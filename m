Return-Path: <linux-kernel+bounces-775044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 750A5B2BAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA7B1BC11F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675E2737E1;
	Tue, 19 Aug 2025 07:23:32 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201371F0E34
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588212; cv=none; b=KQUlLAmtkuvfO68TUIAt2WQhYhj9CzQSPBy+2Povzi5Kngb5/3B7ZFmkQjauNX0/cMm2lidxaznBU1n1u23ndF9vqsgf3ums4xaW4XQm12BTWOb7xoRUupSXvh0y6W84Lwv33A+djWbQKF3j2fpaXYmzS7Oo45uHEt3Rzevz0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588212; c=relaxed/simple;
	bh=nfGkUxx1t599uzWybak5ze1FItnI0xsBxEVbSeR6owk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nPWHU0DS0SawPffJtnYWTUSZJy3u66J+rv0G/h0PtXC5ES+RYlnQkt+8Im3KglwEjso3qHng99R9DO1od9vVndkZi0gHyBr81c2Nv5vHWMj/fzWcr78fVEVdQ5eQJ0vTvWcdYEq/jRbz52BPTS9qUN0ZLwm/aBgRP0MA8BfuO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88432d877bfso1278196739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588209; x=1756193009;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GVqfu6wyJJrM9P3CmGJb9XaHjTTVPJbs5Rl1aSW2Eg=;
        b=PVsIDN/NfVR5khZwqTns3fb4FMcdGYiQXzddYTzBQbPBTztwNds5KV3uICbOsH2XuA
         7hNo3YYf/TWZyukMGJrnRzjesubpZJkY7/eiTPxgG7hT51tYGSYWmbrNZlF0aG5+pClT
         C1axSELMWD7AEv8YrbTxBjbN409hFTqZpK2TjojN/KKr83KvtNuskNRjsIDxhLpXYIdh
         AdfSSrmMIoMclIIRrGb/z3chLLboXdCDuE28cBftwzvjUIkytqCBk1h5/qAZ3ABdQNaz
         +EAEVAP2DcHntp5lKio5Yo9bX+8EPVqGKIXE7cW71pxyorFf1p8LPSS1LYBb4oLf2Bxz
         J5ug==
X-Forwarded-Encrypted: i=1; AJvYcCXQcAsBLMihUYCtOGfHuX6XfyaYT7q90BuBxwelxuZknEFKWLXq/posD4LOgOpiTmpomCJaGvxJZ5Tu4ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTHwbYLL/8kY/HoqK5fRmyFQ6kcocdlrjJYZ3Ppy2+tVN5FRK
	ckCM9IkLn3SQ8pOJ26a5jYVraYJTsPKCzV/uwpN+WBaGhQmYCVmpUm9w/gIAdrZENgZXs7K2i6B
	TREfXj9bIczC5b5kWOff5gUz2nlbHvLFtz5+sBWLkafdzr6x600T3jxS2XsQ=
X-Google-Smtp-Source: AGHT+IG96naQ1dTMzhzPtk6NJCllIx7ctV135cOL5ZjQadbjiPOVaoCVGVhaF4WXFYW/+vmCE/IDAtRBMSBhIQiOHDZgwFsZWITv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc1:b0:881:85cd:d08e with SMTP id
 ca18e2360f4ac-88467e825c4mr255919239f.3.1755588209259; Tue, 19 Aug 2025
 00:23:29 -0700 (PDT)
Date: Tue, 19 Aug 2025 00:23:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a42671.050a0220.e29e5.00bf.GAE@google.com>
Subject: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Write in ntfs_read_run_nb
From: syzbot <syzbot+469f16243a55e0098ea3@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    be48bcf004f9 Merge tag 'for-6.17-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b5d234580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9f694461848a008
dashboard link: https://syzkaller.appspot.com/bug?extid=469f16243a55e0098ea3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1397c6f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7f60d7b6589/disk-be48bcf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fe093258314/vmlinux-be48bcf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/493b5928449f/bzImage-be48bcf0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/af731da4c932/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+469f16243a55e0098ea3@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Differ[  377.578305][T10283] ntfs3(loop0): Different NTFS sector size (1024) and media sector size (512).
==================================================================
BUG: KASAN: slab-out-of-bounds in ntfs_read_run_nb+0x4e2/0xdb0 fs/ntfs3/fsntfs.c:1232
Write of size 1024 at addr ffff888029ed4000 by task syz.0.1974/10283

