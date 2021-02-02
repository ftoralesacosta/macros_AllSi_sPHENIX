source /global/project/projectdirs/alice/ftorales/Singularity/cvmfs/sphenix.sdcc.bnl.gov/gcc-8.3/opt/sphenix/core/bin/sphenix_setup.sh
export INST="/global/project/projectdirs/alice/ftorales/Singularity/install" 
source /global/project/projectdirs/alice/ftorales/Singularity/cvmfs/sphenix.sdcc.bnl.gov/gcc-8.3/opt/sphenix/core/bin/setup_local.sh $INST
source /project/projectdirs/alice/ftorales/Singularity/set_g4.sh

#Quality of life aliases
alias rth="ls -lrth"
alias ebp="vim /global/project/projectdirs/alice/ftorales/Singularity/.profile"
alias sbp="source /global/project/projectdirs/alice/ftorales/Singularity/.profile"
alias r="root -b"
alias rfe="r Fun4All_G4_EICDetector.C\(10\)"
alias agen="/global/project/projectdirs/alice/ftorales/Singularity/tutorials/myjetanalysis/src/autogen.sh --prefix=$INST" 
alias agen_si="/global/project/projectdirs/alice/ftorales/Singularity/fernando_lblvtx/macros/AllSi_src/autogen.sh --prefix=$INST"
alias agen_ejet="/project/projectdirs/alice/ftorales/Singularity/e_Jet_sPHENIX/myjetanalysis/src/autogen.sh --prefix=$INST"
alias agen_g4="/global/project/projectdirs/alice/ftorales/Singularity/coresoftware/simulation/g4simulation/g4eval/autogen.sh --prefix=$INST"
#alias agen="/global/project/projectdirs/alice/ftorales/Singularity/e_Jet_sPHENIX/myjetanalysis/src/autogen.sh --prefix=$INST" 
