Return-Path: <linux-kernel+bounces-838251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1476CBAECBE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829A4194304D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE5B2D2385;
	Tue, 30 Sep 2025 23:45:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165E2D2381
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275906; cv=none; b=f4eAEK8R9R65IFsnaRpbx1WlayPENBOQetZCSAHzm9IIhCcqimJY5hAsNLaAMxB7ETycM+YXdrR/3NVIMc+IWQHUs0LGL7gVwMkvQpcQLhBfNBm7ZKk8/DbWhJ5EWyXtK3ctS1F4LRu20yGcBU8X8CPgGDcYVJ91786FYGPwDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275906; c=relaxed/simple;
	bh=R4O1l9rnmupg/A0ZngLlda5xXZOzu/eJm5saxxzm+JM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kv9e4TVqmNaHaqiqmZAs4AA81SoQxdJrKBdR5bGEc2JWaOKZ8SGRPcEhb0JGvBjRW3V/TJx0wr3G/MM6qZC9ie4amX9fwf514bKBKKPpSNlgGJIKREjKg9OKBtAUZYnfRpBT4Z3rrrcxpNoDADuFzRcBjiK9lPO6HY+A1DuCnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257ae42790so101356255ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759275904; x=1759880704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QsQbuls882TEuIBp1zpQH3VDhodQUjSn0FV+BP3pjg=;
        b=rdDGN8GB8dpeOjssdIaokanQAVYQPApf0c0prlAhGOuS4MUxrOpjZo6y4vvVJEX//T
         /XdNdH9Fy6ZyP8URKzDPJ0wlkt7m4JWztEHyR85zhvYqw3TxeMb19QqGJe34KBMQO5VU
         g3FxHW2D+iHndnS8KRqqtiSZ6WaeP+q+lbKJ2yecKBYevuoqHueLF+WaZ6tSpoZOltxe
         LZHkDS4CwlOCVS/QRT6OXbImYQn29fsHeXlzc547rPElROyRfEQ1GHteLKXQTvv8LLkh
         XfHHLfAvMFDmgXk+XwuXk36cPx0dceNbojjH40IVj0jEBrjHdqHqjRxs87DnpNxzSjk6
         eVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqVKFK5OsEyxCr/Ffe8/g607d61hMgeuzUZWlofHcr9G2G6NpEYYX+u+wNe5pfoC5yCAChFHfTlp3X23I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhin1u/AzruLY7Tlcv8JUNDWavlEk9TVGPYYK6hQhdbnTIo8XL
	84OqDT+URVXeRpdAuk+9p2n5r6OHOxqqyqw9stV0XBeqL7TvkjQQtzgOxx31f3Qoj2I/EQcBx2N
	tyUyW7ZECarFyCFV3tgElwrCvUoqcOEjQA2REcwayTUTJbNqh9jjL9fkccb4=
X-Google-Smtp-Source: AGHT+IEkZ7mkEQ3QoePyAlnkwE+lsfzxNYbO174U5qK1enEaQcW8qKQKEj30qK+anofoV6Bkwceu8/cDdShpBNCD0J0rhCRNR9I6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194e:b0:425:7974:fe21 with SMTP id
 e9e14a558f8ab-42d8167e8bbmr25208855ab.22.1759275903706; Tue, 30 Sep 2025
 16:45:03 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:45:03 -0700
In-Reply-To: <20250930230857.946230-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc6b7f.050a0220.25d7ab.076b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_ext_insert_extent
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in ext4_ext_insert_extent

EXT4-fs (loop4): stripe (1570) is not aligned with cluster size (16), stripe is disabled
==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_ext_insert_extent+0x41b6/0x4af0 fs/ext4/extents.c:2096
Read of size 4 at addr ffff88805b641c18 by task syz.4.165/7385

CPU: 0 UID: 0 PID: 7385 Comm: syz.4.165 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_ext_insert_extent+0x41b6/0x4af0 fs/ext4/extents.c:2096
 ext4_ext_map_blocks+0x1bc9/0x3890 fs/ext4/extents.c:4420
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x860/0x1740 fs/ext4/inode.c:811
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:910
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:943
 ext4_block_write_begin+0x993/0x1710 fs/ext4/inode.c:1198
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
RIP: 0033:0x7fbff2b8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbff3a58038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007fbff2db5fa0 RCX: 00007fbff2b8e969
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007fbff2c10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbff2db5fa0 R15: 00007ffc69cdac78
 </TASK>

Allocated by task 6339:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kvmalloc_node_noprof+0x30d/0x5f0 mm/slub.c:5067
 alloc_netdev_mqs+0xa3/0x11b0 net/core/dev.c:11812
 rtnl_create_link+0x31f/0xd10 net/core/rtnetlink.c:3633
 rtnl_newlink_create+0x25c/0xb00 net/core/rtnetlink.c:3815
 __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
 rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2231
 __do_sys_sendto net/socket.c:2238 [inline]
 __se_sys_sendto net/socket.c:2234 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2234
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805b640000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3696 bytes to the right of
 allocated 3496-byte region [ffff88805b640000, ffff88805b640da8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5b640
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802ed031c1
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a04b500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000000f5000000 ffff88802ed031c1
head: 00fff00000000040 ffff88801a04b500 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000000f5000000 ffff88802ed031c1
head: 00fff00000000003 ffffea00016d9001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6339, tgid 6339 (syz-executor), ts 122638337757, free_ts 82614727744
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
 __kvmalloc_node_noprof+0x429/0x5f0 mm/slub.c:5067
 alloc_netdev_mqs+0xa3/0x11b0 net/core/dev.c:11812
 rtnl_create_link+0x31f/0xd10 net/core/rtnetlink.c:3633
 rtnl_newlink_create+0x25c/0xb00 net/core/rtnetlink.c:3815
 __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
 rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
page last free pid 5876 tgid 5876 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbb1/0xd20 mm/page_alloc.c:2895
 vfree+0x25a/0x400 mm/vmalloc.c:3434
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:961
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x125e/0x1310 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805b641b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805b641b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805b641c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff88805b641c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805b641d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         22bdd6e6 Merge tag 'x86_apic_for_v6.18_rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108366e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6899ea2dd30a3ed1
dashboard link: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13088092580000


