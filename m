Return-Path: <linux-kernel+bounces-814776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD3B5588B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900D17B727E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141322C11EA;
	Fri, 12 Sep 2025 21:43:38 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C7280CF1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713417; cv=none; b=TGfWLX6jc3MJOPIWppQqBLXqM5zpMH2q/6kDJcelG3BgDqHUSaCROf8kUT8j/n+BMGBejqAUXfbeBssNxKHyO3QpDLZFYq1wVJKvA8Xuyr2mncZFdYvhe5WmtcqVw8NSCTwBCmmhlkhrr7/PLS8hXxdWB/MwLTXyUGAAFr4HH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713417; c=relaxed/simple;
	bh=dRKncOwadauklnCaK6wHt4d+XRuGodJ94h5uReG5YOM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Ta+6dh7L3zM+nvZfcw4n/1+PIVVM8WmIPPPhCzKE5/OqywLAsbwdwW9rSi0nHt975KYyLFL+RPI7SKPpCEDHeX2v+b7Z0toyDLtLS0Cg0hA7/O40SPbsh0ayDY1GaC4XB8SDeWvB0VqIU3SO2oUMrs26S2o6D7SXa9OiWyYFFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ffbd7e6662so26196935ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757713415; x=1758318215;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27YWpGtmCRGtPLUcyQLZK8M3gMzNWkSac3dYGbv05sg=;
        b=O+B0V9ewOUA1HTTctHVLMBHgVgU8qjhaXssRSXzEz45rfssXxU6njWqutiCuomJ5CB
         DN6JOv1faBzl07sMtSMms0bxC0nJW7OhVPj/uEyMVZteo8qI7DWBsUECe2JLKnpsXvSf
         y1lZRKWOx8zwkfRAUqqIE8qzZjwEIhzQxvDCQaow2igxFCf971qHIoQnyUqSOPv58Oea
         HFkihrXk+PDKeoL1mD/y6Z50O/XRessNtcnAK+/Qix8IEP/wZrXv0AEPBvoAqrhx3AnF
         amoi65m8ZHZ38D/DAxAu4Nhm1LDuKwF2Zk09MU3b+ohXL5xNAd6UlspV1lDbWdIz9DRr
         Qp/w==
X-Forwarded-Encrypted: i=1; AJvYcCUvje/Sqg0sa+j/QJn9/AtLrYsXmB6v5OSkYsA+KLv5aTFrq0AnXa4j06KBb2CAq3kdZpDpr+RrffmsOs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpS6khGrSZW1d0lFinVfWM+k7E6twjDuZQ7EgH2JNBjstY64SV
	XXDUbsDmTVv9wPWGdFYSIoAY1tFWj86ydssf27+Dv4yuC1u4F0n24L989dXunu605kAmAffLSgF
	ZGgHtknnCrILgbxEez9ocBpHoXSrVvwWSLN+x/OQ1gfasAxOdKxmUgOEfm3I=
X-Google-Smtp-Source: AGHT+IHxmanH59T50NpRvac3TcA4p3LXyFa7s/9ZuwAxAzMcEH+8hGT/lIUIOBUoDw0VQ0eZt1jzKDLmj4MSC5FtSpJEuRakLFOI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:417:fc48:51e0 with SMTP id
 e9e14a558f8ab-4209d40feebmr69291615ab.6.1757713415289; Fri, 12 Sep 2025
 14:43:35 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:43:35 -0700
In-Reply-To: <19d2990f-ba92-4fef-891d-26baf03afe18@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c49407.050a0220.3c6139.04b4.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca, leon@kernel.org, yanjun.zhu@linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one

unknown command "test:https://github.com/zhuyj/linux.git"

>
> On 9/12/25 2:20 PM, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>> WARNING in gid_table_release_one
>>
>> WARNING: CPU: 1 PID: 1342 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
>> WARNING: CPU: 1 PID: 1342 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 1342 Comm: kworker/u8:7 Not tainted syzkaller #0 PREEMPT(full)
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>> Workqueue: ib-unreg-wq ib_unregister_work
>> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
>> RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
>> Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 00 46 71 8c 4c 89 e6 44 89 fa e8 3b a5 fa f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
>> RSP: 0018:ffffc90004bff908 EFLAGS: 00010246
>> RAX: 6115427e6ab01100 RBX: ffff88807855c2d8 RCX: ffff888027abbc00
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
>> RBP: 1ffff1100f0ab85b R08: 0000000000000003 R09: 0000000000000004
>> R10: dffffc0000000000 R11: fffffbfff1bfa24c R12: ffff8880206a4b40
>> R13: ffff88807855c200 R14: ffff88801ffd5a00 R15: 0000000000000002
>> FS:  0000000000000000(0000) GS:ffff888125d16000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000200000000240 CR3: 000000005e54a000 CR4: 00000000003526f0
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
>> commit:         e5320428 RDMA/rxe: Add logs to find out the root cause
>> git tree:https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
>> console output:https://syzkaller.appspot.com/x/log.txt?x=12829934580000
>> kernel config:https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
>> dashboard link:https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>
>> Note: no patches were applied.

