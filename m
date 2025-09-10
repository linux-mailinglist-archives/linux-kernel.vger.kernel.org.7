Return-Path: <linux-kernel+bounces-810184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35516B51704
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8CA3B2B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3341F3BA4;
	Wed, 10 Sep 2025 12:35:35 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A531D37C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507735; cv=none; b=o3AbA+f34pqADYQV3oso3cIIJlMAHRuVgqoY8Cx5LGWDFssVeh6y9jzaigzjLn5AcjmtPj80i1QA5OUiRWfZY4cDPijQ4a8B0uQBgJUtQnoIcnl/WsioMKbZh4Y25NR/rL1/7Pd9I+UFucF2QwcxD4ksrppsvAjr8A2gkONePfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507735; c=relaxed/simple;
	bh=YvZEAXaowQR36siTReaoCci7LRUtXdxCRrBuhPOjl74=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BRlJGaZik6bt95EGB58KouzhxT+5bskt0KuplbhDkK/TAn2FFFBx6UO1IAWDr91uyuge64xqiMZ09enrzn6PHuCVfyFUm46XW6EBw4T3GQYDTCbZ4HOwevD8amJp//0hXxP7d8P0u33FREM6+6YqFt+Clwvy/7QEZAe3dGloUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ffbd7e6662so50969895ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757507732; x=1758112532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yf3HksuGDvdFhsxx6nkK7e8YHDdD/H22VcMIwJxIl2w=;
        b=LhQR0Psbf78ig+1C19522/HOC+ok+uQOcbd3oxiEiBWWQQZgyq7CXwqU4fjkij0iiH
         qMlizBurLiw+Xzj3i9aXs0BkuIMw11OsB8cK4KYk8v3syq2+rnIbr2rDEIMJOoYEvKDN
         n+CrDzhavJN4YFkhGAgORnJV5X1NJLv8Tzh0MrueFNKvFyevU/1GkxJkCY1gMCwWmwyp
         1DR3hsj4hzC6YWVNLvwp6F5nJheaZqneRGmV4Rg+2vBy9y674jBdceRUJ8LCeNMSFNjN
         3viVP0M4vQJq9wbYatXifsq1DmS+gegCPgklBy9La5+rggY4xltrimm/69iyCUbmqrn3
         +y7w==
X-Forwarded-Encrypted: i=1; AJvYcCXPyVsbHlQ2qdq3nqFiz1iBGDp9JTcoc7OCD55UN+6AQHjVvfG5LYDgI3K4sGJOKqzaA8qZS6SKckqFU8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYE7DtEcvzTItc5SLY5xLGCVj4B1Kykey5j8VATzMpDi54P9f1
	kur6ijP7p001lPk21YSwzb+JgBF+JLIzA4WHjy4vAg5O2jFboTAjja85sVAl1EWlVx09yDP+QUQ
	Al0SgzVhwypTOX5PA3TvsevoaXfaq68KixZXDIWksJekdWcShsSnjEw1AN9w=
X-Google-Smtp-Source: AGHT+IFZFxaZPS26lp8nYaF+DSjAOMPPpTFrsM3kQdmD9U2BfhAjHIl8KXRacMIRmk6w7XNFvXb93y1ZFL57FpLJZVZECw1WyCBL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184c:b0:3f6:55e5:1914 with SMTP id
 e9e14a558f8ab-3fd94458067mr235498475ab.18.1757507732292; Wed, 10 Sep 2025
 05:35:32 -0700 (PDT)
Date: Wed, 10 Sep 2025 05:35:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c17094.050a0220.3c6139.0021.GAE@google.com>
Subject: [syzbot] [mm?] KMSAN: uninit-value in __run_timer_base (2)
From: syzbot <syzbot+7d660d9b8bd5efc7ee6e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, chrisl@kernel.org, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	shikemeng@huaweicloud.com, syzkaller-bugs@googlegroups.com, 
	weixugc@google.com, yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1d10cea0895 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1583ba42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ee07385471829e7
