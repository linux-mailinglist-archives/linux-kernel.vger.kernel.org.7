Return-Path: <linux-kernel+bounces-607896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C431A90C10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 21:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8849619019A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C60D2248BB;
	Wed, 16 Apr 2025 19:15:40 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06C224AED
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830939; cv=none; b=tXFdqh/EIhOH/9BMYlUZVjj7fMbwmghUAoi4cmL1uG3oKUA4JmlA5QmiEZLvXHkm47p4X6j4CaK7AVRe9f05+Wbgv7mf+SS3AnMI+rr7gj0w30zwpZsuEKsZJwS6dtJtI/Nj9TMVIrDjvcvy6cEBVWPXIc7jrGqlhSkhsVG2W9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830939; c=relaxed/simple;
	bh=q553TEd7R9yQBjrZT6YjB0vHC9w9jhtO5GUiE3dhpJE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q3vFu3NtiWX0DEquFV9q8NFQDXi+BBFwCBEz4LQM/FJMX2HXLe/ONL+xbOdUkdTEIT8nB473QW1rtOouKUmRMrxdKkk82I4ZFxWgw+YFD+xm5eJsjsOsxIfmym9eNuIPo93RhQXrqkmxB6c6pFx7gyQuIY9vXYBBQeEjfFgl2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b53875729so1561251239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 12:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744830937; x=1745435737;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ilGkIWrm8F9IkU3lmN+jkExtONmYjoDsbGEG/YMG2c=;
        b=e5vUB1TYCRIm+Dz2PgUluuozNZP+ULOxASfQ2yjit7w9hQIe8ME+ciWeFdfRe2kwm7
         IJz8c0bPuu/QEIC4H/F0iUkUFY99X+5kF3Bg7lF93BZ6G73V7wrbwPhWr3Oq/+NpmW2m
         wV6gF7y51s/8x7OLcR/K7xGBEWUHsg+1trr2F9eEeGewFaSEXFvmodK0Pcg80I5EsyQG
         qiAbl47shp30IwDM6ruv7HCQnmTMxOFdB66DhglenCbJbfcSdPctRT2tk6ZRxwxfZuvL
         Hnck2AezoVsmo+71FuyUMUhsf9OaIrCzrZAXajkI5+hFrQGf86h9VkJbNB4deYRSo7L8
         KFtg==
X-Forwarded-Encrypted: i=1; AJvYcCWkC3wx/j3MG1QwMytgdi9VJ+bq2YH4Ui1yoHeECVtw7rehR80+Lko7y/UqXPvxWqLQbeCeYqAKTjpuhLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnq98aqqmd/7XsVIzZHdhz92HaHmS5+OVTZx6C9lHUcqInQX4n
	uKTjTjK2Bgk1N8xfEar3AwSEPZSz8UAOvNGm6QUcJXMb6eZMhnn7RLtZqORlZnmV3j8+dafqJGH
	AkSDWwp4EWwwk38Pqt6/2isMj1zVT6gtfdH+9JRaSYwQkhTs9cbNEpKI=
X-Google-Smtp-Source: AGHT+IGbeYfjsyEqD9ZZPU0XQFuJBFnr7Skzqjq9KiBjQK4hvKS3D5izyNg4VNIF9EHbI4Jdv09d0mY9WQzoSyf3lcWf0RNrHg3P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4415:10b0:3d5:eb10:1c3b with SMTP id
 e9e14a558f8ab-3d815af440bmr26176255ab.5.1744830936847; Wed, 16 Apr 2025
 12:15:36 -0700 (PDT)
Date: Wed, 16 Apr 2025 12:15:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680001d8.050a0220.5cdb3.0008.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_inode_update_after_write (2)
From: syzbot <syzbot+af878a66b6ed801e9515@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    834a4a689699 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1757c470580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a972ee73c2fcf8ca
dashboard link: https://syzkaller.appspot.com/bug?extid=af878a66b6ed801e9515
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-834a4a68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4454365a3050/vmlinux-834a4a68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d99dbd9f6f4/bzImage-834a4a68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af878a66b6ed801e9515@syzkaller.appspotmail.com

bcachefs (loop0): accounting_read... done
bcachefs (loop0): alloc_read... done
bcachefs (loop0): snapshots_read...
bcachefs (loop0): running explicit recovery pass reconstruct_snapshots (21), currently at snapshots_read (7)
 done
bcachefs (loop0): check_allocations...
bcachefs (loop0): btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq ac62141f8dc7e261 written 24 min_key POS_MIN durability: 1 ptr: 0:26:0 gen 0, fixing
bcachefs (loop0): bucket 0:26 data type btree ptr gen 0 missing in alloc btree
  while marking u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq ac62141f8dc7e261 written 24 min_key POS_MIN durability: 1 ptr: 0:26:0 gen 0, fixing
