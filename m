Return-Path: <linux-kernel+bounces-804699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62658B47BB5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B9E1B21A47
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CCA28682;
	Sun,  7 Sep 2025 13:59:33 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B161E511
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757253572; cv=none; b=kCcA1gMRED3Ep+ePjbVbZkz4uouN37X2PgMxnuSRXnYou7cbgAsmcQ65X5VRvpfjWNP29x5QOPaxbG/iX2e2VfJUm0V86HeMkqa1p3zC2M4Xnu2khYWJxEGyJjgQK5YXWcvocGGxHNWqAM1hJbAt5y0Fh96+W6kp5TE6s18NBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757253572; c=relaxed/simple;
	bh=nqVbFJ70vW1rKadGZDVK+26fYTbsJVWlYy030ZJlCRg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nJGOJk0jLzt3qtJ9yuDQuIyDOzcqhQWyovBpb+s4W9fMsutJlvUSfAeA+EvJCxzESMNcic2XrrdrLuY1foFlRfUnnDU5R6P3RqGCPGyBbX7aFAGXA3x+m07gpVXVvDR5dNi0VT7xDvUxJhY81wlayB8bq1rF6cpK6G0QpSvVTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88a930b80bdso78092139f.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 06:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757253570; x=1757858370;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLBHzWOATpxaXV05bDjFGmpQdLV2z3/qrf5c3Gk0dpc=;
        b=MULrENGNzBYilpH85YnftXKF7fyHZV0n8x49xs4xAUNYQpAc8qF+ycBe2I5cP19pSv
         ASSGnwGwIzgoUd+gBU4om/86pNQ7MkV9qrpkOoye4RpTezflZfX8yYSGzxjQgakHFQKV
         BQ3srfWuMLaZw2BRV1EbJS1qbj1YgXVnQsSth3x6NXdcnjOmPOYcrNjHJhP4Q/EV6vZB
         YlwxTMve9nPv2Fx482azB6XKofsOB7wJGkSUxMxSVc7Cp/cFNQYqH1FKM10pS2rPTuFW
         +5m5VBKjSORNYUFur0Op3lAfjt1LJhuiOUnahmg0glMRBXNls7HLKfOnArY3RoVfz3dS
         bMGg==
X-Forwarded-Encrypted: i=1; AJvYcCVCUzLXugTGbZxK6S/T1dN/be9pQ8rKQMIuOf2lMxEz6LPTiuJd5UQqAaVbqS0snFgeDO/FglDuuE+nDhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCIRPzFnV9SFdSfSW6ExLQFlxdT1xQOzbKwumxN7Se2zIEUUaM
	RIJRxd9kKWQzpvA4NcpR8uRw6uxQIhoJoRYD6Jc2figti7lpBPTb2K4zR1dlZommF8ceM8rLGNa
	l3WmYjDZ9OaBQPmz0VUAve5d+rMIexamPuP/z5qD/Gralvv1EXXnlWwpu3Ko=
X-Google-Smtp-Source: AGHT+IEVtGvErnSymJtVXd+9Qgp9dRx36y4QCLqFZNPAXOmTgg4qOMa/d9XAw3S9d98YEcdPD6myD2Hx/LIY0u4xjwx1AOjOBeBA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2287:b0:3ec:6e58:be9f with SMTP id
 e9e14a558f8ab-3fd806a3355mr78797215ab.3.1757253570433; Sun, 07 Sep 2025
 06:59:30 -0700 (PDT)
Date: Sun, 07 Sep 2025 06:59:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bd8fc2.050a0220.192772.01da.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in __bch2_trans_get
From: syzbot <syzbot+3a42e4989f9047772c6d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08b06c30a445 Merge tag 'v6.17-rc4-ksmbd-fix' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128c4962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=385d836f07b5a70d
dashboard link: https://syzkaller.appspot.com/bug?extid=3a42e4989f9047772c6d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-08b06c30.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/516e142f1f8b/vmlinux-08b06c30.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a968d13b9737/bzImage-08b06c30.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a42e4989f9047772c6d@syzkaller.appspotmail.com

bcachefs (loop0): /file0/file0 offset 0: data_read_io_err
  u64s 8 type extent 4099:8:U32_MAX len 8 ver 1: durability: 1 crc: c_size 8 size 8 offset 0 nonce 0 csum chacha20_poly1305_80 77fa:f532966a693125aa  compress incompressible ptr: 0:34:0 gen 0
bcachefs (loop0): /file0/file0 offset 0: data read error: data_read_io_err
bcachefs (loop0): /file0/file0 offset 0: data read error, data_read_io_err
  u64s 8 type extent 4099:8:U32_MAX len 8 ver 1: durability: 1 crc: c_size 8 size 8 offset 0 nonce 0 csum chacha20_poly1305_80 77fa:f532966a693125aa  compress incompressible ptr: 0:34:0 gen 0
  loop0 io error
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_iter.c:3462!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 43 Comm: kworker/u4:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound bch2_rbio_retry
RIP: 0010:__bch2_trans_get+0xce2/0xd80 fs/bcachefs/btree_iter.c:3460
Code: fd e9 81 f4 ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 9b fa ff ff 4c 89 ff e8 09 ca f9 fd e9 8e fa ff ff e8 5f d9 94 fd 90 <0f> 0b 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 45 fd ff ff 4c 89 e7
RSP: 0018:ffffc900005e7460 EFLAGS: 00010293
RAX: ffffffff842ae4a1 RBX: ffff888051f68000 RCX: ffff88801e8b0000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffffffff8fa3b637 R09: 1ffffffff1f476c6
R10: dffffc0000000000 R11: fffffbfff1f476c7 R12: ffff888052f84200
R13: 000000000000002b R14: dffffc0000000000 R15: ffff888051dd81d8
FS:  0000000000000000(0000) GS:ffff88808d20d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fec0a7d3fc8 CR3: 00000000305ea000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 bch2_rbio_retry+0x1d1/0x19b0 fs/bcachefs/io_read.c:594
 bch2_rbio_done fs/bcachefs/io_read.c:464 [inline]
 bch2_rbio_retry+0xbf4/0x19b0 fs/bcachefs/io_read.c:667
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bch2_trans_get+0xce2/0xd80 fs/bcachefs/btree_iter.c:3460
Code: fd e9 81 f4 ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 9b fa ff ff 4c 89 ff e8 09 ca f9 fd e9 8e fa ff ff e8 5f d9 94 fd 90 <0f> 0b 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 45 fd ff ff 4c 89 e7
RSP: 0018:ffffc900005e7460 EFLAGS: 00010293
RAX: ffffffff842ae4a1 RBX: ffff888051f68000 RCX: ffff88801e8b0000


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

