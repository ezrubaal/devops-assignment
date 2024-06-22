# create repos for docker images for services 1 and 2
resource "aws_ecr_repository" "eladviprojservice1" {
  name = "eladviprojservice1"
}

resource "aws_ecr_repository" "eladviprojservice2" {
  name = "eladviprojservice2"
}