bcachefs (loop0): btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 7589ab5e0c11cc7a written 24 min_key POS_MIN durability: 1 ptr: 0:38:0 gen 0, fixing
bcachefs (loop0): btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 9aa2895aefce4bdf written 24 min_key POS_MIN durability: 1 ptr: 0:41:0 gen 0, fixing
bcachefs (loop0): btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq c0bef60d07ceb940 written 16 min_key POS_MIN durability: 1 ptr: 0:35:0 gen 0, fixing
bcachefs (loop0): btree ptr not marked in member info btree allocated bitmap
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq e81e1ed936acf3df written 32 min_key POS_MIN durability: 1 ptr: 0:29:0 gen 0, fixing
bcachefs (loop0): bucket 0:15 gen 0 has wrong data_type: got free, should be journal, fixing
bcachefs (loop0): bucket 0:15 gen 0 data type journal has wrong dirty_sectors: got 0, should be 256, fixing
bcachefs (loop0): bucket 0:26 gen 0 has wrong data_type: got free, should be btree, fixing
bcachefs (loop0): bucket 0:26 gen 0 data type btree has wrong dirty_sectors: got 0, should be 256, fixing
bcachefs (loop0): bucket 0:32 gen 0 has wrong data_type: got btree, should be need_discard, fixing
bcachefs (loop0): bucket 0:32 gen 0 data type need_discard has wrong dirty_sectors: got 256, should be 0, fixing
 done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay... done
bcachefs (loop0): check_lrus... done
bcachefs (loop0): check_backpointers_to_extents... done
bcachefs (loop0): check_extents_to_backpointers...
bcachefs (loop0): scanning for missing backpointers in 4/128 buckets
 done
bcachefs (loop0): reconstruct_snapshots...
bcachefs (loop0): snapshot node 4294967295 from tree 4294967295 missing, recreating
 done
bcachefs (loop0): check_inodes... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): Fixed errors, running fsck a second time to verify fs is clean
bcachefs (loop0): check_lrus... done
bcachefs (loop0): check_backpointers_to_extents... done
bcachefs (loop0): check_extents_to_backpointers...
bcachefs (loop0): scanning for missing backpointers in 1/128 buckets
 done
bcachefs (loop0): reconstruct_snapshots... done
bcachefs (loop0): check_inodes... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
kernel BUG at fs/bcachefs/fs.c:61!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5325 Comm: syz.0.0 Not tainted 6.15.0-rc2-syzkaller-00037-g834a4a689699 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_inode_update_after_write+0xc89/0xc90 fs/bcachefs/fs.c:61
Code: ff 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c cc fb ff ff 48 89 f7 49 89 f6 e8 25 5c bc fd 4c 89 f6 e9 b9 fb ff ff e8 08 23 52 fd 90 <0f> 0b e8 d0 8e bf 07 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d4d78c0 EFLAGS: 00010293
RAX: ffffffff84713228 RBX: 000000000000100c RCX: ffff888000e1c880
RDX: 0000000000000000 RSI: 000000000000100c RDI: 0000000000001002
RBP: ffffc9000d4d7a10 R08: ffffffff847126c2 R09: 00000000ffffffff
R10: 0000000000001000 R11: 00000000ffffffff R12: 0000000000001002
R13: ffff888043ff9e60 R14: ffff888043ff9e60 R15: ffffc9000d4d7b90
FS:  00007f76e17e76c0(0000) GS:ffff88808c593000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002bc0 CR3: 0000000041356000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bch2_unlink+0x459/0x520 fs/bcachefs/fs.c:818
 bch2_unlink+0xac/0xf0 fs/bcachefs/fs.c:841
 vfs_unlink+0x365/0x650 fs/namei.c:4544
 do_unlinkat+0x442/0x7b0 fs/namei.c:4608
 __do_sys_unlink fs/namei.c:4654 [inline]
 __se_sys_unlink fs/namei.c:4652 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f76e098d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f76e17e7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f76e0ba5fa0 RCX: 00007f76e098d169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000500
RBP: 00007f76e0a0e990 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f76e0ba5fa0 R15: 00007fff9e387278
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_inode_update_after_write+0xc89/0xc90 fs/bcachefs/fs.c:61
Code: ff 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c cc fb ff ff 48 89 f7 49 89 f6 e8 25 5c bc fd 4c 89 f6 e9 b9 fb ff ff e8 08 23 52 fd 90 <0f> 0b e8 d0 8e bf 07 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d4d78c0 EFLAGS: 00010293
RAX: ffffffff84713228 RBX: 000000000000100c RCX: ffff888000e1c880
RDX: 0000000000000000 RSI: 000000000000100c RDI: 0000000000001002
RBP: ffffc9000d4d7a10 R08: ffffffff847126c2 R09: 00000000ffffffff
R10: 0000000000001000 R11: 00000000ffffffff R12: 0000000000001002
R13: ffff888043ff9e60 R14: ffff888043ff9e60 R15: ffffc9000d4d7b90
FS:  00007f76e17e76c0(0000) GS:ffff88808c593000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002bc0 CR3: 0000000041356000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

