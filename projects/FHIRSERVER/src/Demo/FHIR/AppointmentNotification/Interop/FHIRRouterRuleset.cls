Class Demo.FHIR.AppointmentNotification.Interop.FHIRRouterRuleset Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="" production="">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<constraint name="source" value="FHIR Endpoint"></constraint>
<constraint name="msgClass" value="HS.FHIRServer.Interop.Request"></constraint>
<when condition="(FhirRequestType(Document.QuickStreamId))=&quot;Appointment&quot;" comment="">
<send transform="" target="Notify Patient Process"></send>
</when>
<otherwise>
<send transform="" target="FHIR Storage"></send>
</otherwise>
</rule>
</ruleSet>
</ruleDefinition>
}

}
