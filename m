Return-Path: <linux-kernel+bounces-724205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B55BAFF001
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5AF1C824C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34E8FC1D;
	Wed,  9 Jul 2025 17:38:33 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABA221F0A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082713; cv=none; b=rH5cGmeRnpGku+OGfeNIuZVr5SLci+KTsisM91dZ6HCnkmTWbZqHQIqW7wyerZLb9Pzna7YGh68X5JeElgYY0ybFB+Qyooncczh71r0wZk7kRGVsveDp/4ULvo0iJ3me4XGHQJ9/9/JLz33qmRdl8l3dkLOFQaHG0L5K4hl+hlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082713; c=relaxed/simple;
	bh=q9Pbp7urO0epXPxgo2MXb6syFHGq3ww+QGxyGJc+168=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TSWYDps61ZRRVLeU63tZ8fD0IH89+kxkBd5bIdswnZde/PZo9S0aSoBSOHLtr0FYgK0jj0+AYOnoP+t0d1MSpg2fU6b+itqpcgyHIfoMZziENz1AKQKUBfcgFL91sRS2hKw0jdckLMonuPOHsB0U+9M+tSyeSWHJ4qfqY8untyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e055be2288so941425ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 10:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752082711; x=1752687511;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUkTTgI92QzmAc9ICKC0M2YNgzpd6VFuNwCoNZ6vJfY=;
        b=FB4xyqQ0BvlthdpwuXtV4PZIzflid7VZ5ukmgaKlmt4Z9if2Ds3sswv/ffPP9H891V
         Bp1IvjGDqCgb5d8NeFm4rXq1WRvHxizf9UZiiSUr/TdUdBGM05BpAO+I35h1Zom0sQiA
         B9vR28QVH/gbB1jBGWLBnZ8UJNKqAozoggGJB7tuQLpvvXCfZoEkrl2IkhmeARd1CqyQ
         nX6xp6PksA/J3gWxccD7/XdjoVPrV78wEIOfi/Zh978y3poe0VbbUoyBDHdVXgLnbhzH
         dL6C+6OSMVrkllRe2iUrIdX1rErnxJXlMEJzno54qKPxzIWPdkfX/vEoyz+n2F7pTAe0
         rlJg==
X-Forwarded-Encrypted: i=1; AJvYcCVtuQRWZ20GwSb6v29+zSybD9Nlv+nRyWTkqVH8iAaAgGFubdSGwuGrz5/z3VvkTnT3vViRXBRiFF8HyA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy70RcU/i6KP8DQNM7D7BCjDS827tr23HTx+cZ0Xr4waRGe2KZ
	/h8uxWDmqcR9VYHNcx3G5nEpfFLT70Gta3fe77AvVhARK94SkLZwpuNAP7b3g+qcylF1uw7CfKt
	y9XLE7E0wOJBPB6H7rs9tNADKHST0WhQrOM8Bxn6QDjqzeMmJU9AuTdpNhho=
X-Google-Smtp-Source: AGHT+IHBluWqgairrFXOlngsvcfyszYqLbwcrys7mpxy4nEeBj7YHhGsmlwlU84AGN4q/JIF++O2yIT6LBrKYznQoLcp6QxDTBAo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:3df:3154:2e90 with SMTP id
 e9e14a558f8ab-3e1670fac99mr36542005ab.19.1752082710981; Wed, 09 Jul 2025
 10:38:30 -0700 (PDT)
Date: Wed, 09 Jul 2025 10:38:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686ea916.050a0220.385921.0013.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_btree_node_iter_init (2)
From: syzbot <syzbot+3ba6dd3d414ec2296f3c@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    733923397fd9 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d4b582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba6dd3d414ec2296f3c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fd2a8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115bea8c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-73392339.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be7feaa77b8c/vmlinux-73392339.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a663b3e31463/bzImage-73392339.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3e7303eff7fc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ba6dd3d414ec2296f3c@syzkaller.appspotmail.com

bcachefs (loop0): bucket 0:26 data type btree ptr gen 0 missing in alloc btree
  while marking u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq ac62141f8dc7e261 written 24 min_key POS_MIN durability: 1 ptr: 0:26:0 gen 0, fixing
