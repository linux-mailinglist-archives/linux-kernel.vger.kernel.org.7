Return-Path: <linux-kernel+bounces-750542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38DFB15DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA88C4E0596
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5A22F76F;
	Wed, 30 Jul 2025 10:06:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248A156C6A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869967; cv=none; b=nMKn+oWoMAZyzD/u6kAZPyehakVprkhflcQdA3zaDut3R41LnVwuIsmeMWB02dLJkZ1bXIi0aIRsjbX5zJjD3cCS/G4zBL+u6rvntiIPGA7SjPINRWWrSSlci/g1mDFUg7Cqr3KSNm7RO9S6Jx982nnY9VLKWlBE9GoHvNG+KSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869967; c=relaxed/simple;
	bh=QLFb4NAgJSAGuZ0PyEO0oNviQfZH/qLo7nGtRleY14A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=egAXA/KBs5cqFlplth9HIYzRk7L0b3ot4n9kSk0dYBFjtIlLmZcS1NmvBZ6yzqcEz589DJV9nEhwLuqBSvCRk2zhpdXVQtfm8A4WLeELDQnVsCl3mKlwe0btO3Xd0lH4NyF9Ulk5+gH92duIAW57yrbiVSKM1AGu+PGfe/FOsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e05997f731so146766275ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753869964; x=1754474764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vS3GogWmDtbK1JLTNkBdUVmSDzgU43r+mlvukhGZ7AE=;
        b=SmLB0NloDJnLEkTvhG7AGSgNdIe2z8YDD0Ro7NbPoubs70SuiqXxWZG+9Cm8NAJHvy
         yTOrJYsbWkYiDu0k3t7N8LDOE1m5pT9ojAw1qbN/TyHg0Z9jbD94ATcgfeIrr4C+IMK0
         Aq+MbK96hbBh5uJP+zenuTkdHRfYFiko3rN0Tr+EyA/IzD7kI8XsIgrvBFrwAAV8pn0+
         zBf0DrpK/OSTQOM1YLxhKCdXkRTiODBtQAKDSK08QI0bAVh2Oe+QBeNXFo6wZijNR7tN
         /Oq6UzfJOb2Pms3ApLE/CvZ+Zx4FEeoiGNL61qz1r8MSVJeDze+He4EBIjdqAvVgotvG
         BX0w==
X-Forwarded-Encrypted: i=1; AJvYcCWTiPrz7zuDmsefkHw+6RJII/+RViOpNj9EE3hWmfKkePTleNtP9jbMZa+oZ/jniauTdzic0TjcP3Br21g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGc1A8aWmheFDogjhNTtH+JhEnIz7RtEC2y12O02mbtDt/5ft
	Vbp1jy2yS6IAZ4+GJ+JwoCA9foUuSkmJbGWtnN229d8Xzftalop98uIm4c/cNsKvr3Oe8hKO0fC
	Bv/VM4opxeao1PLwDZm6UQOf8kBbDhkc4HCMjOO2vzUtMS6ZkLRhpuos9hD8=
X-Google-Smtp-Source: AGHT+IFToXghW8iKPbjrpZt5qSh2LHAfbo5OJn/TLElJ0b66kZzfuBmrZ6dgZwyTlFI0+pfrJJaLlarxLpMaeOdNlOvDO/UUBQx6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f:b0:3e3:f914:d774 with SMTP id
 e9e14a558f8ab-3e3f914d892mr29124695ab.17.1753869964099; Wed, 30 Jul 2025
 03:06:04 -0700 (PDT)
Date: Wed, 30 Jul 2025 03:06:04 -0700
In-Reply-To: <20250730082404.3487-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6889ee8c.a00a0220.26d0e1.001a.GAE@google.com>
Subject: Re: [syzbot] [fuse?] WARNING: refcount bug in process_scheduled_works
From: syzbot <syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in mddev_put

------------[ cut here ]------------
kernel BUG at drivers/md/md.c:641!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6690 Comm: syz.0.18 Not tainted 6.16.0-syzkaller-04405-g4b290aae788e-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__mddev_put drivers/md/md.c:641 [inline]
RIP: 0010:mddev_put+0x1e9/0x1f0 drivers/md/md.c:660
Code: f9 e9 3f ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 6d ff ff ff 4c 89 f7 e8 c2 ed e0 f9 e9 60 ff ff ff e8 f8 da 7e f9 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002f27cb0 EFLAGS: 00010293
RAX: ffffffff8840e0e8 RBX: ffff888032332000 RCX: ffff88807b13da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888032332133 R09: 1ffff11006466426
R10: dffffc0000000000 R11: ffffed1006466427 R12: ffff88806364e000
R13: ffff888148c47310 R14: ffff888032332130 R15: dffffc0000000000
FS:  000055558e36e500(0000) GS:ffff888125c86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000007 CR3: 000000005c370000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 bdev_release+0x536/0x650 block/bdev.c:-1
 blkdev_release+0x15/0x20 block/fops.c:699
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9d1d58e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee3402d38 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000025060 RCX: 00007f9d1d58e9a9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f9d1d7b7ba0 R08: 0000000000000001 R09: 00000008e340302f
R10: 00007f9d1d400000 R11: 0000000000000246 R12: 00007f9d1d7b5fac
R13: 00007f9d1d7b5fa0 R14: ffffffffffffffff R15: 00007ffee3402e50
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__mddev_put drivers/md/md.c:641 [inline]
RIP: 0010:mddev_put+0x1e9/0x1f0 drivers/md/md.c:660
Code: f9 e9 3f ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 6d ff ff ff 4c 89 f7 e8 c2 ed e0 f9 e9 60 ff ff ff e8 f8 da 7e f9 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002f27cb0 EFLAGS: 00010293
RAX: ffffffff8840e0e8 RBX: ffff888032332000 RCX: ffff88807b13da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888032332133 R09: 1ffff11006466426
R10: dffffc0000000000 R11: ffffed1006466427 R12: ffff88806364e000
R13: ffff888148c47310 R14: ffff888032332130 R15: dffffc0000000000
FS:  000055558e36e500(0000) GS:ffff888125c86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000007 CR3: 000000005c370000 CR4: 0000000000350ef0


Tested on:

commit:         4b290aae Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11948834580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dea300d7050f7861
dashboard link: https://syzkaller.appspot.com/bug?extid=9921e319bd6168140b40
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1394ccf0580000


