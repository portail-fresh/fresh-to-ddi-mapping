<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fresh="urn:fresh-enrichment:v1"
  exclude-result-prefixes="fresh">

  <!-- ======================
       Template principale
       ====================== -->
  <xsl:template match="FichePortailEpidemiologieFrance">

    <!-- stdyDscr -->
    <stdyDscr>
      <citation>
        <titlStmt>
          <!-- ID -->
          <xsl:apply-templates select="Metadonnees/ID" />
          <xsl:apply-templates select="Metadonnees/fresh:ID" />
          <!-- Titoli e acronimi -->
          <xsl:apply-templates select="General/Identification/NomFR" />
          <xsl:apply-templates select="General/Identification/NomEN" />
          <xsl:apply-templates select="General/Identification/AcronymeFR" />
          <xsl:apply-templates select="General/Identification/AcronymeEN" />
        </titlStmt>
        <rspStmt>
          <xsl:apply-templates select="//fresh:PrimaryInvestigator" />
          <xsl:apply-templates
            select="//AutresCollaborationsFR |
                    //AutresCollaborationsEN |
                    //PartenariatsEtReseauxPrecisionsFR |
                    //PartenariatsEtReseauxPrecisionsEN" />
        </rspStmt>
        <distStmt>
          <xsl:apply-templates select="//fresh:ContactPoint" />
        </distStmt>

        <prodStmt>
          <xsl:apply-templates select="//fresh:FundingAgent" />
          <xsl:apply-templates select="//fresh:Sponsor" />


        </prodStmt>
      </citation>

      <xsl:apply-templates
        select="fresh:AuthorizingAgencyFR | Metadonnees/fresh:AuthorizingAgencyEN" />
      <method>
        <xsl:apply-templates select="//fresh:ResearchTypeFR | //fresh:ResearchTypeEN" mode="append" />
        <xsl:apply-templates select="//TypeEnqueteFR | //TypeEnqueteEN" />
        <!-- Applica template a EnActiviteFR e EnActiviteEN -->
        <xsl:apply-templates select="//EnActiviteFR | //EnActiviteEN" />
        <dataColl>
          <xsl:apply-templates select="//TailleBaseFR | //TailleBaseEN"></xsl:apply-templates>
          <xsl:apply-templates select="//RecruitmentTimingFR | //RecruitmentTimingEN" />
          <sampleFrame>
            <frameUnit>
              <xsl:apply-templates
                select="//RecrutementParIntermediaireFR | //RecrutementParIntermediaireEN" />
            </frameUnit>
          </sampleFrame>
          <sources>
            <xsl:apply-templates select="//fresh:ThirdPartySource" />
          </sources>

          <xsl:apply-templates select="//fresh:CollectionModeFR | //fresh:CollectionModeEN" />
          <xsl:apply-templates select="//fresh:SamplingModeFR | //fresh:SamplingModeEN" />
          <xsl:apply-templates select="//TailleBaseDetailFR | //TailleBaseDetailEN" />
        </dataColl>

        <xsl:apply-templates
          select="//SuiviDesParticipantsModalitesFR | //SuiviDesParticipantsModalitesEN" />

      </method>
      <stdyInfo>   <!-- Applica template agli abstract FR e EN -->
        <xsl:apply-templates
          select="//ObjectifGeneralFR | //ObjectifGeneralEN" />
        <subject>
          <xsl:apply-templates
            select="//DomainesDePathologiesFR | //DomainesDePathologiesEN" />
          <xsl:apply-templates select="//fresh:Pathology" />
          <xsl:apply-templates select="//DeterminantsDeSanteFR | //DeterminantsDeSanteEN" />
          <xsl:apply-templates select="//MotsClesFR | //MotsClesEN" />

        </subject>
        <qualityStatement>
          <standardsCompliance>
            <xsl:apply-templates select="//NomenclatureFR | //NomenclatureEN" />
          </standardsCompliance>
          <xsl:apply-templates
            select="//ProcedureQualiteFR |
                             //ProcedureQualiteEN" />
        </qualityStatement>
        <sumDscr>
          <xsl:apply-templates select="//TypeDonneesRecueilliesFR | //TypeDonneesRecueilliesEN" />
          <anlyUnit lang="fr">Individus</anlyUnit>
          <anlyUnit lang="en">Individuals</anlyUnit>
          <xsl:apply-templates select="//fresh:InclusionCriterionFR | //fresh:InclusionCriterionEN" />
          <xsl:apply-templates select="fresh:ExclusionCriterionFR | fresh:ExclusionCriterionEN" />
          <xsl:apply-templates select="//fresh:NationFR | //fresh:NationEN" />
          <xsl:if test="not(//fresh:NationFR) and not(//fresh:NationEN)">
            <nation lang="fr" abbr="fr"> France <concept>
                <vocab>ISO</vocab>
                <vocabURI>fr</vocabURI>
              </concept>
            </nation>
            <nation lang="en" abbr="fr"> France <concept>
                <vocab>ISO</vocab>
                <vocabURI>fr</vocabURI>
              </concept>
            </nation>
          </xsl:if>
          <xsl:apply-templates select="//RegionsConcerneesFR" />
          <xsl:apply-templates select="//SexeFR | //SexeEN" />
          <xsl:apply-templates select="//TranchesAgeFR | //TranchesAgeEN" />
          <xsl:apply-templates select="//PopulationFR | //PopulationEN" />
          <xsl:apply-templates select="//AnneePremierRecueilFR  " />
          <xsl:apply-templates select="//AnneeDernierRecueilFR " />

        </sumDscr>
      </stdyInfo>
      <dataAccs>
        <setAvail>
          <xsl:apply-templates
            select="//fresh:IndividualDataAccessFR | //fresh:IndividualDataAccessEN" />

          <xsl:apply-templates
            select="
                //fresh:AccessConditionsFR | 
                //fresh:AccessConditionsEN" />
          <xsl:apply-templates
            select="//fresh:AdditionalDataAccessLinkFR | //fresh:AdditionalDataAccessLinkEN" />
          <xsl:apply-templates
            select="//fresh:DataFileCompletenessFR | //fresh:DataFileCompletenessEN" />

          <xsl:apply-templates select="//fresh:DataLocationFR | //fresh:DataLocationEN" />

        </setAvail>
        <useStmt>
          <xsl:apply-templates select="//fresh:AccessRestrictionsFR | //fresh:AccessRestrictionsEN" />
          <xsl:apply-templates
            select="//fresh:DataAccessRequestToolAvailableFR | //fresh:DataAccessRequestToolAvailableEN" />
          <xsl:apply-templates
            select="//fresh:DataAccessRequestToolLocationFR | //fresh:DataAccessRequestToolLocationEN" />
          <xsl:apply-templates
            select="//fresh:DataCitationRequirementFR | //fresh:DataCitationRequirementEN" />
          <xsl:apply-templates
            select="//fresh:DataCitationStatementFR | //fresh:DataCitationStatementEN" />
          <xsl:apply-templates
            select="//fresh:DataInformationContactFR | //fresh:DataInformationContactEN" />
          <xsl:apply-templates
            select="//fresh:NonDisclosureAgreementFR | //fresh:NonDisclosureAgreementEN" />


        </useStmt>
      </dataAccs>
      <othStdMat>
        <xsl:apply-templates select="//AccesDonneesAgregeesFR | //AccesDonneesAgregeesEN" />
      </othStdMat>
      <studyDevelopment>
        <xsl:apply-templates select="//ParametreDeSanteFR | //ParametreDeSanteEN" />
        <xsl:apply-templates select="//AutreParametreObserveFR | //AutreParametreObserveEN" />

      </studyDevelopment>
    </stdyDscr>

    <!-- docDscr: MetadataContributorName -->
    <docDscr>
      <citation>
        <rspStmt>
          <AuthEnty>
            <xsl:apply-templates select="fresh:MetadataContributorName" />
          </AuthEnty>
        </rspStmt>
        <prodStmt>
          <producer>
            <!-- Creazione dell'attributo affiliation corretta -->
            <xsl:attribute name="affiliation">
              <xsl:apply-templates select="fresh:MetadataContributorAffiliation" />
            </xsl:attribute>

            <!-- Applicazione dei templates ai nomi dei contributori -->
            <xsl:apply-templates select="fresh:MetadataContributorName" />
          </producer>

          <!-- Applicazione dei templates alla provenienza -->
          <xsl:apply-templates select="fresh:Provenance" />
        </prodStmt>
      </citation>
    </docDscr>


    <!-- additional: tutti i campi non DDI -->
    <additional>
      <xsl:apply-templates select="fresh:Provenance" />
      <xsl:apply-templates select="//RelatedDocument" />
      <!-- CreationDate e LastUpdatedManual -->
      <xsl:call-template name="creationDate" />
      <xsl:call-template name="lastUpdatedManual" />

      <fundingAgent>
        <xsl:apply-templates select="//fresh:FundingAgentTypeFR | //fresh:FundingAgentTypeEN" />
      </fundingAgent>


      <theme>
        <xsl:apply-templates select="//fresh:RareDiseasesFR" />
      </theme>

      <governance>
        <xsl:apply-templates select="//ExistenceDeComiteFR" />
      </governance>
      <collaborations>
        <xsl:apply-templates select="//PartenariatEtReseauxFR" />
      </collaborations>

      <mockSample>
        <xsl:apply-templates select="//fresh:MockSampleAvailableFR | //fresh:MockSampleAvailableEN" />
        <xsl:apply-templates select="//fresh:MockSampleLocationFR | //fresh:MockSampleLocationEN" />
      </mockSample>
      <dataQuality>
        <xsl:apply-templates select="//fresh:OtherDocumentationFR | //fresh:OtherDocumentationEN" />
      </dataQuality>
      <variableDictionnary>
        <xsl:apply-templates select="//ExistenceDocumentCodageFR | //ExistenceDocumentCodageEN" />
      </variableDictionnary>
      <dataTypes>

        <xsl:apply-templates
          select="//DonneesCliniquesPrecisionsFR | //DonneesCliniquesPrecisionsEN" />
        <xsl:apply-templates
          select="//DonneesBiologiquesPrecisionsFR | //DonneesBiologiquesPrecisionsEN" />
        <xsl:apply-templates select="//BiothequeFR" />
        <xsl:apply-templates select="//ContenuBiothequeFR | //ContenuBiothequeEN" />


      </dataTypes>
      <collectionProcess>
        <xsl:apply-templates select="//ModalitesDeRecueilFR | //ModalitesDeRecueilEN" />
      </collectionProcess>
      <geographicalCoverage>
        <xsl:apply-templates
          select="//ChampGeographiquePrecisionsFR | //ChampGeographiquePrecisionsEN" />
      </geographicalCoverage>

      <activeFollowUp>
        <xsl:apply-templates select="//SuiviDesParticipantsFR" />
      </activeFollowUp>

      <dataCollectionIntegration>
        <xsl:apply-templates select="//fresh:IsDataIntegration" />
      </dataCollectionIntegration>


    </additional>

  </xsl:template>

  <!-- ======================
       Trasformazioni generiche
       ====================== -->

  <!-- ID → IDNo con default PEF -->
  <xsl:template match="ID | fresh:ID">
    <IDNo>
      <xsl:attribute name="agency">
        <xsl:choose>
          <xsl:when test="@agency">
            <xsl:value-of select="@agency" />
          </xsl:when>
          <xsl:otherwise>PEF</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:value-of select="normalize-space(.)" />
    </IDNo>
  </xsl:template>

  <!-- MetadataContributorName → AuthEnty -->
  <xsl:template name="creationDate">
    <!-- Lettura date -->
    <xsl:variable name="dateFR" select="normalize-space(Metadonnees/DateCreationFicheFR)" />
    <xsl:variable name="dateEN" select="normalize-space(Metadonnees/DateCreationFicheEN)" />

    <!-- Converti dd/MM/yyyy → yyyy-MM-dd -->
    <xsl:variable name="dateFR_iso"
      select="concat(substring($dateFR,7,4),'-',substring($dateFR,4,2),'-',substring($dateFR,1,2))" />
    <xsl:variable name="dateEN_iso"
      select="concat(substring($dateEN,7,4),'-',substring($dateEN,4,2),'-',substring($dateEN,1,2))" />

    <!-- Prendi la data più vecchia -->
    <xsl:variable name="minDate_iso" select="min(($dateFR_iso, $dateEN_iso))" />

    <!-- Riconversione yyyy-MM-dd → dd-MM-yyyy -->
    <xsl:variable name="minDate_out"
      select="concat(substring($minDate_iso,9,2),'-',substring($minDate_iso,6,2),'-',substring($minDate_iso,1,4))" />

    <creationDate>
      <xsl:value-of select="$minDate_out" />
    </creationDate>
  </xsl:template>

  <xsl:template name="lastUpdatedManual">
    <!-- Lettura date -->
    <xsl:variable name="dateFR" select="normalize-space(Metadonnees/DateChangementStatutFicheFR)" />
    <xsl:variable name="dateEN" select="normalize-space(Metadonnees/DateChangementStatutFicheEN)" />

    <!-- Converti dd/MM/yyyy → yyyy-MM-dd -->
    <xsl:variable name="dateFR_iso"
      select="concat(substring($dateFR,7,4),'-',substring($dateFR,4,2),'-',substring($dateFR,1,2))" />
    <xsl:variable name="dateEN_iso"
      select="concat(substring($dateEN,7,4),'-',substring($dateEN,4,2),'-',substring($dateEN,1,2))" />

    <!-- Prendi la data più recente -->
    <xsl:variable name="maxDate_iso" select="max(($dateFR_iso, $dateEN_iso))" />

    <!-- Riconversione yyyy-MM-dd → dd-MM-yyyy -->
    <xsl:variable name="maxDate_out"
      select="concat(substring($maxDate_iso,9,2),'-',substring($maxDate_iso,6,2),'-',substring($maxDate_iso,1,4))" />

    <lastUpdatedManual>
      <xsl:value-of select="$maxDate_out" />
    </lastUpdatedManual>
  </xsl:template>


  <!-- Campi non DDI (additional) -->
  <xsl:template match="fresh:Provenance">
    <prodPlac>
      <xsl:value-of select="normalize-space(.)" />
    </prodPlac>
  </xsl:template>

  <!-- Titoli -->
  <xsl:template match="NomFR">
    <titl lang="fr">
      <xsl:value-of select="normalize-space(.)" />
    </titl>
  </xsl:template>

  <xsl:template match="NomEN">
    <titl lang="en">
      <xsl:value-of select="normalize-space(.)" />
    </titl>
  </xsl:template>

  <!-- Acronimi -->
  <xsl:template match="AcronymeFR">
    <altTitl lang="fr">
      <xsl:value-of select="normalize-space(.)" />
    </altTitl>
  </xsl:template>

  <xsl:template match="AcronymeEN">
    <altTitl lang="en">
      <xsl:value-of select="normalize-space(.)" />
    </altTitl>
  </xsl:template>

  <!-- AuthorizingAgency FR/EN → studyAuthorization/authorizingAgency -->
  <xsl:template match="fresh:AuthorizingAgencyFR | fresh:AuthorizingAgencyEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:AuthorizingAgencyFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <studyAuthorization>
      <authorizingAgency lang="{$lang}">
        <xsl:value-of select="normalize-space(.)" />
      </authorizingAgency>
    </studyAuthorization>
  </xsl:template>


  <!-- FinancementsPrecisions FR/EN → prodStmt/fundAg -->
  <xsl:template match="fresh:FundingAgent">
    <!-- FundAg FR -->
    <fundAg>
      <name lang="fr">
        <xsl:value-of select="normalize-space(fresh:FundingAgentName)" />
      </name>
      <name lang="en">
        <xsl:value-of select="normalize-space(fresh:FundingAgentName)" />
      </name>
      <!-- <type lang="fr">
        <xsl:value-of select="normalize-space(fresh:FundingAgentTypeFR)" />
      </type>
      <type lang="en">
        <xsl:value-of select="normalize-space(fresh:FundingAgentTypeEN)" />
      </type> -->
      <xsl:for-each select="fresh:FundingAgentPID">
        <extLink>
          <title>
            <xsl:value-of select="normalize-space(fresh:PIDSchema)" />
          </title>
          <uri>
            <xsl:value-of select="normalize-space(fresh:URL)" />
          </uri>
        </extLink>
      </xsl:for-each>
    </fundAg>
  </xsl:template>

  <!-- FundingAgentType FR/EN → fundingAgentType -->
  <xsl:template match="fresh:FundingAgentTypeFR | fresh:FundingAgentTypeEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:FundingAgentTypeFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <fundingAgentType lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </fundingAgentType>
  </xsl:template>

  <!-- PrimaryInvestigator → AuthEnty con più ExtLink -->
  <xsl:template match="fresh:PrimaryInvestigator">
    <AuthEnty>
      <name>
        <xsl:value-of select="normalize-space(fresh:PIName)" />
      </name>

      <affiliation lang="fr">
        <xsl:value-of select="normalize-space(fresh:Affiliation)" />
      </affiliation>
      <affiliation lang="en">
        <xsl:value-of select="normalize-space(fresh:Affiliation)" />
      </affiliation>

      <!-- Ciclo su tutti i PID -->
      <xsl:for-each select="fresh:PiID">
        <extLink>
          <uri>
            <xsl:value-of select="normalize-space(fresh:URI)" />
          </uri>
          <role>pi id</role>
          <title>
            <xsl:value-of select="normalize-space(fresh:PIDSchema)" />
          </title>
        </extLink>
      </xsl:for-each>

      <xsl:for-each select="fresh:OrganisationID">
        <extLink>
          <uri>
            <xsl:value-of select="normalize-space(fresh:URI)" />
          </uri>
          <role>organisation id</role>
          <title>
            <xsl:value-of select="normalize-space(fresh:PIDSchema)" />
          </title>
        </extLink>
      </xsl:for-each>

      <xsl:for-each select="fresh:LaboID">
        <extLink>
          <uri>
            <xsl:value-of select="normalize-space(fresh:URI)" />
          </uri>
          <role>labo id</role>
          <title>
            <xsl:value-of select="normalize-space(fresh:PIDSchema)" />
          </title>
        </extLink>
      </xsl:for-each>

      <isContact>
        <xsl:choose>
          <xsl:when test="string(normalize-space(fresh:isContact))">
            <xsl:value-of select="normalize-space(fresh:isContact)" />
          </xsl:when>
          <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
      </isContact>
      <email>
        <xsl:choose>
          <xsl:when test="fresh:mail">
            <xsl:value-of select="normalize-space(fresh:mail)" />
          </xsl:when>
          <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
      </email>

      <PILabo>
        <xsl:choose>
          <xsl:when test="fresh:PILabo">
            <xsl:value-of select="normalize-space(fresh:PILabo)" />
          </xsl:when>
          <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
      </PILabo>
    </AuthEnty>
  </xsl:template>

  <!-- ContactPoint → distStmt/contact + contact:email -->
  <xsl:template match="fresh:ContactPoint">

    <contact>
      <name>
        <xsl:value-of select="normalize-space(fresh:ContactName)" />
      </name>

      <email>
        <xsl:value-of select="normalize-space(fresh:EMail)" />
      </email>

      <affiliation lang="fr">
        <xsl:value-of select="normalize-space(fresh:Affiliation)" />
      </affiliation>
      <affiliation lang="en">
        <xsl:value-of select="normalize-space(fresh:Affiliation)" />
      </affiliation>

      <xsl:for-each select="fresh:OrganisationID">
        <extLink>
          <uri>
            <xsl:value-of select="normalize-space(fresh:URI)" />
          </uri>
          <role>organisation id</role>
          <title>
            <xsl:value-of select="normalize-space(fresh:PIDSchema)" />
          </title>
        </extLink>
      </xsl:for-each>
    </contact>

  </xsl:template>

  <!-- Sponsor → prodStmt/producer con ExtLink -->
  <xsl:template match="fresh:Sponsor">
    <producer>
      <name lang="fr">
        <xsl:value-of select="normalize-space(fresh:SponsorName)" />
      </name>
      <name lang="en">
        <xsl:value-of select="normalize-space(fresh:SponsorName)" />
      </name>
      <xsl:apply-templates select="fresh:SponsorTypeFR | fresh:SponsorTypeEN" />
      <!-- Ciclo sugli eventuali PID -->
      <xsl:for-each select="fresh:SponsorPID">
        <extLink>
          <title>
            <xsl:value-of select="normalize-space(fresh:PIDSchema)" />
          </title>
          <uri>
            <xsl:value-of select="normalize-space(fresh:URL)" />
          </uri>
        </extLink>
      </xsl:for-each>
    </producer>
  </xsl:template>

  <!-- SponsorType → sponsorType multilingue dentro producer -->
  <xsl:template match="fresh:SponsorTypeFR | fresh:SponsorTypeEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="local-name() = 'SponsorTypeFR'">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <sponsorType lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </sponsorType>
  </xsl:template>


  <!-- ExistenceDeComite → committee boolean -->
  <xsl:template match="ExistenceDeComiteFR">
    <committee>
      <xsl:choose>
        <xsl:when test="lower-case(normalize-space(.)) = 'oui'">true</xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
      </xsl:choose>
    </committee>
  </xsl:template>

  <xsl:template match="PartenariatsEtReseauxFR">
    <networkConsortium>
      <xsl:choose>
        <xsl:when test="lower-case(normalize-space(.)) = 'oui'">true</xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
      </xsl:choose>
    </networkConsortium>
  </xsl:template>

  <!-- AutresCollaborations e PartenariatsEtReseauxPrecisions → othId (type="collaboration") -->
  <xsl:template
    match="
  AutresCollaborationsFR |
  AutresCollaborationsEN |
  PartenariatsEtReseauxPrecisionsFR |
  PartenariatsEtReseauxPrecisionsEN">
    <othId type="collaboration">

      <affiliation>
        <xsl:attribute name="lang">
          <xsl:choose>
            <xsl:when test="contains(local-name(), 'FR')">fr</xsl:when>
            <xsl:otherwise>en</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="normalize-space(.)" />
      </affiliation>

    </othId>
  </xsl:template>


  <!-- EnActivite → stdyDscr/method/stdyClas -->
  <xsl:template match="EnActiviteFR | EnActiviteEN">
    <stdyClas>
      <xsl:attribute name="lang">
        <xsl:choose>
          <xsl:when test="local-name()='EnActiviteFR'">fr</xsl:when>
          <xsl:otherwise>en</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:value-of select="normalize-space(.)" />
    </stdyClas>
  </xsl:template>

  <xsl:template match="RelatedDocument">
    <relatedDocuments>
      <documentTitle lang="fr">
        <xsl:value-of select="normalize-space(DocumentTitle)" />
      </documentTitle>
      <documentLink lang="fr">
        <xsl:value-of select="normalize-space(DocumentLink)" />
      </documentLink>
      <documentTitle lang="en">
        <xsl:value-of select="normalize-space(DocumentTitle)" />
      </documentTitle>
      <documentLink lang="en">
        <xsl:value-of select="normalize-space(DocumentLink)" />
      </documentLink>

    </relatedDocuments>
  </xsl:template>

  <!-- ObjectifGeneral → stdyDscr/stdyInfo/abstract (contentType=purpose) -->
  <xsl:template match="ObjectifGeneralFR | ObjectifGeneralEN">
    <abstract>
      <xsl:attribute name="contentType">purpose</xsl:attribute>
      <xsl:attribute name="lang">
        <xsl:choose>
          <xsl:when test="local-name()='ObjectifGeneralFR'">fr</xsl:when>
          <xsl:otherwise>en</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:value-of select="normalize-space(.)" />
    </abstract>
  </xsl:template>

  <!-- DomainesDePathologies → stdyDscr/stdyInfo/subject/topcClas -->
  <xsl:template match="DomainesDePathologiesFR | DomainesDePathologiesEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="local-name()='DomainesDePathologiesFR'">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:for-each select="value">
      <topcClas>
        <xsl:attribute name="vocab">health theme</xsl:attribute>
        <xsl:attribute name="lang">
          <xsl:value-of select="$lang" />
        </xsl:attribute>
        <xsl:value-of select="normalize-space(.)" />
        <xsl:for-each select="concept">
          <extLink>
            <title>
              <xsl:value-of select="normalize-space(@vocab)" />
            </title>
            <uri>
              <xsl:value-of select="normalize-space(@uri)" />
            </uri>
          </extLink>
        </xsl:for-each>
      </topcClas>
    </xsl:for-each>
  </xsl:template>


  <!-- fresh:Pathology → stdyDscr/stdyInfo/subject/topcClas con ExtLink@uri -->
  <xsl:template match="fresh:Pathology">
    <topcClas vocab="cim-11" lang="fr">
      <xsl:value-of select="normalize-space(@fr)" />
      <extLink uri="{normalize-space(.)}" title="CIM-11" />
    </topcClas>
    <topcClas vocab="cim-11" lang="en">
      <xsl:value-of select="normalize-space(@en)" />
      <extLink uri="{normalize-space(.)}" title="CIM-11" />
    </topcClas>
  </xsl:template>

  <!-- MotsClesFR/EN → stdyDscr/stdyInfo/subject/keyword -->
  <xsl:template match="MotsClesFR | MotsClesEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::MotsClesFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:for-each select="value">
      <keyword lang="{$lang}">
        <xsl:value-of select="normalize-space(.)" />
      </keyword>
    </xsl:for-each>
  </xsl:template>


  <!-- DeterminantsDeSanteFR/EN → stdyDscr/stdyInfo/subject/topcClas (vocab="health determinant") -->
  <xsl:template match="DeterminantsDeSanteFR | DeterminantsDeSanteEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::DeterminantsDeSanteFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:for-each select="value">
      <topcClas vocab="health determinant" lang="{$lang}">
        <xsl:value-of select="normalize-space(.)" />
      </topcClas>
    </xsl:for-each>
  </xsl:template>

  <!-- fresh:RareDiseases → stdyDscr/stdyInfo/subject/rareDiseases -->
  <xsl:template match="fresh:RareDiseasesFR">
    <RareDiseases>
      <xsl:value-of select="normalize-space(.)" />
    </RareDiseases>
  </xsl:template>

  <!-- TailleBaseFR/EN → stdyDscr/method/dataColl/targetSampleSize -->
  <xsl:template match="TailleBaseFR | TailleBaseEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::TailleBaseFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <targetSampleSize lang="{$lang}">
      <xsl:value-of select="normalize-space(value)" />
    </targetSampleSize>
  </xsl:template>


  <!-- TailleBaseDetailFR/EN → stdyDscr/method/respRate -->
  <xsl:template match="TailleBaseDetailFR | TailleBaseDetailEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::TailleBaseDetailFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <respRate lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </respRate>
  </xsl:template>

  <!-- NomenclatureFR/EN →
  stdyDscr/stdyInfo/qualityStatement/standardsCompliance/standard/standardName -->
  <xsl:template match="NomenclatureFR | NomenclatureEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::NomenclatureFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <standard>
      <standardName lang="{$lang}">
        <xsl:value-of select="normalize-space(.)" />
      </standardName>
    </standard>

  </xsl:template>

  <!-- ProcedureQualiteFR/EN → stdyDscr/stdyInfo/qualityStatement/otherQualityStatement -->
  <xsl:template match="ProcedureQualiteFR | ProcedureQualiteEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::ProcedureQualiteFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <otherQualityStatement lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </otherQualityStatement>

  </xsl:template>

  <xsl:template match="fresh:AccessConditionsFR | fresh:AccessConditionsEN">
    <conditions lang="fr">
      <xsl:value-of select="normalize-space(../fresh:AccessConditionsFR)" />
    </conditions>
    <conditions lang="en">
      <xsl:value-of select="normalize-space(../fresh:AccessConditionsEN)" />
    </conditions>

  </xsl:template>

  <!-- AccessRestrictionsFR/EN → stdyDscr/dataAccs/useStmt/restrctn -->
  <xsl:template match="fresh:AccessRestrictionsFR | fresh:AccessRestrictionsEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:AccessRestrictionsFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <restrctn lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </restrctn>
  </xsl:template>

  <!-- AdditionalDataAccessLinkFR/EN → stdyDscr/dataAccs/setAvail/notes -->
  <xsl:template match="fresh:AdditionalDataAccessLinkFR | fresh:AdditionalDataAccessLinkEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:AdditionalDataAccessLinkFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <notes lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </notes>
  </xsl:template>


  <!-- IndividualDataAccessFR/EN → stdyDscr/dataAccs/setAvail/avlStatus -->
  <xsl:template match="fresh:IndividualDataAccessFR | fresh:IndividualDataAccessEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:IndividualDataAccessFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <avlStatus lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
      <xsl:if test="@uri and normalize-space(@uri) != ''">
        <extLink>
          <title>
            <xsl:value-of select="normalize-space(@vocab)" />
          </title>
          <uri>
            <xsl:value-of select="normalize-space(@uri)" />
          </uri>
        </extLink>
      </xsl:if>

    </avlStatus>
  </xsl:template>

  <!-- DataAccessRequestToolAvailableFR/EN → stdyDscr/dataAccs/useStmt/specPerm -->
  <xsl:template
    match="fresh:DataAccessRequestToolAvailableFR | fresh:DataAccessRequestToolAvailableEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:DataAccessRequestToolAvailableFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <specPerm lang="{$lang}" required="yes">
      <xsl:value-of select="normalize-space(.)" />
    </specPerm>
  </xsl:template>

  <!-- DataAccessRequestToolLocationFR/EN → stdyDscr/dataAccs/useStmt/specPerm -->
  <xsl:template
    match="fresh:DataAccessRequestToolLocationFR | fresh:DataAccessRequestToolLocationEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:DataAccessRequestToolLocationFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <specPerm lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </specPerm>
  </xsl:template>

  <!-- DataCitationRequirementFR/EN → stdyDscr/dataAccs/useStmt/deposReq -->
  <xsl:template match="fresh:DataCitationRequirementFR | fresh:DataCitationRequirementEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:DataCitationRequirementFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <deposReq lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </deposReq>
  </xsl:template>

  <xsl:template match="fresh:MetadataContributorName">

    <xsl:value-of select="normalize-space(.)" />

  </xsl:template>

  <xsl:template match="fresh:MetadataContributorAffiliation">

    <xsl:value-of select="normalize-space(.)" />

  </xsl:template>

  <!-- DataCitationStatementFR/EN → stdyDscr/dataAccs/useStmt/citReq -->
  <xsl:template match="fresh:DataCitationStatementFR | fresh:DataCitationStatementEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:DataCitationStatementFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <citReq lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </citReq>
  </xsl:template>


  <!-- DataFileCompletenessFR/EN → stdyDscr/dataAccs/setAvail/complete -->
  <xsl:template match="fresh:DataFileCompletenessFR | fresh:DataFileCompletenessEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:DataFileCompletenessFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <complete lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </complete>
  </xsl:template>


  <!-- DataInformationContactFR/EN → stdyDscr/dataAccs/useStmt/contact -->
  <xsl:template match="fresh:DataInformationContactFR | fresh:DataInformationContactEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:DataInformationContactFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <contact lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </contact>
  </xsl:template>

  <!-- DataLocationFR/EN → stdyDscr/dataAccs/setAvail/accsPlac -->
  <xsl:template match="fresh:DataLocationFR | fresh:DataLocationEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:DataLocationFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <accsPlac lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </accsPlac>
  </xsl:template>

  <!-- NonDisclosureAgreementFR/EN → stdyDscr/dataAccs/useStmt/confDec -->
  <xsl:template match="fresh:NonDisclosureAgreementFR | fresh:NonDisclosureAgreementEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:NonDisclosureAgreementFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <confDec lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </confDec>
  </xsl:template>

  <!-- MockSampleAvailableFR/EN → mockSampleAvailable -->
  <xsl:template match="fresh:MockSampleAvailableFR | fresh:MockSampleAvailableEN">
    <mockSampleAvailable>
      <xsl:value-of select="normalize-space(.)" />
    </mockSampleAvailable>
  </xsl:template>

  <!-- MockSampleLocationFR/EN → mockSampleLocation -->
  <xsl:template match="fresh:MockSampleLocationFR | fresh:MockSampleLocationEN">
    <mockSampleLocation>
      <xsl:value-of select="normalize-space(.)" />
    </mockSampleLocation>
  </xsl:template>

  <!-- OtherDocumentationFR/EN → otherDocumentation -->
  <xsl:template match="fresh:OtherDocumentationFR | fresh:OtherDocumentationEN">
    <otherDocumentation>
      <xsl:value-of select="normalize-space(.)" />
    </otherDocumentation>
  </xsl:template>

  <!-- AccesDonneesAgregeesFR/EN → stdyDscr/othStdMat/relMat -->
  <xsl:template match="AccesDonneesAgregeesFR | AccesDonneesAgregeesEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::AccesDonneesAgregeesFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <relMat lang="{$lang}">
      <xsl:value-of select="normalize-space(value)" />
    </relMat>
  </xsl:template>

  <!-- TypeDonneesRecueilliesFR/EN → stdyDscr/stdyInfo/sumDscr/dataKind -->
  <xsl:template match="TypeDonneesRecueilliesFR | TypeDonneesRecueilliesEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::TypeDonneesRecueilliesFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:for-each select="value">
      <dataKind lang="{$lang}">
        <xsl:value-of select="normalize-space(.)" />
      </dataKind>
    </xsl:for-each>
  </xsl:template>


  <!-- ExistenceDocumentCodageFR/EN → variableDictionnaryLink -->
  <xsl:template match="ExistenceDocumentCodageFR | ExistenceDocumentCodageEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::ExistenceDocumentCodageFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <variableDictionnaryLink lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </variableDictionnaryLink>
  </xsl:template>

  <!-- DonneesCliniquesPrecisionsFR/EN → clinicalDataDetails -->
  <xsl:template match="DonneesCliniquesPrecisionsFR | DonneesCliniquesPrecisionsEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::DonneesCliniquesPrecisionsFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <clinicalDataDetails lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </clinicalDataDetails>
  </xsl:template>

  <!-- DonneesBiologiquesPrecisionsFR/EN → biologicalDataDetails -->
  <xsl:template match="DonneesBiologiquesPrecisionsFR | DonneesBiologiquesPrecisionsEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::DonneesBiologiquesPrecisionsFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <biologicalDataDetails lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </biologicalDataDetails>
  </xsl:template>

  <!-- BiothequeFR/EN → isDataInBiobank -->
  <xsl:template match="BiothequeFR">
    <xsl:variable name="valueNormalized" select="lower-case(normalize-space(.))" />
    <isDataInBiobank>
      <xsl:choose>
        <xsl:when test="$valueNormalized = 'oui'">true</xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
      </xsl:choose>
    </isDataInBiobank>
  </xsl:template>

  <!-- ContenuBiothequeFR/EN → biobankContent -->
  <xsl:template match="ContenuBiothequeFR | ContenuBiothequeEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::ContenuBiothequeFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <biobankContent lang="{$lang}">
      <xsl:for-each select="value">
        <xsl:value-of select="normalize-space(.)" />
        <xsl:text> </xsl:text> <!-- opzionale, per separare i valori -->
      </xsl:for-each>
    </biobankContent>
  </xsl:template>


  <!-- ResearchTypeFR/EN → stdyDscr/method/notes (subject="research type") -->
  <xsl:template match="fresh:ResearchTypeFR | fresh:ResearchTypeEN" mode="append">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:ResearchTypeFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <notes subject="research type" lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </notes>
  </xsl:template>


  <!-- TypeEnqueteFR/EN → stdyDscr/method/dataColl/timeMeth -->
  <xsl:template match="TypeEnqueteFR | TypeEnqueteEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::TypeEnqueteFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <notes lang="{$lang}" subject="observational study method">
      <xsl:for-each select="value">
        <xsl:value-of select="normalize-space(.)" />
        <xsl:text> </xsl:text> <!-- opzionale, per separare i valori -->
      </xsl:for-each>
    </notes>
  </xsl:template>

  <xsl:template match="RecruitmentTimingFR | RecruitmentTimingEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::RecruitmentTimingFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <timeMeth lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </timeMeth>
  </xsl:template>


  <!-- ModalitesDeRecueilFR/EN → collectionModeDetails -->
  <xsl:template match="ModalitesDeRecueilFR | ModalitesDeRecueilEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::ModalitesDeRecueilFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <collectionModeDetails lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </collectionModeDetails>
  </xsl:template>

  <!-- RecrutementParIntermediaireFR/EN → stdyDscr/method/dataColl/sampleFrame/frameUnit/unitType -->
  <xsl:template match="RecrutementParIntermediaireFR | RecrutementParIntermediaireEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::RecrutementParIntermediaireFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <unitType lang="{$lang}">
      <xsl:for-each select="value">
        <xsl:value-of select="normalize-space(.)" />
        <xsl:text> </xsl:text> <!-- opzionale, aggiunge uno spazio tra valori -->
      </xsl:for-each>
    </unitType>
  </xsl:template>


  <!-- InclusionCriterionFR/EN → stdyDscr/stdyInfo/sumDscr/universe (clusion="I") -->
  <xsl:template match="fresh:InclusionCriterionFR | fresh:InclusionCriterionEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:InclusionCriterionFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <universe clusion="I" lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </universe>
  </xsl:template>


  <!-- ExclusionCriterionFR/EN → stdyDscr/stdyInfo/sumDscr/universe (clusion="E") -->
  <xsl:template match="fresh:ExclusionCriterionFR | fresh:ExclusionCriterionEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:ExclusionCriterionFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <universe clusion="E" lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </universe>
  </xsl:template>


  <!-- NationFR/EN → stdyDscr/stdyInfo/sumDscr/nation -->
  <xsl:template match="fresh:NationFR | fresh:NationEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:NationFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <nation lang="{$lang}" abbr="{fresh:URI}">
      <xsl:value-of select="normalize-space(fresh:value)" />
      <concept>
        <vocab>ISO</vocab>
        <vocabURI>
          <xsl:value-of select="normalize-space(fresh:URI)" />
        </vocabURI>
      </concept>
    </nation>
  </xsl:template>

  <!-- RegionsConcerneesFR → geogCover -->
  <xsl:template match="RegionsConcerneesFR">


    <xsl:for-each select="value">
      <geogCover lang="fr">
        <xsl:value-of select="normalize-space(.)" />
      </geogCover>

      <geogCover lang="en">
        <xsl:value-of select="normalize-space(.)" />
      </geogCover>
    </xsl:for-each>

  </xsl:template>

  <!-- ChampGeographiquePrecisionsFR/EN → geoDetail -->
  <xsl:template match="ChampGeographiquePrecisionsFR | ChampGeographiquePrecisionsEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::ChampGeographiquePrecisionsFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <geoDetail lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </geoDetail>
  </xsl:template>


  <!-- LabellisationsEtExpertisesFR/EN → developmentActivity -->
  <xsl:template match="ParametreDeSanteFR | ParametreDeSanteEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::ParametreDeSanteFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:for-each select="value">
      <developmentActivity type="primary evaluation" lang="{$lang}">

        <description>
          <xsl:value-of select="normalize-space(.)" />
        </description>

      </developmentActivity>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="AutreParametreObserveFR | AutreParametreObserveEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::AutreParametreObserveFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <developmentActivity type="secondary evaluation" lang="{$lang}">
      <description>
        <xsl:value-of select="normalize-space(.)" />
      </description>
    </developmentActivity>
  </xsl:template>


  <!-- SexeFR/EN → stdyDscr/stdyInfo/sumDscr/universe (level="sex", clusion="I") -->
  <xsl:template match="SexeFR | SexeEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::SexeFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:for-each select="value">
      <universe level="sex" clusion="I" lang="{$lang}">
        <xsl:value-of select="normalize-space(.)" />
        <concept>
          <vocab>
            <xsl:value-of select="normalize-space(@vocab)" />
          </vocab>
          <vocabURI>
            <xsl:value-of select="normalize-space(@uri)" />
          </vocabURI>
        </concept>
      </universe>
    </xsl:for-each>
  </xsl:template>

  <!-- TranchesAgeFR/EN → stdyDscr/stdyInfo/sumDscr/universe (level="age", clusion="I") -->
  <xsl:template match="TranchesAgeFR | TranchesAgeEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::TranchesAgeFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:for-each select="value">
      <universe level="age" clusion="I" lang="{$lang}">
        <xsl:value-of select="normalize-space(.)" />
        <concept>
          <vocab>
            <xsl:value-of select="normalize-space(@vocab)" />
          </vocab>
          <vocabURI>
            <xsl:value-of select="normalize-space(@uri)" />
          </vocabURI>
        </concept>
      </universe>
    </xsl:for-each>
  </xsl:template>

  <!-- PopulationFR/EN → stdyDscr/stdyInfo/sumDscr/universe (level="type", clusion="I") -->
  <xsl:template match="PopulationFR | PopulationEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::PopulationFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:for-each select="value">
      <universe level="type" clusion="I" lang="{$lang}">
        <xsl:value-of select="normalize-space(.)" />
      </universe>
    </xsl:for-each>
  </xsl:template>


  <!-- AnneePremierRecueilFR/EN → stdyDscr/stdyInfo/sumDscr/collDate (event="start") -->
  <xsl:template match="AnneePremierRecueilFR ">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::AnneePremierRecueilFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <collDate event="start">
      <xsl:value-of select="normalize-space(.)" />
    </collDate>
  </xsl:template>

  <!-- AnneeDernierRecueilFR/EN → stdyDscr/stdyInfo/sumDscr/collDate (event="end") -->
  <xsl:template match="AnneeDernierRecueilFR ">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::AnneeDernierRecueilFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <collDate event="end">
      <xsl:value-of select="normalize-space(.)" />
    </collDate>
  </xsl:template>

  <!-- SuiviDesParticipantsFR/EN → isActiveFollowUp (boolean) -->
  <xsl:template match="SuiviDesParticipantsFR">
    <isActiveFollowUp>
      <xsl:choose>
        <xsl:when
          test="translate(normalize-space(.), 'ouiyes', 'OUIYES') = 'OUI' 
                      or translate(normalize-space(.), 'ouiyes', 'OUIYES') = 'YES'">
          true
        </xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
      </xsl:choose>
    </isActiveFollowUp>
  </xsl:template>

  <!-- SuiviDesParticipantsModalitesFR/EN → stdyDscr/method/notes (subject="follow-up") -->
  <xsl:template match="SuiviDesParticipantsModalitesFR | SuiviDesParticipantsModalitesEN">
    <notes subject="follow-up">
      <xsl:value-of select="normalize-space(.)" />
    </notes>
  </xsl:template>


  <xsl:template match="fresh:IsDataIntegration">
    <isDataIntegration>
      <xsl:value-of select="normalize-space(.)" />
    </isDataIntegration>
  </xsl:template>

  <!-- ======================
     ThirdPartySource → stdyDscr/method/dataColl/sources
     ====================== -->

  <!-- Template principale per ThirdPartySource -->
  <xsl:template match="fresh:ThirdPartySource">
    <sources>
      <!-- Applica template a tutti i sottoelementi -->
      <xsl:apply-templates
        select="//SourcesAdministrativesPrecisionsFR | //SourcesAdministrativesPrecisionsEN | fresh:SourceTypeFR | fresh:SourceTypeEN | fresh:SourcePurposeFR | fresh:SourcePurposeEN" />
    </sources>
  </xsl:template>

  <!-- SourceNameFR/EN → sourceCitation -->
  <xsl:template match="SourcesAdministrativesPrecisionsFR | SourcesAdministrativesPrecisionsEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::SourcesAdministrativesPrecisionsFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <sourceCitation lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </sourceCitation>
  </xsl:template>

  <!-- SourceTypeFR/EN → srcOrig -->
  <xsl:template match="fresh:SourceTypeFR | fresh:SourceTypeEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:SourceTypeFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <srcOrig lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
    </srcOrig>
  </xsl:template>

  <!-- SourcePurposeFR/EN → sourceCitation/notes (subject="source purpose") -->
  <xsl:template match="fresh:SourcePurposeFR | fresh:SourcePurposeEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:SourcePurposeFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <sourceCitation>
      <notes subject="source purpose" lang="{$lang}">
        <xsl:value-of select="normalize-space(.)" />
      </notes>
    </sourceCitation>
  </xsl:template>

  <xsl:template match="fresh:CollectionModeFR | fresh:CollectionModeEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:CollectionModeFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <collMode lang="{$lang}">
      <xsl:value-of select="normalize-space(.)" />
      <concept>
        <xsl:attribute name="vocabURI">
          <xsl:value-of select="@uri" />
        </xsl:attribute>
        <xsl:attribute name="vocab">CESSDA</xsl:attribute>
      </concept>
    </collMode>
  </xsl:template>


  <xsl:template match="fresh:SamplingModeFR | fresh:SamplingModeEN">
    <xsl:variable name="lang">
      <xsl:choose>
        <xsl:when test="self::fresh:SamplingModeFR">fr</xsl:when>
        <xsl:otherwise>en</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <sampProc lang="{$lang}">
      <concept>
        <xsl:attribute name="vocabURI">
          <xsl:value-of select="@uri" />
        </xsl:attribute>
        <xsl:attribute name="vocab">CESSDA</xsl:attribute>

      </concept>
      <xsl:value-of select="normalize-space(.)" />
    </sampProc>
  </xsl:template>


</xsl:stylesheet>