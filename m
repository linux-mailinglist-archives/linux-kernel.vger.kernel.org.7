Return-Path: <linux-kernel+bounces-835349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE703BA6D45
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B36B7AA047
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F432D77E6;
	Sun, 28 Sep 2025 09:26:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BE2D193B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759051565; cv=none; b=SUJNyQ6gXqR4cmyJN5ue2umoegK0cLIOjYjD6yPzR+eUagKm9ZkhJ1zS8xPiOdYMNERZmAjzDQeaR3qRD2HsVdmwF6NtBJaNrjTIDEdoAr9vxiH9QD4TTW7/uW/5LMx1wrpmFiF3mhi+/qkPhUUAWOuDyoAbTKTiJaxPgdcMgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759051565; c=relaxed/simple;
	bh=/aJijknKBS8+IlQfRBTreUPk/qcfBT9jHa5+vVxOIMo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OQ22bpWuTcx3vzPTUBT9XIrUe283rnq3zrB6VvbLlKZBEdT9mOxsITVWqLpK43/DEd0okn9AOgKT4nHYWvwMkBSBvw8uF/3NOLGfHOQR4O8fcXXpGTVji1WcLH8velKtI44oBGRh7YGXL17a5RrwTLiqlqtIUcyKVaR/bdB4lVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-426cea3f07eso90440785ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759051562; x=1759656362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6UcUEl+n5DzBI8rGE8oXMTQmrLTc/3pyU/b7KjGWGg=;
        b=im2de7zM251Cb3sl8zb3ah7cjoY/pYre6RZPfiy0hhvcqA2yQn5JXw/QIH7bVckEAu
         PcjNCXhDvqi4ZjhSyfgOYj1hxfao2lMju+jHOgMXwvYVgiEDCfTfHVDUoklQCF2ev1yU
         2XLQmNANUONyFsatkTscAeLo88g2zImGBLWvweAmcIOrbDqUNUVHyO+gOBcWxatXZV7A
         ouCXL/izZp7Kb6XKdHFHYNqk1xCyQt5dwfytV0BQ2Evsu/AhEJuCGHpE6gzHSGLLellj
         YJFutRPQsWf8unZ307TpkrmTicp2pGAJByDCkQ2PHxntVaRLNvyA2Wiur8nj18Ldq49u
         +n+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDUA7dJMtSmjCMFf7o6EiR9pYc0s9hFso5xS+/zfxm1RkGEtsHbKmzoNKyRfbs46OLp02z64OJ9feG6bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSN+bvJbvQif87RIMujajt+v968cd4ZR9WnZbieawHjZ9yTWZ
	kHsrkLcR5QJkCbr74oX1nN8qUHB4vjNKpbqTDmliac7x5c4snSpi5eAd657SDaq2PorK3SbcoJH
	Zg0RUTumZ5OmCGPAEynXRadXlkF4pov+zhcXZk4kZPQl290YpAMum5limdLo=
X-Google-Smtp-Source: AGHT+IEbdVcmAw4NNhSmiL8xNf9XfgCRtBqQv4RIBEvSv4d93qPSpSnTWBZbPLIFP481RDZURcUSJkju9IW9GkIHWtYHkVIh1oy3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c6:b0:423:fac4:d8aa with SMTP id
 e9e14a558f8ab-425955d492dmr183838325ab.8.1759051562184; Sun, 28 Sep 2025
 02:26:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 02:26:02 -0700
In-Reply-To: <20250928091137.9626-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8ff2a.a70a0220.10c4b.001c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (3)
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: =syzbot@syzkaller.appspotmail.com, kartikey406@gmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in ext4_find_extent

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
EXT4-fs error (device loop0): ext4_cache_extents:545: inode #15: comm syz.0.17: corrupted extent tree: lblk 0 < prev 66
==================================================================
BUG: KASAN: use-after-free in ext4_ext_binsearch fs/ext4/extents.c:848 [inline]
BUG: KASAN: use-after-free in ext4_find_extent+0x85c/0xa20 fs/ext4/extents.c:963
Read of size 4 at addr ffff888041c23e48 by task syz.0.17/5858

CPU: 0 UID: 0 PID: 5858 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_ext_binsearch fs/ext4/extents.c:848 [inline]
 ext4_find_extent+0x85c/0xa20 fs/ext4/extents.c:963
 ext4_get_verity_descriptor_location fs/ext4/verity.c:292 [inline]
 ext4_get_verity_descriptor+0x102/0x590 fs/ext4/verity.c:346
 fsverity_get_descriptor+0x90/0x4b0 fs/verity/open.c:323
 ensure_verity_info fs/verity/open.c:363 [inline]
 __fsverity_file_open+0xd7/0x1f0 fs/verity/open.c:384
 fsverity_file_open include/linux/fsverity.h:300 [inline]
 ext4_file_open+0x32d/0xa40 fs/ext4/file.c:909
 do_dentry_open+0x950/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cf3b8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6cf4aaa038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f6cf3dc5fa0 RCX: 00007f6cf3b8ebe9
RDX: 0000000000000000 RSI: 0000200000000100 RDI: ffffffffffffff9c
RBP: 00007f6cf3c11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6cf3dc6038 R14: 00007f6cf3dc5fa0 R15: 00007fff26487178
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x55b5a552d pfn:0x41c23
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001070948 ffffea0001070888 0000000000000000
raw: 000000055b5a552d 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5236, tgid 5236 (dhcpcd), ts 65849526604, free_ts 140329459250
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 compaction_alloc_noprof mm/compaction.c:1836 [inline]
 compaction_alloc+0x3099/0x34a0 mm/compaction.c:1847
 migrate_folio_unmap mm/migrate.c:1211 [inline]
 migrate_pages_batch+0x7e2/0x35c0 mm/migrate.c:1873
 migrate_pages_sync mm/migrate.c:1996 [inline]
 migrate_pages+0x1bcc/0x2930 mm/migrate.c:2105
 compact_zone+0x23e1/0x4ab0 mm/compaction.c:2647
 compact_node+0x1d2/0x280 mm/compaction.c:2916
 kcompactd+0xbc8/0x1290 mm/compaction.c:3214
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 30 tgid 30 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 __folio_put+0x21b/0x2c0 mm/swap.c:112
 migrate_folio_move mm/migrate.c:1409 [inline]
 migrate_folios_move mm/migrate.c:1719 [inline]
 migrate_pages_batch+0x227f/0x35c0 mm/migrate.c:1966
 migrate_pages_sync mm/migrate.c:1996 [inline]
 migrate_pages+0x1bcc/0x2930 mm/migrate.c:2105
 compact_zone+0x23e1/0x4ab0 mm/compaction.c:2647
 compact_node+0x1d2/0x280 mm/compaction.c:2916
 kcompactd+0xbc8/0x1290 mm/compaction.c:3214
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888041c23d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888041c23d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888041c23e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff888041c23e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888041c23f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d8f2e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ec3f12580000


