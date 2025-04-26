<h3 align="center">< Projeto DemoDay /></h3>

<div align="center">
  	<br>
    <img src="https://static.wixstatic.com/media/7dea42_a57655ddd6874bb099c143a02aed0dee~mv2.png/v1/fit/w_512,h_137,al_c,q_10,usm_0.66_1.00_0.01,enc_png,quality_high/Logo%20Avanti.png" height="60"/>
    <h1>DevOps</h1>
</div>

Documentação do projeto **DemoDay**.

### Contexto

Uma empresa cujo foco principal é a **criação e publicação de conteúdos** em blogs (baseado em WordPress) enfrentou um **crescimento expressivo** na quantidade de leitores e usuários acessando a plataforma.

Com o aumento do tráfego e da demanda por novos conteúdos, surgiu a necessidade de uma **infraestrutura** mais **robusta**, **escalável** e **automatizada**.

### Objetivo

A equipe precisa provisionar uma **infraestrutura** moderna na nuvem para hospedar seu sistema de publicação de conteúdos. A proposta é construir essa estrutura na **AWS**, garantindo **escalabilidade** e **automação**. Os principais requisitos incluem:

- Instalar e configurar o Docker em uma EC2 (usando User Data);
- Configurar **Wordpress** com **Docker** compose;
- Utilizar o **RDS** _(mysql)_;
- Utilizar o **EFS**;
- Utilizar o **Application Load Balancer**;
- Utilizar o **NAT Gateway**;
- Utilizar o **Internet Gateway**;
- Utilizar o **Auto Scaling Group**;

O objetivo é fazer tudo isso de forma **automatizada** e **reutilizável** usando **Terraform**, garantindo que qualquer pessoa da equipe possa subir a mesma infra com um único comando.

### Diagrama da solução

<div align="center">

![DemoDay Diagrama](./assets/demoday.png)

</div>

|                                                       -                                                        | **Serviço**        |
| :------------------------------------------------------------------------------------------------------------: | ------------------ |
|                    <img src="https://icon.icepanel.io/AWS/svg/Compute/EC2.svg" width="40">                     | EC2                |
|              <img src="https://icon.icepanel.io/AWS/svg/Compute/EC2-Auto-Scaling.svg" width="40">              | Auto Scaling Group |
| <img src="https://icon.icepanel.io/AWS/svg/Networking-Content-Delivery/Virtual-Private-Cloud.svg" width="40">  | VPC                |
| <img src="https://icon.icepanel.io/AWS/svg/Networking-Content-Delivery/Elastic-Load-Balancing.svg" width="40"> | ALB                |
| <img src="https://icon.icepanel.io/AWS/svg/Networking-Content-Delivery/Virtual-Private-Cloud.svg" width="40">  | VPC                |
|                    <img src="https://icon.icepanel.io/AWS/svg/Storage/EFS.svg" width="40">                     | EFS                |
|            <img src="https://icon.icepanel.io/AWS/svg/Storage/Elastic-Block-Store.svg" width="40">             | EBS                |
|                    <img src="https://icon.icepanel.io/AWS/svg/Database/RDS.svg" width="40">                    | RDS (MySQL)        |
