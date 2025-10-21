Return-Path: <linux-kernel+bounces-862665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 167BABF5DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A621018C7503
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEC32A3FF;
	Tue, 21 Oct 2025 10:48:34 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB42F0C67
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043713; cv=none; b=OvU3dntCkORXe5cHAAD2J5TTutQf+sIxGwPJkMQpe9niC8ix3Lx81mYIgLPPh7OApyemyZVM3pP9r4pIdNqd/O0TUnZLntulbAU3Ew+GOvsNNiotfjOPiGWP4v7cTM6zw0n+SBXO7d4VBexRTRMeRUahBGnE7CDhkoeOnsFGq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043713; c=relaxed/simple;
	bh=ekkOu9pFXf7K5W+tHX9vLbOkRky/WUvnLCrfPYvleHo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fr+qBwa0+pk02r0SmqTis1dlQ06LSntwim2zcBEffOdBNJc0WNKSy7FvgfX4KX8djLLbtyimV2pVXZ0wp6iK8SCfMq3DdFxRK3t8zv2f3CxNENTF2vPT6B8c5IX7Mk9RFiEJApJq8kKWOUmTSdXo9BJrO9GgWHU1hhERrXOYlNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-430c8321bc1so52531885ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043710; x=1761648510;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQQNjQEnn+ShjDzxcQC6CUi/l7dSE95szG+U/bFP8XA=;
        b=Guhk6IcGbfY+BG9Qp0NkM+QxTdBb/ZsmJqh0dignAAjo7/6xZh6lSuMsjGmDkeXcVR
         9ZpLPeVc+1GiP29ffegtaWBuMnYxdZ9shIb0OHvntE9wFG4CiOk3aZf8V48V8wfBphbj
         xjQ2Lq+eLLlvwng8JWbHH5xNh1i4oXCUGXl7WxoM8z+UO6ife6iEI53LMrTLp4f3Iv7+
         GeOq2h3GHu4m4NGcC/zn4GaF2qaspgWw7C2XyNDrJlziX+yyhZxGboio0Rrp7YapTORh
         dLpIiUXvUeNoJdGGmfbsOJuBR/LTLsm7k6/tNt+BhmTeg+CpzoxXd5ik0VpI2MlCvQNX
         jLSw==
X-Gm-Message-State: AOJu0Yxec8luGqTxY8f/Ry6STXLpqYGSE84kghbyPs2rLbhtq0IjIhbW
	tYbAw5nsRywiO5j/ycJszbOL+5bRDx5zXSdKFjgmZTsIytwMJEiL1JAtEB2UTnqYcUAmGrOM1S2
	Y31cxGI8kH/3Rk15PVah6f2U+G/5wELAiq/ag0T9F1KP0HHqnBybEXowyA5LBGA==
X-Google-Smtp-Source: AGHT+IFRmQhYKe26WCgdemVPVszYqb8xciqjiaTnD9lb9rjczjEabZzEouPiYe6jpS6tz0aF4aya712aJl/wp5Ai4DkB/Sndonpo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e06:b0:430:b147:3b70 with SMTP id
 e9e14a558f8ab-430c524ce8amr225468285ab.6.1761043710396; Tue, 21 Oct 2025
 03:48:30 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:48:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f764fe.050a0220.346f24.0011.GAE@google.com>
Subject: [syzbot] [sound?] KASAN: slab-use-after-free Read in snd_pcm_action
From: syzbot <syzbot+addf1973f8732e2cc468@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    211ddde0823f Linux 6.18-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16304e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=216353986aa62c5d
dashboard link: https://syzkaller.appspot.com/bug?extid=addf1973f8732e2cc468
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07371cf02d4e/disk-211ddde0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/27220c94ca08/vmlinux-211ddde0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/12abd01b8291/bzImage-211ddde0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+addf1973f8732e2cc468@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
Read of size 1 at addr ffff8880338ae1c0 by task syz.7.3131/20318

CPU: 0 UID: 0 PID: 20318 Comm: syz.7.3131 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:580
 kasan_check_byte include/linux/kasan.h:401 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 rtlock_slowlock kernel/locking/rtmutex.c:1894 [inline]
 rtlock_lock kernel/locking/spinlock_rt.c:43 [inline]
 __rt_spin_lock kernel/locking/spinlock_rt.c:49 [inline]
 rt_spin_lock+0x14a/0x3e0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 __wake_up_common_lock+0x2f/0x1e0 kernel/sched/wait.c:124
 snd_pcm_action_single sound/core/pcm_native.c:-1 [inline]
 snd_pcm_action+0x1f4/0x240 sound/core/pcm_native.c:1393
 loopback_check_format sound/drivers/aloop.c:363 [inline]
 loopback_trigger+0xb82/0x1b60 sound/drivers/aloop.c:411
 snd_pcm_do_start+0xb7/0x180 sound/core/pcm_native.c:1454
 snd_pcm_action_single sound/core/pcm_native.c:1310 [inline]
 snd_pcm_action+0xe7/0x240 sound/core/pcm_native.c:1393
 __snd_pcm_lib_xfer+0x1762/0x1ce0 sound/core/pcm_lib.c:2405
 snd_pcm_oss_write3+0x1bc/0x320 sound/core/oss/pcm_oss.c:1241
 snd_pcm_plug_write_transfer+0x2cb/0x4c0 sound/core/oss/pcm_plugin.c:630
 snd_pcm_oss_write2 sound/core/oss/pcm_oss.c:1373 [inline]
 snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1439 [inline]
 snd_pcm_oss_write+0xba2/0x11a0 sound/core/oss/pcm_oss.c:2794
 vfs_write+0x287/0xb40 fs/read_write.c:684
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd64e82efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd64ca75038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd64ea86090 RCX: 00007fd64e82efc9
RDX: 0000000000004000 RSI: 00002000000012c0 RDI: 0000000000000005
RBP: 00007fd64e8b1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd64ea86128 R14: 00007fd64ea86090 R15: 00007ffd87fbae38
 </TASK>

