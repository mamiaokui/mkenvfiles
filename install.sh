sudo apt-get install chromium-browser git virtualbox git-svn emacs cscope xcscope-el ccache g++ gperf bison flex perl g++-multilib ant subversion wmctrl  ttf-wqy-microhei ttf-wqy-zenhei xfonts-wqy pepperflashplugin-nonfree wireshark apache2 openjdk-7-jdk openjdk-7-jre meld eclipse gnome-tweak-tool
git config --global diff.tool meld
ccache -M  5G
cp .emacs ~/
echo "source ~/mkenvfiles/ext_bashrc" >> ~/.bashrc
echo "add mount disk to configure file, sudo blkid /dev/sdb1, emacs /etc/fstab, UUID=c48d7a54-0af2-45cc-82fa-fe040b62e55d /home/mamk/ssd  ext4    defaults        0       2 "
echo "use gnome-tweak-tool to set caps as ctrl"
echo "if this is MAC and what to use gdb, can add s permission to gdb and chown it as root"
echo "download sdk to ~/tools, add tools to PATH"
echo "download ndk to ~/tools, add tools to PATH"
echo "copy sdk 14 to sdk 8 and sdk 14"


