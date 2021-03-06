{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"
import _ from 'lodash'

#FIXME: Broken with KaTeX, figure out what to do with it. id:30
generators =
  linGlSys : (level = 1, language="de") ->
    coeffMatrix = (d) ->
      matrix = math.matrix (rnd.intsMin(-9,9)[1..d]for i in [1..d])
      unless (math.det matrix) is 0
        matrix
      else
        coeffMatrix d
    dimension = level + 1
    solutions = (rnd.intsMin -9, 9)[1..dimension]
    solutionNames = rnd.uniqueLetters()[1..dimension]
    coeffs = coeffMatrix dimension
    rightSides = math.multiply(coeffs,solutions)
    problem = (
      for rightSide, i in rightSides._data
        leftSide = ""
        for solutionName, j in solutionNames
          coeff = coeffs._data[i][j]
          leftSide += " + #{coeff} #{solutionName}"
        nerdamer("#{leftSide} = #{rightSide}")
    ).join ","
    solutionArray =
      solutionNames.map (name, i) -> "#{name} = #{solutions[i]}"
    solution = solutionArray.join(", ")
    chars = solutionNames.sort().join(", ").split("")
    if lastCommaPosition = chars.lastIndexOf ","
      chars[lastCommaPosition] = " und"
    variableNamesString = chars.join ""
    #return
    problem : problem
    solution : solution
    description : "Löse das Lineare Gleichungssystem. Bestimme die Variablen \
      #{variableNamesString}."
    checks : [
      Check.equivalent
      Check.noReducableFractionsOptional,
      Check.leftSideExactFit
    ]
exports.linGlSys =
  title :
    de : "Lineare Gleichungssysteme"
  description :
    de : "Mehrere Gleichungen mit mehreren Unbekannten"
  problems : [
    levels : [1..5]
    generator : generators.linGlSys
  ]
