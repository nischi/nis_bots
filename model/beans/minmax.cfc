<cfcomponent accessors="true" hint="Min Max Bean">
  <cfproperty name="matrix" type="array" />
  <cfproperty name="score"  type="numeric" />
  <cfproperty name="depth"  type="numeric" />
    
  
  <cffunction name="getIntrus" access="public" returntype="numeric" hint="Get Intrus">
    <cfloop from="1" to="9" index="local.i">
      <cfif NOT compare(getMatrix()[local.i],'o')>
        <cfreturn local.i />
      </cfif>
    </cfloop>
    
    <cfreturn -1 />
  </cffunction>
</cfcomponent>