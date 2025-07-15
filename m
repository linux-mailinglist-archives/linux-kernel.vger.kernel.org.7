Return-Path: <linux-kernel+bounces-731297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22052B05261
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A89A189E520
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4E425B67D;
	Tue, 15 Jul 2025 07:05:32 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379080B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563131; cv=none; b=ncdrbZUjQpRiBq2CoHaZ/M6Z4hXtWkwZUi3QG46DxvDIjN0bVE4cZPYNnMFd3Q11RFND08dbLytofGAfp8GAz+1v5labcmSv3aHn4crbdglGm4XhMt7CurDNm/wmJnwwD3iH9o0+3Y4vB1v5UE9t6RerTLVbbTnf0Rdt5AAybO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563131; c=relaxed/simple;
	bh=fwCSAXm0TKhSFZmIQiINH5e3gB7sQN/3T59sZAgjigM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C9+bdQaD9jTFGi9+izzyZcwzGJY45BW3ajpR5zlJVu0uw0JsUHXAu30+G9Z/4v4atg5Bae2421uSvMaBSXjoeyCG3JUf6QS7hkoaIJEjjf3iJL8V3UvwrUUXi53tcGPy1FUe6Xi9Ovl1HY2nhBcCkBcoPRR9aqFN9aRZLwIKufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-87595d00ca0so506986639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563129; x=1753167929;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcPGEa9MuXYPJOKcOUCi2Ats/BG3AAl+zbfUx34Vipo=;
        b=HfUCyopL+oOi3Z6UJPoWgbs6pLPw6vo3Ezyi3FYsFuktB2E76fcJRo2oh0ToewHBDC
         mqY6xf+KdEYJmIltP2/Dc7nhUCy3dYcuDbELToGirCfEKEzUJjJtMaTvCVaajGTpqQzU
         8yygjYhy4wUwTWG1dhyILwGeySDTYM4uf1xyDxp7x/UN28J65rPREA7CqFE84fPyYv1m
         a0QUYia0WLSBSF0S9y6ju4GbvJ/2Vv351gVf/rj1B1KGN0tjuldBslnEEPmkQ1jSFEaz
         //ELbOE/P6q0XYOm4YAeH4+rWd5A7CvejcJjePdUvvQEc7v4ajzFf9M6RDgTmUxpM1u0
         aC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKR1wJyCEtAMOH/BxteTnyZTXsblS2k0MD7/277CEVoIj2Pcp5Yb/J5mFTaHeqyI1QQ+bfoyrJknVNOsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmyiiyQq86CfQZ+kdhOkjjHrRGwGvzAcYn4BBw+0AniIXZRnD
	TZTYyxBPKsxOSW9juD5cLmz9s/P81Oy9PIeMW4zmnqWi7azWb0ErWzhcH0ewoIwRWs+E3dMlTYf
	KBR8ubVWqC2GBS7hzctLDZ9TIPnMzFNFb8eoOwjKCJpSDmZNXIJXF6cTIlyg=
X-Google-Smtp-Source: AGHT+IHWfRYyxt/iF749WLNYYR4F+UJ4DjzjQzCZnVsS+XtKy7y2WDCATEXuDdO/riGNmm2dH3TbZYre8cKCdVCfxXOrhU03iHw0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3a17:b0:879:26b0:1cca with SMTP id
 ca18e2360f4ac-87977fedb75mr1749267039f.13.1752563129167; Tue, 15 Jul 2025
 00:05:29 -0700 (PDT)
Date: Tue, 15 Jul 2025 00:05:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875fdb9.a70a0220.693ce.0000.GAE@google.com>
Subject: [syzbot] [udf?] KASAN: slab-out-of-bounds Write in udf_write_aext (2)
From: syzbot <syzbot+4e1da0d327b65949fe1b@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ce5d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=4e1da0d327b65949fe1b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3f31a806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7304d62ced97/vmlinux-3f31a806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4913df6ab730/bzImage-3f31a806.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e1da0d327b65949fe1b@syzkaller.appspotmail.com

 udf_setattr+0x3a1/0x5a0 fs/udf/file.c:236
 notify_change+0xb36/0xe40 fs/attr.c:552
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3517 [inline]
 do_open fs/namei.c:3900 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_creat fs/open.c:1530 [inline]
 __se_sys_creat fs/open.c:1524 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1524
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc4ff8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbc50d42038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fbc501b6160 RCX: 00007fbc4ff8e929
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 00002000000002c0
RBP: 00007fbc50010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbc501b6160 R15: 00007ffe3eb0f768
 </TASK>
