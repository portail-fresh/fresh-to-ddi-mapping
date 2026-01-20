import os
import json
import xmltodict
from saxonche import PySaxonProcessor

# XML tags that must always be parsed as lists by xmltodict,
# even if they occur only once in the XML.
FORCE_LIST_TAGS = (
    "extLink",
    "extlink",
    "contact",
    "producer",
    "AuthEnty",
    "fundAg",
    "sources"
)


def execute_xsl_transformation(xml_file, xsl_file):
    """
    Transform an XML file using an XSLT stylesheet with Saxon/C.

    Parameters:
        xml_file (str): Path to the input XML file.
        xsl_file (str): Path to the XSLT stylesheet.

    Returns:
        str: The transformed XML as a string.
    """
    with PySaxonProcessor(license=False) as proc:
        # Create an XSLT 3.0 processor
        xsltproc = proc.new_xslt30_processor()

        # Parse the input XML file into an XDM node
        xml_input = proc.parse_xml(xml_file_name=xml_file)

        # Compile the XSLT stylesheet
        xslt_exec = xsltproc.compile_stylesheet(stylesheet_file=xsl_file)

        # Apply the transformation and return the result as a string
        xml_output = xslt_exec.transform_to_string(xdm_node=xml_input)

    return xml_output


def to_bool_or_same(value):
    """
    Convert string representations of booleans into actual booleans.

    Accepted values (case-insensitive):
        - "true"  -> True
        - "false" -> False

    If the value is not a boolean-like string, it is returned unchanged.

    Parameters:
        value: Any value, typically a string.

    Returns:
        bool or original value
    """
    if isinstance(value, str):
        low = value.strip().lower()
        if low == "true":
            return True
        if low == "false":
            return False
    return value


def normalize_sirene(value: str):
    """
    Normalize SIREN/SIRENE/SIRET identifiers to a single canonical form.

    Any of the following (case-insensitive):
        - "siren"
        - "sirene"
        - "siret"

    will be converted to:
        - "SIREN"

    If the value does not match, it is returned unchanged.

    Parameters:
        value (str): Input string.

    Returns:
        str: Normalized or original value.
    """
    if isinstance(value, str):
        low = value.strip().lower()
        if low in {"siren", "sirene", "siret"}:
            return "SIREN"
    return value


def xml_string_to_json(xml_string):
    """
    Convert an XML string into a JSON-compatible Python dictionary.

    Transformations applied:
        - XML attributes (prefixed with '@') are converted to plain keys.
        - '#text' nodes are renamed to 'value'.
        - Empty XML elements (None) are converted to {} or "" for specific fields.
        - Boolean-like strings are converted to booleans.
        - SIREN/SIRENE/SIRET values are normalized.

    Parameters:
        xml_string (str): XML content as a string.

    Returns:
        dict: Parsed and normalized JSON structure.
    """

    def postprocessor(path, key, value):
        """
        xmltodict postprocessor callback applied to every parsed node.

        Parameters:
            path: XML path (unused but required by xmltodict).
            key (str): XML key name.
            value: Parsed value.

        Returns:
            tuple: (new_key, new_value)
        """

        # Replace '#text' nodes with a clearer 'value' key
        if key == "#text":
            return "value", value

        # Remove '@' prefix from XML attributes
        elif key.startswith("@"):
            return key[1:], value

        # Replace None (empty elements) with {} or empty string
        elif value is None:
            if key in ["email", "PILabo", "frameUnit"]:
                return key, ""
            else:
                return key, {}

        # Apply boolean conversion and SIREN normalization
        value = to_bool_or_same(value)
        value = normalize_sirene(value)

        return key, value

    # Parse XML into a Python dictionary
    parsed_xml = xmltodict.parse(
        xml_string,
        dict_constructor=dict,
        postprocessor=postprocessor,
        force_list=FORCE_LIST_TAGS
    )

    # Extract root element
    rr = parsed_xml["root"]

    # Inject a fixed schema type
    rr["schematype"] = "survey"

    return rr


