Return-Path: <linux-kernel+bounces-889877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09169C3EBF3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49AEF349EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935D3090D5;
	Fri,  7 Nov 2025 07:29:27 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03AF303A29
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500566; cv=none; b=hRxUk/N+t+dBEIh17Exnx93nScI2cyqXKGfV1xtT6df3mjj2u9LsZM36Gp9rfKgtEUUVJxIz+X1oplWo2CtF8+D+mqK5Dt52orLCxnoMt25vjujjNPJQAkus0lzlqF3IeeeVuBW0RlElq5VLcRVGqd6eSWCbTxOUWC9q3UuR25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500566; c=relaxed/simple;
	bh=NkUmiRr2VxDy5/5BOLr+iLlwO1D8uIsEdDyaTo/nMqI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R2jh4J3HD4xJVExbllJ+QWc4B6gbhMafLB+oRg+VpabcP/aN501YZlCyswv/qGT3WUHCWO3GkfUmmHSiwnNYZgIePJsBTr5ojF09cV9Ez7STK7wI+AGSZpspXXfCvf8bvlNgUZEYOo+v3zE2qL5qcO9gcT6lt0VFLY9EfKvBEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-94880a46eaeso138298039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500564; x=1763105364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myDtyB0quJocgmZPo4q8NiQGN1NpxAndRSGB3Kice1c=;
        b=SjPijHOmtWasr9H5PL3u+H+WbS7wULPw3nBusl+5Hj6wt6/DqFG187aUsE2sQIUHWx
         eFdnBdzQrU4L8HD9bxhXIhrL8PahCjlAgdrMLkAFth41Vi0yD4q8E6EOoVB1QdQmwn6f
         leZT6L8oD8djBKClBGxkMnUeQhbFjvQ7QzvC8O5Gwe4oly/N4LxStbosRHf/3ALYI3a6
         nmwfaWQ1C3YakjlZhfwTonigVJV8PF7tR6dI8q3eAN4N1eRtNGwDFMLIgKwLcMZl0JgU
         7GBdwzkLB/aZrk7wCWgFeIbG+GslMsQInDniAGmxRfmTNhYAsf7q//LOvxBSweNkmQht
         /dxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUa1ZEiphcnmlnEzKpu0cUg6Dj7G7NV5lwCPi5hSwgk6W9yLSzwWCHAeCVKOuOXzqwdU59Bs6XkJCAT24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05BbmHXv1xc0XWC3Lshu18XAtAGtKIXfS5QMATTtcFr2YDWJN
	VChTlU/sF9AG4evh9p5nPnClWZjiJ/i9ouDu2R8ytsQqs63ICBj2JUCjjhCOmqjqYyRsxFqx++d
	RccPxA+Q73H0scFFyQqe/WYspkgIXN73phiEzs40nMvBw0FnqKYI3M5cGEvg=
X-Google-Smtp-Source: AGHT+IGgYvO/k8HgWgHBBRLdbKwms4v/QEC+jVS0TpNqadUYrRu4lKS8VY1gkYkSGFunATjoR31L1xQhU48H+Qmll7WlPKz9FMx5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:433:2389:e0ad with SMTP id
 e9e14a558f8ab-4335f3c3f22mr28628815ab.8.1762500564176; Thu, 06 Nov 2025
 23:29:24 -0800 (PST)
Date: Thu, 06 Nov 2025 23:29:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d9fd4.a70a0220.22f260.0022.GAE@google.com>
Subject: [syzbot] [jfs?] BUG: unable to handle kernel paging request in diUpdatePMap
From: syzbot <syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1451a532580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=7fc112f7a4a0546731c5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fc5812580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110f3012580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae6bec0d0398/disk-dcb6fa37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcc732da66c3/vmlinux-dcb6fa37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/301d1bbdecc2/Image-dcb6fa37.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/94e5a8b9504e/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1051a532580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address fbd5200000000021
KASAN: maybe wild-memory-access in range [0xdead000000000108-0xdead00000000010f]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[fbd5200000000021] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 100 Comm: jfsCommit Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 834000c5 (Nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __list_add_valid_or_report+0x3c/0x148 lib/list_debug.c:29
lr : __list_add_valid include/linux/list.h:96 [inline]
lr : __list_add include/linux/list.h:158 [inline]
lr : list_add include/linux/list.h:177 [inline]
lr : diUpdatePMap+0x4e8/0xb90 fs/jfs/jfs_imap.c:2831
sp : ffff800099e67b50
x29: ffff800099e67b50 x28: dfff800000000000 x27: 00000000c0000000
x26: 0000000000000000 x25: dead000000000100 x24: 1bd5a00000000021
x23: dfff800000000000 x22: dead000000000108 x21: ffff0000e21152f8
x20: ffff80009b403120 x19: dead000000000100 x18: 0000000000000000
x17: ffff80010ca0e000 x16: ffff800080536ef4 x15: ffff7000133ccf58
x14: 1ffff000133ccf58 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff7000133ccf58 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000000 x7 : ffff800081c11594 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008053700c
x2 : dead000000000100 x1 : ffff80009b403120 x0 : ffff0000e21152f8
Call trace:
 __list_add_valid_or_report+0x3c/0x148 lib/list_debug.c:29 (P)
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add include/linux/list.h:177 [inline]
 diUpdatePMap+0x4e8/0xb90 fs/jfs/jfs_imap.c:2831
 txUpdateMap+0x708/0x8d0 fs/jfs/jfs_txnmgr.c:2357
 txLazyCommit fs/jfs/jfs_txnmgr.c:2665 [inline]
 jfs_lazycommit+0x394/0x94c fs/jfs/jfs_txnmgr.c:2734
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
Code: aa0103f4 d343fed8 f2fbfff7 aa0003f5 (38776b08) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa0103f4 	mov	x20, x1
   4:	d343fed8 	lsr	x24, x22, #3
   8:	f2fbfff7 	movk	x23, #0xdfff, lsl #48
   c:	aa0003f5 	mov	x21, x0
* 10:	38776b08 	ldrb	w8, [x24, x23] <-- trapping instruction


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

