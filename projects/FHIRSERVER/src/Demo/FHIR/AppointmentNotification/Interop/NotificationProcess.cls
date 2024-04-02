Class Demo.FHIR.AppointmentNotification.Interop.NotificationProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='HS.FHIRServer.Interop.Request' response='HS.FHIRServer.Interop.Response' height='2000' width='2000' >
<context>
<property name='PatientID' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='250' />
</parameters>
</property>
<property name='PatientFHIRResponse' type='HS.FHIRServer.Interop.Response' instantiate='0' />
<property name='PatientMobile' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='PatientEmail' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='150' />
</parameters>
</property>
<property name='AppointmentIsUpdate' type='%Boolean' instantiate='0' />
<property name='AppointmentStart' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='150' />
</parameters>
</property>
</context>
<sequence xend='200' yend='1700' >
<code name='PatientID and Time' xpos='200' ypos='250' >
<annotation><![CDATA[Get Patient ID and AppointmentTime from appointment request]]></annotation>
<![CDATA[ Set tQuickStream = ##class(HS.SDA3.QuickStream).%OpenId(request.QuickStreamId)
 Set tJsonObject = ##class(%DynamicAbstractObject).%FromJSON(tQuickStream)
 
 Set context.AppointmentStart = tJsonObject.start
 
 Set tIter = tJsonObject.participant.%GetIterator()
 While tIter.%GetNext(, .value,)
 {
    If $FIND(value.actor.reference, "Patient", 0) 
    {
       Set context.PatientID  = value.actor.reference
    }  

 }]]>
</code>
<call name='Get Patient' target='FHIR Storage' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[Get Patient info from FHIR repository]]></annotation>
<request type='HS.FHIRServer.Interop.Request' >
<assign property="callrequest.Request.SessionApplication" value="request.Request.SessionApplication" action="set" />
<assign property="callrequest.Request.RequestMethod" value="&quot;GET&quot;" action="set" />
<assign property="callrequest.Request.RequestPath" value="context.PatientID" action="set" />
</request>
<response type='HS.FHIRServer.Interop.Response' >
<assign property="context.PatientFHIRResponse" value="callresponse" action="set" />
</response>
</call>
<code name='Patient Info' xpos='200' ypos='450' >
<annotation><![CDATA[Extract mail and phone from Patient FHIR Object]]></annotation>
<![CDATA[ Set tQuickStream = ##class(HS.SDA3.QuickStream).%OpenId(context.PatientFHIRResponse.QuickStreamId)
 Set tJsonObject = ##class(%DynamicAbstractObject).%FromJSON(tQuickStream)
 Set tIter = tJsonObject.telecom.%GetIterator()
 While tIter.%GetNext(, .value,)
 {
    If $FIND(value.system, "phone", 0) 
    {
       Set context.PatientMobile  = value.value
    }
    
    If $FIND(value.system, "email", 0) 
    {
       Set context.PatientEmail  = value.value
    }

 }]]>
</code>
<call name='Create or update App.' target='FHIR Storage' async='0' xpos='200' ypos='550' >
<annotation><![CDATA[Send Apppointment request to FHIR repository]]></annotation>
<request type='HS.FHIRServer.Interop.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='HS.FHIRServer.Interop.Response' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<if name='Is Update?' condition='response.Response.Status="200"' xpos='200' ypos='650' xend='200' yend='1600' >
<true>
<trace name='Trace' value='"App is an update"' xpos='335' ypos='800' />
<if name='Mobile Phone?' condition='$LENGTH(context.PatientMobile) &gt; 2' xpos='335' ypos='900' xend='335' yend='1150' >
<true>
<call name='Send SMS Notication' target='SMS Notification' async='1' xpos='470' ypos='1050' >
<request type='Demo.FHIR.AppointmentNotification.Interop.SMSRequest' >
<assign property="callrequest.MobilePhone" value="context.PatientMobile" action="set" />
<assign property="callrequest.Message" value="&quot;Ihr Termin im USZ wurde verschoben: &quot;_context.AppointmentStart" action="set" />
</request>
</call>
</true>
</if>
<if name='Has Email?' condition='$LENGTH(context.PatientEmail) &gt; 5' xpos='335' ypos='1250' xend='335' yend='1500' >
<true>
<call name='Send Email Notification' target='E-Mail Notification' async='1' xpos='470' ypos='1400' >
<request type='Demo.FHIR.AppointmentNotification.Interop.EmailRequest' >
<assign property="callrequest.EmailAddress" value="context.PatientEmail" action="set" />
<assign property="callrequest.Subject" value="&quot;Terminverschiebung USZ&quot;" action="set" />
<assign property="callrequest.Message" value="&quot;Ihr Termin im USZ wurde verschoben: &quot;_context.AppointmentStart" action="set" />
</request>
</call>
</true>
</if>
</true>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
