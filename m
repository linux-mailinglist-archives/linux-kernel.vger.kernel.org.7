Return-Path: <linux-kernel+bounces-788848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD19B38AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50696189E9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C9284B35;
	Wed, 27 Aug 2025 20:33:41 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD811C3C08
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326820; cv=none; b=UtVcJd+7BwlXlyWUpNMgG2nQ/RP8qF1evXaq30cp1g35VNiE9bMVbwr6vVb89iqjl7xdccwhzXBPSnFIziU6SWFIshUNTR0I5tHndDsxti5xPm6U2efR4wej8F+zO5Sm/gEMAMyaGQxoKUsRAZSPZf1RuizUeTwU0OMc7YliGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326820; c=relaxed/simple;
	bh=xPuG+qUhqTW3G4H+uPp506IaIqsO905LH7HNMtz/Q0E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pLflYGWRh4V/HB8UdkMTuQ2WSPpdI4d0OegyRG+DftUceayRqpGTwuIzQMwshiNssNoPZo2N0NDtQieOT7Ko1rOx47RV+TUU936XKAB2seU0wxesg2qwr+4Br+dhSgYgyOfykhW3C7E+BGoD4rxm82J4YLrhkpbTDUBJzij9AJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ea2bd7b667so7008825ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756326818; x=1756931618;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClMMWPm0halKkm7yoGCwfsVNtnQ0YJOwTOy1VEYzY0A=;
        b=eyc1AHLkNntUKQL7xBCgIsRvu/mFmn53Z+KFYCeDC0zoXbYZNYtd1BNdob83NWLmku
         6Ni5D2DhE78thq62wvwp+po2aW9gCKO+tHun0iN2kuAKShwNu+rhGQaOb+rKJLXEossp
         oc3s9/S0ioS5bOJVMISBU/6iTmYlldUniHX2VhhNcCOa+66OLWMcM+v+1ycivlskWx2N
         j2qEUPLvfk4QkVxv8NHPdBzInRYIuDvyXXT0QKGGE9ar6zFaNOvvmBwyMJqruJeK+aTf
         oLGwMd72wb5rRm1bgKittjclGMt096PXnzSfGD0yvFmeEnRrTNWKeSySzvlZIP6PbeHK
         cFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+725uZnEq6eWF55R66+CHY/o+c2lBgNtfg/bizT5xGBYjyPYdoErjRSMHwbP0UhgwIZQ+bcPmz8OF1qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KPO+hUgZTN0aQiaQir6ZJz1tSGBVZJ8gi5gfmFsPe1hiOA6A
	i3M2HgesudkGkJe0xtMxVD42QWcafofvKQ6vKr4V/mLNem8mf8fTgrvbFLLR3NTbdRMfMMJr6Ol
	Kopm/v7Ka7doAXULb84e9drxGb40yS+Iswv7gRBfJkz9fFqmmBECuQe7PFC0=
X-Google-Smtp-Source: AGHT+IFr42bWTP2BVIAPBvd3kBfvGI0HWMGsXQiOl0SHGkEgP/4kACwt/1rvrAiCs+q4WgdtlT4ie4WM0IXIiBdWj62bOjWZWHBp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2308:b0:3ef:d092:c07d with SMTP id
 e9e14a558f8ab-3efd092c0d2mr62467855ab.16.1756326813782; Wed, 27 Aug 2025
 13:33:33 -0700 (PDT)
Date: Wed, 27 Aug 2025 13:33:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af6b9d.a70a0220.3cafd4.0032.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in release_sock (2)
From: syzbot <syzbot+e5e64cdf8e92046dd3e1@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32b7144f806e Merge tag 'libcrypto-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162256f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=e5e64cdf8e92046dd3e1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-32b7144f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c99ef9a67dcb/vmlinux-32b7144f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/674eddcd5e31/bzImage-32b7144f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5e64cdf8e92046dd3e1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_lock+0x26f/0x2b0 kernel/locking/spinlock_debug.c:115
Read of size 4 at addr ffff88803b7eb1c4 by task syz.5.3276/16995

CPU: 3 UID: 0 PID: 16995 Comm: syz.5.3276 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x26f/0x2b0 kernel/locking/spinlock_debug.c:115
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 release_sock+0x21/0x220 net/core/sock.c:3746
 bt_accept_dequeue+0x505/0x600 net/bluetooth/af_bluetooth.c:312
 l2cap_sock_cleanup_listen+0x5c/0x2a0 net/bluetooth/l2cap_sock.c:1451
 l2cap_sock_release+0x5c/0x210 net/bluetooth/l2cap_sock.c:1425
 __sock_release+0xb3/0x270 net/socket.c:649
 sock_close+0x1c/0x30 net/socket.c:1439
 __fput+0x3ff/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2accf8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb6cb1378 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00000000000426fb RCX: 00007f2accf8ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f2acd1b7da0 R08: 0000000000000001 R09: 00000012b6cb166f
R10: 0000001b30e20000 R11: 0000000000000246 R12: 00007f2acd1b609c
R13: 00007f2acd1b6090 R14: ffffffffffffffff R15: 00007ffdb6cb1490
 </TASK>

