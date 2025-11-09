Return-Path: <linux-kernel+bounces-891798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B04FC4385D
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 05:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 397344E28D5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 04:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E00520FAB2;
	Sun,  9 Nov 2025 04:34:32 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8814A8B
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 04:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762662871; cv=none; b=Rr4MLAu5OEHK5IcMWSacZcL/GvwrIFVpS6Elu26/gaMp9ZeIgH8MouN0SYKRGb+WkKfRFN0P8K8pKqouWoV0gzRiVVqVw1xr3OQ8IMMLg8RTpibkur4nqDSzqlT844b2iIuyRV7oB1vyYoR6C3yjpxtQG6MV+TFp3WcDXMOsTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762662871; c=relaxed/simple;
	bh=1us21LeZ5Fhb2t+8+yjr/4a9T77CGM1Fw6ZZkxn0H14=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JCQnRmxSeSt56PZugACxSsPN76IjUn//6iT2EdsY7m0gJwUHdkubFFm6lCGKNN1qZEUqKU+dD55wEaB+XpjDhwaqjnE9zTajxT4jBItKocPiRMP0dYU6Kug6fNnlRWIx8d6TnkTKGiv4vI91UCg5uMyEmzqU0GaiWUVj88vU0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-43329b607e0so35480835ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 20:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762662869; x=1763267669;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JPnnnoOluDvBvAtrevvnCdC6xcG78znJuA5aqJ/ucQ=;
        b=h7Ih+Uo4/+Cp56jtKPJmGanmG6fHCP8Ib90Co5M56F3NVFeaMysI+sOGSGjVepEeDs
         R2IuBZIVBpJzlnv4hBkF596zpK66piYtA5EbwAUzIDUGAtmMxnbmLyinvwCQnVtOMCHP
         EiWgH04KQfJaEiWiCmW61gQEY4MXk1CEaxmHJofY5aa3qjTzAiPcxHHPMlusbsYN32pS
         +3GF0VvymcjeyTa423MAm2k8i4F4vUK2G9NrKk0eKn/PD3aYo54ysISSXkS0pJ9NIVMu
         TV7pG0ULgVpSmtOcZVXOUxgmLBQFrHCqfhCoPHaRnShOt4QvfLyNQJw4H8ZhjWrHJXHC
         i4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXsx8KCuwr105m4vLN7NWBk2aLWPDBwujvra9qhenKq3MOuJ9fesKq7qYWXSt1EaaoqwUS8BHhoOZmwxf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mBDmCP8wy4+fNv2TtBl+oruiplGa6Up9qBUcQEt5sLcN/2hc
	je7Y98NcUD20hqaKefL5jfl1P18v9Yx6MY/HoDdzo8EuY67eMA82dBwWrJgwAFKuVjXvflzZH1i
	lEfIAYFI5DAcWsczp495iGy2huDCUdA2mmYKufBd247BxHOlZGksebGBxRgc=
X-Google-Smtp-Source: AGHT+IHQiCNeilPHoB53wjdXpON4MkF7lkaJhjuj9j7OkmABAR+gJ3kvK24MR31wDLHgDKFC2wvhrPTnG40d1X2X3ABfAkvBHH3l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218e:b0:433:2b18:e8d with SMTP id
 e9e14a558f8ab-43367e2d974mr57528825ab.18.1762662869285; Sat, 08 Nov 2025
 20:34:29 -0800 (PST)
