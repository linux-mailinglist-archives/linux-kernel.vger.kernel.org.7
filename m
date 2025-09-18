Return-Path: <linux-kernel+bounces-790176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABADDB3A205
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC57058297E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE2123D298;
	Thu, 28 Aug 2025 14:25:36 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144222FE11
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391136; cv=none; b=JxyezswHrsLcoyDmpvz3lj/DtRwOkaUDpnNcrn2sxGQnN790BqisKZ48BYqtiNjyMcefrIuYKCsJ4FZPBDYBgZO5iQtYtoY5JL/CT/6VfnE2HXpDW0lhxvYgQ0bhvBAI+XdU/8dPX0yzkRv2Y7PFBYulo4wB0wV+bRMtjIc73no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391136; c=relaxed/simple;
	bh=or4ymz+8rapxhUcqnPZhNyzaZe3k0OTQofWc3oLIz6k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YHOulDTicGxTqfCD7bD1zt9CnoeiqEnk1REVjdcgB4iDvkxSkOPDFIxJyFCf6ryQrlH7GKDKJWsgLwtbiG3Sbc4iJ2HC7GtP2RctDa5yvZyC1vJDIumJzyO+9fYBSJl1C/i4s3NI4a2tyNiQWFXdEvE3F0yJxu+2kl/+7acn/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-886e347d26bso120368439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756391134; x=1756995934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X401dxTztD/h02Lx3lrqLzK2dweQNmNnv6bEtQK8+EM=;
        b=mcbqDIq/ZH78DOGh06xT8y+96AfGNFndQMV4F7ZtCVLmqX4ny3DU+6D6tuO068JsS4
         GjCk0yvrwiehwZ1Aw1OyBpWwUXsjLhT+/e0BCJxyrR9NyYo2+PEdCGb+1FJbZ+Zeclna
         RW5IsTVhloe7BWVVRo2nfRHCObt4AdXLtJu9L2f3+0T0U9wrDnk5mbYRGrfuf52bH/+7
         us3XrNMunw7edmFwhcoTdc4utXp2F8xf0sv9ybOyDvsC+763Onn0lhynw4XFiIk8T8l5
         48ll0pz5jF/HDvHt7y3SZ0KYaFjrscg99Ea2IBSohtQyF99fB5sBKJfskzRm8PbwWGde
         4hZg==
X-Forwarded-Encrypted: i=1; AJvYcCWYIj5obaS8PNYT5aDPT9PKfcn7IEfVn7vHTedCvzIZ17h7bdnAs/c2dgr/TqFAflmUKVPPn87asBb9FUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0NIyEEmF91vwqrf1dp6zDCZLUEz3Ah7KSGRDhWF8/6b0BcXB
	wkRefOTKhlhgqTyYJB/ganpNsrx2cGLJkOztBHDgJW3ckikDAuQGJo9ig7zK5/h+c2IMSBAYweW
	h+xjJvBRZmwVo+nMGIcBkvOumEn0HsR6IEC/lo+JpTC4n5+cyf991nNb9Y5w=
X-Google-Smtp-Source: AGHT+IF1JahB34Nzk8euvUaM8Fb3n8wWejPb8okot3E4s8ziUB2BctW//TxhVGjZgwBudcF+W5C7c9VLwAl8RNMreZuRKAXETc46
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4617:b0:3ea:d47f:5995 with SMTP id
 e9e14a558f8ab-3ef08764393mr130298875ab.11.1756391133708; Thu, 28 Aug 2025
 07:25:33 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:25:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b066dd.a70a0220.f8cc2.007b.GAE@google.com>
Subject: [syzbot] [rcu?] BUG: unable to handle kernel paging request in rcu_cblist_dequeue
From: syzbot <syzbot+dfae5535e0da40eb9879@syzkaller.appspotmail.com>
To: boqun.feng@gmail.com, frederic@kernel.org, jiangshanlai@gmail.com, 
	joelagnelf@nvidia.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org, 
	paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1617e634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=dfae5535e0da40eb9879
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfae5535e0da40eb9879@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address ffff3ff7ee0a2600
KASAN: maybe wild-memory-access in range [0xfffdffbf70513000-0xfffdffbf70513007]
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
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000206ec9000
[ffff3ff7ee0a2600] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 1816 Comm: kworker/0:2 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Workqueue: rcu_gp srcu_invoke_callbacks
pstate: 03400005 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : rcu_cblist_dequeue+0x68/0xc8 kernel/rcu/rcu_segcblist.c:75
lr : srcu_invoke_callbacks+0x198/0x394 kernel/rcu/srcutree.c:1802
sp : ffff80009f9c7960
x29: ffff80009f9c7960 x28: ffff80009f9c79c0 x27: dfff800000000000
x26: ffff0000c5a5a918 x25: ffff0000c1092800 x24: fffffdffbf6e0e40
x23: 1ffff00013f38f3c x22: dfff800000000000 x21: ffff80009f9c79f0
x20: fffdffbf70513000 x19: ffff80009f9c79e0 x18: 0000000000000000
x17: ffff80010c5d9000 x16: ffff8000805293e8 x15: 0000000000000001
x14: 1fffffbff7edc1c8 x13: 0000000000000000 x12: 0000000000000000
x11: ffff800093306be8 x10: 0000000000000001 x9 : 1fffbff7ee0a2600
x8 : 0000000000000000 x7 : ffff8000805b4130 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000010
x2 : 0000000000000006 x1 : ffff80008edc258c x0 : ffff80009f9c79e0
Call trace:
 rcu_cblist_dequeue+0x68/0xc8 kernel/rcu/rcu_segcblist.c:74 (P)
 srcu_invoke_callbacks+0x198/0x394 kernel/rcu/srcutree.c:1802
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
Code: f94002a8 d343fe89 d1000508 f90002a8 (38766928) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f94002a8 	ldr	x8, [x21]
   4:	d343fe89 	lsr	x9, x20, #3
   8:	d1000508 	sub	x8, x8, #0x1
   c:	f90002a8 	str	x8, [x21]
* 10:	38766928 	ldrb	w8, [x9, x22] <-- trapping instruction


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

