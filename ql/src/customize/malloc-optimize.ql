import go

from Variable ptr,Write w, ControlFlow::Node node,ReturnStmt ret,DataFlow::ResultNode retNode
where w = ptr.getAWrite()  and
ptr.getType() instanceof PointerType 


select ptr