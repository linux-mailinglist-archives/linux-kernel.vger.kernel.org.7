Return-Path: <linux-kernel+bounces-817664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17AAB58520
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DF23B8961
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C6327F166;
	Mon, 15 Sep 2025 19:07:46 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10711E9B1C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963266; cv=none; b=uyzlc4Nuxh/DhBBu2+YfQp+Nv+2j54OZQXM7cAvSRUmyNnkLI7d3F/XL3tRfDH1ufXM+3VBtQLqSgI//hNxeJd/KIiXI+puAJgrXXwxwOvaRGZmoCSKDpbl8SgIT+1Ihag1BBLhGQN3qE06I/ybjL0UwV8hBIDEPuPuG5X30QnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963266; c=relaxed/simple;
	bh=2aBAK15ip3O5OLmQKzZk+8W48e2KI5m7FWxIRoHVReg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=mbEW8KdfieeYv57fWAacByeOb5Y4zriJctfLnvOtGp9VwrDJXOJpLmcKSZRajBZ8r9xHgbKtrUPEsRCLskOYWQXaztd1Hv4BO9Irz/IVYVivPgvHWFOPOxhlLBxyeqOE8fum5WSKWb52cKHeMJzOx4+xHCDsjmzf401iOy8n98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8875a8663d0so471804039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963264; x=1758568064;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuOIk64QYWOXQ27t1jVJjOXapS9T9UT7lZ0e3vJIKOQ=;
        b=fllHuDDiNqEo3S7Xt0+xx15B2xynHgYaI9iM5p462fa9oky0AF+PqQ3WYRPkZSDheb
         ZqMpwRPZ4+G/4J8hivuo7wbi80T4p0CEoxz7ztFkieQFaH6db1zmpoYSNB3YG9IxRVao
         +i9J8m5H8ukJhh2YDR/cEZWCKO4Udt5ccB2DHSxNpZEMlenzhD64iLHXfBduztQSA5/C
         fpjYry+CYPuYwTXZ6sUr2v76yYCohRDn4VvSeo5tMgA4dMcqTbiMJmAoqjbBMPyO0T1l
         EfBWfh2gafXPK+dqlCDycpPoBY4H8+KP2zboTu7VnTAN/hwDrO8N9mxavT11MTPiV0Vz
         Vtvg==
X-Forwarded-Encrypted: i=1; AJvYcCUA1GRYFGrhvX3Lbabzz6J1HD6EXqNdHwc5k5ZKEcyY9VNxe19/bDLxL2JjQiHBc3WHzclkkhHjdnd2BlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqn+Z/gzvrpvfzNxCpWx2OIB46peJRgWifVXVR6GVx22A2Pdw
	cV4DlFX+SjtGsTkC0Ih+6XzGd6rVYujKrqHbiB7cfHjw4rRj86+LFMc2+CRZwcdIQqIbguEtLHz
	Xg1canCqZ/cpnLZ1ElDxYb/sx2nMpInQS0DC2JqtgZrc1QOtH7XVU9b0R66w=
X-Google-Smtp-Source: AGHT+IFcnTSXLGbUKH46CdN9QivF+oRfPAWztpgbJ9CSLQBB/FS1T/4FxJ5DhmxJb+X4TgYmHveyIbXZ9qIF//HTp/7f7+xrf9pR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:423:fd07:d3f0 with SMTP id
 e9e14a558f8ab-423fd07d535mr54611465ab.26.1757963264106; Mon, 15 Sep 2025
 12:07:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:07:44 -0700
In-Reply-To: <5fb34b0f-435e-4584-abe0-bbf7839b44df@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c86400.050a0220.2ff435.03a7.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca, leon@kernel.org, yanjun.zhu@linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one

unknown command "test:https://github.com/zhuyj/linux.git"

>
> On 9/12/25 3:04 PM, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>> WARNING in gid_table_release_one
>>
>> ------------[ cut here ]------------
>> GID entry ref leak for dev syz1 index 2 ref=445
>> WARNING: CPU: 1 PID: 1088 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
>> WARNING: CPU: 1 PID: 1088 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 1088 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(full)
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>> Workqueue: ib-unreg-wq ib_unregister_work
>> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
>> RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
>> Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 00 46 71 8c 4c 89 e6 44 89 fa e8 3b a5 fa f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
>> RSP: 0018:ffffc90003d0f908 EFLAGS: 00010246
>> RAX: 11007f8b953ea200 RBX: ffff88802d562cd8 RCX: ffff888026adda00
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
>> RBP: 1ffff11005aac59b R08: ffff8880b8724253 R09: 1ffff110170e484a
>> R10: dffffc0000000000 R11: ffffed10170e484b R12: ffff888028265480
>> R13: ffff88802d562c00 R14: ffff8880779b1800 R15: 0000000000000002
>> FS:  0000000000000000(0000) GS:ffff888125d16000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000200000000240 CR3: 000000007612e000 CR4: 00000000003526f0
>> Call Trace:
>>   <TASK>
>>   ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>>   device_release+0x99/0x1c0 drivers/base/core.c:-1
>>   kobject_cleanup lib/kobject.c:689 [inline]
>>   kobject_release lib/kobject.c:720 [inline]
>>   kref_put include/linux/kref.h:65 [inline]
>>   kobject_put+0x22b/0x480 lib/kobject.c:737
>>   process_one_work kernel/workqueue.c:3236 [inline]
>>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
>>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>>   kthread+0x70e/0x8a0 kernel/kthread.c:463
>>   ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:148
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>   </TASK>
>>
>>
>> Tested on:
>>
>> commit:         dd87fd3f RDMA/rxe: Add logs to find out the root cause
>> git tree:https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
>> console output:https://syzkaller.appspot.com/x/log.txt?x=144a9934580000
>> kernel config:https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
>> dashboard link:https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>
>> Note: no patches were applied.