Date: Sat, 08 Nov 2025 20:34:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691019d5.a70a0220.22f260.0098.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in _prb_read_valid
From: syzbot <syzbot+b492b1871577c9dcaebc@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17490bd0527f Add linux-next specific files for 20251104
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=100f2114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a6439adcb87a9e
dashboard link: https://syzkaller.appspot.com/bug?extid=b492b1871577c9dcaebc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9b67f1f748d3/disk-17490bd0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2c8bd981892f/vmlinux-17490bd0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/83c27f8467c8/bzImage-17490bd0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b492b1871577c9dcaebc@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/slub.c:6756 at free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6756, CPU#0: syz-executor/5833
Modules linked in:
CPU: 0 UID: 0 PID: 5833 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6756
Code: 44 89 f6 e8 f6 d0 fc ff 65 48 8b 05 4e 43 58 10 48 3b 44 24 08 75 57 48 83 c4 10 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc cc 90 <0f> 0b 90 65 48 8b 05 29 43 58 10 48 3b 44 24 08 75 32 48 89 df 48
RSP: 0018:ffffc9000425fc88 EFLAGS: 00010206
RAX: 00000000ff000000 RBX: ffffea0000389300 RCX: ffffea0000389308
RDX: 0000000000000000 RSI: ffffffff8e24c120 RDI: ffffea0000389300
RBP: 1ffff1100457bd43 R08: ffffffff8f7d7d77 R09: 1ffffffff1efafae
------------[ cut here ]------------
WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278, CPU#0: syz-executor/5833
Modules linked in:
CPU: 0 UID: 0 PID: 5833 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 57 1a 1f 00 90 <0f> 0b 90 eb 05 e8 4c 1a 1f 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
RSP: 0018:ffffc9000425f220 EFLAGS: 00010293
RAX: ffffffff81a1f239 RBX: 00003fffffffffff RCX: ffff88802b5f9e80
RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
RBP: 0000000000000012 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000012
R13: 0000000000000000 R14: ffffc9000425f368 R15: 1ffffffff1bca682
FS:  0000555588454500(0000) GS:ffff888125ed8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc9e6a1b78 CR3: 0000000064e40000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 copy_data kernel/printk/printk_ringbuffer.c:1857 [inline]
 prb_read kernel/printk/printk_ringbuffer.c:1966 [inline]
 _prb_read_valid+0x672/0xa90 kernel/printk/printk_ringbuffer.c:2143
 prb_read_valid+0x3c/0x60 kernel/printk/printk_ringbuffer.c:2215
 printk_get_next_message+0x15c/0x7b0 kernel/printk/printk.c:2978
 console_emit_next_record kernel/printk/printk.c:3062 [inline]
 console_flush_one_record kernel/printk/printk.c:3194 [inline]
 console_flush_all+0x4cc/0xb10 kernel/printk/printk.c:3268
 __console_flush_and_unlock kernel/printk/printk.c:3298 [inline]
 console_unlock+0xbb/0x190 kernel/printk/printk.c:3338
 vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 __show_regs+0x225/0x620 arch/x86/kernel/process_64.c:90
 show_regs+0x36/0x70 arch/x86/kernel/dumpstack.c:483
 __warn+0x182/0x4c0 kernel/panic.c:899
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x2be/0x4f0 lib/bug.c:215
 handle_bug+0x84/0x160 arch/x86/kernel/traps.c:338
 exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:392
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:616
RIP: 0010:free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6756
Code: 44 89 f6 e8 f6 d0 fc ff 65 48 8b 05 4e 43 58 10 48 3b 44 24 08 75 57 48 83 c4 10 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc cc 90 <0f> 0b 90 65 48 8b 05 29 43 58 10 48 3b 44 24 08 75 32 48 89 df 48
RSP: 0018:ffffc9000425fc88 EFLAGS: 00010206
RAX: 00000000ff000000 RBX: ffffea0000389300 RCX: ffffea0000389308
RDX: 0000000000000000 RSI: ffffffff8e24c120 RDI: ffffea0000389300
RBP: 1ffff1100457bd43 R08: ffffffff8f7d7d77 R09: 1ffffffff1efafae
R10: dffffc0000000000 R11: fffffbfff1efafaf R12: 1ffff1100457bd36
R13: dffffc0000000000 R14: ffff888022bde9b0 R15: ffff88803293a448
 ntfs_put_super+0x15b/0x1b0 fs/ntfs3/super.c:708
 generic_shutdown_super+0x135/0x2c0 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1723
 ntfs3_kill_sb+0x44/0x1b0 fs/ntfs3/super.c:1850
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1317
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2cd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd6175909f7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffda216ea18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fd617611d7d RCX: 00007fd6175909f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffda216ead0
RBP: 00007ffda216ead0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffda216fb60
R13: 00007fd617611d7d R14: 0000000000024391 R15: 00007ffda216fba0
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

