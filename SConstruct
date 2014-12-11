import os
import re

env=Environment()
reg_matlab = re.compile(r'.*(\.m|\.fig)')
mfiles = [fname for fname in os.listdir('.') if reg_matlab.match(fname)]
print(mfiles)
mfiles.append('homer1a.fasta')
mfiles.append('README.md')
archive_fname = 'src.zip'
archive = env.Zip(archive_fname, mfiles)
dropbox_root = '/home/jdag/dropbox/bmes546.20141/Reham.Sarah.Jason.Oligo'
dropbox_src = os.path.join(dropbox_root, 'src')
install_dropbox = env.Install(
        dropbox_src,
        mfiles,
        )
install_archive = env.Install(
        dropbox_root,
        archive_fname,
        )
Default([install_dropbox, install_archive])
env.Alias('install', [install_dropbox, install_archive])
