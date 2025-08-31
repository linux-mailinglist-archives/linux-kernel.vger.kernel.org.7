Return-Path: <linux-kernel+bounces-793260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E131FB3D146
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B32517ECF9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 08:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1B239E75;
	Sun, 31 Aug 2025 08:03:38 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E52AD31
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756627418; cv=none; b=hff6HkbRSc6WNFdibAc9MglzJ2P8CZg+9mCXn7Fw3f1E/EwRFxPEOFeo0qcmYdtDHl94+0h5CWb0W7Ql428bYp2ngHFlIwI/3Gse/iT/qHyOJ6PNQl2gRz2itwdtptZsyfwfH8iqVG8WM4OepgT+c5WY700p1hOLVDGoghosdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756627418; c=relaxed/simple;
	bh=M0e5WbPXSn6pipf5yDojrmc/TlquJH2+YuL+w6BbqTQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GPs8xTOLiftv/3Pd+H4SeApn9QdOb6ilDQ685UAsLude1I7HbFsmWfQkUnJ5L0g95UKold305uogz3K4K+99uPKOmAP3lSlvJRkKuPSrzKRe0dHqyakuXQj4N6RBeEgDYUZWXADuLUgSZLrNcTdHb4ubEp0xTVkSnm11BasdrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3eea931c037so88635945ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756627415; x=1757232215;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFx4RHsZpPKOi6j9JvrbO6GmWcfK8WFdE3b5KFAfu0M=;
        b=jOnVU0i+6tQLg0xpOEzo8Ly64Wqje7zESSVVX1YnM7oNlpjMhiigk1Lc1sjZE71mFT
         GlgtVus6wYV0OraeNWjF4UJR575Kx+UTYsn9tm9mcqErF+ZlpVuNX2IYg2QdR422Hme0
         FkdnBEPJVXUvt2EvB4zFKLgAYgHTn1TycmuzeOHWWlDxCl1fK85qcYROO2rtBMwNm/nX
         fagp3KxOe0EUUPO5al2MSaYHNf9BQU3c9qkeqeqJ7Zz42OKpbh60YdpHATYZtQyIj0iv
         H4/V1FN5ONJXCkZi0vR1qmXxPzfcxAjgvE/7BqcYOzvZ3ElKFDwlyq+PBjPZkyNrrsI9
         rzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOD0CPWa3Re0BImYYmnXlwBMxtsxLOOhR9VKRw3cb9s31bRpmQlx4kD3K5E78WNsauT//Nn2+2fCFedFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmI9/5PfuNPF2On793NoZAOaz+KoqMbLw0xuaa1vsMQjWcPZVE
	yC+7h4Yb83tkrR6V7M+O4/4/g6q3ms9OF+N2gVkLIDsgImpVcrZXIah/aa1ky5jYsuYHokw5r83
	z2eK7smwciKdFJmnnl+8QovmwsLNiGKNsRCkEFlL5cqUdzd4t4i7k/6fftdI=
X-Google-Smtp-Source: AGHT+IFOMPYqbusZKfCaCax85hfhBNOHdlVthWhDIu+EXr2ccRdGQMldqZJ6d9KgYylWT7oKT7xZBWdeAdVM4dzNxo7tSqEb6xFU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6a:b0:3f2:1ba1:1caf with SMTP id
 e9e14a558f8ab-3f4006758e8mr97305025ab.14.1756627415725; Sun, 31 Aug 2025
 01:03:35 -0700 (PDT)
