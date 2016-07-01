import std.algorithm.iteration;
import std.algorithm.mutation;
import std.conv;
import std.getopt;
import std.range;
import std.range.primitives;
import std.stdio;

int main(string[] args) {
	size_t numLines = 1;
	auto helpInfo = getopt(
		args,
		std.getopt.config.passThrough,
		"n|count", "Number of lines to pick", &numLines,
	);

	if (args.length != 2 || numLines < 0) {
		usage(args[0], helpInfo);
		return 1;
	}

	long lineStart = to!long(args[1]);
	if (lineStart < 0) {
		stdin
			.byLine
			.takeLast(-lineStart)
			.take(numLines)
			.each!writeln;
	} else {
		stdin
			.byLine
			.drop(lineStart - 1)
			.take(numLines)
			.each!writeln;
	}
	return 0;
}

void usage(string name, GetoptResult helpInfo) {
	writefln("usage: %s [flags] lineNumber", name);
	writeln();
	defaultGetoptPrinter("Flags:", helpInfo.options);
}

char[][] takeLast(Range)(Range r, size_t n) {
	auto lastN = new char[][n];
	size_t index = 0;
	size_t count = 0;
	foreach (t; r) {
		lastN[index] = t;
		index = (index + 1) % n;
		count++;
	}

	if (count <= n) {
		return lastN[0..n];
	} else {
		auto ret = new char[][n];
		copy(lastN[0..index], copy(lastN[index..$], ret));
		return ret;
	}
}
