Return-Path: <linux-kernel+bounces-892893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35EBC460DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5658189027E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D8A305979;
	Mon, 10 Nov 2025 10:50:32 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D6211A14
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771832; cv=none; b=mpXPQG1BHcLWJBZyICjGCXtiiREo2GuhJj6aPgtNMyE7UZHdqPG/0EaBxYSMXNQVxjQu6dyoeN5rvofNlwbN8wDAz281M4jMAOOu/dlDW8FWlOWNx/gNMQe6L/IWNNvFLVtgoUn9i+e1NBswa+E6NLcNRz3vgcSmeLS/ZuHrPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771832; c=relaxed/simple;
	bh=Zhrp4LDk7dOUXkkLZz4/sptStXebClv+Ej6ovl65JYM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dZiBOVhG2b1RUNP/aUXCv67qCHM7M7ihdIKBXo/VcPScAldUxU57qa0OGPj683uygmhxSsBzB0b2K1SmLws90On9/FqhVmaBRac9C1r7Jy8N3WugkGwTc6PTU3Kya6UkR8F5ICS6xKiiSsxYQHZhfFUy1iOO29X8B6OGR1TtD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43300f41682so24183055ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771830; x=1763376630;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqgVM9CCWpCtNK7cyv2/w16aYIHi4Yzf7vfwrkHV6vE=;
        b=FNRb1rVsS8Y12dC8hSM2RlJ2H09TpFnDe3rD5riWhUk7OxQFYfheH9mBv+XqaQlUed
         HDD+eRXtV4ICzTyxFR02mnJmZqFXQhYkRlZ+iA40qRTSyJkWs6AzvDO1H2d60hvuHwuY
         01daryCm9t0xXmlTNcAPZDvrlMweCHhi/ff26suLY7rsAD9e4teUdY4Nz5Q2Muq/ed1k
         suXgyQPBX4o98eC1HmlIvxWuUgz/rRE2Q5GEeYOCURLXWGpmx9PJPdOIYzNvQxXa9AQz
         9V/UO23ikwOvhl79dhGRsaoT30ku6AyuSkLUqeN68uOvJLtA0ombtdkWjFVhYGMta8iX
         BPFw==
X-Forwarded-Encrypted: i=1; AJvYcCUF+PKU2p+JAjaJKMeoDNq4dmLYmeLPFT5zCboSTrv8L6NEvL6fac9I2p8rtBezGYiFlIaw/+vweGbNc+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9b8QAzdWEWDTsm2lxmrN+gpyduan7oMpaaC7zXOemDzhzx/RB
	Y7ACyocyE6ssf7QQAH2SxqV+Jcq3l03sg5uwy00Z11nONmXGQkVXgttlZs4JPIoGPTIfQz/skz4
	4lO7zg1KyopKr3YnYlQCMeasPNQKUgM4eUhkIltbm3Fy2zZxSIOldiTdGAPE=
X-Google-Smtp-Source: AGHT+IHVPLOFlpWEKucXQ7ln1rVHLKQy82gMbywydBWzmvUrylE97m2oukC3gH6R31IYd8ZJ3X0O34jOzAZYCO0w+UTtVa6pxNAC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a81:b0:433:773d:adc0 with SMTP id
 e9e14a558f8ab-433773db12amr83866195ab.17.1762771829788; Mon, 10 Nov 2025
 02:50:29 -0800 (PST)
Date: Mon, 10 Nov 2025 02:50:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911c375.a70a0220.22f260.00e2.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in prb_reserve_in_last
From: syzbot <syzbot+df3efe4853f4ce1836ea@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    df5d79720b15 Add linux-next specific files for 20251106
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11fc6532580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4204c002971894e3
dashboard link: https://syzkaller.appspot.com/bug?extid=df3efe4853f4ce1836ea
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c94253b384cb/disk-df5d7972.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9625b013dc5e/vmlinux-df5d7972.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f7a8fb31fb9f/bzImage-df5d7972.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df3efe4853f4ce1836ea@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/slub.c:6760 at free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6760, CPU#1: syz-executor/5836
Modules linked in:
CPU: 1 UID: 0 PID: 5836 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6760
Code: 44 89 f6 e8 f6 d0 fc ff 65 48 8b 05 fe ac 58 10 48 3b 44 24 08 75 57 48 83 c4 10 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc cc 90 <0f> 0b 90 65 48 8b 05 d9 ac 58 10 48 3b 44 24 08 75 32 48 89 df 48
------------[ cut here ]------------
WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278, CPU#1: syz-executor/5836
Modules linked in:
CPU: 1 UID: 0 PID: 5836 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 f7 45 1f 00 90 <0f> 0b 90 eb 05 e8 ec 45 1f 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
RSP: 0000:ffffc9000422f3a0 EFLAGS: 00010093
RAX: ffffffff81a238a9 RBX: 00003fffffffffff RCX: ffff8880789b0000
RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
RBP: 0000000000000012 R08: ffffc9000422f4e7 R09: 1ffff92000845e9c
R10: dffffc0000000000 R11: fffff52000845e9d R12: 0000000000000012
R13: 0000000000000000 R14: ffffffff8de2d650 R15: 1ffffffff1bca6c2
FS:  000055556d8e1500(0000) GS:ffff888125fc5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3d4427000 CR3: 0000000077ae4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 prb_reserve_in_last+0x574/0x18f0 kernel/printk/printk_ringbuffer.c:1447
 vprintk_store+0x641/0xd00 kernel/printk/printk.c:2273
 vprintk_emit+0x15f/0x590 kernel/printk/printk.c:2399
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 __show_regs+0x77/0x620 arch/x86/kernel/process_64.c:82
 show_regs+0x36/0x70 arch/x86/kernel/dumpstack.c:483
 __warn+0x182/0x4c0 kernel/panic.c:899
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x2be/0x4f0 lib/bug.c:215
 handle_bug+0x84/0x160 arch/x86/kernel/traps.c:338
 exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:392
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:616
RIP: 0010:free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6760
Code: 44 89 f6 e8 f6 d0 fc ff 65 48 8b 05 fe ac 58 10 48 3b 44 24 08 75 57 48 83 c4 10 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc cc 90 <0f> 0b 90 65 48 8b 05 d9 ac 58 10 48 3b 44 24 08 75 32 48 89 df 48
RSP: 0000:ffffc9000422fc48 EFLAGS: 00010206
RAX: 00000000ff000000 RBX: ffffea0000389000 RCX: ffffea0000389008
RDX: 0000000000000000 RSI: ffffffff8e240580 RDI: ffffea0000389000
RBP: 1ffff1100db81943 R08: ffffffff8f7d9077 R09: 1ffffffff1efb20e
R10: dffffc0000000000 R11: fffffbfff1efb20f R12: 1ffff1100db81936
R13: dffffc0000000000 R14: ffff88806dc0c9b0 R15: ffff888028ec3708
 ntfs_put_super+0x15b/0x1b0 fs/ntfs3/super.c:709
 generic_shutdown_super+0x135/0x2c0 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1723
 ntfs3_kill_sb+0x44/0x1b0 fs/ntfs3/super.c:1848
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1317
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2e9/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f715c7909f7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd679885e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f715c811d7d RCX: 00007f715c7909f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd679886a0
RBP: 00007ffd679886a0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd67989730
R13: 00007f715c811d7d R14: 000000000002be47 R15: 00007ffd67989770
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

