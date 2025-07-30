Return-Path: <linux-kernel+bounces-751358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C4B1683F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E191AA7D84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1721CC56;
	Wed, 30 Jul 2025 21:21:38 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0D2907
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753910498; cv=none; b=ZOM3DFDtOLUmoyhIK3livfBmkotyvlSbU+L/Pa+yyRNvoacsAVftT55imfetHANtxOLffcggF8e08aLfPqnaKQdkJOErF9TBstDdS8IU3CFCyodpp832wWCGS1IiuoRXah9WWXkBMihxDF57pTfif6wp4qp9sA3lGE0U27Hllro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753910498; c=relaxed/simple;
	bh=b80eulaWIERMCyRUDwJXLCGu8Mx3z9QN7VbdlbOQGjM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YwM4u6dmcaU5XUPGKapEYJ16R1RBU2IP0DnXY3153pWudPZzoC7z+b1pmY0E85FwoirHFQFy5R318S1Ctl65tGnHpJSstR1hcmuLqPnaDV923UksZBurIgYkCCPPgZ52I4/dVExUiUaQJ4bhOxz93OrUDC9UX9ZatN29DoEQYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86463467dddso30926939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753910496; x=1754515296;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3Vzg17W+qsKpjUnwHYEZW0KbJegntvfD1EYEozr3p8=;
        b=SNUOu3GZAvNtSzSoGiP1SB/gvv+pLzVSQznawSkvOPKZj38Niq+J7J9EKcCUWudK8L
         zUKlspsvjQTaS345gmAY+hJ+0zBDPQuSx+FMLdBeX9IfwLV8AMU0XKx4gulFAFGEiVlq
         uKzQThGmVYBLz/LAPOVWqBrR9FDG1USJs7Ns3h0lXxKKnVxFZj6gf919HH/LsexC7kgt
         OZT/W/75pGfF9SNTQb8UT3TNo3zjQj3fH+VWto+qUhAWxFgtASOiVHrH+ZbeCzffzWfS
         sScbXwaGTsfVvSaylJpKetMzoxfTZ8OcwxyN7ZE+V7jmftpWdUWYPS99mCnQI28vvOEt
         6dpA==
X-Forwarded-Encrypted: i=1; AJvYcCUuDzMtTnUkxCYMNIMf7MSNVgVeHuRM5XiO6QZKpNLZmSBy5lrPti6KI1pY0ozW8gxmnIRNCjWIxrP6opA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmz8MTszc8HuPWqJRKfAGuZ7k9xf5FIJTrJk4NWTtKkVpwtaO
	SIQ2KocUmK1bS8IQDN+Z5zBphNW5Osu1eGCYqhqoddgr6vsN72Dkb77MQ2Vx/0aruIfWlcl0uzl
	CpT3nyWlH0EhiAHFEIpEuWzIrgvjKmtPtHrEOSSePm6nUZizJf7Rri0oSF70=
X-Google-Smtp-Source: AGHT+IFsoSOY2EtYUgiiufvJ/qPDNg1vEp2n8/OUFT/3GdbLYNU/MRt2SH3bM7iMn6SefaO3eSB0EEI26LXkhKfVvJcl40yrftBg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:600f:b0:86d:9ec7:267e with SMTP id
 ca18e2360f4ac-881374abe60mr865520839f.4.1753910495770; Wed, 30 Jul 2025
 14:21:35 -0700 (PDT)
Date: Wed, 30 Jul 2025 14:21:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688a8cdf.a00a0220.26d0e1.002f.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel panic: in transaction restart:
 transaction_restart_relock, last restarted by
From: syzbot <syzbot+d3fa2fb715cfcc9d201d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b290aae788e Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13faeca2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d57eeb4d30293deb
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fa2fb715cfcc9d201d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4b290aae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5deb700fdcf/vmlinux-4b290aae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/303ba5e224e7/bzImage-4b290aae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3fa2fb715cfcc9d201d@syzkaller.appspotmail.com

ppp0: PPP: VJ uncompressed error
loop0: detected capacity change from 0 to 32768
bcachefs (loop0): starting version 1.7: mi_btree_bitmap opts=errors=continue,metadata_checksum=none,data_checksum=none,compression=lz4,foreground_target=invalid label 255,nocow
  allowing incompatible features above 0.0: (unknown version)
  features: lz4,new_siphash,inline_data,new_extent_overwrite,btree_ptr_v2,new_varint,journal_no_flush,alloc_v2,extents_across_btree_nodes
bcachefs (loop0): Using encoding defined by superblock: utf8-12.1.0
bcachefs (loop0): initializing new filesystem
bcachefs (loop0): going read-write
bcachefs (loop0): marking superblocks
bcachefs (loop0): initializing freespace
bcachefs (loop0): done initializing freespace
bcachefs (loop0): reading snapshots table
bcachefs (loop0): reading snapshots done
bcachefs (loop0):  loop0: Superblock write was silently dropped! (seq 0 expected 42)
bcachefs (loop0): done starting filesystem
Kernel panic - not syncing: in transaction restart: transaction_restart_relock, last restarted by
[<0>] btree_trans_restart_ip fs/bcachefs/btree_iter.h:364 [inline]
[<0>] btree_trans_restart fs/bcachefs/btree_iter.h:372 [inline]
[<0>] btree_path_get_locks+0x3ad/0xa30 fs/bcachefs/btree_locking.c:491
[<0>] __bch2_trans_relock+0x234/0x5f0 fs/bcachefs/btree_locking.c:826
[<0>] bch2_new_inode fs/bcachefs/fs.c:484 [inline]
[<0>] bch2_inode_hash_init_insert+0x118/0x170 fs/bcachefs/fs.c:501
[<0>] bch2_vfs_inode_get+0x272/0x330 fs/bcachefs/fs.c:524
[<0>] bch2_fs_get_tree+0xfe4/0x1520 fs/bcachefs/fs.c:2572
[<0>] vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
[<0>] do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
[<0>] do_mount fs/namespace.c:4133 [inline]
[<0>] __do_sys_mount fs/namespace.c:4344 [inline]
[<0>] __se_sys_mount+0x317/0x410 fs/namespace.c:4321
[<0>] do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
[<0>] do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f
CPU: 0 UID: 0 PID: 5332 Comm: syz.0.0 Not tainted 6.16.0-syzkaller-04405-g4b290aae788e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x99/0x250 lib/dump_stack.c:120
 panic+0x2db/0x790 kernel/panic.c:442
 bch2_trans_in_restart_error+0xdb/0x110 fs/bcachefs/btree_iter.c:1455
 bch2_trans_put+0x1012/0x1220 fs/bcachefs/btree_iter.c:3559
 bch2_vfs_inode_get+0x285/0x330 fs/bcachefs/fs.c:525
 bch2_fs_get_tree+0xfe4/0x1520 fs/bcachefs/fs.c:2572
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f699279014a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6993591e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6993591ef0 RCX: 00007f699279014a
RDX: 00002000000000c0 RSI: 00002000000003c0 RDI: 00007f6993591eb0
RBP: 00002000000000c0 R08: 00007f6993591ef0 R09: 0000000000000810
R10: 0000000000000810 R11: 0000000000000246 R12: 00002000000003c0
R13: 00007f6993591eb0 R14: 0000000000005aa3 R15: 0000200000000040
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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

