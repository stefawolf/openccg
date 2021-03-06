<!--Copyright (C) 2005-2009 Scott Martin, Rajakrishan Rajkumar and Michael White
 
 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public
 License along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.-->


<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns:xalan="http://xml.apache.org/xalan"
  xmlns:xalan2="http://xml.apache.org/xslt"
  xmlns:java="http://xml.apache.org/xalan/java"
  exclude-result-prefixes="xalan xalan2 java">

<xsl:output method="xml" indent="yes" xalan2:indent-amount="2" omit-xml-declaration = "yes"/>

<xsl:strip-space elements="*"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<!--The first slash of all non-conj punct cats made associative
<xsl:template match="Leafnode[contains(@pos1,'PUNCT') and not(contains(@pos1,'CONJ'))]/complexcat/slash[position()=1]">
	<slash dir="{@dir}" mode="^"/>
</xsl:template>-->

<!--Remaining slashes of non-conj punct cats made application only
Commented out as this does not work completely as 8 LFs are not created. Will look into it
<xsl:template match="Leafnode[not(contains(@pos1,'SAY')) and contains(@pos1,'PUNCT') and not(contains(@pos1,'CONJ'))]/complexcat/slash[position()>1]">
	<slash dir="{@dir}" mode="*"/>
</xsl:template>-->

<!--Change all the top-level slashes of selected punctuation categories to application-only (*)-->

<xsl:template match="Leafnode[contains(@pos1,'PUNCT_SAY')]/complexcat[*[1]/@type='s' and *[3]/@type='s']/slash">
	<slash dir="{@dir}" mode="*"/>
</xsl:template>
<xsl:template match="Leafnode[@pos1='PUNCT_APPOS']/complexcat/slash">
	<slash dir="{@dir}" mode="*"/>
</xsl:template>

<!--For this kind of apposition, the first slash should be associative-->
<xsl:template match="Leafnode[@pos1='PUNCT_APPOS_MISC']/complexcat/slash[position()=1]">
	<slash dir="{@dir}" mode="^"/>
</xsl:template>

<!--Slash in determiners np_1/n_1 made associative-->
<xsl:template match="Leafnode[@cat='np_1/n_1']/*[1]/slash[@dir='/']">
	<slash dir="{@dir}" mode="^"/>
</xsl:template>

<!--Default global copy rule-->
<xsl:template match="@*|node()">
   <xsl:copy>
     <xsl:apply-templates select="@*|node()"/>
   </xsl:copy>
</xsl:template>

</xsl:transform>











