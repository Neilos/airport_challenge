class Plane
  attr_accessor :status
  private :status=

  FLYING = :flying
  LANDED = :landed

  def initialize
    @status = FLYING
  end

  def take_off!; self.status = FLYING; end
  def land!; self.status = LANDED; end

  def landed?; self.status == LANDED; end
  # def flying?; status == :flying; end
end