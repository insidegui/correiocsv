#!/usr/bin/env ruby

# CORREIOCSV
# Criado por Guilherme Rambo
# blog.guilhermerambo.com.br

require 'rubygems'
require 'nokogiri'
require 'open-uri'

if ARGV.count < 1
  puts "\nComo usar:\ncorreiocsv [codigo]\n\n"
  puts "Exemplo:\ncorreiocsv CP912406317HK"
  puts "Exemplo - Gravar num arquivo:"
  puts "correiocsv CP912406317HK > teste.csv\n\n"
  exit
end

url = "http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI="+ARGV[0]
doc = Nokogiri::HTML(open(url))

csv = ""
doc.css("tr").each do |row|
  row.css("td").each do |cell|
    if cell[:colspan] != "2"
      csv += cell.text+","
    end
  end
  csv += "\n"
end

puts csv