<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<!---Pretend this is your action page--->

<!--- First, write your form variables to the database.  The return the primary key for that record --->

<!--- Then run this in your action page and write these results to a table referencing the primary key you got from above --->

<!---<cfset results = application.minFraud.echo('#cgi.REMOTE_ADDR#', '#form.city#', '#form.state#', '#form.zip#', 'US', '#application.license_key#', '#form.phone#')>--->


<!--- USe this information to create your risk data table --->
<!---http://dev.maxmind.com/minfraud/#Output-14--->

 <!--- Here is a way you might want to show the risk ---> 
<cfchart  title="Overall Risk"  scalefrom="0" scaleto="100"
        chartWidth=100 
        BackgroundColor="##FFFF00" 
        show3D="yes" 
    > 
    <cfchartseries type="bar" seriescolor="##FF0000"> 
    	<cfchartdata item="Risk" value="#structFind(results, 'riskScore')#">
    </cfchartseries> 
</cfchart> 

<cfchart  title="Proxy Score" scalefrom="0" scaleto="100"
        chartWidth=100 
        BackgroundColor="##FFFF00" 
        show3D="yes" 
    > 
    <cfchartseries type="bar" seriescolor="##FF0000"> 
    	<cfchartdata item="Risk" value="#structFind(results, 'proxyScore')#" >
    </cfchartseries> 
</cfchart>
<br><br>
<!--- For a mapping API --->
<cfoutput> 
<br />
ip adDress: #cgi.REMOTE_HOST#<br />
 LAT: #structFind(results, 'ip_latitude')#
 <br>
 LON: #structFind(results, 'ip_longitude')#
 <br />
 </cfoutput>

 
 <cfdump var="#results#">
 <!---
 anonymous Proxy: #structFind(results, 'anonymousProxy')#<br>
 city Postal Match: #structFind(results, 'cityPostalMatch')#<br>
 country Code: #structFind(results, 'countryCode')#<br>
 country Match: #structFind(results, 'countryMatch')#<br>
 cust Phone In Billing Loc: #structFind(results, 'custPhoneInBillingLoc')#<br>
 Radius: #structFind(results, 'distance')# miles<br>
 freeMail: #structFind(results, 'freeMail')#<br>
 high Risk Country: #structFind(results, 'highRiskCountry')#<br>
 ip accuracy Radius: #structFind(results, 'ip_accuracyRadius')#<br>
 ip_areaCode: #structFind(results, 'ip_areaCode')#<br>
 prepaid: #structFind(results, 'prepaid')#<br>
 
 Theses are the interesting ones.  You can get more from the dump.
 --->
 
 
</body>
</html>
