Return-Path: <linux-kernel+bounces-773677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12431B2A514
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB45676E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F11258EE6;
	Mon, 18 Aug 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1aBZ/u6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vdbA64m9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C522A7E0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523020; cv=none; b=dyAdIjELduheTJ/FVWTx0ya7gDvhHETLETBmyjiaPjtMi+6Z3Ds3NnOen83B4N41s5LIAKPCVljLcmGpzBhkKPDp3vA9bq/lPDuy1vgrI46LeIfGmMVL1l8ZhRX42oUZ3vhd6wi84n28+uSCRoKrScOdDxhE/KSqwJO1x1e4VMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523020; c=relaxed/simple;
	bh=4VsFzLn7yeppnxl0zFHdA8oC6di4rKpKDVwU1k1yYXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/HJvcDztE+nnZjHs/Mh8NNCg15nk2EBNWlme8DopjO/6cSabyQX5BW2Ddlszgp6xHhMItKFdyyFncifYieirgOGZzk+lQcvbub/H34dIlIsa9YO9abfkp6TmQkwUD8p4FQCVakUwL+UNpvQyBmerjj6uKQYqPssd815FTYjETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1aBZ/u6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vdbA64m9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 15:16:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755523016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oGxlUxlwRzA7Te+PJK2UytkyniCrG3aVV5ezy6MYdM=;
	b=R1aBZ/u6xA0E35B6RWc2ozIJ6OKPf5RUyQLfzC61Rh1HoyKrgjVfniuIwT8ZW73d32i5n0
	MRxAsKsQrDWeEKXMHXrmFC+3g2au36m8l947CXOb3IjQ+HQUzaOJWGriCq4OTHc9MSuvMB
	RM+nEBI3Zocskcmf2+k01VYMuZg4xquMinLCReOIaBNJ5mqm0qiygLTuLApBIpE28qA6gW
	WbjIXstqNKZzKgZoMTJygH0HMO1bgSMWGrFt9V0RiKDaJvAnVGCDCL10qJvkHfxb/mGVTH
	ycfEpPMxXjWPtUyPq8j5wEYR5LHb4s1Zt0BoBtMFfwrgcSG7aMRPQ/PudAAl6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755523016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oGxlUxlwRzA7Te+PJK2UytkyniCrG3aVV5ezy6MYdM=;
	b=vdbA64m9Wig62jxQDvgZScddHzGZZdDQIpuqh3lQ2k9s+LrT/hKQSxCevpBPHuItnhzCef
	IGnvOFwkXHd0jfBQ==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
Message-ID: <20250818131655.1FybFuR4@linutronix.de>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-3-prakash.sangappa@oracle.com>
 <87a54bcmd7.ffs@tglx>
 <BF199244-10DF-4B84-99AF-DDA125F775E4@oracle.com>
 <87o6smb3a0.ffs@tglx>
 <20250813161927.CFYHxNIv@linutronix.de>
 <87jz376tzj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jz376tzj.ffs@tglx>

On 2025-08-13 18:56:16 [+0200], Thomas Gleixner wrote:
> On Wed, Aug 13 2025 at 18:19, bigeasy@linutronix.de wrote:
> > I spent some time on the review. I tried to test it but for some reason
> > userland always segfaults. This is not subject to your changes because
> > param_test (from tools/testing/selftests/rseq) also segfaults. Also on a
> > Debian v6.12. So this must be something else and maybe glibc related.
> 
> Hrm. I did not run the rseq tests. I only used the test I wrote, but
> that works and the underlying glibc uses rseq too, but I might have
> screwed up there. As I said it's POC. I'm about to send out the polished
> version, which survive the selftests nicely :)

It was not your code. Everything exploded here. Am right to assume that
you had a recent/ current Debian Trixie environment testing? My guess is
that glibc or gcc got out of sync. 

> > gcc has __atomic_fetch_and() and __atomic_fetch_or() provided as
> > built-ins.
> > There is atomic_fetch_and_explicit() and atomic_fetch_or_explicit()
> > provided by <stdatomic.h>. Mostly the same magic.
> >
> > If you use this like
> > |  static inline int test_and_clear_bit(unsigned long *ptr, unsigned int bit)
> > |  {
> > |          return __atomic_fetch_and(ptr, ~(1 << bit), __ATOMIC_RELAXED) & (1 << bit);
> > |  }
> >
> > the gcc will emit btr. Sadly the lock prefix will be there, too. On the
> > plus side you would have logic for every architecture.
> 
> I know, but the whole point is to avoid the LOCK prefix because it's not
> necessary in this context and slows things down. The only requirement is
> CPU local atomicity vs. an interrupt/exception/NMI or whatever the CPU
> uses to mess things up. You need LOCK if you have cross CPU concurrency,
> which is not the case here. The LOCK is very measurable when you use
> this pattern with a high frequency and that's what the people who long
> for this do :)

Sure. You can keep it on x86 and use the generic one in the else case
rather than abort with an error.
Looking at arch___test_and_clear_bit() in the kernel, there is x86 with
its custom implementation. s390 points to generic___test_and_clear_bit()
which is a surprise. alpha's and sh's isn't atomic so this does not look
right. hexagon and m68k might okay and a candidate.

> Thanks,
> 
>         tglx

Sebastian

