Return-Path: <linux-kernel+bounces-736916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695FB0A51D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFF6581519
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5862DC344;
	Fri, 18 Jul 2025 13:27:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCEB2D979C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845224; cv=none; b=O+NiQatt0S1Fp0fbdoi1f2lLyFEQKujIpcODhPpt3hXwShtSDT3oJy77uthYf4j+ZISdgy+NhjpyFmjfbIhC0JW1+KO+ikN1AyoWJ3ZufhpQZn9UP7s7SIfZVyyD0UpLXVvvKCipGiQ/xdbfu7GC9U4VR2pJRfeLcCIkzJLwoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845224; c=relaxed/simple;
	bh=h8I/v9Uey5DCpDJ/EKCJaETXqp+70nNHL6Io/E6WEdQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QshDUzsl0aCtWMlj5GSj9aPuLG9kR4FmqWKscAFeGeTqkYrYNM5MfHYQ9zrx1WAo/a4UjEFgXsILybghImJ6fdCiFAEtVl+YFYSaXM06BaWl+X52ShNN9B9iEchfphQZnxQ7WANywi0Jmde/W28sAa6Di5CxHQcbK5XuQfOrK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c0e531fc4so148318839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752845222; x=1753450022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DX+s2di3wG9h33pI8asf/7RDaIBckFTauzZO6guRFcY=;
        b=Ze3EnfZvneY4llK15/Lx7A6o6hMeTNvBL2NjDHqPZTs6YzshYmSHNMW3I9eNI0emv9
         ZLiM5XhbSK6LzEccT+QJ8WCzGcx1uy8bfqOQcV2A02YRvWgjlyPZdq59GgeMYAwma4Uq
         cQ0OfHpuvNC85saOwjRBlQUpqvq9EkHJhBZRjVoDQhzsuKqGHuRFJx2GRqI5KBUx6Ujj
         W1EgLhGKm5D8wJK5XrNL/djmdG4YAwLvrFGdiYSXRXJpKyEAKVKTB/3jkaY+10/lST/b
         8WMoAbLpIFMrfRRf8uL56vhntP/l1H3aNPt5yGO6ce9j9oRkzzJpnGzGUJ7s/NzaRoTY
         Gw6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhxzm4o/gbggXWzdUANsJTlRelhUieaDaMFdk1HGxXgqMEV5I+NtXDyBhmWvhnpnGvOENmcyVAJko6QBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofjY/pqLzq0dvoV/9C++8Dsay5xgvOkqZIFcUjv+WKTF3U097
	YZJm5JjtjnQPf/M89PGKYxtBO0Ke4gmAEKwzXtQBj7vSqA5rwivaSzFE1BmMQdymQRUkURjB6IX
	taa1IkIG402zWaFqkEvSlTyWcWHFfdUlwvQmafq4J4sKgJi96aG665j5ziK4=
X-Google-Smtp-Source: AGHT+IEUPIkxy4VvbZiaIWKJB8pdBetQ0ycEppfbYmm4vfpr/coq26jBN3CUyKAiOF1qBp+G0Qt9BYwfvqHvq79u8k1do8muT5OE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a35:b0:86c:ef0b:3a52 with SMTP id
 ca18e2360f4ac-879c2925195mr1051122239f.11.1752845222338; Fri, 18 Jul 2025
 06:27:02 -0700 (PDT)
Date: Fri, 18 Jul 2025 06:27:02 -0700
In-Reply-To: <62d528e9-2414-4e50-8e3f-c4cac3526858n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687a4ba6.a70a0220.693ce.0065.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in hpfs_get_ea

hpfs: filesystem error: warning: spare dnodes used, try chkdsk
hpfs: You really don't want any checks? You are crazy...
hpfs: hpfs_map_sector(): read error
hpfs: code page support is disabled
==================================================================
BUG: KASAN: use-after-free in hpfs_get_ea+0x1f7/0xca0 fs/hpfs/ea.c:146
Read of size 1 at addr ffff8880719ea8a3 by task syz.0.16/6612

CPU: 0 UID: 0 PID: 6612 Comm: syz.0.16 Not tainted 6.16.0-rc6-syzkaller-00121-g6832a9317eee-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 hpfs_get_ea+0x1f7/0xca0 fs/hpfs/ea.c:146
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
RIP: 0033:0x7fb45e3900ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb45f2c9e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fb45f2c9ef0 RCX: 00007fb45e3900ca
RDX: 0000200000009e80 RSI: 0000200000009ec0 RDI: 00007fb45f2c9eb0
RBP: 0000200000009e80 R08: 00007fb45f2c9ef0 R09: 0000000000000041
R10: 0000000000000041 R11: 0000000000000246 R12: 0000200000009ec0
R13: 00007fb45f2c9eb0 R14: 0000000000009e02 R15: 0000200000009fc0
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7fdaad200 pfn:0x719ea
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001c67988 ffffea0001c61d88 0000000000000000
raw: 00000007fdaad200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 6566, tgid 6566 (sed), ts 134996856935, free_ts 135030622689
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 folio_alloc_mpol_noprof mm/mempolicy.c:2438 [inline]
 vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2473
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 alloc_anon_folio mm/memory.c:5014 [inline]
 do_anonymous_page mm/memory.c:5071 [inline]
 do_pte_missing mm/memory.c:4249 [inline]
 handle_pte_fault mm/memory.c:6069 [inline]
 __handle_mm_fault+0x2c88/0x5620 mm/memory.c:6212
 handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6381
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 6566 tgid 6566 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 free_unref_folios+0xcd2/0x1570 mm/page_alloc.c:2763
 folios_put_refs+0x559/0x640 mm/swap.c:992
 free_pages_and_swap_cache+0x277/0x520 mm/swap_state.c:264
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
 ffff8880719ea780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880719ea800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880719ea880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
 ffff8880719ea900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880719ea980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         6832a931 Merge tag 'net-6.16-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155f38f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1644fd8c580000


