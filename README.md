<h1><center>Terraform Packer ECS Project Demo</center></h1>
<h2>Instructions in regards to terraforming AWS ECS using packer</h2>

<br/>
<hr/>

<h1>Step One: Build up Centos image using packer</h1> 
<h2><i>packer build packer.json</i></h2>

<br/>

<h1>Step Two: Tag image</h1> 
<h2><i>docker tag lightninglife/mycentosimage</i></h2>

<br/>

<h1>Step Three: Create a repo named mycentosimage in Dockerhub</h1> 
<h2><i><a href="https://drive.google.com/file/d/1-1qWCX7FmIFlWdFj6AbvXW-9HkJiMfaS/view?usp=sharing">Create a repo</a></i></h2>

<br/>

<h1>Step Four: Push image to Dockerhub</h1> 
<h2><i>docker push lightninglife/mycentosimage</i></h2>

<br/>

<h1>Step Five: Terraforming AWS ECS </h1> 
<h2><i>terraform init</i></h2>
<h2><i>terraform validate</i></h2>
  <h2><i>terraform plan</i></h2>
  <h2><i>terraform apply</i></h2>

