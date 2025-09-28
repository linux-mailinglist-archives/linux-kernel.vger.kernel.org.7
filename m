Return-Path: <linux-kernel+bounces-835516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E5DBA75AB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E59174323
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F372367D2;
	Sun, 28 Sep 2025 17:44:31 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1611E260A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759081470; cv=none; b=WyJoliKZRZ4+cADotw7RYT5CRT51QsLlO1yfIWYNmGLUh5tM1surz72BTHM+7xQLMnZx/1kjKCjXq/66aGLdTCAD/o+SZrwy+/3GTP+9FjduBtwrFEVze7JQLmcY1Ml+u0HuD9TINl+6fSATcyBcHx5DpNnFsmo14tiKJSIbMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759081470; c=relaxed/simple;
	bh=+jK8Ma3IpkzGke8O20X459XvV03rrNWyhCdUKlLQs24=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fqFpI3fZ7o5irYQW/OwqE8L1g4kOP2WMN5RYlA+ZS8IZhJZRO+taDsnbw2oCp+5kJojb8c0HzyZDYqxlmSeMm32NnFBTslcTlzOtfNAiougPH7mNYCVCn/i9Nl/+y3ajkAhRqrnai9j7UIz+x4GnIENHNUxL4/TSWGqPFwVq5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so45324335ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 10:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759081468; x=1759686268;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfHz+kVBBN6qxDi9w6vxoz4MHOeNlBqzhi/tIoFuRPE=;
        b=XlBXw0vHKNPpoQn5y/otRKkPvZfARFkE+ApkLT1pYEcRiT0cwy49tCMIWy23La0w67
         PnjerD02udvdQTJ/S5bN3xp94jfY3BkeGHnTMme+IVyrA+ru1VDxyv889lvXV0jB2VDX
         zcoloEmqK/oOgqloJK5ErPUoKxvY/TyQB3Jall2LdqkSs/LAsvR0XcXQ1gcyDG2w7jck
         iIAeFHDxkiVrcsx3O1D1uMPLaAa3pg/GAM4+qS3oRjPqxNGYiK5hrDKHcCTTocJyxIzq
         DKh7MeqaEt9nkgXdAYhpIl6UFkhajOfmw+XBbupXc9Cba4jKhyaa2gSIZfzXc6ME+PDc
         TvNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn940wRENEjgFRCGxLmEhyhtr6Ln4QnhRkEiNseegNIEICgdTJ3hOB4dhAXY+QiwmVTVoZKVx/cWB4ytM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznjP1AiIaPSaoUy8SYJeFD8b3f/R0BkxawQvB5h/CmFUDfjG74
	gXG0vHuV0ennGC3oHTWiN+/FMq0RgiRlkXDSvlBfbo4cbjw1fC97fyhqYqNnm9u/7GVn6ga5dhU
	7upoYSFybSNTxro2pJNp9h8myydJoV7WyqUwNgG2CVuvbaL+sxtooaFxp2OU=
X-Google-Smtp-Source: AGHT+IFMLHheYfBzpYXH2L+A8ieG9iaNLiHGhD/LJKn1x6lDumvntoi3looYvzugPONUK1RFSwCI0/btp5SXrDxyLfRc9saqMxq8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:428:c370:d972 with SMTP id
 e9e14a558f8ab-428c370dba4mr79681495ab.7.1759081468228; Sun, 28 Sep 2025
 10:44:28 -0700 (PDT)
Date: Sun, 28 Sep 2025 10:44:28 -0700
In-Reply-To: <6861c281.a70a0220.3b7e22.0ab8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d973fc.a00a0220.102ee.002b.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in xfs_init_fs_context
From: syzbot <syzbot+359a67b608de1ef72f65@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, baohua@kernel.org, 
	byungchul@sk.com, cem@kernel.org, david@fromorbit.com, david@redhat.com, 
	gourry@gourry.net, harry.yoo@oracle.com, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	matthew.brost@intel.com, mhocko@suse.com, penguin-kernel@i-love.sakura.ne.jp, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	willy@infradead.org, ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    51a24b7deaae Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1268bf12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=359a67b608de1ef72f65
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a20334580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-51a24b7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d2422223a2d/vmlinux-51a24b7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f33b7e0feca/bzImage-51a24b7d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/345ccb8f827e/mount_8.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=161e6ae2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+359a67b608de1ef72f65@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6463 at mm/page_alloc.c:4619 __alloc_pages_slowpath+0xcb3/0xce0 mm/page_alloc.c:4619
Modules linked in:
CPU: 0 UID: 0 PID: 6463 Comm: syz.0.279 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_pages_slowpath+0xcb3/0xce0 mm/page_alloc.c:4619
Code: d8 48 c1 e8 03 0f b6 04 08 84 c0 75 2e f6 43 01 08 48 8b 14 24 0f 84 a2 f3 ff ff 90 0f 0b 90 e9 99 f3 ff ff e8 3e 9e 64 09 90 <0f> 0b 90 f7 c5 00 04 00 00 75 bc 90 0f 0b 90 eb b6 89 d9 80 e1 07
RSP: 0018:ffffc9000e2ff8f0 EFLAGS: 00010246
RAX: 97af8c55b4e88b00 RBX: 0000000000000002 RCX: dffffc0000000000
RDX: ffffc9000e2ffa00 RSI: 0000000000000002 RDI: 0000000000048cc0
RBP: 0000000000048cc0 R08: ffff88805ffd7297 R09: 1ffff1100bffae52
R10: dffffc0000000000 R11: ffffed100bffae53 R12: ffffc9000e2ffa00
R13: 1ffff92001c5ff3c R14: 0000000000048cc0 R15: dffffc0000000000
FS:  00007fb4ec9696c0(0000) GS:ffff88808d007000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4ebb72b60 CR3: 00000000516af000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:5161
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0xd9/0x370 mm/slub.c:2668
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 xfs_init_fs_context+0x54/0x500 fs/xfs/xfs_super.c:2278
 alloc_fs_context+0x64e/0x7d0 fs/fs_context.c:318
 do_new_mount+0x16f/0x9e0 fs/namespace.c:3787
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb4ebb9066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb4ec968e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fb4ec968ef0 RCX: 00007fb4ebb9066a
RDX: 0000200000009600 RSI: 0000200000009640 RDI: 00007fb4ec968eb0
RBP: 0000200000009600 R08: 00007fb4ec968ef0 R09: 0000000000200800
R10: 0000000000200800 R11: 0000000000000246 R12: 0000200000009640
R13: 00007fb4ec968eb0 R14: 0000000000009644 R15: 00002000000002c0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

