echo "# FILE data.s"		>	./build/merged-file.s
cat ./src/data.s		>>	./build/merged-file.s
echo "# FILE $1.s"		>>	./build/merged-file.s
cat "./src/$1.s" 		>>	./build/merged-file.s
echo "# FILE rpnparser.s"       >>      ./build/merged-file.s
cat ./src/rpnparser.s           >>      ./build/merged-file.s
echo "# FILE shuntingyard.s"	>>	./build/merged-file.s
cat ./src/shuntingyard.s	>>	./build/merged-file.s
echo "# FILE token.s"		>>	./build/merged-file.s
cat ./src/token.s		>>	./build/merged-file.s
echo "# FILE deque.s"		>>	./build/merged-file.s
cat ./src/deque.s 		>>	./build/merged-file.s
