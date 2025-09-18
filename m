Return-Path: <linux-kernel+bounces-817603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D097EB58464
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883C91725B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E102DAFB7;
	Mon, 15 Sep 2025 18:17:37 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8027A916
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960256; cv=none; b=eE7w3QEKWWaPEsU4ZLYlYfwjo4v6y8fnXR2ACjh8q5i6oMiOo1xb1Fpb3Y+7UOQq/griJRASH7fAB6VgPq/v5xKkDucX+jroF8zFkuNot1ebYJw5iBaqRVq/pCk9WtFXCoQxe0xJWmDNKHQ6+Ky6SKik1d+COmPduh5gZxrUw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960256; c=relaxed/simple;
	bh=arkH0t2+6qOJIEnuqX97Aj+81+ne1YcEJHoaZrLY0vo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YYUgmZfr38VT42LgEqU2RFYjhTg8jRqzoi6dDy2qTPRjCWSz9Av7gZkQ6kDVEl6J9kaE7Hk3lIEIQolz1+26pW+FcXWCU4GUDTIY1y+zkHYJA8bk1fdxL7M5uuwGwoZ744fhsSiP3JqEGbdnHKphe/snr6DmIdPpmMfdua16xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f736aa339aso127666335ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960253; x=1758565053;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTHya9CWE052p3YVJjNwwhIiYXOxgjMvw+Iy7Uy1gcA=;
        b=HemwfFLMS1GLmfAuJBue+WGXK9klav1+n7d11QILHIv4BoN7MtPMexrAfYvX4TP/m8
         mdRhISwjo2BzSJKR4QetDgfWkIyyJryhoAz9+uGahTOEGoJwG+c5ieUJFdHZiGN30pHs
         crtHLWw/QWb35AlkC5/+h1fHn6MdC7ubB3sLldhjwzeGCkM5DU0WahlmDXqp1u4fXJy0
         oo/PjcHAQVz5ShEZd/csaLCGrwAlR41e1Ath4Is/f0moh8wcua4t3mbXRAbi9T95nm15
         ua0Dz2HY24QuEAo135ZZMP6/Ip6ciSpatj2QOGAtpvf5fnThTGuBq1G7b/Bk7Tco5S+I
         izRw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZmRFJE8fRE+U1GRoq4nJq38xO/qUF911pns2BMVZ15W+wKFpzg5DTBpZHd3oa8X/I494RzgtmvJvp9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVAEAt8YfGN1YfiyxFVDSD4aPEKSHhDt4qhlc2630roMe2AGDS
	RAQpyVgNwy320LEo8S0gGZu7cpMmOFiVk0VwQ7z7m94O3vGn1csAnTnjoql7mKO52uYBINs4kXM
	zJynBjM4CXAjKmzI7fj16sQ68Yd4q0J3lMw/xPekibYBTrz3xp4vem2eUDLc=
X-Google-Smtp-Source: AGHT+IEDoKyYNKa0469HpOMIpVva7pz0Tm8CUsTETL6GaSBU7taxGz6s6FvOF/lwuPOXZ8SJqV6OG49chdgF4GOqACf5cmQMy6OT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e11:b0:421:bb6:fc6a with SMTP id
 e9e14a558f8ab-4210bc6491cmr126789115ab.2.1757960253470; Mon, 15 Sep 2025
 11:17:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:17:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8583d.050a0220.2ff435.03a2.GAE@google.com>
Subject: [syzbot] [iommu?] KASAN: slab-use-after-free Write in iommufd_eventq_fops_release
From: syzbot <syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f20375f5b7 Merge tag 'pci-v6.17-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c29b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ea369e307c9d48f
dashboard link: https://syzkaller.appspot.com/bug?extid=80620e2d0d0a33b09f93
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17795934580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17403642580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76d1a12b1763/disk-22f20375.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ebd247c9a40/vmlinux-22f20375.xz
kernel image: https://storage.googleapis.com/syzbot-assets/405482fe4099/bzImage-22f20375.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com

R13: 00007fb44b1d5fa0 R14: 00007fb44b1d5fa0 R15: 0000000000000003
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec include/linux/refcount.h:455 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec include/linux/refcount.h:476 [inline]
BUG: KASAN: slab-use-after-free in iommufd_eventq_fops_release+0x45/0xc0 drivers/iommu/iommufd/eventq.c:376
Write of size 4 at addr ffff888059c97804 by task syz.0.46/6164

CPU: 0 UID: 0 PID: 6164 Comm: syz.0.46 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_dec include/linux/refcount.h:455 [inline]
 refcount_dec include/linux/refcount.h:476 [inline]
 iommufd_eventq_fops_release+0x45/0xc0 drivers/iommu/iommufd/eventq.c:376
 __fput+0x402/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x41c/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb44af8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3d692818 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffff2 RBX: 00007fb44b1d5fa0 RCX: 00007fb44af8eba9
RDX: 0000000000000004 RSI: 0000000000003b8e RDI: 0000000000000006
RBP: 00007ffc3d692870 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fb44b1d5fa0 R14: 00007fb44b1d5fa0 R15: 0000000000000003
 </TASK>

Allocated by task 6164:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 _iommufd_object_alloc+0x23/0x1a0 drivers/iommu/iommufd/main.c:40
 _iommufd_object_alloc_ucmd+0xb2/0x160 drivers/iommu/iommufd/main.c:84
 iommufd_fault_alloc+0x93/0x420 drivers/iommu/iommufd/eventq.c:430
 iommufd_fops_ioctl+0x34d/0x540 drivers/iommu/iommufd/main.c:508
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6164:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x60/0x70 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4894
 iommufd_object_abort+0x10c/0x170 drivers/iommu/iommufd/main.c:124
 iommufd_fops_ioctl+0x381/0x540 drivers/iommu/iommufd/main.c:512
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888059c97800
 which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 4 bytes inside of
 freed 512-byte region [ffff888059c97800, ffff888059c97a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x59c94
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888026413e01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b84b140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000000f5000000 ffff888026413e01
head: 00fff00000000040 ffff88801b84b140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000100010 00000000f5000000 ffff888026413e01
head: 00fff00000000002 ffffea0001672501 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5224, tgid 5224 (klogd), ts 132635729272, free_ts 132529818110
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab mm/slub.c:2660 [inline]
 new_slab+0x247/0x330 mm/slub.c:2714
 ___slab_alloc+0xcf2/0x1750 mm/slub.c:3901
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3992
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4395
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:600
 __alloc_skb+0x166/0x380 net/core/skbuff.c:669
 alloc_skb include/linux/skbuff.h:1336 [inline]
 alloc_skb_with_frags+0xe0/0x860 net/core/skbuff.c:6665
 sock_alloc_send_pskb+0x7fb/0x990 net/core/sock.c:2958
 unix_dgram_sendmsg+0x3e9/0x17f0 net/unix/af_unix.c:2153
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 __sys_sendto+0x4a3/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
page last free pid 5980 tgid 5980 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2758 [inline]
 __put_partials+0x165/0x1c0 mm/slub.c:3223
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4247
 getname_flags.part.0+0x4c/0x550 fs/namei.c:146
 getname_flags include/linux/audit.h:322 [inline]
 getname include/linux/fs.h:2919 [inline]
 __do_sys_unlink fs/namei.c:4696 [inline]
 __se_sys_unlink fs/namei.c:4694 [inline]
 __x64_sys_unlink+0xb0/0x110 fs/namei.c:4694
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888059c97700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888059c97780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888059c97800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888059c97880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888059c97900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

