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
end