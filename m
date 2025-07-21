Return-Path: <linux-kernel+bounces-739093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90C8B0C1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A3954053E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FE61F03C5;
	Mon, 21 Jul 2025 10:46:38 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638823B29E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094798; cv=none; b=sj38QTn2vt/OKY4Ndn+NpBkZvfvQ+bWWB+Ko4tRHlMzr/5yjAIIbkJhxCb9QCe2aS9A/VxwHfwga6RpSYThmvK39ydFVF5pc6dlptludfbWr76ZawY1O/WRbr3wiAvExBkDkeoIKDwqDAy8kFCGhUZPSxWy4Bx9pKMvokSA51FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094798; c=relaxed/simple;
	bh=7MKcg4H/F+/xBrLQGGes7UheZYshMdn8Ir7ZqR3W/E8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=guGs/DYXqnwegH3Cj7aC5bTRg1BERbNcUrk6JpCgF8lHQSurCmYvBQXJz/+8VIcTQJ1QoRTVqV/WybMWDWZNTcQwYE4AdRbUooArI5XYthkM3B6UOS8IlfPrJrMv+n0EsvdjoGoz9j3Dq0hE3rV5PBXjaJn1C3B8Ro0Sn0nGzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e2a7bb1d9cso7316755ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094795; x=1753699595;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8n/U25luu3EiyWc2k9gUy4lXIT5EC9pJx9mumzbY51U=;
        b=I1ztHiiNhYhD6Au9Zh0l171lKX5P7qRMsduKQKxAbp6G6SppGTwITCUXIk8FvBINEV
         KCJK1O1LxErye+rgCwufLpMTUAlpp1tYTRMtQyUPPcd7Tyc/EWdj2DoqaVqrmhV42yAe
         7dHiqo7KCNeb5GOR2Mt/xhgYO+T201bYzThVz+eS0l8O6p9PTi8fxWmQgxYBDksCfbmd
         0xSzpxOG6bE7CcqLP6fC48DHlfBtJOAq+HcHxcmoQEBAHK2BZEDRiNZZVNoZlxQUAoxX
         96tkXCTA6TG1Gn9IkhsY889AN8y6DivZ6BFZiyV0MvcNk22diP6lRB6Cad+a4ZPv9AXb
         BTqg==
X-Forwarded-Encrypted: i=1; AJvYcCUxRvn5iM4CUpQMlTRgiSyTr3mvs3gHrQ7AlvpYoxGBJHdlXCjSOIgWSPcc919/hEZx6QEY3hzuCuLEG4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0pr8V7GURvqper7UDvVCYVyVzYu9EuaCWOUXXUX8Blu4FMW9P
	tyeZbVXe514UkPuPrYTmT7uG3j5ll/EclkGPUifwtaKwWM91fFB2f/PQBHo/IUM408JR1hSvQIM
	9jY0MI4p2gfX2/QnK1APHaK9cpMU+zfWzHdUIUeyaUZ9YzYmfgWrRb6qckj8=
X-Google-Smtp-Source: AGHT+IFg7cl4+SB46QB9tYhjZZQImWRwBTpMC6m3P9ZySXIwlP7KuTEeyzjVFVIxX0oi6S7l8poylt5g6tB4O9oNI+2WrRpzm0Q0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3047:b0:3e2:77d9:f8fc with SMTP id
 e9e14a558f8ab-3e28bdfb160mr183605185ab.10.1753094795589; Mon, 21 Jul 2025
 03:46:35 -0700 (PDT)
Date: Mon, 21 Jul 2025 03:46:35 -0700
In-Reply-To: <687c89c0.a70a0220.693ce.00b1.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687e1a8b.a70a0220.693ce.00ec.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in do_bch2_trans_commit_to_journal_replay
From: syzbot <syzbot+e3f91c76099a777cbf16@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d086c886ceb9 Add linux-next specific files for 20250718
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126b41bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc0cd9fdf69889c3
dashboard link: https://syzkaller.appspot.com/bug?extid=e3f91c76099a777cbf16
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12227722580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4435f80a19c4/disk-d086c886.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a7dc57a5ea3/vmlinux-d086c886.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da9f2dc22ae1/bzImage-d086c886.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f5e4ca95b41f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3f91c76099a777cbf16@syzkaller.appspotmail.com

  allowing incompatible features above 0.0: (unknown version)
  features: lz4,new_siphash,inline_data,new_extent_overwrite,btree_ptr_v2,new_varint,journal_no_flush,alloc_v2,extents_across_btree_nodes
