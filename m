Return-Path: <linux-kernel+bounces-872586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58591C11837
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15B714E2EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36B324B2F;
	Mon, 27 Oct 2025 21:17:34 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AC2C15A8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599854; cv=none; b=SNzPrN+x80mGkR22VUdhkngQRLWP0GNhQ9zXAzIvoaVJ5zmefLIpot6x+XJwFmgQR14X2WmZVdswuMJb57Sj7garxGxZEbtj0Bt7Xrq2VO6qEmr0JoIpPUdpTJDTo1ecc/xR7j3YR8b7Ky1VWDIb+xORurAug/q4aEdwj8qp1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599854; c=relaxed/simple;
	bh=4mr5YBif/PMaISEB0kyGz7Y1AmJ90TjLDTzSUIR6IrU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BSD6mWiv9yV5mcflZ8rdDZuw9RQbdLgyyf/0ahYmC29GDGSAV/RyHSyDoeow+U6d54Wot2MA5kc/Fp62iBVbaAxaGeDsLCohSK5bfbBdNxGJPTM8gBRQWNYjBRKYuxHjXsOFryMl0H7N+bUOx/j6f2H9dU8dhGBcWLI/Gd/uJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430ca53080bso53440185ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761599851; x=1762204651;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpFwd3BTvddRmXCyOREKM3aDRBoXKG7FVv68NbxwWTY=;
        b=ZQzulZCdC2vNDl6i0rWjOyzL+NJbHFfHs6QPylFq8X8+AUY/Vh732QtV+UYYvmRi7H
         te+5ty4e5bHGLeaQqxY/ogZRdgJMq65ku7YH4X+kx8XmvzplrZ9jvoQ+OBtk+gymePxZ
         1lgxlQsjojH1p3o8CgFqzZMyydTEgfKMXBoxpVWAkLFPp8XEQJvthfkOgbA4QpMl9qYf
         T4Favh/viaThVarlVTuCIzssrwon+blgoaBKs8XBV1VRMIfG/1B/aT7h58zS/EBlKti9
         IkxGR0cciWLjrer8wkZKDaGPti5IrQaqlmfgFC3taF9/U1JNEgjGReGVpVJuRETjwxlX
         6SOw==
X-Forwarded-Encrypted: i=1; AJvYcCWBHHbvNBV032qaOg3Z/u5JSu/UroHNUPzKu26uZX8jmFahRMpHj0c5/nG2FLJwZ5ZJDjU4hI9xUIobaEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQa/wlDOSC0BW7zz6JnXYDUwRp4DO8orHtTttl8cs+E3fA3Nxy
	xlCzI+A7l+qIzPTWnfE96x+p7A9QZB+kHH55+50L1QO++KaBELzLQL1gTmyQfF69ItnAok7AjWe
	lKdiuQmgym+18ShC7tJkpVi7bxLAuSzrUH9SB4BSG3hAtAZ7f7sWSNoktqMY=
X-Google-Smtp-Source: AGHT+IEFa1cGmFpFTgATLEflN3lFPJMR+QNgzAgxFRr8SVhBoOmS/sh6XoNsGoSdqAahqJBNWPQTOWjW8suCay2tEG0ZpvnXtxdv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b88:b0:42f:a7ee:4922 with SMTP id
 e9e14a558f8ab-4320f773782mr20794495ab.16.1761599851668; Mon, 27 Oct 2025
 14:17:31 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:17:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ffe16b.050a0220.3344a1.039f.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_count_dnodes
From: syzbot <syzbot+7d1563afac6cb196a444@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mikulas@artax.karlin.mff.cuni.cz, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    72761a7e3122 Merge tag 'driver-core-6.18-rc3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a293cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8345ce4ce316ca28
dashboard link: https://syzkaller.appspot.com/bug?extid=7d1563afac6cb196a444
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165c1e7c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129427e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/733feb854771/disk-72761a7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94891a491db1/vmlinux-72761a7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1dc1e26ee843/bzImage-72761a7e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2990601c297c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d1563afac6cb196a444@syzkaller.appspotmail.com

HPFS: dnode_end_de: dnode->first_free = 7b3184b6
HPFS: de_next_de: de->length = 0
HPFS: dnode_end_de: dnode->first_free = 7b3184b6
HPFS: de_next_de: de->length = 0
HPFS: dnode_end_de: dnode->first_free = 7b3184b6
HPFS: de_next_de: de->length = 0
HPFS: dnode_end_de: dnode->first_free = 7b3184b6
==================================================================
BUG: KASAN: use-after-free in hpfs_count_dnodes+0x854/0xb20 fs/hpfs/dnode.c:773
Read of size 2 at addr ffff8880471a64d0 by task syz.0.17/5986

CPU: 1 UID: 0 PID: 5986 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 hpfs_count_dnodes+0x854/0xb20 fs/hpfs/dnode.c:773
 hpfs_read_inode+0xc52/0x1010 fs/hpfs/inode.c:128
 hpfs_fill_super+0x12a9/0x2050 fs/hpfs/super.c:650
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6afb54076a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5770e378 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd5770e400 RCX: 00007f6afb54076a
RDX: 000020000000a000 RSI: 0000200000009ec0 RDI: 00007ffd5770e3c0
RBP: 000020000000a000 R08: 00007ffd5770e400 R09: 0000000003200041
R10: 0000000003200041 R11: 0000000000000246 R12: 0000200000009ec0
R13: 00007ffd5770e3c0 R14: 0000000000009e21 R15: 0000200000000000
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x5604d8ef1 pfn:0x471a6
flags: 0x80000000000000(node=0|zone=1)
raw: 0080000000000000 ffffea0000f20148 ffffea00011c6e48 0000000000000000
raw: 00000005604d8ef1 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5928, tgid 5928 (udevd), ts 106316997485, free_ts 115294923226
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 folio_alloc_mpol_noprof mm/mempolicy.c:2435 [inline]
 vma_alloc_folio_noprof+0xe4/0x280 mm/mempolicy.c:2470
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 wp_page_copy mm/memory.c:3679 [inline]
 do_wp_page+0x11f4/0x4930 mm/memory.c:4140
 handle_pte_fault mm/memory.c:6193 [inline]
 __handle_mm_fault mm/memory.c:6318 [inline]
 handle_mm_fault+0x97c/0x3400 mm/memory.c:6487
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
page last free pid 5928 tgid 5928 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 free_unref_folios+0xc22/0x1860 mm/page_alloc.c:2963
 folios_put_refs+0x569/0x670 mm/swap.c:1002
 free_pages_and_swap_cache+0x277/0x520 mm/swap_state.c:355
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 exit_mmap+0x444/0xb40 mm/mmap.c:1293
 __mmput+0xcb/0x3d0 kernel/fork.c:1133
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:954
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 __do_sys_exit_group kernel/exit.c:1118 [inline]
 __se_sys_exit_group kernel/exit.c:1116 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1116
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880471a6380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880471a6400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880471a6480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff8880471a6500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880471a6580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

