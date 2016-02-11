<cfcomponent accessors="true" hint="Tic Tac Toe Controller" output="false">
  <cfproperty name="framework" />
  
  
  <cffunction name="get" access="public" returntype="void" hint="Get request for tic tac toe bot">
    <cfset local.data = {
            'Name'        = 'Nischi Bot',
            'Description' = 'The ultimate Tic Tac Toe Bot',
            'Version'     = '1.0.201602.alpha',
            'Active'      = true
           } />
    
    <cfset getFramework().renderData('json',local.data) />
  </cffunction>
</cfcomponent>