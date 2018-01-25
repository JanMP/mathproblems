{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

checks = [Check.equivalent, Check.isWholePositiveNumber]

exports.einXeinsGenerator = einXeinsGenerator =
  multiplikation : (level = 1, language="de") ->
    switch level
      when 1
        [a, b] = rnd.ints2Plus 9
      when 2
        a = rnd.int2Plus 9
        b = rnd.intMin 11, 20
        if rnd.bool() then [a, b] = [b, a]
      when 3
        [a, b] = rnd.intsMin 11, 20
      when 4
        a = rnd.intMin 11, 99
        b = rnd.intMin 101, 999
        if rnd.bool() then [a, b] = [b, a]
      else
        [a, b] = rnd.intsMin 101, 999
    #return
    problem : "#{a}*#{b}"
    description :
      switch language
        when "de" then "Multipliziere die zwei Natürlichen Zahlen:"
        else "Multiply the two integers:"
    checks : checks

  division : (level = 1, language="de") ->
    switch level
      when 1
        [a, b] = rnd.ints2Plus 9
      when 2
        a = rnd.int2Plus 9
        b = rnd.intMin 11, 20
        if rnd.bool() then [a, b] = [b, a]
      when 3
        [a, b] = rnd.intsMin 11, 99
      else
        [a, b] = rnd.intsMin 101, 999
    #return
    problem : "#{a}"
    problemTeX : "#{a*b}\\div#{b}"
    description :
      switch language
        when "de" then "Teile durch die Zahl:"
        else "Do the division:"
    checks : checks

exports.punktrechnung =
  title :
    de : "Punktrechnung mit Natürlichen Zahlen"
    en : "Basics of Multiplication and Division"
  description :
    de : "Vermischte Aufgaben zur Multiplikation und Division mit Natürlichen Zahlen"
    en : "Multiplication and Division with Integers"
  problems : [
    levels : [1..5]
    generator : einXeinsGenerator.multiplikation
  ,
    levels : [2..5]
    levelOffset : -1
    generator : einXeinsGenerator.division
  ]

exports.einXeins =
  title :
    de : "1 x 1"
    en : "Basics of Multiplication"
  description :
    de : "Multiplikation mit Natürlichen Zahlen"
    en : "Multiplication with Integers"
  problems : [
    levels : [1..5]
    generator : einXeinsGenerator.multiplikation
  ]

exports.einsDurchEins =
  title :
    de : "1 durch 1"
    en : "Basics of Division"
  description :
    de : "Division mit Natürlichen Zahlen"
    en : "Division with Integers"
  problems : [
    levels : [1..4]
    generator : einXeinsGenerator.division
  ]
