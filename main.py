import os
import json
import xmltodict
from saxonche import PySaxonProcessor

FORCE_LIST_TAGS=("extLink", "extlink", "contact", "producer","AuthEnty","fundAg","sources")

def execute_xsl_transformation(xml_file, xsl_file):
    """Trasforma un file XML usando un XSLT con Saxon/C."""
    with PySaxonProcessor(license=False) as proc:
        xsltproc = proc.new_xslt30_processor()
        xml_input = proc.parse_xml(xml_file_name=xml_file)
        xslt_exec = xsltproc.compile_stylesheet(stylesheet_file=xsl_file)
        xml_output = xslt_exec.transform_to_string(xdm_node=xml_input)
    return xml_output

def to_bool_or_same(value):
    """
    Converte stringhe tipo 'true', 'True', 'FALSE', ecc. in booleani.
    Se la stringa non rappresenta un booleano, restituisce il valore originale.
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
    Converte SIREN, SIRENE, SIRET (in qualsiasi maiuscolo/minuscolo) in 'SIRENE'.
    Se non corrisponde, restituisce il valore originale.
    """
    if isinstance(value, str):
        low = value.strip().lower()
        if low in {"siren", "sirene", "siret"}:
            return "SIRENE"
    return value

def xml_string_to_json(xml_string):
    """Converte XML in JSON rimuovendo '@' dagli attributi e sostituendo '#text' con 'value'.
       Se un elemento è vuoto, restituisce {} invece di null.
    """
    def postprocessor(path, key, value):
        # Trasforma #text in 'value'
        if key == "#text":
            return "value", value
        # Rimuove '@' dagli attributi
        elif key.startswith("@"):
            return key[1:], value
        # Sostituisce None (elemento vuoto) con {}
        elif value is None:
            if key in ["email", "PILabo","frameUnit"]:
                return key, ""
            else:
                return key, {}
        value=to_bool_or_same(value)
        value=normalize_sirene(value)
        return key, value

    parsed_xml = xmltodict.parse(
        xml_string,
        dict_constructor=dict,
        postprocessor=postprocessor,
        force_list=FORCE_LIST_TAGS
    )

    rr = parsed_xml["root"]
    rr["schematype"] = "survey"
    return rr

def filter_extlinks(data):
    if isinstance(data, dict):
        for key, value in data.items():
            # Se troviamo una lista di extlink/extLink
            if key.lower() == "extlink" and isinstance(value, list):
                titles = {item.get("title") for item in value if isinstance(item, dict)}
                # Se ci sono sia ROR che SIRENE, teniamo solo SIRENE
                if "ROR" in titles and "SIRENE" in titles:
                    data[key] = [item for item in value if item.get("title") != "ROR"]
            else:
                # Ricorsione sui valori
                filter_extlinks(value)
    elif isinstance(data, list):
        for item in data:
            filter_extlinks(item)

def transform_authenty_in_docdscr(json_data):
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
        # Uniamo gli elementi della lista in una stringa, sostituendo ';' con spazio
        if len(auth)>0:
            item=auth[0]
            if isinstance(item, str):
                rspStmt["AuthEnty"] = ' '.join(item.split(';'))
            else:
                 rspStmt["AuthEnty"] = ''
        
def process_xml_folder(input_folder, xsl_file, intermediate_folder, output_json_folder):
    """Trasforma tutti i file XML di una cartella tramite XSLT e li converte in JSON."""
    os.makedirs(intermediate_folder, exist_ok=True)
    os.makedirs(output_json_folder, exist_ok=True)

    print(len(os.listdir(input_folder)))
    for filename in os.listdir(input_folder):
        
        if filename.lower().endswith(".xml"):
            xml_path = os.path.join(input_folder, filename)
            # Applica XSLT e salva in cartella intermedia
            transformed_xml = execute_xsl_transformation(xml_path, xsl_file)
            intermediate_path = os.path.join(intermediate_folder, filename)
            with open(intermediate_path, "w", encoding="utf-8") as f:
                f.write(transformed_xml)

            # Converte XML trasformato in JSON e salva
            json_data = xml_string_to_json(transformed_xml)
            filter_extlinks(json_data)
            transform_authenty_in_docdscr(json_data)
            json_filename = os.path.splitext(filename)[0] + ".json"
            json_path = os.path.join(output_json_folder, json_filename)
            with open(json_path, "w", encoding="utf-8") as f:
                json.dump(json_data, f, ensure_ascii=False, indent=2)

    print("Trasformazione completata! JSON salvati in:", output_json_folder)
    

input_folder = "input-files"
intermediate_folder = "xml-transformed"
output_json_folder = "output-files"
xsl_file = "mapping-for-impact/main.xsl"

process_xml_folder(input_folder, xsl_file, intermediate_folder, output_json_folder)