Return-Path: <linux-kernel+bounces-721116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F29AFC4F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C23427FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD1729CB4B;
	Tue,  8 Jul 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4NGf+s0q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRx1bMsA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317B2989BC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961706; cv=none; b=aW/3dU/Z9uTUzmy7e7F36g612fuE57vUr6ToPYKCrcN1Y6Td9AkW8eXF2pFwRqTP/Nz73E4HV3UqyylXM7acgRFvixWDCBV5D/QKHAwLcJuha4C9oO47QuUn3P0GocaIECcqcaZENZrHd+HD1bO8S5zfTcVqDMK4+KT1IkRF6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961706; c=relaxed/simple;
	bh=wPvO6CjaT4I5CbPQP4ZYFHt1t04N5QaJLuKASUDCfY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl6nts3cfun9KUM5Q+EjxcGK4bUqGyH5lQoY0gfAmW9/vMMvkHJP13xrGHGR+H+fhfer6UX343/iYHbI6zQNV36zGXzx12WbA4p3K2orjXn/9TkmdXcsFFQshuWlkFPZ0WvohqLFt6s1m7CtVyz8wa+LN80LN60STW2qlTLI6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4NGf+s0q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rRx1bMsA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 10:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751961702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgrC17L7S+8CjGt1v0c5Aa1kJyKSz8Zbjz45ZCol7qY=;
	b=4NGf+s0qZmvAGAXSIL2nUTDWYZ/2zykWghDjr21cuAsb55n3NTfp9tVaaYki3xSNSlkxKT
	sEk5vmIwDDzzEmrCjMS7N/RNy8AnG8/WvyE02J6f7nwlUMJyjlPodR4Y2emI8A5T+XkQ/K
	MiMIAmYBnUlLLfLJ7WsXzoZjFTvpFz1nRJitygpG/vQSOAbgiD5Ho/XkP8jj/n6fJIH4zq
	TUlDjPjIaz/uscYj6d2hrQanw29zhNEQrt+u6+8kRMQGpGNhXFYVTGTSt4BQKGm/gpZC+S
	gIYNK6+J2ejOvf24nfNm/f9JQqYOdHfr8AHlEK6trRsNUj36gZnU9w8wPxgbtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751961702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgrC17L7S+8CjGt1v0c5Aa1kJyKSz8Zbjz45ZCol7qY=;
	b=rRx1bMsAzth0uRRlXsljJMHnrw7iNig2I0oqICR88njZsIzPs3IjJIO/rRF1SR54WPqdk0
	WPi1IUCaoFqswgAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/3] selftests/futex: Adapt the private hash test to RCU
 related changes
Message-ID: <20250708080140.YUpDy-bM@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250707143623.70325-2-bigeasy@linutronix.de>
 <20250708074124.GE1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708074124.GE1613376@noisy.programming.kicks-ass.net>

On 2025-07-08 09:41:24 [+0200], Peter Zijlstra wrote:
> On Mon, Jul 07, 2025 at 04:36:21PM +0200, Sebastian Andrzej Siewior wrote:
> > The auto scaling on create creation used to automatically assign the new
> > hash because there was the private hash was unused and could be replaced
> > right away.
> > 
> > With the upcoming change to wait for a RCU grace period before the hash
> > can be assigned, the test will always fail.
> > 
> > If the reported number of hash buckets is not updated after an
> > auto scaling event, block on an acquired lock with a timeout. The timeout
> > is the delay to wait towards a grace period and locking and a locked
> > pthread_mutex_t ensure that glibc calls into kernel using futex
> > operation which will assign new private hash if available.
> > This will retry every 100ms up to 2 seconds in total.
> 
> So the auto scaling thing is 'broken' in that if you do a 'final'
> pthread_create() it will try and stage this new hash. If for whatever
> reason the refcount isn't '0' -- and this can already happen today due
> to a concurrent futex operation. Nothing will re-try the rehash.

Sure it was there but not in the way the test case was setup. I *think*
it is okay because in real life the new hash will be put to use unless
you terminate shortly after at which point you don't need it.

> This RCU business made this all but a certainty, but the race was there.
>
> I briefly wondered if we should have a workqueue re-try the rehash.

I don't think we need to worry about it.

Sebastian

