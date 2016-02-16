<cfcomponent accessors="true" hint="Tic Tac Toe Controller">
  <cfproperty name="framework" />
  <cfproperty name="tictactoeService" />
  
  
  <cffunction name="get" access="public" returntype="void" hint="Get request for tic tac toe bot">
    <cflog text="GET: #serializeJSON(rc)#" file="tictactoe" />
    
    <cfset local.data = {
            'Name'        = 'Ultimo',
            'Description' = 'The ultimate Tic Tac Toe Bot',
            'Version'     = 2,
            'Active'      = true
           } />
    
    <cfset getFramework().renderData('json',local.data) />
  </cffunction>
  
  
  <cffunction name="post" access="public" returntype="void" hint="Post request for tic tac toe bot">
    <cflog text="POST: #serializeJSON(rc)#" file="tictactoe" />
    
    <cfset local.data = { 'R'=1,'C'=1 } />
    <cfif structKeyExists(rc,'gameState')>
      <cfset local.gameState  = deserializeJSON(rc.gameState) />
      <cfset local.board      = local.gameState.board />
      <cfset local.matrix     = [] />
      <cfset local.isO        = rc.player EQ local.gameState.player2 />
      <cfset local.isEmpty    = true />
      
      <cfloop from="1" to="3" index="local.row">
        <cfloop from="1" to="3" index="local.column">
          <cfset local.value = ' ' />
          <cfif NOT isNull(local.board[local.row][local.column]) AND local.board[local.row][local.column] EQ 0>
            <cfset local.value    = local.isO ? 'O' : 'X' />
            <cfset local.isEmpty  = false />
          <cfelseif NOT isNull(local.board[local.row][local.column]) AND local.board[local.row][local.column] EQ 1>
            <cfset local.value    = NOT local.isO ? 'O' : 'X' />
            <cfset local.isEmpty  = false />
          </cfif>
          <cfset arrayAppend(local.matrix,local.value) />
        </cfloop>
      </cfloop>
        
      <cfif NOT local.isEmpty>
        <cfset local.data = getTicTacToeService().getMove(local.matrix) />
      </cfif>
    </cfif>
      
    <cflog text="POST: #serializeJSON(local.data)#" file="tictactoe" />
    
    <cfset getFramework().renderData('json',local.data) />
  </cffunction>
</cfcomponent>