------------[ cut here ]------------
kernel BUG at fs/bcachefs/bset.h:287!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5498 Comm: syz.0.16 Not tainted 6.16.0-rc5-syzkaller-00038-g733923397fd9 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bkey_cmp_p_or_unp fs/bcachefs/bset.h:287 [inline]
RIP: 0010:bset_search_tree fs/bcachefs/bset.c:1129 [inline]
RIP: 0010:__bch2_bset_search fs/bcachefs/bset.c:1181 [inline]
RIP: 0010:bch2_btree_node_iter_init+0x3961/0x3a50 fs/bcachefs/bset.c:1334
Code: fd 90 0f 0b e8 90 a8 a3 fd 90 0f 0b e8 88 a8 a3 fd 90 0f 0b e8 80 a8 a3 fd 90 0f 0b e8 78 a8 a3 fd 90 0f 0b e8 70 a8 a3 fd 90 <0f> 0b e8 68 a8 a3 fd 90 0f 0b e8 60 a8 a3 fd 90 0f 0b e8 58 a8 a3
RSP: 0018:ffffc90002b5e300 EFLAGS: 00010293
RAX: ffffffff841c7e00 RBX: 000000000000004e RCX: ffff888032b52440
RDX: 0000000000000000 RSI: 000000000000004e RDI: 0000000000000001
RBP: ffffc90002b5e530 R08: ffff888032b52440 R09: 0000000000000002
R10: 000000000000ffff R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88803f849908 R14: ffff888011900288 R15: 0000000000000001
FS:  0000555588091500(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faae076b5a3 CR3: 000000001ee4f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __btree_path_level_init fs/bcachefs/btree_iter.c:617 [inline]
 bch2_btree_path_level_init+0x50b/0xa20 fs/bcachefs/btree_iter.c:637
 btree_path_lock_root fs/bcachefs/btree_iter.c:787 [inline]
 bch2_btree_path_traverse_one+0xfec/0x21d0 fs/bcachefs/btree_iter.c:1203
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:250 [inline]
 __bch2_btree_iter_peek fs/bcachefs/btree_iter.c:2267 [inline]
 bch2_btree_iter_peek_max+0x9e8/0x58f0 fs/bcachefs/btree_iter.c:2384
 bch2_btree_iter_peek_max_type fs/bcachefs/btree_iter.h:743 [inline]
 bch2_gc_btree fs/bcachefs/btree_gc.c:729 [inline]
 bch2_gc_btrees fs/bcachefs/btree_gc.c:792 [inline]
 bch2_check_allocations+0x120d/0x57b0 fs/bcachefs/btree_gc.c:1094
 bch2_run_recovery_pass fs/bcachefs/recovery_passes.c:484 [inline]
 __bch2_run_recovery_passes+0x392/0x1010 fs/bcachefs/recovery_passes.c:539
 bch2_run_recovery_passes+0x184/0x210 fs/bcachefs/recovery_passes.c:610
 bch2_fs_recovery+0x2690/0x3a50 fs/bcachefs/recovery.c:1005
 bch2_fs_start+0xaaf/0xda0 fs/bcachefs/super.c:1213
 bch2_fs_get_tree+0xb39/0x1520 fs/bcachefs/fs.c:2488
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6704d900ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3cd859c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd3cd85a50 RCX: 00007f6704d900ca
RDX: 00002000000058c0 RSI: 0000200000005900 RDI: 00007ffd3cd85a10
RBP: 00002000000058c0 R08: 00007ffd3cd85a50 R09: 0000000000010000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000200000005900
R13: 00007ffd3cd85a10 R14: 0000000000005923 R15: 0000200000000040
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bkey_cmp_p_or_unp fs/bcachefs/bset.h:287 [inline]
RIP: 0010:bset_search_tree fs/bcachefs/bset.c:1129 [inline]
RIP: 0010:__bch2_bset_search fs/bcachefs/bset.c:1181 [inline]
RIP: 0010:bch2_btree_node_iter_init+0x3961/0x3a50 fs/bcachefs/bset.c:1334
Code: fd 90 0f 0b e8 90 a8 a3 fd 90 0f 0b e8 88 a8 a3 fd 90 0f 0b e8 80 a8 a3 fd 90 0f 0b e8 78 a8 a3 fd 90 0f 0b e8 70 a8 a3 fd 90 <0f> 0b e8 68 a8 a3 fd 90 0f 0b e8 60 a8 a3 fd 90 0f 0b e8 58 a8 a3
RSP: 0018:ffffc90002b5e300 EFLAGS: 00010293
RAX: ffffffff841c7e00 RBX: 000000000000004e RCX: ffff888032b52440
RDX: 0000000000000000 RSI: 000000000000004e RDI: 0000000000000001
RBP: ffffc90002b5e530 R08: ffff888032b52440 R09: 0000000000000002
R10: 000000000000ffff R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88803f849908 R14: ffff888011900288 R15: 0000000000000001
FS:  0000555588091500(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faae06c8120 CR3: 000000001ee4f000 CR4: 0000000000352ef0


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

