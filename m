Return-Path: <linux-kernel+bounces-837958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04ABAE200
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F75F3287C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8842309F1D;
	Tue, 30 Sep 2025 17:03:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC1222F76F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251789; cv=none; b=Stn8XIdIBAh1o9TSYW8yQiYmR2v35/KdCTHynBQgd7nuia9wKY2ar1X198h7ereEDeWOnEsRyY415SxF06k7WTM/uHMwZ33JinrK1dUZ08A5I+GFmX0Emb8heXylxqWMwI6kVpAbxEvQxOcjmj/6cmV5b8q4SJqYUD+f1WJspg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251789; c=relaxed/simple;
	bh=FVQdJTAA9d5lCAd4j2TtMCNPXSKf3UKSp6ndYk8Do+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jRDI5sVC1wmLvrHwlrqni8Vhzjv2vKC1B8F45iwBreJSYWgCBtVrBE9uOLicVup7IiDPZuA2D0PULj0FwiSQKNZjwduNiJUrLz2O9S7n8FohBQCCGAIzxAwmIRzjKL+oLo/RDcKeAXquaR3LHoj86O/Tg3TdYEFUa/5ELrXiz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4278a8ecfa0so138627515ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251784; x=1759856584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcTxC6VKsTa1Le7QNNnf5R9AkZGx2CC7OFExQY5BVAg=;
        b=a/1UcyVZhxjbhXOisPhT90IUhAnbuqvR+axjVWZ9Q+o4sw9uYZkGGAFYyoW5LJZyNb
         fIjCqfXKpDnwyMmhLZ4SFA1p32EIFqbG01xC53nPnQVa08c3Zu3jv6xo5gspuzGXV5+1
         gNEtIf8gJHfYVVfWLd2rEJdle0RmJvxQxH9en8e/u2SUDXTIMWSz8ZDxnmqexnrl4iC1
         W4aq4sDSg07nLw5bPAapg/jCBoKQTzZZRNfErLtOrrvGA9366WvjEmINfPguU1fPjvNH
         nFfIw4U6K8v2cWi67y162Ua6yPTvnDyRQRdjFO/G30v2dMHNtInwJhadl4f/GKtysj8b
         gjEg==
X-Forwarded-Encrypted: i=1; AJvYcCVO8GhRxVZTMhNjgDZkp36ep++wPPmmWn3dHuyop6xImXTvqLirD2mxF+asjnWLQwED5DCyotITHxFnGxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32PrxY5xW16TzmT6XGLKph+d5oOkT12b8ZNbaWkJeHVVzzLgB
	2cRyXXBXq5eKcpnBthft3OJDR+lDi/YpRP/jOVwxkrrbQATC6auMdL5OgP22yzixZcAhAgSn0Uf
	upRnGbVVS+taaHoGc2jFYgW517XH81L2SgOeEnO7mbabiHQf3puRp2O3t79s=
X-Google-Smtp-Source: AGHT+IHnEHmGQNEDkKCVdcreoDrDHL0BcmJLvcyByTJbkxCk1pOVovdLB9uGABAjjg1eglHXSTE+28xNQ6BSlCf2Jcqf2tT5akr9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c244:0:b0:423:feda:f14f with SMTP id
 e9e14a558f8ab-42d815b0340mr11035755ab.12.1759251784173; Tue, 30 Sep 2025
 10:03:04 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:03:04 -0700
In-Reply-To: <20250930152023.319472-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc0d48.a00a0220.102ee.004d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_ext_insert_extent
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in ext4_find_extent

==================================================================
BUG: KASAN: slab-use-after-free in ext4_ext_binsearch fs/ext4/extents.c:841 [inline]
BUG: KASAN: slab-use-after-free in ext4_find_extent+0xae6/0xcc0 fs/ext4/extents.c:956
Read of size 4 at addr ffff88807e32ee18 by task syz.0.121/7280

CPU: 1 UID: 0 PID: 7280 Comm: syz.0.121 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_ext_binsearch fs/ext4/extents.c:841 [inline]
 ext4_find_extent+0xae6/0xcc0 fs/ext4/extents.c:956
 ext4_ext_map_blocks+0x288/0x6ac0 fs/ext4/extents.c:4214
 ext4_map_query_blocks+0x13b/0x930 fs/ext4/inode.c:550
 ext4_map_blocks+0x4b3/0x1740 fs/ext4/inode.c:773
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:910
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:943
 ext4_block_write_begin+0x990/0x1710 fs/ext4/inode.c:1198
 ext4_write_begin+0xc04/0x19a0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x445/0xda0 fs/ext4/inode.c:3129
 generic_perform_write+0x2c2/0x900 mm/filemap.c:4175
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c6/0xb30 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:798
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f49d8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f4ab1e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f2f49fb5fa0 RCX: 00007f2f49d8e969
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f2f49e10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2f49fb5fa0 R15: 00007ffdd4fbb178
 </TASK>

Allocated by task 6267:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_realpath_from_path+0xe3/0x5d0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x1c1/0x3b0 security/tomoyo/file.c:771
 security_file_open+0xb1/0x270 security/security.c:3144
 do_dentry_open+0x384/0x13f0 fs/open.c:942
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3975 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4134
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6267:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x18e/0x440 mm/slub.c:4894
 tomoyo_realpath_from_path+0x598/0x5d0 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x1c1/0x3b0 security/tomoyo/file.c:771
 security_file_open+0xb1/0x270 security/security.c:3144
 do_dentry_open+0x384/0x13f0 fs/open.c:942
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3975 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4134
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807e32e000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3608 bytes inside of
 freed 4096-byte region [ffff88807e32e000, ffff88807e32f000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e328
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a042140 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a042140 0000000000000000 dead000000000001
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001f8ca01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5163, tgid 5163 (rcS), ts 23112480838, free_ts 21314138532
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x183/0x1f70 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x340/0x1480 security/tomoyo/common.c:2198
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission+0x25a/0x380 security/tomoyo/file.c:587
 tomoyo_path_perm+0x392/0x4b0 security/tomoyo/file.c:838
 security_inode_getattr+0x12f/0x330 security/security.c:2377
 vfs_getattr fs/stat.c:259 [inline]
 vfs_statx_path fs/stat.c:299 [inline]
 vfs_statx+0x18e/0x550 fs/stat.c:356
 vfs_fstatat+0x118/0x170 fs/stat.c:375
 __do_sys_newfstatat fs/stat.c:542 [inline]
 __se_sys_newfstatat fs/stat.c:536 [inline]
 __x64_sys_newfstatat+0x116/0x190 fs/stat.c:536
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbb1/0xd20 mm/page_alloc.c:2895
 __free_pages mm/page_alloc.c:5260 [inline]
 free_contig_range+0x1bd/0x4a0 mm/page_alloc.c:7091
 destroy_args+0x69/0x660 mm/debug_vm_pgtable.c:958
 debug_vm_pgtable+0x39f/0x3b0 mm/debug_vm_pgtable.c:1345
 do_one_initcall+0x233/0x820 init/main.c:1271
 do_initcall_level+0x104/0x190 init/main.c:1333
 do_initcalls+0x59/0xa0 init/main.c:1349
 kernel_init_freeable+0x334/0x4b0 init/main.c:1581
 kernel_init+0x1d/0x1d0 init/main.c:1471
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88807e32ed00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e32ed80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807e32ee00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88807e32ee80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e32ef00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         30d4efb2 Merge tag 'for-linus-6.18-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a00a7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a4d61c2af99e8dd
dashboard link: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=119d2334580000


