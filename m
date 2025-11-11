Return-Path: <linux-kernel+bounces-895695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A40C4EAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93CB18937D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE0A3314A8;
	Tue, 11 Nov 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="i5VaVQPp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I4O/IXyX"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2027FD72
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873238; cv=none; b=Shf5tlmtyvvOwUS7C818K+qFG93vRukQOWaTseMtt9IGl8/di2HY9T5RlW4e/0BDl70thXm3DaMpewk+b2r99K6m1a2vxmSvvdUZ5GPd9kVFvVy1YC5ytNyRb9sDYLUrgd9/cTx/jWopd0+21sBAfr87fV80QN1U1OsPFUiZKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873238; c=relaxed/simple;
	bh=QdbXiSddzrc5lWBPNEv1AWs8zwV/s1kZ0cqjvFGTiks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPNDu0zYUVK/0jzFngZsITcO2lCSG/3o7g3a3HcaJbuuriOvUNlBg9UyL+qw7Jtrf/qjMOVGI1IxjggtjIdlz/FgTvanoSztCa0IDQPVkqWMYf4h2EArcjJlHlrmeBMNe12GAHp5t24pA7PwrJpmcY9hR39NTtUrufSHskLA3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=i5VaVQPp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I4O/IXyX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D27D714001D5;
	Tue, 11 Nov 2025 10:00:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 11 Nov 2025 10:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1762873234; x=1762959634; bh=uc42wYO24N0tTLrcJ5MgHi4Jtgg5HaJE
	dp9QGfoeIbQ=; b=i5VaVQPpfKUzQIipBE8dJRvmMxcgEeyRhwFJVpANdJ8pYUrw
	HurJ6xeieVtvNcL81egmjIm5nqzbfBGPSiTdkx9gM8CpQPGDW20f82RVBNYP1dhe
	I1q0Tbw8ln49fbm5Jo5aEg11IDM7dwKoWsTIFRDtMxOeFSaZbeRdWFP7wHPjLc2O
	3ody3uyPnFwqq7Rx0Lm9eBwvnD7wFUOv6q1ZIVK6OgohtA5WXbreJm2LsSfpNnZV
	D9T1TO0ght2SBU2X1udqeHtK/65Cdq8Vbsy2NZDS/H8CK7UIffmT1+4Ydz33L0+I
	wgb9jFXs7huTc9R6yXd0o1cfQEBDgZi9GW0NPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762873234; x=
	1762959634; bh=uc42wYO24N0tTLrcJ5MgHi4Jtgg5HaJEdp9QGfoeIbQ=; b=I
	4O/IXyXTula1YLgbq71o868jbqhjwABP2rPc18CuIgaJUr+TZTCywfau1o79KoOR
	1wyigTjKzqxVl+gLmicnGtQ9yeNKqeOHKbP6TIGJ3x7NijnIaOQRjAYqq7sazBmX
	ErYV/wQVbVhzXh1YhesvAYVt3VSSoGVzK+w3iPo6FPNgSi/UWTFkz/x7kx/ZFfuy
	n5gh7I4XUbVIG9MyjenaLN5j1LDk+JvCzzrr1ZwLLwQOgJxw/xour/s59GFx0E4m
	Z0ewhU7QYOcK6s0JOJ98+GeLgBOuW1+cuM4wIF3dm5KKQ2r8nqLo7RIbcoNnOEL6
	yg0MX8F2ln9VpgtPqYaPg==
X-ME-Sender: <xms:kk8TaXNMhMv3SlGNF4BRDxMatIE_xx-Y2S53ra1tp1FjoyxdbwNumg>
    <xme:kk8TaZti0qD66B4OcfDgqy-z3ozqGFGq2hRtuCeDjqya-d2q6Ym8kxfc0cn0qcl6V
    DQ0HoAO2L5xvoCT2-qR_QmuKLxFtKc0zdZJt_PnLvd98LKACjKgAjU>
X-ME-Received: <xmr:kk8TaZW5cDnz3i1oLFlh1Ssj48AY8w0vLyHVTVMNR1KjW5uUUnwg81stgs0EVhik0MUX94YXwY2jxKdiQwgbkl6-7L37McVb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddugeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeefhfefiedtjeehledukeevueeiueekteefvddutdfg
    ieehteeljeeiieegjedtjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlfihnrd
    hnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtohepfe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrhhgrrhgupghfsehmrghilhgs
    ohigrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishht
    shdrshhouhhrtggvfhhorhhgvgdrnhgvth
X-ME-Proxy: <xmx:kk8TaZtjqBFQlo1WoLrlbgQW15kzLv-T1thnkZe0Xcx_w_9UtTz30A>
    <xmx:kk8TadW05nga1rwr3rUEGH4c5ALzp5YpzfYJx2tVUih2J-S1zC-vWA>
    <xmx:kk8TaUkdPY4NQM082srjF-4WGMSWc3V7_vAtnZHWWu7CmGCVtv_bXA>
    <xmx:kk8TaeYbizNtyVB9vcL1k8ejJYqEC2NiOkBE2v_u1TnWFE8LDGauKA>
    <xmx:kk8TaReBxYvd2VgS50IBGELK1aWkpzsLAFu-qPO1CXKHrBM0ed6cvhG4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 10:00:33 -0500 (EST)
Date: Wed, 12 Nov 2025 00:00:30 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: BUG: spinlock bad magic on CPU#1, irq/39-firewire/245
 (v6.18-rc4, ppc64)
