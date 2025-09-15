Return-Path: <linux-kernel+bounces-817722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD6B585A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5573A6D37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B259D2874E3;
	Mon, 15 Sep 2025 19:57:32 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC5279DDD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966252; cv=none; b=ego9Hje/yAvurP7ben0HUtepJZ31MuxfiJqTxeFFJPyAdUycKVpJAPKk5eVD0g3lCGpbZuSjN70/7Uf1nds6BgNEX+Fp0tFUxCI6TdSnu91MDyjgJY9Sw6bcUHnsw7U+hUnR7UZaTGoyjnYs9Kvtgmhd4rqQhmPHRsSMzHT1+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966252; c=relaxed/simple;
	bh=VWgGilGF/rjd71gdgLN4FzRihvvihonjoWSLYGIKoDE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jTMnw7ZEq6kcRIqjl5/iJNcK7kGsw5e0TCD8Bms4vfpO8AwXR5dJGj9ctJQ/69glotRZKpM4VaWBPAVDCXm6irZSf6MHoH+qIwqgcf4ZEULfppC/Ox3ONgG7TGA+awm/otxh0x187y8617+nvgl815ur1/Y5gjDPipIOcDmm9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42407cbc8d1so13443675ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966250; x=1758571050;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7u677u+FRX2HTabBo3vsuCN2+Wdc3q65kRzXTtKfSg=;
        b=SEQykq7hwkXsyURXMUcb9fkOHTTmuwkPpBBG0IU7DLCX/UPtVnXnr6EfrDXFUFtHH3
         wITwJi6Oqb2E0SGB7kn7WCJTae4rZDlKc5sP+RyGAKymVHKUDVvdkzE5N7vpooKPwShz
         a/9MgsanTHQUnMqe5sBD7fhZ/hbH4d8na5W52FcVH0CyIL9/7rKuQDJ7vTPj0ykv+WoK
         oc6MyXktof/VMynR0ZpmINMHtnNd11+aBFJ9y7YirZMss2mOvbW0eMAxqZAF5PbaKkCF
         D/cSLJvM4ePKEdeTuzrWE31yr/FuYfGHbv+5Wuw6rp5H0UXK3uhS7L8C4GUSJCfvV0N9
         +Xhg==
X-Forwarded-Encrypted: i=1; AJvYcCWPS8eHSzvT0v89GvJMNjiyaER8MNFFkOxGThrlwWtSg9m2c5rd+Ow4slQTtamhris87FegBiQiNnzyQl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8J5P/fpA7bnyRhxnPzBJ2ABx6i2YXnPiEg7NRl9R5AByiAiZ
	oZ77wv+GakR+3AMDYaaDddxEYtzypE+DqbtqO9m5MgFRr45VDM8nFhJqhHk61pOqwLhABDvGPUD
	SdPNfRvExETHtR9Lyyo/h4ZQp5FBiYb0d6EbehG7qP9TXQvDJIjCffZoVSHE=
X-Google-Smtp-Source: AGHT+IEfW6NwqGU1Snh4ZVpBc4AtlgMUTmqs/A7vV7cjMiciIcZxMmgNB6nJ/Y1zq86wHuMMLHk0dkHwGb1E20or0kvVnM1b8i6g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:412:fa25:dd54 with SMTP id
 e9e14a558f8ab-4209e36cf49mr163685275ab.14.1757966249805; Mon, 15 Sep 2025
 12:57:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:57:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c86fa9.050a0220.2ff435.03ac.GAE@google.com>
Subject: [syzbot] [net?] WARNING in add_timer
From: syzbot <syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    63a796558bc2 Revert "net: usb: asix: ax88772: drop phylink..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11906b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c302bcfb26a48af
dashboard link: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ee11780421b/disk-63a79655.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea93cc1dbd6d/vmlinux-63a79655.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ca443049a6a/bzImage-63a79655.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6273 at kernel/time/timer.c:1247 add_timer+0x73/0x90 kernel/time/timer.c:1247
Modules linked in:
CPU: 1 UID: 0 PID: 6273 Comm: syz.4.86 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:add_timer+0x73/0x90 kernel/time/timer.c:1247
Code: e8 03 42 80 3c 38 00 74 05 e8 69 1d 76 00 48 8b 73 10 48 89 df ba 04 00 00 00 5b 41 5e 41 5f e9 d3 ef ff ff e8 ee ab 12 00 90 <0f> 0b 90 5b 41 5e 41 5f c3 cc cc cc cc cc 66 66 66 66 66 66 2e 0f
RSP: 0018:ffffc9000b847980 EFLAGS: 00010293
RAX: ffffffff81ad0262 RBX: ffffffff8f742880 RCX: ffff88802e6e9e00
RDX: 0000000000000000 RSI: 00000000000061d8 RDI: ffffffff8f742880
RBP: ffffc9000b847ac8 R08: ffff88801b68f8fb R09: 1ffff110036d1f1f
R10: dffffc0000000000 R11: ffffed10036d1f20 R12: 00000000000061d8
R13: ffff88807e627000 R14: ffffffff8f742888 R15: dffffc0000000000
FS:  00007fdd1c7e46c0(0000) GS:ffff888125d18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056332c8bc2b8 CR3: 0000000028848000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mpc_timer_refresh net/atm/mpc.c:1419 [inline]
 atm_mpoa_mpoad_attach net/atm/mpc.c:802 [inline]
 atm_mpoa_ioctl+0x2c3/0xca0 net/atm/mpc.c:1460
 do_vcc_ioctl+0x36d/0x9e0 net/atm/ioctl.c:159
 svc_ioctl+0x1ee/0x770 net/atm/svc.c:611
 sock_do_ioctl+0xdc/0x300 net/socket.c:1238
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd1b98eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd1c7e4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdd1bbd5fa0 RCX: 00007fdd1b98eba9
RDX: 0000000000000000 RSI: 00000000000061d8 RDI: 0000000000000004
RBP: 00007fdd1c7e4090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fdd1bbd6038 R14: 00007fdd1bbd5fa0 R15: 00007fffd3ee7758
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

