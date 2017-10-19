{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ teXifyAM } = require "../renderAM.coffee"

checksPositive = [Check.equivalent, Check.isWholePositiveNumber]
checks = [Check.equivalent, Check.isWholeNumber]

getNumbers = (level) ->
  switch level
    when 1
      rnd.intsPlus 9
    when 2
      rnd.intsPlus 19
    when 3
      rnd.intsPlus 59
    when 4
      rnd.intsPlus 99
    when 5
      rnd.intsPlus 999
    else
      rnd.intsPlus 9999

exports.strichrechnungGenerator = generator =
  additionNatural : (level = 1, language="de") ->
    [a,b] = getNumbers level
    #return
    problem : "#{a}+#{b}"
    description : "Addiere die zwei Ganzen Zahlen:"
    checks : checksPositive
  subtraktionNatural : (level = 1, language="de") ->
    [a,b] = getNumbers level
    if b > a then [a, b] = [b, a]
    #return
    problem : "#{a}-#{b}"
    description :
      switch language
        when "de" then "Subtrahiere die zwei Ganzen Zahlen:"
        else "Subtract the two integers:"
    checks : checksPositive
  strichGanzzahlig : (level = 1, language="de") ->
    [a, b] = getNumbers level
    [op1, op2, op3] = rnd.opsStrich()
    problem = "(#{op1}#{a})#{op2}(#{op3}#{b})"
    #return
    problem : problem
    problemTeX : problem
    description :
      switch language
        when "de" then "Berechne:"
        else "Calculate:"
    checks : checks

exports.strichrechnungGanzzahlig =
  title :
    de : "Strichrechnung mit Natürlichen Zahlen"
    en : "Sums adn Differences of Natural Numbers"
  description :
    de : "Plus und Minus ohne Komma"
    en : "Plus and Minus, but no Commas yet"
  problems : [
    levels : [1..7]
    generator : generator.additionNatural
  ,
    levels : [2..7]
    levelOffset : -1
    generator : generator.subtraktionNatural
  ]

exports.strichrechnungRational =
  title :
    de : "Strichrechung mit Rationalen Zahlen"
    en : "Sums and Numbers of Rational Numbers"
  description :
    de : "Plus und Minus mit (möglicherweise) negativem Ergebnis"
    en : "+++"
  problems : [
    levels : [1..6]
    generator : generator.strichGanzzahlig
  ]
