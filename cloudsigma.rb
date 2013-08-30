require 'rubygems'
require 'serialport'
require 'json'

# Open the serial port
sp = SerialPort.new "/dev/ttyS1"

# Trigger read from the serial port
sp.write "<\n\n>"

# Parse the output as JSON
jsonify = JSON.parse(sp.readline())

$core_values = ['vnc_password', 'name', 'cpu', 'mem', 'enable_numa', 'smp', 'cpus_instead_of_cores', 'uuid', 'vlan', 'tags']

def set_fact(value, key)
  Facter.add(value) do
    setcode do
      key
    end
  end
end

# Set the facts as cs_<key>
for i in $core_values
  $value_name = 'cs_' + i
  set_fact($value_name, jsonify[i])
end

# Close the serial port
sp.close
