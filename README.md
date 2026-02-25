# Getting Started with Create React App

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can't go back!**

If you aren't satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you're on your own.

You don't have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn't feel obligated to use this feature. However we understand that this tool wouldn't be useful if you couldn't customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: [https://facebook.github.io/create-react-app/docs/code-splitting](https://facebook.github.io/create-react-app/docs/code-splitting)

### Analyzing the Bundle Size

This section has moved here: [https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size](https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size)

### Making a Progressive Web App

This section has moved here: [https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app](https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app)

### Advanced Configuration

This section has moved here: [https://facebook.github.io/create-react-app/docs/advanced-configuration](https://facebook.github.io/create-react-app/docs/advanced-configuration)

### Deployment

This section has moved here: [https://facebook.github.io/create-react-app/docs/deployment](https://facebook.github.io/create-react-app/docs/deployment)

### `npm run build` fails to minify

This section has moved here: [https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify](https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify)

End-to-End DevOps Deployment Documentation
Project: Brain-Tasks-App Deployment on AWS EKS using CI/CD
1. Application Overview
Repository: https://github.com/Vennilavan12/Brain-Tasks-App.git
This project demonstrates complete DevOps lifecycle for deploying a React application into a
production-ready Kubernetes cluster using AWS services.
Key Goals:
- Containerize application
- Push image to ECR
- Deploy to AWS EKS
- Build CI/CD using CodePipeline and CodeBuild
- Monitor logs using CloudWatch
2. Clone the Repository
git clone https://github.com/Vennilavan12/Brain-Tasks-App.git
cd Brain-Tasks-App
Install dependencies:
npm install
Run application locally:
npm start
Access via: http://localhost:3000
3. Dockerization
Create Dockerfile:
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
RUN npm install -g serve
CMD ["serve", "-s", "build", "-l", "3000"]
EXPOSE 3000
Build Image:
docker build -t brain-task :latest .
Run Container:
docker run -d -p 3000:3000 brain-tasks-app:latest
4. AWS ECR Setup
Create ECR Repository:
aws ecr create-repository --repository-name brain-tasks-app
Login:
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin
.dkr.ecr.us-east-1.amazonaws.com
Tag and Push:
docker tag brain-tasks-app:latest :latest
docker push :latest
5. EKS Cluster Setup
Create Cluster using eksctl:
eksctl create cluster --name brain-cluster --region ap-south-1
Configure kubeconfig:
aws eks update-kubeconfig --region ap-south-1 --name brain-cluster
Verify:
kubectl get nodes
6. Kubernetes Deployment
deployment.yaml:
apiVersion: apps/v1
kind: Deployment
metadata:
name: brain-app
spec:
replicas: 2
selector:
matchLabels:
app: brain-app
template:
metadata:
labels:
app: brain-app
spec:
containers:
- name: brain-app
image:
ports:
- containerPort: 3000
service.yaml:
apiVersion: v1
kind: Service
metadata:
name: brain-tasks-service
spec:
type: LoadBalancer
selector:
app: brain-tasks
ports:
- protocol: TCP
port: 80
targetPort: 8080
Apply:
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
7. CodeBuild Setup
Create buildspec.yml:
version: 0.2
phases:
pre_build:
commands:
- aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin
build:
commands:
- docker build -t brain-app .
- docker tag brain-tasks-app:latest :latest
post_build:
commands:
- docker push :latest
8. AppSpec for Deployment
Create appspec.yml:
version: 0.0
Resources:
- TargetService:
Type: AWS::EKS::Service
Properties:
TaskDefinition: deployment.yaml
9. Git Version Control
git init
git remote add origin 
git add .
git commit -m "Initial deployment pipeline"
git push -u origin main
10. CodePipeline Setup
Stages:
- Source: GitHub
- Build: AWS CodeBuild
- Deploy: EKS using kubectl or Lambda
Automated end-to-end CI/CD pipeline.
11. Monitoring
Enable CloudWatch Logs for:
- CodeBuild logs
- CodePipeline logs
- EKS container logs
kubectl logs
aws logs describe-log-groups
12. Final Output
Application accessible using LoadBalancer URL on port 80.
kubectl get svc
LoadBalancerURL : http://a7d72c016477d4c2aaf281cb783f6f95-125436209.ap-south-1.elb.amazonaws.com/
NOTE : The Above created LoadBalancer is Created By AWS CLI EKS Using CloudFormation Stack and It is A Classic LoadBalncer The AWS Resource "ARN" :should be BLANK (EMPTY)










