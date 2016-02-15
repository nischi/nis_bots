<cfcomponent accessors="true" hint="Service Tic Tac Toe">
  <cfproperty name="framework" />
  
  
  <cffunction name="getMove" access="public" returntype="struct" hint="Make move">
    <cfargument name="matrix" type="array" required="true" hint="Matrix" />
    
    <cfset local.result = minmax(arguments.matrix,"MAX",0,0) />
    <cflog text="INDEX: #local.result.getIntrus()#" file="tictactoe" />
    <cfreturn {
      'Y' = (local.result.getIntrus() - 1) % 3,
      'X' = fix((local.result.getIntrus() - 1) / 3)
    } />
  </cffunction>
  
  
  <cffunction name="getScore" access="public" returntype="numeric" hint="Get the score">
    <cfargument name="matrix" type="array" required="true" hint="Matrix" />
    
    <cfif (arguments.matrix[1] EQ 'x' AND arguments.matrix[2] EQ 'x' AND arguments.matrix[3] EQ 'x') OR
          (arguments.matrix[4] EQ 'x' AND arguments.matrix[5] EQ 'x' AND arguments.matrix[6] EQ 'x') OR
          (arguments.matrix[7] EQ 'x' AND arguments.matrix[8] EQ 'x' AND arguments.matrix[9] EQ 'x') OR
          (arguments.matrix[1] EQ 'x' AND arguments.matrix[4] EQ 'x' AND arguments.matrix[7] EQ 'x') OR
          (arguments.matrix[2] EQ 'x' AND arguments.matrix[5] EQ 'x' AND arguments.matrix[8] EQ 'x') OR
          (arguments.matrix[3] EQ 'x' AND arguments.matrix[6] EQ 'x' AND arguments.matrix[9] EQ 'x') OR
          (arguments.matrix[1] EQ 'x' AND arguments.matrix[5] EQ 'x' AND arguments.matrix[9] EQ 'x') OR
          (arguments.matrix[3] EQ 'x' AND arguments.matrix[5] EQ 'x' AND arguments.matrix[7] EQ 'x')
          >
      <cfreturn -1 />
    </cfif>
    <cfif (arguments.matrix[1] EQ 'o' AND arguments.matrix[2] EQ 'o' AND arguments.matrix[3] EQ 'o') OR
          (arguments.matrix[4] EQ 'o' AND arguments.matrix[5] EQ 'o' AND arguments.matrix[6] EQ 'o') OR
          (arguments.matrix[7] EQ 'o' AND arguments.matrix[8] EQ 'o' AND arguments.matrix[9] EQ 'o') OR
          (arguments.matrix[1] EQ 'o' AND arguments.matrix[4] EQ 'o' AND arguments.matrix[7] EQ 'o') OR
          (arguments.matrix[2] EQ 'o' AND arguments.matrix[5] EQ 'o' AND arguments.matrix[8] EQ 'o') OR
          (arguments.matrix[3] EQ 'o' AND arguments.matrix[6] EQ 'o' AND arguments.matrix[9] EQ 'o') OR
          (arguments.matrix[1] EQ 'o' AND arguments.matrix[5] EQ 'o' AND arguments.matrix[9] EQ 'o') OR
          (arguments.matrix[3] EQ 'o' AND arguments.matrix[5] EQ 'o' AND arguments.matrix[7] EQ 'o')
          >
      <cfreturn 1 />
    </cfif>
    <cfreturn 0 />
  </cffunction>
  
  
  <cffunction name="inverse" access="public" returntype="string" hint="Invesrse">
    <cfargument name="level"  type="string" required="true" hint="Level" />
    
    <cfreturn arguments.level EQ 'MIN' ? 'MAX' : 'MIN' />
  </cffunction>
  
  
  <cffunction name="generateSuccessor" access="public" returntype="any" hint="generate successor">
    <cfargument name="matrix" type="array"  required="true" hint="Matrix" />
    <cfargument name="level"  type="string" required="true" hint="Level" />
    
    <cfset local.successor = [] />
    <cfloop from="1" to="#arrayLen(arguments.matrix)#" index="local.i">
      <cfif arguments.matrix[local.i] EQ ' '>
        <cfset local.child = [] />
        <cfloop from="1" to="9" index="local.j">
          <cfset arrayAppend(local.child,arguments.matrix[local.j]) />
        </cfloop>
        <cfif arguments.level EQ 'MAX'>
          <cfset local.child[i] = 'o' />
        <cfelse>
          <cfset local.child[i] = 'x' />
        </cfif>
        <cfset arrayAppend(local.successor,local.child) />
      </cfif>
    </cfloop>
      
    <cfreturn arrayLen(local.successor) EQ 0 ? javaCast('null','') : local.successor />
  </cffunction>
    
  
  <cffunction name="getResult" access="public" returntype="any" hint="Get Result">
    <cfargument name="listScore"  type="array" required="true" hint="List Score" />
    <cfargument name="level"      type="string" required="true" hint="Level" />
    
    <cfset local.result = arguments.listScore[1] />
    <cfif arguments.level EQ 'MAX'>
      <cfloop from="1" to="#arrayLen(arguments.listScore)#" index="local.i">
        <cfif (arguments.listScore[local.i].getScore() GT local.result.getScore()) OR
            (arguments.listScore[local.i].getScore() == local.result.getScore() AND arguments.listScore[i].getDepth() LT local.result.getDepth())
          >
          <cfset local.result = arguments.listScore[local.i] />
        </cfif>
      </cfloop>
    <cfelse>
      <cfloop from="1" to="#arrayLen(arguments.listScore)#" index="local.i">
        <cfif (arguments.listScore[local.i].getScore() LT local.result.getScore()) OR
            (arguments.listScore[local.i].getScore() == local.result.getScore() AND arguments.listScore[i].getDepth() LT local.result.getDepth())
          >
          <cfset local.result = arguments.listScore[local.i] />
        </cfif>
      </cfloop>
    </cfif>
      
    <cfreturn local.result />
  </cffunction>
  
  
  <cffunction name="minmax" access="public" returntype="any" hint="Calculcate min max">
    <cfargument name="matrix" type="array"    required="true" hint="Matrix" />
    <cfargument name="level"  type="string"   required="true" hint="Level" />
    <cfargument name="fils"   type="numeric"  required="true" hint="Fils" />
    <cfargument name="depth"  type="numeric"  required="true" hint="Depth" />
    
    <cfset local.children = generateSuccessor(arguments.matrix,arguments.level) />
    <cfif isNull(local.children) OR arrayIsEmpty(local.children)>
      <cfset local.bean = getFramework().getBeanFactory().getBean('minmax') />
      <cfset local.bean.setMatrix(arguments.matrix) />
      <cfset local.bean.setScore(getScore(arguments.matrix)) />
      <cfset local.bean.setDepth(arguments.depth) />
      <cfreturn local.bean />
    <cfelse>
      <cfset local.listScore = [] />
      <cfloop from="1" to="#arrayLen(local.children)#" index="local.i">
        <cfset arrayAppend(local.listScore,minmax(local.children[local.i],inverse(arguments.level),1,arguments.depth+1)) />
      </cfloop>
      
      <cfset local.result = getResult(local.listScore,arguments.level) />
      <cfif arguments.fils EQ 1>
        <cfset local.result.setMatrix(arguments.matrix) />
      </cfif>
      
      <cfreturn local.result />
    </cfif>
  </cffunction>
</cfcomponent>