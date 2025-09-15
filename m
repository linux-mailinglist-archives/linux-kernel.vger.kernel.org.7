Return-Path: <linux-kernel+bounces-817763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38A4B5863B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB6C1B226C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2ED28E5F3;
	Mon, 15 Sep 2025 20:55:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B632747B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969727; cv=none; b=cKjW8ibB82ecSNm5/5RFzRRjUr/XbtMNCChUHgqbWirGkrUDm9yO+N1nVAvxh+vbt010yfnwJCMMzKcWccj5OIrkNGkQeBBik/Tt652UrbVwiPh/WEMy8PNewE5AZjLrDBlZt9mapF8u69f57zIJ/Px6V/gdfWNg5wG0u+b+q3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969727; c=relaxed/simple;
	bh=N/ZDec9ENUC94b0f8dCgncceDYqEhPz5S2OVyu7voy8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rlaUtyPwQ8MsgAPAUhcdYVGvjyQEc0z2ym5qJtRfC4Yl3gNfszdslRTpxvY4RKAvy0dSJ/ZShRp2r8b14fT646kc0zIWvPy6kB5MMhqpKpaW1pwCbAVXw6e3mCQK3jLBzVWKqW116mvZOA1brgiCQjuNMIBfpY5vAHm8ICM5RnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-893668dea72so346234339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757969725; x=1758574525;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrmaagcVKzDm8wUKYMNtMjopPETS6Z1b8+TLqEEF2p8=;
        b=gWUL7Flgrh3SXAvXi46W1UWqbmYlFb5KBZG2h4cPL9SuIlkydsNrogrq0inN+tNoLO
         IfTs313PswJ+08juyA1qvR0lYEww4lQRzmMQG/7Shd2aEb2hLOLA3Rm3GsSbkbT6ZvL4
         sAbkyZGLa8LpOiKrxNrJX55u59Tc3PkTxVIIRcCepFYguEpPGYhE7XxBIYC7bjjxiN91
         XorY1utFLlY+4gs4Rx97hYmcfm6exTAxv2YgoUzmEVbUonjj4G6yt7roT23McVP+eYWy
         OIjdKONcLLcQnaCkAaMaxllsSqF9zKH3Auk8cAdeUAvLyzgyD92ORgy5qbQ6cLAo5kAR
         Ki+A==
X-Forwarded-Encrypted: i=1; AJvYcCV/zX9hIkcPYAFHCF46ugc3vRzq0l4hi7ujDSZOZ7+pvkDmswisjtUj7/HSfvNqCjNtSV9CLufkgmw10iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNUxD19o7BpYVKk3xdggRgtnej1b8MlwMhZAvbSp6SqKFAbP/
	T93I0HNUr6uC0FFEf6dqefocDiKaF1vWT9j3khPSzKVhkP6VoxelXgobL41t5Khqyko+jk3ndTT
	eyLY2B5fzgv4vXn5LXjQgv4bXsim+U4HBdF5jqpZgBtx3IzsVFo8vikF8Ysg=
X-Google-Smtp-Source: AGHT+IFWxShPxkdPM4Z5zoYQoSmHxJAQImrYMZ3T9LwTAGD87FO+F7eNdHDcwmfVxcPvk2WwD7VNQ47YNLc1N7ivxhLA8A6ChBJH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:250b:b0:424:771:418e with SMTP id
 e9e14a558f8ab-4240771429bmr36078265ab.30.1757969724652; Mon, 15 Sep 2025
 13:55:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:55:24 -0700
In-Reply-To: <dfb7c3c3-dba2-4c99-9347-50715e652c59@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c87d3c.050a0220.2ff435.03af.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca, leon@kernel.org, yanjun.zhu@linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one

unknown command "test:https://github.com/zhuyj/linux.git"

>
> On 9/15/25 12:07 PM, Yanjun.Zhu wrote:
>> #syz test:https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
>> On 9/12/25 3:04 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>> WARNING in gid_table_release_one
>>>
>>> ------------[ cut here ]------------
>>> GID entry ref leak for dev syz1 index 2 ref=445
>>> WARNING: CPU: 1 PID: 1088 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
>>> WARNING: CPU: 1 PID: 1088 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
>>> Modules linked in:
>>> CPU: 1 UID: 0 PID: 1088 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(full)
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>>> Workqueue: ib-unreg-wq ib_unregister_work
>>> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
>>> RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
>>> Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 00 46 71 8c 4c 89 e6 44 89 fa e8 3b a5 fa f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
>>> RSP: 0018:ffffc90003d0f908 EFLAGS: 00010246
>>> RAX: 11007f8b953ea200 RBX: ffff88802d562cd8 RCX: ffff888026adda00
>>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
>>> RBP: 1ffff11005aac59b R08: ffff8880b8724253 R09: 1ffff110170e484a
>>> R10: dffffc0000000000 R11: ffffed10170e484b R12: ffff888028265480
>>> R13: ffff88802d562c00 R14: ffff8880779b1800 R15: 0000000000000002
>>> FS:  0000000000000000(0000) GS:ffff888125d16000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000200000000240 CR3: 000000007612e000 CR4: 00000000003526f0
>>> Call Trace:
>>>   <TASK>
>>>   ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>>>   device_release+0x99/0x1c0 drivers/base/core.c:-1
>>>   kobject_cleanup lib/kobject.c:689 [inline]
>>>   kobject_release lib/kobject.c:720 [inline]
>>>   kref_put include/linux/kref.h:65 [inline]
>>>   kobject_put+0x22b/0x480 lib/kobject.c:737
>>>   process_one_work kernel/workqueue.c:3236 [inline]
>>>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
>>>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>>>   kthread+0x70e/0x8a0 kernel/kthread.c:463
>>>   ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:148
>>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>>   </TASK>
>>>
>>>
>>> Tested on:
>>>
>>> commit:         dd87fd3f RDMA/rxe: Add logs to find out the root cause
>>> git tree:https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
>>> console output:https://syzkaller.appspot.com/x/log.txt?x=144a9934580000
>>> kernel config:https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
>>> dashboard link:https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
>>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>>
>>> Note: no patches were applied.

