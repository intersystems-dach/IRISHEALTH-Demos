Class Demo.FHIRServer.FHIRObservationToBloodPressure Extends Ens.DataTransformDTL [ DependsOn = (HS.FHIR.DTL.vR4.Model.Resource.Observation, Demo.FHIRServer.Observations.Interop.BloodPressureMsg) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.FHIR.DTL.vR4.Model.Resource.Observation' targetClass='Demo.FHIRServer.Observations.Interop.BloodPressureMsg' create='new' language='objectscript' >
<assign value='source.contained.(1).identifier.(1).value' property='target.DeviceId' action='set' />
<assign value='source.component.(1).valueQuantity.value' property='target.Systolic' action='set' />
<assign value='source.component.(2).valueQuantity.value' property='target.Diastolic' action='set' />
<assign value='source.effectiveDateTime' property='target.Timestamp' action='set' />
</transform>
}

}
