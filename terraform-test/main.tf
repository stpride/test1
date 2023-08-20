provider aws {
  region = "us-west-2"
}

variable subscriptions {
  type = list(object({
      protocol = string
      endpoint = string
  }))
  default = [
    {
      protocol = "lambda"
      endpoint = "arn:aws:lambda:us-west-2:123456789012:function:my-function"
    }
  ]
}

locals {
  data = {
      for sub in var.subscriptions: "${sub.protocol}-${sub.endpoint}" => sub
      if sub.protocol == "lambda"
  }
}