CPU: 1 UID: 0 PID: 10283 Comm: syz.0.1974 Tainted: G        W           6.17.0-rc2-syzkaller-00028-gbe48bcf004f9 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 ntfs_read_run_nb+0x4e2/0xdb0 fs/ntfs3/fsntfs.c:1232
 ntfs_read_bh+0x40/0x7e0 fs/ntfs3/fsntfs.c:1293
 mi_read+0x194/0x5a0 fs/ntfs3/record.c:133
 ntfs_read_mft fs/ntfs3/inode.c:70 [inline]
 ntfs_iget5+0x45b/0x37c0 fs/ntfs3/inode.c:540
 ntfs_fill_super+0x3927/0x40b0 fs/ntfs3/super.c:1519
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efe277b038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efe26e1de68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007efe26e1def0 RCX: 00007efe277b038a
RDX: 0000200000000040 RSI: 00002000000001c0 RDI: 00007efe26e1deb0
RBP: 0000200000000040 R08: 00007efe26e1def0 R09: 0000000000814000
R10: 0000000000814000 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007efe26e1deb0 R14: 000000000001f855 R15: 0000200000000140
 </TASK>

Allocated by task 10283:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x1ef/0x430 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 mi_init+0x76/0xe0 fs/ntfs3/record.c:105
 ntfs_read_mft fs/ntfs3/inode.c:54 [inline]
 ntfs_iget5+0x356/0x37c0 fs/ntfs3/inode.c:540
 ntfs_fill_super+0x3927/0x40b0 fs/ntfs3/super.c:1519
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888029ed4000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 allocated 1023-byte region [ffff888029ed4000, ffff888029ed43ff)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29ed0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff888019841dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 0080000000000040 ffff888019841dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 0080000000000003 ffffea0000a7b401 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4350, tgid 4350 (kworker/u8:11), ts 89554626456, free_ts 88744354126
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2119/0x21b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0x8d1/0xdd0 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x145/0x430 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 ieee802_11_parse_elems_full+0x152/0x2ab0 net/mac80211/parse.c:1011
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2462 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2469 [inline]
 ieee80211_inform_bss+0x10c/0x10a0 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0xd21/0x1ab0 net/wireless/scan.c:2379
 cfg80211_inform_bss_data+0x1fb/0x3b30 net/wireless/scan.c:3234
 cfg80211_inform_bss_frame_data+0x3d7/0x730 net/wireless/scan.c:3325
 ieee80211_bss_info_update+0x746/0x9e0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1094 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1573 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xa36/0x2ae0 net/mac80211/ibss.c:1600
 ieee80211_iface_process_skb net/mac80211/iface.c:1699 [inline]
 ieee80211_iface_work+0x85f/0x12d0 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x2bb/0x470 net/wireless/core.c:435
page last free pid 13 tgid 13 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xb59/0xce0 mm/page_alloc.c:2895
 __slab_free+0x2db/0x390 mm/slub.c:4591
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_node_noprof+0x14e/0x330 mm/slub.c:4281
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
 alloc_skb include/linux/skbuff.h:1336 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 inet6_netconf_notify_devconf+0x10f/0x1d0 net/ipv6/addrconf.c:593
 __addrconf_sysctl_unregister net/ipv6/addrconf.c:7355 [inline]
 addrconf_sysctl_unregister net/ipv6/addrconf.c:7379 [inline]
 addrconf_ifdown+0x157f/0x18c0 net/ipv6/addrconf.c:4006
 addrconf_notify+0x1bc/0x1010 net/ipv6/addrconf.c:-1
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 unregister_netdevice_many_notify+0x14d7/0x1fe0 net/core/dev.c:12154
 unregister_netdevice_many net/core/dev.c:12217 [inline]
 default_device_exit_batch+0x819/0x890 net/core/dev.c:12721
 ops_exit_list net/core/net_namespace.c:204 [inline]
 ops_undo_list+0x522/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4cb/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319

Memory state around the buggy address:
 ffff888029ed4280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888029ed4300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888029ed4380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 07
                                                                ^
 ffff888029ed4400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888029ed4480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

