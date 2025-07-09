Return-Path: <linux-kernel+bounces-724548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F89AFF421
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0145A3508
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CE23C8CE;
	Wed,  9 Jul 2025 21:52:35 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B323534D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097954; cv=none; b=QA6+TAEfUr1GjPkG77xkSvQP4pAlBPkhHzTyGOg1xB+5sFWN+KwS/QoKEzY2g578adE2uo38Lz7OOnNqk6mX5sXAoqfqiCCNRdxAN7+q83DkcXgEIaINST0nlJYKMWwoFHxXmLsdKgbHI3xJRESqdyW3IGn3VKgRyxcjP7h7s6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097954; c=relaxed/simple;
	bh=8G0jFNWAm6LngLUTyL0L/8Bmyg4IvAvoOOotujOiWoY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t/cdreJNpvmkPl2kjEeFHR83pmnE1oLx5qOLzAOVYWXEX1tlPF3iCfoil/qzzGxhrdRZNRxJ0+lo0VXmfwfLojpaJxzzkBSLInkaDXVI10AcYtesupVaA6XAJY/Wpk45Y3nFT/ygjeLuV68X+0SGhM6Y6MiF+yTqrihpXozWhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-875bd5522e9so37480239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097952; x=1752702752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qns3PTsLSxHmcUEVZ0NGFxRYwJ/fQJEfgHSSuuxIADg=;
        b=jVXzIL+rOLgdg//dk/A35plI8Xvd8981n8KgW9fRkke29On8nxgiEPOeUdPHKsgc5a
         autrRik/qEcyqiZs9THsq7LBQrGxU9yHf7aJNcmAwa3cesiC99CkG2b9AXzcYsbBfrD3
         C2wR8qjms8NfJOHlwgqBIapmEve3EfrIqNGw1/EyC078g3DCblDSu1K25g67lm6SgYuz
         hWIotPWeMRKULdbemRm4opR54GPtfq4/PBtm+G5qbI5BKbtb9JXYJiRlri9+ccL5oUJj
         6IVdWRin8NaN8kfKFNZRCliNT944/lNbAPOCXoDnFQiV5Le+zgm6L6RJ/VOYjK3MBbSu
         xYZA==
X-Forwarded-Encrypted: i=1; AJvYcCW08VwYA+mDnjE/z3jvPi78PM8VfEr6cEyCOIriiNrw8T5zfj8Wk/gvTcEzHmi7bPdM43IavZm6rGTu7yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHV0fL/pjnzTwBNhS3QIyi6cu8BtAfHnvMbA/k490+2juMVw/j
	UA10Gdn3YeuGmx3t26GYl8d1emMHmPqATytYQSkHUn61+jCg1lFkZgptueKLtSbAuvqZ4V2jpAa
	F1MUKjgiNEAiDVwTOidvKEwyALcIjx5P5azeFqgLwjJUPj8/fYlWOjuucHl0=
X-Google-Smtp-Source: AGHT+IHF/6O87P5etdEw8gMnH7CB8aKKGG2eoMmZZ1bQZ8DtPVF2qvf6Yy1PNZ6RQ0uG78YtQYbVcd7K0plzSxWYpWpKP/aFOCn2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26c5:b0:875:bc7e:26ce with SMTP id
 ca18e2360f4ac-87968d06310mr35569739f.0.1752097952289; Wed, 09 Jul 2025
 14:52:32 -0700 (PDT)
Date: Wed, 09 Jul 2025 14:52:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686ee4a0.050a0220.385921.0022.GAE@google.com>
Subject: [syzbot] [net?] WARNING: ./include/net/netdev_lock.h:LINE at
 __linkwatch_sync_dev, CPU: kworker/u8:NUM/NUM
From: syzbot <syzbot+9196eb463ddf99a0be6e@syzkaller.appspotmail.com>
To: cratiu@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzkaller-bugs@googlegroups.com, vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    050f8ad7b58d Add linux-next specific files for 20250616
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ad8370580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2efc7740224b93a
dashboard link: https://syzkaller.appspot.com/bug?extid=9196eb463ddf99a0be6e
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c190c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109c95d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49faa18d2f53/disk-050f8ad7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c6f9cd7fe5d/vmlinux-050f8ad7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84a08d6403ee/bzImage-050f8ad7.xz

The issue was bisected to:

commit 04efcee6ef8d0f01eef495db047e7216d6e6e38f
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Fri Apr 4 16:11:22 2025 +0000

    net: hold instance lock during NETDEV_CHANGE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16390dd4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15390dd4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11390dd4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9196eb463ddf99a0be6e@syzkaller.appspotmail.com
Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")

------------[ cut here ]------------
RTNL: assertion failed at ./include/net/netdev_lock.h (72)
WARNING: ./include/net/netdev_lock.h:72 at netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline], CPU#0: kworker/u8:3/49
WARNING: ./include/net/netdev_lock.h:72 at __linkwatch_sync_dev+0x303/0x350 net/core/link_watch.c:279, CPU#0: kworker/u8:3/49
Modules linked in:
CPU: 0 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted 6.16.0-rc2-next-20250616-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: bond0 bond_mii_monitor
RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
RIP: 0010:__linkwatch_sync_dev+0x303/0x350 net/core/link_watch.c:279
Code: 7c fe ff ff e8 5e 7f 66 f8 c6 05 ce 6b 31 06 01 90 48 c7 c7 20 2f 93 8c 48 c7 c6 7a 32 9d 8d ba 48 00 00 00 e8 9e 1d 2a f8 90 <0f> 0b 90 90 e9 4d fe ff ff 44 89 f1 80 e1 07 38 c1 0f 8c 22 fd ff
RSP: 0018:ffffc90000ba7670 EFLAGS: 00010246
RAX: a4c1d8d5a4094c00 RBX: ffff888032708000 RCX: ffff8880222a5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa14 R12: 1ffff110064e105d
R13: dffffc0000000000 R14: ffffffff8c1c95e8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125c40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000300 CR3: 000000007997c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ethtool_op_get_link+0x15/0x70 net/ethtool/ioctl.c:63
 bond_check_dev_link+0x444/0x6c0 drivers/net/bonding/bond_main.c:863
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2745 [inline]
 bond_mii_monitor+0x428/0x2e00 drivers/net/bonding/bond_main.c:2967
 process_one_work kernel/workqueue.c:3235 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3318
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3399
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