getblk(): invalid block size 512 requested
logical block size: 2048
CPU: 0 UID: 0 PID: 5337 Comm: syz.0.0 Not tainted 6.16.0-rc5-syzkaller-00266-g3f31a806a62e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __getblk_slow fs/buffer.c:1133 [inline]
 bdev_getblk+0x5b0/0x690 fs/buffer.c:1467
 __getblk include/linux/buffer_head.h:382 [inline]
 sb_getblk include/linux/buffer_head.h:388 [inline]
 udf_setup_indirect_aext+0x190/0x800 fs/udf/inode.c:1998
 udf_table_free_blocks fs/udf/balloc.c:472 [inline]
 udf_free_blocks+0x13f2/0x17f0 fs/udf/balloc.c:677
 extent_trunc+0x35c/0x450 fs/udf/truncate.c:52
 udf_truncate_extents+0x5b0/0xec0 fs/udf/truncate.c:271
 udf_setsize+0x972/0x1000 fs/udf/inode.c:1317
 udf_setattr+0x3a1/0x5a0 fs/udf/file.c:236
 notify_change+0xb36/0xe40 fs/attr.c:552
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3517 [inline]
 do_open fs/namei.c:3900 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_creat fs/open.c:1530 [inline]
 __se_sys_creat fs/open.c:1524 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1524
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc4ff8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbc50d42038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fbc501b6160 RCX: 00007fbc4ff8e929
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 00002000000002c0
RBP: 00007fbc50010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbc501b6160 R15: 00007ffe3eb0f768
 </TASK>
==================================================================
BUG: KASAN: slab-out-of-bounds in udf_write_aext+0x69d/0x7b0 fs/udf/inode.c:2160
Write of size 4 at addr ffff88803f0485d8 by task syz.0.0/5337

CPU: 0 UID: 0 PID: 5337 Comm: syz.0.0 Not tainted 6.16.0-rc5-syzkaller-00266-g3f31a806a62e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 udf_write_aext+0x69d/0x7b0 fs/udf/inode.c:2160
 __udf_add_aext+0x2b9/0x6d0 fs/udf/inode.c:2085
 udf_table_free_blocks fs/udf/balloc.c:481 [inline]
 udf_free_blocks+0x1466/0x17f0 fs/udf/balloc.c:677
 extent_trunc+0x35c/0x450 fs/udf/truncate.c:52
 udf_truncate_extents+0x5b0/0xec0 fs/udf/truncate.c:271
 udf_setsize+0x972/0x1000 fs/udf/inode.c:1317
 udf_setattr+0x3a1/0x5a0 fs/udf/file.c:236
 notify_change+0xb36/0xe40 fs/attr.c:552
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3517 [inline]
 do_open fs/namei.c:3900 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_creat fs/open.c:1530 [inline]
 __se_sys_creat fs/open.c:1524 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1524
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc4ff8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbc50d42038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fbc501b6160 RCX: 00007fbc4ff8e929
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 00002000000002c0
RBP: 00007fbc50010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbc501b6160 R15: 00007ffe3eb0f768
 </TASK>

Allocated by task 5335:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 udf_alloc_i_data fs/udf/inode.c:1661 [inline]
 udf_read_inode fs/udf/inode.c:1473 [inline]
 __udf_iget+0xc66/0x3ae0 fs/udf/inode.c:1967
 udf_iget_special fs/udf/udfdecl.h:147 [inline]
 udf_fill_partdesc_info+0x773/0x1310 fs/udf/super.c:1162
 udf_load_partdesc fs/udf/super.c:1321 [inline]
 udf_process_sequence+0x1133/0x4840 fs/udf/super.c:1837
 udf_load_sequence fs/udf/super.c:1875 [inline]
 udf_check_anchor_block+0x28e/0x550 fs/udf/super.c:1910
 udf_scan_anchors fs/udf/super.c:1964 [inline]
 udf_load_vrs+0x96d/0xf20 fs/udf/super.c:2024
 udf_fill_super+0x5ad/0x17a0 fs/udf/super.c:2192
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1681
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803f048400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes to the right of
 allocated 472-byte region [ffff88803f048400, ffff88803f0485d8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88803f048000 pfn:0x3f048
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000240(workingset|head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000240 ffff88801a441c80 ffffea000100d490 ffffea0000fec710
raw: ffff88803f048000 0000000000080007 00000000f5000000 0000000000000000
head: 04fff00000000240 ffff88801a441c80 ffffea000100d490 ffffea0000fec710
head: ffff88803f048000 0000000000080007 00000000f5000000 0000000000000000
head: 04fff00000000001 ffffea0000fc1201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 22938950246, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 net_alloc_generic net/core/net_namespace.c:77 [inline]
 net_assign_generic net/core/net_namespace.c:97 [inline]
 ops_init+0x1eb/0x5c0 net/core/net_namespace.c:132
 __register_pernet_operations net/core/net_namespace.c:1284 [inline]
 register_pernet_operations+0x336/0x800 net/core/net_namespace.c:1361
 register_pernet_subsys+0x28/0x40 net/core/net_namespace.c:1402
 tcf_register_action+0x8f/0x670 net/sched/act_api.c:1021
 do_one_initcall+0x233/0x820 init/main.c:1274
 do_initcall_level+0x137/0x1f0 init/main.c:1336
 do_initcalls+0x69/0xd0 init/main.c:1352
 kernel_init_freeable+0x3d9/0x570 init/main.c:1584
 kernel_init+0x1d/0x1d0 init/main.c:1474
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803f048480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803f048500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88803f048580: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
                                                    ^
 ffff88803f048600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803f048680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

