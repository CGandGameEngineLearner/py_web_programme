# 定义 Python 安装程序的下载链接和文件名 通过华为云下载python 3.8.6安装包
$installerUrl = "https://mirrors.huaweicloud.com/python/3.8.6/python-3.8.6-amd64.exe"
$installerFile = "python-3.8.6-amd64.exe"

# 获取所有已安装的Python版本
$pythonVersions = Get-ChildItem -Path "HKLM:\SOFTWARE\Python\PythonCore" | ForEach-Object { $_.PSChildName }

# 检查是否有3.8.6版本
$python386Installed = $false
foreach ($version in $pythonVersions) {
    Write-Host $version
    if ($version -eq "3.8.6") {
        $python386Installed = $true
        break
    }
}

# 输出结果
if ($python386Installed) {
    Write-Host "Python 3.8.6 已安装在计算机上。"
} else {
    Write-Host "Python 3.8.6 未在计算机上安装，准备自动安装Python 3.8.6。"
}

# 如果没安装Python 3.8.6 则自动安装
if ($python386Installed -eq $false)
{
    # 下载 Python 安装程序
    Write-Host "正在下载 Python 安装程序..."
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerFile

    # 安装 Python
    Write-Host "正在安装 Python，请稍候..."
    Start-Process -FilePath $installerFile -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1" -Wait

    # 删除安装程序
    Write-Host "Python 安装完成！删除安装程序..."
    Remove-Item $installerFile

    Write-Host "Python 3.8.6 已安装成功"
}


# 创建虚拟环境
python -m venv venv

# 激活虚拟环境
.\venv\Scripts\Activate.ps1

# 通过镜像源pip安装项目依赖库
pip install -r requirements.txt -i https://pypi.mirrors.ustc.edu.cn/simple/

# 通过jupyter打开
jupyter notebook ./第8次实验报告-2024.ipynb
