Return-Path: <linux-kernel+bounces-838303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8CBAEE87
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D7A3A706A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1571E521A;
	Wed,  1 Oct 2025 00:44:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF9191484
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279445; cv=none; b=KoYqQU/Wqr9Gj83wjqUzu/J+M5eenljkd/ovHFnUpUhERK/h8IYZZQGkzkqBAwFCxz0Neu8CQqs5+V7abWjPVuLS7V2CZaxPrcbFCzE76z062sr+JNu+mUOIeO9Yy40UqgEOCfdnDqEk6M995s5cQmeyeu/fkLUy9hIKKLcyf7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279445; c=relaxed/simple;
	bh=WaprJfvuJ4aeuKB3QGxxEQ0miLuX74Rf5K5UtqWtyrE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=USLRNdWxYJqEnAHx0vrp8FliRM6oSiMUDjLyMAg30Az6Ho/TW7R561FzQwmy32D9jKGY968NcfQ4cUNLEBX/YC/P38QHYPwUtcpuJUPGN4iH9NLBDlYrwb5jVWtUFY0gIqfiaDqp29hftYNiCv4rIQtZ7DIQbU7WW2ifFd0x/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42571c700d2so154384695ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759279443; x=1759884243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72RfHp0ngRgHWEMq4nE6duUutfvrSqd1zW+nWa+ryBw=;
        b=X8z4AnthreAfMXaX+chv3zqehTCbppz2TkOVigrFFUX2WdIkWKNscD9t447kf58MQt
         2gkVXFx6xe5ADm+8Zfn3nL89Vl1hROh5T70xpS+KxjDPcw6kv0lON4snzd3bwPqcnx19
         8kK7ehB2lGq5tWXsTrcgig6NZqFdiQdFtZCyeJ87Z5DPcPsQ2VEMsUFCwIDu/VxWurho
         2ihJLQefjqzViE8V5jFmpgYm+LEni2DOIybH5q5bl94gxECSdyoIc5+DkO8lcdh+h47i
         Th8FuM5TNTGHtKXisOS7EP2iuo4/u7NcfRn6l8vItygVVroQ0d3Mbs+WKgzLvXow746H
         btEw==
X-Forwarded-Encrypted: i=1; AJvYcCVv3HI1DiyNwIdtKcz7gfFzytTPSuLV74Xwr3kL6R3SyUTpzEvUFPbiTa45yPhjVo2nytbteff89Su1nF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzY1KzW1g4y/TxP2Z5bt+8VpFc40Yofo6nW7siBqScgGZWXZt
	diL1M33sQAHWnnZg7P6v8/zJ0slGqZQKUUGwA5/xbYszyfjzL7ZZMtqJJ+e35XuUshq2mB3Kjjb
	/Qltf3uPLTrH8YQOGX5LOdv39fek/P4a7k6vHFuNXrWO4tfCskUI99XRLsJ4=
X-Google-Smtp-Source: AGHT+IGeVzWSE1E6Ebb8uzcPRiX0T8JPUDFEdFVwBFrFC1QGMLVOss5UXobxKtbbTzTJ8pNpYJS+sOdfhA+NOvYgZuRAGS8q1hd1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2287:b0:424:14a4:5064 with SMTP id
 e9e14a558f8ab-42d814db630mr26881755ab.0.1759279443020; Tue, 30 Sep 2025
 17:44:03 -0700 (PDT)
Date: Tue, 30 Sep 2025 17:44:03 -0700
In-Reply-To: <20251001001017.1094774-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc7953.050a0220.25d7ab.076d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_ext_insert_extent
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in ext4_ext_insert_extent

==================================================================
BUG: KASAN: slab-use-after-free in ext4_ext_insert_extent+0x41b6/0x4af0 fs/ext4/extents.c:2096
Read of size 4 at addr ffff888044a48c18 by task syz.1.185/7323

