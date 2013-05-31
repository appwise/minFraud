<cfcomponent> 
<cfset This.name = "MaxMindMinFraud"> 
<cfset This.Sessionmanagement=true> 
<cfset This.Sessiontimeout="#createtimespan(0,0,10,0)#"> 
<cfset This.applicationtimeout="#createtimespan(5,0,0,0)#"> 
 
<cffunction name="onApplicationStart"> 
    <cfset application.minFraud = createObject("component","components.minFraud")>
    
    
    <!--- You do not have to lock code in the onApplicationStart method that sets Application scope variables. ---> 
    <!--- User ID is not used I just have it here in case its used in the future --->
    
    <!---get it here: https://www.maxmind.com/en/my_license_key--->
    <cfset application.user_id = "">
 	<cfset application.license_key = "">
    <cfset application.minFraud_hostname = "minfraud.maxmind.com">
    <cfset application.minFraud_URIsuffix = "/app/ccv2r">
    <!--- You do not need to return True if you don't set the cffunction returntype attribute. ---> 
    </cffunction> 
 
<cffunction name="onApplicationEnd"> 
    <cfargument name="ApplicationScope" required=true/> 
    <cflog file="#This.Name#" type="Information"  
        text="Application #ApplicationScope.applicationname# Ended"> 
</cffunction> 
 
 
<cffunction name="onRequestStart">  
     

</cffunction> 
 
 
<cffunction name="onRequestEnd"> 
  
</cffunction> 
 
<cffunction name="onSessionStart"> 

</cffunction> 
 
<cffunction name="onSessionEnd"> 

</cffunction> 
 
<cffunction name="onError"> 
    <cfargument name="Exception" required=true/> 
    <cfargument type="String" name = "EventName" required=true/> 
    <!--- Log all errors. ---> 
    <cflog file="#This.Name#" type="error" text="Event Name: #Eventname#"> 
    <cflog file="#This.Name#" type="error" text="Message: #exception.message#"> 
    <!--- Some exceptions, including server-side validation errors, do not 
             generate a rootcause structure. ---> 
    <cfif isdefined("exception.rootcause")> 
        <cflog file="#This.Name#" type="error"  
            text="Root Cause Message: #exception.rootcause.message#"> 
    </cfif>     
    <!--- Display an error message if there is a page context. ---> 
    <cfif NOT (Arguments.EventName IS onSessionEnd) OR  
            (Arguments.EventName IS onApplicationEnd)> 
        <cfoutput> 
            <h2>An unexpected error occurred.</h2> 
            <p>Please provide the following information to technical support:</p> 
            <p>Error Event: #EventName#</p> 
            <p>Error details:<br> 
            <cfdump var=#exception#></p> 
        </cfoutput> 
    </cfif> 
    </cffunction> 
 
</cfcomponent>