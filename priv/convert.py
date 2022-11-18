from subprocess import Popen

LIBRE_OFFICE = r"/usr/bin/libreoffice"

def convert_to_pdf(input_file, out_folder):
    p = Popen([LIBRE_OFFICE, '--headless', '--convert-to', 'pdf', '--outdir',
               out_folder, input_file])
    print([LIBRE_OFFICE, '--convert-to', 'pdf', input_file])
    p.communicate()

sample_doc = 'test-chart.xlsx'
out_folder = '.'
convert_to_pdf(sample_doc, out_folder)