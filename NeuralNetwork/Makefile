all:
	arm-linux-gnueabihf-gcc -Dsoc_cv_av -O2 -o neuralNetworkInt neuralNetworkInt.c
	arm-linux-gnueabihf-strip -s neuralNetworkInt

clean:
	rm -rf neuralNetworkInt