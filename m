Return-Path: <linux-kernel+bounces-895099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A2EC4CED8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6C4A4FAD76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24633509B;
	Tue, 11 Nov 2025 10:02:31 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089D333735
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855350; cv=none; b=Fx8/Z2E0akCAMF8e66/nL3GzezjSEzhb0RM+SZq8K7IkErnzDYkzPFN1RCBhFDU9h53BJU+aOQEaOR1RxTRIa4nzFGx4JThx+bSlAVrT5DjOdlKywMSoBkNPSVwmj//DQ/wDxCc/12RgYgyJ/sU15IQuXvl/9a+xQIoovwMdFFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855350; c=relaxed/simple;
	bh=vxyBx/MOE0F/9Jxofu3U1pUJcJc8Hh127c5na2FzDRM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vg+5u/lxQf2upXgbtBiBhKw43mFty8O5mo3T0f36Z2d4ISY2vtHALUV2SV/nigrJhbOJnBhHmebdfg26F8atp86OV/qJKEbuzb/MBR7Ydhjs6ROdw2WHmeVykP/Z8TgbnjyDHp0CXqnYkO10fgrV+AVKpmFrhhG3fix/eBPDc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-9489c73d908so237470139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855348; x=1763460148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9gGu9oyo0707+mNJUixmiZvMnsJd1DK+S6x2+Dz/88=;
        b=JWBFJ8yKF4TGkM9dLYvLGPQ3TY5ES7yst0XiPXm05Tiw6MrcP4/FZfGYCu7FHZyVs7
         X+LmR44Eh7E2byrYHXjbSBnUkYwltACTZs33Sjcg4ZipqEFpEGOVq0IG4daLWbQk9Y/Y
         X5oyQ3/6ApkSK3y51gkHPabVQKJz4Szlly57B8b0KlhwsQ3MpkXgYmNg5MGUnTSdm6uC
         KXO9TWkHmmdlN2DqRXJ7ZLMxW0r3DfHRSoi1HgK3KTWEQ/I+o9LZQb/d+Znox/f+ED3L
         CfurAOClWaUe90TBq5ypZnlx2oBnPpBP5sjlSLfYYqbWlcmDzye7Y11I0s9pocs6HV1E
         utRw==
X-Forwarded-Encrypted: i=1; AJvYcCVjR/7xS+XX5/kuF05MLSwHm+RrajdwP9I48QocC5/86MJWOE7cz2H/Nx25DQ988d8awwGOhkZzmu5IFEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lDSAU9fneA1iDPcfLCFMZHWsS8pj7T8sIyAr1Oz2u8RMOhuv
	miomymaSITJ4j90TKzmd5SUyUw2wDCNuD8w1JXnxREa+Nl/zSRSujkiPnmqUtIGYL8euM17W1wS
	hDxg2NGeI3juMeXmF/n+B8oj2bN6a7bBIjTRQuTSXkl01UQWvstcrvMYbvcE=
X-Google-Smtp-Source: AGHT+IEyDUDQ45SEEWG+uFxc4pqGZcp2gt5ExQ+vwzcmPnW1uzB1Ib8IQvzY7B/cXQ7ctysLLOyYJyk6qh7+sxTWJLS3PKY2MFT6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e93:b0:433:78fa:7fe9 with SMTP id
 e9e14a558f8ab-43378fa8302mr108807405ab.22.1762855348010; Tue, 11 Nov 2025
 02:02:28 -0800 (PST)
Date: Tue, 11 Nov 2025 02:02:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691309b4.a70a0220.22f260.0133.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in mtree_range_walk
From: syzbot <syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=10da7012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3106dc390828a333
dashboard link: https://syzkaller.appspot.com/bug?extid=131f9eb2b5807573275c
compiler:       Debian clang version 20.1.8 (++20250708123704+0de59a293f7a-1~exp1~20250708003721.134), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-dcb6fa37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a05d908f307/vmlinux-dcb6fa37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/874b2b8dba2a/Image-dcb6fa37.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ma_data_end lib/maple_tree.c:1255 [inline]
BUG: KASAN: slab-use-after-free in mtree_range_walk+0x604/0x8d0 lib/maple_tree.c:2556
Read of size 8 at addr 4cf000000dcf0178 by task syz.0.1606/8933
Pointer tag: [4c], memory tag: [fe]

