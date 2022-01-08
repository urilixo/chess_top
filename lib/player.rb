class Player
  def initialize(color, player_name = nil)
    @player_name = player_name unless player_name.nil?
    new_name if player_name.nil?
    @color = color
  end
end