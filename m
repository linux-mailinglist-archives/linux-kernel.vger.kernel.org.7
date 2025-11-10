Return-Path: <linux-kernel+bounces-893849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84106C487E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067A01891A99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA3A31A7ED;
	Mon, 10 Nov 2025 18:09:33 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6DC314B96
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798173; cv=none; b=Zem3Awz1/TKtvA2UsOI0eyU7YzrCWbx0GaEvGxO1o3qm73seu327Xwzq7Em7Txi+FVK7rpASLEb7fzJf1vg13i6d2SrteJrK+B4tom78qA6UYe2TSF+MW6CzGmRMvKGh5vWaia1kwDr0w+Zk3pmTL4lOCCEU81WBwz2a7jIy1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798173; c=relaxed/simple;
	bh=BX+nAeNIF1g3TkXSjB13OGmoZFqYiahZuRo5NBB2WaM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oFbB2Wu7tVLsY8wNfaqrExU0VX9RX6y5CV60x068GVeMjfepRDtt2ps3+8aoh+LXdL78R5jjzCZ55jWjD/7fqy0P4D2300XJAwjVW3gZ0KJGeVOq44oBGtLbQkHCvRkPf7Ct11ae8TWebCJiV2vPFEciNsih/3dpi8oAk3NqI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-93e7f4f7bb1so296193639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762798170; x=1763402970;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ksrKuOU5FPJxqYEVZzmca7yyxRXUq9NtK9oQxoK79g=;
        b=FQSNjkhVXY5wPYdmwQxVcXuuxjA9h9F2sdTEK5P74r2Gc6BcxV9jtL/KVmyWIocTFC
         r3drCMLWJ67Z4dsfq9bNgYrHu1CeejFOexgCESNasKXg8K0aiIyF4AWuUm4CImlVvwbp
         bym3uGJXKN9xEEHOhf8/nlGKD6v62ut/eGDjjL9rq9fXuTPpdT7JBQBfFqGJbPAgHZOy
         1H3UaQ4jb6p43I0DdRGcCtZ25fR1olqDzvkP/AbRhpbnA9it0Ozigtuu6ayKsqi1ghdF
         tRysStSolLOzM+UtNKHbe6Tx+G6fJoDOdqcCqGgO0Dk+ZrvPXVkgnQ4x3X3K5rL8wL68
         D7uA==
X-Forwarded-Encrypted: i=1; AJvYcCVfYkPSu5URnQxOU1F2bAteEhgT619J2wehwi6BBYAQhAJqPS1u5ZC+IgHcsMcr8qErHQznPLUQUTRYVv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye03tpzQXl0otVfyMrp9AXnL51G8Be0BAsaMR7NcHW7YlGrZat
	DKhlTMYoKKxpoJhhHaCkkH2abFOaqy6PCOx1MHEqGYpvfdCCeimTDKS7q6YoKCYgxue0Qc2b87p
	80Y+Sa6DZF5vlDQyg3P6YGH53wQ1QQFgfGVsv+FxVPoALFVj3epapAevtQ+Y=
X-Google-Smtp-Source: AGHT+IFDAoztbnvC9n21uInqFfDm51VC2VSaReCQ3ut32Mn+MW31DvE+zso0ifMwNhvWq9U8Fzv5vQPmG2XZgs5LeBvcFUDXrRVw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:433:7673:1d with SMTP id
 e9e14a558f8ab-43376730369mr95532205ab.31.1762798169947; Mon, 10 Nov 2025
 10:09:29 -0800 (PST)
