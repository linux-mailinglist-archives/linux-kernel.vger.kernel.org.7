Return-Path: <linux-kernel+bounces-887145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D033C3761F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A9A64E91D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD530311966;
	Wed,  5 Nov 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmSSc534"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312652BE7D9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368653; cv=none; b=IUkiGYVmbDKyxqzG7e+x+9O8FodFBetDuZpizJscEueKzp8G+WcTbngBxGj3EzXZhUsRIoHOpdPl68vSedAyDwibdK2wvmfaLFB7tVzhrKzPXUsqIRrO1DzdQ6yqgoddCaPF2CI46kaQxWhC1WZ6XNmVEol6UobqAVnxt4EOmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368653; c=relaxed/simple;
	bh=ZChi0j6lBzCHHjSk+YTfvl679jHfaKLTr4YuNjjvvxI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ITphUth7fPSCl+dqW79E4soeOq/kcinQIkR7Tfe3HuZF5X/1gsChnFOFeP+IlFLImxKXvZeOKSURQd8ennHqHeo0I/8ohcQDzQKg5Rj3Y5NTnRZZ/EQugmYgAXf1cvep3y9BXtsuUOjVDBNUTaTF6QiRJL5DirPckZo1tPxrjT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmSSc534; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80664C116B1;
	Wed,  5 Nov 2025 18:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762368652;
	bh=ZChi0j6lBzCHHjSk+YTfvl679jHfaKLTr4YuNjjvvxI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MmSSc534JRhVLXFvlaHy1cfyvZyzmoZLxA6tM96GQqoS1iQxUkcEHiy1FK/mHkM+3
	 /+Kdx8itml6V6voNojcJ0/Z1RvHMZx/kuf/1uMP2mox3V+jW34Z+XbuwowZHLDpVpF
	 hFVlPsYDyQhVXZrwXyFmg8B1/Aft0N81D24xc9OZpSPnPpSY985vYFwvNl5MvJq5y1
	 uRm/MiCA64BqbxyeBETM5NaSpRhrkCZyraeCAKDH2b2Dl0d/oECzTSR4nw/8TkckFR
	 YST4zR+YWvtMu9I9JyCsN/b+p8+JELCZO8m9BciV009EmOaE7fEdSwj9V9VDHVQcze
	 5rAKymvrXSZzA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 79978F40068;
	Wed,  5 Nov 2025 13:50:51 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 13:50:51 -0500
X-ME-Sender: <xms:i5wLaa_WwnXtfYyRsnrXMo7pVxhRSF8DpHg42nv3_YFDgmLdVvDPXA>
    <xme:i5wLaVh2ubeNpXj59Cs1uGvXlWK-mSCSU1ctQ_G5rfOq7RtNB4hw2VUtoVRGs0uKg
    DQceZX2zhBl23TTA4m2xeRmVWefmY3AV2kDTr9sw9ZYR8xW3Vaj8Lo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfnvghonhcutfhomhgrnhhovhhskhihfdcuoehlvghonhes
    khgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpefgueeghedttdevheetgffgvd
    ffudeuteehjeeukeffheelgfehffelieekvdduteenucffohhmrghinhepghhithhhuhgs
    rdgtohhmpdhshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhgvohhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeelkeegqddvjeejleejjedvkedqlh
    gvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnhhupdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshiiikhgrlhhlvghrqdgsuhhgsh
    esghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohephigrnhhjuhhnrdiihhhu
    sehlihhnuhigrdguvghvpdhrtghpthhtohepshihiigsohhtodgstdgurgekfegriegttd
    gvvdgvvdgsuggusggugeesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrg
