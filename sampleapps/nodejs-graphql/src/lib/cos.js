import axios from 'axios';
import { hostname } from "os";

const getEndpoints = (url, type) => {
  return new Promise( function(resolve, reject) {
      axios.get(url, {
        validateStatus: (status) => {
          return status >= 200 && status < 300;
        }
      })
      .then(res => {
        resolve(res.data);
      })
      .catch(function (error) {
        if (error.response) {
          // The request was made and the server responded with a status code that falls out of the range of 2xx
          reject(`Received ${error.response.status} : ${error.response.statusText} calling url: ${error.config.url}`);
        } else if (error.request) {
          // The request was made but no response was received `error.request` is an instance of http.ClientRequest
          reject(`Error ${error.message} in request calling url: ${error.config.url}`);
        } else {
          // Something happened in setting up the request that triggered an Error
          reject(`Error ${error.message} in request calling url: ${error.config.url}`);
        }
      });
  });
};

const getItemsFromBucket = (cos, bucketName) => {
  return new Promise( function(resolve, reject) {
    cos.listObjects(
      {Bucket: bucketName},
    ).promise()
    .then(data => {
      resolve(data);
    })
    .catch(function (error) {
        reject(`Received an error ${error.code} - ${error.message}`);
    });
  });
};

const updateItemsInBucket = async (cos, bucketName) => {
  const data = await cos.listObjects(
    {Bucket: bucketName},
  ).promise();

  if (data.Contents.length > 0) {
    for (let i = 0; i < data.Contents.length; i++) {
      let key = data.Contents[i].Key;
      const item = await cos.getObject({
        Bucket: bucketName, 
        Key: key, 
      }).promise();

      await cos.putObject({
        Bucket: bucketName, 
        Key: key, 
        Body: `${item.Body}\nThis line is added by ${hostname} at ${Date.now()}.`
      }).promise();
    }
  }
};

export {
  getEndpoints,
  getItemsFromBucket,
  updateItemsInBucket
}