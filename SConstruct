import os
import re

env=Environment()
reg_matlab = re.compile(r'.*(\.m|\.fig)')
mfiles = [fname for fname in os.listdir('.') if reg_matlab.match(fname)]
print(mfiles)
mfiles.append('homer1a.fasta')
dropbox_dir = '/home/jdag/dropbox/bmes546.20141/Reham.Sarah.Danial.Oligo/src'
install_dropbox = env.Install(
    dropbox_dir,
    mfiles,
    )
Default(install_dropbox)
env.Alias('install', install_dropbox)
