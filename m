Return-Path: <linux-kernel+bounces-816265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCC7B571AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E8717B3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F412D5C86;
	Mon, 15 Sep 2025 07:39:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0842C0271
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921973; cv=none; b=CqxddHE7Te4hnL/RZUJiPACM55dA3UqXnxfY+dIGDLs5jzEf0TlD4Ig4+vyQ6x7FAkvjoQzaPV+mg29M0JoXK5gr5W+0LIKOOvx/HiWMiZTwm30RNXlomCA2Hy4AxPbuSN0+6JPm1hNs37Sbv5wWGK2/Wr1X8vjWp9kx/TZoqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921973; c=relaxed/simple;
	bh=6GBWyLW0UVwHsfuLbvq8Rru0VRWBE9R4rx6QUfQex0U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tByPX0pAyU+D3WY5mCqUGTQ2D7nClJ9GrnXq8cwltHU0OG7XjFhlX9UOWzAxRgbXUJpnEASSZ0lC2OiIg0tMbp9tOk6Sf8zpOgZyGdtnnXSighPbMscXTUHnkZiVhPjEv4dg86gP1Lt4fuIWEqumVqc8F1ke5EXH2jaEzOBdVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42404bb4284so9466215ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757921971; x=1758526771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dySGFBgkjVikd0fQbO38RWU4Co2WfmuOPRpUI/qZ7rY=;
        b=XtxoYzPPMDAylIlS4dD5dTiDn01LEuznVMewb7PI72xlGnubXL9e4+p7Gd4K7lpVWY
         nNAqceO0kPpSFA4tR612Aa40/PpzNHhGI8Zvis/rysNvBTL8hjbWChQ0dfDYQjHbWhy5
         1Y1lq38RMST6GCaalq/lZrRR68Mjry1sIHGQnGpbNaP5Eo18MAedNAXdjg2BA0ivwA/Z
         rlQAUKdrA7IgWnjyd6qv92KYleHNKqnCJLqE+K+LNNSuYtOi9M79rnlkQWu2xk0LsHUy
         D0X/inK1Kpp8VyPTaHSpH9CUqffPHRnOEzjSfZ5KcbpSyYKlwRncHoUCEgNTWjIiZ5y+
         5dBw==
X-Forwarded-Encrypted: i=1; AJvYcCV9cEv7ZPmwIam+7cs0VJBpB7XylY1Echey9saIWWpWBWQ9ke60QI5AXRRTFvbSFcHHW0ACjvOyhvzKu7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZWEb8oUFpxQ0Nl/Cvq1oB4nngLYVFjM7Qui0Uv7KsJEaAbOf
	eFuRjmiXEVyl1fK9n8rDhcskjIkWZpCkOZqQbY5vQ3pK1vT/NfNvICIPDXgZMMW6sHOdjeP9N1A
	iYmlyzcYuQytPoWIK6s7V0o7nQ/Z4lbt5+k7UYij2EcKhJZbRcLeFGX3XJVg=
X-Google-Smtp-Source: AGHT+IFdD8J1/tqennnnYbtE6aacxehX04c8H9Jsk4npPASwTOfAeBWIMgByP67zeYFcRb+dBaZUY3fTma0MjIalYfWiA8NPZ/2e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:423:f9af:b8c9 with SMTP id
 e9e14a558f8ab-423f9afbb98mr49790265ab.18.1757921971229; Mon, 15 Sep 2025
 00:39:31 -0700 (PDT)
