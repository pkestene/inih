To build INIReaderExample.cpp, assuming inih has been installed
in INIH_ROOT, all you need to do is:


```shell
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:INIH_ROOT
mkdir build; cd build
cmake ..
make
````

Then run example:
```shell
./INIReaderExample
```

