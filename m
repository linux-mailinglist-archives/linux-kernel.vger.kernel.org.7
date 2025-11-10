Return-Path: <linux-kernel+bounces-893847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16E8C487E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9DB3B78B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2C314D01;
	Mon, 10 Nov 2025 18:09:32 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A7314D03
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798172; cv=none; b=rgqJFSj6g306CnqiTY7jAWjM2Bqqvm8jdkUYNdE1B32zPFkClfSNa9RYpAcwTXTACse7KSk3BpT2Ir03VsEbEtI0/++dke/rXmMHmuKI/Eq3S0PtFvwJT7QPBjDdKQqnhBXliOa/ajSuJkWeCJi/t2EjMJiizcxgTWqehQqM+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798172; c=relaxed/simple;
	bh=AQBG0AHdUaV7JwDWC+nFZcYAdCK/9Gml1U/bexRQVCU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nCuPOagHY/fKQTYmJWCaKcx3oRDJ9gU7d9FYa4uqnWocA4uR3QsnzKEzVWZi8AZWkZc+YwCkmDqXfc6//XouDS3SItNTkaamdsSn9f+G96PE9T/28b4GgnQdRxwRC1hnjcRiT8jT+qWVhWuRr+R8LgdrU8d8BpP3fuZudi846gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso1010984439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762798169; x=1763402969;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfVHyy3yInLiUbcIqZnocrna0llwjFI7de3HK7K21Js=;
        b=wJIxrR+hDY2DiwX+N40F+JDj9jcKmpCIxPN3pMLdH3SKYTNyplHDUwT9g6ByLyJByI
         qhg+anmusq+e+1bXFYvLDoqGeT7F7V/tw0MzMU3NGLiXL4SEBfxMMjYNEy4z47ePN8x2
         ZwdfFUm81BHgj4OzLuuPFeUciNv2/WzN8Jo24sRzRcvyg0AwZFstot470rriXIaIUw8+
         5B/APu9jDGSHMVPFX+qQKSFPA17rNQFhhRTlhSsKM7yNSqMPorQcqWFJw29saH+eWqiN
         SpKNFD3bsr3xJWVxiTSPKGEPmRoEn4e2nerZhek6sFXgQghkmSYqsaSHc99r79Cl4xAM
         ljmw==
X-Forwarded-Encrypted: i=1; AJvYcCW1g/QdkeyQcwa/4UKNS55LntfasQ/7iIDZs6+mCAcLPflcN5PDoRXrtqa7SVE9AGiyfa0LwIwiu3zczqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLf8336RiQuM9apR7IDwc55u66Dxe4aSuM0gLX33FZ/sa7VJt8
	x68Rr/qqPvoY8/PrX743fzSOdZAnoSOj3f4G4uFmijhsYZqypDJqR0pSKYwtOav/7Oh9b1WTnv/
	LRV3Qmk/LkyCCZYw1CwUVw6CSOYeCBDCPZarLmHYkvPPn7S3ZZmLF8XwrLso=
X-Google-Smtp-Source: AGHT+IEIv86/SSoO/EP6AO48d+5zrweh+PuwtJkgQSpsVtjR0v7vJTjEvDwvpKUi6L+0B5BIcY2f8or9qjw9c9rSoNxLbNJSknPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:433:5736:968f with SMTP id
 e9e14a558f8ab-43367df3cd3mr149960695ab.13.1762798169416; Mon, 10 Nov 2025
 10:09:29 -0800 (PST)
Date: Mon, 10 Nov 2025 10:09:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69122a59.a70a0220.22f260.00fb.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KMSAN: kernel-infoleak in hugetlbfs_read_iter
From: syzbot <syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com>
To: david@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	osalvador@suse.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    439fc29dfd3b Merge tag 'drm-fixes-2025-11-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c7517c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf50e713aaa5cb0
dashboard link: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107f3084580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10634b42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cfc76859b0d7/disk-439fc29d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a4aa2e08e02/vmlinux-439fc29d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24591c797483/bzImage-439fc29d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_iovec include/linux/iov_iter.h:52 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:330 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x4e4/0x33f0 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_iovec include/linux/iov_iter.h:52 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:330 [inline]
 _copy_to_iter+0x4e4/0x33f0 lib/iov_iter.c:185
 copy_page_to_iter+0x482/0x910 lib/iov_iter.c:362
 copy_folio_to_iter include/linux/uio.h:204 [inline]
 hugetlbfs_read_iter+0x6cd/0xe10 fs/hugetlbfs/inode.c:281
 do_iter_readv_writev+0x9e1/0xc20 fs/read_write.c:-1
 vfs_readv+0x34a/0xf30 fs/read_write.c:1018
 do_preadv fs/read_write.c:1132 [inline]
 __do_sys_preadv fs/read_write.c:1179 [inline]
 __se_sys_preadv fs/read_write.c:1174 [inline]
 __x64_sys_preadv+0x2a3/0x510 fs/read_write.c:1174
 x64_sys_call+0x3064/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:296
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_frozen_pages_noprof+0x689/0xf00 mm/page_alloc.c:5206
 alloc_buddy_hugetlb_folio mm/hugetlb.c:1944 [inline]
 only_alloc_fresh_hugetlb_folio+0x2b0/0x1280 mm/hugetlb.c:1984
 alloc_fresh_hugetlb_folio mm/hugetlb.c:2003 [inline]
 alloc_surplus_hugetlb_folio+0x178/0x5c0 mm/hugetlb.c:2223
 gather_surplus_pages mm/hugetlb.c:2415 [inline]
 hugetlb_acct_memory+0x759/0x2420 mm/hugetlb.c:5331
 hugetlb_reserve_pages+0x10d1/0x26f0 mm/hugetlb.c:7347
 memfd_alloc_folio+0x20a/0x7b0 mm/memfd.c:90
 memfd_pin_folios+0x10b3/0x16a0 mm/gup.c:3523
 udmabuf_pin_folios drivers/dma-buf/udmabuf.c:337 [inline]
 udmabuf_create+0x1256/0x1ed0 drivers/dma-buf/udmabuf.c:434
 udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:486 [inline]
 udmabuf_ioctl+0x2eb/0x5b0 drivers/dma-buf/udmabuf.c:517
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:583
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
 x64_sys_call+0x1cbc/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 0-5 of 6 are uninitialized
Memory access of size 6 starts at ffff88804480000f
Data copied to user address 0000200000000080

CPU: 0 UID: 0 PID: 6052 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


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

