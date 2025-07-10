Return-Path: <linux-kernel+bounces-725394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48159AFFE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5E81C23E38
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6492D3EFC;
	Thu, 10 Jul 2025 09:48:30 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9672D59E2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140910; cv=none; b=F+OWLki8Gb1eSu2SA6JyG8mnCrIOTtZq1mxhW1L2tUlDE+rhSDbkpQbbpQ4Pa3+csVVCCYJcLp2QeierNMhfYaXf06aML/Z+ihfRVOyWpRvIeOy/XDstVQnAD+VetI2A3ckeT8Dq3XZH4idRagHvtFhvRTX7L38n4dSx1U33agE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140910; c=relaxed/simple;
	bh=wua15EXatrBk9R6iK5XMpx7VDAhdWc7lVkWDizjVrSM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T83gMW0Dh0EK9vs8aZL210anwx2UkQFaxkFsG4gd8xpkZPMfZP2aSgCr2eC2M00iqbmS9gtRYv39TLp7+VdNyVYOcRY0/jSNX4DWMWNBJXnzCRSVFjYeAvnEwZ2JVfvYKt+845aWbSEBnJtsE5s81bduZ1lZLLwxoOMT2253ook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3df6030ea24so7795795ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752140908; x=1752745708;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Th7Zhin8QPUH3N06DLsdoISRDrdM3Ozfgu5cmTbMOjo=;
        b=uFemyslu9BVXVG3GRDhPsFmWwT4IebPkA8opqP0V5jZI/iV89sbNE+TGkFr42qDST6
         O4HQU1JOxGBR/yQfNUZ238OonI3CNU4T94xBBiLrQ7JW2bge2QxLkLqotBQ67rXlzppG
         KPJVR9HBFx5i3O7t/x/ME6xB+ibtLdPABncJjQ6v6JKl1hXkdUGlIoeQMEvtJ1zN98Mm
         NVwUyrirsYkRh3CpPhsDAoYr13Yy36uWxjQBM6oxdt8M8kYRT8uez11CZOI9wB8st806
         +swd2GLirBVUxUL7V6z473F7IsfHB+fquEBeqsAy7CRIxtujp/sIaM36CBRCD9vMxB+Q
         +c7w==
X-Forwarded-Encrypted: i=1; AJvYcCWOEXbQL4TBlxmuiNIc6/mVZPO7fQSA107d4YXQu0Gknqq/xWBEKRj7+FEVtl1P+vmno329qSn+Bfy9Gv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJOiGL3Py2gus3bCcUNLZfQ3gHoYlJEP5FB7fZ+1IAaI8pLxU7
	dfsGJBiXks4fRf5GrW7V4w+gMepCOMlV2RDZzwENyxJMMC/sBTO/iW3pCtLROvxJ/dU9nsqPhqZ
	nu0XalrfmwKVk63sKJ5umphqRHPtCkPSSyg6VHfywN1c2el/RVNsFAPU/EMM=
X-Google-Smtp-Source: AGHT+IHIwms0CBlclfEP762gb3HSmOTXv+nfCV7EKukKEdvS5ODM4IecXCP+5KGxqYRP+I3iJhND3FNZ2XHx/rEJ0dfHFloWlJQL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3192:b0:3dd:d1bc:f08c with SMTP id
 e9e14a558f8ab-3e1670fe7f6mr68367135ab.20.1752140907815; Thu, 10 Jul 2025
 02:48:27 -0700 (PDT)
Date: Thu, 10 Jul 2025 02:48:27 -0700
In-Reply-To: <686a8143.a00a0220.c7b3.005b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686f8c6b.a00a0220.26a83e.000e.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in bdev_getblk
From: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jfs-discussion@lists.sourceforge.net, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    835244aba90d Add linux-next specific files for 20250709
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10535a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8396fd456733c122
dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c40f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11856a8c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e5c5711c47f9/disk-835244ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd2453f9f672/vmlinux-835244ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a81cc03651e7/bzImage-835244ab.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e3888e058fbc/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=12856a8c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: fs/buffer.c:1125 at __getblk_slow fs/buffer.c:1125 [inline], CPU#0: syz-executor261/5880
WARNING: fs/buffer.c:1125 at bdev_getblk+0x580/0x660 fs/buffer.c:1461, CPU#0: syz-executor261/5880
Modules linked in:
CPU: 0 UID: 0 PID: 5880 Comm: syz-executor261 Not tainted 6.16.0-rc5-next-20250709-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__getblk_slow fs/buffer.c:1125 [inline]
RIP: 0010:bdev_getblk+0x580/0x660 fs/buffer.c:1461
Code: 26 fb ff ff e8 81 ee 78 ff 48 c7 c7 20 08 9a 8b 48 c7 c6 02 1b a0 8d 4c 89 fa 4c 89 e9 e8 38 d7 e0 fe eb bd e8 61 ee 78 ff 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 41 80 3c 07 00 74 08 48 89
RSP: 0018:ffffc9000403f620 EFLAGS: 00010293
RAX: ffffffff8246c6ff RBX: ffff888022d0b998 RCX: ffff888078b31e00
RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000000
RBP: 0000000000000400 R08: ffff888078b31e00 R09: 0000000000000003
R10: 0000000000000406 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888022d0b980 R14: 0000000000000400 R15: 1ffff110045a1733
FS:  000055558d712380(0000) GS:ffff888125bd4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5b0e5d6000 CR3: 00000000227ea000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_sb_breadahead_unmovable+0x6f/0xf0 fs/ext4/super.c:270
 __ext4_get_inode_loc+0xcc9/0x1040 fs/ext4/inode.c:4879
 __ext4_get_inode_loc_noinmem fs/ext4/inode.c:4909 [inline]
 __ext4_iget+0x450/0x4260 fs/ext4/inode.c:5168
 __ext4_fill_super fs/ext4/super.c:5500 [inline]
 ext4_fill_super+0x4592/0x6080 fs/ext4/super.c:5724
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1681
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f457044b7da
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd924f6f58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd924f6f70 RCX: 00007f457044b7da
RDX: 0000200000000040 RSI: 0000200000000000 RDI: 00007ffd924f6f70
RBP: 0000200000000000 R08: 00007ffd924f6fb0 R09: 00007ffd924f6fb0
R10: 000000000000088e R11: 0000000000000246 R12: 0000200000000040
R13: 00007ffd924f6fb0 R14: 0000000000000003 R15: 000000000000088e
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

