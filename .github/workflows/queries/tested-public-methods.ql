/**
 * @description Find all public methods directly invoked from a test
 * @kind problem
 * @id javascript/tested-public-methods
 * @problem.severity recommendation
 */
import javascript

predicate isTest(InvokeExpr expression){
  expression.getCalleeName() = "it" and
  exists(InvokeExpr newExpression | newExpression.getCalleeName() = "describe" and expression.getParent*() = newExpression)
}

// Finds all public methods called from tests
from MethodDeclaration md
where 
    exists(ClassDefinition cd | md.getParent() = cd) and
    md.isPublic() and
    not exists(InvokeExpr call, InvokeExpr test |
      isTest(test) and
      call.getParent*() = test and
      md.getName() = call.getCalleeName()
    )
select md, "No tests that call a public method " + md.getName()
