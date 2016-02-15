<cfcomponent>
  <cffunction name="before" access="public" returntype="void" hint="Logging before">
    <cfargument name="targetBean" type="any"    required="true"   hint="Bean" />
    <cfargument name="methodName" type="string" required="true"   hint="Method name" />
    <cfargument name="args"       type="struct" required="false"  hint="Arguments" />
    
    <cflog text="#arguments.methodName#: #deserializeJSON(arguments.args)#" />
  </cffunction>
</cfcomponent>