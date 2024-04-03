/// 
Class Demo.JSONtoFHIR.GetInputFileProcess Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Demo.JSONtoFHIR.InvokeRequest' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='GetInputFileRequest' type='EnsLib.HTTP.GenericMessage' instantiate='1' />
<property name='SchemaPackage' type='%String' initialexpression='"Demo.JSONtoFHIR"' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='2500' />
</parameters>
</property>
<property name='SchemaName' type='%String' initialexpression='"InputFile"' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='250' />
</parameters>
</property>
<property name='GetInputFileResult' type='EnsLib.HTTP.GenericMessage' instantiate='0' />
<property name='InputFileMessage' type='Ens.Request' instantiate='0' />
</context>
<sequence xend='200' yend='1200' >
<call name='Get JWT Operation' target='Get JWT' async='0' xpos='200' ypos='250' >
<request type='Ens.Request' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Ens.StringRequest' >
<assign property="context.GetInputFileRequest.HTTPHeaders" value="&quot;Bearer &quot;_callresponse.StringValue" action="set" languageOverride="" key="&quot;Authorization&quot;" />
</response>
</call>
<assign name="Assign Request Type" property="context.GetInputFileRequest.HTTPHeaders" value="&quot;GET&quot;" action="set" languageOverride="" key="&quot;HttpRequest&quot;" xpos='200' ypos='350' />
<assign name="Assign  HTTP Version" property="context.GetInputFileRequest.HTTPHeaders" value="&quot;1.1&quot;" action="set" languageOverride="" key="&quot;HTTPVersion&quot;" xpos='200' ypos='450' />
<assign name="Assign Content-Type" property="context.GetInputFileRequest.HTTPHeaders" value="&quot;application/json&quot;" action="set" languageOverride="" key="&quot;content-type&quot;" xpos='200' ypos='550' />
<call name='Get Input File' target='Get Input File' async='0' xpos='200' ypos='650' >
<request type='EnsLib.HTTP.GenericMessage' >
<assign property="callrequest" value="context.GetInputFileRequest" action="set" languageOverride="" />
</request>
<response type='EnsLib.HTTP.GenericMessage' >
<assign property="context.GetInputFileResult" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<if name='If schema exists' condition='##class(%Dictionary.CompiledClass).%Exists($lb(context.SchemaPackage_"."_context.SchemaName))' xpos='200' ypos='750' xend='200' yend='1100' >
<true>
<code name='Convert JSON to Object' xpos='470' ypos='900' >
<![CDATA[ $$$TRACE("Schema does exist")
 Set context.InputFileMessage = $CLASSMETHOD(context.SchemaPackage_"."_context.SchemaName,"%New")
 Do context.InputFileMessage.%JSONImport(context.GetInputFileResult.Stream)
 ]]>
</code>
<call name='Call FHIR Conversion' target='Object To FHIR' async='0' xpos='470' ypos='1000' >
<request type='Ens.Request' >
<assign property="callrequest" value="context.InputFileMessage" action="set" languageOverride="" />
</request>
<response type='Ens.Response' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</true>
<false>
<code name='Create Schema' xpos='200' ypos='900' >
<![CDATA[ $$$TRACE("Schema does not exist")
 set tSC = ##class(ISC.SE.Tools.JSON).GenerateClassesFromStream(context.GetInputFileResult.Stream, context.SchemaPackage, context.SchemaName, 1, 1)
 $$$ThrowOnError(tSC)
 $$$LOGINFO("Schema '"_context.SchemaPackage_"."_context.SchemaName_"' created")]]>
</code>
</false>
</if>
</sequence>
</process>
}

}