bcachefs (loop0): Using encoding defined by superblock: utf8-12.1.0
bcachefs (loop0): initializing new filesystem
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_trans_commit.c:1027!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 11141 Comm: syz.0.833 Not tainted 6.16.0-rc6-next-20250718-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:do_bch2_trans_commit_to_journal_replay+0x10f3/0x1120 fs/bcachefs/btree_trans_commit.c:1027
Code: 48 c7 c1 79 7b 99 8d 49 89 c0 e8 f8 7a 2b 00 4c 89 ff e8 10 c7 0d 00 48 8b 7c 24 68 e8 d6 1b 00 00 90 0f 0b e8 4e e3 92 fd 90 <0f> 0b e8 46 e3 92 fd eb ad e8 3f e3 92 fd eb a6 e8 38 e3 92 fd 90
RSP: 0018:ffffc9000401edb8 EFLAGS: 00010293
RAX: ffffffff842ccdc2 RBX: 00000000fffff7ab RCX: ffff888030303c00
RDX: 0000000000000000 RSI: 00000000fffff7ab RDI: 0000000000000000
RBP: ffff888076024000 R08: ffff888045c049e3 R09: 1ffff11008b8093c
R10: dffffc0000000000 R11: ffffed1008b8093d R12: ffff888076024028
R13: 0000000000000000 R14: ffff8880760240d2 R15: ffff888030a90080
FS:  00007f01a1c236c0(0000) GS:ffff888125be3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff07b402150 CR3: 000000006968a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __bch2_trans_commit+0x1b13/0x8a70 fs/bcachefs/btree_trans_commit.c:1060
 bch2_trans_commit fs/bcachefs/btree_update.h:270 [inline]
 bch2_dev_usage_init+0x22c/0x3f0 fs/bcachefs/disk_accounting.c:934
 bch2_fs_initialize+0x4b5/0xe60 fs/bcachefs/recovery.c:1179
 bch2_fs_start+0xa00/0xcc0 fs/bcachefs/super.c:1217
 bch2_fs_get_tree+0xb39/0x1540 fs/bcachefs/fs.c:2456
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f01a0d9014a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f01a1c22e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f01a1c22ef0 RCX: 00007f01a0d9014a
RDX: 0000200000000140 RSI: 0000200000000100 RDI: 00007f01a1c22eb0
RBP: 0000200000000140 R08: 00007f01a1c22ef0 R09: 0000000002800000
R10: 0000000002800000 R11: 0000000000000246 R12: 0000200000000100
R13: 00007f01a1c22eb0 R14: 0000000000005a7a R15: 0000200000000340
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_bch2_trans_commit_to_journal_replay+0x10f3/0x1120 fs/bcachefs/btree_trans_commit.c:1027
Code: 48 c7 c1 79 7b 99 8d 49 89 c0 e8 f8 7a 2b 00 4c 89 ff e8 10 c7 0d 00 48 8b 7c 24 68 e8 d6 1b 00 00 90 0f 0b e8 4e e3 92 fd 90 <0f> 0b e8 46 e3 92 fd eb ad e8 3f e3 92 fd eb a6 e8 38 e3 92 fd 90
RSP: 0018:ffffc9000401edb8 EFLAGS: 00010293
RAX: ffffffff842ccdc2 RBX: 00000000fffff7ab RCX: ffff888030303c00
RDX: 0000000000000000 RSI: 00000000fffff7ab RDI: 0000000000000000
RBP: ffff888076024000 R08: ffff888045c049e3 R09: 1ffff11008b8093c
R10: dffffc0000000000 R11: ffffed1008b8093d R12: ffff888076024028
R13: 0000000000000000 R14: ffff8880760240d2 R15: ffff888030a90080
FS:  00007f01a1c236c0(0000) GS:ffff888125be3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f4c3e5000 CR3: 000000006968a000 CR4: 00000000003526f0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

