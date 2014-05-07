class Tracker

  def initialize(data)
    @data = data

  end
  def projects
    @data.first["name"]
  end
  def story_name
    @data.first["name"]
  end
  def names
    names = []
    @data.each do |x|
      p x
      names << x["name"]
    end
    names
  end
end