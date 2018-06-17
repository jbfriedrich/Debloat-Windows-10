# Debloat Windows 10

Scripts used to debloat and declutter Windows 10 and make it bearable. It is a combination of [W4RH4WK's Debloat Windows 10 repository](https://github.com/W4RH4WK/Debloat-Windows-10/) and [adolfintel's Windows 10 Privacy](https://github.com/adolfintel/Windows10-Privacy) repository. I tested these scripts on a Windows 10 Professional 64-Bit (English) virtual and physical machine. 

Like the original, these scripts run without any user-interaction. They are intended for tech-savvy administrators, who know what they are doing and just want to automate this phase of their setup. If this profile does not fit you, I recommend using a different, maybe more interactive tool.

**There is no undo**, I recommend only using these scripts on a fresh
installation (including Windows Updates). Test everything after running them
before doing anything else. Also there is no guarantee that everything will
work after future updates since I cannot predict what Microsoft will do next.

## Contents

### lib

Folder contains helper libraries to elevate access and force creating directories inside the registry.

### contrib

Additional settings or applications used by the scripts.

### scripts

The actual scripts with self-explanatory names. They do not have to be excuted in any specific oder, the numbering merely shows in which order I tend to apply them. Scripts that might have undesired side-effects or that are work in progress have been moved to the "optional" subfolder. Apply them with extra caution, as their chance to break something is higher.

## Preparation

Enable execution of PowerShell scripts:

    PS> Set-ExecutionPolicy Unrestricted

Unblock PowerShell scripts and modules within this directory:

    PS > ls -Recurse *.ps1 | Unblock-File
    PS > ls -Recurse *.psm1 | Unblock-File

## Usage

1. Install all available updates for your system.
2. Edit the scripts to fit your need.
3. Run the scripts from a PowerShell with administrator priviledges (Explorer
   `Files > Open Windows PowerShell > Open Windows PowerShell as
   administrator`)
4. `PS > Restart-Computer`

## Liability

**All scripts are provided as is and you use them at your own risk.**

## Thanks To

- [W4RH4WK](https://github.com/W4RH4WK)
- [adolfintel](https://github.com/adolfintel/Windows10-Privacy)
