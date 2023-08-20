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
    },
    {
      protocol = "sqs"
      endpoint = "arn:aws:sqs:us-west-2:123456789012:function:my-function"
    },
    {
      protocol = "lambda"
      endpoint = "arn:aws:lambda:us-west-2:123456789012:function:my-second-function"
    }
  ]
}

locals {
  #data = {
  #    for sub in var.subscriptions: "${sub.protocol}-${sub.endpoint}" => sub.endpoint
  #    if sub.protocol == "lambda"
  #}
  #data = [
  #    for sub in var.subscriptions: sub.endpoint
  #    if sub.protocol == "lambda"
  #]
  data = [
      for sub in var.subscriptions: split(":",sub.endpoint)[6]
      if sub.protocol == "lambda"
  ]
}

output stuff {
  value = local.data
}
