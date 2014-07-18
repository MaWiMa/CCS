#!/usr/bin/ruby
# encoding: utf-8

class Flip
attr_accessor :lang, :page, :thesePageNames, :thisPage, :nextPageNumber, :backPageNumber, :nextPage, :backPage
 def initialize(l,p)
 @lang = l
 @page = p
 @thesePageNames = "-Changing_Canadian_Schools-"
 @thisPageNumber = @page.to_i
 @nextPageNumber = @page.to_i+1
 @backPageNumber = @page.to_i-1
 @thisPage = @lang + @thesePageNames + "%03d" % @thisPageNumber.to_s
 @nextPage = @lang + @thesePageNames + "%03d" % @nextPageNumber.to_s
 @backPage = @lang + @thesePageNames + "%03d" % @backPageNumber.to_s
 end
end
