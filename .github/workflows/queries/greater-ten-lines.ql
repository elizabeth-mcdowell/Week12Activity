/**
 * @description Find all files with functions greater than 10 lines
 * @kind problem
 * @id javascript/functions-greater-ten-lines
 * @problem.severity recommendation
 */
import javascript

from Function function
where function.getNumLines() > 10
select function, "is longer than 10 lines"
