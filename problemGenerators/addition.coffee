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
      rnd.intsMin 11, 59
    when 4
      rnd.intsMin 11, 99
    when 5
      rnd.intsMin 101, 999
    else
      rnd.intsMin 1001, 9999

exports.strichrechnungGenerator = generator =
  additionNatural : (level = 1, language="de") ->
    [a,b] = getNumbers level
    #return
    problem : "#{a}+#{b}"
    description : switch language
      when "de" then "Addiere die zwei Natürlichen Zahlen:"
      else "Add the two natural numbers:"
    checks : checksPositive

  subtraktionNatural : (level = 1, language="de") ->
    [a,b] = getNumbers level
    if b > a then [a, b] = [b, a]
    #return
    problem : "#{a}-#{b}"
    description :
      switch language
        when "de" then "Subtrahiere die zwei Natürlichen Zahlen:"
        else "Subtract the two natural numbers:"
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
    en : "Sums and Differences of Natural Numbers"
  description :
    de : "Plus und Minus ohne Komma"
    en : "Plus and Minus, but no decimal point (yet)"
  problems : [
    levels : [1..6]
    generator : generator.additionNatural
  ,
    levels : [1..6]
    generator : generator.subtraktionNatural
  ]

exports.strichrechnungRational =
  title :
    de : "Strichrechung mit Ganzen Zahlen"
    en : "Sums and Differences of Integers"
  description :
    de : "Plus und Minus mit (möglicherweise) negativem Ergebnis"
    en : "Plus and Minus with (possibly) Negative Results"
  problems : [
    levels : [1..6]
    generator : generator.strichGanzzahlig
  ]
