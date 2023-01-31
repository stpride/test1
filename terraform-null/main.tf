variable "python_version" {
  description = "version"
  type = string
}

variable "src_dir" {
  description = "source directory"
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
        /bin/sh -c "pip install -r ${var.src_dir}/python/requirements.txt -t ${var.src_dir}/python/; exit"
    EOF
  }
}