Message-ID: <20251111150030.GA210402@workstation.local>
Mail-Followup-To: Erhard Furtner <erhard_f@mailbox.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <992eaf94-6fbb-4611-9a29-2db2e2148965@mailbox.org>
 <5145f071-c8bd-4b9d-94b1-2afe651cf25a@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5145f071-c8bd-4b9d-94b1-2afe651cf25a@mailbox.org>

Hi,

Thanks for the report, and sorry for your inconvenience.

On Tue, Nov 11, 2025 at 01:41:21PM +0100, Erhard Furtner wrote:
> On 11/9/25 15:17, Erhard Furtner wrote:
> > [...]
> > firewire_ohci 0001:03:0e.0: added OHCI v1.0 device as card 0, 8 IR + 8
> > IT contexts, quirks 0x0
> > BUG: spinlock bad magic on CPU#1, irq/39-firewire/245
> >   lock: 0xc00000001f672618, .magic: 00000000, .owner: irq/39-
> > firewire/245, .owner_cpu: 1
> > CPU: 1 UID: 0 PID: 245 Comm: irq/39-firewire Tainted: G N  6.18.0-rc4-
> > PMacG5 #1 PREEMPTLAZY
> > Tainted: [N]=TEST
> > Hardware name: PowerMac11,2 PPC970MP 0x440101 PowerMac
> > Call Trace:
> > [c000000005dafb20] [c000000000bc054c] __dump_stack+0x30/0x54 (unreliable)
> > [c000000005dafb50] [c000000000bc04e4] dump_stack_lvl+0x98/0xd0
> > [c000000005dafb90] [c0000000000f22a8] spin_dump+0x88/0xb4
> > [c000000005dafc10] [c0000000000f1d4c] do_raw_spin_unlock+0xdc/0x164
> > [c000000005dafc50] [c000000000bf65d0] _raw_spin_unlock+0x18/0x68
> > [c000000005dafc70] [c0003d0013ce1d5c]
> > fw_core_handle_bus_reset+0xa98/0xb64 [firewire_core]
> > [c000000005dafdc0] [c0003d0013d19aec]
> > handle_selfid_complete_event+0x610/0x764 [firewire_ohci]
> > [c000000005dafe80] [c000000000106050] irq_thread_fn+0x40/0x9c
> > [c000000005dafec0] [c000000000105ecc] irq_thread+0x1c0/0x298
> > [c000000005daff60] [c0000000000b5e54] kthread+0x250/0x280
> > [c000000005daffe0] [c00000000000bd30] start_kernel_thread+0x14/0x18
> I bisected the issue. First bad commit is:
> 
>  # git bisect good
> 7d138cb269dbd2fa9b0da89a9c10503d1cf269d5 is the first bad commit
> commit 7d138cb269dbd2fa9b0da89a9c10503d1cf269d5
> Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date:   Tue Sep 16 08:47:44 2025 +0900
> 
>     firewire: core: use spin lock specific to topology map
> 
>     At present, the operation for read transaction to topology map register
> is
>     not protected by any kind of lock primitives. This causes a potential
>     problem to result in the mixed content of topology map.
> 
>     This commit adds and uses spin lock specific to topology map.
> 
>     Link:
> https://lore.kernel.org/r/20250915234747.915922-4-o-takashi@sakamocchi.jp
>     Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
>  drivers/firewire/core-topology.c    | 22 ++++++++++++++--------
>  drivers/firewire/core-transaction.c |  6 +++++-
>  include/linux/firewire.h            |  6 +++++-
>  3 files changed, 24 insertions(+), 10 deletions(-)
> 
> 
> Bisect.log attached.

At present, I suspect the buffer overflow over 'struct
fw_card.topology_map.buffer[256]' and the cause would be unexpected value
of 'self_id_count' variable provided to 'fw_core_handle_bus_reset()'. It
means that in your machine the 1394 OHCI PCI driver computes the
unexpected value.

Would I ask you to retrieve verbose data by the following steps?

Step 1. Applying the following patch to avoid the suspicious buffer
overflow by limiting the pointer cursor within the buffer.

```
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 2f73bcd5696f..5e66428ec4b0 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -442,6 +442,7 @@ static void update_topology_map(__be32 *buffer, size_t buffer_size, int root_nod
 {
        __be32 *map = buffer;
        int node_count = (root_node_id & 0x3f) + 1;
+       size_t count;

        memset(map, 0, buffer_size);

@@ -449,7 +450,10 @@ static void update_topology_map(__be32 *buffer, size_t buffer_size, int root_nod
        *map++ = cpu_to_be32(be32_to_cpu(buffer[1]) + 1);
        *map++ = cpu_to_be32((node_count << 16) | self_id_count);

-       while (self_id_count--)
+       count = buffer_size / sizeof(*buffer) - 3;
+       if (self_id_count > 0 && count > self_id_count)
+               count = self_id_count;
+       while (count--)
                *map++ = cpu_to_be32p(self_ids++);

        fw_compute_block_crc(buffer);

```

Step 2. The value of self_id_count can be retrieved as the part of
'firewire:bus_reset_handle' tracepoint event. Please work with Linux
tracepoints framework[1] and store the event log. I think unbind/bind
operation to firewire-ohci driver is useful[2].

[1] https://docs.kernel.org/trace/events.html
[2] https://lwn.net/Articles/143397/


Thanks

Takashi Sakamoto

