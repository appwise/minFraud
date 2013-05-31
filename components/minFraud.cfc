<cfcomponent>

    
	<!---<cffunction name="init" access="minFraud" output="false" hint="The base constructor.">
    <CFSET pattern = createObject("java", "java.util.regex.Pattern").compile(ippattern);>
		<cfreturn this />
    </cffunction>--->
    
	<cffunction name="echo" access="public" output="yes" returntype="struct" >
    
		<cfargument name="i" type="string" required="yes">
        <cfargument name="city" type="string" required="yes">
        <cfargument name="region" type="string" required="yes">
        <cfargument name="postal" type="string" required="yes">
        <cfargument name="country" type="string" required="yes">
        <cfargument name="license_key" type="string" default="#application.license_key#" required="yes">
        <cfargument name="custPhone" type="string"  required="yes">
        
            <cflock type="exclusive" scope="session" timeout="3">
                <cfset arr = ArrayNew(1)>
                <cfset temp = ArrayNew(1)> 
                <cfset myStruct=StructNew()>
                <cfset clearTemp = ArrayClear(temp)>
            </cflock>    
            
			<cfhttp method="get" url="https://minfraud.maxmind.com/app/ccv2r">
            	<cfhttpparam type="formfield" name="i" value="#arguments.i#">
                <cfhttpparam type="formfield" name="city" value="#arguments.city#">
                <cfhttpparam type="formfield" name="region" value="#arguments.region#">
                <cfhttpparam type="formfield" name="postal" value="#arguments.postal#">
                <cfhttpparam type="formfield" name="country" value="#arguments.country#">
                <cfhttpparam type="formfield" name="license_key" value="#arguments.license_key#">
                <cfhttpparam type="formfield" name="custPhone" value="#arguments.custPhone#">
            </cfhttp>
            
            <cfset returnString = cfhttp.fileContent>
            <!--- Take the returned content and make an array out of it --->
            <cfset arr = listToArray (returnString, ";",false,false)>
            
            
            <cfset lstLen = ArrayLen(arr)>
            <!--- loop over the single dimensional array --->
            <cfloop from="1" to="#lstLen#" index="pozition">
            	
                <!--- Look for the = sign as the deliminator --->
            	<cfset Temp = listToArray (arr[pozition], "=",false,false)>
                
                <!--- Store it all in a structure :: Easier to search --->
                <cfif ArrayLen(temp) EQ 2>
                    <cfset minFraudStruct[Temp[1]] = Temp[2]>
                <cfelse>
                    <cfset minFraud[Temp[1]] = 'NA'>
                </cfif>
            	<cfset clearTemp = ArrayClear(temp)>
            </cfloop>
            
           
		<cfreturn minFraud>
	</cffunction>
</cfcomponent>