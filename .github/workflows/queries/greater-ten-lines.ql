/**
 * @description Find all files with functions greater than 10 lines
 * @kind problem
 * @id javascript/functions-greater-10-lines
 * @problem.severity recommendation
 */
import javascript

predicate isJavaScriptOrTypeScriptFile(File file) {
  file.getExtension() = "ts" or file.getExtension() = "tsx"
}

predicate functionGreaterThanNLines(Function func) {
  exists(
    Line line |
    line.getAncestorOfType(Function).getParent() = func and
    line.getNumLines() > 10   
  )
}

from Function function, File file
where
  isJavaScriptOrTypeScriptFile(file) and
  function.getFile() = file and
  functionGreaterThanNLines(function)
select file, "Functions longer than 10 lines in file " + file.getAbsolutePath()
