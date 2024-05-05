# ���� Python ��װ������������Ӻ��ļ��� ͨ����Ϊ������python 3.8.6��װ��
$installerUrl = "https://mirrors.huaweicloud.com/python/3.8.6/python-3.8.6-amd64.exe"
$installerFile = "python-3.8.6-amd64.exe"

# ��ȡ�����Ѱ�װ��Python�汾
$pythonVersions = Get-ChildItem -Path "HKLM:\SOFTWARE\Python\PythonCore" | ForEach-Object { $_.PSChildName }

# ����Ƿ���3.8.6�汾
$python386Installed = $false
foreach ($version in $pythonVersions) {
    Write-Host $version
    if ($version -eq "3.8.6") {
        $python386Installed = $true
        break
    }
}

# ������
if ($python386Installed) {
    Write-Host "Python 3.8.6 �Ѱ�װ�ڼ�����ϡ�"
} else {
    Write-Host "Python 3.8.6 δ�ڼ�����ϰ�װ��׼���Զ���װPython 3.8.6��"
}

# ���û��װPython 3.8.6 ���Զ���װ
if ($python386Installed -eq $false)
{
    # ���� Python ��װ����
    Write-Host "�������� Python ��װ����..."
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerFile

    # ��װ Python
    Write-Host "���ڰ�װ Python�����Ժ�..."
    Start-Process -FilePath $installerFile -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1" -Wait

    # ɾ����װ����
    Write-Host "Python ��װ��ɣ�ɾ����װ����..."
    Remove-Item $installerFile

    Write-Host "Python 3.8.6 �Ѱ�װ�ɹ�"
}


# �������⻷��
python -m venv venv

# �������⻷��
.\venv\Scripts\Activate.ps1

# ͨ������Դpip��װ��Ŀ������
pip install -r requirements.txt -i https://pypi.mirrors.ustc.edu.cn/simple/

# ͨ��jupyter��
jupyter notebook ./��8��ʵ�鱨��-2024.ipynb
