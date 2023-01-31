variable "python_version" {
  description = "version"
  type = string
}

resource "null_resource" "test" {
  #depends_on = [
  #  aws_ecr_repository.main
  #]
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOF
      docker run \
        -v "$PWD":/var/task \
        "public.ecr.aws/sam/build-${var.python_version}" \
        /bin/sh -c "pip install -r ./python/requirements.txt -t python/; exit"
    EOF
  }
}
