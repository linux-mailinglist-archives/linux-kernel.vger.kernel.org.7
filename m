Return-Path: <linux-kernel+bounces-657084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3168ABEF13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 11:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AF58C6378
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88323815B;
	Wed, 21 May 2025 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W9Sb2eKA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uUy0QVaz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BEF230268;
	Wed, 21 May 2025 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818228; cv=none; b=Nnxj6BK+rrBBhOgKmoI9y4mAAdCtmk3Ubf9DiL4aouKfbVJ2fqIWDvhEtT2JLBuCcAHjloppXglry2g6Tm6E2mz1vDuqhtAhcwOaE72NRv84fKNqkOqLNTx30Nez44LTMaWHBHDqCifCiCMc3DoueDD+4rE/PHa0hNNGo7Q9U/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818228; c=relaxed/simple;
	bh=PCE6LSVt1T9swMpEpefnmPyR908xT/dzCXHH6xdDWVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA7eWHCzGTIizceL8D3tIgAMs14KiKgkrDPIpfFff3uBI56QwOj2VieDa77CU95FqAvXm7Q7MgCD6EC1Fh8fD33LaRMGH66KsGRWMpYUfiKHKfn5Q3yoDo70syWo0DW7zNY85xSoINzh/4G3N9DRTn5E38nJ7xeA/MefsVyduIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W9Sb2eKA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uUy0QVaz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 11:03:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747818224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7WKk454nZ5z7mTMr0u//RgRu0zeGFgAgehInroqNVQ=;
	b=W9Sb2eKAX9r4Z9mVFdvQbOc/uyRHh5TATQuw+oJkimDjXi77IQO67txtyOxV5Z1mb0xNkK
	tl0KAI7a27OFNb78JT2QUzs/DUAbBIUdpV2LqfZFOTkx3MJM2vacRlpFl7t0xtd4/Ph/Q2
	Z5XCmMBHLYhpZupS5NXKincovE0ucYQYNXPzD4Ho6VbcdeoEaSJZEvLeXfNrxwfnow4foR
	tyg+tSXIXvvlmKGYUMO01Uky9d8Unz0Z3ZbQ6G0Pq74Fopof23ZiE9/1p0+7eT3XR4SCj/
	ScAxPPNJiCHlBOWmPzDqQ6yPgWWrtyZEKTwc6Nc+xAjE9tlwJzIsRX5l7Hznqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747818224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7WKk454nZ5z7mTMr0u//RgRu0zeGFgAgehInroqNVQ=;
	b=uUy0QVaz9/+cz0oViaHoaQ8XiptZDPfm2VwHMg5MQ9S3pbr8+LNpPxiXyV3SVee3Fn3Too
	Hde/GQ/TmCT91EAQ==
From: Nam Cao <namcao@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250521090343.TKXXN2x0@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
 <f5fccde2326a896e5c568ef06a4dbd9aa7465f6a.1747046848.git.namcao@linutronix.de>
 <aCtE-RvyN6XJQjTo@arm.com>
 <20250520122548.lkvaylSB@linutronix.de>
 <aCyOZVVioijWpEPY@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCyOZVVioijWpEPY@arm.com>

On Tue, May 20, 2025 at 03:15:01PM +0100, Catalin Marinas wrote:
> On Tue, May 20, 2025 at 02:25:48PM +0200, Nam Cao wrote:
> > On Mon, May 19, 2025 at 03:49:29PM +0100, Catalin Marinas wrote:
> > > On Mon, May 12, 2025 at 12:51:00PM +0200, Nam Cao wrote:
> > > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > > index ec0a337891dd..55094030e377 100644
> > > > --- a/arch/arm64/mm/fault.c
> > > > +++ b/arch/arm64/mm/fault.c
> > > > @@ -44,6 +44,9 @@
> > > >  #include <asm/tlbflush.h>
> > > >  #include <asm/traps.h>
> > > >  
> > > > +#define CREATE_TRACE_POINTS
> > > > +#include <trace/events/exceptions.h>
> > > > +
> > > >  struct fault_info {
> > > >  	int	(*fn)(unsigned long far, unsigned long esr,
> > > >  		      struct pt_regs *regs);
> > > > @@ -559,6 +562,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
> > > >  	if (kprobe_page_fault(regs, esr))
> > > >  		return 0;
> > > >  
> > > > +	if (user_mode(regs))
> > > > +		trace_page_fault_user(addr, regs, esr);
> > > > +	else
> > > > +		trace_page_fault_kernel(addr, regs, esr);
> > > 
> > > What are the semantics for these tracepoints? When are they supposed to
> > > be called? In the RV context context I guess you only care about the
> > > benign, recoverable faults that would affect timing. These tracepoints
> > > were generalised from the x86 code but I don't know enough about it to
> > > tell when they would be invoked.
> > > 
> > > For arm64, we also have the do_translation_fault() path for example that
> > > may or may not need to log such trace events.
> > 
> > These tracepoints are invoked for x86 page fault exceptions. Are arm64's
> > translation faults considered equivalent to x86 page faults?
> 
> Probably. We route permission or access flag faults via do_page_fault()
> directly while missing page table entries via do_translation_fault().
> The latter end up in do_page_fault() only if the faulting address is in
> the user address range.
> 
> My point was that we may not always invoke the trace callbacks if, for
> example, the user tries to access the kernel space (and results in a
> SIGSEGV). While that's fine for RV, I wanted to know what is expected of
> these trace points in general. Do we need to log such SIGSEGV-generating
> events? We do log them if there's a permission fault.

I'm not sure. Digging into history, these tracepoints were added for LTTng.
So maybe LTTng's developer could answer this.

Added to the conversation: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Can you please give some insight to the above question?

Best regards,
Nam


