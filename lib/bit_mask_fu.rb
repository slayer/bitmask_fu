module BitMaskFu

  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods
    def bitmask attribute, values
      define_method attribute do
        values.reject { |f| ((self[attribute] || 0) & 2**values.index(f)).zero? }
      end

      define_method "#{attribute.to_s}=" do |value|
        self.send "[]=", attribute, (value & values).map { |f| 2**values.index(f) }.sum
      end

      values.each do |f|
        # getter
        define_method("#{f.to_s}?") do
          self.send(attribute).include? f
        end
        # setter
        define_method("#{f.to_s}=") do |val|
          cur = self.send(attribute)
          self.send("#{attribute}=", val ? cur + [f] : cur - [f])
        end
      end
    end
  end

end


