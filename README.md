Profiler for the second IVS project for academic year 2022/2023
===

A program meant to profile the performance of our 
[math library](https://github.com/Zeftax/ivs2-mathlib). <br>
Part of the second IVS project for the academic year 2022/2023 at BUT FIT.

Installing
---
#### Compiling from source
**Note: You must install the math library first in the same parent directory!**
```sh
git clone https://github.com/Zeftax/ivs2-profiler
cd ivs2-profiler && make
```
The program will install to the repo directory. <br>
If you wish to install it elsewhere, set `-DCMAKE_INSTALL_PREFIX:PATH` to your 
desired destination or use the method below for system-wide installation.

#### Using a deb package
If you're on a debian based system, you can use a .deb package provided in 
releases. <br>
Right click the package and install it using the Ubuntu Software Centre or via
terminal:
```sh
sudo dpkg -i <package_name.deb>
```

Usage
---
The program itself calculates standard deviation from numbers (doubles) sent to STDIN.
```sh
stddev
```
or
```sh
stddev < data.txt
```
If you wish to get the profiler results, you must [compile from source](#compiling-from-source)
and generate a report using:
```sh
make eval
```
in the project root directory. <br>
The `report.png` file will be located in the `_build` directory.

License
---
Copyright (C) <2023>  <xborov08, xkrejc84, xlozrt00, xmitre07>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
