Return-Path: <linux-kernel+bounces-887555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4770AC3882C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CE714EAABA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C481ACEAF;
	Thu,  6 Nov 2025 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Psxa6XZW"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDCD43AA6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389880; cv=none; b=i13o18erdwGVqflYMKZ/ul8Z4PHuaqIgUg+5ttca3NaqXUIZTSJxJLu7rQ3D4k1Bbaiu4zQZS5GMoIU8XCEnjUzJcP1GTfCaJQ4nCJiYOd5S5sU76s2dbrMs0zLcbdlIeumbFWk7/NJTbV5WSFYsh/ULf89zMiZeQeVIKv0bOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389880; c=relaxed/simple;
	bh=4YIrExipjwIw+0oTSGSzsI7Tt2PtZ+F6dd9zme5jo8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAmw/5wWv96HRQA12pLMtKWDSGBhLh9u45nnpemgVIP8MjvbCLpXJrq0qyy+guXqXm8ARpMwIVUn9kmLAyG82DDhdwWbOiGzz0LnFbzQZZ/CKWVJ17f8c7SvbsXx707DdE0g6AxcuHPfcw/CNRjZO+Dlry+loukVE+pHxgq0RVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Psxa6XZW; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a97a3ea8-2acc-49c5-af2f-0bb60aff494f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762389875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmLc41JPGOKg1KJCgv7WXfIlvGnNZX2Ma/Ax0Z6ar3k=;
	b=Psxa6XZWaD3hXVTqaa2BRel05vHyAX7WykT53b2D0wfbc3IqALzJ+kdL9gUYSX/BLr+d57
	Qu0JGyFntraX+HsFVHNgYXUHFshFMMbUjCRBB4E7ji2ISVCO9Zk+QtX5v4EisbixzoRifL
	3Cks/eyo1+3COqvcG+5VbghHHTQyuXw=
Date: Wed, 5 Nov 2025 16:44:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <185e135e-0e17-4ef8-91a2-15e69897cd01@linux.dev>
 <690b83fc.050a0220.3d0d33.006c.GAE@google.com>
 <20251105171457.GO1204670@ziepe.ca>
 <b65f327e-446f-4388-9b77-0256943d0596@app.fastmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <b65f327e-446f-4388-9b77-0256943d0596@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/5/25 10:50 AM, Leon Romanovsky wrote:
>
> On Wed, Nov 5, 2025, at 19:14, Jason Gunthorpe wrote:
>> On Wed, Nov 05, 2025 at 09:06:04AM -0800, syzbot wrote:
>>> Hello,
>>>
>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>> WARNING in gid_table_release_one
>>>
>>> ------------[ cut here ]------------
>>> GID entry ref leak for dev syz1 index 2 ref=363, state: 3
>>> WARNING: CPU: 1 PID: 50 at drivers/infiniband/core/cache.c:827 release_gid_table drivers/infiniband/core/cache.c:824 [inline]
>>> WARNING: CPU: 1 PID: 50 at drivers/infiniband/core/cache.c:827 gid_table_release_one+0x5ae/0x6c0 drivers/infiniband/core/cache.c:904
>>> Modules linked in:
>>> CPU: 1 UID: 0 PID: 50 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full)
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
>>> Workqueue: ib-unreg-wq ib_unregister_work
>>> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:824 [inline]
>>> RIP: 0010:gid_table_release_one+0x5ae/0x6c0 drivers/infiniband/core/cache.c:904
>>> Code: e8 03 0f b6 04 28 84 c0 0f 85 cc 00 00 00 44 8b 03 48 c7 c7 60 7c 2b 8c 48 8b 74 24 28 44 89 fa 8b 4c 24 50 e8 73 e7 35 f9 90 <0f> 0b 90 90 44 8b 74 24 04 4c 8b 7c 24 20 4c 8b 64 24 48 e9 15 fe
>>> RSP: 0018:ffffc90000bb78f8 EFLAGS: 00010246
>>> RAX: 124fa0acf3bf2700 RBX: ffff8880268c1990 RCX: ffff888020289e40
>>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
>>> RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
>>> R10: dffffc0000000000 R11: fffffbfff1b7a678 R12: ffff88802ed4e2d8
>>> R13: 00000000000001a8 R14: ffff88806a158010 R15: 0000000000000002
>>> FS:  0000000000000000(0000) GS:ffff88812646a000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00005555712ce808 CR3: 000000006b6c8000 CR4: 00000000003526f0
>>> Call Trace:
>>>   <TASK>
>>>   ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>>>   device_release+0x9c/0x1c0 drivers/base/core.c:-1
>>>   kobject_cleanup lib/kobject.c:689 [inline]
>>>   kobject_release lib/kobject.c:720 [inline]
>>>   kref_put include/linux/kref.h:65 [inline]
>>>   kobject_put+0x22b/0x480 lib/kobject.c:737
>>>   process_one_work kernel/workqueue.c:3263 [inline]
>>>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>>>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>>>   kthread+0x711/0x8a0 kernel/kthread.c:463
>>>   ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>>   </TASK>
>>>
>>>
>>> Tested on:
>>>
>>> commit:         ad2cc78b RDMA/core: Fix WARNING in gid_table_release_one
>>> git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=11dfa17c580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
>>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> I think this disproves the theory that the the gid is sitting in a
>> work queue waiting to be cleaned up..
> Yes, this is makes more sense to me when multiple ib_wq flush.


ib_unreg_wq also has to handle gid. Thus the 2 workqueues (ib_wq and 
ib_unreg_wq) handle gid.

Thus it is not enough to just flush ib_wq.

Yanjun.Zhu

>
>> So we still need to find out what is holding on to the reference...
>>
>> Jason

