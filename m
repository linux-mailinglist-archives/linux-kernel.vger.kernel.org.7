Return-Path: <linux-kernel+bounces-773618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB9B2A2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09646562B63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522BD320CC9;
	Mon, 18 Aug 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OwSFGVCD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QbFanGte"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE08320CC3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521567; cv=none; b=YHYDUophWCi3+sT6lyuk5f7bIXsHdlHACcBF5CFjtZVB/E+fcfMesFSMbVCN/qzEhpt5vNxYo4JRWE6K6v9QZO5+v0X3ty5KYLe0U9Gdm6JkvDF5HmI3ocdidSdIfeRzJa64R0tsQnCqsD3ZbF4SWgmgXmaVrZz0lFvYLqiH6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521567; c=relaxed/simple;
	bh=WS1GAw/EoGg7F4iUR6kmjSFg+XPs96VJRDDL9js7iUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlT7UvsGTtRBfYJSNYqWcxhmQdd/C74va4JTW89sMvHHsXMPbL68ge6A7PQoPPdZv4/dCU503mxalqXGH//RpdpUlNoogoPWih9Hb4EIONN1PiZjncyzqCzfkd6g3fe8UPDEj4NBQVVgPQJ3cDHUj5zyAITGmFVtVJ2sP2s3AsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OwSFGVCD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QbFanGte; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 14:52:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755521564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fe699vDAzc3LvWXFMREqbcBvlpPNmNxfbNTNF0p9oB4=;
	b=OwSFGVCD9r2d7xTK6ka83OfqpkqJtvEP9DLf4R9X4v4CdiDFhapl9jJQY1hTo/0fldne0j
	z1AvSea/+1pXPrYiT7ePEJG+/GJnkJMDXDQhkSYqWkma3StsmVtxGjiFSBvny+akPOBJGU
	A2xDX6uVM38DS3mW0wNjVmKxiXBYDKWKMUEQgLQpRb2YWoehm8qXAjxCKHdGKq0rrE9AC9
	FEv/6+SG9V+/6uu0T6jHmNRQ+9sEVtgCQS8zYbFwGVZf57gQjVP50JbsV9OxBXT6zzWA7j
	Xd38DZHVF15TJNNCc7RcL1qJ9E8n9Q2So5Kaeie/aujG2idAxYwKMSQ/nYOy2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755521564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fe699vDAzc3LvWXFMREqbcBvlpPNmNxfbNTNF0p9oB4=;
	b=QbFanGteD15lihsMonjrtYNKt8UZjlIjp1eIobB4eR8SlwXUQFgV4BMBc5RFvAkWwm3oA3
	C8/X5JD8loGdzpDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250818125242.vJ4wGk20@linutronix.de>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJzT7rqwkRQrLGqo@slm.duckdns.org>

On 2025-08-13 08:05:34 [-1000], Tejun Heo wrote:
> Hello,
Hi Tejun,

> On Wed, Aug 13, 2025 at 08:33:11AM +0200, Sebastian Andrzej Siewior wrote:
> ...
> > > The intention is to convert all BH users to workqueue-BH and remove BH
> > > (that's what Linus wants and why workqueue-BH came to be), so the APIs
> > > should be able to match up, I'm afraid. There were some attempts at pushing
> > > the conversion but we've only made minimal progress. If you're looking at BH
> > > users anyway and feel like it, please feel free to convert them.
> > 
> > I understand this but I am talking about legacy users:
> > 
> > | drivers/atm/eni.c:      tasklet_disable_in_atomic(&ENI_DEV(vcc->dev)->task);
> > | drivers/net/wireless/ath/ath9k/beacon.c:        tasklet_disable_in_atomic(&sc->bcon_tasklet);
> > | drivers/pci/controller/pci-hyperv.c:    tasklet_disable_in_atomic(&channel->callback_event);
> > 
> > This is what is left. (There is also i915 but this is "special").
> > So we are talking about establishing an API and behaviour for those here
> > after we painfully managed converting everyone else away:
> 
> Right, given how early in conversion, we can definitely leave this as
> something to think about later. I have no objection to leave it be for now.

Okay. Do I need to update __flush_work() in anyway to make it obvious?
The local_bh_disable()/ local_bh_enable() will become a nop in this
regard and should be removed.
It would be the revert of commit 134874e2eee93 ("workqueue: Allow
cancel_work_sync() and disable_work() from atomic contexts on BH work
items"). The commit added the possibility to flush BH work from atomic
context but it is unclear if there already a requirement for this or if
it was to match the legacy part of the tasklet API.

> Thanks.

Sebastian

