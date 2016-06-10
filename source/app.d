import std.algorithm.iteration;
import std.conv;
import std.getopt;
import std.range;
import std.range.primitives;
import std.stdio;

int main(string[] args) {
	size_t numLines = 1;
	auto helpInfo = getopt(
		args,
		"n", "Number of lines to pick", &numLines,
	);

	if (args.length != 2 || numLines < 0) {
		usage(args[0], helpInfo);
		return 1;
	}

	size_t lineNumber = to!size_t(args[1]);
	stdin.byLine
		.drop(lineNumber - 1)
		.take(numLines)
		.each!writeln;
	return 0;
}

void usage(string name, GetoptResult helpInfo) {
	writefln("usage: %s [flags] lineNumber", name);
	writeln();
	defaultGetoptPrinter("Flags:", helpInfo.options);
}