Date: Mon, 15 Sep 2025 00:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c7c2b3.050a0220.3c6139.0d0d.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in ext4_mb_load_buddy_gfp
From: syzbot <syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f20375f5b7 Merge tag 'pci-v6.17-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1252eb62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154ed642580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17af7362580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-22f20375.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecd89a64f115/vmlinux-22f20375.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73fd42b48d3c/bzImage-22f20375.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/3c9e74db5034/mount_6.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=114ed642580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/1c25a03fc55a/mount_8.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13af7362580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5744 at mm/page_alloc.c:4630 __alloc_pages_slowpath+0xca5/0xce0 mm/page_alloc.c:4630
Modules linked in:
CPU: 0 UID: 0 PID: 5744 Comm: syz.5.31 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_pages_slowpath+0xca5/0xce0 mm/page_alloc.c:4630
Code: 48 8b 1c 25 08 60 a1 92 48 83 c3 2c 48 89 d8 48 c1 e8 03 0f b6 04 08 84 c0 75 2e f6 43 01 08 48 8b 14 24 0f 84 a2 f3 ff ff 90 <0f> 0b 90 e9 99 f3 ff ff e8 1e 55 64 09 90 0f 0b 90 f7 c5 00 04 00
RSP: 0018:ffffc9000d656050 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff888000bba46c RCX: dffffc0000000000
RDX: ffffc9000d656160 RSI: 0000000000000000 RDI: 0000000000048c40
RBP: 0000000000048c40 R08: ffff88801b2f30cf R09: 1ffff1100365e619
R10: dffffc0000000000 R11: ffffed100365e61a R12: ffffc9000d656160
R13: 1ffff92001acac28 R14: 0000000000048c40 R15: dffffc0000000000
FS:  00007f7ccbb366c0(0000) GS:ffff88808d20a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94b93a8638 CR3: 0000000042c26000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:5161
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
 alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2507
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2517
 filemap_alloc_folio_noprof+0xdf/0x470 mm/filemap.c:1007
 __filemap_get_folio+0x3f2/0xaf0 mm/filemap.c:1981
 ext4_mb_load_buddy_gfp+0x281/0xeb0 fs/ext4/mballoc.c:1709
 ext4_discard_preallocations+0x66b/0xec0 fs/ext4/mballoc.c:5660
 ext4_clear_inode+0x40/0x1c0 fs/ext4/super.c:1503
 ext4_evict_inode+0xa67/0xee0 fs/ext4/inode.c:321
 evict+0x504/0x9c0 fs/inode.c:810
 dispose_list fs/inode.c:852 [inline]
 prune_icache_sb+0x21b/0x2c0 fs/inode.c:1000
 super_cache_scan+0x39b/0x4b0 fs/super.c:224
 do_shrink_slab+0x6ef/0x1110 mm/shrinker.c:437
 shrink_slab_memcg mm/shrinker.c:550 [inline]
 shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
 shrink_one+0x28a/0x7c0 mm/vmscan.c:4954
 shrink_many mm/vmscan.c:5015 [inline]
 lru_gen_shrink_node mm/vmscan.c:5093 [inline]
 shrink_node+0x314e/0x3760 mm/vmscan.c:6078
 shrink_zones mm/vmscan.c:6336 [inline]
 do_try_to_free_pages+0x668/0x1960 mm/vmscan.c:6398
 try_to_free_pages+0x8a2/0xdd0 mm/vmscan.c:6644
 __perform_reclaim mm/page_alloc.c:4310 [inline]
 __alloc_pages_direct_reclaim+0x144/0x300 mm/page_alloc.c:4332
 __alloc_pages_slowpath+0x5ff/0xce0 mm/page_alloc.c:4781
 __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:5161
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
 faultin_page mm/gup.c:1144 [inline]
 __get_user_pages+0x1699/0x2ce0 mm/gup.c:1446
 __get_user_pages_locked mm/gup.c:1712 [inline]
 faultin_page_range+0x240/0x8d0 mm/gup.c:1932
 madvise_populate mm/madvise.c:979 [inline]
 madvise_do_behavior+0x2e7/0x550 mm/madvise.c:1883
 do_madvise+0x1bc/0x270 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __x64_sys_madvise+0xa7/0xc0 mm/madvise.c:1985
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7ccad8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7ccbb36038 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f7ccafd5fa0 RCX: 00007f7ccad8eba9
RDX: 0000000000000017 RSI: 0000000000c00000 RDI: 0000200000000000
RBP: 00007f7ccae11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7ccafd6038 R14: 00007f7ccafd5fa0 R15: 00007ffd394e0938
 </TASK>


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