Date: Sun, 31 Aug 2025 01:03:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b401d7.a00a0220.1337b0.0031.GAE@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_do_truncate_blocks
From: syzbot <syzbot+1867a378155795cb1680@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fab1beda7597 Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b6c634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7016efe6aaa498c
dashboard link: https://syzkaller.appspot.com/bug?extid=1867a378155795cb1680
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fab1beda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07d60c58352f/vmlinux-fab1beda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6d2b98f110e/bzImage-fab1beda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1867a378155795cb1680@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 131072
F2FS-fs (loop0): QUOTA feature is enabled, so ignore qf_name
F2FS-fs (loop0): build fault injection rate: 7
F2FS-fs (loop0): build fault injection type: 0x40004
F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): inject page alloc in f2fs_grab_cache_folio of __get_meta_folio+0x157/0x4f0 fs/f2fs/checkpoint.c:77
F2FS-fs (loop0): inject page alloc in f2fs_grab_cache_folio of f2fs_ra_meta_pages+0x615/0x970 fs/f2fs/checkpoint.c:303
F2FS-fs (loop0): inject page alloc in f2fs_grab_cache_folio of f2fs_ra_meta_pages+0x615/0x970 fs/f2fs/checkpoint.c:303
F2FS-fs (loop0): inject invalid blkaddr in f2fs_is_valid_blkaddr of f2fs_ra_meta_pages+0x1cb/0x970 fs/f2fs/checkpoint.c:275
F2FS-fs (loop0): inject page alloc in f2fs_grab_cache_folio of __get_meta_folio+0x157/0x4f0 fs/f2fs/checkpoint.c:77
F2FS-fs (loop0): inject page alloc in f2fs_grab_cache_folio of __get_meta_folio+0x157/0x4f0 fs/f2fs/checkpoint.c:77
------------[ cut here ]------------
kernel BUG at fs/f2fs/file.c:824!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5364 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:f2fs_do_truncate_blocks+0x1075/0x10c0 fs/f2fs/file.c:824
Code: 27 fd 90 0f 0b e8 bb 30 bf fd 90 0f 0b e8 b3 30 bf fd 48 89 df 48 c7 c6 00 8c d1 8b e8 e4 71 27 fd 90 0f 0b e8 9c 30 bf fd 90 <0f> 0b e8 94 30 bf fd 90 0f 0b 90 e9 dd fd ff ff e8 86 30 bf fd 90
RSP: 0018:ffffc9000d387620 EFLAGS: 00010287
RAX: ffffffff84008aa4 RBX: 0000000000000003 RCX: 0000000000100000
RDX: ffffc9000e2d2000 RSI: 00000000000385b6 RDI: 00000000000385b7
RBP: ffffc9000d387740 R08: ffff888000714880 R09: 0000000000000002
R10: 00000000fffffffe R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 00000000ffff039c
FS:  00007f95562866c0(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f38293909c0 CR3: 0000000042d26000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 f2fs_truncate_blocks+0x10a/0x300 fs/f2fs/file.c:861
 f2fs_truncate+0x452/0x780 fs/f2fs/file.c:911
 f2fs_evict_inode+0x9aa/0x19c0 fs/f2fs/inode.c:897
 evict+0x501/0x9c0 fs/inode.c:810
 f2fs_fill_super+0x563c/0x6ff0 fs/f2fs/super.c:5047
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1692
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f955539038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9556285e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f9556285ef0 RCX: 00007f955539038a
RDX: 0000200000010580 RSI: 00002000000105c0 RDI: 00007f9556285eb0
RBP: 0000200000010580 R08: 00007f9556285ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000105c0
R13: 00007f9556285eb0 R14: 0000000000010595 R15: 0000200000000100
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_do_truncate_blocks+0x1075/0x10c0 fs/f2fs/file.c:824
Code: 27 fd 90 0f 0b e8 bb 30 bf fd 90 0f 0b e8 b3 30 bf fd 48 89 df 48 c7 c6 00 8c d1 8b e8 e4 71 27 fd 90 0f 0b e8 9c 30 bf fd 90 <0f> 0b e8 94 30 bf fd 90 0f 0b 90 e9 dd fd ff ff e8 86 30 bf fd 90
RSP: 0018:ffffc9000d387620 EFLAGS: 00010287
RAX: ffffffff84008aa4 RBX: 0000000000000003 RCX: 0000000000100000
RDX: ffffc9000e2d2000 RSI: 00000000000385b6 RDI: 00000000000385b7
RBP: ffffc9000d387740 R08: ffff888000714880 R09: 0000000000000002
R10: 00000000fffffffe R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 00000000ffff039c
FS:  00007f95562866c0(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f38293909c0 CR3: 0000000042d26000 CR4: 0000000000352ef0


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

