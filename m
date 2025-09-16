Return-Path: <linux-kernel+bounces-818023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57AB58BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759701BC24C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BB2222AA;
	Tue, 16 Sep 2025 02:10:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DBD136E37
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988606; cv=none; b=WIZWVOujCcHfkd/9QrOQ16OS8HTNvUgDovxKTNmWtjxClKVb2S6ceafJh748x7hlVHNqJRnSQ1adH30A2gLHgablhoKbWVAX77ayzKkWp9P5DkcoVIJeV0YeYodZ83a/14Nlu3z9lbe3+00tGKGCbDYUZGCWMRM/SdMx2M61hOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988606; c=relaxed/simple;
	bh=WVLKRmRcwE7oDH8Ir87NBhjCJQ9Qwc9y6TF7GV33cQ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Je6sDsvsxpjyVNdx1t+WInJmSHBUwYa2iSYK8yHtepfn1rkZfTvQm9Ka8C/FM/1hNBCQQy6Rjhk+gPc5wVhi5sVCngF3sS3FLlakHMAw0JQnllia+kntDK1na96oRYBUgCN69ZmhW4ssjHPnConEycQ4jGjvkN/ojz4Pq71auuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-423f9d1ea61so74239805ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757988603; x=1758593403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1AtsoW9FinNvk/ea3367p68ehG6wxDT38SCJypxuk0=;
        b=R/YKRnAZ2C3fLe/jqSzVUj5yu15Zi+3dPUGUUACkeMUc7lGtIsjexZW5iD4PprOuv2
         dkNY4qhPyjf5a9NOUwlax+g2Y1dl9J/7ZbqetiZwct4c1qy3cyBMbEnoFST+Wl9g4N+J
         6K7yQ3ejWV63j3CQulC4GyNyBJkXVeyBZaWWL0Uq6DNUd2gUn2Iv8sBovFIfsdRmWVy5
         E+kDemYTslJPxv6FaexBkkJc3WKfTlb3YcI9fKJ45nIh49nTm/rng0XmdC4KBCD3Msyh
         K2S36Q3cOj73F+WJmIf8SkphI00pKfQBgWh8JpFrZWaP0Uc/pOdVtk2oV5pXjxVHys5w
         vATQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhUJPZid+6ra6Kyn16VgI4bbEjD4d+Y3tV1H5m6GYl4vR7WZBrg6Ut82EUKYpeZJQwkkbYwusxN/Xz4Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4dAANepqvE0eFNIT1LsYmi4nzWdnIu528CwCLVVwLHZ17QkQ
	++/3Ht/HVlziQxLPrE8wwvBQjHcIJejKO3cPsR/RZf3Xc4pbucKg6cr7vv7YfkgjkuDsNpvfDPs
	54CgruCc/ut7B2fs5ML1K5Xy00YD27Q7G3YHQJdEhOgF3wL2VCMtCF8RPOfw=
X-Google-Smtp-Source: AGHT+IE+nG+Bf2HxNyXkL7AohIZgmJoGDrwaAw8QHaoykp0kzrXUaxXzcVR1UohTbk5dQQYAajiPAp8w7jJDd6SiD9Fi1NuDrxzU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:424:9a5:855b with SMTP id
 e9e14a558f8ab-42409a58679mr37727095ab.16.1757988603761; Mon, 15 Sep 2025
 19:10:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:10:03 -0700
In-Reply-To: <6aed82d8-8e65-402d-909e-b8cfbfbb41e4@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8c6fb.050a0220.2ff435.03ba.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=450
WARNING: CPU: 1 PID: 59 at drivers/infiniband/core/cache.c:813 release_gid_table drivers/infiniband/core/cache.c:810 [inline]
WARNING: CPU: 1 PID: 59 at drivers/infiniband/core/cache.c:813 gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:890
Modules linked in:
CPU: 1 UID: 0 PID: 59 Comm: kworker/u8:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:810 [inline]
RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:890
Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 60 4b 71 8c 4c 89 e6 44 89 fa e8 1b 81 fa f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000210f908 EFLAGS: 00010246
RAX: 1a406f1d516b1b00 RBX: ffff88807d4a44d8 RCX: ffff88801bbf9e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff1100fa9489b R08: ffff8880b8724253 R09: 1ffff110170e484a
R10: dffffc0000000000 R11: ffffed10170e484b R12: ffff8880202c6e80
R13: ffff88807d4a4400 R14: ffff88802566aa00 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff888125d16000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000240 CR3: 0000000024970000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
 device_release+0x9c/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         10a39576 RDMA/rxe: Add logs to find out the root cause
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=114d8e42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

