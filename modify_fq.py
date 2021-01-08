import gzip
from argparse import ArgumentParser

## update the fastq 
def update_fastq(r1, out_r1 ): 


    f_r1 = gzip.open(r1, 'rt')
    f_out_r1 = open(out_r1, 'w')

    while True:
        cur_r1_name = f_r1.readline()
        cur_r1_read = f_r1.readline().strip()
        cur_r1_plus = f_r1.readline()
        cur_r1_qual = f_r1.readline().strip()

        if cur_r1_name == "" : break

        cur_r1_read = cur_r1_read[:100]+cur_r1_read[110:118] # modify based on library structure 
        cur_r1_qual = cur_r1_qual[:100]+cur_r1_qual[110:118]
        cur_r1_name = cur_r1_name.replace("/2","/1")
        f_out_r1.write(cur_r1_name)
        f_out_r1.write(cur_r1_read+"\n")
        f_out_r1.write(cur_r1_plus)
        f_out_r1.write(cur_r1_qual+"\n")
    f_r1.close()
    f_out_r1.close()

def main():
    parser = ArgumentParser(description='provide fastq and new files')
    parser.add_argument('-r1', help='r1', required=True)
    parser.add_argument('-o',  help='file_name', required=True)
    options = parser.parse_args()
    r1 = options.r1
    out_r1 = options.o

    update_fastq(r1, out_r1)

if __name__== "__main__":
    main()
