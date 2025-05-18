Return-Path: <linux-kernel+bounces-652530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EAABACDD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 01:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EB43AC59E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 May 2025 23:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597491EB5CE;
	Sat, 17 May 2025 23:36:36 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561F19E826
	for <linux-kernel@vger.kernel.org>; Sat, 17 May 2025 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747524995; cv=none; b=eeAYIdw2uarei40lVTBsPNMcERRNtnnjMPHuDKQqqfuZTCBoJ5wyv9UjbY5ov+4nrKXVpxMTkQdp29zQRX+dVnVTSGA0T1tFLjtFjGwIkbhegw6m9HH+3Ph1qrU8rHKft6ZGxinpXnH47DDdShdqgGTWSvCLzlTa9IjtizyHlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747524995; c=relaxed/simple;
	bh=CkyKFVfEWGqajmNtGkyDlxulELBRaHkYaZtEF9uWPbQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vEO/BFqD/cn9U4q3EfXsNjB+zhocGgYKz+R7VZtta/zvK7q3I7wXuq9ujLaCawL6fD9HHBkk7kensV2/abpZgEy1TNj66DhjRqPssoiXseCFjDHzmix54i+8AfbQoEBjyBOb0iJpGD1o6KqC+RfsSZZLLHjB8+TQPjudXwQdOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3db846bc020so24639495ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 May 2025 16:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747524993; x=1748129793;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mm1rzRRr2gYxXOshQVLHGoaUSHj4swFtoJiT6tOTaMY=;
        b=XGddS4fE0RROCiCUMQfL7/QSp6Y5vWPkjPUhwT8l/Ah7wvrCZP41ya2T3H39Wmuyzb
         /rI+7H+7mO0mvyaJi0MYP1qVFkFHU6cVcBGoo1GoCDy52cIBwlflhcD7DJwVAN7/YrBb
         4C0E+G/h5HbMzrGtklgmvI/frco0uPUaBVT3QIhKWeuT6XLd1Ll8DmBCEPCkn1iJvh/l
         BgpPbMvA+BjDAAm0f4NVWK68tCI4D+GNexBdicWIPtG98ljCACB1u3IFo763Q2Sc/SgM
         4Tv3+wMVOgiyyFP0+jjA0LEhuoSmkFof8hkgi+XdhvEnLkT8sewzr4NfgD+94obNHcqg
         c3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUquO+QzH5n/8s+Nj87KP4gWZd0H7dmVV0VsOPIAu6rN8nkxrrbYZqISqOC75LVMgaeB/Ay41yHrxytkqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1ha+0QNhbng5RFXXSK8tXp0g6u8wb8ARaOcCzJhMRsMbD3/G
	ftGFwYZhDz8p/t1yrLuo1SccPDZ7DKMsncYHzLZ3IcvHzBWgc6cPZfOx8wNCYNPX+9VcJs5RqTI
	ortC1XqE+HHu/9IKMNeHdwHX4G9//RBiBx9XbnlqYPLEb5M7k9MLc3gcMKiE=
X-Google-Smtp-Source: AGHT+IElA54x3wxZVeYXSDAcJnJ+iwWppNTnrVix9StPvIxMwtWB+axwbW1pKsDRQ5FSummo/wJkiwS6XbdPVHhuNkzx22VSJNss
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1489:b0:3d8:1d7c:e197 with SMTP id
 e9e14a558f8ab-3db842fe965mr89253815ab.7.1747524993430; Sat, 17 May 2025
 16:36:33 -0700 (PDT)
Date: Sat, 17 May 2025 16:36:33 -0700
In-Reply-To: <67ffed34.050a0220.5cdb3.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68291d81.a00a0220.398d88.02b3.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_alloc_sectors_start_trans
 (2)
