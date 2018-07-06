# Slappy Examples
require 'net/http'

# called when start up
hello do
  puts 'successfly connected'
end


# called when match message
hear 'foo' do
  puts 'foo'
end


# # use regexp in string literal
# hear 'bar (.*)' do |event|
#   puts event.matches[1] #=> Event#matches return MatchData object
# end


# event object is slack event JSON (convert to Hashie::Mash)
hear '^slappy (.*)' do |event|
  next unless event.channel.name == '#devops'
  args = event.matches[1].split()
  message = "hoge"
  case args[0]
  when "build" then
    message = "しょうがねぇなあ"
    Net::HTTP.get_print(URI.parse('http://tocomi-ubuntu:10000/job/checkout-source/build'))
  else
    puts event.user.name
    if event.user.name == '@tocomi' then
      message = "<@tocomi> いまいそがしい"
    else
      message = "ういー"
    end
  end
  say message, channel: event.channel, icon_emoji: ':slappy:'
end


# # use regexp literal
# hear /^foobar/ do
#   say 'slappppy!'
# end
