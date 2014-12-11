# OligoCalc

**Jason Gilliland, Reham Garash, Sarah Sivilich**

This project is meant to be used to design primers for quantitative
polymerase chain reaction (qPCR) experiments.
Given a sequence for a transcript (mRNA), the location in that sequence
of an exon junction, and a few optional arguments, OligoCalc can yield a
list of potentially suitable primer pairs based on criteria such as melting
point, dimerization, hairpinning, etc.
The primer selection functionality is available either through a GUI or
through a plain Matlab function.
The GUI requires you to either paste in a sequence or upload one from a
FASTA formatted file, and then configure various options (sensible defaults
are built in).
The selected primers are then displayed in the GUI as a table, and
optionally output to a FASTA formatted file that lists each primer, the
number of the pair to which it belonged, and the pair score (like golf,
higher is worse).
The plain Matlab function to use to get this functionality is
``select_primers``.
This function takes as arguments the sequence, and a structure with several
optional fields.
The only mandatory field is ``opts.exonjunction``.

This project has no external dependencies other than a working version of
Matlab, and is thus completely cross-platform.
