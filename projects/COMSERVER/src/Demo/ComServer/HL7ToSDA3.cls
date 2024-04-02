/// 
Class Demo.ComServer.HL7ToSDA3 Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='EnsLib.HL7.Message' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='SDA3Message' type='HS.Message.XMLMessage' instantiate='1' />
</context>
<sequence xend='200' yend='450' >
<code name='Convert HL7 to SDA3' xpos='200' ypos='250' >
<![CDATA[ set tSc = ##class(HS.Gateway.HL7.HL7ToSDA3).GetSDA(request, .tSDA3Stream)
 set tSDAString = tSDA3Stream.Read()
 set tSDAString = $piece(tSDAString, "?>", 2,*)
 set tSc = context.SDA3Message.ContentStream.Write(tSDAString)]]>
</code>
<call name='Call SDA3 to FHIR Conversion' target='SDA3_to_FHIR' async='1' xpos='200' ypos='350' >
<request type='HS.Message.XMLMessage' >
<assign property="callrequest" value="context.SDA3Message" action="set" languageOverride="" />
</request>
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
