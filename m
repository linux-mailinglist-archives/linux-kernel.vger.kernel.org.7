Return-Path: <linux-kernel+bounces-840924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C197BB5BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDB43C5D49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB1274B5D;
	Fri,  3 Oct 2025 01:28:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB126E17F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454889; cv=none; b=Ut2gbGzoblOWcTBDO8vQLC3z/nwvqdLjtsy/0fq/8zCr5f9+R/Wv+8K2Gz110NGZ7OXsDUu4dPZ5EJkyCfEkeL2EpIXreuqe05oG96kpjINtRxgLtSzv/xpFDO8HFkeIr6XYZo7gJGXJ4SA5+1mAioqIkTduzKUlnFaXASC1MLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454889; c=relaxed/simple;
	bh=LKeQrgvKLkbm7LbHaizX9T1wRokj/qcXsnJYpDBfskU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tBC0p/Kl8QR9/vauNhhjGHtcXM79WTRZ6YiKQ/Sw+MJEZ683uFe7GvWIC3EbgJ/h6+yF6GByLiIHpkRokvNztKPW2i90KGpYjU2HZBJJ5BTW3xd9QRHKMv/5kbv9uWKTBExn2+QI2QBxrrOP1Ol+JVqgPWHlek1H4Wf3WhAZACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88c2f1635e1so181674039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454883; x=1760059683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdEA7vbwxPZfXDyQ5Ll7PM0c67HA6MUjF6vKckGz6xU=;
        b=sG3f4eX+IAUNpHwjYzXcT1yUa6BQzDZDsL1sf/a7a3k4P3Q4tHB3aV/dLv3La8qm6X
         J6q5RXgYXZ83jlY29Bb+RmCNpGXDmx309OtqWjqxkBXtnUztINUq5RKn1LhVlOBk++MJ
         we2Yn37j33k/cJgnTV8OjOPPv+uSsFOvF27jxwM0mU+SpMWL/3fZ5JU9Sdo3gdAY4E9s
         RqR+2u8KB9j8H6cE+CY0lhuYEumXYV4hQ3VnQo7/s3P0UVRK7YVoJP5Vy4JPHn3KKb/S
         Bu8zHsMTdRAx2VntR23Pxh7nAs+hN8HTEs/GOdzuwQzUu3PMGhDavAY42mZlO/rqPLGf
         nM+g==
X-Forwarded-Encrypted: i=1; AJvYcCWPTTxMctXzFfhgeK4HJPKoXx56OA35ON/zkOcP54Q5EkNwD5eMZU9tFnMqsdrPqhv0KpiGhbw/Ph2Az2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRSuA17SqMuKgDKE+83oB10PY8ole4rkIkpwNejZ8S4Fv5Oto
	KNCLdbwVe+Xb8KaM731hEtBgpN1h9c4zuG7YztzYMAYPNJjKcVMjO/1QYQBVvSW/ILBt325zaXA
	RRPW96gNIDfK8UKuJPSAPLvmSY1lGIoWN49aPPT2Z5+48eKQ8QBzI6x2faMw=
X-Google-Smtp-Source: AGHT+IGfWC8sCZJgS4RGY1RLyzqnZvduyJrZ71jekUIWHGna1M0HnAxB0TXQpZUbvE135HTXuTIiw2h9juT9dnu34HUrnAyVloPl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1602:b0:91d:e35:b317 with SMTP id
 ca18e2360f4ac-93b96974fb6mr170703739f.7.1759454883136; Thu, 02 Oct 2025
 18:28:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 18:28:03 -0700
In-Reply-To: <20251003010657.2402278-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df26a3.050a0220.2c17c1.000f.GAE@google.com>
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
Read of size 1 at addr ffff888043c0f1b3 by task syz.0.17/6052

CPU: 0 UID: 0 PID: 6052 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
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
RIP: 0033:0x7fc79498eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc7958bb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fc794be6090 RCX: 00007fc79498eec9
RDX: 0000000000000042 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007fc794a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc794be6128 R14: 00007fc794be6090 R15: 00007ffe09140cb8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7fe0644ad pfn:0x43c0f
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea00010f0408 ffffea00010f0548 0000000000000000
raw: 00000007fe0644ad 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 6053, tgid 6053 (modprobe), ts 152683869333, free_ts 152820788321
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
page last free pid 6053 tgid 6053 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 free_unref_folios+0xdbd/0x1520 mm/page_alloc.c:2952
 folios_put_refs+0x559/0x640 mm/swap.c:999
 free_pages_and_swap_cache+0x277/0x520 mm/swap_state.c:264
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 exit_mmap+0x444/0xb40 mm/mmap.c:1293
 __mmput+0x118/0x430 kernel/fork.c:1130
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:949
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888043c0f080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888043c0f100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888043c0f180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                     ^
 ffff888043c0f200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888043c0f280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         24d9e8b3 Merge tag 'slab-for-6.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e31214580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bc5f6d89013f5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14980304580000


