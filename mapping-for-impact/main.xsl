<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Import delle sezioni -->
  <xsl:import href="metadonnees_techniques.xsl"/>

  <!-- aggiungeremo: <xsl:import href="titles.xsl"/> ecc. -->

  <!-- Entry point -->
  <xsl:template match="/">
    <root>
      <xsl:apply-templates select="FichePortailEpidemiologieFrance"/>
    </root>
  </xsl:template>

</xsl:stylesheet>
