Class Demo.ComServer.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Demo.ComServer.Production" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="HL7_File_In" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="ArchivePath">/home/irisowner/hl7/archive/</Setting>
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/hl7/in/</Setting>
    <Setting Target="Host" Name="MessageSchemaCategory">2.5</Setting>
    <Setting Target="Host" Name="TargetConfigNames">HL7_Router</Setting>
  </Item>
  <Item Name="HL7_TCP_In" Category="" ClassName="EnsLib.HL7.Service.TCPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.5</Setting>
    <Setting Target="Adapter" Name="Port">44444</Setting>
    <Setting Target="Adapter" Name="ReadTimeout">0</Setting>
    <Setting Target="Adapter" Name="StayConnected">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">HL7_Router</Setting>
    <Setting Target="Host" Name="DefCharEncoding">unicode utf-8</Setting>
  </Item>
  <Item Name="HL7_Router" Category="" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">Demo.ComServer.HL7RoutingRule</Setting>
  </Item>
  <Item Name="HS.Util.Trace.Operations" Category="" ClassName="HS.Util.Trace.Operations" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Send_to_FHIR_server" Category="" ClassName="HS.FHIRServer.Interop.HTTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TraceOperations"></Setting>
    <Setting Target="Host" Name="ServiceName">FHIR Repo</Setting>
  </Item>
  <Item Name="HL7_to_Kitchen" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">%f_%Q%!+(_a).hl7</Setting>
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/hl7/out/</Setting>
  </Item>
  <Item Name="HL7_to_Lab" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">%f_%Q%!+(_a).hl7</Setting>
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/hl7/out/</Setting>
  </Item>
  <Item Name="HL7_to_SDA3" Category="" ClassName="Demo.ComServer.HL7ToSDA3" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="SDA3_to_FHIR" Category="" ClassName="HS.FHIR.DTL.Util.HC.SDA3.FHIR.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">Send_to_FHIR_server</Setting>
    <Setting Target="Host" Name="FHIRMetadataSet">HL7v40 / FHIR R4 Core Specification</Setting>
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
  </Item>
</Production>
}

}
