require "rubygems"
require "bundler/setup"

require "nokogiri"
require 'pp'

def clean_notes(a_notes)
  notes = a_notes.encode('UTF-8')
  notes.gsub!('"',"'")
  notes.gsub!(',',';')
  notes.gsub!("\n",'<nl>')
  notes.gsub!("\r",'<cr>')
  notes
end
def obfuscate(label)
  $obs_num += 1
  "#{label}_#{$obs_num.to_s * 2}"
end
def traverse_groups(parent_title,node)
  node.children.each do |child|
    if child.is_a?(Nokogiri::XML::Element) && child.name == 'group'
      if parent_title
        group_title = "#{parent_title} - #{child.css('title').first.content}"
      else
        group_title = child.css('title').first.content
      end
      child.children.each do |child|
        if child.is_a?(Nokogiri::XML::Element) && child.name == 'entry'
          entry_title = child.css('title').first.content
          notes = child.css('comment').first.inner_html
          notes.strip!
          if notes.length > 0
            notes = '"' + clean_notes(notes) + '"'
          end
          username = child.css('username').first.content
          password = child.css('password').first.content
          password.strip!
          if password.length > 0
            password = '"' + clean_notes(password) + '"'
          end
          url = child.css('url').first.content

          export = entry_title
          export += ",#{username}"
          export += ",#{password.encode('UTF-8')}"
          export += ",#{url}"
          export += ",#{notes}"
          export += ",#{group_title}"
          puts export
        end
      end
      traverse_groups(group_title,child)
    end
  end
end
doc = Nokogiri::XML(File.open("secret/glop.xml")) do |config|
  config.strict
end
root = doc.root
$obs_num = 0
traverse_groups(nil,doc.root)


