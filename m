Return-Path: <linux-kernel+bounces-665504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C96AC6A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 15:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCF57A85A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 13:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622E72857E9;
	Wed, 28 May 2025 13:15:35 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6518F1E3DC8
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438135; cv=none; b=ghZHJvK1S4bCDHowrwxkMXPd2wVLeKtfz9x7U0yYnbMJr3NP0Mn7CU8UY53W7Yn8JoXITfzTfTzXx71N1H5EhMuBquWLyQyCGj+j+aJAsJKyi3WR191+9ll6qNyBcH6om9Me3tupZZSMdrSO2gRkFYtjfiVDa169shlccBD9Sc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438135; c=relaxed/simple;
	bh=PIRdrkn4tXQ/Nrngd/B6xUH/lNsjoWD2K2FQZhbNEiw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lcayHtPEND3IUtfRLqXfBiEG9vKialfCjen5SS31qRVW+scGDm2ixfOr52TY+AEMfN+WEXE5CEm2/3SoPSfOXNTFigiwiCW19hT/EGEMuZkAepC4BeRutaIW5N49F5F+BiGfZo03qU2QZxLbA0bqmKGljsniCTonSXf0mSRuAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86cda073958so299212239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 06:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748438132; x=1749042932;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GX4lpjdQUN+6EDguSjn+NQtMuXJztbQghOCQZ9PhaHQ=;
        b=lAntByJcmOySsA0HvZ9pcJqrxJmD2yyGZRQ4USy2l9hJ/dcLABBzYKo294MdeqA+LQ
         6/7diTg+opIAGsV8nYT0aLOkNE3TUVDmfpURu2vyDGSbELjJ8WxfbcQIeGigSxWLFPGt
         Kafpet0Rd0qAxU26E4fva22sMbnAo6ipjEY45AWSnk6c7sZcHuXyXatW6YrevT2TyMLp
         5+ABFMV+YSi64jYMWRqIsDguc+NzBk+00dCuNThTY6WQH2F0Jk90s/P0VxLsQBjAMQFx
         YbsG5biIYj1WolDdQgHEpz/HON7H5l1oaw0UXuucYsfDxy2T1XPCZtTOf0p7fBC2nEhp
         1YLg==
X-Forwarded-Encrypted: i=1; AJvYcCW34tpcpAQo24IiQHduviOEB3lqE9DSs7+IRyVyllKRzWTGNd/Tn04Abtrc1aAoxkxyqqPtnAPjLeyxpg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HUto+uCms7/IeV3c3CQulJPibpQS/yS6Lyhz4Je0w5zNzBMC
	M+SWV5ivYxb24xvQXcpwgj9GD4STto/bMCWy8yW7pkny8mnTglerocMXvHiLjK0fxULCSD7IrGP
	i4QMfFu2fjuTEERrlANJflDPEpr0oWXpi3DMNuwmyEjNBuPFU8Hq0b1X+ZNA=
X-Google-Smtp-Source: AGHT+IHJDVCZxm4KIQ1DwJLE+6C3Ib6KsrUY/6QQGyvT43fuL7kZcOJ4XOaZXovq85X5staTd1+teEXQo7NcDSb96lK4fAAkeT0C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a22:b0:3dc:79e5:e696 with SMTP id
 e9e14a558f8ab-3dd8b01b114mr18743335ab.11.1748438132458; Wed, 28 May 2025
 06:15:32 -0700 (PDT)
Date: Wed, 28 May 2025 06:15:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68370c74.a70a0220.253bc2.00cd.GAE@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in __bch2_bkey_unpack_key
From: syzbot <syzbot+cfd994b9cdf00446fd54@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    785cdec46e92 Merge tag 'x86-core-2025-05-25' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10b5adf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf9956a5a76267c7
dashboard link: https://syzkaller.appspot.com/bug?extid=cfd994b9cdf00446fd54
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e626d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e626d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0672bd8fdf4a/disk-785cdec4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df460fea958f/vmlinux-785cdec4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ae41e61549e/bzImage-785cdec4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8a6de6365ccd/mount_0.gz

The issue was bisected to:

commit cd3cdb1ef706a1ac725194d81858d58375739b25
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Tue Apr 22 13:14:19 2025 +0000

    bcachefs: Single err message for btree node reads

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138c6df4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104c6df4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=178c6df4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfd994b9cdf00446fd54@syzkaller.appspotmail.com
Fixes: cd3cdb1ef706 ("bcachefs: Single err message for btree node reads")

bcachefs (loop0): sb invalid before write: Unsupported superblock version_min 0.0: (unknown version) (min 0.9: (unknown version), max 1.28: inode_has_case_insensitive)
  emergency read only at seq 10
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/bkey.c:163:16
shift exponent 4294967127 is too large for 64-bit type 'u64' (aka 'unsigned long long')
CPU: 0 UID: 0 PID: 5832 Comm: read_btree_node Not tainted 6.15.0-syzkaller-01958-g785cdec46e92 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:231
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:492
 get_inc_field fs/bcachefs/bkey.c:163 [inline]
 __bch2_bkey_unpack_key+0xdc4/0xe10 fs/bcachefs/bkey.c:284
 __bch2_bkey_compat+0x4db/0xbd0 fs/bcachefs/bkey_methods.c:480
 bch2_bkey_compat fs/bcachefs/bkey_methods.h:134 [inline]
 validate_bset_keys+0x6c1/0x1390 fs/bcachefs/btree_io.c:983
 bch2_btree_node_read_done+0x18c8/0x4f60 fs/bcachefs/btree_io.c:1211
 btree_node_read_work+0x426/0xe30 fs/bcachefs/btree_io.c:1400
 bch2_btree_node_read+0x887/0x29f0 fs/bcachefs/btree_io.c:-1
 bch2_btree_node_fill+0xd12/0x14f0 fs/bcachefs/btree_cache.c:994
 bch2_btree_node_get_noiter+0xa2c/0x1000 fs/bcachefs/btree_cache.c:1261
 found_btree_node_is_readable fs/bcachefs/btree_node_scan.c:85 [inline]
 try_read_btree_node fs/bcachefs/btree_node_scan.c:220 [inline]
 read_btree_nodes_worker+0x1319/0x1e20 fs/bcachefs/btree_node_scan.c:269
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4e/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

