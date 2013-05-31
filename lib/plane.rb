
class Plane

attr_reader :status

def initialize
  self.take_off!
end

def take_off!
  @status = :flying
end

def land!
  @status = :landed
end


def landed?
  self.status == :landed
end

def flying?
  self.status == :flying
end


end