X-ME-Proxy: <xmx:i5wLaZJP6O9wJk0bLroBZ4pFllLTaEUutzMw0CKZGGMnzNZo2e1uLQ>
    <xmx:i5wLaeFm-9etm-cOuQA9UKrpKCgOp7zcgVPWfW8Q92bzJRGoOa20Sw>
    <xmx:i5wLadQ7HiBn__vHrjBIui17oRf7K_1nf0fEmvmyz0b4l4ER5n1h5Q>
    <xmx:i5wLaacygc2_88dQrN-pNI_zSfd8LPXauYMQomkR7k-e49GMOle2ag>
    <xmx:i5wLacr1O2AE3abtew1k8N71cEHXeJs45UoYQosEpplms4-RGY3cIGGs>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A4512CE0067; Wed,  5 Nov 2025 13:50:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ar1NWyDjluCN
Date: Wed, 05 Nov 2025 20:50:25 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Jason Gunthorpe" <jgg@ziepe.ca>,
 syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Message-Id: <b65f327e-446f-4388-9b77-0256943d0596@app.fastmail.com>
In-Reply-To: <20251105171457.GO1204670@ziepe.ca>
References: <185e135e-0e17-4ef8-91a2-15e69897cd01@linux.dev>
 <690b83fc.050a0220.3d0d33.006c.GAE@google.com>
 <20251105171457.GO1204670@ziepe.ca>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Nov 5, 2025, at 19:14, Jason Gunthorpe wrote:
> On Wed, Nov 05, 2025 at 09:06:04AM -0800, syzbot wrote:
>> Hello,
>> 
>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>> WARNING in gid_table_release_one
>> 
>> ------------[ cut here ]------------
>> GID entry ref leak for dev syz1 index 2 ref=363, state: 3
>> WARNING: CPU: 1 PID: 50 at drivers/infiniband/core/cache.c:827 release_gid_table drivers/infiniband/core/cache.c:824 [inline]
>> WARNING: CPU: 1 PID: 50 at drivers/infiniband/core/cache.c:827 gid_table_release_one+0x5ae/0x6c0 drivers/infiniband/core/cache.c:904
>> Modules linked in:
>> CPU: 1 UID: 0 PID: 50 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
>> Workqueue: ib-unreg-wq ib_unregister_work
>> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:824 [inline]
>> RIP: 0010:gid_table_release_one+0x5ae/0x6c0 drivers/infiniband/core/cache.c:904
>> Code: e8 03 0f b6 04 28 84 c0 0f 85 cc 00 00 00 44 8b 03 48 c7 c7 60 7c 2b 8c 48 8b 74 24 28 44 89 fa 8b 4c 24 50 e8 73 e7 35 f9 90 <0f> 0b 90 90 44 8b 74 24 04 4c 8b 7c 24 20 4c 8b 64 24 48 e9 15 fe
>> RSP: 0018:ffffc90000bb78f8 EFLAGS: 00010246
>> RAX: 124fa0acf3bf2700 RBX: ffff8880268c1990 RCX: ffff888020289e40
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
>> RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
>> R10: dffffc0000000000 R11: fffffbfff1b7a678 R12: ffff88802ed4e2d8
>> R13: 00000000000001a8 R14: ffff88806a158010 R15: 0000000000000002
>> FS:  0000000000000000(0000) GS:ffff88812646a000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00005555712ce808 CR3: 000000006b6c8000 CR4: 00000000003526f0
>> Call Trace:
>>  <TASK>
>>  ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>>  device_release+0x9c/0x1c0 drivers/base/core.c:-1
>>  kobject_cleanup lib/kobject.c:689 [inline]
>>  kobject_release lib/kobject.c:720 [inline]
>>  kref_put include/linux/kref.h:65 [inline]
>>  kobject_put+0x22b/0x480 lib/kobject.c:737
>>  process_one_work kernel/workqueue.c:3263 [inline]
>>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>>  kthread+0x711/0x8a0 kernel/kthread.c:463
>>  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>  </TASK>
>> 
>> 
>> Tested on:
>> 
>> commit:         ad2cc78b RDMA/core: Fix WARNING in gid_table_release_one
>> git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11dfa17c580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> I think this disproves the theory that the the gid is sitting in a
> work queue waiting to be cleaned up..

Yes, this is makes more sense to me when multiple ib_wq flush.

>
> So we still need to find out what is holding on to the reference...
>
> Jason

