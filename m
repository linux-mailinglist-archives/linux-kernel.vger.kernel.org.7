Return-Path: <linux-kernel+bounces-828198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DBAB9428F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CA53AE0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF18246BC5;
	Tue, 23 Sep 2025 03:55:30 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED279478
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599729; cv=none; b=f6qQD2PzBftHLzRbQq/MRBbtF/EEKdDJ/9wvd2taPJVO/X1V0JCIausoya7FJzHhFExqlNPLT1MR6EZnYKbxxQIpvYhlqEURRFGVHcCBwboNuA9D6wAJVaAYlc+rXRxPaZ++JxYA7Aanr+WRkCUgO4WTWJzGR8AyfjNuyI+CGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599729; c=relaxed/simple;
	bh=y8t9PWKB3zZnvP5kG7JZ363xUj3Mj/g8G3OhuE68EJ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Oli0BwswIVTj/lDDSwjIonZdddgYjhW3PLmf04oh0xF0uikX89jjkSopqESDr4Dkiks7J+KIPMj+TLeHbebwii86owkkXbha9UKE1EylQlacKLiFRpuUql+GliG13uoYliFMOTLWREKgEAcLuEiAzViqO99E4j/YwwC87anNEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4248c63531eso39129595ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758599727; x=1759204527;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6QQWM5fRoiia+oLFHfMduX9EUKHNI+cY56i35VXsOQ=;
        b=bFjvyEBImrnwVs8v8bOLZ+l54OQrGWcxdYHk21ICcoJzmcn9mG1Xnsu+pQJbe+k92B
         MxJbN9nysiLACeV6QzkK8zM89CQzH1RUk/qjqR3W9vI621gA0UuPOuSuAZCYlpZjjI3e
         7AApuo9ZMsME5a8l8hQMpb2IH5G1ebkDWK3kJ0offzCZ34eHCMRRpWL8kU73fpKs0ETO
         GnqVIyvz1yC8xdtRkkGVCULzRSWjtHPJ/GWKkursOh7EZODM/mEAl+7KEZ96Hg+tQQbT
         Fw8PmiW4UFrc2WVUlCWPAcGs8BwZ48YobnYEL5epEer6PYnAsG+6TZWrNvQGnlKPkLyA
         /K/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7OnNelQjm3EDYhYfYXCzg8gIfOw83/o++4Ghg0zjWdUmKVDtrXYrcHn4/h68TYeTjTLg9X9wsMdFtY0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAV7yl3w7jce5KuTyVnQImvrYNOtEtfQ57mtQ8tU47a8dA3Oq
	Y5/b0pSzm6cZla8Om7t4KQk8GMqxUhff7YGlkc/8Sujf/KsjtaEKoIqFCzBk7g7+xHNRjcL/iMm
	3QUni+WwM1f1H2Q4etZ8hAEYyNxjPyfFLDvoqpPjy0qLm0HNhBfG3dqDxQ5A=
X-Google-Smtp-Source: AGHT+IF4DRqeQJmbuvS+SCCT1xYCrTL/XC7rwP+aFvBxomAU5mm+qMXcTSz7OlGdD0WPekjui9sS/Fsd4L5gESkRFKgNvTw04dU8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b48:b0:425:70ad:799e with SMTP id
 e9e14a558f8ab-42582315dcemr20343595ab.10.1758599727224; Mon, 22 Sep 2025
 20:55:27 -0700 (PDT)
Date: Mon, 22 Sep 2025 20:55:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d21a2f.a70a0220.1b52b.0044.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in __bch2_writepage
From: syzbot <syzbot+682a660800143ff55ffe@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cbf658dd0941 Merge tag 'net-6.17-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1702c712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=682a660800143ff55ffe
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cbf658dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a976546d6ce4/vmlinux-cbf658dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/13baef55a10d/bzImage-cbf658dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+682a660800143ff55ffe@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
bcachefs (loop0): starting version 1.7: mi_btree_bitmap opts=errors=continue,metadata_checksum=none,data_checksum=none,compression=lz4,nocow
  allowing incompatible features above 0.0: (unknown version)
  features: lz4,new_siphash,inline_data,new_extent_overwrite,btree_ptr_v2,new_varint,journal_no_flush,alloc_v2,extents_across_btree_nodes
bcachefs (loop0): Using encoding defined by superblock: utf8-12.1.0
bcachefs (loop0): initializing new filesystem
bcachefs (loop0): going read-write
bcachefs (loop0): marking superblocks
bcachefs (loop0): initializing freespace
bcachefs (loop0): done initializing freespace
bcachefs (loop0): reading snapshots table
bcachefs (loop0): reading snapshots done
bcachefs (loop0):  loop0: Superblock write was silently dropped! (seq 0 expected 42)
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5357 at mm/page_alloc.c:4619 __alloc_pages_slowpath+0xcb3/0xce0 mm/page_alloc.c:4619
Modules linked in:
CPU: 0 UID: 0 PID: 5357 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_pages_slowpath+0xcb3/0xce0 mm/page_alloc.c:4619
Code: d8 48 c1 e8 03 0f b6 04 08 84 c0 75 2e f6 43 01 08 48 8b 14 24 0f 84 a2 f3 ff ff 90 0f 0b 90 e9 99 f3 ff ff e8 be 7b 64 09 90 <0f> 0b 90 f7 c5 00 04 00 00 75 bc 90 0f 0b 90 eb b6 89 d9 80 e1 07
RSP: 0018:ffffc9000d396e50 EFLAGS: 00010246
RAX: dff18e3eab6b8600 RBX: 0000000000000002 RCX: dffffc0000000000
RDX: ffffc9000d396f60 RSI: 0000000000000002 RDI: 0000000000048c40
RBP: 0000000000048c40 R08: ffff88801b6f303f R09: 1ffff110036de607
R10: dffffc0000000000 R11: ffffed10036de608 R12: ffffc9000d396f60
R13: 1ffff92001a72de8 R14: 0000000000048c40 R15: dffffc0000000000
FS:  00007fa3c72006c0(0000) GS:ffff88808d009000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000200000 CR3: 000000003e644000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:5161
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0xd9/0x370 mm/slub.c:2668
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 __bch2_writepage+0x653/0x2790 fs/bcachefs/fs-io-buffered.c:563
 write_cache_pages+0x61/0x100 mm/page-writeback.c:2612
 bch2_writepages+0xf9/0x2d0 fs/bcachefs/fs-io-buffered.c:666
 do_writepages+0x32e/0x550 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
 __filemap_fdatawrite_range mm/filemap.c:419 [inline]
 file_write_and_wait_range+0x23e/0x340 mm/filemap.c:794
 bch2_fsync+0x127/0x330 fs/bcachefs/fs-io.c:245
 generic_write_sync include/linux/fs.h:3043 [inline]
 bch2_write_iter+0x2822/0x2b90 fs/bcachefs/fs-io-buffered.c:1089
 aio_write+0x535/0x7a0 fs/aio.c:1634
 __io_submit_one fs/aio.c:-1 [inline]
 io_submit_one+0x78b/0x1310 fs/aio.c:2053
 __do_sys_io_submit fs/aio.c:2112 [inline]
 __se_sys_io_submit+0x185/0x2f0 fs/aio.c:2082
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa3c638eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa3c7200038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007fa3c65d5fa0 RCX: 00007fa3c638eba9
RDX: 0000200000000540 RSI: 0000000000000018 RDI: 00007fa3c71be000
RBP: 00007fa3c6411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa3c65d6038 R14: 00007fa3c65d5fa0 R15: 00007ffd247f0388
 </TASK>


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