def filter_extlinks(data):
    """
    Recursively traverse a JSON structure and filter extLink/extlink entries.

    If an extLink list contains both:
        - title = "ROR"
        - title = "SIREN"

    then all "ROR" entries are removed, keeping only "SIREN".

    Parameters:
        data (dict | list): JSON data structure to process.
    """
    if isinstance(data, dict):
        for key, value in data.items():

            # Check for extLink/extlink lists
            if key.lower() == "extlink" and isinstance(value, list):
                titles = {
                    item.get("title")
                    for item in value
                    if isinstance(item, dict)
                }

                # If both ROR and SIREN exist, drop ROR
                if "ROR" in titles and "SIREN" in titles:
                    data[key] = [
                        item for item in value
                        if item.get("title") != "ROR"
                    ]
            else:
                # Recurse into nested structures
                filter_extlinks(value)

    elif isinstance(data, list):
        for item in data:
            filter_extlinks(item)


def transform_authenty_in_docdscr(json_data):
    """
    Normalize the AuthEnty field inside docDscr/citation/rspStmt.

    If AuthEnty is a list:
        - Take the first element
        - Replace ';' with spaces
        - Store it back as a single string

    Parameters:
        json_data (dict): Parsed JSON data.
    """
    docDscr = json_data.get("docDscr")
    if not isinstance(docDscr, dict):
        return

    citation = docDscr.get("citation")
    if not isinstance(citation, dict):
        return

    rspStmt = citation.get("rspStmt")
    if not isinstance(rspStmt, dict):
        return

    auth = rspStmt.get("AuthEnty")
    if isinstance(auth, list):
        if len(auth) > 0:
            item = auth[0]
            if isinstance(item, str):
                rspStmt["AuthEnty"] = ' '.join(item.split(';'))
            else:
                rspStmt["AuthEnty"] = ''


def process_xml_folder(input_folder, xsl_file, intermediate_folder, output_json_folder):
    """
    Process all XML files in a folder:
        1. Apply XSLT transformation
        2. Save transformed XML to an intermediate folder
        3. Convert transformed XML to JSON
        4. Apply post-processing rules
        5. Save final JSON files

    Parameters:
        input_folder (str): Folder containing input XML files.
        xsl_file (str): Path to the XSLT stylesheet.
        intermediate_folder (str): Folder to store transformed XML files.
        output_json_folder (str): Folder to store final JSON files.
    """
    os.makedirs(intermediate_folder, exist_ok=True)
    os.makedirs(output_json_folder, exist_ok=True)

    print(len(os.listdir(input_folder)))

    for filename in os.listdir(input_folder):

        # Process only XML files
        if filename.lower().endswith(".xml"):
            xml_path = os.path.join(input_folder, filename)

            # Apply XSLT transformation
            transformed_xml = execute_xsl_transformation(xml_path, xsl_file)

            # Save transformed XML
            intermediate_path = os.path.join(intermediate_folder, filename)
            with open(intermediate_path, "w", encoding="utf-8") as f:
                f.write(transformed_xml)

            # Convert XML to JSON
            json_data = xml_string_to_json(transformed_xml)

            # Apply domain-specific cleanups
            filter_extlinks(json_data)
            transform_authenty_in_docdscr(json_data)

            # Save JSON output
            json_filename = os.path.splitext(filename)[0] + ".json"
            json_path = os.path.join(output_json_folder, json_filename)
            with open(json_path, "w", encoding="utf-8") as f:
                json.dump(json_data, f, ensure_ascii=False, indent=2)

    print("Transformation completed! JSON files saved in:", output_json_folder)


# Folder configuration
input_folder = "input-files"
intermediate_folder = "xml-transformed"
output_json_folder = "output-files"
xsl_file = "mapping-for-impact/main.xsl"

# Execute the full processing pipeline
process_xml_folder(
    input_folder,
    xsl_file,
    intermediate_folder,
    output_json_folder
)
