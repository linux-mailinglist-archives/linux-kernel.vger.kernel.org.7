Return-Path: <linux-kernel+bounces-891883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9859FC43B88
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 11:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6951888FA2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D428489E;
	Sun,  9 Nov 2025 10:15:36 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748103D76
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762683336; cv=none; b=bPDxPBG0HdBvnVpvrdZ1AusVpBSBiqJ7UMf4LzTJfYT7ZIm9YTIN/EeXv71MAuxs1REm1HoTStIMUPtTeN8yKnuiqJNX5KTfp+0i7+/XhlaHxOjSBDxeA4EyPZF0ylaZSoLAOMhP4ZYxCsIFUUuxyIdPECXj7NqOYzj5HwTzzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762683336; c=relaxed/simple;
	bh=q/qbJWFfFE5P6vG0JPZ59MczMNUFyCKYvENiFok2S2U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VkIRTqzLyY3rKqWdinTcRA7tSONAdQVxVBH75RHLVCQjjXfD5yWo4PCj/e9BArHJIiJyderuMe9mBAlkipzPPIpMg+cuzJlHdqoOM7BAsFf0PusdeyCEBdh75aYcQVPpGf/fmZZ5fsloiTUuzl+dQYTAdGSiSfHYTlZeME58WS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-433312ee468so22102405ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 02:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762683333; x=1763288133;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWfewmnudh1KlyEWNvuVvB5Kgj50o7QInWoa1pVfLis=;
        b=h/iGUAWXvHcw4UoxgB2fUUXw+q20qWVnPY+gzX6YtHzCqLJdK0/MrAWsn9v06P7Gj1
         vRIbQw/Ycz8ZK3FK8KhOsEZB2HQ2hvnqyLiAgHqK5T/j3uKaI3DNbsgJUglusJzTUhNQ
         1oCxzBoSq3z569sU9i4nX6xwxCfy69i6guLeao7HHaedKNoomauClGLjFceFdOyB7v40
         u8dr2EzizAP9IjeDVr4dKrFUo/Xjh1KasdMbB2LU20wyxyxZA3/LfOLJFWjFeMXRdOL+
         FT8iOHEZBhQl6YOzdts0Kgfgrka3Nlq2nenvgT6yJHEHuVNzxTXEqOVDi2UZhBkRWXHT
         0gWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdW23Abwf1LQ6i5MvIT89Hbr33ij281sAko5OgitoNscouKMJvmxoUbdP+E95rjYVkLwyZsjhHdVSFIZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0zu5O8SvepgFPpM2NfCFkUsCsswBYswiIff4lpLtBWviATkn
	0mirJNXhVp0D6L39kSmoRdgZI3cqD3fmbpdFXKHvl0wj1TdS0/FFxofJXjnLKGzE9N2RDYnzaIh
	VaG+tg5w4PFm71e8jhARChANwfirnpI2HtAXOQ1pRpJHwWWn8CDVZDRUaN+w=
X-Google-Smtp-Source: AGHT+IEbcKnfSa5fRGJI6MUUWScp8I9DxMyTDf8/KLrLsOwjjl8LC6bhITS7iNJ8+amgcbqzNaoHjpmnfLUcajxKRTAphhZ1AsKm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:433:43fb:37dd with SMTP id
 e9e14a558f8ab-43367de214emr71758115ab.5.1762683333724; Sun, 09 Nov 2025
 02:15:33 -0800 (PST)
Date: Sun, 09 Nov 2025 02:15:33 -0800
In-Reply-To: <68fc0765.a00a0220.9662e.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691069c5.a70a0220.22f260.00aa.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in get_data
From: syzbot <syzbot+f5d91b1897d5b094c6b4@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, chao@kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9c0826a5d9aa Add linux-next specific files for 20251107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11c44b42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2ebeee52bf052b8
dashboard link: https://syzkaller.appspot.com/bug?extid=f5d91b1897d5b094c6b4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16263084580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14496a92580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32b5c04a0baa/disk-9c0826a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9438206c142a/vmlinux-9c0826a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/129cd0208baa/bzImage-9c0826a5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/be89fc48acf0/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5d91b1897d5b094c6b4@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (1024) and media sector size (512).
------------[ cut here ]------------
WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278, CPU#1: syz.0.541/6553
Modules linked in:
CPU: 1 UID: 0 PID: 6553 Comm: syz.0.541 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 87 47 1f 00 90 <0f> 0b 90 eb 05 e8 7c 47 1f 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
RSP: 0018:ffffc9000c0eec40 EFLAGS: 00010293
RAX: ffffffff81a238a9 RBX: 00003fffffffffff RCX: ffff888026123d00
RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
RBP: 0000000000000012 R08: 0000000000000f4d R09: 0000003b6994bf6b
R10: 0000003b6994bf6b R11: 0000199962000021 R12: 0000000000000012
R13: 0000000000000000 R14: ffffc9000c0eed88 R15: 1ffffffff1bca6c2
FS:  000055557ac66500(0000) GS:ffff888125fc2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffec7fad000 CR3: 000000002ea20000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 copy_data kernel/printk/printk_ringbuffer.c:1857 [inline]
 prb_read kernel/printk/printk_ringbuffer.c:1966 [inline]
 _prb_read_valid+0x672/0xa90 kernel/printk/printk_ringbuffer.c:2143
 prb_read_valid+0x3c/0x60 kernel/printk/printk_ringbuffer.c:2215
 printk_get_next_message+0x15c/0x7b0 kernel/printk/printk.c:2978
 console_emit_next_record kernel/printk/printk.c:3062 [inline]
 console_flush_one_record kernel/printk/printk.c:3194 [inline]
 console_flush_all+0x4cc/0xb10 kernel/printk/printk.c:3268
 __console_flush_and_unlock kernel/printk/printk.c:3298 [inline]
 console_unlock+0xbb/0x190 kernel/printk/printk.c:3338
 vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 ntfs_inode_printk+0x5fd/0x700 fs/ntfs3/super.c:156
 ntfs_bad_inode+0x71/0x150 fs/ntfs3/fsntfs.c:910
 mi_enum_attr+0x7b9/0x9f0 fs/ntfs3/record.c:352
 ntfs_read_mft fs/ntfs3/inode.c:123 [inline]
 ntfs_iget5+0x245b/0x3860 fs/ntfs3/inode.c:542
 ntfs_fill_super+0x23ce/0x43d0 fs/ntfs3/super.c:1284
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x92/0x2b0 fs/super.c:1752
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3641 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3717
 do_mount fs/namespace.c:4040 [inline]
 __do_sys_mount fs/namespace.c:4228 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4205
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6530f90e6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec7fac3c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffec7fac450 RCX: 00007f6530f90e6a
RDX: 00002000000002c0 RSI: 0000200000000040 RDI: 00007ffec7fac410
RBP: 00002000000002c0 R08: 00007ffec7fac450 R09: 0000000000000082
R10: 0000000000000082 R11: 0000000000000246 R12: 0000200000000040
R13: 00007ffec7fac410 R14: 000000000001f853 R15: 00002000000000c0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

