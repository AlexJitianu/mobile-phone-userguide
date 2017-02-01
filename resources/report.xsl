<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xpath-default-namespace="http://www.oxygenxml.com/ns/report">
    
    <xsl:template match="report">
        <html>
            <head>
                <title>Validate and Check for completeness report</title>
                <style>
                    .incident { border-bottom: 1px solid black; margin-bottom:10px;}
                </style>
                
            </head>
            <body>
              <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="incident">
        <div class="incident">
            <h4>Incident <xsl:value-of select="count(preceding-sibling::incident) + 1"/></h4>
            <table style="margin-left:10px">
                <xsl:apply-templates/>
            </table>
        </div>
    </xsl:template>
    
  
    
    <xsl:template match="severity | description | systemID">
        <tr>
        <td style="font-weight:bold;">
            <xsl:value-of select="upper-case(substring(local-name(), 1, 1))"/>
            <xsl:value-of select="substring(local-name(), 2)"/>
        </td>
         <td >
            <xsl:value-of select="."/>
         </td>
        </tr>
    </xsl:template>
    
   <!-- <xsl:template match="severity">
        <span>Severity: <xsl:value-of select="."/></span>
    </xsl:template>
    
    <xsl:template match="description">
        <h5>Description</h5>
        <p><xsl:value-of select="."/></p>
    </xsl:template>
    
    <xsl:template match="systemID">
        <span>System id: <xsl:value-of select="."/></span>
    </xsl:template>-->
    
    <xsl:template match="text()"/>
    
</xsl:stylesheet>