Allocated by task 5326:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 sk_prot_alloc+0x1a8/0x2a0 net/core/sock.c:2239
 sk_alloc+0x36/0xc20 net/core/sock.c:2295
 bt_sock_alloc+0x3b/0x3a0 net/bluetooth/af_bluetooth.c:151
 l2cap_sock_alloc.constprop.0+0x33/0x1d0 net/bluetooth/l2cap_sock.c:1894
 l2cap_sock_new_connection_cb+0x101/0x240 net/bluetooth/l2cap_sock.c:1482
 l2cap_connect_cfm+0x4c4/0xf80 net/bluetooth/l2cap_core.c:7287
 hci_connect_cfm include/net/bluetooth/hci_core.h:2050 [inline]
 hci_remote_features_evt+0x4dd/0x970 net/bluetooth/hci_event.c:3712
 hci_event_func net/bluetooth/hci_event.c:7519 [inline]
 hci_event_packet+0xa0d/0x11c0 net/bluetooth/hci_event.c:7573
 hci_rx_work+0x2c5/0x16b0 net/bluetooth/hci_core.c:4071
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 16995:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x60/0x70 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4879
 sk_prot_free net/core/sock.c:2278 [inline]
 __sk_destruct+0x75f/0x9a0 net/core/sock.c:2373
 sk_destruct+0xc2/0xf0 net/core/sock.c:2401
 __sk_free+0xf4/0x3e0 net/core/sock.c:2412
 sk_free+0x6a/0x90 net/core/sock.c:2423
 sock_put include/net/sock.h:1960 [inline]
 bt_accept_unlink+0x245/0x2e0 net/bluetooth/af_bluetooth.c:262
 bt_accept_dequeue+0x517/0x600 net/bluetooth/af_bluetooth.c:308
 l2cap_sock_cleanup_listen+0x5c/0x2a0 net/bluetooth/l2cap_sock.c:1451
 l2cap_sock_release+0x5c/0x210 net/bluetooth/l2cap_sock.c:1425
 __sock_release+0xb3/0x270 net/socket.c:649
 sock_close+0x1c/0x30 net/socket.c:1439
 __fput+0x3ff/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803b7eb000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 452 bytes inside of
 freed 2048-byte region [ffff88803b7eb000, ffff88803b7eb800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3b7e8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b842f00 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b842f00 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000edfa01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5972, tgid 5972 (syz-executor), ts 43865453144, free_ts 42562860965
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab mm/slub.c:2655 [inline]
 new_slab+0x247/0x330 mm/slub.c:2709
 ___slab_alloc+0xcf2/0x1740 mm/slub.c:3891
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3981
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4384
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:600
 __alloc_skb+0x166/0x380 net/core/skbuff.c:669
 alloc_skb include/linux/skbuff.h:1336 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 rtmsg_ifinfo_build_skb+0x81/0x280 net/core/rtnetlink.c:4392
 rtmsg_ifinfo_event net/core/rtnetlink.c:4434 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4424 [inline]
 rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4443
 register_netdevice+0x1bd9/0x2270 net/core/dev.c:11246
 __ip_tunnel_create+0x540/0x6e0 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x22f/0x7d0 net/ipv4/ip_tunnel.c:1161
 ops_init+0x1df/0x5f0 net/core/net_namespace.c:136
page last free pid 5942 tgid 5942 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 __folio_put+0x329/0x450 mm/swap.c:112
 folio_put include/linux/mm.h:1360 [inline]
 put_page include/linux/mm.h:1429 [inline]
 put_netmem net/core/skbuff.c:7370 [inline]
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x81a/0x9e0 net/core/skbuff.c:1080
 skb_release_all net/core/skbuff.c:1151 [inline]
 napi_consume_skb+0x15a/0x220 net/core/skbuff.c:1479
 skb_defer_free_flush net/core/dev.c:6635 [inline]
 skb_defer_free_flush net/core/dev.c:6619 [inline]
 net_rx_action+0x47f/0xfe0 net/core/dev.c:7665
 handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
 do_softirq kernel/softirq.c:480 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:467
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:910 [inline]
 __dev_queue_xmit+0xb06/0x4490 net/core/dev.c:4740
 dev_queue_xmit include/linux/netdevice.h:3361 [inline]
 neigh_hh_output include/net/neighbour.h:531 [inline]
 neigh_output include/net/neighbour.h:545 [inline]
 ip_finish_output2+0xc38/0x21a0 net/ipv4/ip_output.c:235
 __ip_finish_output.part.0+0x1b4/0x350 net/ipv4/ip_output.c:313
 __ip_finish_output net/ipv4/ip_output.c:301 [inline]
 ip_finish_output net/ipv4/ip_output.c:323 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x35e/0xa10 net/ipv4/ip_output.c:436
 dst_output include/net/dst.h:461 [inline]
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x1d30/0x2620 net/ipv4/ip_output.c:532
 __tcp_transmit_skb+0x265f/0x3df0 net/ipv4/tcp_output.c:1479
 __tcp_send_ack.part.0+0x3de/0x700 net/ipv4/tcp_output.c:4285
 __tcp_send_ack net/ipv4/tcp_output.c:4291 [inline]
 tcp_send_ack+0x84/0xa0 net/ipv4/tcp_output.c:4291

Memory state around the buggy address:
 ffff88803b7eb080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803b7eb100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803b7eb180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88803b7eb200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803b7eb280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

