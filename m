Return-Path: <linux-kernel+bounces-733582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EDDB0769A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05333AD292
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4FA2F4317;
	Wed, 16 Jul 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VRO6KPZ+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20217BE65;
	Wed, 16 Jul 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671331; cv=none; b=apN8IqZNHSFN9lUMsaAwlVIfuLtoE5ggHJAF487u2w3XjbwLaK4MWBU51JPlHoJL8gHR3uCl/pX16SiQoUJayShJ9mg1wz7IrzyaaA5CeTPyUgwYx6ex8jy1VgLRp+Vrv1fkCefT1S0lsuTkxUyRT0CeXiJ+z1MnIkZNF5B166o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671331; c=relaxed/simple;
	bh=7QmweYLy0doCZbujsf0EKw1OnFdtVKhmIo1nkk52TAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQxHcajK//kqoUJY5RjjNCDw9PNsRbUhqMvuyn4Pvh+2GZyLADLsN93R+8FU9xLXmkQKENm4UBtGn0MdHOKltRZ51BiLqQgtZ7yykEvT0LfYC62hea52LKqTqOToC+HZJidbaBtQN9iy/4ivHlTGe57Sv4fKk+P5sLHS/gwLZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VRO6KPZ+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SpHBP6E5OrGJuNGQHIKVt2RCVzUGiSyros9YkguCPtA=; b=VRO6KPZ+sIm4xNQR7QG+tY+Pm1
	Y8aLSPfzNcCmU8kRmixqvqClBEo+BhUBrvD6YTCXIi+EQaVkJmYnCzRKLLBoSQQitICcwAagZpxin
	Q8tTisGvV3BIXHMAynFjoJ8ERSU7mqtvWKKD3quuGvjFe1aKbZm3UqIWPt+CXxyZ++uePx5Sr9dJm
	U2nwA0XNfPGSWZUjj62eUM2IxVnsNIH2/Q5lKeJ84unKzwkvNRDdBiIfYpClPCEcVBvU4jK+uoNzA
	0xFrX/s5WOIh/8RCdBc2KhqcxpuwAmAsBUWKnQzv7L1e9B4iQM/wcEsCDAZPxc9T88ZAJ57yKk4mf
	+4TRIrgw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc1sN-0000000Gcys-2Nva;
	Wed, 16 Jul 2025 13:08:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF846300186; Wed, 16 Jul 2025 15:08:46 +0200 (CEST)
Date: Wed, 16 Jul 2025 15:08:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
Message-ID: <20250716130846.GC3429938@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-2-gmonaco@redhat.com>
 <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
 <21b23f125e20102440e36da08a039d88bdf58eb1.camel@redhat.com>
 <20250716124105.GX1613200@noisy.programming.kicks-ass.net>
 <5aa9b70894f464dbff8e317cbd8fc188db9920e4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aa9b70894f464dbff8e317cbd8fc188db9920e4.camel@redhat.com>

On Wed, Jul 16, 2025 at 03:05:50PM +0200, Gabriele Monaco wrote:
> On Wed, 2025-07-16 at 14:41 +0200, Peter Zijlstra wrote:
> > On Wed, Jul 16, 2025 at 02:18:28PM +0200, Gabriele Monaco wrote:
> > > On Wed, 2025-07-16 at 13:50 +0200, Peter Zijlstra wrote:
> > > > On Tue, Jul 15, 2025 at 09:14:18AM +0200, Gabriele Monaco wrote:
> > > > > Currently, the userspace RV tool skips trace events triggered by the RV
> > > > > tool itself, this can be changed by passing the parameter -s, which
> > > > > sets the variable config_my_pid to 0 (instead of the tool's PID). The
> > > > > current condition for per-task monitors (config_has_id) does not check
> > > > > that config_my_pid isn't 0 to skip. In case we pass -s, we show events
> > > > > triggered by RV but don't show those triggered by idle (PID 0).
> > > > 
> > > > The distinction between !my_pid and has_id is that you can in fact trace
> > > > pid-0 if you want?
> > > > 
> > > Yes pretty much, no flag is meant to skip events from pid-0.
> > 
> > > > > -	if (config_has_id && (config_my_pid == id))
> > > > > +	if (config_my_pid && config_has_id && (config_my_pid == id))
> > 
> > But should we then not write:
> > 
> > 	if (config_has_id && (config_my_pid == id))
> 
> Sorry, got a bit confused, I flipped the two while describing:
> * -s shows traces from RV but skips from pid-0 (unintended)
> * omitting -s skips events from RV (correct)
> 
> If we are running a per-task monitor config_has_id is always true, we pass -s,
> which makes config_my_pid = 0 (intended /not/ to skip RV).
> Now when we are about to trace an event from idle (id=0), we skip it, although
> we really shouldn't.
> That's why we also needs to check for config_my_pid not being 0.
> 
> Does it make sense?

Sorta, but would it not make sense to use has_pid := -1 for the invalid
case, instead of 0, which is a valid pid?

