Return-Path: <linux-kernel+bounces-761259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4E5B1F633
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 22:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D76317F7DC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B323224898;
	Sat,  9 Aug 2025 20:36:42 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA62E36F1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754771801; cv=none; b=mXxpyGU47Srba8WT9JAhCoa/UrT5BUIt/M8j5+XmWq8seduLJ/XpSCeXggAEjcuWj64/2rnKVucWjn6q0pyp9gZ44eekm4zdQUuKgYA9fBXorYS+RVNVuK+Bw637A6KYU0KpVN8XIYrpTdg1t047DjhwRJLwpmPMZh2Ug5ExRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754771801; c=relaxed/simple;
	bh=iK0d660qGv/wOKuewcJI9UymZ0vEkEcgo1cce0Q8j4s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tU0n7Il4gYbjmhUYgjIS7KLiQbX3Cj6gJCob9g8+SiO18EA1J4/nKIdH83FTOLX813PXoAfuJobr7Eiqu/O9ggEhQAxvCGFqRD13sA9ZK9Tr9aQOda3yKU2jzose9rgv3KHW2D6euXGucD4/ndABkSirm4k2C57DPv1OnfYUwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8760733a107so370276239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 13:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754771798; x=1755376598;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDf+bc2+oc3YTV8U7966QRgfXOKnldRn94ktsfY5qq8=;
        b=XxgwMmLg74KRRWKY2uX97FumptRU+Y07I2YrmbDt9yt4yhQRwm2A9x7xYaadUo4BQ3
         SB+6BdKBqBnEcTeNPmBHNtrHLn5Ol99Nnz2R4qiYgl06kpJono8pOwqb0Py2wY8LHBAp
         gdKYvdbe5rfOFtpXnc2PfCqubdW0q23Bm1AqFtXF/+s4W33X6jsEL0C4Q4eaCDikxo16
         FrxEcsRKFxPLYnElMCFXewg8u5ompCNcuIm0EjG1XJNTHji1akcnFieSeqodg5cLevPS
         Njv6USgYArk1D90qV2WLbYSMpxmWphYVvsqiOIu3GixWrrumuVeHNdQoFBZ12AXJVEx2
         CDxA==
X-Forwarded-Encrypted: i=1; AJvYcCWy1Q7IAqGk0mmoy6FwOwa3RfJ2F1KT84XQB62gcxniaU3IDbaxI444tUH9XoF4Ud9MBtbXq3oYdnwcaJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3lSXV0etBpNO0rK+org1QYfsrCtxULsJjxP/5aAa6fMgazakV
	WSZLs9PKkoEPAOV0sJkbADjBHFrFgWvh0QyjfNY8RnI2vfdnKsBHfoefX1dwwl7oFEZC5C74ymS
	Jb72ZgKxgP+B6GBikYdY16kL9ZLhZdlz5uutdU1WSmScUK7QeDhofYDroq8E=
X-Google-Smtp-Source: AGHT+IHQFSE7PgibGZc4mzG1dSdRxoqjCvuZgmSib2uDKcmIvOxU725MhB6gux796mLIQFLeNrEgF5YK72ntKpk+dtHeTPBYqXIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:21ce:b0:86a:84f:7a45 with SMTP id
 ca18e2360f4ac-883f11ee752mr1129689239f.8.1754771798098; Sat, 09 Aug 2025
 13:36:38 -0700 (PDT)
Date: Sat, 09 Aug 2025 13:36:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6897b156.050a0220.51d73.0082.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in try_to_migrate_one (3)
From: syzbot <syzbot+63859a31071a369082b1@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	harry.yoo@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, riel@surriel.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0227b49b5027 Merge tag 'gpio-updates-for-v6.17-rc1-part2' ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1422d434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117c72f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ab7ea2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d0d0622733f6/disk-0227b49b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a993871f113/vmlinux-0227b49b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f07823c6782/bzImage-0227b49b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63859a31071a369082b1@syzkaller.appspotmail.com

 do_initcall_level+0x104/0x190 init/main.c:1331
 do_initcalls+0x59/0xa0 init/main.c:1347
 kernel_init_freeable+0x334/0x4b0 init/main.c:1579
 kernel_init+0x1d/0x1d0 init/main.c:1469
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5866 at mm/rmap.c:2452 try_to_migrate_one+0xf27/0x34d0 mm/rmap.c:2451
Modules linked in:
CPU: 0 UID: 0 PID: 5866 Comm: syz-executor265 Not tainted 6.16.0-syzkaller-12187-g0227b49b5027 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:try_to_migrate_one+0xf27/0x34d0 mm/rmap.c:2451
Code: fb 00 00 00 f4 0f 84 35 0e 00 00 e8 f3 41 ae ff e9 73 f8 ff ff e8 e9 41 ae ff 4c 89 e7 48 c7 c6 00 79 96 8b e8 0a 92 16 ff 90 <0f> 0b 90 e9 60 ff ff ff e8 cc 41 ae ff 49 ff cf e9 3e fb ff ff e8
RSP: 0000:ffffc9000401f120 EFLAGS: 00010246
RAX: c3d51769d0dbd500 RBX: 0400000000000000 RCX: c3d51769d0dbd500
RDX: 0000000000000003 RSI: ffffffff8dba5e25 RDI: ffff8880115dda00
RBP: ffffc9000401f370 R08: ffff8880b8624253 R09: 1ffff110170c484a
R10: dffffc0000000000 R11: ffffed10170c484b R12: ffffea0001cd8000
R13: 0000000073603867 R14: dffffc0000000000 R15: ffffea0001cd8018
FS:  0000555590a54380(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 00000000743ea000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rmap_walk_anon+0x550/0x730 mm/rmap.c:2842
 rmap_walk_locked mm/rmap.c:2958 [inline]
 try_to_migrate+0x3f5/0x670 mm/rmap.c:2619
 unmap_folio+0x191/0x1f0 mm/huge_memory.c:3137
 __folio_split+0x90d/0x1c60 mm/huge_memory.c:3711
 try_split_folio+0x13f/0x310 mm/migrate.c:1550
 migrate_pages_batch+0x653/0x3620 mm/migrate.c:1819
 migrate_pages_sync mm/migrate.c:1974 [inline]
 migrate_pages+0x1bcc/0x2930 mm/migrate.c:2083
 do_mbind mm/mempolicy.c:1539 [inline]
 kernel_mbind mm/mempolicy.c:1682 [inline]
 __do_sys_mbind mm/mempolicy.c:1756 [inline]
 __se_sys_mbind+0xa3e/0xc30 mm/mempolicy.c:1752
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb95004e539
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa7b144d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007fb95004e539
RDX: 0000000000000001 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007fb9500c15f0 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

