require 'nokogiri'
require 'open-uri'
require 'pry'
# require 'nokogiri'
# require 'open-uri'
# def remove_numbers_from(name)
#     name.scan(/[a-zA-Z ]+/)[0].rstrip
# end

# parsed_csv = File.open('1-premierleague.csv').readlines.map{|line| line.split(',')}
# parsed_csv.shift

# parsed_csv.each do |line| 

#     home_team = Team.find_or_create_by(name: remove_numbers_from(line[2]))
#     away_team = Team.find_or_create_by(name: remove_numbers_from(line[5]))
#     home_team_score = line[3].split('-')[0].to_i
#     away_team_score = line[3].split('-')[1].to_i
#     # binding.pry
#     Match.create(home_team_id: home_team.id, away_team_id: away_team.id, 
#         home_team_score: home_team_score, away_team_score: away_team_score)
# end

def get_stadium_info
    table = Nokogiri::HTML(open('https://en.wikipedia.org/wiki/2016%E2%80%9317_Premier_League#Stadia_and_locations')).css('#mw-content-text > div > table:nth-child(25)')

    array = []
    table.css('tr').each do |row| 
        obj = {} 
        obj[:team_name] = row.children[1].text[0..-2]
        obj[:location] = row.children[3].text[0..-2]
        obj[:name] = row.children[5].text[0..-2]
        obj[:capacity] = row.children[7].text[0..-2]
        array << obj
    end
    array.shift
    array 
end

get_stadium_info.each do |stadium|
    Stadium.create(name: stadium[:name], team_id: Team.find_by("name like ?", "%#{stadium[:team_name]}%").id, location: stadium[:location], capacity: stadium[:capacity])
end
