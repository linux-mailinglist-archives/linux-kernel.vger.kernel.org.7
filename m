Return-Path: <linux-kernel+bounces-840865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3EFBB59CA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 424844E1DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FF929CB52;
	Thu,  2 Oct 2025 23:34:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2D254B1B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448045; cv=none; b=lUUzozNTH+jvj42OaH7WQ98e1m26HdeIPUq6OjWHzOtGAFFHTTSBP15UttTJI+mlvdNEvYarmRhw/bntheCqsL0Tef6BjA8OXsK0S7eOWvx8/qqLqEZliWk7Fu/AxrJf1Za/ha+lWHcYVXZbohQtEybveYGcUhkcWUCl+J7D/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448045; c=relaxed/simple;
	bh=SAO+WA3jcTfT5NAuiVuS1fTUvM5yNBZ1J5hG7w1jGyA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TTniexx7qM7/3mZG8lfUel9KUTvcy5HDShWRIxzSlFLTlbWfVI6L27Ihug0PRvk+yyPHfedkw+mNEW1BV0+CV7CSNEluGoGaXvAtZe2AcoD36jmVHY2VxvW5Ai4TbSkeaBOxdlLbqTgXXWDd9FqklrbtNepFSsLVBd489Tjbcbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-90e388db4bdso405597439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 16:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448043; x=1760052843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjUM6Dd/iQCzDchMp7+7jaQ4lNJgJQdgjPgVX2z4/ac=;
        b=aqcKRSgZNZPHUCXFjU7PI6z1dt6G4FyBYOqFXEH8qOimqPb3TuJRlZDn3Z5RTrxwcM
         yxDqKH2nPm5wXEIh4cJrhBffO51lQV1v14Zqy9d06CQIwd4AxZk97H7yqC58PDpskHHM
         IqUJnOBNzVApAHGDDAMvkrvdOU9CR1n7Id83UU2hGJlWalaMGo1yepkwsZaBnaqjhkFv
         0ZvQCyXxhdKXuINXfMtAKXriSXOQdNtE9//w2SvnFrPyqqm517LdbYPVl/tW8pxdZPv9
         eigbKeHx8WMQ4gGTioYryo88eUHW1iWFkb0qnYNZI1WUIh3LLwKQ1FSUFraNa2fPxYfn
         FTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQZpOeq136fA+TbYLLmeC/V+dkTwBKgS3u+70cAJpZPElUa/E3zGdJot7Rf1PWR0niNTtBgIUDSzUgdDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3fXCE0Ww00eLyUN9pGggF8GiNJ+1s7oJrcN/0BpAyzEu8Yjv
	RUcmcRIuaMHC+PtyIJpRVAh+d7rh180b677DU70H1E0nQ3gExLVo2cTZFfGq9M+t6CAGSoVNAze
	nDRmzr2UH9TSmYkLVEcRdpdOPK5PNooX6y/nKnXrT+w4jUkLIoXo0apVZCZk=
X-Google-Smtp-Source: AGHT+IHiO7bm6coHTCR9pw4OpeegBn4wlswz2eCiB5anuDZKxvTvg0yy9+nQeyfV4RYip9an+pwSgYYUT0uM9GOg7BmNbwUYhn0A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6215:b0:887:26b5:a581 with SMTP id
 ca18e2360f4ac-93b96a5d491mr110275239f.12.1759448042962; Thu, 02 Oct 2025
 16:34:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 16:34:02 -0700
In-Reply-To: <20251002225742.2395560-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df0bea.050a0220.2c17c1.0006.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in ext4_search_dir

loop0: detected capacity change from 1024 to 767
==================================================================
BUG: KASAN: use-after-free in ext4_search_dir+0xf1/0x1b0 fs/ext4/namei.c:1469
Read of size 1 at addr ffff888047fa1c98 by task syz.0.17/6004

CPU: 0 UID: 0 PID: 6004 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
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
RIP: 0033:0x7f67b018eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f67b1082038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f67b03e5fa0 RCX: 00007f67b018eec9
RDX: 0000000000000042 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007f67b0211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f67b03e6038 R14: 00007f67b03e5fa0 R15: 00007ffc3955f658
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1cf pfn:0x47fa1
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001321d08 ffffea0001457388 0000000000000000
raw: 00000000000001cf 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5999, tgid 5999 (dhcpcd-run-hook), ts 97515739076, free_ts 97930783293
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 folio_alloc_mpol_noprof mm/mempolicy.c:2435 [inline]
 vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2470
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 wp_page_copy mm/memory.c:3552 [inline]
 do_wp_page+0x1231/0x5800 mm/memory.c:4013
 handle_pte_fault mm/memory.c:6068 [inline]
 __handle_mm_fault+0x1033/0x5440 mm/memory.c:6195
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5999 tgid 5999 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 free_unref_folios+0xdbd/0x1520 mm/page_alloc.c:2952
 folios_put_refs+0x559/0x640 mm/swap.c:999
 free_pages_and_swap_cache+0x4be/0x520 mm/swap_state.c:267
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 exit_mmap+0x44c/0xb50 mm/mmap.c:1293
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
 ffff888047fa1b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888047fa1c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888047fa1c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                            ^
 ffff888047fa1d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888047fa1d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         f79e7722 Merge tag 'media/v6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1176c92f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f967f2c97bd611a
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f18458580000


