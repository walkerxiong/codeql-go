import go

from DataFlow::Node err, ReturnStmt ret, IfStmt ifs, DataFlow::EqualityTestNode eq, DataFlow::Node nil,Boolean outcome,Function func, int i
where err.getType() = Builtin::error().getType() and
nil = Builtin::nil().getARead() and
eq.eq(outcome, err, nil) and
outcome = false and
func.getACall().asExpr() = ret.getExpr() and
ifs.getCond() = eq.asExpr() and
func.getResult(i).getType() instanceof ErrorType and
ifs.getThen().getAStmt() = ret and 
ret.getExpr(i).getType() = Builtin::nil().getType()
select ret