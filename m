Return-Path: <linux-kernel+bounces-890358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EEAC3FE59
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C3E1892736
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A884039;
	Fri,  7 Nov 2025 12:31:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104131FDA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518669; cv=none; b=axLpwKmEG28zowUyzE2G8FmhZm3FqZeXvneZb5wlt1NpGMP3qjld1p0gjuU1zAyGr52Ipmb/IK42MzJ93bBgLCk9yeQGrN5eRL9uyUFmXyUJK//qQTeYACO6+MExTFszICCuKJWVfT++Yg+WriougqFmw7L9T19TvPr0AMDWPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518669; c=relaxed/simple;
	bh=C1bwZwZYkjOemEoQy7IAf9mRYarS0AkpLq9qEIitGF4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kFW/FY+XcCJfpNeOV854ICV4ON16fMHFo0cZFR3uAk5OgPSCPi8wmTi+bJTmTpwOkInWjRHlxfObftNDTrbf1VnKiZLwyV3shKa504s1HpIJf9e06/7wxl/mMLY32VjZ6x9XyyJylFQzjDXFQTso5KCqky9BshrPgPygRr64V8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940f5d522efso132713739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762518664; x=1763123464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tec+fl2m4A5ufgJbJ9g6OD84PUrXgUOwmbOyKFcXfU=;
        b=UB3racfb0nPNV+WGOt8PYwx77sbL8w2R0x6Rjl7bC++umHAmiQyA/h3xYtSHnX5VzH
         xjNr4e7BBjdEJ6u8LAE9PRLffiWTUJUjO6lFpCDPZcQL3MBMdaqFm3cCoy981incQlU5
         peOcUiMgGsoordALTBYYBDza9SvRu2HZJuVZ7c6OxjgMvTbGExbIqHfiFkaPCuUoJboK
         24ycKpR+ukA3/TT238NTNFjJ3fIWJzP57oX1xK1JVATkz6EoFmUfEgxisFd7sSfz3uv7
         GSR/bI8vUomOJecNIiOXTN2yQZrz6C1fQlMcIBV5DkoZwSliOZ5wHNry05gebbUxNDiQ
         hWZA==
X-Gm-Message-State: AOJu0YxiGNGHj+Vgn0JYCKb4dt/OQL4X1T5o5lZ8lQo8WJ6huHjUEg58
	2K2zfOhi6TaF7q2PsY2FTPJ4L4zAhMXk/U4CAjl0mNgJ1BtoO1hPcLbYqbe8bF6BTTVPSaqkeNM
	lXlgaJE8JrzRcvttIJdeKTY903B6hr6s3hpxgscmBFuusEvSgXCUOBQB2Lww=
X-Google-Smtp-Source: AGHT+IHuWzS7PX3w1HOCf1RXPP6W7CJA1LjfRHXWBACLuDaKyZ/ObAxUX3qttjEET3rsWmH5rMGOJo85z29wQV9+Sk1WspIm6HGF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca08:0:b0:433:2b18:e8d with SMTP id
 e9e14a558f8ab-4335f440f08mr41660575ab.18.1762518664109; Fri, 07 Nov 2025
 04:31:04 -0800 (PST)
Date: Fri, 07 Nov 2025 04:31:04 -0800
In-Reply-To: <11a7108a-5fc2-40ee-b1b2-37a76f7284a2@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690de688.a70a0220.22f260.0049.GAE@google.com>
Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging request in diUpdatePMap
From: syzbot <syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in release_metapage

==================================================================
BUG: KASAN: slab-use-after-free in drop_metapage fs/jfs/jfs_metapage.c:312 [inline]
BUG: KASAN: slab-use-after-free in release_metapage+0x678/0xa34 fs/jfs/jfs_metapage.c:893
Read of size 8 at addr ffff0000cf7dddb8 by task jfsCommit/99

CPU: 0 UID: 0 PID: 99 Comm: jfsCommit Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 drop_metapage fs/jfs/jfs_metapage.c:312 [inline]
 release_metapage+0x678/0xa34 fs/jfs/jfs_metapage.c:893
 put_metapage+0x1ec/0x288 fs/jfs/jfs_metapage.c:863
 txUnlock+0x464/0xc98 fs/jfs/jfs_txnmgr.c:949
 txLazyCommit fs/jfs/jfs_txnmgr.c:2684 [inline]
 jfs_lazycommit+0x480/0x94c fs/jfs/jfs_txnmgr.c:2735
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

