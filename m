Return-Path: <linux-kernel+bounces-738055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE8B0B3BD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 08:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F843B8CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 06:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B4E1A2389;
	Sun, 20 Jul 2025 06:16:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3C38B
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992194; cv=none; b=l+8l5TQ2z6MJCXoGGHUO0VMO4EylHAB4vtmRH7h3F6j//obwuk8Uou48rbs+HcMpXbthRgQeyy5oCMKbZUUU8EtrOFa56td1BsPvtmFbbjRcKQ5t3ITSlK96frFMMZI17CA/lSN/BPBGZsCG4gQks8iL/Dz5lXSglnufaPFKPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992194; c=relaxed/simple;
	bh=/jb9iBtc2ifuiWiH908/NL1yWtw7Wx+KkPYoSBd6r7o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=USY+ZG6j50r3XbatWq20daaun6GAQ6aixWd58K5gzqg4xT4y/MujBdr6A0jija2UGX+eWp+e27JTZtbH5on6u8J4/n/G9UOD+0Vd7WotzLqUXMyfaosA/xawOjMAwfNQQqVtE8diob4dl8v3bHNltYoZ0E2rlk4BuNGYfqINDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e26ad54369so39323435ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 23:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752992192; x=1753596992;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d41DgRagL6N8vrWtMdzJjrW3+CWuP2xkB8rnWhXmK+M=;
        b=PXGqVrAZKD16/KF4JvXas43ZE3dKXGR196+PvYI4TdORrLtTmg/APKJ2xRqaE6OHEo
         8qjYdQrCpJ13+Q3RRTDlPVnhqsQGpw4u9cdAMdkDoCtzb22M6RnKm0w7jqWlm5j8SeZr
         P8zOz9sudjWq/mM1rlIopoxrXO2Pb/koETQEFvrthhSqOx6bexNRro5kS0HaLqd75U15
         keBCFwctr3G9JR/19jf0RtTwCElhBvYxzYs5jsHnrM0el2FKQQA9SWWkG7HTXcxpLmlz
         T1ERELDhMJr9dGeaeYh0hQxa/naSo9mLzg7+hAcRy3QyWjrWVXz7HOxPf7xr3QeLE3ZU
         fbag==
X-Forwarded-Encrypted: i=1; AJvYcCW0YLZkncf6ZY4ZALMho96XqCjHvFUQtznPFGzr7GIIFyfUleU/ZLG9bFH93JKpGNxEpAMm7nQ486YM2iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwdibuOoJUzA/lVZFl1Jt0MgnjGLt8Xp4pH/W5y5h0ye+iSqN0
	8IdYpm/d6m4P2DMUi8JW+78T2Vut+DPPnTpPtIYOeHIS/VtoX8t3nMBz8J/eIREP7tF0z+ZS6Bj
	kKTAAxQJWn+lcW09FEE3gra8WbpoDFA+y/N0alWTKXqE6eqdkciU8V6yrk1Q=
X-Google-Smtp-Source: AGHT+IH6RhVqN7nEMgrv2lP+4CZlg9RhaQnEtn3G6QRs0MO7K17tc9f9mLVmAvHmV7CGAYR3T4opgmETt58z5w7slOuAdA50Fbh/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:441c:20b0:3d9:2992:671b with SMTP id
 e9e14a558f8ab-3e295994634mr50541775ab.4.1752992192059; Sat, 19 Jul 2025
 23:16:32 -0700 (PDT)
Date: Sat, 19 Jul 2025 23:16:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c89c0.a70a0220.693ce.00b1.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in do_bch2_trans_commit_to_journal_replay
From: syzbot <syzbot+e3f91c76099a777cbf16@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d086c886ceb9 Add linux-next specific files for 20250718
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=174f04f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc0cd9fdf69889c3
dashboard link: https://syzkaller.appspot.com/bug?extid=e3f91c76099a777cbf16
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4435f80a19c4/disk-d086c886.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a7dc57a5ea3/vmlinux-d086c886.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da9f2dc22ae1/bzImage-d086c886.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3f91c76099a777cbf16@syzkaller.appspotmail.com

  features: lz4,new_siphash,inline_data,new_extent_overwrite,btree_ptr_v2,new_varint,journal_no_flush,alloc_v2,extents_across_btree_nodes
