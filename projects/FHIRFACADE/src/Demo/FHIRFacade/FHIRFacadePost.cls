/// Response Code
Class Demo.FHIRServer.FHIRFacadePost Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='HS.FHIRServer.Interop.Request' response='HS.FHIRServer.Interop.Response' height='2000' width='2000' layout='manual' >
<context>
<property name='ResponseCode' type='%Integer' initialexpression='501' instantiate='0' >
<annotation><![CDATA[Default Response is 501 (not implemented)]]></annotation>
</property>
<property name='FHIRObservation' type='HS.FHIR.DTL.vR4.Model.Resource.Observation' instantiate='0' />
<property name='BloodPressureRequest' type='Demo.FHIRServer.Observations.Interop.BloodPressureMsg' instantiate='0' />
</context>
<sequence xpos='200' ypos='150' xend='200' yend='1000' >
<if name='Check RequestPath' condition='request.Request.RequestPath = "Observation"' xpos='200' ypos='350' xend='200' yend='900' >
<annotation><![CDATA[If REST endpoint is Observation]]></annotation>
<true>
<code name='Open Stream' xpos='470' ypos='500' >
<![CDATA[ Set tQuickStreamIn = ##class(HS.SDA3.QuickStream).%OpenId(request.QuickStreamId)
 Set context.FHIRObservation = ##class(HS.FHIR.DTL.vR4.Model.Resource.Observation).FromJSON(tQuickStreamIn, "vR4")]]>
</code>
<transform name='Transform FHIR' class='Demo.FHIRServer.FHIRObservationToBloodPressure' source='context.FHIRObservation' target='context.BloodPressureRequest' xpos='470' ypos='600' >
<annotation><![CDATA[Uses a DTL to convert FHIR to proprietary format]]></annotation>
</transform>
<call name='Blood Pressure Operation' target='Store Blood Pressure' async='0' xpos='470' ypos='700' >
<request type='Demo.FHIRServer.Observations.Interop.BloodPressureMsg' >
<assign property="callrequest" value="context.BloodPressureRequest" action="set" languageOverride="" />
</request>
<response type='Ens.Response' />
</call>
<assign name="Response Status" property="response.Response.Status" value="201" action="set" languageOverride="" xpos='470' ypos='800' >
<annotation><![CDATA[Status code = 201 (Created)]]></annotation>
</assign>
</true>
<false>
<assign name="Response Status" property="response.Response.Status" value="501" action="set" languageOverride="" xpos='176' ypos='610' >
<annotation><![CDATA[Status code = 501 (Not implemented)]]></annotation>
</assign>
</false>
</if>
</sequence>
</process>
}

}
