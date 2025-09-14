Return-Path: <linux-kernel+bounces-815492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D172B5674A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252887A0649
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA40221FC3;
	Sun, 14 Sep 2025 07:53:30 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380F1862
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757836409; cv=none; b=Hc9aZ0qDf3vIqOj6sHY+tBmi7yvb174le6lMqA0Qrm62Xo3x5E4bKKm/6HWcWIfbNi1KhVEQV/F7cacLoJEKcsRe0U0fqr2+264Bx/0PwX0jgZivB8e+Ibmin/Cl2ySDwGH4ruZBCiM3O3Va5O/LCASMnBSxOx7Nx+OpRhzkSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757836409; c=relaxed/simple;
	bh=qkxA4K0qPEUSbPWKE/1gmkI85LY4Qnz1euenyPFCBfY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u8r01ohbz4wCMc6VksjYXO+TXRunVjjN7wcAyr0JSFjZTwKNsahzTnxgeUt9dfbdQ0GYNFRGuUNIj2rkARZ04bczNkubAZxzlmHB75df9o+LndU9a3hulkXh1OktzKnJMUU3dfmkar+l1QKGogKWwA15egFfYvemK2qF18j/NNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4155725a305so43991925ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 00:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757836407; x=1758441207;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aiqRIxpz9AdL8psvEfiBudfnoYD+n/6tWabnQVapIEY=;
        b=hxBp9ECddD9DleCgWzSgVpwM+tZ4KMprH+zWjrCQz0l1QAgpfa+sPQCaBVov7Vghfq
         hc9AO5J2zQOLswV5pSJzzjPTwdSam1B2U/ftUzoVa6X/2D/2HZ9TkL9VSBoQP7KnttPN
         uPcrS7Fglz865t5P1+lz60UGtphvBGZwjwhIlbv8nUDVOaFZPvpIlCqTBeHXZ4Jjr2I/
         WQiBr/1B4b9vckhVRBro14nS6szqdOwExuaazW67r2+xGNjVHroiE6yJEUVirZL21knq
         1pdCJHUWTDxWiux4Zf9sBlWJJctS7rRkFSlfXuIvfb7/pHi1KFVmntr+MfnPRPy5cFRA
         TT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxMJGwoppnpkALYM2RuVWiNp6clLhOb+9z4rYNr+IrNryWIMcmwTzXPWRQeXUbflWPuwdvqgOUWgXr8Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSDfGc1bPjfAVl18WsSR+1z1PcpB7tO89LFBR/fJTyv4qxdnG
	qpIp6WC1XNjYY3psyhDZZHoLhyc1v7Rn/lG/N8Qzv+b/UfU8OzDuWQ+lnVlO3H1c4rsEOF06lBg
	GiUXxqkNhQ69kN2dxYPW+HgELpFG0sSEM/aWYZOp13nnn+CChrigXM1K2B3M=
X-Google-Smtp-Source: AGHT+IFRyjJOy5CX3Z/PQJ+hrBL0jzi1pt2APVtVz0PTj6gbB4xr+O9pYuS5iAFAkvyFm+jfQHarge2cxcHxPynkqCVDpnkf7Njk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3801:b0:424:57d:1a5e with SMTP id
 e9e14a558f8ab-424057d1bc0mr499245ab.5.1757836407126; Sun, 14 Sep 2025
 00:53:27 -0700 (PDT)
Date: Sun, 14 Sep 2025 00:53:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c67477.050a0220.2ff435.037f.GAE@google.com>
Subject: [syzbot] [bcachefs?] BUG: unable to handle kernel NULL pointer
 dereference in mempool_alloc_noprof (3)
From: syzbot <syzbot+4ebc8d586b68728bcad6@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f777d1112ee5 Merge tag 'vfs-6.17-rc6.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1547ad62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7f605fd273c8220
dashboard link: https://syzkaller.appspot.com/bug?extid=4ebc8d586b68728bcad6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f777d111.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff082b9d029e/vmlinux-f777d111.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2c8489f25c3/bzImage-f777d111.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ebc8d586b68728bcad6@syzkaller.appspotmail.com

bcachefs (loop0): compression opt none set but not marked in superblock, fixing
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0010 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5383 Comm: bch-rebalance/l Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000d49ec18 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff8880532c75a0
RDX: 1ffff1100a658eb4 RSI: 0000000000000000 RDI: 0000000000092800
RBP: ffffc9000d49ed70 R08: ffffc9000d49ece7 R09: 0000000000000000
R10: ffffc9000d49ecc0 R11: 0000000000000000 R12: 1ffff92001a93d94
R13: ffff8880532c75a0 R14: 0000000000092c40 R15: 0000000000092800
FS:  0000000000000000(0000) GS:ffff88808d20c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000400eb000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mempool_alloc_noprof+0x1a4/0x510 mm/mempool.c:406
 __bio_compress fs/bcachefs/compress.c:461 [inline]
 bch2_bio_compress+0x42f/0x14c0 fs/bcachefs/compress.c:555
 bch2_write_extent fs/bcachefs/io_write.c:1060 [inline]
 __bch2_write+0xfb5/0x3900 fs/bcachefs/io_write.c:1554
 move_write fs/bcachefs/move.c:217 [inline]
 bch2_moving_ctxt_do_pending_writes+0x5a7/0xe60 fs/bcachefs/move.c:248
 bch2_move_ratelimit+0x8e8/0x1330 fs/bcachefs/move.c:585
 do_rebalance fs/bcachefs/rebalance.c:557 [inline]
 bch2_rebalance_thread+0x17b0/0x1f80 fs/bcachefs/rebalance.c:626
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000d49ec18 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff8880532c75a0
RDX: 1ffff1100a658eb4 RSI: 0000000000000000 RDI: 0000000000092800
RBP: ffffc9000d49ed70 R08: ffffc9000d49ece7 R09: 0000000000000000
R10: ffffc9000d49ecc0 R11: 0000000000000000 R12: 1ffff92001a93d94
R13: ffff8880532c75a0 R14: 0000000000092c40 R15: 0000000000092800
FS:  0000000000000000(0000) GS:ffff88808d20c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000400eb000 CR4: 0000000000352ef0


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

