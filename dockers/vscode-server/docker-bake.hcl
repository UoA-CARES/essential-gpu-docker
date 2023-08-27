variable "IMAGE_NAME" {
    default = "mycares/kaggle-vscode-server"
}

variable "RELEASE" {
    default = "v132"
}

target "default" {
    dockerfile = "Dockerfile"
    tags = ["${IMAGE_NAME}:${RELEASE}"]
    contexts = {
        scripts = "../../container-template"
        proxy = "../../container-template/proxy"
    }
}
