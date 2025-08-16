Return-Path: <linux-kernel+bounces-772268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D23B29083
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 22:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B583B17D8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19932F60AF;
	Sat, 16 Aug 2025 19:58:35 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC262E7627
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374315; cv=none; b=KP/nK8OHqJebXNd4N99ZQVlxTUIUtTU6TIZCqPe8VcpjG55LdaEiXesGADwfY7pEa/4P+5VeFN/sfDlf9LnWElOrvMUWPSFGhk7t9Lztj+x8UjVu5nvNIL9bhbxq9TnaEyyJO2AL46LUdh9PepE4UIeekcXNiDVfoXI/uPAOOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374315; c=relaxed/simple;
	bh=PmZhJ+AyyPp0IETOJ2Lp0Yr/WPBtnpQxDMgCQTq5ahQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tBdvvp4wqi8WWJhbyupcftiV7LujX7gwt2KvrEOl2RDpWAB1IdO4TtGIkqwz5KZhOlJ1Po7yEZhsKk3AJx8zDdeayZb/wKk69xG4dtxvTrwWXWNFmTNoD2KuXQfUbDSR0EvCKehIN/fVGFhSOYQ7yS9X/pY+Ur3n/sEFp8GgJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432e62d01so394164039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755374313; x=1755979113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9X3frL1K6ABgF+/GeFMFMDMzdy6vwlHamHmGBwxJKy0=;
        b=ubmbpQudhlpzVNsSKp2xaKhi8OijDrJDFuoX1HL8lq66Vabp6QLVidzJgbpR9eb32R
         ht7aB5KDnIhGgekOtwcoEcEC24BAHage9LZAVM0jRoDKr7IOmfHvDzMCKhalsQNdDiuj
         69k0/Ktw615OYK/DSLr1QCvH6nV+tmeQKpKz+UbNknDedOezuwlrArloS9siO7p3vju1
         i7igpHJoVMFI0xhXCijhLb54PR7+lExhTwbl2ejckhkVi49NCxSCpTPW8Qa7c1pF2Bs+
         18y7a1YuslvAEia1bYxgNp6twzalKKMpf/lG5Fkw43MVFFWvIIdnSF7r4cF5zIQ14Kd/
         VdvA==
X-Forwarded-Encrypted: i=1; AJvYcCVQUpZnM/tzLVIs7qhUEdjP6djx2SVULdAdogf/2UKi+DJXdquhdNvIVpCu4Z/wWdGt3/wBHGy8eLrw5C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznncNFtDjtZkSQfTfmKLCTPnvZ2fvnDgqXLdh+KJG8DFGr+zN7
	+A6J8qurY8W0xHL2jWwHYUxweNGDJdWS4cIeCVXdQJsvE2tYB4Z2p0pYJy7nSXO4mZXEbfJsGLu
	VSF4v4TlS0zosD+p8jrq9Uq9uJg5SmQughPAj2CZUS4clZaQRjOxpUgc4Dw8=
X-Google-Smtp-Source: AGHT+IF4r7sKRkuX/L42iMRPCUrR2kVmZ1UmrTutaF5hEqKsLaNQnPGd43eTzB7Eo9jlWB5cX8dp4l+iXStfBGPC5MWGiUxNXnlo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:3e5:4942:88dc with SMTP id
 e9e14a558f8ab-3e57e82d473mr133133955ab.9.1755374312721; Sat, 16 Aug 2025
 12:58:32 -0700 (PDT)
Date: Sat, 16 Aug 2025 12:58:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a0e2e8.050a0220.e29e5.0049.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_journal_pin_set_locked
From: syzbot <syzbot+014934d9b1d3601f30db@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0e39a731820a Merge tag 'for-6.17-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c6f5bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=014934d9b1d3601f30db
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0e39a731.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4de62048a1d4/vmlinux-0e39a731.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5ed93317a562/bzImage-0e39a731.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+014934d9b1d3601f30db@syzkaller.appspotmail.com

bcachefs (loop0): u64s 12 type alloc_v4 0:42:0 len 0 ver 0: 
    gen 0 oldest_gen 0 data_type btree
    journal_seq_nonempty 7
    journal_seq_empty    0
    need_discard         1
    need_inc_gen         1
    dirty_sectors        256
    stripe_sectors       0
    cached_sectors       0
    stripe               0
    stripe_redundancy    0
    io_time[READ]        1
    io_time[WRITE]       1280
    fragmentation     0
    bp_start          7
  
  incorrectly set at freespace:0:42:0 (free 0, genbits 0 should be 0), fixing
------------[ cut here ]------------
kernel BUG at fs/bcachefs/journal_reclaim.h:30!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 1037 Comm: kworker/u4:5 Not tainted 6.17.0-rc1-syzkaller-00014-g0e39a731820a #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: btree_node_rewrite async_btree_node_rewrite_work
RIP: 0010:journal_seq_pin fs/bcachefs/journal_reclaim.h:30 [inline]
RIP: 0010:bch2_journal_pin_set_locked+0x346/0x350 fs/bcachefs/journal_reclaim.c:422
Code: fe ff ff e8 3c 92 72 fd 48 c7 c7 e0 f5 78 8e 4c 89 e6 e8 bd 86 b3 00 e9 54 fe ff ff e8 23 92 72 fd 90 0f 0b e8 1b 92 72 fd 90 <0f> 0b e8 13 92 72 fd 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000256f6a0 EFLAGS: 00010293
RAX: ffffffff844d2945 RBX: ffff8880119ce108 RCX: ffff888032e4a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: 0000000000000005 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520004adecc R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888054049800
FS:  0000000000000000(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564f7dae2a38 CR3: 0000000051967000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 bch2_journal_pin_copy+0x4c7/0x5b0 fs/bcachefs/journal_reclaim.c:463
 bch2_btree_interior_update_will_free_node+0x478/0xef0 fs/bcachefs/btree_update_interior.c:1092
 bch2_btree_node_rewrite+0x9ac/0x1120 fs/bcachefs/btree_update_interior.c:2275
 bch2_btree_node_rewrite_key+0x273/0x320 fs/bcachefs/btree_update_interior.c:2312
 async_btree_node_rewrite_work+0x110/0x4f0 fs/bcachefs/btree_update_interior.c:2369
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:journal_seq_pin fs/bcachefs/journal_reclaim.h:30 [inline]
RIP: 0010:bch2_journal_pin_set_locked+0x346/0x350 fs/bcachefs/journal_reclaim.c:422
Code: fe ff ff e8 3c 92 72 fd 48 c7 c7 e0 f5 78 8e 4c 89 e6 e8 bd 86 b3 00 e9 54 fe ff ff e8 23 92 72 fd 90 0f 0b e8 1b 92 72 fd 90 <0f> 0b e8 13 92 72 fd 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000256f6a0 EFLAGS: 00010293
RAX: ffffffff844d2945 RBX: ffff8880119ce108 RCX: ffff888032e4a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: 0000000000000005 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520004adecc R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888054049800
FS:  0000000000000000(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564f7dae2a38 CR3: 0000000051967000 CR4: 0000000000352ef0


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

