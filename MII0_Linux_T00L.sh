#!/bin/bash
echo "-------------------------------------------------------------------------------"
echo "   _   __   __   __   _                                          _    _    __
  / \,' /  / /  / / ,' \       /7  ()  _         _ __       /7 ,' \ ,' \  / /
 / \,' /  / /  / / / 0 /      //  /7  / \/7 /7/7 \V,'      /_7/ 0 // 0 / / /_
/_/ /_/  /_/  /_/  \_,'  ____//  //  /_n_/ /__/ ,'n\  ____//  \_,' \_,' /___/
                        /___/                        /___/
"
echo "-------------------------------------------------------------------------------"
# 函数：识别操作系统及版本
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_NAME=$NAME
        OS_VERSION=$VERSION
    else
        OS_NAME=$(uname -s)
        OS_VERSION=$(uname -r)
    fi
}

# 函数：显示菜单
show_menu() {
    echo "请选择你的操作系统："
    echo "1) Ubuntu"
    echo "2) CentOS"
    echo "3) Debian"
    echo "4) Fedora"
    echo "5) 其他/未知 ($OS_NAME $OS_VERSION)"
    read -p "请输入选择 (1-5): " choice
}

# 函数：执行相应的命令
execute_command() {
    case $choice in
        1)
            echo "你选择了 Ubuntu"
            # 更新系统
            echo "更新系统..."
            sudo apt update && sudo apt upgrade -y

            # 安装基本工具
            echo "安装基本工具: vim, nano..."
            sudo apt install -y vim nano

            # 安装 proxychains4
            echo "安装 proxychains4..."
            sudo apt install -y proxychains4

            # 安装 nginx
            echo "安装 nginx..."
            sudo apt install -y nginx

            # 启动并启用 nginx
            echo "启动并启用 nginx..."
            sudo systemctl start nginx
            sudo systemctl enable nginx

            # 安装 tomcat
            echo "安装 tomcat..."
            TOMCAT_VERSION=9.0.73
            wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
            sudo tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/
            sudo mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
            rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

            # 启动 tomcat
            echo "启动 tomcat..."
            sudo /opt/tomcat/bin/startup.sh

            # 安装 Docker
            echo "安装 Docker..."
            sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            sudo apt update
            sudo apt install -y docker-ce

            # 启动并启用 Docker
            echo "启动并启用 Docker..."
            sudo systemctl start docker
            sudo systemctl enable docker

            # 安装 Docker Compose
            echo "安装 Docker Compose..."
            DOCKER_COMPOSE_VERSION=2.21.0
            sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose

            # 安装 Java
            echo "安装 Java..."
            sudo apt install -y default-jdk

            # 安装 Python
            echo "安装 Python..."
            sudo apt install -y python3 python3-pip

            # 安装 C/C++ 开发工具
            echo "安装 C/C++ 开发工具..."
            sudo apt install -y build-essential

            # 显示所有安装的软件的版本信息
            echo "所有软件安装完成，版本信息如下："

            echo "vim version: $(vim --version | head -n 1)"
            echo "nano version: $(nano --version | head -n 1)"
            echo "proxychains4 version: $(proxychains4 -v | head -n 1)"
            echo "nginx version: $(nginx -v 2>&1)"
            echo "tomcat version: $(/opt/tomcat/bin/catalina.sh version | head -n 1)"
            echo "docker version: $(docker --version)"
            echo "docker-compose version: $(docker-compose --version)"
            echo "java version: $(java -version 2>&1 | head -n 1)"
            echo "python version: $(python3 --version)"
            echo "gcc version: $(gcc --version | head -n 1)"
            echo "g++ version: $(g++ --version | head -n 1)"

            echo "所有软件已成功安装！"
            ;;
        2)
            echo "你选择了 CentOS"
            # 更新系统
            echo "更新系统..."
            sudo yum update -y

            # 安装基本工具
            echo "安装基本工具: vim, nano..."
            sudo yum install -y vim nano

            # 安装 proxychains4
            echo "安装 proxychains4..."
            sudo yum install -y epel-release
            sudo yum install -y proxychains

            # 安装 nginx
            echo "安装 nginx..."
            sudo yum install -y nginx

            # 启动并启用 nginx
            echo "启动并启用 nginx..."
            sudo systemctl start nginx
            sudo systemctl enable nginx

            # 安装 tomcat
            echo "安装 tomcat..."
            TOMCAT_VERSION=9.0.73
            wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
            sudo tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/
            sudo mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
            rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

            # 启动 tomcat
            echo "启动 tomcat..."
            sudo /opt/tomcat/bin/startup.sh

            # 安装 Docker
            echo "安装 Docker..."
            sudo yum install -y yum-utils
            sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
            sudo yum install -y docker-ce

            # 启动并启用 Docker
            echo "启动并启用 Docker..."
            sudo systemctl start docker
            sudo systemctl enable docker

            # 安装 Docker Compose
            echo "安装 Docker Compose..."
            DOCKER_COMPOSE_VERSION=2.21.0
            sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose

            # 安装 Java
            echo "安装 Java..."
            sudo yum install -y java-1.8.0-openjdk-devel

            # 安装 Python
            echo "安装 Python..."
            sudo yum install -y python3 python3-pip

            # 安装 C/C++ 开发工具
            echo "安装 C/C++ 开发工具..."
            sudo yum groupinstall -y "Development Tools"

            # 显示所有安装的软件的版本信息
            echo "所有软件安装完成，版本信息如下："

            echo "vim version: $(vim --version | head -n 1)"
            echo "nano version: $(nano --version | head -n 1)"
            echo "proxychains version: $(proxychains -v | head -n 1)"
            echo "nginx version: $(nginx -v 2>&1)"
            echo "tomcat version: $(/opt/tomcat/bin/catalina.sh version | head -n 1)"
            echo "docker version: $(docker --version)"
            echo "docker-compose version: $(docker-compose --version)"
            echo "java version: $(java -version 2>&1 | head -n 1)"
            echo "python version: $(python3 --version)"
            echo "gcc version: $(gcc --version | head -n 1)"
            echo "g++ version: $(g++ --version | head -n 1)"

            echo "所有软件已成功安装！"

            ;;
        3)
            echo "你选择了 Debian"
            # 更新系统
            echo "更新系统..."
            sudo apt update && sudo apt upgrade -y

            # 安装基本工具
            echo "安装基本工具: vim, nano..."
            sudo apt install -y vim nano

            # 安装 proxychains4
            echo "安装 proxychains4..."
            sudo apt install -y proxychains4

            # 安装 nginx
            echo "安装 nginx..."
            sudo apt install -y nginx

            # 启动并启用 nginx
            echo "启动并启用 nginx..."
            sudo systemctl start nginx
            sudo systemctl enable nginx

            # 安装 tomcat
            echo "安装 tomcat..."
            TOMCAT_VERSION=9.0.73
            wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
            sudo tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/
            sudo mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
            rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

            # 启动 tomcat
            echo "启动 tomcat..."
            sudo /opt/tomcat/bin/startup.sh

            # 安装 Docker
            echo "安装 Docker..."
            sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
            echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
            sudo apt update
            sudo apt install -y docker-ce

            # 启动并启用 Docker
            echo "启动并启用 Docker..."
            sudo systemctl start docker
            sudo systemctl enable docker

            # 安装 Docker Compose
            echo "安装 Docker Compose..."
            DOCKER_COMPOSE_VERSION=2.21.0
            sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose

            # 安装 Java
            echo "安装 Java..."
            sudo apt install -y default-jdk

            # 安装 Python
            echo "安装 Python..."
            sudo apt install -y python3 python3-pip

            # 安装 C/C++ 开发工具
            echo "安装 C/C++ 开发工具..."
            sudo apt install -y build-essential

            # 显示所有安装的软件的版本信息
            echo "所有软件安装完成，版本信息如下："

            echo "vim version: $(vim --version | head -n 1)"
            echo "nano version: $(nano --version | head -n 1)"
            echo "proxychains4 version: $(proxychains4 -v | head -n 1)"
            echo "nginx version: $(nginx -v 2>&1)"
            echo "tomcat version: $(/opt/tomcat/bin/catalina.sh version | head -n 1)"
            echo "docker version: $(docker --version)"
            echo "docker-compose version: $(docker-compose --version)"
            echo "java version: $(java -version 2>&1 | head -n 1)"
            echo "python version: $(python3 --version)"
            echo "gcc version: $(gcc --version | head -n 1)"
            echo "g++ version: $(g++ --version | head -n 1)"

            echo "所有软件已成功安装！"

            ;;
        4)
            echo "你选择了 Fedora (暂未开发)"
            echo "该选项尚未实现，请选择其他操作系统。"
            ;;

        5)
            echo "你选择了 其他/未知 ($OS_NAME $OS_VERSION) (暂未开发)"
            echo "该选项尚未实现，请选择其他操作系统。"
            ;;

        *)
            echo "无效的选择，请重新运行脚本。"
            ;;
    esac
}

# 主程序
detect_os
echo "检测到的操作系统：$OS_NAME $OS_VERSION"
show_menu
execute_command
