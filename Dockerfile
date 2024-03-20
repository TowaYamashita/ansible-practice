FROM python:3.9-alpine

RUN apk add --no-cache gcc musl-dev libffi-dev openssl-dev openssh && \
    pip install --upgrade pip && \
    pip install ansible

WORKDIR /ansible

COPY ./ansible /ansible
COPY ./.ssh /ansible-ssh

CMD ["ansible-playbook", "-i", "inventory.ini", "playbook.yml"]
