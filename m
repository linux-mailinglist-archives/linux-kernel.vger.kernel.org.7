Return-Path: <linux-kernel+bounces-859533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC5BEDE84
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1C63B6A76
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CDC21CC4D;
	Sun, 19 Oct 2025 05:36:13 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C181ADC97
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760852172; cv=none; b=o2wz54O4VA25hct/Mt+T9pB72Lk7YwJ9GHLFDYdmLy0ZWYnHOX6qyVWGsyTeTaDSjlX7tXqfCHfJPAN5EIm5Nv20jVfIC5CcFAaarIQASVUlB1OFRtEyEI5eq23g+Kd3tlQqsCspdY0kW2DTTZZ0IAwYZsylyxz+0tA8ecETX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760852172; c=relaxed/simple;
	bh=02ZqNH4MHDERHCMJG8ZmQcoq221TxBujGWspZwC2XC0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BHJb2VvWlqdY0PmZc3dCnwNPjIvAjk+ZoynXgIIN9jSofIleWtlz7IprHvhR3buWH/ixme5c5Oz75iwJ32DiX+0GxNuTQaX/TmAh0W16jZnH6AT/RJOvbYXPCyHk5AbH+m0Cf4O0CHbEZvZrndMxMjDNZabv3DarOWGCdWXLElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940d3efe58bso22685939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 22:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760852164; x=1761456964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9qxqwC/aKvFZZOzwbfYf2j4w0vd7INmp8xbd9RZ/MU=;
        b=WXuH5ldiWnqpn21maA99KQN3LAGGldAFwdbZcdA/NRFZyGxMCNNzYTWxsugRowQdK4
         Q4SbZi883JaB6ZhMZsjgSg2v/8uHU3zdDFIKS1p4pC27gB4SSB6WYgJ+vLYklQBnOG2s
         y/S/PqlqkCB5IvKgz1L1J4jfqX/M7jsEyWwhKZcY0A98ZjEcf4laNIPFCE+PVP5fZEK5
         eARP7vwSYrGph29zV/wvYsuzOc0VMsE8SLPiYjaw41KKJo+iBR/Ff4LVITBxsV3hKXkv
         8tihA6HQv7nKMgVKe/Q3Q4uW9JJGX8gW9DRjbo1lRL3tPOkz8CHbgzgvCaNIXfqFI5Dp
         O4ow==
X-Gm-Message-State: AOJu0YwOMNtRm6SeMxGerjB16XS4BPAdixUwa0bQ1NtmInhiTxPMOJux
	Qbn/4cqp57yATPAoO3BSLaqGiPvqKc/V/4Gj1CCjMywBUftaki88rMb6jAG7VFnHoFv6HlB5Ods
	TOL56EQy1MOUG2FBC5vpD8BRuzvtVnTC2zZr0iWf7FYIKWHD91DHRopoaISw=
X-Google-Smtp-Source: AGHT+IEs7lPQOqb9A90Wm8tlk6dpXUVxH4jpb9C3qnY0aKcQTN01HCwHTDpCJgGVfLYPYhrl6Y5ZpRZU25kjEf+cb8oQH5qeSluI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3426:b0:93e:8817:dac1 with SMTP id
 ca18e2360f4ac-93e8817de47mr899103039f.8.1760852164085; Sat, 18 Oct 2025
 22:36:04 -0700 (PDT)
Date: Sat, 18 Oct 2025 22:36:04 -0700
In-Reply-To: <luix3x4zjs7wt2nxbum2iihi4zdsqefj3njqglgkreehenags2@47i3wmfhboyo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f478c4.050a0220.91a22.0435.GAE@google.com>
Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in nr_add_node
From: syzbot <syzbot+2860e75836a08b172755@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in nr_add_node

==================================================================
BUG: KASAN: slab-use-after-free in nr_add_node+0x25e5/0x2c10 net/netrom/nr_route.c:249
Read of size 4 at addr ffff88802b876030 by task syz.2.1937/10375

CPU: 0 UID: 0 PID: 10375 Comm: syz.2.1937 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 nr_add_node+0x25e5/0x2c10 net/netrom/nr_route.c:249
 nr_rt_ioctl+0x11b7/0x29b0 net/netrom/nr_route.c:653
 nr_ioctl+0x19a/0x2d0 net/netrom/af_netrom.c:1254
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35ebf8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35ecd77038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f35ec1e5fa0 RCX: 00007f35ebf8efc9
RDX: 0000200000000280 RSI: 000000000000890b RDI: 0000000000000004
RBP: 00007f35ec011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f35ec1e6038 R14: 00007f35ec1e5fa0 R15: 00007ffff17dcae8
 </TASK>

Allocated by task 10366:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kmalloc_noprof include/linux/slab.h:957 [inline]
 nr_add_node+0xe4e/0x2c10 net/netrom/nr_route.c:146
 nr_rt_ioctl+0x11b7/0x29b0 net/netrom/nr_route.c:653
 nr_ioctl+0x19a/0x2d0 net/netrom/af_netrom.c:1254
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802b876000
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 48 bytes inside of
 freed 64-byte region [ffff88802b876000, ffff88802b876040)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b876
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b4428c0 ffffea0000926300 dead000000000006
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6284, tgid 6284 (syz-executor), ts 96678923529, free_ts 96199339256
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5183
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3046 [inline]
 allocate_slab mm/slub.c:3219 [inline]
 new_slab+0x24a/0x360 mm/slub.c:3273
 ___slab_alloc+0xdc4/0x1ae0 mm/slub.c:4643
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4762
 __slab_alloc_node mm/slub.c:4838 [inline]
 slab_alloc_node mm/slub.c:5260 [inline]
 __kmalloc_cache_noprof+0x477/0x780 mm/slub.c:5750
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 mpls_add_dev net/mpls/af_mpls.c:1443 [inline]
 mpls_dev_notify+0x346/0xa20 net/mpls/af_mpls.c:1600
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2229
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x182e/0x2270 net/core/dev.c:11332
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1059 [inline]
 nsim_create+0xdd5/0x1260 drivers/net/netdevsim/netdev.c:1141
 __nsim_dev_port_add+0x435/0x7d0 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1494 [inline]
 nsim_drv_probe+0xe40/0x1520 drivers/net/netdevsim/dev.c:1653
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
page last free pid 6298 tgid 6298 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
 discard_slab mm/slub.c:3317 [inline]
 __put_partials+0x130/0x170 mm/slub.c:3864
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4962 [inline]
 slab_alloc_node mm/slub.c:5272 [inline]
 kmem_cache_alloc_noprof+0x250/0x6e0 mm/slub.c:5279
 getname_flags.part.0+0x4c/0x550 fs/namei.c:146
 getname_flags+0x93/0xf0 include/linux/audit.h:345
 getname include/linux/fs.h:2922 [inline]
 getname_maybe_null include/linux/fs.h:2929 [inline]
 getname_maybe_null include/linux/fs.h:2926 [inline]
 vfs_fstatat+0xe1/0xf0 fs/stat.c:370
 __do_sys_newfstatat+0x97/0x120 fs/stat.c:542
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802b875f00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88802b875f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802b876000: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                     ^
 ffff88802b876080: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
 ffff88802b876100: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         1c64efcb Merge tag 'rust-rustfmt' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1166f67c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=2860e75836a08b172755
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1069dc58580000


