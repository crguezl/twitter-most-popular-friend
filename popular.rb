# -*- coding: utf-8 -*-
require 'twitter'
require './configure'

screen_name = ARGV[0] || 'timoreilly'
#crondinosaurio no funciona, pues está protegido. Por ello usamos timoreilly.

screen_number = ARGV[1] || 3
screen_number = screen_number.to_i

amigos = Hash.new

client = my_twitter_client() 
#Guardo los ids de mis amigos

seguidores = client.friend_ids(screen_name).attrs[:ids]
#p seguidores


#Buscar el nombre de mi amigo y relacionarlo con el numero de seguidores en el hash de amigos
n = screen_number - 1
#Hacemos un for en vez de un each, pues se producen fallos con más de 200 peticiones sin estar registrado en Twitter o 350 estando registrado
#Si excedemos el número máximo de peticiones, debemos esperar 15min para volver a ejecutar la aplicación

#seguidores.each{ |id|
for i in (0..seguidores.length)
	#Solo muestro los primeros usuarios sin sobrepasar el limite de peticiones
	if (i < 90) 
		id = seguidores[i]
		amigos[client.user(id).name] = client.user(id).followers_count
	end
end
#}

#ordenar amigos por mayor número de seguidores
#mostrar los amigos con más popularidad
#amigos.each{|key, value| puts"#{key} tiene #{value} seguidores"}
for i in (0..n)
	a = i+1
	puts "#{a}.- #{amigos.key(amigos.values.sort.reverse[i])}  #{amigos.values.sort.reverse[i]} seguidores  " 
end
