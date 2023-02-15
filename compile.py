import subprocess
import sys, os


def pad(msg: str, to: int) -> str:
	return f"{msg}{' ' * (to - len(msg))}"


def cd(base: str, *dirs: str) -> str:
	for dir in dirs: base = os.path.join(base, dir)
	return base


if __name__ == "__main__":
	if "-help" in sys.argv:
		print(
			"required option: *",
			"n args required: (n)\n",
			f"{pad('[-help]', 20)}=> print this message",
			f"{pad('[-verbose, -v]', 20)}=> show all commands as they are ran",
			sep="\n", end="\n\n"
		)
	verbose = "-verbose" in sys.argv or "-v" in sys.argv
	
	root_folder = os.path.dirname(os.path.realpath(__file__))
	if root_folder == os.getcwd(): root_folder = ""
	src_folder = cd(root_folder, "src")
	inc_folder = cd(root_folder, "inc")
	int_folder = cd(root_folder, "int")
	bin_folder = cd(root_folder, "bin")
	static_folder = cd(bin_folder, "static")
	
	if not os.path.exists(src_folder): print("no 'src' folder"); exit(-1)
	if not os.path.exists(inc_folder): print("no 'inc' folder"); exit(-1)
	if not os.path.exists(int_folder): os.mkdir(int_folder)
	if not os.path.exists(bin_folder): os.mkdir(bin_folder)
	if not os.path.exists(static_folder): os.mkdir(static_folder)
	
	commands = [
		# math.h
		["nasm", "-f", "elf64", "-o", cd(int_folder, "arithmetic.o"), cd(src_folder, "arithmetic.asm")],
		["nasm", "-f", "elf64", "-o", cd(int_folder, "trig.o"), cd(src_folder, "trig.asm")],
		["nasm", "-f", "elf64", "-o", cd(int_folder, "exp.o"), cd(src_folder, "exp.asm")],
		[   # linking to math.h equivalent object
			"ld", "--relocatable", "-o", cd(static_folder, "math.o"),
			cd(int_folder, "arithmetic.o"),
			cd(int_folder, "trig.o"),
			cd(int_folder, "exp.o")
		],
		
		[   # linking to shared object
			"ld", "--shared", "-o", cd(bin_folder, "stdlib.so"),
			cd(static_folder, "math.o")    # math.h equivalent object
		]
	]

	for command in commands:
		if verbose: print(*command, end=" => ")
		code, msg = subprocess.getstatusoutput(' '.join(command))
		if verbose: print(f"code {code}:", msg, sep="\n" if msg else "", end="\n\n" if msg else "\n")
		elif code: print(f"{' '.join(command)} returned with code {code}:", msg, sep="\n" if msg else "", end="\n\n" if msg else "\n")

# TODO: add verbose flag to compile array
