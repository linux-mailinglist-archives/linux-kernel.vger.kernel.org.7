Return-Path: <linux-kernel+bounces-738086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA945B0B423
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DE7178801
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982E51CBEAA;
	Sun, 20 Jul 2025 07:49:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2A78F4A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752997746; cv=none; b=RqjkmiqP5xSRzajEOQms+qoKj1y9gjBT7IFyxxofQE2KuVo0Gb6AAghAO1PaolClHqun3xmU8O+JK6+K/Lwv7tOA76e4qAYiP98QS1QQqxqLHgCT1msNHSR8CXSgnOnBbgU/92IaJT1mhMw9OKLO744RCKkrIGS7cuNk99ZNdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752997746; c=relaxed/simple;
	bh=N26ZGLWPwoUAkNgftjAVDr+88CA5gLyx4SIrLsdMtpk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hR/6FSzHndOSDNw5Nb5lZl87CLy4DbezmFSK8/GG3x6ebLaWvCNpdN2G8f2RhkrezfpVukkqogoroN3VDdlaXvoszOqF8VArtCcnguJM/4bFuLxXlOXjjjq91XtU6nK/TKqzjGBdeGeGo/0H+2/xwGCFBklrbuUkNWf6XqeEYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86f4e2434b6so378378439f.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752997743; x=1753602543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7xAjgXtlwM/t7mVJXnXUconqhFA4R6rNmyrQ1x51rM=;
        b=docUUPGzwTbGJnFr7m2XxZps0Uu66qe37JFwevogM46TiEgabAZOJOdpqoQVIjaHUB
         0Q/dBWHNZHEPyw1mXijkEJxCmu+0QV0apQa0hLMOTgx2sc40KmAA9Xf40mTxQeL9cG/k
         K0dlV5v2QLaunsbcF24amfl8/tun4jc+qWdhJhBzO0PbWZCqNGc03qQzYSXkOe3+4ovA
         ZbfYLAZxq3Oq4x0iUumA2kPfnZ5powytJ1w2+fcKeGr8ZiwSpCDDm2BV1DEjoF3Urxao
         gYLEys9/NxSzhTGq3j+vB4ZJBd48JCJlYw/deTxbvmJdWUEN10UAiTA4eeu2O/1TPQtM
         XEOA==
X-Gm-Message-State: AOJu0YwdbwnMdoLiG4k9nm8G9BhCcvRB+hASdSNcx0GDNRVHHH+ye92e
	7tUt9W7iDsLghTj8OSxND88/JIX7ur2E3/8MYG6094gra3rmTo5ZO0EZglHm1nvVqFpN8HXB/7X
	Esj+ryF3Ex4NabXlCjBt8T9YKoV3bwVFcHb3nMC1I4MRCKPH2vkepDs70Mc4=
X-Google-Smtp-Source: AGHT+IEg4zMmsyIjQj0D37KKRze34ZchgL1Qtjq8GB0erLmjRuNX7c9MpOT+2yM0hLMNNtWgWKDZPt0h9crheQUszBN01kItzPTi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:380f:b0:87c:1d65:3aeb with SMTP id
 ca18e2360f4ac-87c1d653c78mr459226739f.2.1752997743684; Sun, 20 Jul 2025
 00:49:03 -0700 (PDT)
Date: Sun, 20 Jul 2025 00:49:03 -0700
In-Reply-To: <CAMp3bLWE1Q17He7mzu8S-VTe9Sackn8YryD6L0msjyPpifmyBg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c9f6f.a70a0220.693ce.00b6.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in hpfs_get_ea

hpfs: filesystem error: invalid number of hotfixes: 2066844986, used: 2066844985; already mounted read-only
hpfs: filesystem error: improperly stopped
hpfs: filesystem error: warning: spare dnodes used, try chkdsk
hpfs: You really don't want any checks? You are crazy...
hpfs: hpfs_map_sector(): read error
hpfs: code page support is disabled
==================================================================
BUG: KASAN: use-after-free in hpfs_get_ea+0x1ee/0xc90 fs/hpfs/ea.c:144
Read of size 1 at addr ffff88806051d8a3 by task syz.0.16/6564

CPU: 1 UID: 0 PID: 6564 Comm: syz.0.16 Not tainted 6.16.0-rc6-syzkaller-00281-gf4a40a4282f4-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 hpfs_get_ea+0x1ee/0xc90 fs/hpfs/ea.c:144
 hpfs_read_inode+0x19d/0x1010 fs/hpfs/inode.c:63
 hpfs_fill_super+0x12bd/0x2070 fs/hpfs/super.c:654
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1681
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2b0bb900ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2b0ca8de68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2b0ca8def0 RCX: 00007f2b0bb900ca
RDX: 0000200000009e80 RSI: 0000200000009ec0 RDI: 00007f2b0ca8deb0
RBP: 0000200000009e80 R08: 00007f2b0ca8def0 R09: 0000000000000041
R10: 0000000000000041 R11: 0000000000000246 R12: 0000200000009ec0
R13: 00007f2b0ca8deb0 R14: 0000000000009e02 R15: 0000200000009fc0
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x2 pfn:0x6051d
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea00017f91c8 ffffea0001814508 0000000000000000
raw: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 6526, tgid 6526 (sed), ts 155457290558, free_ts 155502026680
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 folio_alloc_mpol_noprof mm/mempolicy.c:2438 [inline]
 vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2473
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 wp_page_copy mm/memory.c:3569 [inline]
 do_wp_page+0x1231/0x5800 mm/memory.c:4030
 handle_pte_fault mm/memory.c:6085 [inline]
 __handle_mm_fault+0x1144/0x5620 mm/memory.c:6212
 handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6381
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 6526 tgid 6526 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 free_unref_folios+0xcd2/0x1570 mm/page_alloc.c:2763
 folios_put_refs+0x559/0x640 mm/swap.c:992
 free_pages_and_swap_cache+0x4be/0x520 mm/swap_state.c:267
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 exit_mmap+0x44c/0xb50 mm/mmap.c:1297
 __mmput+0x118/0x410 kernel/fork.c:1121
 exit_mm+0x1da/0x2c0 kernel/exit.c:581
 do_exit+0x648/0x22e0 kernel/exit.c:952
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
 __do_sys_exit_group kernel/exit.c:1116 [inline]
 __se_sys_exit_group kernel/exit.c:1114 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1114
 x64_sys_call+0x21ba/0x21c0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88806051d780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88806051d800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88806051d880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
 ffff88806051d900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88806051d980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         f4a40a42 Merge tag 'efi-fixes-for-v6.16-2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116f8b82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e5b7d4580000


