Return-Path: <linux-kernel+bounces-889385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B9C3D716
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AE784E59FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776193019C7;
	Thu,  6 Nov 2025 21:02:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB172E719B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462928; cv=none; b=DL8yCwIDaNcDzDIGH2j1M6TPQ+y0jXCATHaYawBopeYzyxkQTOLfSNff2ng1EFMjTiDbaueW1DocVSvkRrLEJoqeMygw7ilqRCs8NupixSR9gaYgBtwXi/g0d+0wvXBirjcfIbcnoQyqDMtbiDvhAqbSYaQWTVWTPesZMSDPSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462928; c=relaxed/simple;
	bh=nBYhpFJgds7k16pvBhZt5edoFuijzMVHZhuJ5kSK2XE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BdDvecVwIpZik1ZDZiYCWo2SHKOOG41RHECDSUBG1rOhavHVRgRN005koxga5zT1lt/Up+LWaF4DGytXN8vxLznr437EFuPq/ImabgQP0/neW1k6OkuHFQcWtfjbfh9mBirHPrAcSICUbpXHIrq4wBF5PEiNV4erktsNV1/mWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43328dcdac1so1773445ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462925; x=1763067725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P5fry+YhpP/GQ2PB9FayW+Xhf/s0t07JFkZZepi76s=;
        b=H0LCSQVdB2zEqH5cQ6onY+HxOpcJj1WAyGaqsthqPU0XgWiZ2Ed5un4bHcoBz95qQa
         cI56WXyb856uVWb++phvbuo7PtpB0bPNsr1j/V0WCGe7vC+pPXE3WqH6oNmF8SqxaC0/
         OQ43yH+SadzLHw0D/5V0zS690zwNSsZmQ0CKeYKMOmBLuo54CK0M69VoSqWGXngI9F8K
         5P6PwQ4VdAjtYd8DRZ5US2V7TwgNJKHZ35QSrJB5poHxUY1oKmrudn0CIw6ScGvJfxwM
         Y6zZuHP3e5Wid3UJlAQN8su6ax/mAHSqQo+i5yPJobM2OURgEkrggV34Lv1tqlZjso5/
         5EiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo0WIUrur/5I13A8hJ7a6/Ue++wF60WKKXZzT9KHJB3rkenYJIgUNXRG8uh+Rvtu0bpHGdrkifKEnEYCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xP6NjqgGWYIVz5xo2FpAukHs56hFHcmyBtcEwNhEHqQqkHlL
	itQ56g1I1LFwuq8zHrD0QqWVybcwmCzj3O+fk138zmSa6QALRHprFSqrdCd/B4x0SKF1uWqzXq3
	iycdCMAUaVSpsMKstm9jepptyDO6+NQPwLSSSgBFXnp2S3X5Bu5mZPwbetjE=
X-Google-Smtp-Source: AGHT+IHj5wLviO4uhYrntm+ASBL9DTQ0+auYUccKhkVxQTc+WLSyQ/KS+oY96kg59cxbda7Qt4f4PWDtywqCFZyr6VkHlkh3ZCAw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348d:b0:433:377:abd with SMTP id
 e9e14a558f8ab-4335f47f038mr12529475ab.22.1762462925666; Thu, 06 Nov 2025
 13:02:05 -0800 (PST)
Date: Thu, 06 Nov 2025 13:02:05 -0800
In-Reply-To: <ffdab397-0096-4946-a7d5-073300cc34a3@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d0ccd.a70a0220.22f260.000a.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
Possibly kref leak, ref:403, state: 3
WARNING: CPU: 0 PID: 12 at drivers/infiniband/core/cache.c:820 release_gid_table drivers/infiniband/core/cache.c:819 [inline]
WARNING: CPU: 0 PID: 12 at drivers/infiniband/core/cache.c:820 gid_table_release_one+0x4fb/0x800 drivers/infiniband/core/cache.c:897
Modules linked in:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:819 [inline]
RIP: 0010:gid_table_release_one+0x4fb/0x800 drivers/infiniband/core/cache.c:897
Code: 49 01 c6 4c 89 f0 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 be 01 00 00 41 8b 16 48 c7 c7 60 7d 2b 8c 44 89 e6 e8 16 e2 35 f9 90 <0f> 0b 90 90 e9 c4 fe ff ff e8 f7 76 72 f9 4c 8b 7c 24 48 4c 89 f8
RSP: 0018:ffffc90000117900 EFLAGS: 00010246
RAX: a2ec906fdf0a5800 RBX: ffff888030cab6d8 RCX: ffff88801c6e5ac0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff888079d48010 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1b7a680 R12: 0000000000000193
R13: dffffc0000000000 R14: ffff888028a68690 R15: ffff888030cab600
FS:  0000000000000000(0000) GS:ffff88812636a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f49bf3056c0 CR3: 00000000772e8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
 device_release+0x9c/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         690e9fda RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=16bbb012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

