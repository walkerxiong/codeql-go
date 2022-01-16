import go



from Function fct
where fct.hasQualifiedName(_, "recursion") and
fct.getBody().getAChildStmt() = fct.getACall().asExpr()
select fct.getBody().getAChildStmt()