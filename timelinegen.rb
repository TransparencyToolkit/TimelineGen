require 'json'

class TimelineGen

  # Change date format to work with TimelineJS
  def self.parseDate(date)
    if date != nil
      date.gsub!("-",",")
      date.gsub!(" ",",")
      date.gsub!(":",",")
    end
    date
  end
  
  # Generate JSON for event
  def self.genEvent(startDate, endDate, headline, text)
    JSON.pretty_generate(
                         "startDate" => parseDate(startDate),
                         "endDate" => parseDate(endDate),
                         "headline" => headline,
                         "text" => text
                        )
  end


  # Generate JSON for timeline
  def self.parseEvents(file)
    pe = JSON.parse(File.read(file))
    k = pe.length-1
    event = Array.new
    (0..k).each do |i|
      event[i] = JSON.parse(
                            genEvent(
                                     (pe[i])["date"], 
                                     nil, 
                                     (pe[i])["subject"], 
                                     (pe[i])["body"]
                                     )
                            )
    end
    return event
  end
    
  def self.genTimeline(event)
    JSON.pretty_generate(
                         "timeline" => {
                           "headline" => "timeline name",
                           "type" => "default",
                           "text" => "text goes here",
                           "date" => event
                         }
                       )
  end

  puts genTimeline(parseEvents("test.json"))
end