CPU: 0 UID: 0 PID: 7323 Comm: syz.1.185 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_ext_insert_extent+0x41b6/0x4af0 fs/ext4/extents.c:2096
 ext4_ext_map_blocks+0xf2d/0x2890 fs/ext4/extents.c:4420
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x860/0x1740 fs/ext4/inode.c:811
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:910
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:943
 ext4_block_write_begin+0x990/0x1710 fs/ext4/inode.c:1198
 ext4_write_begin+0xc04/0x19a0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x445/0xda0 fs/ext4/inode.c:3129
 generic_perform_write+0x2c2/0x900 mm/filemap.c:4175
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:798
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35f338e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35f42db038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f35f35b5fa0 RCX: 00007f35f338e969
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f35f3410ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f35f35b5fa0 R15: 00007ffcbdfba708
 </TASK>

Allocated by task 6265:
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
 tomoyo_path_perm+0x213/0x4b0 security/tomoyo/file.c:822
 security_inode_getattr+0x12f/0x330 security/security.c:2416
 vfs_getattr fs/stat.c:259 [inline]
 vfs_statx_path fs/stat.c:299 [inline]
 vfs_statx+0x18e/0x550 fs/stat.c:356
 vfs_fstatat+0x118/0x170 fs/stat.c:375
 __do_sys_newfstatat fs/stat.c:542 [inline]
 __se_sys_newfstatat fs/stat.c:536 [inline]
 __x64_sys_newfstatat+0x116/0x190 fs/stat.c:536
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6265:
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
 tomoyo_path_perm+0x213/0x4b0 security/tomoyo/file.c:822
 security_inode_getattr+0x12f/0x330 security/security.c:2416
 vfs_getattr fs/stat.c:259 [inline]
 vfs_statx_path fs/stat.c:299 [inline]
 vfs_statx+0x18e/0x550 fs/stat.c:356
 vfs_fstatat+0x118/0x170 fs/stat.c:375
 __do_sys_newfstatat fs/stat.c:542 [inline]
 __se_sys_newfstatat fs/stat.c:536 [inline]
 __x64_sys_newfstatat+0x116/0x190 fs/stat.c:536
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888044a48000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3096 bytes inside of
 freed 4096-byte region [ffff888044a48000, ffff888044a49000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x44a48
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a042140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a042140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001129201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6265, tgid 6265 (syz-executor), ts 162534949588, free_ts 162514529707
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
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_realpath_from_path+0xe3/0x5d0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x213/0x4b0 security/tomoyo/file.c:822
 security_inode_getattr+0x12f/0x330 security/security.c:2416
 vfs_getattr fs/stat.c:259 [inline]
 vfs_statx_path fs/stat.c:299 [inline]
 vfs_statx+0x18e/0x550 fs/stat.c:356
 vfs_fstatat+0x118/0x170 fs/stat.c:375
 __do_sys_newfstatat fs/stat.c:542 [inline]
 __se_sys_newfstatat fs/stat.c:536 [inline]
 __x64_sys_newfstatat+0x116/0x190 fs/stat.c:536
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5185 tgid 5185 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbb1/0xd20 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2758 [inline]
 __put_partials+0x156/0x1a0 mm/slub.c:3223
 put_cpu_partial+0x17c/0x250 mm/slub.c:3298
 __slab_free+0x2d5/0x3c0 mm/slub.c:4565
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x224/0x4f0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_realpath_from_path+0xe3/0x5d0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x213/0x4b0 security/tomoyo/file.c:822
 security_inode_getattr+0x12f/0x330 security/security.c:2416
 vfs_getattr fs/stat.c:259 [inline]
 vfs_fstat fs/stat.c:281 [inline]
 __do_sys_newfstat fs/stat.c:555 [inline]
 __se_sys_newfstat fs/stat.c:550 [inline]
 __x64_sys_newfstat+0xfc/0x200 fs/stat.c:550
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888044a48b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888044a48b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888044a48c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888044a48c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888044a48d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         4b81e2eb Merge tag 'timers-vdso-2025-09-29' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11af6942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb6d0df33502bde3
dashboard link: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134f6942580000


