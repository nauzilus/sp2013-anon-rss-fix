<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Page Language="C#" Inherits="AnonymousRss.Layouts.AnonymousRss.RssXslt" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> <%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> <%@ Import Namespace="Microsoft.SharePoint" %> <%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<% Response.ContentType = "text/xml"; %>
<xsl:stylesheet
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:dc="http://purl.org/dc/elements/1.1/"
		version="1.0"
>
<xsl:template match='/rss'>
<html ID="HtmlRootTag" runat="server" dir="<%$Resources:wss,multipages_direction_dir_value%>">
	<head>
		<title><xsl:value-of select='channel/title'/></title>
		<style type="text/css">
		.blankline {
			height: 10px;
		}
		.padfive {
			padding: 5px;
		}
		.padten {
			padding: 10px;
		}
		.seventyp {
			width: 70%;
		}
		.underlinestyle, .hoverstyle a:hover {
			text-decoration: underline ! important;
		}
		</style>
		<SharePoint:CssLink runat="server" ID="Csslink1" />
	</head>
	<body>
		<div class="padten">
			<div class="ms-authoringcontrols seventyp padfive">
				<h2 class="padfive"><asp:Label ID="ContentFrameTitle" runat="server"/></h2>
				<div><asp:Label ID="ContentFrameDescription" runat="server"/></div>
				<SharePoint:ScriptBlock runat="server">
				var loc = window.location.href;
				if (loc.substring(0, 5) == "http:")
				{
					document.getElementById("feedlink").href =
						"feed:" + loc.substring(5);
				}
				else if (loc.substring(0, 6) == "https:")
				{
					document.getElementById("feedlink").href =
						"feeds:" + loc.substring(6);
				}
				</SharePoint:ScriptBlock>
				<h3><SharePoint:EncodedLiteral runat="server" text="<%$Resources:wss,RssXslt_TableOfContents%>" EncodeMethod='HtmlEncode'/></h3>
				<ul>
					<xsl:apply-templates select='channel/item' mode='toc'/>
				</ul>
			</div>
			<xsl:apply-templates select='channel/item'/>
		</div>
	</body>
</html>
</xsl:template>
<xsl:template match='title'>
	<xsl:value-of select="." />
</xsl:template>
<xsl:template match='author'>
	<xsl:value-of select="." />
</xsl:template>
<xsl:template match='item' mode='toc'>
	<li class="ms-globallinks hoverstyle"><a>
	<xsl:attribute name='href'> #<xsl:number/></xsl:attribute>
	<xsl:apply-templates select='title' />
	</a></li>
</xsl:template>
<xsl:template match='item'>
<br/><br/>
<div class="ms-inputuserfield padfive seventyp">
	<h4><a class="underlinestyle" href='{link}'><xsl:attribute name='name'><xsl:number /></xsl:attribute><xsl:apply-templates select='title'/></a></h4>
	<div>
		<xsl:value-of select='description' disable-output-escaping='yes' />
	</div>
	<span class="blankline"> </span>
	<div>
		<asp:Label ID="LastModified" runat="server"/><br/>
		<a class="underlinestyle" href='{link}'><SharePoint:EncodedLiteral runat="server" text="<%$Resources:wss,RssXslt_RTWT%>" EncodeMethod='HtmlEncode'/></a><SharePoint:EncodedLiteral runat="server" text="<%$Resources:wss,RssXslt_RTWT_Dot%>" EncodeMethod='HtmlEncode'/>
	</div>
</div>
</xsl:template>
</xsl:stylesheet>
