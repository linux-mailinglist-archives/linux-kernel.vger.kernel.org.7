Return-Path: <linux-kernel+bounces-752864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661CFB17BD4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218765A6F21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287E219C542;
	Fri,  1 Aug 2025 04:30:33 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA31519B4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022632; cv=none; b=WXYjZAIbi73WP0VfC3mmmtoPl2g75h3YJm9t+awCqZ3WnIst4q/mYklQNkAnBzKbuDfujezjmIHhfF05mEeQc7VPvSPuGzE0ls2MWCD3Z7VYp4FG98w8n9QHH4tLnq8k1lN/T6OlvDiS6EiUPRj11MV/CsK/zZitfs3MYir6dk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022632; c=relaxed/simple;
	bh=rHmO7vLdeQLdyeedkg2RPf13roH7oC1DwF+2dFV9jbc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uLsz131VteOlUWG7ZOqOEeZOvG4YMBrVFycjoZOtmHgqxS7UNQVIJMqdJdx4RP7HICZDImjChObic8BzeUb1Zpt2GJQq5yHW1LcegfJHK044xSPEUEtnNXRsdrBrT4bCagiiYE2PThNV51BNW+/Owf+eZWLzfwmhzAAaM5YlKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-87c467931c1so321997839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754022630; x=1754627430;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vxwJIxaosd9nfIl/jWLrhdqN8QLPOB+c9MQEPkb/Tc=;
        b=KDUuHl9iuF4+qvFOXtgMgepZ8mjoGlASSru0KNecPz7o+7FBEjZs8Qf376dU6MzfPn
         QM20S6JnbYMwdKkVh0FpzNuN/OLeCiXJjrORdG+l9dnU9Kc5/47tKUYHZvJHJRH261S7
         LUZ+GolZJJuZ0+aJnh+odJqF4J1jk7i4tbZSo0QO/3UmDvJPMGY5N8hhOLDHgVSurwOq
         KhW4YAud9WYF/lVmp/lczHyn2i4HL0IXLJwUGafpAi022ykJpFapNanmMo98X3AXrlcf
         mBKxG+y2eCzMSZmIIeTLsGoe/Q4zW+FoSdM8vJqmbY5kfeO4+mqRcB0Wr/GcalZlHOGq
         DDUg==
X-Forwarded-Encrypted: i=1; AJvYcCU/ixrshoQfrXmpjiEb+Z+m0I8hzWMW2blrDBN/1gjGTNi8e9mJd94HeXXeOOocw0DJi8uD2Cli/s+/cE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPXNF4/xpEMXXSfZLg9QwsCLfw/Cl+ZU84gS8SdA5j+yceZo9
	IKIVuWVSZCqTui+L1Kl3MKuXtwTlZmZ0zcTULi/hhE8vk+JCIC9T7fsG561e1f3Oxx4R70D7TbB
	um+lbzptmojFaZZ+e4L8ZAJDLNOrDdyF+dzlUIHkiI7UPs03/Is+Q0LVkOWw=
X-Google-Smtp-Source: AGHT+IHeKqKvG/oiMpU/x/IomizPdjYuB/DA7RCnODPJnmDyf/W0N820XiK6GjgfbqaHF2yqf04/WvsnvWm/AYIJqoLf4C3DWLgl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380a:b0:3d8:2085:a188 with SMTP id
 e9e14a558f8ab-3e3f60e0508mr157837325ab.1.1754022629916; Thu, 31 Jul 2025
 21:30:29 -0700 (PDT)
Date: Thu, 31 Jul 2025 21:30:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688c42e5.a00a0220.26d0e1.005e.GAE@google.com>
Subject: [syzbot] [ntfs3?] KASAN: stack-out-of-bounds Read in
 unwind_next_frame (4)
From: syzbot <syzbot+b3447ea7dcdd5eb42d00@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    260f6f4fda93 Merge tag 'drm-next-2025-07-30' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cdd9bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7581d3fb1bb0d7
dashboard link: https://syzkaller.appspot.com/bug?extid=b3447ea7dcdd5eb42d00
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1566d2a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1fce1d4d56ce/disk-260f6f4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01688cdba884/vmlinux-260f6f4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eba9b2f77e6a/bzImage-260f6f4f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5a4b5197a5f5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3447ea7dcdd5eb42d00@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: stack-out-of-bounds in vsnprintf+0x5f6/0xf00 lib/vsprintf.c:2878
Read of size 8 at addr ffffc90006337718 by task syz.4.519/7161