CPU: 0 UID: 0 PID: 8933 Comm: syz.0.1606 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xac/0x288 mm/kasan/report.c:378
 print_report+0x84/0xa0 mm/kasan/report.c:482
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 kasan_tag_mismatch+0x28/0x3c mm/kasan/sw_tags.c:176
 __hwasan_tag_mismatch+0x30/0x60 arch/arm64/lib/kasan_sw_tags.S:55
 ma_data_end lib/maple_tree.c:1255 [inline]
 mtree_range_walk+0x604/0x8d0 lib/maple_tree.c:2556
 mas_state_walk lib/maple_tree.c:3296 [inline]
 mas_walk+0xf8/0x34c lib/maple_tree.c:4597
 lock_vma_under_rcu+0x10c/0x35c mm/mmap_lock.c:232
 do_page_fault+0x3a8/0x1508 arch/arm64/mm/fault.c:625
 do_translation_fault+0xbc/0xfc arch/arm64/mm/fault.c:789
 do_mem_abort+0x50/0x110 arch/arm64/mm/fault.c:929
 el0_da+0x64/0x210 arch/arm64/kernel/entry-common.c:562
 el0t_64_sync_handler+0x90/0x12c arch/arm64/kernel/entry-common.c:768
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Allocated by task 8934:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:56
 save_stack_info+0x30/0x138 mm/kasan/tags.c:106
 kasan_save_alloc_info+0x14/0x20 mm/kasan/tags.c:142
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x94/0x98 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4970 [inline]
 slab_alloc_node mm/slub.c:5280 [inline]
 kmem_cache_alloc_noprof+0x320/0x5a8 mm/slub.c:5287
 mt_alloc_one lib/maple_tree.c:172 [inline]
 mas_alloc_nodes+0x350/0x3b8 lib/maple_tree.c:1108
 mas_preallocate+0x544/0x970 lib/maple_tree.c:5192
 vma_iter_prealloc mm/vma.h:442 [inline]
 __split_vma+0x318/0xb00 mm/vma.c:528
 vms_gather_munmap_vmas+0x4d0/0x1474 mm/vma.c:1380
 __mmap_prepare mm/vma.c:2359 [inline]
 __mmap_region mm/vma.c:2652 [inline]
 mmap_region+0x6c0/0x1fcc mm/vma.c:2740
 do_mmap+0xa50/0xf64 mm/mmap.c:558
 vm_mmap_pgoff+0x290/0x3e8 mm/util.c:581
 ksys_mmap_pgoff+0x3a4/0x448 mm/mmap.c:604
 __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
 __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
 __arm64_sys_mmap+0x13c/0x198 arch/arm64/kernel/sys.c:21
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x90/0x238 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x180/0x2f4 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x58/0x74 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x234 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 8110:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:56
 save_stack_info+0x30/0x138 mm/kasan/tags.c:106
 __kasan_save_free_info+0x18/0x24 mm/kasan/tags.c:147
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x64/0x68 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 __rcu_free_sheaf_prepare+0x11c/0x2c4 mm/slub.c:2745
 rcu_free_sheaf+0x2c/0x138 mm/slub.c:6181
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xe14/0x1d30 kernel/rcu/tree.c:2861
 rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2878
 handle_softirqs+0x36c/0xd08 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656

The buggy address belongs to the object at fff000000dcf0100
 which belongs to the cache maple_node of size 256
The buggy address is located 120 bytes inside of
 256-byte region [fff000000dcf0100, fff000000dcf0200)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xbbf000000dcf0000 pfn:0x4dcf0
flags: 0x1ffc00000000200(workingset|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
page_type: f5(slab)
raw: 01ffc00000000200 d5f000000cc09700 ffffc1ffc0494790 ffffc1ffc051fb90
raw: bbf000000dcf0000 000000000010000e 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 fff000000dceff00: ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
 fff000000dcf0000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>fff000000dcf0100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                                        ^
 fff000000dcf0200: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
 fff000000dcf0300: 70 70 70 70 70 70 70 70 70 70 70 70 70 70 70 70
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

