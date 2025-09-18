Return-Path: <linux-kernel+bounces-809357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1DEB50C65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5DE467073
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF12268C40;
	Wed, 10 Sep 2025 03:46:33 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994CF29A2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475993; cv=none; b=EFqHHGuw6dexBBk68L/gt4txkSTImWLVUF7bzkQ/Rb92BEdtuc5vvouKI2B7UTB6KLhze6RXx0TIQrW5CPQQvx0NZKpqiBVqRpeqIWvVDxJSGiy45V4QnTlwtJRUJ0Qq3PZXibQV5xJcbfX/wUNCp2GewrFrYMg5mx4AcAbAeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475993; c=relaxed/simple;
	bh=nIOk8rJS2PzNvjZfDf2V4ws13cgiCS+GN1FMerV6IFY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZM4ycRWdaIoGkDcf0OJDXaa6gZmaEFrQV52OlWjrSITcQr4VUgbzK6RTi7ooaFEP/+6gUcJwtYA9bNBaApE5wu6eJGmhRwZO3XczWMalZKkTcPXAMbX+z5rQ2yItiguakl24l9al2HxdbNAzCunW3dzpjcc0zBPVnMiszufOGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-404746a9c67so38756675ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 20:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757475991; x=1758080791;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJpekRJ4ltGwgno2RKBtlHJn+DT7VRZwBvsTfYmMG40=;
        b=YbvLgjYBeD9cFZafHAi+CrIRYImLzV9HlWyJVN5W9XiuvMAqvRhW2UP43q8h3UA8lk
         /qK7l0hFavp+rordO+hr3e3q31s/YDN2wi8d/8irRUfOBCV6U1KFTwvVWWmND2WhcHT1
         xHwkRDltRobU1QJ56ujriFqJSy1Zr7CmB8cVlDh284XYwLQQgMO/ldwR8HtsUB/WBL1s
         h3vMGVCyqQOFx5G4vbKwNHtfCeByUKrnkf807mz5uCMCBMCuF9aIrh8fl1zs9q82WBHQ
         jHQLSvyJ8eQtBwHyyS2Lo/AFAL5CKaPvW24PA69m9GfJ19DGNqdIKGq3w8/c2/tXRPqy
         yYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuv4g6moEKJ2qDqiOhXgYDMhreA/Dmlz2mjqtqgdG7aljecv7efveGUsQG3Spo9HotMP3YNIMbNQaxsbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0s622g/NLust36QHr5e7+zNuh9RJWVyYxe4jzY880EDSql2s
	PmQPo5yKa2zXxxYjxkNJCW9wwwPl3WZHv3BFvl35ggnH0/EekOWpvkXeCtlRAWKutnxatjGoSHJ
	gibev4oGBajHEmj7FLUxBslwSz+MjwSXGZ2zm8ZY1gkKJrLuaTnkYGfjnD3s=
X-Google-Smtp-Source: AGHT+IE2m0YtHdklvI2AqehcAshQg6XJlAZm87AjsfgD2bo3DRMFpw4TS0BuY9ASks3/0aU0l1XFKsjAbyupZECAR8zIJxJ7Jcmr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184c:b0:407:51a8:6b71 with SMTP id
 e9e14a558f8ab-40751a86cdemr137782995ab.28.1757475990722; Tue, 09 Sep 2025
 20:46:30 -0700 (PDT)
Date: Tue, 09 Sep 2025 20:46:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c0f496.050a0220.3c6139.0017.GAE@google.com>
Subject: [syzbot] [crypto?] KASAN: wild-memory-access Read in crypto_nhpoly1305_update_helper
From: syzbot <syzbot+634e67b3f57206befe3c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, david@redhat.com, 
	herbert@gondor.apana.org.au, jgg@ziepe.ca, jhubbard@nvidia.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, peterx@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    be5d4872e528 Add linux-next specific files for 20250905
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10f70962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a726684450a7d788
dashboard link: https://syzkaller.appspot.com/bug?extid=634e67b3f57206befe3c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1247a962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12751134580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f67121360b62/disk-be5d4872.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f666ca2e57f/vmlinux-be5d4872.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e86b794b985e/bzImage-be5d4872.xz

The issue was bisected to:

commit db076b5db550aa34169dceee81d0974c7b2a2482
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Sep 1 15:03:40 2025 +0000

    mm/gup: remove record_subpages()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173c0642580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14bc0642580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10bc0642580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+634e67b3f57206befe3c@syzkaller.appspotmail.com
Fixes: db076b5db550 ("mm/gup: remove record_subpages()")

==================================================================
BUG: KASAN: wild-memory-access in crypto_nhpoly1305_update_helper+0x156/0x390 crypto/nhpoly1305.c:165
Read of size 15 at addr 0005088000000000 by task syz.0.17/6036

CPU: 0 UID: 0 PID: 6036 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 crypto_nhpoly1305_update_helper+0x156/0x390 crypto/nhpoly1305.c:165
 nhpoly1305_sse2_update+0x68/0xb0 arch/x86/crypto/nhpoly1305-sse2-glue.c:29
 crypto_shash_update include/crypto/hash.h:1006 [inline]
 shash_ahash_update+0x213/0x2f0 crypto/ahash.c:178
 hash_sendmsg+0x96b/0x11d0 crypto/algif_hash.c:149
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x52d/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmmsg+0x227/0x430 net/socket.c:2757
 __do_sys_sendmmsg net/socket.c:2784 [inline]
 __se_sys_sendmmsg net/socket.c:2781 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2781
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdaa258ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3b406218 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fdaa27c5fa0 RCX: 00007fdaa258ebe9
RDX: 0000000000000001 RSI: 0000200000004140 RDI: 0000000000000006
RBP: 00007fdaa2611e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdaa27c5fa0 R14: 00007fdaa27c5fa0 R15: 0000000000000004
 </TASK>
==================================================================


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

