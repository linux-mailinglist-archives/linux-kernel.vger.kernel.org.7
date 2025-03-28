Return-Path: <linux-kernel+bounces-580126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99510A74DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 16:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A9A17AC97
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB51D514F;
	Fri, 28 Mar 2025 15:21:27 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0DA171092
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175287; cv=none; b=dAgkFP7NnXmuPf2w8/4RkNavNXKJ9Oi/0otOdb2OHJvt+cyyHTZOQDC9ABqTLW4Gr+1i1LPdG7OCe0RGwuVQcrLE6p+wzrKTgsCqpSmvkcKC4TBT4gfF8ywx6+5aCGvnbaezbCVCUdN5DjP27Q6m0wULYFib2qiZ3TJJzEe8mgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175287; c=relaxed/simple;
	bh=/DJcgoepLrhBqIykp56qvvhQGBS88i2BdgFsikmpXQI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HuRHIrQS8jFJxJS7933bmp0RJPkDyWClsoDM8hoM0xdHlprtZANIPSCET/ZG3Gp3nl2TfcR1aLbpQ7aoCOzHUiHrhVK+IH8KOth+rC8OwZJSwAHFQGmwdMscC7Cw/ZJtz4A9z9Pnz/x2JhwjhpKlufogbMoc40OkowZ+vp6bCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d5b3819ff6so21562815ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 08:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743175285; x=1743780085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rEQe0yVISN2xBFeCkIqt/cInxyTeq/ldI8FyDfMB8w=;
        b=Sh0Eg4egrLhaZGpjeE+QMYaFrCUGU1aKg0DX5tysG14McfnbGB9GVP5e0yCh8XsAHF
         d/gfQHPQBW51Ze1hvL1I5EjaD4AvwGH+YM35TlHQ2MEF0vuYUdXDfs/JKiL3d+N9bf4R
         P6dSFmVH0G/FSwb0YVLGqBlNd2feiXz/CgmUDGCyFMk9fQxbM0eE98H9t69C4BO/0Mjg
         5kM0v/TXoP82zVwymzx++93eILBJ/QT5r5/ZKSonv4wTGgldwdPL/DYRNmZJpsCj02bf
         ji/SByDRQtuBZj8TRh1DRljrQ5Wyy9NtiuaKgkHo4tCA4CXm+FhAAPp4GJWyzMIhELbv
         7p3A==
X-Forwarded-Encrypted: i=1; AJvYcCWwx/OkjwquvSLQDYMF0g3bgrf2JH0JaWiEEB+0VRXs90X7LU/5+xb75mqlKxxtxSPblYuEJywDguX3VGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0ldlAGug5cncjHfGJZgmcHKTKg9VmqiTeO4lofDrAG6wCJQ4
	NsgvKIbgc9hleLAQaP2ijUjAvBaDevejYnaTkxrPEugKm/1FyHApW0jqZ8s0TLitJTOopPbaaph
	besVDNDeR34QiUCLZWBRfkr9cEDV0lUJSFhte0zPi7cB5xlwE6g6XQiw=
X-Google-Smtp-Source: AGHT+IGtTduv27dw2iXD86Lo3CIKLQBYjSpbC4tosT+BE9iiUMBTYFGsYRLmktEgwtwuySlKclT5Fltw5WkQatTg95WaokB1DVA0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1689:b0:3d4:28c0:1692 with SMTP id
 e9e14a558f8ab-3d5ccdc1e0bmr89764765ab.5.1743175284806; Fri, 28 Mar 2025
 08:21:24 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:21:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6be74.050a0220.2f068f.007e.GAE@google.com>
Subject: [syzbot] [net?] WARNING in tls_strp_msg_load
From: syzbot <syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com>
To: borisp@nvidia.com, davem@davemloft.net, dhowells@redhat.com, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccc2f5a436fb net: dsa: mt7530: Fix traffic flooding for MM..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17494a64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b4c41bdaeea1964
dashboard link: https://syzkaller.appspot.com/bug?extid=b4cd76826045a1eb93c1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141203a8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131e24b7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3aefdb8b7ff7/disk-ccc2f5a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96e0fd0ea0ad/vmlinux-ccc2f5a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7c4310217a6/bzImage-ccc2f5a4.xz

The issue was bisected to:

commit c5c37af6ecad955acad82a440b812eb9cd73f77f
Author: David Howells <dhowells@redhat.com>
Date:   Mon May 22 12:11:14 2023 +0000

    tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cf8878580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17cf8878580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13cf8878580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5834 at net/tls/tls_strp.c:486 tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
Modules linked in:
CPU: 0 UID: 0 PID: 5834 Comm: syz-executor412 Not tainted 6.14.0-rc4-syzkaller-00210-gccc2f5a436fb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
Code: 5c 24 18 e9 72 fc ff ff e8 cf b8 31 f7 90 0f 0b 90 e9 91 f9 ff ff e8 c1 b8 31 f7 90 0f 0b 90 e9 be f9 ff ff e8 b3 b8 31 f7 90 <0f> 0b 90 eb 84 e8 a8 b8 31 f7 90 0f 0b 90 e9 8c fe ff ff 89 d9 80
RSP: 0018:ffffc90003e7f700 EFLAGS: 00010293
RAX: ffffffff8a90068d RBX: ffff88802a9f24dc RCX: ffff888034e0bc00
RDX: 0000000000000000 RSI: 000000000000001f RDI: 0000000000000000
RBP: ffffc90003e7f7f0 R08: ffffffff8a9002fe R09: 1ffff110062bf36c
R10: dffffc0000000000 R11: ffffed10062bf36d R12: ffff88802a9f24d0
R13: dffffc0000000000 R14: 0000000000000000 R15: 000000000000001f
FS:  0000555585cc3480(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000000218 CR3: 00000000347a8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tls_rx_rec_wait+0x280/0xa60 net/tls/tls_sw.c:1363
 tls_sw_recvmsg+0x85c/0x1c30 net/tls/tls_sw.c:2043
 inet6_recvmsg+0x2c9/0x730 net/ipv6/af_inet6.c:678
 sock_recvmsg_nosec net/socket.c:1023 [inline]
 sock_recvmsg+0x109/0x280 net/socket.c:1045
 __sys_recvfrom+0x202/0x380 net/socket.c:2237
 __do_sys_recvfrom net/socket.c:2252 [inline]
 __se_sys_recvfrom net/socket.c:2248 [inline]
 __x64_sys_recvfrom+0xde/0x100 net/socket.c:2248
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f382a3c83a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3fe269d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f382a3c83a9
RDX: 0000000000001ff4 RSI: 0000400000000100 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe3fe26c58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

