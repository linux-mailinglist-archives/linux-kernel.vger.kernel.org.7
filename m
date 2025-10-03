Return-Path: <linux-kernel+bounces-841090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4C5BB63D3
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4147D4E42FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038423D7FA;
	Fri,  3 Oct 2025 08:35:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D22BD03
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759480507; cv=none; b=S3S2WcmN5R+RofSWFWQDDxi7sdMUrFQsiB83Bvy/uNlKw8lMct/76ilo22AFM7Dkn4hGG76/iwVIpmCCaX9OflmYCyDZhjGpyCCKoabD0JEZriWQuQ6sGxbB+wJcfxMHPmdxur0rgbtj+5IPCZAjD0u0ol6KwI1M+X+wostTLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759480507; c=relaxed/simple;
	bh=xIWOLYk+eAUc58pYKgJkZMLCy6w/UjdRoQelJqU0IX4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ovPyx6YMJVEEQu/pG8LQhBBGVbH/iNlLZar0MGDaCWL96g8oVZjS68uSDEAfrjwW85l9pxgLg9LKJN1TkaiA7BY77lIM6YkH6H/B5xW3puhMzqYx6VEvTv0SCFupVuXMc/PURIgNsxszCgmNWtITH6BpnOR3K+1gi4jYkV5roaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42640cbf7f2so61501115ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759480504; x=1760085304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0ZujGHTzkp1B1hJZ1y1duO+/1npTWs5I8S+KWjP5A4=;
        b=tNgZE6pABU2+ZcRbt42/ZSHYrh5ma9wCngGnMFCFrB5fWlRsdYcR6EJXXt45ONxckx
         BguhG9z/iy0MQeV/uG+gc+0ia3Q77rztNV9+BeeRGKZjX+fqncxNBKm9ywEvz3WFVAjf
         03DTv5hONwakdGHg7ooy0l5DS0Fn3ik+dxua6SIWn//MeMJoTDv0r0YCJrO2LEkmv1Ki
         CaqX11/XEkzDDhMJJPm+b9BY/RPv1yd5wSnJzfz1iPgTAZXp01FAoJEFHJUfY+Hik1fv
         5LNGVHXbhMGWMjySHDE2KyDg+u1lptv/3KAxAMhp3lJgHh+xBcNCN3uU2UT5fVLhgepD
         b05A==
X-Forwarded-Encrypted: i=1; AJvYcCV1SsyaLgOSIaPIEITlJOFUhZKSzSHsRpCNyI/Y+cNHCZP4fzqKalF/sdDmV1JJ3RhYR73LMVrhhREC/i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6qgHkhfnxv4kFxNtw7YXFcw8WAozMe1fXMNid5j9qiO8a3x/
	yR0SXOLaOEQ9OnuK/2eGDNUUwfmtsXonqbaMyU8mxqBS/gwS4l0zJ3wEADNAiRitsQFrgAw1gfP
	VKPS42/RWdJxQj25bgxFoD5W/xIL1Lkyf3u5fUBJGzVx0l2bREVU+Z3Se6Yc=
X-Google-Smtp-Source: AGHT+IGVXYdcxPCAZN+41G45APEO8s4PRkmirukNJEXXY4A+z40wtHr27zvbwoui6P9Zl7YLemeb6CzwvM6B/VHNgFlJczNNFjsz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:42d:86cc:1bd2 with SMTP id
 e9e14a558f8ab-42e7adb977cmr28865085ab.32.1759480504370; Fri, 03 Oct 2025
 01:35:04 -0700 (PDT)
Date: Fri, 03 Oct 2025 01:35:04 -0700
In-Reply-To: <20251003081442.2555454-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df8ab8.050a0220.2c17c1.001c.GAE@google.com>
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
Read of size 1 at addr ffff888047c19e53 by task syz.0.25/5994

CPU: 0 UID: 0 PID: 5994 Comm: syz.0.25 Not tainted syzkaller #0 PREEMPT(full) 
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
 __do_sys_creat fs/open.c:1528 [inline]
 __se_sys_creat fs/open.c:1522 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1522
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f30dc98eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f30dd80c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f30dcbe5fa0 RCX: 00007f30dc98eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000100
RBP: 00007f30dca11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f30dcbe6038 R14: 00007f30dcbe5fa0 R15: 00007ffd1c506f18
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1ce pfn:0x47c19
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea00011f0688 ffffea00011f6088 0000000000000000
raw: 00000000000001ce 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5999, tgid 5999 (cmp), ts 160342984478, free_ts 160390502500
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 folio_alloc_mpol_noprof mm/mempolicy.c:2435 [inline]
 vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2470
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 wp_page_copy mm/memory.c:3679 [inline]
 do_wp_page+0x1231/0x5800 mm/memory.c:4140
 handle_pte_fault mm/memory.c:6193 [inline]
 __handle_mm_fault+0x1033/0x5400 mm/memory.c:6318
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6487
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5999 tgid 5999 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 free_unref_folios+0xdb3/0x14f0 mm/page_alloc.c:2963
 folios_put_refs+0x584/0x670 mm/swap.c:1002
 free_pages_and_swap_cache+0x277/0x520 mm/swap_state.c:355
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 exit_mmap+0x444/0xb40 mm/mmap.c:1293
 __mmput+0x118/0x430 kernel/fork.c:1133
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:954
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 __do_sys_exit_group kernel/exit.c:1118 [inline]
 __se_sys_exit_group kernel/exit.c:1116 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1116
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888047c19d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888047c19d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888047c19e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff888047c19e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888047c19f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         e406d57b Merge tag 'mm-nonmm-stable-2025-10-02-15-29' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126965cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13911ee2580000


