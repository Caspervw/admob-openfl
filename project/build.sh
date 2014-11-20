echo "Removing old libs / objs"
sudo rm -rf "obj"
sudo rm -rf "../ndll/iPhone/libadmob*"
echo "compiling for armv6"
sudo haxelib run hxcpp Build.xml -Diphoneos
echo "compiling for armv7"
sudo haxelib run hxcpp Build.xml -Diphoneos -DHXCPP_ARMV7
echo "compiling for simulator"
sudo haxelib run hxcpp Build.xml -Diphonesim
echo "============================="
echo "|           Done !          |"
echo "============================="
sudo rm -rf "obj"