import os
import boto3
import urllib3
from flask import Flask, render_template, request, redirect, send_file, url_for
from werkzeug.utils import secure_filename

app = Flask(__name__)

@app.route('/')
def entry_point():
    contents = list_files(s3, BUCKET)
    return render_template('index.html', contents=contents)

@app.route("/upload", methods=['POST'])
def upload():
    if request.method == "POST":
        f = request.files['file']
        sfname = os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename));
        f.save(sfname)
        upload_file(s3, sfname, BUCKET)

        return redirect("/")

@app.route("/download/<filename>", methods=['GET'])
def download(filename):
    if request.method == 'GET':
        sfname = os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(filename));
        output = s3.download_file(BUCKET, sfname, sfname)

        return send_file(sfname)

def upload_file(s3,file_name, bucket):
    """
    Function to upload a file to an S3 bucket
    """
    object_name = file_name
    response = s3.upload_file(file_name, bucket, object_name)

    return response


def download_file(s3, file_name, bucket):
    """
    Function to download a given file from an S3 bucket
    """
    output = "downloads/{file_name}"
    s3.Bucket(bucket).download_file(file_name, output)

    return output


def list_files(s3, bucket):
    """
    Function to list files in a given S3 bucket
    """
    contents = []
    signed_url = {}
    try:
        for item in s3.list_objects(Bucket=bucket)['Contents']:
            object_key = item['Key']
            response = s3.generate_presigned_url('get_object',
                                                    Params={'Bucket': bucket,
                                                            'Key': object_key},
                                                    ExpiresIn=3600)
            signed_url = {'url': response, 'name': object_key, 'path': os.path.basename(object_key)}
            #signed_url.update(signed_url)
            #print(response)
            contents.append(signed_url)
            
    except Exception as e:
        pass
    return contents

if __name__ == '__main__':
    urllib3.disable_warnings()
    UPLOAD_FOLDER = '/tmp'
    app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
    BUCKET = os.environ['BUCKET_NAME']
    s3 = boto3.client('s3',
        endpoint_url = os.environ['ENDPOINT_URL'],
        aws_access_key_id = os.environ['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key = os.environ['AWS_SECRET_ACCESS_KEY'],
        use_ssl=False,
        verify=False
        )
    
    app.static_folder = 'static'    
    app.run(host='0.0.0.0', port=8081, debug=True)

