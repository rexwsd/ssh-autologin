#!/usr/bin/expect

set SERVER_NAME [lindex $argv 0]
set IP [lindex $argv 1]
set PORT [lindex $argv 2]
set USER_NAME [lindex $argv 3]
set PASSWORD [lindex $argv 4]

spawn ssh -p $PORT $USER_NAME@$IP

expect {
    -timeout 50
    "*assword" { send "$PASSWORD\r\n"; exp_continue ; sleep 5; }
    "yes/no" { send \"yes\n\"; exp_continue; }
    "Last login*" {
        puts "\n登录成功\n";
        send "clear\r";
    }
    "Welcome*" {
        puts "\n登录成功\n";
        send "clear\r";
    }
    "~*" {
        puts "\n登录成功\n";
        send "clear\r";
    }
    "$*" {
        puts "\n登录成功\n";
        send "clear\r";
    }

    "#*" {
        puts "\n登录成功\n";
        send "clear\r";
    }
    
    "MFA auth*" {
        interact
    }

    "fingerprint*" {
        send "yes";
    }

    "菜单编号*" {
        send "yes";
    }
    timeout { puts "Expect was timeout."; return }
}

interact