Date: Mon, 10 Nov 2025 10:09:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69122a59.a70a0220.22f260.00fd.GAE@google.com>
Subject: [syzbot] [io-uring?] memory leak in iovec_from_user (2)
From: syzbot <syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a0c9b339199 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12af5342580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=3c93637d7648c24e1fd0
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16af5342580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13664412580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfd02a09ef4d/disk-4a0c9b33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed9a1334f973/vmlinux-4a0c9b33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e503329437ee/bzImage-4a0c9b33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812638cc20 (size 32):
  comm "syz.0.17", pid 6104, jiffies 4294942640
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kmalloc_array_noprof include/linux/slab.h:1003 [inline]
    iovec_from_user lib/iov_iter.c:1309 [inline]
    iovec_from_user+0x108/0x140 lib/iov_iter.c:1292
    __import_iovec+0x71/0x350 lib/iov_iter.c:1363
    io_import_vec io_uring/rw.c:99 [inline]
    __io_import_rw_buffer+0x1e2/0x260 io_uring/rw.c:120
    io_import_rw_buffer io_uring/rw.c:139 [inline]
    io_rw_do_import io_uring/rw.c:314 [inline]
    io_prep_rw+0xb5/0x120 io_uring/rw.c:326
    io_prep_rwv io_uring/rw.c:344 [inline]
    io_prep_readv+0x20/0x80 io_uring/rw.c:359
    io_init_req io_uring/io_uring.c:2248 [inline]
    io_submit_sqe io_uring/io_uring.c:2295 [inline]
    io_submit_sqes+0x354/0xe80 io_uring/io_uring.c:2447
    __do_sys_io_uring_enter+0x83f/0xcf0 io_uring/io_uring.c:3514
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812638cc40 (size 32):
  comm "syz.0.17", pid 6104, jiffies 4294942640
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kmalloc_array_noprof include/linux/slab.h:1003 [inline]
    iovec_from_user lib/iov_iter.c:1309 [inline]
    iovec_from_user+0x108/0x140 lib/iov_iter.c:1292
    __import_iovec+0x71/0x350 lib/iov_iter.c:1363
    io_import_vec io_uring/rw.c:99 [inline]
    __io_import_rw_buffer+0x1e2/0x260 io_uring/rw.c:120
    io_import_rw_buffer io_uring/rw.c:139 [inline]
    io_rw_do_import io_uring/rw.c:314 [inline]
    io_prep_rw+0xb5/0x120 io_uring/rw.c:326
    io_prep_rwv io_uring/rw.c:344 [inline]
    io_prep_readv+0x20/0x80 io_uring/rw.c:359
    io_init_req io_uring/io_uring.c:2248 [inline]
    io_submit_sqe io_uring/io_uring.c:2295 [inline]
    io_submit_sqes+0x354/0xe80 io_uring/io_uring.c:2447
    __do_sys_io_uring_enter+0x83f/0xcf0 io_uring/io_uring.c:3514
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812638cc60 (size 32):
  comm "syz.0.17", pid 6104, jiffies 4294942640
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kmalloc_array_noprof include/linux/slab.h:1003 [inline]
    iovec_from_user lib/iov_iter.c:1309 [inline]
    iovec_from_user+0x108/0x140 lib/iov_iter.c:1292
    __import_iovec+0x71/0x350 lib/iov_iter.c:1363
    io_import_vec io_uring/rw.c:99 [inline]
    __io_import_rw_buffer+0x1e2/0x260 io_uring/rw.c:120
    io_import_rw_buffer io_uring/rw.c:139 [inline]
    io_rw_do_import io_uring/rw.c:314 [inline]
    io_prep_rw+0xb5/0x120 io_uring/rw.c:326
    io_prep_rwv io_uring/rw.c:344 [inline]
    io_prep_readv+0x20/0x80 io_uring/rw.c:359
    io_init_req io_uring/io_uring.c:2248 [inline]
    io_submit_sqe io_uring/io_uring.c:2295 [inline]
    io_submit_sqes+0x354/0xe80 io_uring/io_uring.c:2447
    __do_sys_io_uring_enter+0x83f/0xcf0 io_uring/io_uring.c:3514
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812638cc80 (size 32):
  comm "syz.0.17", pid 6104, jiffies 4294942640
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kmalloc_array_noprof include/linux/slab.h:1003 [inline]
    iovec_from_user lib/iov_iter.c:1309 [inline]
    iovec_from_user+0x108/0x140 lib/iov_iter.c:1292
    __import_iovec+0x71/0x350 lib/iov_iter.c:1363
    io_import_vec io_uring/rw.c:99 [inline]
    __io_import_rw_buffer+0x1e2/0x260 io_uring/rw.c:120
    io_import_rw_buffer io_uring/rw.c:139 [inline]
    io_rw_do_import io_uring/rw.c:314 [inline]
    io_prep_rw+0xb5/0x120 io_uring/rw.c:326
    io_prep_rwv io_uring/rw.c:344 [inline]
    io_prep_readv+0x20/0x80 io_uring/rw.c:359
    io_init_req io_uring/io_uring.c:2248 [inline]
    io_submit_sqe io_uring/io_uring.c:2295 [inline]
    io_submit_sqes+0x354/0xe80 io_uring/io_uring.c:2447
    __do_sys_io_uring_enter+0x83f/0xcf0 io_uring/io_uring.c:3514
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812638cca0 (size 32):
  comm "syz.0.17", pid 6104, jiffies 4294942640
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kmalloc_array_noprof include/linux/slab.h:1003 [inline]
    iovec_from_user lib/iov_iter.c:1309 [inline]
    iovec_from_user+0x108/0x140 lib/iov_iter.c:1292
    __import_iovec+0x71/0x350 lib/iov_iter.c:1363
    io_import_vec io_uring/rw.c:99 [inline]
    __io_import_rw_buffer+0x1e2/0x260 io_uring/rw.c:120
    io_import_rw_buffer io_uring/rw.c:139 [inline]
    io_rw_do_import io_uring/rw.c:314 [inline]
    io_prep_rw+0xb5/0x120 io_uring/rw.c:326
    io_prep_rwv io_uring/rw.c:344 [inline]
    io_prep_readv+0x20/0x80 io_uring/rw.c:359
    io_init_req io_uring/io_uring.c:2248 [inline]
    io_submit_sqe io_uring/io_uring.c:2295 [inline]
    io_submit_sqes+0x354/0xe80 io_uring/io_uring.c:2447
    __do_sys_io_uring_enter+0x83f/0xcf0 io_uring/io_uring.c:3514
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812638ccc0 (size 32):
  comm "syz.0.17", pid 6104, jiffies 4294942640
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kmalloc_array_noprof include/linux/slab.h:1003 [inline]
    iovec_from_user lib/iov_iter.c:1309 [inline]
    iovec_from_user+0x108/0x140 lib/iov_iter.c:1292
    __import_iovec+0x71/0x350 lib/iov_iter.c:1363
    io_import_vec io_uring/rw.c:99 [inline]
    __io_import_rw_buffer+0x1e2/0x260 io_uring/rw.c:120
    io_import_rw_buffer io_uring/rw.c:139 [inline]
    io_rw_do_import io_uring/rw.c:314 [inline]
    io_prep_rw+0xb5/0x120 io_uring/rw.c:326
    io_prep_rwv io_uring/rw.c:344 [inline]
    io_prep_readv+0x20/0x80 io_uring/rw.c:359
    io_init_req io_uring/io_uring.c:2248 [inline]
    io_submit_sqe io_uring/io_uring.c:2295 [inline]
    io_submit_sqes+0x354/0xe80 io_uring/io_uring.c:2447
    __do_sys_io_uring_enter+0x83f/0xcf0 io_uring/io_uring.c:3514
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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

