Return-Path: <linux-kernel+bounces-889400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B753FC3D749
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6863BB69E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE930507B;
	Thu,  6 Nov 2025 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bKsYhKw9"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9862304BCB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463346; cv=none; b=YG74a+zs/sNQSJN+N2w0iHJkBjpOhn+rjehF0LMtnIweSF/mMXOqnVpuyGGIP3e7M9XlQK3ZA5v04w5bgZmH6dt7sOZutwrlHCxvirwg1llVpse6OMV4WaKlu8co0hJdfRuxQLJ9h0PrKVIpQyAjb5Hk15th8DVASXTbZzcdSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463346; c=relaxed/simple;
	bh=3AtY/VwyhU9BVz2wNHpcH2scMMYmfb188zCCT3AVuZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PBc4ze+tOQNWoot2EEWXpPdo3sqtPLLwZ7GnkcaABCk7E65hG8Oy3dnV9ilkF4qOwn62OovBOt7asdv68zYho0rJUBR8K2bxVdzGX6QlnbAW9iblalXZTfKjXbKvs2aWmsGQP/Rs2YM4Aqvx5bokMgY2afl5EbXVxzQAUQURZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bKsYhKw9; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a14d9fe2-e2f3-454c-acbc-229f358f05af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762463340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pA+Au9Wfg4FnaO+AIfMrv9CyLswebJ75y8ZdGYpg94s=;
	b=bKsYhKw9FfnEZB/GKRLwVYih+dtPxKW/JZz5B+iFwQ5S9x6dtdnCuTU32kpbfrD73M3GOr
	jp4lgonMcVhtxlYkWziQeVQYa9ullJUZ5YzsQvuoZbOTzCrth6xCJTYg36KG9BvWNswYpV
	T9WGXQ+dsbTn52PjKHuKe05we2I648o=
Date: Thu, 6 Nov 2025 13:08:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <690d0ccd.a70a0220.22f260.000a.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <690d0ccd.a70a0220.22f260.000a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/6/25 1:02 PM, syzbot wrote:
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in gid_table_release_one
>
> ------------[ cut here ]------------
> Possibly kref leak, ref:403, state: 3
> WARNING: CPU: 0 PID: 12 at drivers/infiniband/core/cache.c:820 release_gid_table drivers/infiniband/core/cache.c:819 [inline]
> WARNING: CPU: 0 PID: 12 at drivers/infiniband/core/cache.c:820 gid_table_release_one+0x4fb/0x800 drivers/infiniband/core/cache.c:897
> Modules linked in:
> CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> Workqueue: ib-unreg-wq ib_unregister_work

The problem occurred in ib_unreg_wq. It is a workqueue in ib device.

I will work on this problem.

Yanjun.Zhu

> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:819 [inline]
> RIP: 0010:gid_table_release_one+0x4fb/0x800 drivers/infiniband/core/cache.c:897
> Code: 49 01 c6 4c 89 f0 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 be 01 00 00 41 8b 16 48 c7 c7 60 7d 2b 8c 44 89 e6 e8 16 e2 35 f9 90 <0f> 0b 90 90 e9 c4 fe ff ff e8 f7 76 72 f9 4c 8b 7c 24 48 4c 89 f8
> RSP: 0018:ffffc90000117900 EFLAGS: 00010246
> RAX: a2ec906fdf0a5800 RBX: ffff888030cab6d8 RCX: ffff88801c6e5ac0
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: ffff888079d48010 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffffbfff1b7a680 R12: 0000000000000193
> R13: dffffc0000000000 R14: ffff888028a68690 R15: ffff888030cab600
> FS:  0000000000000000(0000) GS:ffff88812636a000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f49bf3056c0 CR3: 00000000772e8000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>   device_release+0x9c/0x1c0 drivers/base/core.c:-1
>   kobject_cleanup lib/kobject.c:689 [inline]
>   kobject_release lib/kobject.c:720 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   kobject_put+0x22b/0x480 lib/kobject.c:737
>   process_one_work kernel/workqueue.c:3263 [inline]
>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>   kthread+0x711/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
>
>
> Tested on:
>
> commit:         690e9fda RDMA/core: Fix WARNING in gid_table_release_one
> git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
> console output: https://syzkaller.appspot.com/x/log.txt?x=16bbb012580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Note: no patches were applied.