Allocated by task 20315:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x1ef/0x6c0 mm/slub.c:5755
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 snd_pcm_attach_substream+0x5b7/0xb50 sound/core/pcm.c:938
 snd_pcm_open_substream+0xb9/0x23a0 sound/core/pcm_native.c:2756
 snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2437 [inline]
 snd_pcm_oss_open+0xf35/0x1bf0 sound/core/oss/pcm_oss.c:2518
 chrdev_open+0x4cf/0x5e0 fs/char_dev.c:414
 do_dentry_open+0x9b1/0x1350 fs/open.c:965
 vfs_open+0x3b/0x350 fs/open.c:1097
 do_open fs/namei.c:3975 [inline]
 path_openat+0x2ef1/0x3840 fs/namei.c:4134
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 20314:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2530 [inline]
 slab_free mm/slub.c:6619 [inline]
 kfree+0x197/0x950 mm/slub.c:6826
 snd_pcm_detach_substream+0x1e1/0x290 sound/core/pcm.c:1003
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2396 [inline]
 snd_pcm_oss_release+0x184/0x250 sound/core/oss/pcm_oss.c:2575
 __fput+0x45b/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880338ae000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 448 bytes inside of
 freed 2048-byte region [ffff8880338ae000, ffff8880338ae800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x338a8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ff27000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ff27000 dead000000000100 dead000000000122
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 0080000000000003 ffffea0000ce2a01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5810, tgid 5810 (syz-executor), ts 87951115432, free_ts 83939004793
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3046 [inline]
 allocate_slab+0x96/0x3a0 mm/slub.c:3219
 new_slab mm/slub.c:3273 [inline]
 ___slab_alloc+0xb12/0x13f0 mm/slub.c:4643
 __slab_alloc+0xc6/0x1f0 mm/slub.c:4762
 __slab_alloc_node mm/slub.c:4838 [inline]
 slab_alloc_node mm/slub.c:5260 [inline]
 __do_kmalloc_node mm/slub.c:5633 [inline]
 __kmalloc_node_track_caller_noprof+0x2a8/0x7e0 mm/slub.c:5743
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:601
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 rtmsg_ifinfo_build_skb+0x84/0x260 net/core/rtnetlink.c:4400
 rtmsg_ifinfo_event net/core/rtnetlink.c:4442 [inline]
 rtmsg_ifinfo+0x8c/0x1a0 net/core/rtnetlink.c:4451
 register_netdevice+0x1746/0x1b10 net/core/dev.c:11346
 __ip_tunnel_create+0x3e7/0x560 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x2ba/0x800 net/ipv4/ip_tunnel.c:1147
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
page last free pid 5784 tgid 5784 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xfb6/0x1140 mm/page_alloc.c:2906
 __folio_put+0x247/0x300 mm/swap.c:112
 put_netmem net/core/skbuff.c:7376 [inline]
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x49a/0x7c0 net/core/skbuff.c:1081
 skb_release_all net/core/skbuff.c:1152 [inline]
 __kfree_skb+0x55/0x70 net/core/skbuff.c:1166
 tcp_clean_rtx_queue net/ipv4/tcp_input.c:3471 [inline]
 tcp_ack+0x2266/0x6950 net/ipv4/tcp_input.c:4096
 tcp_rcv_established+0x93c/0x2670 net/ipv4/tcp_input.c:6430
 tcp_v4_do_rcv+0xe1a/0x12b0 net/ipv4/tcp_ipv4.c:1931
 sk_backlog_rcv include/net/sock.h:1158 [inline]
 __release_sock+0x285/0x3e0 net/core/sock.c:3180
 __sk_flush_backlog+0x4b/0xe0 net/core/sock.c:3203
 sk_flush_backlog include/net/sock.h:1221 [inline]
 tcp_sendmsg_locked+0x4309/0x5550 net/ipv4/tcp.c:1214
 tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1413
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:742
 sock_write_iter+0x27f/0x370 net/socket.c:1195
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5d5/0xb40 fs/read_write.c:686
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94

Memory state around the buggy address:
 ffff8880338ae080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880338ae100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880338ae180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880338ae200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880338ae280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