dashboard link: https://syzkaller.appspot.com/bug?extid=7d660d9b8bd5efc7ee6e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b803befa3a5f/disk-d1d10cea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f37cb94f110/vmlinux-d1d10cea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68d1d6d1e102/bzImage-d1d10cea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d660d9b8bd5efc7ee6e@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __hlist_del include/linux/list.h:980 [inline]
BUG: KMSAN: uninit-value in detach_timer kernel/time/timer.c:891 [inline]
BUG: KMSAN: uninit-value in expire_timers kernel/time/timer.c:1781 [inline]
BUG: KMSAN: uninit-value in __run_timers kernel/time/timer.c:2372 [inline]
BUG: KMSAN: uninit-value in __run_timer_base+0x690/0xd90 kernel/time/timer.c:2384
 __hlist_del include/linux/list.h:980 [inline]
 detach_timer kernel/time/timer.c:891 [inline]
 expire_timers kernel/time/timer.c:1781 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x690/0xd90 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0x3a/0x80 kernel/time/timer.c:2403
 handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x66/0x180 kernel/softirq.c:680
 irq_exit_rcu+0x12/0x20 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0x84/0x90 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 kmsan_metadata_is_contiguous+0x10b/0x1e0 mm/kmsan/core.c:-1
 kmsan_get_shadow_origin_ptr+0x27/0xb0 mm/kmsan/shadow.c:96
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
 __msan_metadata_ptr_for_load_8+0x24/0x40 mm/kmsan/instrumentation.c:94
 is_last_frame arch/x86/kernel/unwind_frame.c:87 [inline]
 is_last_task_frame+0x2e/0x370 arch/x86/kernel/unwind_frame.c:156
 unwind_next_frame+0x60/0x350 arch/x86/kernel/unwind_frame.c:276
 arch_stack_walk+0x1b1/0x280 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xc3/0x100 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:73 [inline]
 kmsan_internal_poison_memory+0x4a/0xa0 mm/kmsan/core.c:57
 kmsan_free_page+0xd5/0x160 mm/kmsan/shadow.c:210
 free_pages_prepare mm/page_alloc.c:1317 [inline]
 free_unref_folios+0x270/0x2a20 mm/page_alloc.c:2952
 folios_put_refs+0xaac/0xb10 mm/swap.c:997
 folios_put include/linux/mm.h:1419 [inline]
 __folio_batch_release+0xe1/0x100 mm/swap.c:1057
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x926/0x2100 mm/shmem.c:1157
 shmem_truncate_range mm/shmem.c:1269 [inline]
 shmem_evict_inode+0x232/0xed0 mm/shmem.c:1397
 evict+0x6fd/0xd00 fs/inode.c:810
 iput_final fs/inode.c:1897 [inline]
 iput+0x996/0xdd0 fs/inode.c:1923
 dentry_unlink_inode+0x5ce/0x6d0 fs/dcache.c:466
 __dentry_kill+0x340/0xbf0 fs/dcache.c:669
 dput+0xdd/0x240 fs/dcache.c:911
 __fput+0xb0a/0x1040 fs/file_table.c:476
 ____fput+0x25/0x30 fs/file_table.c:496
 task_work_run+0x206/0x2b0 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0x2a6/0x330 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x1e3/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4197 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 __kmalloc_cache_noprof+0x7f7/0xed0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 rose_add_node net/rose/rose_route.c:85 [inline]
 rose_rt_ioctl+0x1fc7/0x3b30 net/rose/rose_route.c:748
 rose_ioctl+0x4f8/0xc60 net/rose/af_rose.c:1381
 sock_do_ioctl+0x9f/0x480 net/socket.c:1238
 sock_ioctl+0x70b/0xd60 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0x239/0x400 fs/ioctl.c:584
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:584
 x64_sys_call+0x1cbc/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 30968 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================


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

