Return-Path: <linux-kernel+bounces-835387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12518BA6F71
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961FC7A50AA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D222D8375;
	Sun, 28 Sep 2025 10:54:29 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63742D4813
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759056868; cv=none; b=vBRl2DAXMqVotesSawSGiUv5bpbGOh1rTihy9DQXfYeVUXhGaTLEhvr6h0r+q5Wt2ZqQu5tbsh53fLY2gFQr0sSy44DBG5TOCc2EZUaShzSnz4B/nv12POieH6Fc2SSKng3VQEsxFkzBdNQCUD8sXB/cN1Hhyv4MZk+MjRtNW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759056868; c=relaxed/simple;
	bh=A9zRhQtNo8Re/2JNSAP8Kfhz8tWPbrgh6vubwD0r28o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iElvcPaxzz198/UlRFGnF2thTBLBGf2GwuL295PLQMIebwnFtc4eqLA4JpAIfcbv8pu5pd0sors8vhaqXetssMEGz5pDgPRXch4SivaBVlKmZL6rQJse1u52nz0YJ/oaKWjBt7xpIVF5pgpWh0FYT6RtnBa/f5/ZcvqhXtESt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42628f7c151so74354025ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759056866; x=1759661666;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sG7EmFMTWYKDYn47cpx5DkN1WXCeji+FBkhG0W1ANI4=;
        b=tTA85id6to2XKjfHVbvj6WWlk7VkMBg4C8VcX3r/75mW00Z14m/tdhnNvWSz08OXpa
         /ohfiLRcUjIiS0j2Lrlq3ZaHy7gfsBbTtQS+R1E6tdkIDSoGkbvPIMF4HHbuhe/tl8jG
         JXDk9akE6yg61t9Cg3V0qzcO/5mdxtfUkzXv15fto0fHC3SRNZ/wW9JjAqeaqRN5a7cq
         e8iCwsXYgin4MnioGD7HJP8FFJmFRziRFg3VD4up4zzefao+qlRZZCtc/LQpmMZdnURm
         nhEAKe+uzVtgMDawc713UC74PSdxAzaPTAXeqmrPPhWXD0lwzR1N7t7CaY9qzoGjllDd
         exUA==
X-Forwarded-Encrypted: i=1; AJvYcCXv+O+Ef+pZW4rDOE5OXxXqnYZGwVKx64ZVO6ZWuiY92m9+Miy02KuvNvCZZsVPqZVlsXvwvZUDpqwmdq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyD52TyJnM6cB7wzUMhXhpAjuC5G6FHDobngwKJKI+m4Y49Qf7
	s9vZyIVqHj+MHmqg2UBYzzoN45fwHRWhPGQibf0uNBPLmlwyLkL8Ao3iZg+N8pG0naCUsrKhMpc
	hgEtR4tPaMR6HCpFgHuXl4HH5PppGo7HaGzpHAkaYrhYDEX7DaAcLn/TCn30=
X-Google-Smtp-Source: AGHT+IFYZyy3wMIfr0fNK5H4tGggpCjBuCkn4KATXqg+rhPMm+Y8RwQXdAYZiP3Qltsglm0R0GERFEdVGB3okV3Uvl/d9ee2JaRq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c0c4:0:b0:424:85b0:e1cb with SMTP id
 e9e14a558f8ab-42595644bb4mr90731585ab.31.1759056865991; Sun, 28 Sep 2025
 03:54:25 -0700 (PDT)
Date: Sun, 28 Sep 2025 03:54:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d913e1.050a0220.1696c6.0003.GAE@google.com>
Subject: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    51a24b7deaae Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1531fd34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14263f12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a8f142580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-51a24b7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d2422223a2d/vmlinux-51a24b7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f33b7e0feca/bzImage-51a24b7d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8f3233dafc3f/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=16b3aae2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com

On-disk corruption discovered. Please run fsck.ocfs2 once the filesystem is unmounted.
OCFS2: File system is now read-only.
(syz.0.17,5501,0):ocfs2_find_entry_dx:1037 ERROR: status = -30
==================================================================
BUG: KASAN: use-after-free in ocfs2_dx_dir_lookup_rec+0x1eb/0x7f0 fs/ocfs2/dir.c:813
Read of size 4 at addr ffff88804cddc2c0 by task syz.0.17/5501

CPU: 0 UID: 0 PID: 5501 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ocfs2_dx_dir_lookup_rec+0x1eb/0x7f0 fs/ocfs2/dir.c:813
 ocfs2_dx_dir_lookup+0xdb/0x520 fs/ocfs2/dir.c:868
 ocfs2_dx_dir_search fs/ocfs2/dir.c:928 [inline]
 ocfs2_find_entry_dx fs/ocfs2/dir.c:1042 [inline]
 ocfs2_find_entry+0x1004/0x2000 fs/ocfs2/dir.c:1079
 ocfs2_check_dir_for_entry+0x14c/0x3f0 fs/ocfs2/dir.c:2048
 ocfs2_mknod+0x697/0x2050 fs/ocfs2/namei.c:291
 ocfs2_create+0x1a5/0x440 fs/ocfs2/namei.c:676
 lookup_open fs/namei.c:3708 [inline]
 open_last_lookups fs/namei.c:3807 [inline]
 path_openat+0x14f4/0x3830 fs/namei.c:4043
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f01a478eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe14ee92e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f01a49e5fa0 RCX: 00007f01a478eec9
RDX: 0000000000105042 RSI: 0000200000000080 RDI: ffffffffffffff9c
RBP: 00007f01a4811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001ff R11: 0000000000000246 R12: 0000000000000000
R13: 00007f01a49e5fa0 R14: 00007f01a49e5fa0 R15: 0000000000000004
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7f45e8d66 pfn:0x4cddc
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001337748 ffffea00013376c8 0000000000000000
raw: 00000007f45e8d66 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 5347, tgid 5347 (syz-executor), ts 83789570758, free_ts 89515838215
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
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5347 tgid 5347 stack trace:
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
 vms_clear_ptes+0x42c/0x540 mm/vma.c:1235
 vms_complete_munmap_vmas+0x206/0x8a0 mm/vma.c:1277
 do_vmi_align_munmap+0x358/0x420 mm/vma.c:1536
 do_vmi_munmap+0x253/0x2e0 mm/vma.c:1584
 __vm_munmap+0x23b/0x3d0 mm/vma.c:3155
 __do_sys_munmap mm/mmap.c:1080 [inline]
 __se_sys_munmap mm/mmap.c:1077 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1077
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804cddc180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804cddc200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88804cddc280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                           ^
 ffff88804cddc300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804cddc380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

