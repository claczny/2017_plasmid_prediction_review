SHELL = /bin/bash

RDIR = results

SAMPLES_GRAM_NEG = XXX

SOFTWARE_DIR = /home/cedric/apps/software
CD_HIT_EST_BIN = $(SOFTWARE_DIR)/cd-hit-v4.6.6-2016-0711/cd-hit-est

.PHONY: all

all: $(addprefix $(RDIR)/cd-hit-est/, $(SAMPLES_GRAM_NEG:=/pooled_candidate_plasmid_contigs.cd-hit-est.fasta))

#####
# CD-HIT-EST
#####
# Pool the individual predictions
$(RDIR)/cd-hit-est/%/pooled_candidate_plasmid_contigs.fasta: $(RDIR)/cbar/%/contigs.cbar.fasta $(RDIR)/recycler/%/assembly_graph.cycs.fasta $(RDIR)/plasmidfinder/%/contigs.enterobacteriaceae.fasta $(RDIR)/plasmidspades55/%/contigs.fasta
    @echo "###### POOLING CANDIDATE PLASMIDS - $* ######"
    @date
    mkdir -p $(dir $@)
    cat \
    <(sed '/^>/s/^>/>cbar|/' $(word 1, $^)) \
    <(sed '/^>/s/^>/>recycler|/' $(word 2, $^)) \
    <(sed '/^>/s/^>/>plasmidfinder|/' $(word 3, $^)) \
    <(sed '/^>/s/^>/>plasmidspades|/' $(word 4, $^)) > $@
    @date
    @echo "##########"
    @echo

# Cluster the pooled predictions
$(RDIR)/cd-hit-est/%/pooled_candidate_plasmid_contigs.cd-hit-est.fasta: $(RDIR)/cd-hit-est/%/pooled_candidate_plasmid_contigs.fasta
    @echo "###### RUNNING CD-HIT-EST ON POOLED PREDICTIONS - $* ######"
    @date
    (date && \
    $(CD_HIT_EST_BIN) -i $^ -o $@ && \
    date) 2>$(dir $@)/cd-hit-est.stderr 1>$(dir $@)/cd-hit-est.stdout
    @date
    @echo "######"
    @echo
