def main(args):


    parameters = dict(
        coverage=args.gene_coverage,
        identity_16s_alignment=args.bowtie_16s_identity,
        skip_trimmomatic=args.skip_trimmomatic,
        skip_normalize_16=args.skip_normalize_16
    )
    if(parameters['parameters']['skip_trimmomatic']):
        print(11111111)
    print(parameters['parameters']['skip_trimmomatic'])