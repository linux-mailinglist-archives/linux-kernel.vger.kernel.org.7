Return-Path: <linux-kernel+bounces-891884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAFFC43B8E
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF581889677
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 10:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C0B2D97A1;
	Sun,  9 Nov 2025 10:15:37 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96031FF1B5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762683336; cv=none; b=pOhrPZ307yZXdwZhnFS4K/3kUnIlMLkGquSQrjbeSDnS91XJL2i+U1CSgSriW4XShGKKdcXfhJkXyJG1s2ejkakINc/XBEUwWrnyiuAhjFMwr1pyYL3fGh1vqVMBZukDXD4g3pRMCHelb691327K4pCkVWOgLhYyeaHe/H94bw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762683336; c=relaxed/simple;
	bh=JoJpjaNCesMsEk/LnuAxI9vwz7fODrhFaOeqt+A+B1g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jnyiABNYW2ohbVCeX8jixDZMi6xgGhzMqYmtsUk078IU4QXXe+nvAMQ8S3cWxVQxm7VFadgOCagJv4JSAB6rpMMFUfEIjHoPxGg4m4UIHmA8N4yRFUKiqgxRXWcqgQ++USi5U8bxjbt1bnlGQBvPxsewWbzVlHVG/VomnVZsL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-432f8352633so61910855ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 02:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762683334; x=1763288134;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TusO6l7rENag8kyO6sxtwjm6OOmX9LukE12Q6Ye/4I=;
        b=kaexcr7Gm+yySedDJM8EkboC4W1ExBQg9qvqI4aP7L0pAiVREmZcJMAwEnxXgSKcIq
         9v7QbMRqqeyM6q4xza+NopgAIzmQapZFMcc4sW6z7bEmpB+eIYbqQfgkQ614tPI1BRLd
         CzrWTLOleB2Y3+M0xIGEOWoAGtidiTkJsKDMOWDlOVpocFaUynszuNykrOJawSy3Uaf/
         2AOlXNNjDLgwlEq1d8sTAqBCiyfmZZ++d4nS6yzK5UbYRXzLwJFoNNzAiKdQoVrDw1Ay
         JE4vOgeNbK2IA2mYQ4npbawZ8gMX294FsF2LAq/OnHkFaIiLoPNVZJiEPm7v/V7E1VGK
         eGRw==
X-Gm-Message-State: AOJu0YwoWHbHykxkSYElVon0aOQC+6+dXDz4Sh4LXqXqkv9Wy9TuXCi3
	gx9htZmhEY75OypZ//U7ZncOPXthShbxSahRVUm5eDkNYf8Q8Pjm9Z/iT9NrNaX8C/Z0KV8cYyK
	k1V19AMikQWUZcAoV3pp2H3eZahRh/7RsJsPjK63WOh8JnHYJ1V0VHQRqx5cIgQ==
X-Google-Smtp-Source: AGHT+IHx6FDK+IL+nlPayW1BJNFMc3mn7GbmR7tl/F+f15FEcbUwVtRr1bXUvSuNzKwZTvAneuK9Kx50U8W1UNOf3GJHOk5uRFH0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:250d:b0:433:7a2f:a410 with SMTP id
 e9e14a558f8ab-4337a2fa653mr19307215ab.23.1762683333938; Sun, 09 Nov 2025
 02:15:33 -0800 (PST)
Date: Sun, 09 Nov 2025 02:15:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691069c5.a70a0220.22f260.00ab.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in put_pid_ns
From: syzbot <syzbot+513ead8ebc465c343285@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c0826a5d9aa Add linux-next specific files for 20251107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=112b2a92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f8fcc6438a785e7
dashboard link: https://syzkaller.appspot.com/bug?extid=513ead8ebc465c343285
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b76dc0ec17f/disk-9c0826a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/522b6d2a1d1d/vmlinux-9c0826a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a58225d70f3/bzImage-9c0826a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+513ead8ebc465c343285@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:255 at __ns_ref_put include/linux/ns_common.h:255 [inline], CPU#1: syz.3.216/6577
WARNING: ./include/linux/ns_common.h:255 at put_pid_ns+0x113/0x150 kernel/pid_namespace.c:187, CPU#1: syz.3.216/6577
Modules linked in:
CPU: 1 UID: 60929 PID: 6577 Comm: syz.3.216 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_put include/linux/ns_common.h:255 [inline]
RIP: 0010:put_pid_ns+0x113/0x150 kernel/pid_namespace.c:187
Code: ab cc ff bf 01 00 00 00 89 ee e8 58 b9 03 00 85 ed 7e 1c e8 0f b5 03 00 5b 41 5e 41 5f 5d c3 cc cc cc cc cc e8 fe b4 03 00 90 <0f> 0b 90 eb 95 e8 f3 b4 03 00 4c 89 f7 be 03 00 00 00 5b 41 5e 41
RSP: 0018:ffffc900179e7a68 EFLAGS: 00010293
RAX: ffffffff81be1b32 RBX: ffff888075ae0810 RCX: ffff88802f758000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffff888075ae097b R09: 1ffff1100eb5c12f
R10: dffffc0000000000 R11: ffffed100eb5c130 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff888075ae0978 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125b79000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3ee428 CR3: 0000000075a66000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_nsproxy+0x13a/0x560 kernel/nsproxy.c:195
 do_exit+0x6b8/0x2300 kernel/exit.c:969
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1111
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x87/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2e9/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f224db8f6c9
Code: Unable to access opcode bytes at 0x7f224db8f69f.
RSP: 002b:00007f224e9e90e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f224dde5fa8 RCX: 00007f224db8f6c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f224dde5fa8
RBP: 00007f224dde5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f224dde6038 R14: 00007ffdda9ff3c0 R15: 00007ffdda9ff4a8
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

