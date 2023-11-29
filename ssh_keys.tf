resource "aws_key_pair" "key-class1" {
    key_name = "key-class1"
    public_key = file("class_key.pem.pub")
}
