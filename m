Return-Path: <linux-kernel+bounces-895275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA694C4D682
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB513B67F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5AF3563DF;
	Tue, 11 Nov 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S08h0bVJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E03559C4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860300; cv=none; b=QSrWXnsm7woKb2uABR7ReY/axxy4jj9MIeOPI8Sj7Buvc/tvMOTl1jjFrcP9xF3zw0Wre4XwV1Tl7iOASgxAyjDmeo/4emCbL86Ej8Bw3RM7fIM+0GNfdmq8wGNL0smiJZPJg/TGLGvRR7XqR4Ey8R7MxyD6Ph2udRXjQEnE3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860300; c=relaxed/simple;
	bh=l78xUjywc6Bql46xhOMlUfw0d55inHz4vfyIjb3d/r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFxGdFflWnI8wRh9iFpNewqqMxQbNoSFB0gXOWOQF/eBcGuqCpauoYvmoI0ZcG2cOvBhm+8j/RM6y7lXuW4PmJoVBkh8ECJr3o/Hdbxm/WOSFwDjtVALlwIamb+44xavDis8qhtJxDQ/0DF4Fz7HjrzRxTZlkDkiwu//ioVV3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S08h0bVJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=smXZ1Viq1l246VSTAsYLzZC/c8EM+fmoMM+ZSPYMo0s=; b=S08h0bVJc6EmoPSp9TYeibyYRs
	6QRt4KNAIflrQ0n781yrpEasn9qj7ZFrUHE6eZ807qKUtTBrXnvQlO7WpvUQ0kADlmIyqsL0iPXqw
	7oJUo6nkC0jIumv1H3ntlP8AKsRl9q/ph5pki0cnLgY2A9byhbRe1XYh+ftuy1pBJQtYRgKAf3S8v
	ZGAkU5zJNrKcnLGqrER7Uoz65dmtWH7dElaKhZvJOb6BVTShwOXGCA5ohGJsIK4eaEyZXS0WM962s
	Wbq/NkflWwhqukRYc4vHhHSnMhHEF3m5BmaZJ80roWXkQeYlz8QDGkeWE/bM1X8QHh9kVEnic9gV6
	XhP8fxPw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vImUa-00000004CKY-3K8K;
	Tue, 11 Nov 2025 11:24:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 478F5300328; Tue, 11 Nov 2025 12:24:56 +0100 (CET)
Date: Tue, 11 Nov 2025 12:24:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>, arighi@nvidia.com
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251111112456.GB1421687@noisy.programming.kicks-ass.net>
References: <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
 <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
 <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
 <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>
 <20251031154455.GU3245006@noisy.programming.kicks-ass.net>
 <20251101000057.GA2184199@noisy.programming.kicks-ass.net>
 <b8454329ce061f0c113b25b9400e2b0771fa9e27.camel@redhat.com>
 <20251111111716.GL278048@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111111716.GL278048@noisy.programming.kicks-ass.net>

On Tue, Nov 11, 2025 at 12:17:17PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 11, 2025 at 10:58:51AM +0100, Gabriele Monaco wrote:
> 
> > Is there a reason why dl_server_stop() doesn't reset the running flag?
> 
> Yes. Suppose we're boosting a task, and that task has a small sleep
> (mutex or whatever). The dl_server won't have anything to actually boost
> and will stop itself, clearing running (if dl_server_stop() were to
> clear running).
> 
> Then if the initial fair task wakes up again, we'll (re)start the
> dl_server, but since !running, it will go do the whole defer/zero-laxity
> thing again, making out task wait for a whole period until it can run
> again.
> 
> Conversely (dl_server_stop(), like now, does *not* clear running), if
> running is retained, the dl_server is able to immediately resume its
> still valid runtime.
> 
> Put otherwise, a fair task that always runs and a fair task that has
> micro-sleeps should more or less behave the same. We should not punish a
> micro-sleep with a whole second delay.
> 
> Now, if the sleep is long, we'll find the deadline is in the past and
> then it pushes the activation forward and we go ... Oooh to E.

Ah, no, replenlish_dl_new_period() sets defer_armed = 1, so
start_dl_timer() from enqueue_dl_entity() will end up in zero-laxity
wait.

Damn, so much notes and I still get it wrong :-(

