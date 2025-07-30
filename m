Return-Path: <linux-kernel+bounces-750194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED50B15872
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B164318A1973
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958331F949;
	Wed, 30 Jul 2025 05:30:30 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B482198E9B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753853430; cv=none; b=RAxUUgCQCkdAzVOzv50IzGJlgCkr6vaW5ZH8K6gAE19uUiJMbSpto9hGr4F9dfTA/7iRzTYyjnxv41j2vvkQYc+xVK3A9yEvb7tQoGgiDAOPhlwfwgUzp7GZzjRk93VYN+nGTyaBfn1HxygPeWarZ/4beTtc3lWwejv2SjcTExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753853430; c=relaxed/simple;
	bh=SWXjA3T0iZABKRIwmCf5Uzft+ycSIlMkdD+XTW84w/o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n//3JB7hxJMh3ah4Osl7cax7pSeufpIqMrIX7QGCX/qBvmEFKnWF7QeYmclf7wkah9EE8OQ+2PTNfd/79sAnQxVX/bVtsqdk7DJpDAELmC4WQ2BbeYa7oYmpxPvg2sP9GOojKM/ESOzgDhHNlSfOkj8Bxw5bb/BDi+yb6jdjwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-87c13b0a7beso647002739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753853427; x=1754458227;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eu7fGBCIzOPa9YHCMscfdaivYVWI9C4AstnrKLseCYE=;
        b=sPME8WzKao540NUaDO4PGQrIrGu6zLmPZdmxWd+ZW5fbaDo+GZdibCuOUSQzZdw9wv
         HZq3nXSknoxioaz+jb1BnzR8MPqdq2w+1+ucciHqRkPi1qHWpCKUdMtSsBxipTZ6DQ3A
         JfGZeme6Hzo7+zQRr5K/NhJ4QtSWpV47G1WFuceAW/JuKvZ6DrfF6vSjNgjNAsVZdK0g
         6YXqPvYqttglVNWlTIzAYYn4JFhcTgvaMEnc6y42VsWXcMZchdOOSsC3qAzmh0zRFutw
         fCHFBolqvyO+IBXZcBLxQk/fjXrMxGdpZYBjsss+V+KpvlNyZbWSRNF8NCOkec5/EHGw
         QBvw==
X-Forwarded-Encrypted: i=1; AJvYcCXB+UuXh47yo+0mTSmSwP2o+RBy5UHsgFObcw0UUnq9QXHnuhWG8XnLqaTujEDusrNk71c7jCiDE8A2xcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwlJ4rM2SgzqN+E8WFI5v1fENxiUI1ghrBGJd3VIZ5uYbvvMN
	EpyABfZXzmOW6Nmm91cFDdSmfK11V+H0Q7UUiSdTbtvqVuDS2dQLtGmsD1rXxuONTHJVC6RcIoB
	mlR5K6Wtjhw9Ua1tEdSuaGsj54EGtWorqvbHFGRGqMCA5tbebFiPd1IvjCZE=
X-Google-Smtp-Source: AGHT+IGbEBXcBVdHTDiadmIrdZtqg/YJT1t5jbW5zXbtps0IXePdqO8BBqN40v43mfu3JJrTWicRPG+91/LmheYL2272IcmGFJuQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1592:b0:85d:b054:6eb9 with SMTP id
 ca18e2360f4ac-88138b04598mr386025539f.14.1753853427267; Tue, 29 Jul 2025
 22:30:27 -0700 (PDT)
Date: Tue, 29 Jul 2025 22:30:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6889adf3.050a0220.5d226.0002.GAE@google.com>
Subject: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (9)
From: syzbot <syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9312ee76490d octeontx2-af: use unsigned int as iterator fo..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=114b88a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b71a7f00d74e4f3
dashboard link: https://syzkaller.appspot.com/bug?extid=78ac1e46d2966eb70fda
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b381ecf9ad30/disk-9312ee76.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebd0e7846e92/vmlinux-9312ee76.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9c68d721e9c/bzImage-9312ee76.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com

x_tables: ip6_tables: mh match: only valid for protocol 135
------------[ cut here ]------------
hook not found, pf 10 num 1
WARNING: CPU: 0 PID: 7813 at net/netfilter/core.c:514 __nf_unregister_net_hook+0x30a/0x700 net/netfilter/core.c:514
Modules linked in:
CPU: 0 UID: 0 PID: 7813 Comm: syz.1.502 Not tainted 6.16.0-rc7-syzkaller-01904-g9312ee76490d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__nf_unregister_net_hook+0x30a/0x700 net/netfilter/core.c:514
Code: 58 59 ef 05 01 90 48 8b 44 24 10 0f b6 04 28 84 c0 0f 85 e3 03 00 00 41 8b 17 48 c7 c7 60 8f 98 8c 44 89 ee e8 07 46 e7 f7 90 <0f> 0b 90 90 e9 d8 01 00 00 e8 98 bf d3 01 89 c3 31 ff 89 c6 e8 1d
RSP: 0018:ffffc9000e8a7768 EFLAGS: 00010246
RAX: d399e8c7c2db4300 RBX: ffff8880688c2400 RCX: ffff88802c435a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa6c R12: ffff888029a72440
R13: 000000000000000a R14: ffff888029a736c0 R15: ffffffff8c9a21fc
FS:  00007f5152aa66c0(0000) GS:ffff888125c12000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c34c54a CR3: 0000000027c74000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nf_unregister_net_hook net/netfilter/core.c:-1 [inline]
 nf_unregister_net_hooks+0xcb/0x140 net/netfilter/core.c:610
 synproxy_tg6_destroy+0x58/0xb0 net/ipv6/netfilter/ip6t_SYNPROXY.c:94
 cleanup_entry+0x265/0x320 net/ipv6/netfilter/ip6_tables.c:669
 translate_table+0x1e5f/0x2040 net/ipv6/netfilter/ip6_tables.c:744
 do_replace net/ipv6/netfilter/ip6_tables.c:1154 [inline]
 do_ip6t_set_ctl+0x970/0xce0 net/ipv6/netfilter/ip6_tables.c:1644
 nf_setsockopt+0x26f/0x290 net/netfilter/nf_sockopt.c:101
 do_sock_setsockopt+0x179/0x1b0 net/socket.c:2344
 __sys_setsockopt net/socket.c:2369 [inline]
 __do_sys_setsockopt net/socket.c:2375 [inline]
 __se_sys_setsockopt net/socket.c:2372 [inline]
 __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2372
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5151b8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5152aa6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f5151db6080 RCX: 00007f5151b8e9a9
RDX: 0000000000000040 RSI: 0000000000000029 RDI: 000000000000000d
RBP: 00007f5151c10d69 R08: 0000000000000470 R09: 0000000000000000
R10: 0000200000000480 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5151db6080 R15: 00007ffc85b4e498
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

