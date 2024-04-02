Class Demo.ComServer.HL7RoutingRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="Demo.ComServer.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="">
<when condition="1" comment="">
<send transform="" target="HL7_to_SDA3"></send>
<send transform="Demo.ComServer.DTL.GenderCoding" target="HL7_to_Kitchen"></send>
<send transform="Demo.ComServer.DTL.SwitchName" target="HL7_to_Lab"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