Allocated by task 7281:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:573
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x70/0x88 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4970 [inline]
 slab_alloc_node mm/slub.c:5280 [inline]
 kmem_cache_alloc_noprof+0x338/0x648 mm/slub.c:5287
 mempool_alloc_slab+0x58/0x74 mm/mempool.c:587
 mempool_alloc_noprof+0x150/0x3f4 mm/mempool.c:406
 alloc_metapage fs/jfs/jfs_metapage.c:264 [inline]
 __get_metapage+0x530/0xec8 fs/jfs/jfs_metapage.c:761
 diNewExt+0x800/0x253c fs/jfs/jfs_imap.c:2275
 diAllocExt fs/jfs/jfs_imap.c:1952 [inline]
 diAllocAG+0x9bc/0x1a84 fs/jfs/jfs_imap.c:1669
 diAlloc+0x17c/0x1630 fs/jfs/jfs_imap.c:1590
 ialloc+0x80/0x78c fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x170/0x8b4 fs/jfs/namei.c:225
 vfs_mkdir+0x284/0x424 fs/namei.c:4453
 do_mkdirat+0x1f8/0x4c8 fs/namei.c:4486
 __do_sys_mkdirat fs/namei.c:4503 [inline]
 __se_sys_mkdirat fs/namei.c:4501 [inline]
 __arm64_sys_mkdirat+0x8c/0xa4 fs/namei.c:4501
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 7107:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 __kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x74/0xa4 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6630 [inline]
 kmem_cache_free+0x18c/0x6dc mm/slub.c:6740
 mempool_free_slab+0x28/0x38 mm/mempool.c:594
 mempool_free+0xf8/0x5a0 mm/mempool.c:576
 free_metapage fs/jfs/jfs_metapage.c:280 [inline]
 metapage_release_folio+0x36c/0x484 fs/jfs/jfs_metapage.c:637
 metapage_invalidate_folio+0x14c/0x1cc fs/jfs/jfs_metapage.c:672
 folio_invalidate mm/truncate.c:140 [inline]
 truncate_cleanup_folio+0x264/0x3a0 mm/truncate.c:160
 truncate_inode_pages_range+0x1f4/0xe18 mm/truncate.c:379
 truncate_inode_pages+0x2c/0x3c mm/truncate.c:460
 jfs_put_super+0x124/0x188 fs/jfs/super.c:200
 generic_shutdown_super+0x12c/0x2b8 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xc4/0x12c fs/super.c:473
 deactivate_super+0xe0/0x100 fs/super.c:506
 cleanup_mnt+0x31c/0x3ac fs/namespace.c:1327
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1334
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

The buggy address belongs to the object at ffff0000cf7ddd90
 which belongs to the cache jfs_mp of size 184
The buggy address is located 40 bytes inside of
 freed 184-byte region [ffff0000cf7ddd90, ffff0000cf7dde48)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10f7dd
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000000 ffff0000c4c31000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000cf7ddc80: fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000cf7ddd00: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
>ffff0000cf7ddd80: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff0000cf7dde00: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
 ffff0000cf7dde80: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Unable to handle kernel paging request at virtual address dfff800000000029
KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000029] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 99 Comm: jfsCommit Tainted: G    B               syzkaller #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : txEnd+0x180/0x4f0 fs/jfs/jfs_txnmgr.c:541
lr : txEnd+0x158/0x4f0 fs/jfs/jfs_txnmgr.c:530
sp : ffff8000993c7c60
x29: ffff8000993c7c60 x28: 1ffff00013680666 x27: ffff80008fb96000
x26: 1ffff00011f72cc4 x25: dfff800000000000 x24: ffff8000974a8000
x23: 0000000000000001 x22: 000000000000014c x21: ffff80009b403358
x20: 0000000000000003 x19: 0000000000000000 x18: 1fffe000337db690
x17: 3d3d3d3d3d3d3d3d x16: ffff8000802112a8 x15: 0000000000000001
x14: 1ffff0001368066c x13: 0000000000000000 x12: 0000000000000000
x11: ffff70001368066d x10: 0000000000ff0100 x9 : 0000000000000029
x8 : 0000000000000003 x7 : ffffffffffffffff x6 : ffff800080502e24
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800081c4c3ec
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 txEnd+0x180/0x4f0 fs/jfs/jfs_txnmgr.c:536 (P)
 txLazyCommit fs/jfs/jfs_txnmgr.c:2686 [inline]
 jfs_lazycommit+0x4b4/0x94c fs/jfs/jfs_txnmgr.c:2735
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
Code: 12003e88 790002b7 d343fec9 b902c308 (38f96928) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	12003e88 	and	w8, w20, #0xffff
   4:	790002b7 	strh	w23, [x21]
   8:	d343fec9 	lsr	x9, x22, #3
   c:	b902c308 	str	w8, [x24, #704]
* 10:	38f96928 	ldrsb	w8, [x9, x25] <-- trapping instruction


Tested on:

commit:         dcb6fa37 Linux 6.18-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17f7dbcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=7fc112f7a4a0546731c5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a7dbcd980000


