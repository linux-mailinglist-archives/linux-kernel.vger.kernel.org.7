Return-Path: <linux-kernel+bounces-721071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EFAAFC460
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2B03A3C97
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB4299AAF;
	Tue,  8 Jul 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2FkjbDn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D522156C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960489; cv=none; b=fEwe5/QXO/q+jfiY/EyaGe13EKR0oEru/UYS0itbEPAhEnkwokCav8cIwh32sQWLHcTpP2jNe0JrrAX8v9sdOezp4u1SI6veohn3hOShWZd/NFxDDAXvZ/EAufVnleHlrSNEgEyGQdNW2nmZbS0BEszLOJwa8tB+9hYU96OJ3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960489; c=relaxed/simple;
	bh=BFaon7Lh83vD95XayQzfRrTiTblL7ozjem2TRdOr6Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj0b1e9tS2KtaaqdbG0YSq5lI1ydBHdoI/+wowBFieMB7ILQD1kw5oovRNShf25F3T5yxeVitIM0L/YssxfZpSdJOWFr9HU0Y/0TrvwbK9Gsdn0aZDx9lmeznhCPyCAbRF+E+Q5j4LYSdtfdHPas8XRL4tV1C3TpHPc6w2NBS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A2FkjbDn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V1Gpbaww/oiBMPzeMThO+Bfx+4TFLql5xCIq5L4WvVo=; b=A2FkjbDnKuaUKlXwCqotrUA9z1
	WanXssLNHoPOUFLl+vxEysEWAo/+7fWIZQV0f+PHMa6KTcRRI+ZsmuebWJ7TLLqxz3DAaskJZbhLc
	pN+TSgWXCAngp88cga8PjtXNK7d6J+91TVUmmsDtOIkYuyy7GVj6LTBSzOcazg9LSKArOHzM3uVT/
	bivxp0ypU1MybCjvZXtFns/f6ZdUeSX3NlFDF2WJtVSIGrKzkRmvnrG+h0IjpjGIG2xu4g5elRZ6u
	pwOt8GkeBT4SHWg0oHJRm5XfVYyJz2oxZcKFdWnca3hni6CYSC05BRXRamPQiExranasFiiWxx4+F
	sbHBnIwg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ2xA-0000000GRpM-20m6;
	Tue, 08 Jul 2025 07:41:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1D6B3300708; Tue, 08 Jul 2025 09:41:24 +0200 (CEST)
Date: Tue, 8 Jul 2025 09:41:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/3] selftests/futex: Adapt the private hash test to RCU
 related changes
Message-ID: <20250708074124.GE1613376@noisy.programming.kicks-ass.net>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250707143623.70325-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707143623.70325-2-bigeasy@linutronix.de>

On Mon, Jul 07, 2025 at 04:36:21PM +0200, Sebastian Andrzej Siewior wrote:
> The auto scaling on create creation used to automatically assign the new
> hash because there was the private hash was unused and could be replaced
> right away.
> 
> With the upcoming change to wait for a RCU grace period before the hash
> can be assigned, the test will always fail.
> 
> If the reported number of hash buckets is not updated after an
> auto scaling event, block on an acquired lock with a timeout. The timeout
> is the delay to wait towards a grace period and locking and a locked
> pthread_mutex_t ensure that glibc calls into kernel using futex
> operation which will assign new private hash if available.
> This will retry every 100ms up to 2 seconds in total.

So the auto scaling thing is 'broken' in that if you do a 'final'
pthread_create() it will try and stage this new hash. If for whatever
reason the refcount isn't '0' -- and this can already happen today due
to a concurrent futex operation. Nothing will re-try the rehash.

This RCU business made this all but a certainty, but the race was there.

I briefly wondered if we should have a workqueue re-try the rehash.

