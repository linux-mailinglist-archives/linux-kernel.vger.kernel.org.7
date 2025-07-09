Return-Path: <linux-kernel+bounces-723438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20682AFE6DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433B24E4A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D628DF40;
	Wed,  9 Jul 2025 11:02:37 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB4262D0C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058956; cv=none; b=tdKk+JOB9ecVE7IdLLGk9dgHtYGLuiuyruBN4TfeccMatxeOsyzvO0hSq9gztBWbEy8fChzpNdm4ZMqVbSOdeaCTJKyoAy+yctoB16gpd/vJ0ALdb1ynl8mobb9MdF1OJyBib5o/1hfkvfAoKwvysNRcP6EJYlQAA0nK0l3Z//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058956; c=relaxed/simple;
	bh=O0MMq39vN3cng0FqHb9r8Q6q9d4a9T7F2gL66JFgbs0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eSP+ULybXDQn2DN0lskrs19dyY01TRPtk5Vz4DsACIqYPx3t/iSBstDJ2q1bVtXv5v2aKNZ59GyONbIyes+RiwtSZtcJe0F5CvJwVTrBAWoYDUcdt/I70TTzfEygJyyN0q7/O875hcqU522LJmVCUdOEeR8CYT9LaVQkZG0ARCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-87313ccba79so999722739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752058954; x=1752663754;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLl91HmUoBUBEBsBZoYxAI59AmOo2F+f0y37lcNR5c4=;
        b=MDsqkIl4uDP/Aaf/WP/gl1dyrP8uTqpCbIovlwx0bp26SCz5BukKuk4sjWIfMDBM9A
         kG/BfRJUI5gGYp9zYzrlzJF3s9EcVrTzuHnzgN94pDFguLX6dT1+MRDFZKqJdvRXWvyQ
         rjgVvtGMzTmPsVUmXCxPJSfShYVArLC/TXrFNzSTpobVdg4UsL+5pgMBEO+9Darzxyv0
         85yrcakQsBZChXg35myLrGKu2Yj7z01hYBKq2hfwwlt51TJX/M9adCZmib8/UC3SH8q3
         45/HIZGrcHJsdzJJ0H8JAtq0jBIhE9C7AXEWwJHZABuMyDXU6mpVOWrrlXYu/oWUapJO
         aFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4CWkLdOnVS+TWWoe+h9NSK8ln08sCLnU48iF8/m9Y/fdgo5BrnleBhNe4vzKDPoxeqQhr0Se/Ht2nP4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7pog2JRdw492QCD3EcEKIy/0ymiB6h4rlE+UqglzG+QZtIrEY
	ichC/tLBzLV0p3dY9KoPYFTGrFXPG0pgw4d9zjw67pXAiC9SEg3w4KH0h9HjJ5U5GnWkh5FytLl
	hMzvjSRJEuBEonRIm2KI//GppeP0FgZmfHqmhhu6Wf/ak7IAz0LZlGqe1EB0=
X-Google-Smtp-Source: AGHT+IGwB3838aBXHzlwoouEEfLOF2pQx/Heas1cwkyErj2k82U4hJFAJ8787uWJv/3T/gDQENNGjFwvMnuWmoG328pKPQ5b/xTu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:488:b0:875:b493:a1d0 with SMTP id
 ca18e2360f4ac-8795b08e3e7mr215412239f.3.1752058954094; Wed, 09 Jul 2025
 04:02:34 -0700 (PDT)
Date: Wed, 09 Jul 2025 04:02:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686e4c4a.a00a0220.296254.03c1.GAE@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in dtReadFirst
From: syzbot <syzbot+2de68371153f0da8af8c@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ec4801305969 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1693ea8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=2de68371153f0da8af8c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1774ff70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1193ea8c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64d8dc107d9d/disk-ec480130.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31280b2dee28/vmlinux-ec480130.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3f9fb3d09f8/Image-ec480130.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7dab6c48056d/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1374ff70580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2de68371153f0da8af8c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
==================================================================
BUG: KASAN: slab-out-of-bounds in addressPXD fs/jfs/jfs_types.h:80 [inline]
BUG: KASAN: slab-out-of-bounds in dtReadFirst+0x408/0x7b8 fs/jfs/jfs_dtree.c:3120
Read of size 4 at addr ffff0000e3e6c028 by task syz.0.16/6711

CPU: 1 UID: 0 PID: 6711 Comm: syz.0.16 Not tainted 6.16.0-rc5-syzkaller-gec4801305969 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x254 mm/kasan/report.c:408
 print_report+0x68/0x84 mm/kasan/report.c:521
 kasan_report+0xb0/0x110 mm/kasan/report.c:634
 __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
 addressPXD fs/jfs/jfs_types.h:80 [inline]
 dtReadFirst+0x408/0x7b8 fs/jfs/jfs_dtree.c:3120
 jfs_readdir+0x548/0x3018 fs/jfs/jfs_dtree.c:2832
 wrap_directory_iterator+0x90/0xf0 fs/readdir.c:65
 shared_jfs_readdir+0x30/0x40 fs/jfs/namei.c:1540
 iterate_dir+0x458/0x5e0 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64 fs/readdir.c:396 [inline]
 __arm64_sys_getdents64+0x110/0x2fc fs/readdir.c:396
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Allocated by task 6711:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:562
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x70/0x88 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_lru_noprof+0x23c/0x3ec mm/slub.c:4216
 jfs_alloc_inode+0x2c/0x68 fs/jfs/super.c:105
 alloc_inode+0x68/0x19c fs/inode.c:346
 new_inode+0x2c/0x130 fs/inode.c:1145
 ialloc+0x54/0x78c fs/jfs/jfs_inode.c:48
 jfs_create+0x170/0x8c4 fs/jfs/namei.c:92
 lookup_open fs/namei.c:3717 [inline]
 open_last_lookups fs/namei.c:3816 [inline]
 path_openat+0x12d8/0x2c40 fs/namei.c:4052
 do_filp_open+0x18c/0x36c fs/namei.c:4082
 do_sys_openat2+0x11c/0x1b4 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __arm64_sys_openat+0x120/0x158 fs/open.c:1463
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

The buggy address belongs to the object at ffff0000e3e6b750
 which belongs to the cache jfs_ip of size 2232
The buggy address is located 32 bytes to the right of
 allocated 2232-byte region [ffff0000e3e6b750, ffff0000e3e6c008)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x123e68
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff0000d151df01
flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000040 ffff0000c47e08c0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800d000d 00000000f5000000 ffff0000d151df01
head: 05ffc00000000040 ffff0000c47e08c0 dead000000000122 0000000000000000
head: 0000000000000000 00000000800d000d 00000000f5000000 ffff0000d151df01
head: 05ffc00000000003 fffffdffc38f9a01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000e3e6bf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000e3e6bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000e3e6c000: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff0000e3e6c080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000e3e6c100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
ERROR: (device loop0): dtReadFirst: btstack overrun

ERROR: (device loop0): remounting filesystem as read-only
btstack dump:
bn = 0, index = 0
bn = 0, index = 0
bn = 0, index = 0
bn = 0, index = 0
bn = 0, index = 0
bn = 0, index = 0
bn = 0, index = 0
bn = 0, index = 0


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

