import subprocess
from multiprocessing import Process
from time import sleep


def main():
    try:
        while True:
            path = 'lib/ps_scripts/basic_info.ps1'
            result = subprocess.run([
                'powershell',
                '-ExecutionPolicy',
                'Unrestricted',
                '-File',
                path
            ], shell=False)
            sleep(1)
            if result.returncode != 0:
                raise Exception("An error has occurred while executing the Powershell script: ")
    except Exception as e:
        raise e


def infoProcesses():
    try:
        while True:
            path = 'lib/ps_scripts/top_processes.ps1'
            result = subprocess.run(['powershell', '-ExecutePolicy', 'Unrestricted', '-File', path], shell=False)
            sleep(1)
            if result.returncode != 0:
                data = "An error has occurred while executing the Powershell script" + str(result.stderr)
                raise Exception(data)
    except Exception as e:
        raise e


if __name__ == "__main__":
    mainProcess = Process(target=main,daemon=True)
    topProcesses = Process(target=infoProcesses,daemon=True)
    mainProcess.start()
    topProcesses.start()
