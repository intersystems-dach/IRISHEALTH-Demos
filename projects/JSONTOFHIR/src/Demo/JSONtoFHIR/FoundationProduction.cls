Class Demo.JSONtoFHIR.FoundationProduction Extends Ens.Production [ Not ProcedureBlock ]
{

XData ProductionDefinition
{
<Production Name="Demo.JSONtoFHIR.FoundationProduction" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="Get JWT" Category="" ClassName="ISC.DACH.Interop.JWT.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="APICredentials">AppSecret</Setting>
    <Setting Target="Adapter" Name="HTTPServer">localhost</Setting>
    <Setting Target="Adapter" Name="SSLConfig"></Setting>
    <Setting Target="Adapter" Name="URL">/Demo/Security</Setting>
    <Setting Target="Adapter" Name="HTTPPort">52773</Setting>
  </Item>
  <Item Name="Get Input File" Category="" ClassName="EnsLib.HTTP.GenericOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">localhost</Setting>
    <Setting Target="Adapter" Name="SSLConfig"></Setting>
    <Setting Target="Adapter" Name="URL">/Demo/TestData</Setting>
    <Setting Target="Adapter" Name="HTTPPort">52773</Setting>
  </Item>
  <Item Name="Get JSON File and Convert to Object" Category="" ClassName="Demo.JSONtoFHIR.GetInputFileProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Object To FHIR" Category="" ClassName="ISC.DACH.Interop.DTLtoFHIR.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Save To File</Setting>
    <Setting Target="Host" Name="DTLClassNames">Demo.JSONtoFHIR.ObjectToFHIRPatient,Demo.JSONtoFHIR.ObjectToFHIREncounter,Demo.JSONtoFHIR.ObjectToFHIRObservation,Demo.JSONtoFHIR.ObjectToFHIRCondition,Demo.JSONtoFHIR.ObjectToFHIRClinicalImpression</Setting>
    <Setting Target="Host" Name="FHIRMetadataSet">HL7v40 / FHIR R4 Core Specification</Setting>
    <Setting Target="Host" Name="TransmissionMode">transaction</Setting>
  </Item>
  <Item Name="HS.Util.Trace.Operations" Category="" ClassName="HS.Util.Trace.Operations" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Save To File" Category="" ClassName="ISC.DACH.Interop.DTLtoFHIR.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/output/</Setting>
  </Item>
</Production>
}

}
