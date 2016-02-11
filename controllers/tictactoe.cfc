<cfcomponent accessors="true" hint="Tic Tac Toe Controller">
  <cfproperty name="framework" />
  <cfproperty name="tictactoeService" />
  
  
  <cffunction name="get" access="public" returntype="void" hint="Get request for tic tac toe bot">
    <cfset local.data = {
            'Name'        = 'Nischi Bot',
            'Description' = 'The ultimate Tic Tac Toe Bot',
            'Version'     = 1,
            'Active'      = true
           } />
    
    <cfset getFramework().renderData('json',local.data) />
  </cffunction>
  
  
  <cffunction name="post" access="public" returntype="void" hint="Post request for tic tac toe bot">
    <cfset local.board  = deserializeJSON(rc.board) />
    <cfset local.matrix = [] />
    <cfloop from="1" to="3" index="local.row">
      <cfloop from="1" to="3" index="local.column">
        <cfset local.value = ' ' />
        <cfif NOT isNull(local.board[local.row][local.column]) AND local.board[local.row][local.column] EQ 0>
          <cfset local.value = 'O' />
        <cfelseif NOT isNull(local.board[local.row][local.column]) AND local.board[local.row][local.column] EQ 1>
          <cfset local.value = 'X' />
        </cfif>
        <cfset arrayAppend(local.matrix,local.value) />
      </cfloop>
    </cfloop>
    <cfset local.data = getTicTacToeService().getMove(local.matrix) />
    
    <cfset getFramework().renderData('json',local.data) />
  </cffunction>
</cfcomponent>