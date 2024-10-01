#!/bin/bash

# Replace tempdir and its contents if it exists
if [ -d "tempdir" ]; then
    rm -rf tempdir
fi
mkdir tempdir

# Replace tempdir/templates if it exists
if [ -d "tempdir/templates" ]; then
    rm -rf tempdir/templates
fi
mkdir tempdir/templates

# Replace tempdir/static if it exists
if [ -d "tempdir/static" ]; then
    rm -rf tempdir/static
fi
mkdir tempdir/static


cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python /home/myapp/sample_app.py" >> tempdir/Dockerfile

cd tempdir
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
