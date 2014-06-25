require 'stringio'
require 'sinatra'
require 'mios'

class Mios < Sinatra::Base
  def self.silence_warnings
    old_stderr = $stderr
    $stderr = StringIO.new
    yield
  ensure
    $stderr = old_stderr
  end

  mios = nil
  
  silence_warnings do 
  	mios = MiOS::Interface.new('http://10.0.1.3:3480')
  end

  get '/lights/:name/:mode' do
    name = params[:name]
    mode = params[:mode]
    # depending on how you name your devices in VeraLite, you may want to update the next line
    # Here I'm taking the passed name of "master bedroom" and changing it to "Master Bedroom Lights"
    device = mios.devices.find {|d| d.name == name.split.map(&:capitalize).join(' ') + " Lights"}
    if mode == "on"
      device.on! { |obj| 
        return "#{obj.name} is being turned on."
      }
    elsif mode == "off"
      device.off! { |obj| 
        return "#{obj.name} is being turned off."
      }
    end
  end
end
