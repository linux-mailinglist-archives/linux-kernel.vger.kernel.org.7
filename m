Return-Path: <linux-kernel+bounces-728460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F43B02870
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2682758398E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A819E13A258;
	Sat, 12 Jul 2025 00:49:44 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB876286A1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281384; cv=none; b=k2qRlWO8lZKDBpuH+ElacgrjtoXdoiX+2/DdlUG8nok7X0Tmj39G6haPBr7T3Xw6eEzojkCdSOtmrosVNNihEfs4iQK9sDYMkQWM46Pz14ZSLCd8VZuYGthvv8gBMQDQHd/Zgswig/jHFDS8T62jMl1w1/Yl6ev2eGlCCPmYUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281384; c=relaxed/simple;
	bh=mzy61pI19e3QPLVixLyp438i8GgZ1rCeV+XbsdpQO9w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OXLSUmoTXNV//XDjYCX306bc6ClCeVHLeLDCWckUWol14rxoE2bl1A7dkXLQnFct1kBNHz4qMYcO0BKwa7ylN3F5ytD3GR61tEn6O0joQRbqX2c5KTBS1xVcgdD3mY9zHjFINFxL1Kew+nI+vNDsO6TP/S7XYSfWv0Nh81KgSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-87326a81ceaso341535339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281382; x=1752886182;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hhf0hDevC5SyDl4jI9us2p3YUtUWmNvUC29BDdv37o=;
        b=QXmsrCFLZp9CnQDwEw6/kku9tEYUlxHnJJrEr+eRmiXhWrJ3UmZ1+5WtxorcVKPmv+
         eMqXb10ER4rm7T9RGEUdZXsGnFY/lHsuKJ5gXiHYYD6Posygq6I2CtWnJbm0isbAZGly
         oTL0QDg9u5sgpqqgANY+SC1b3yH1kdQTdqTSBp+TUTIu2Zeb/q9Oc9WhOFSrVImSnT6L
         uYdbhwYxZEKU9ZI9J87YxH7rgvoJw5JV3BzdF3bGTUlSEt5jhcwEksydrMxiw1HpVqBq
         BsOb0bU21ErqSISoMNLjUnYAiN+ZpM6afmqcAghdXXm7D2MjwxM8gf/f8Q4NU0uEaSRW
         SmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIFcJ/P4mhL9557HtslHznSqKzIzIY2yfIuCVdA9tdeEEnNKDVHWT9x48FCgkmdCwqsFwF1Mj8YNW75Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz711AeFcU4kHQOgj5mWNRu6smza+7uw81XCJOI/KUkFzUssElg
	sPtaY0ZlREko9K1rpJd1lDu8SFncTYqW/vcbUESJdol+I0+9gvsI1DQN24UUNOpNOqI5TGZBZsX
	uSkXatNmrTgZvZwFG7VgHWoXIFj4U+NuB51b7MGxrrA+DTmdUkanqNwlxCQM=
X-Google-Smtp-Source: AGHT+IHrIaDwURkNsmx8w9nKaV68+/2dJk9Kb6yb9RR6d5+ZN3JzJYAQfuTAxuZBhSlTR9+wakeu4V31MYjnx83Ki44rM59VulfA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:d209:0:b0:85e:16e9:5e8d with SMTP id
 ca18e2360f4ac-87966fef563mr945648839f.7.1752281381840; Fri, 11 Jul 2025
 17:49:41 -0700 (PDT)
Date: Fri, 11 Jul 2025 17:49:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871b125.a00a0220.26a83e.0066.GAE@google.com>
Subject: [syzbot] [net?] WARNING in rt_set_nexthop
From: syzbot <syzbot+97bf275720e06ad75f63@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=107f9582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6cfc97245100778
dashboard link: https://syzkaller.appspot.com/bug?extid=97bf275720e06ad75f63
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b6728c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aac28c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/147c9de5b1eb/disk-d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6b4ca03edae/vmlinux-d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c7e75a248fb/bzImage-d7b8f8e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97bf275720e06ad75f63@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5851 at kernel/softirq.c:387 __local_bh_enable_ip+0x180/0x1c0 kernel/softirq.c:387
Modules linked in:
CPU: 0 UID: 0 PID: 5851 Comm: krxrpcio/7001 Not tainted 6.16.0-rc5-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__local_bh_enable_ip+0x180/0x1c0 kernel/softirq.c:387
Code: 48 3b 44 24 48 75 57 48 8d 65 e0 5b 41 5c 41 5e 41 5f 5d e9 ed 9f 8a ff cc 90 0f 0b 90 e9 f9 fe ff ff e8 53 00 00 00 eb 9f 90 <0f> 0b 90 e9 24 ff ff ff 48 c7 c1 30 17 a2 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc9000403f4c0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff89de65e3
RBP: ffffc9000403f548 R08: ffff8880b863bf03 R09: 1ffff110170c77e0
R10: dffffc0000000000 R11: ffffed10170c77e1 R12: ffff8880b863bf00
R13: ffff888076c09570 R14: dffffc0000000000 R15: 1ffff92000807e98
FS:  0000000000000000(0000) GS:ffff888125c1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563736fd8000 CR3: 00000000738cd000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 rt_add_uncached_list net/ipv4/route.c:1526 [inline]
 rt_set_nexthop+0x693/0xa80 net/ipv4/route.c:-1
 __mkroute_output net/ipv4/route.c:2669 [inline]
 ip_route_output_key_hash_rcu+0x18f6/0x23a0 net/ipv4/route.c:2864
 ip_route_output_key_hash+0x1b9/0x2e0 net/ipv4/route.c:2694
 __ip_route_output_key include/net/route.h:169 [inline]
 ip_route_output_flow+0x2a/0x150 net/ipv4/route.c:2921
 ip_route_output_ports include/net/route.h:213 [inline]
 rxrpc_assess_MTU_size net/rxrpc/peer_object.c:174 [inline]
 rxrpc_init_peer+0x50a/0xc60 net/rxrpc/peer_object.c:281
 rxrpc_new_incoming_peer+0x281/0x5a0 net/rxrpc/peer_object.c:325
 rxrpc_alloc_incoming_call net/rxrpc/call_accept.c:284 [inline]
 rxrpc_new_incoming_call+0x612/0x14f0 net/rxrpc/call_accept.c:377
 rxrpc_input_packet net/rxrpc/io_thread.c:310 [inline]
 rxrpc_io_thread+0x18b2/0x2cd0 net/rxrpc/io_thread.c:482
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

