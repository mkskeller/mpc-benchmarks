
# download SCALE-MAMBA v1.5
cd 
cd SCALE-MAMBA
git checkout -b v1.8.1 e3488e646ed71e8d3264e2f3fe8e2226d4d503a9
cp /root/source/CONFIG.mine .
patch -p1 < /root/source/bench.patch
make progs

# set up certificate authority
touch ~/.rnd # see: https://github.com/openssl/openssl/issues/7754
SUBJ="/CN=www.example.com"
cd Cert-Store

openssl genrsa -out RootCA.key 4096
openssl req -new -x509 -days 1826 -key RootCA.key \
           -subj $SUBJ -out RootCA.crt

# make 4 certificates. More can be added as necessary
mkdir csr
for ID in {0..3}
do
  SUBJ="/CN=P$ID"
  openssl genrsa -out Player$ID.key 2048
  openssl req -new -key Player$ID.key -subj $SUBJ -out csr/Player$ID.csr
  openssl x509 -req -days 1000 -set_serial 101$ID \
    -CA RootCA.crt -CAkey RootCA.key \
    -in csr/Player$ID.csr -out Player$ID.crt 
done

# copy examples to correct locations
cd /root/SCALE-MAMBA
for EX in mult3 innerprod xtabs
do
  mkdir Programs/$EX
  cp /root/source/$EX.mpc Programs/$EX/
done

# add simple syntax highlighting
cd
mkdir -p .vim/syntax
mv source/mamba.vim .vim/syntax
mkdir .vim/ftdetect
echo "au BufNewFile,BufRead *.mpc set filetype=mamba" > .vim/ftdetect/mamba.vim

cd ~/SCALE-MAMBA
cp -av Auto-Test-Data/1/* Data
./compile-old.sh Programs/innerprod
