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
        when "de" then "Multipliziere die zwei Ganzen Zahlen:"
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
        when "de" then "Teile durch die Ganze Zahl:"
        else "Do the division:"
    checks : checks

exports.einXeins =
  title :
    de : "1 x 1"
    en : "Basics of Multiplication and Division"
  description :
    de : "Multiplikation und Division mit Ganzen Zahlen"
    en : "Multiplication and Division with Integers"
  problems : [
    levels : [1..5]
    generator : einXeinsGenerator.multiplikation
  ,
    levels : [2..5]
    levelOffset : -1
    generator : einXeinsGenerator.division
  ]
