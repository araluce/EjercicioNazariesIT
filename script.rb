
require 'open-uri'
require 'nokogiri'
require 'json'

def true_o_false(elemento)
	if elemento.css('span').text.downcase == "yes"
		return true
   	end
   	return false
end

# Obtenemos la pagina a escrapear
pagina = Nokogiri::HTML(open("https://www.port-monitor.com/plans-and-pricing"))
# Obtenemos los elementos que contienen las entradas que se nos pide analizar
productos = pagina.css('.product')

resultado = [];
productos.each do |producto|
	dd = producto.css('.thin').css('dd')
	foo = {
	  'monitors' => producto.css('h2').text,
	  'check_rate' => dd[0].text.delete('^0-9'),
	  'history' => dd[1].text.delete('^0-9'),
	  'multiple_notifications' => true_o_false(dd[2]),
	  'push_notifications' => true_o_false(dd[3]),
	  'price' => producto.css('a')[2].text.delete('^.0-9')
	}
	resultado << foo
end
puts JSON[resultado]