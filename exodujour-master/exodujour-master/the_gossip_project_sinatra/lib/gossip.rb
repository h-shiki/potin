require "csv"

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    id = id.to_i
    table = CSV.parse(File.read("db/gossip.csv"), headers: false)
    print table
    puts
    # table = CSV.table('db/gossip.csv')
    puts table[id]
    return table[id]
  end

  def self.update(id, author, content)
    id = id.to_i
    id = id - 1
    table = CSV.table("db/gossip.csv")
    table[id][0] = author
    table[id][1] = content
    File.open("db/gossip.csv", "w") do |f|
      f.write(table.to_csv)
    end
  end
end
