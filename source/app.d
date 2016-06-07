import std.conv;
import std.range;
import std.range.primitives;
import std.stdio;

int main(string[] args) {
	if (args.length != 2) {
		usage(args[0]);
		return 1;
	}

	size_t line_number = to!size_t(args[1]);
	stdin.byLine
		.drop(line_number - 1)
		.front
		.writeln();
	return 0;
}

void usage(string name) {
	writefln("usage: %s line_number", name);
}
