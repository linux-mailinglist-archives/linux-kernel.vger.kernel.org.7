Return-Path: <linux-kernel+bounces-706867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E348EAEBD02
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0347E7B3E89
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D990F2E7F3A;
	Fri, 27 Jun 2025 16:20:28 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFC1A314D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041228; cv=none; b=tTmL9SeDgjTo1gVWYnryFM79KToEY7tglWRSfER7HVGeI0jQ0v7gNEhD82DRxJrx/SM6IrAEFJ88lfOv6yfniJxQS1aekbirwbmF97EjlP9mnKLZG/vs4LGE2c9muUIi6ZX0sWgr7MrXHSMzSYmAvTET+XXgnrwlRdRMeQabuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041228; c=relaxed/simple;
	bh=yzCBJ7YPdsDNPrckw85CigMNhz/1gIuqnx0VKBeYdjU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k41Jkdp9X+l5oULDPxNmX5tJ7/OiXDVP92w6zYVaH17OnVAAHuv786myW+XR0viMiKTk9/c+0s2CXzK1gBL3rvbcqbjVVNCHnJJwabHkXA3p0bvhHq517mArNLRd1UVfuGdhVGF/UvxqYs23cTnADhu2zeIyKrVsIT0W9iu52Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3df2e9e6146so292865ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 09:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041226; x=1751646026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5A61G7PUNKEdRo+sEqDHQX7GS3CerU0voCXdiMu2PV4=;
        b=UTlrHBFjVDrF5Z6XbTpGprIjhUj29GHuvBTEb5s7IkABJqRKOvNX1i2YTZtAgS6NJN
         cGypObnOKWH+5yVoT/QDDT4Kw9uE5FK5YQiy7SQlKJKc39eAoyT/gqsHd7Phyjb1qhIN
         SkVRhuNFthuJh3VpM28UV0asPf/3KTYWJecZHhHLueNcAs8DvVR+7YNllBMvXxmTuLIM
         JewPOHTdZ2ANYRRu96q7Z67V/AHMzkMMdQNn5JujGXRbTm4Io+c7bfzuiKLsFNWRjzLx
         gLeHylN3STdN7RpDgWlw7fFRCc+lMlEwup789q8+w+nsRW1IYY0FyQBz2jxKXJRKo524
         ApMg==
X-Forwarded-Encrypted: i=1; AJvYcCVJUtOEhcdwCcQ4dyqZIA6KVgekLBdvS5bMJeJZycpas8oRJu6hqH2ihIwPxvHx8w0cMNhYzZlgv+4CoyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSyBqhl6SdV42jHdSq6E4Fw4oBBqKbjahJyjuh9lrDHRVrPtI
	2tmccui/ZK3lLxcfGZwgwpjbavjtYdD4CsbF2Bh6EmQUQd1q5zec+i5IwiBwb/rdNomkHL/otMZ
	IgwDq49GnjRNBffUL6f7DdHeBqI7JczEaonktFGLIOhvn946woAHDuVSaeWA=
X-Google-Smtp-Source: AGHT+IGkPYN7X/JcstY6bCruPJz0QsS52JrH0umdKHfUNrybgCUj5wTmbqtC/Umym++72tZEfcdThlzSRT9K8moA7gYKJRBTwf/W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:3df:2d65:c27a with SMTP id
 e9e14a558f8ab-3df4ab5674emr48020675ab.1.1751041225935; Fri, 27 Jun 2025
 09:20:25 -0700 (PDT)
Date: Fri, 27 Jun 2025 09:20:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685ec4c9.a00a0220.129264.000c.GAE@google.com>
Subject: [syzbot] [block?] BUG: sleeping function called from invalid context
 in __xas_nomem (2)
From: syzbot <syzbot+ea4c8fd177a47338881a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86731a2a651e Linux 6.16-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1630bb0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ad206eb0100c6a2
dashboard link: https://syzkaller.appspot.com/bug?extid=ea4c8fd177a47338881a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-86731a2a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e7ff33d1e1f/vmlinux-86731a2a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1bb9a09c88bb/bzImage-86731a2a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea4c8fd177a47338881a@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6843, name: syz.1.211
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
1 lock held by syz.1.211/6843:
 #0: ffffffff8e5c47c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_release include/linux/rcupdate.h:341 [inline]
 #0: ffffffff8e5c47c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 #0: ffffffff8e5c47c0 (rcu_read_lock){....}-{1:3}, at: brd_insert_page drivers/block/brd.c:65 [inline]
 #0: ffffffff8e5c47c0 (rcu_read_lock){....}-{1:3}, at: brd_rw_bvec drivers/block/brd.c:121 [inline]
 #0: ffffffff8e5c47c0 (rcu_read_lock){....}-{1:3}, at: brd_submit_bio+0x935/0x10a0 drivers/block/brd.c:191
CPU: 1 UID: 0 PID: 6843 Comm: syz.1.211 Not tainted 6.16.0-rc3-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 __might_resched+0x3c0/0x5e0 kernel/sched/core.c:8800
 might_alloc include/linux/sched/mm.h:321 [inline]
 might_alloc include/linux/sched/mm.h:316 [inline]
 slab_pre_alloc_hook mm/slub.c:4099 [inline]
 slab_alloc_node mm/slub.c:4177 [inline]
 kmem_cache_alloc_lru_noprof+0x2d2/0x3b0 mm/slub.c:4216
 __xas_nomem+0x266/0x670 lib/xarray.c:341
 __xa_cmpxchg_raw lib/xarray.c:1786 [inline]
 __xa_cmpxchg+0x119/0x290 lib/xarray.c:1766
 brd_insert_page drivers/block/brd.c:72 [inline]
 brd_rw_bvec drivers/block/brd.c:121 [inline]
 brd_submit_bio+0x9ce/0x10a0 drivers/block/brd.c:191
 __submit_bio+0x301/0x690 block/blk-core.c:644
 __submit_bio_noacct block/blk-core.c:690 [inline]
 submit_bio_noacct_nocheck+0x852/0xd30 block/blk-core.c:753
 submit_bio_noacct+0x50d/0x1eb0 block/blk-core.c:874
 __blkdev_direct_IO block/fops.c:257 [inline]
 blkdev_direct_IO+0x1647/0x1ff0 block/fops.c:433
 blkdev_direct_write block/fops.c:701 [inline]
 blkdev_write_iter+0x6fd/0xdf0 block/fops.c:768
 do_iter_readv_writev+0x654/0x950 fs/read_write.c:827
 vfs_writev+0x35f/0xde0 fs/read_write.c:1057
 do_writev+0x132/0x340 fs/read_write.c:1103
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f11579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f503655c EFLAGS: 00000296 ORIG_RAX: 0000000000000092
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000080000a40
RDX: 0000000000000021 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

