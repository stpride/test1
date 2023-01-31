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
      rm -rf ./python > /dev/null
      cp -a ${var.src_dir}/python .
      docker run \
        -v "$PWD":/var/task \
        "public.ecr.aws/sam/build-${var.python_version}" \
        /bin/sh -c "pip install -r ./python/requirements.txt -t ./python/; exit"
    EOF
  }
}

data "archive_file" "layer_zip" {
  type        = "zip"
  output_path = "/tmp/layer.zip"
  source_dir  = "./python"
  depends_on  = [null_resource.test]
}
