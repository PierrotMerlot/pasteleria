pasteleria : auxiliar.adb auxiliar.ads pasteleria.adb
	gnatmake pasteleria.adb

clean :
	rm -f *.ali *.o pasteleria