bcachefs (loop0): Using encoding defined by superblock: utf8-12.1.0
bcachefs (loop0): initializing new filesystem
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_trans_commit.c:1027!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 7573 Comm: syz.0.296 Not tainted 6.16.0-rc6-next-20250718-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:do_bch2_trans_commit_to_journal_replay+0x10f3/0x1120 fs/bcachefs/btree_trans_commit.c:1027
Code: 48 c7 c1 79 7b 99 8d 49 89 c0 e8 f8 7a 2b 00 4c 89 ff e8 10 c7 0d 00 48 8b 7c 24 68 e8 d6 1b 00 00 90 0f 0b e8 4e e3 92 fd 90 <0f> 0b e8 46 e3 92 fd eb ad e8 3f e3 92 fd eb a6 e8 38 e3 92 fd 90
RSP: 0018:ffffc9000494edb8 EFLAGS: 00010283
RAX: ffffffff842ccdc2 RBX: 00000000fffff7ab RCX: 0000000000080000
RDX: ffffc9000b829000 RSI: 0000000000043784 RDI: 0000000000043785
RBP: ffff88807e458000 R08: ffff888063f849e3 R09: 1ffff1100c7f093c
R10: dffffc0000000000 R11: ffffed100c7f093d R12: ffff88807e458028
R13: 0000000000000000 R14: ffff88807e4580d2 R15: ffff8880269a6000
FS:  00007f6f1c5f26c0(0000) GS:ffff888125be3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc41ced2048 CR3: 0000000059546000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __bch2_trans_commit+0x1b13/0x8a70 fs/bcachefs/btree_trans_commit.c:1060
 bch2_trans_commit fs/bcachefs/btree_update.h:270 [inline]
 bch2_dev_usage_init+0x22c/0x3f0 fs/bcachefs/disk_accounting.c:934
 bch2_fs_initialize+0x4b5/0xe60 fs/bcachefs/recovery.c:1179
 bch2_fs_start+0xa00/0xcc0 fs/bcachefs/super.c:1217
 bch2_fs_get_tree+0xb39/0x1540 fs/bcachefs/fs.c:2456
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6f1b79014a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6f1c5f1e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6f1c5f1ef0 RCX: 00007f6f1b79014a
RDX: 0000200000000140 RSI: 0000200000000100 RDI: 00007f6f1c5f1eb0
RBP: 0000200000000140 R08: 00007f6f1c5f1ef0 R09: 0000000002800000
R10: 0000000002800000 R11: 0000000000000246 R12: 0000200000000100
R13: 00007f6f1c5f1eb0 R14: 0000000000005a7a R15: 0000200000000300
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_bch2_trans_commit_to_journal_replay+0x10f3/0x1120 fs/bcachefs/btree_trans_commit.c:1027
Code: 48 c7 c1 79 7b 99 8d 49 89 c0 e8 f8 7a 2b 00 4c 89 ff e8 10 c7 0d 00 48 8b 7c 24 68 e8 d6 1b 00 00 90 0f 0b e8 4e e3 92 fd 90 <0f> 0b e8 46 e3 92 fd eb ad e8 3f e3 92 fd eb a6 e8 38 e3 92 fd 90
RSP: 0018:ffffc9000494edb8 EFLAGS: 00010283
RAX: ffffffff842ccdc2 RBX: 00000000fffff7ab RCX: 0000000000080000
RDX: ffffc9000b829000 RSI: 0000000000043784 RDI: 0000000000043785
RBP: ffff88807e458000 R08: ffff888063f849e3 R09: 1ffff1100c7f093c
R10: dffffc0000000000 R11: ffffed100c7f093d R12: ffff88807e458028
R13: 0000000000000000 R14: ffff88807e4580d2 R15: ffff8880269a6000
FS:  00007f6f1c5f26c0(0000) GS:ffff888125ce3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8ab0e9000 CR3: 0000000059546000 CR4: 00000000003526f0


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

