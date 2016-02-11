<cfcomponent hint="bots for ai games" extends="framework.one" output="false">
  <cfset variables.framework = getFrameworkConfig() />
  
  <cffunction name="getFrameworkConfig" access="private" returntype="struct" hint="Get the configuration of the Framework">
    
    <cfset local.config = {
      reloadApplicationOnEveryRequest = true,
      routes = [
        { "$GET/bot/tictactoe" = "/tictactoe/get" },
        { "$POST/bot/tictactoe" = "/tictactoe/post" }
      ]
    } />
    
    <cfreturn local.config />
  </cffunction>
  
  
  <cffunction name="setupApplication" returnType="void" access="public" output="false">
    <cfset getBeanFactory().addBean('framework',this) />
  </cffunction>
</cfcomponent>