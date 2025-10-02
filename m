Return-Path: <linux-kernel+bounces-839884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED05EBB2A57
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669C419C0391
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9B299AAF;
	Thu,  2 Oct 2025 06:49:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF3298994
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759387745; cv=none; b=QauVsHEqa4tcoUoyYzoN04sbsN2tZWDOD5ICqzbcOEytn5KnFG+q+Ug2CLptCLhmWccGyyqYeNwU6Q4IK9Ca9P903StSSUtY6P7AsJ3g+dGti0YM3KC52ZKDpvMbw8Trs/Qvum0r2UF1gkkqZ+xjaQFdadLKmnnS+cxngl+gW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759387745; c=relaxed/simple;
	bh=QR0E/ZlMUzsD4oUVSYM14d1PsIbsdn/MoGjIImBInDw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gVeCCagZztnnrMBrrxIx/e53OAOhrv5PfU0YcCSgCjoENqAbwAszlz+G6RE3ObGM0rWsPwnbLhGu0SqZw7VCvbBbqg26EdQ/vq6/zjIy6w/FtjJXp7svzUX3F8YTQaIY/5pk8GInA4C+jpo+wTza4abMeIGwW3mZoIAjUhiwfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-925332ba890so186593839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759387743; x=1759992543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIadQ7YAliAJfTXBcNEcrOvJJh/5LPmi9pi4uOW/Vp4=;
        b=JQoOrmcSXgpFNnh8+lzRBX8wj1hD5zROv7Gz0tgi1bGJQ2q5Utc8M7hL9fUas0u4XK
         eQPc2wtTo91WwuPzFvWtLq/17bjfrjnTnwpJhfPcRjelzm1ry7flCRobYkusDF/EJhpn
         qNGZTlxjTIO4mHPMfuNzUuwwpVkmY2wCCgUaV4EGaaJNV2gJ8b/4lZPcRz3kQguSRmrL
         qQpa+1zDaQIWFECtG7j8ipRfZ6cZb0PZdiPSw7v/8+TScELY81wKWqEW9gu6843mpZTT
         uz1UKi0jUjoc6jgAj1lAp20+wTc3LqKRKygs/uQ21g2ejeZskQuMzZEd7sEeeyhNwYaE
         aaKg==
X-Forwarded-Encrypted: i=1; AJvYcCWiPv3mTU715OQvKl57Ck6yOccq1v8IiyjXBLgm52ehH2mxC8w9PcFCzS0baTIYfzuskwBlCHpYVZd2RFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDczT13uXsyXL8jEVdniZ/mUfIpBSe8/AKOiWXosQNGTWcFeP
	d3QZfJuLZLFGhyMFdAU0RVuFnGHepCuqYz28HDZz4wjCcBsbRx4bzdbfrtE3TOP3jvsleLXcwNJ
	GAqDNQmRJgY3wpJpG7Up0TMGwGvP+DqMhOz+Sd4J3oBRigh6ujT9LbBKzRfM=
X-Google-Smtp-Source: AGHT+IFD3twJjAhcH2fBclUTgmpPC2a5kX3kNTubETDtwLgnj2132kC84ivnx56EEVAzmS4fP47qGydKJm3qxQ/S5O5DbT4MNqHb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3424:b0:887:6ce4:8e07 with SMTP id
 ca18e2360f4ac-937ad4ae9b4mr927994339f.9.1759387743500; Wed, 01 Oct 2025
 23:49:03 -0700 (PDT)
Date: Wed, 01 Oct 2025 23:49:03 -0700
In-Reply-To: <20251002062804.2167179-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de205f.050a0220.1696c6.002e.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in ext4_search_dir

==================================================================
BUG: KASAN: use-after-free in ext4_search_dir+0xf1/0x1b0 fs/ext4/namei.c:1469
Read of size 1 at addr ffff88804907506b by task syz.0.23/5978

CPU: 0 UID: 0 PID: 5978 Comm: syz.0.23 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_search_dir+0xf1/0x1b0 fs/ext4/namei.c:1469
 ext4_find_inline_entry+0x492/0x5f0 fs/ext4/inline.c:1621
 __ext4_find_entry+0x2fd/0x1f20 fs/ext4/namei.c:1542
 ext4_lookup_entry fs/ext4/namei.c:1703 [inline]
 ext4_lookup+0x13d/0x6c0 fs/ext4/namei.c:1771
 lookup_open fs/namei.c:3774 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x10fe/0x3830 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f999878eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9997ddd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f99989e6090 RCX: 00007f999878eec9
RDX: 0000000000000042 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007f9998811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f99989e6128 R14: 00007f99989e6090 R15: 00007fffca9efab8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xc002573 pfn:0x49075
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 dead000000000100 dead000000000122 0000000000000000
raw: 000000000c002573 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 5609, tgid 5609 (syz-execprog), ts 124343619274, free_ts 141401086768
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 folio_alloc_mpol_noprof mm/mempolicy.c:2435 [inline]
 vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2470
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 alloc_anon_folio mm/memory.c:4997 [inline]
 do_anonymous_page mm/memory.c:5054 [inline]
 do_pte_missing mm/memory.c:4232 [inline]
 handle_pte_fault mm/memory.c:6052 [inline]
 __handle_mm_fault+0x2ab9/0x5440 mm/memory.c:6195
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 78 tgid 78 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 free_unref_folios+0xdbd/0x1520 mm/page_alloc.c:2952
 shrink_folio_list+0x2977/0x4cd0 mm/vmscan.c:1568
 evict_folios+0x471e/0x57c0 mm/vmscan.c:4744
 try_to_shrink_lruvec+0x8a3/0xb50 mm/vmscan.c:4907
 shrink_one+0x21b/0x7c0 mm/vmscan.c:4952
 shrink_many mm/vmscan.c:5015 [inline]
 lru_gen_shrink_node mm/vmscan.c:5093 [inline]
 shrink_node+0x314e/0x3760 mm/vmscan.c:6078
 kswapd_shrink_node mm/vmscan.c:6938 [inline]
 balance_pgdat mm/vmscan.c:7121 [inline]
 kswapd+0x147c/0x2830 mm/vmscan.c:7386
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888049074f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888049074f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888049075000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                          ^
 ffff888049075080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888049075100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         7f707257 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a92092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0364a9e4a291ab2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15786334580000


