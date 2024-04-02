Class Demo.FHIR.AppointmentNotification.Interop.Production Extends Ens.Production [ Not ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="USZuBEISPIEL2PKG.FoundationProduction" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="FHIR Endpoint" Category="" ClassName="HS.FHIRServer.Interop.Service" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">FHIR Message Router</Setting>
  </Item>
  <Item Name="FHIR Storage" Category="" ClassName="HS.FHIRServer.Interop.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="FHIR Message Router" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">Demo.FHIR.AppointmentNotification.Interop.FHIRRouterRuleset</Setting>
    <Setting Target="Host" Name="ResponseFrom">FHIR Storage,Notify Patient Process</Setting>
  </Item>
  <Item Name="Notify Patient Process" Category="" ClassName="Demo.FHIR.AppointmentNotification.Interop.NotificationProcess" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="E-Mail Notification" Category="" ClassName="Demo.FHIR.AppointmentNotification.Interop.EmailOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="SMS Notification" Category="" ClassName="Demo.FHIR.AppointmentNotification.Interop.SMSOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