CPU: 1 UID: 0 PID: 7161 Comm: syz.4.519 Tainted: G        W           6.16.0-syzkaller-08685-g260f6f4fda93 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 vsnprintf+0x5f6/0xf00 lib/vsprintf.c:2878
 vprintk_store+0x3ef/0xd10 kernel/printk/printk.c:2279
 vprintk_emit+0x224/0x7c0 kernel/printk/printk.c:2426
 vprintk_deferred kernel/printk/printk.c:4602 [inline]
 _printk_deferred+0xdd/0x130 kernel/printk/printk.c:4611
 unwind_next_frame+0x1dc7/0x2390 arch/x86/kernel/unwind_orc.c:667
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 save_trace+0x49/0x390 kernel/locking/lockdep.c:587
 check_prev_add kernel/locking/lockdep.c:3226 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0x14b0/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 rt_spin_lock+0x88/0x2c0 kernel/locking/spinlock_rt.c:56
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 force_sig_info_to_task+0x6c/0x5a0 kernel/signal.c:1302
 force_sig_info kernel/signal.c:1331 [inline]
 force_sig+0xc9/0x120 kernel/signal.c:1645
 __exc_general_protection arch/x86/kernel/traps.c:822 [inline]
 exc_general_protection+0xdb/0x200 arch/x86/kernel/traps.c:792
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:617
 </TASK>

The buggy address belongs to stack of task syz.4.519/7161
internal error: frame has invalid marker: 16140896666449346560

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc90006330000 allocated at copy_process+0x545/0x3ae0 kernel/fork.c:2000
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x276ff
memcg:ffff88814574cf82
flags: 0x80000000000000(node=0|zone=1)
raw: 0080000000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000001 0000000000000000 00000001ffffffff ffff88814574cf82
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO|__GFP_NOWARN), pid 7160, tgid 7160 (syz.4.519), ts 439305495865, free_ts 439089950538
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x2119/0x21b0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2419
 alloc_frozen_pages_noprof mm/mempolicy.c:2490 [inline]
 alloc_pages_noprof+0xcf/0x1e0 mm/mempolicy.c:2510
 vm_area_alloc_pages mm/vmalloc.c:3642 [inline]
 __vmalloc_area_node mm/vmalloc.c:3720 [inline]
 __vmalloc_node_range_noprof+0x97d/0x12f0 mm/vmalloc.c:3893
 __vmalloc_node_noprof+0xc2/0x110 mm/vmalloc.c:3956
 alloc_thread_stack_node kernel/fork.c:317 [inline]
 dup_task_struct+0x3e7/0x860 kernel/fork.c:877
 copy_process+0x545/0x3ae0 kernel/fork.c:2000
 kernel_clone+0x224/0x7c0 kernel/fork.c:2599
 __do_sys_clone3 kernel/fork.c:2903 [inline]
 __se_sys_clone3+0x256/0x2d0 kernel/fork.c:2882
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 6019 tgid 6019 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 free_unref_folios+0xc8b/0x14e0 mm/page_alloc.c:2763
 folios_put_refs+0x569/0x670 mm/swap.c:992
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x338/0xb90 mm/truncate.c:383
 kill_bdev block/bdev.c:91 [inline]
 blkdev_flush_mapping+0x10b/0x280 block/bdev.c:712
 blkdev_put_whole block/bdev.c:719 [inline]
 bdev_release+0x422/0x660 block/bdev.c:1144
 blkdev_release+0x15/0x20 block/fops.c:699
 __fput+0x45b/0xa80 fs/file_table.c:468
 fput_close_sync+0x119/0x200 fs/file_table.c:573
 __do_sys_close fs/open.c:1587 [inline]
 __se_sys_close fs/open.c:1572 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1572
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc90006337600: f1 f1 f1 f1 04 f2 00 f2 f2 f2 00 f2 f2 f2 00 f2
 ffffc90006337680: f2 f2 04 f3 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90006337700: f1 f1 f1 f1 00 00 00 00 f1 f1 f1 f1 00 00 00 f3
                            ^
 ffffc90006337780: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90006337800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

