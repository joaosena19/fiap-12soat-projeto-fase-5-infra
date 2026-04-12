# Security Group para o NLB
resource "aws_security_group" "nlb_sg" {
  name        = "${var.project_identifier}-nlb-sg"
  description = "Security group para Network Load Balancer"
  vpc_id      = aws_vpc.vpc_principal.id

  ingress {
    description = "Upload API"
    from_port   = 84
    to_port     = 84
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Relatorio API"
    from_port   = 86
    to_port     = 86
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Permitir todo trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_identifier}-nlb-sg"
  }
}

# Network Load Balancer para o EKS
resource "aws_lb" "eks_nlb" {
  name               = "${var.project_identifier}-eks-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = aws_subnet.subnet_publica[*].id

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_identifier}-eks-nlb"
  }
}

# Target Group para Upload (porta 30084)
resource "aws_lb_target_group" "upload_tg" {
  name        = "${var.project_identifier}-upload-tg"
  port        = 30084
  protocol    = "TCP"
  vpc_id      = aws_vpc.vpc_principal.id
  target_type = "instance"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 30
    protocol            = "TCP"
    port                = "30084"
  }

  tags = {
    Name = "${var.project_identifier}-upload-tg"
  }
}

# Target Group para Relatorio (porta 30086)
resource "aws_lb_target_group" "relatorio_tg" {
  name        = "${var.project_identifier}-relatorio-tg"
  port        = 30086
  protocol    = "TCP"
  vpc_id      = aws_vpc.vpc_principal.id
  target_type = "instance"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 30
    protocol            = "TCP"
    port                = "30086"
  }

  tags = {
    Name = "${var.project_identifier}-relatorio-tg"
  }
}

# Listener do NLB para Upload (porta 84)
resource "aws_lb_listener" "upload_listener" {
  load_balancer_arn = aws_lb.eks_nlb.arn
  port              = "84"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.upload_tg.arn
  }
}

# Listener do NLB para Relatorio (porta 86)
resource "aws_lb_listener" "relatorio_listener" {
  load_balancer_arn = aws_lb.eks_nlb.arn
  port              = "86"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.relatorio_tg.arn
  }
}

# ASG attachment para Upload
resource "aws_autoscaling_attachment" "upload_asg_attachment" {
  autoscaling_group_name = aws_eks_node_group.eks_node_group.resources[0].autoscaling_groups[0].name
  lb_target_group_arn    = aws_lb_target_group.upload_tg.arn
  
  depends_on = [aws_eks_node_group.eks_node_group]
}

# ASG attachment para Relatorio
resource "aws_autoscaling_attachment" "relatorio_asg_attachment" {
  autoscaling_group_name = aws_eks_node_group.eks_node_group.resources[0].autoscaling_groups[0].name
  lb_target_group_arn    = aws_lb_target_group.relatorio_tg.arn
  
  depends_on = [aws_eks_node_group.eks_node_group]
}

# Regra para permitir que o NLB acesse os nos do EKS nas portas dos NodePorts
resource "aws_security_group_rule" "allow_nlb_to_eks_nodes" {
  type        = "ingress"
  description = "Permitir trafego do NLB para os nos do EKS nas portas 30084-30086"
  from_port   = 30084
  to_port     = 30086
  protocol    = "tcp"

  # NLB network preserva IP do cliente, SG source nao funciona.
  # Usar CIDR aberto porque NLB internet-facing repassa IPs publicos dos clientes.
  cidr_blocks = ["0.0.0.0/0"]

  # O destino e o Security Group automatico do Cluster EKS (onde os nos estao)
  security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id

  depends_on = [aws_eks_cluster.eks_cluster]
}
