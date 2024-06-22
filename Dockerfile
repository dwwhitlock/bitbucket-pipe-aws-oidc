FROM atlassian/default-image:4

# Install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# install terraform
RUN apt-get update &&  apt-get install -y gnupg software-properties-common
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt-get install terraform -y

# install poetry
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python3.10 get-pip.py
RUN pip install poetry==1.8.3

# aws cli, pyenv, terraform
COPY README.md LICENSE /
COPY pipe /pipe

RUN echo "/pipe/pipe.sh" >> $HOME/.bashrc

ENTRYPOINT ["/pipe/pipe.sh"]