From: syzbot <syzbot+2caec1f3fc52004d4f3c@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    172a9d94339c Merge tag '6.15-rc6-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e62d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56e29fa09e87dea7
dashboard link: https://syzkaller.appspot.com/bug?extid=2caec1f3fc52004d4f3c
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15114ef4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da9615d2ee0b/disk-172a9d94.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/997b6c928374/vmlinux-172a9d94.xz
kernel image: https://storage.googleapis.com/syzbot-assets/30f01bdce820/bzImage-172a9d94.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/eb7c6f2d77bd/mount_5.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2caec1f3fc52004d4f3c@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __writepoint_find fs/bcachefs/alloc_foreground.c:1171 [inline]
BUG: KMSAN: uninit-value in writepoint_find fs/bcachefs/alloc_foreground.c:1248 [inline]
BUG: KMSAN: uninit-value in bch2_alloc_sectors_start_trans+0x4d0/0x3630 fs/bcachefs/alloc_foreground.c:1348
 __writepoint_find fs/bcachefs/alloc_foreground.c:1171 [inline]
 writepoint_find fs/bcachefs/alloc_foreground.c:1248 [inline]
 bch2_alloc_sectors_start_trans+0x4d0/0x3630 fs/bcachefs/alloc_foreground.c:1348
 __bch2_write+0x802/0x6bf0 fs/bcachefs/io_write.c:1515
 bch2_write+0xe9f/0x1690 fs/bcachefs/io_write.c:1702
 closure_queue include/linux/closure.h:270 [inline]
 closure_call include/linux/closure.h:432 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:494 [inline]
 bch2_writepages+0x22d/0x430 fs/bcachefs/fs-io-buffered.c:677
 do_writepages+0x448/0xcb0 mm/page-writeback.c:2656
 __writeback_single_inode+0x101/0x1190 fs/fs-writeback.c:1680
 writeback_sb_inodes+0xaa9/0x1c90 fs/fs-writeback.c:1976
 wb_writeback+0x4ce/0xc00 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x397/0x1910 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb97/0x1d90 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd59/0xf00 kernel/kthread.c:464
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 bch2_writepage_io_alloc fs/bcachefs/fs-io-buffered.c:522 [inline]
 __bch2_writepage+0x2b49/0x3c70 fs/bcachefs/fs-io-buffered.c:644
 write_cache_pages+0xc8/0x270 mm/page-writeback.c:2613
 bch2_writepages+0x121/0x430 fs/bcachefs/fs-io-buffered.c:675
 do_writepages+0x448/0xcb0 mm/page-writeback.c:2656
 __writeback_single_inode+0x101/0x1190 fs/fs-writeback.c:1680
 writeback_sb_inodes+0xaa9/0x1c90 fs/fs-writeback.c:1976
 wb_writeback+0x4ce/0xc00 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x397/0x1910 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb97/0x1d90 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd59/0xf00 kernel/kthread.c:464
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4153 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 kmem_cache_alloc_lru_noprof+0x822/0xed0 mm/slub.c:4215
 __bch2_new_inode+0x9b/0x4b0 fs/bcachefs/fs.c:457
 bch2_new_inode fs/bcachefs/fs.c:483 [inline]
 bch2_inode_hash_init_insert+0x82/0x3c0 fs/bcachefs/fs.c:503
 bch2_vfs_inode_get+0x565/0x710 fs/bcachefs/fs.c:526
 bch2_fs_get_tree+0x1dde/0x2820 fs/bcachefs/fs.c:2576
 vfs_get_tree+0xb0/0x5c0 fs/super.c:1759
 do_new_mount+0x738/0x1610 fs/namespace.c:3881
 path_mount+0x6db/0x1e90 fs/namespace.c:4208
 do_mount fs/namespace.c:4221 [inline]
 __do_sys_mount fs/namespace.c:4432 [inline]
 __se_sys_mount+0x6eb/0x7d0 fs/namespace.c:4409
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4409
 x64_sys_call+0xfa7/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5972 Comm: kworker/u8:4 Not tainted 6.15.0-rc6-syzkaller-00278-g172a9d94339c #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: writeback wb_workfn (flush-bcachefs-17)
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

