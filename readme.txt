xlate.rb - Translate the XML output of KeyPassX into a CSV file to import to
Password Dragon http://www.passworddragon.com/

CSV format is
account_name,user_id,password,url,notes,category,attribute 1,attribute 2,attribute 3,attribute 4,attribute 5,attribute 6,attribute 7,attribute 8,attribute 9,attribute 10

Ruby Gem Nokogiri is used to traverse the XML input.

env.sh sets up the PATH environment variable to get my local JRuby to run.

I ran TagSoup on the KeyPassX XML to have it be correct XML for Nokogiri
import

http://ccil.org/~cowan/XML/tagsoup/

