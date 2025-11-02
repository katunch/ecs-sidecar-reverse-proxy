ecs-sidecar-reverse-proxy
====================================

This Nginx image is used to act as a reverse proxy as sidecar container on an AWS ECS application behind an Application Load Balancer. It implements IP based rate limiting and hardening against basic attacks.

# Requirements
To run this image as a sidecar in an ECS task its essential to provide the proxy url to your application and the CIDR block of the VPC where it is running.

# Environment Variables
| Variable                      | Description                                                          | Default Value |
| ----------------------------- | -------------------------------------------------------------------- | ------------- |
| `NGINX_VPC_CIDR_BLOCK`        | (Required) The CIDR block of the VPC where this container is running |               |
| `NGINX_PROXY_URL`             | (Required) The target URL where the requests are proxied to          |               |
| `NGINX_RATE_LIMIT_PER_SECOND` | (Optional) Sets the Rate Limit per second for IP based rate limiting | `10`          |
| `NGINX_RATE_LIMIT_BURST`      | (Optional) Sets the burst limit for the application proxy            | `10`          |


# Running locally
```bash
docker pull ghcr.io/katunch/ecs-sidecar-reverse-proxy:next
docker run --rm -it -p 80:80 -e NGINX_VPC_CIDR_BLOCK=192.168.1.0/24 -e NGINX_PROXY_URL=http://host.docker.internal ghcr.io/katunch/ecs-sidecar-reverse-proxy:next
```