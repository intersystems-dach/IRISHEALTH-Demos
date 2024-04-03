Class ISC.DACH.Interop.DTLtoFHIR.FileOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter SETTINGS = "Filename:Basic,UseFormatAsFileSuffix:Basic";

Parameter INVOCATION = "Queue";

/// Name of file to output the document(s) to. May include timestamp specifiers. The %f specifier
/// if present will be replaced with the FHIR resource type of the request.
/// See method Ens.Util.File.CreateTimestamp() for documentation of timestamp options.
Property Filename As %String(MAXLEN = 1000, MINLEN = 1) [ InitialExpression = "fhir_%f_%+(01)", Required ];

/// If enabled, '.xml' or '.json' will be added to the filename as suffix
/// according to the FHIR format if the request.
Property UseFormatAsFileSuffix As %Boolean [ InitialExpression = 1 ];

Method OutputFile(pInteropRequest As HS.FHIRServer.Interop.Request, Output pInteropResponse As HS.FHIRServer.Interop.Response)
{
    #dim tSC As %Status = $$$OK

    Try {
		$$$ThrowOnError(pInteropRequest.NewResponse(.pInteropResponse))

        // Generate FileName
        Set tFileNameBase = $REPLACE(pInteropRequest.Request.RequestPath, "/", "-")
        if (tFileNameBase = "-") {
            Set tFileNameBase = "Bundle"
        }
        Set fFileNameSpec = ..Filename
        if (..UseFormatAsFileSuffix) {
            Set fFileNameSpec = fFileNameSpec_"."_$ZCONVERT(pInteropRequest.Request.RequestFormatCode, "L")
        }
        Set tFileName = ..Adapter.CreateFilename(tFileNameBase, fFileNameSpec)
        $$$TRACE("Filename: "_tFileName)
		
		If pInteropRequest.QuickStreamId '= "" {
			Set quickStreamIn = ##class(HS.SDA3.QuickStream).%OpenId(pInteropRequest.QuickStreamId,, .tSC)
			$$$ThrowOnError(tSC)
            
            $$$ThrowOnError(..Adapter.PutStream(tFileName, quickStreamIn))
		}
		set pInteropResponse.Response.Status = 200
	
	} Catch eException {
		Set tSC = eException.AsStatus()
        If ($ISOBJECT(pInteropResponse)) {
            Set pInteropResponse.Response.Status = 501
        }
	}
		
	Quit tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="HS.FHIRServer.Interop.Request">
		<Method>OutputFile</Method>
	</MapItem>
</MapItems>
}

}
