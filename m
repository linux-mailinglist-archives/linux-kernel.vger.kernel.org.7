Return-Path: <linux-kernel+bounces-818181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A8EB58DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661437ABEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF5290DBB;
	Tue, 16 Sep 2025 05:40:30 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B8266B40
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001229; cv=none; b=dyeSCB8CkuG8MWJ1TAnCwqCM9V/GKWoLGOTxBCt0Xai+qjS7wl8ocMcemojH3A8xBcJOXtPzzR7WOaY8gTP9uPE0CX00MJd/zFnmISt/+aQ+tF6RYMFZOv0zuqzkfHMQOmWHhAwyxsV2k5oCgfFSqohTJRSM3nPkeAczlEATYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001229; c=relaxed/simple;
	bh=kVu4mkNmf4QkmsH2FDtSx/7rJ/pM1kGWJrtRXs50Os4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dD1XCqE7+mKJzEwegsK90D87sOlDlVKxG5qt7QCECDtTYJr90sdot85EbJmL+knzELSu4cm6+L7zzfd1uSl0eqna4SmoK+8VY6jgNHo3UrD7fuPkYTGNsBOiv3RfaGrr9f1NIztUbeY4xglT8/6zGH6cUbwBrOL3mq5L8EHkJig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-893658a9aceso200717339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001227; x=1758606027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqbNwQGwcLZCF6E/RzvcFo4KBG4VYoymvX8uP1Ymm8E=;
        b=QVtnNo+3F7T0CGmtomRxyaqLu3QZAMEdy0NwhSy3WxPoovjbP9TswQZrvIeQYvrnLm
         UBdT9Wuz49uQaO+O6MxuqlIxkvknEXGKybZQnYvGa482mxSvn8xWgWpEEajasskwTwUz
         2DnXyCtOII2v7IKVkfXqzqoeD0LRzu6GrjXshtkKzQY/BaVzs8vo9/2I+ylHJlGLNWHy
         OCC3z/88ObOhzFWTYWr+xfnD44SWks9+nQkFcFxG/XKDOY8xVkubqTyP5PhU3XjXGg0t
         og4NI3WYYDCa+jfkM3bKHEzdhnCuHMVCiKZK/p6HU0IpnKI2at0AhQbz0Ve1UhZGMpKD
         CU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbcqZjSywQThpDQbw+QpeVQnrMKlczEtSuvdnPp4dO8F8IiJiztDSvve40ccxWJd5Bd6l5qPbTbr07IW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuUxI0yXXIU+fmXWSMhLk6Qx8J3jnOYCMBq0m2xkYFiSRanpV
	kq2PQZaKqpEN8JIwPo7cNK13Qga9vOhZm7y/Nv0EjPlKtBstgbVDOAPhNespdfs1v+iHmssDY78
	oj1pQBZ+SPuya1moG8TozLxzaX4m7QWWWCreTwLCvGkneg4EgRJjieMAczgs=
X-Google-Smtp-Source: AGHT+IFfl5F6ZvVpRZ5U1Pi4oGshhXhgdiBV7Hyhw1qW6ik58aa0ZJeMEPOuwyAq+ilfWZJWBEU0f6y0VssawWJsBReHlJ10p9Q8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:408:c77b:a7ea with SMTP id
 e9e14a558f8ab-420a417433emr139512185ab.22.1758001227240; Mon, 15 Sep 2025
 22:40:27 -0700 (PDT)
Date: Mon, 15 Sep 2025 22:40:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8f84b.050a0220.2ff435.03bc.GAE@google.com>
Subject: [syzbot] [mm?] kernel BUG in __free_one_page (2)
From: syzbot <syzbot+43235b3002d58852ea38@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, chrisl@kernel.org, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	shikemeng@huaweicloud.com, syzkaller-bugs@googlegroups.com, 
	weixugc@google.com, yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8736259279a3 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1107e934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ed0a6d7c80843e9
dashboard link: https://syzkaller.appspot.com/bug?extid=43235b3002d58852ea38
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f3362580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109f6b12580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/025c082a7762/disk-87362592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/606f903fe4d2/vmlinux-87362592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23ea2634f398/Image-87362592.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43235b3002d58852ea38@syzkaller.appspotmail.com

raw: 05ffc00000200000 fffffdffc3207008 ffff0001fea8cba0 0000000000000000
raw: 0000000000000000 0000000000000004 00000001f0000000 0000000000000000
page dumped because: VM_BUG_ON_PAGE(page_count(buddy) != 0)
------------[ cut here ]------------
kernel BUG at mm/internal.h:664!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6702 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : page_is_buddy mm/internal.h:664 [inline]
pc : find_buddy_page_pfn mm/internal.h:716 [inline]
pc : __free_one_page+0x8b8/0x988 mm/page_alloc.c:969
lr : page_is_buddy mm/internal.h:664 [inline]
lr : find_buddy_page_pfn mm/internal.h:716 [inline]
lr : __free_one_page+0x8b8/0x988 mm/page_alloc.c:969
sp : ffff8000a0ac71f0
x29: ffff8000a0ac7210 x28: fffffdffc3c88034 x27: fffffdffc3c88000
x26: 0000000000132200 x25: 0000000000000000 x24: 0000000000000004
x23: 0000000000132210 x22: dfff800000000000 x21: fffffdffc3c88400
x20: 0000000000000000 x19: ffff0001fea8c880 x18: 00000000ffffffff
x17: 3030303030303030 x16: ffff80008b0155d8 x15: 0000000000000001
x14: 1fffe000337976f2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000337976f3 x10: 0000000000ff0100 x9 : e31af28274316600
x8 : e31af28274316600 x7 : ffff800080563530 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff8000807de30c
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 000000000000003b
Call trace:
 page_is_buddy mm/internal.h:664 [inline] (P)
 find_buddy_page_pfn mm/internal.h:716 [inline] (P)
 __free_one_page+0x8b8/0x988 mm/page_alloc.c:969 (P)
 split_large_buddy+0x108/0x1d0 mm/page_alloc.c:1512
 free_one_page+0x94/0x2e0 mm/page_alloc.c:1559
 free_unref_folios+0x6b0/0x1454 mm/page_alloc.c:2959
 folios_put_refs+0x608/0x718 mm/swap.c:997
 folios_put include/linux/mm.h:1419 [inline]
 __folio_batch_release+0x78/0xb0 mm/swap.c:1057
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x2f8/0xe18 mm/truncate.c:383
 truncate_inode_pages+0x2c/0x3c mm/truncate.c:460
 kill_bdev block/bdev.c:91 [inline]
 blkdev_flush_mapping+0xfc/0x254 block/bdev.c:712
 blkdev_put_whole block/bdev.c:719 [inline]
 bdev_release+0x478/0x654 block/bdev.c:1144
 blkdev_release+0x20/0x34 block/fops.c:699
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x524/0x1a14 kernel/exit.c:961
 do_group_exit+0x194/0x22c kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 pid_child_should_wake+0x0/0x1dc kernel/exit.c:1111
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Code: 90052f41 913e0021 aa1b03e0 97d585d0 (d4210000) 
---[ end trace 0000000000000000 ]---


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

