# Show Headers app
It is simple Docker application that only displays HTTP request headers.
This application has only one routing point (`/`).

## Usage
```sh
docker run -it --rm -p 8080:8080 dobassy/show-headers
```

You can access to `http://<host or ip>:8080/`.

Alternatively, it can be protected by BASIC authentication.
If you use it in the public cloud, there is a risk that other people will access it
even if it is temporary. Password protection is strongly recommended, as environment
variable may contain important information.
It's a bit better than being unprotected and public.

```sh
# start with password protection
docker run -it --rm -p 8080:8080 dobassy/show-headers start:withpassword
```

- The username is `user`.
- The password is a random string that is output to the container log (STDOUT).

## Objective and Background
I wanted to investigate Ingress's behavior in the Kubernetes environment.
In particular, there was a strong interest in how the XFF header.

At other times, I sometimes wanted to know how environment variables were set
when launching an application with PaaS (e.g. Cloud Foundry).

In this way, as Cloud Native Applications progress, there are more and more
situations where you want to understand the settings of the execution environment.
At that time, it is the role of this container that you can start immediately.
