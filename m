Return-Path: <linux-kernel+bounces-838132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D1BAE838
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 739547AEE01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065FA285CAB;
	Tue, 30 Sep 2025 20:17:38 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AF1E766E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263457; cv=none; b=cGQmPgjUQwLAvx0e5ASZWgH1e1aQcehv8Oh2o7Mf9GYCuUrTbcKh0CHRF4Wj7odVMPgIvEdzH8cLCAzv1Isv7V2sa+MrsXyjBP59amC/sT/Lb9x2c9tRF5+1/gaKXWWIZEwGYitLmuJtkak2kMqd0d6YJC6+nzmGCzY6OH/NMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263457; c=relaxed/simple;
	bh=XtreJdnQuuYeaIcZ8Juz1KCPjR+edY1Ffz0apbbCTEQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HxtWtuOEdQkfmWgypaK1fejo8bQ9x73gsqhQXaa0xI8inlYQdeCAJnBH+cydu9AsuAJ6//GTmP2vu3nnLEmaUpI4/UsPtTn7j6xrOf3SHuN8jAcgYRmF3tAYJZXSnhS1kkZsFq3KmYI25Ux/NpA5xqn+VDk3uFxqdNDZfe+XDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88c2f1635e1so661136939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263455; x=1759868255;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSAWtj1RDBXdJgZr9yOe92W4TRPCsog5bKILrPHk5f8=;
        b=pGsFel8cK97jXrnQYWM1axxchgrfRT3VsZkn5qwgeBxTYtzkYGSRg9hT6BQThew8bT
         95Wi2/3nJiVCg1yCPkmy5koyj6vMKMlLObkXG4T4vDKye7w9qbRfXO8MCWrT9EC0A0At
         mPXfQOxPxDhB4h7TBoDBl2vnIlIjPokkhyG8mclKHbASIgfQekAP2Q/NxcWTKT6ZDIYn
         NYrxrHg9BgcTmFNqEXeF/7aNFK5AU8vrKJRAjTgo+IT4qunZEtFuEze3Hw4hQ6YfYb/m
         cKpSmPSK0Eb6FGX3jbE3KcuYTiiR17m3mqWGfZFGZvzLd3hv5kP0o6HRJb6DTKF43RCP
         Vl8g==
X-Forwarded-Encrypted: i=1; AJvYcCVRqeHHDNeOtXMT0xYZE9Ru9SKXynvGeMvjcKozZ2Cd7OGW0odA7sSr3RQxfrUYpg4TXKsA2k5UZkk5gbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8NsMA9pWdSlUYQxMq7UusprmSdDp+5ca3rT59FHVAaMcoF2i
	vWSOajSz4NYHOxtQFzTFiWVY3gcCSLlyREjJSEf8UegvjT/ITvgK/S2HFg4Vtrwg42lu8Ao7AFL
	uWCO9rJMLO6IMWKPKjYoRTn8euld4paOb6Gnw2OTqkq3Yso9a0dxq+KHD8xk=
X-Google-Smtp-Source: AGHT+IHmkt02t9H7XVuLG0CXb97MIBC7P5H1LMRNwv0cGGXg0vbEiTZcdjKS9KTFK+UvYgDruji6b6LXKNVkIhxUmviz1H287H9K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1787:b0:42d:7d52:db53 with SMTP id
 e9e14a558f8ab-42d81614fe1mr17397045ab.15.1759263454886; Tue, 30 Sep 2025
 13:17:34 -0700 (PDT)
Date: Tue, 30 Sep 2025 13:17:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc3ade.a70a0220.10c4b.015d.GAE@google.com>
Subject: [syzbot] [isofs?] VFS: Busy inodes after unmount (use-after-free) (3)
From: syzbot <syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    30d4efb2f5a5 Merge tag 'for-linus-6.18-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1350d05b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eb55ce880562a8c
dashboard link: https://syzkaller.appspot.com/bug?extid=1d79ebe5383fc016cf07
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f17c14580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d80a7c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b7f58792107b/disk-30d4efb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a0647491b90/vmlinux-30d4efb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9829a72408d5/bzImage-30d4efb2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ec44ab2c5fdc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com

VFS: Busy inodes after unmount of loop0 (iso9660)
------------[ cut here ]------------
kernel BUG at fs/super.c:653!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5985 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:generic_shutdown_super+0x2bc/0x2c0 fs/super.c:651
Code: 03 42 80 3c 28 00 74 08 4c 89 f7 e8 6e 32 f3 ff 49 8b 16 48 81 c3 d0 07 00 00 48 c7 c7 60 90 d8 8a 48 89 de e8 85 59 fe fe 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc9000419fd20 EFLAGS: 00010246
RAX: 0000000000000031 RBX: ffff88803956a7d0 RCX: 8b706059fb7f3300
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff110072ad51b R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52000833f49 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff8d5b82e0 R15: ffff88803956a8d8
FS:  0000555590698500(0000) GS:ffff888127125000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bb0ed4b1b8 CR3: 0000000028c78000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kill_block_super+0x44/0x90 fs/super.c:1723
 deactivate_locked_super+0xb9/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1318
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff17a1f01f7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff2497d5b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007ff17a271d7d RCX: 00007ff17a1f01f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff2497d670
RBP: 00007fff2497d670 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff2497e700
R13: 00007ff17a271d7d R14: 000000000001bfd3 R15: 00007fff2497e740
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:generic_shutdown_super+0x2bc/0x2c0 fs/super.c:651
Code: 03 42 80 3c 28 00 74 08 4c 89 f7 e8 6e 32 f3 ff 49 8b 16 48 81 c3 d0 07 00 00 48 c7 c7 60 90 d8 8a 48 89 de e8 85 59 fe fe 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc9000419fd20 EFLAGS: 00010246
RAX: 0000000000000031 RBX: ffff88803956a7d0 RCX: 8b706059fb7f3300
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff110072ad51b R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52000833f49 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff8d5b82e0 R15: ffff88803956a8d8
FS:  0000555590698500(0000) GS:ffff888127125000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bb0ed4b1b8 CR3: 0000000028c78000 CR4: 00000000003526f0


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

