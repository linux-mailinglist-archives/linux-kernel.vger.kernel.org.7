Return-Path: <linux-kernel+bounces-893346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B428BC47205
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E02954E65D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598C53128B5;
	Mon, 10 Nov 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k1Dz20DD"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC1305040
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784274; cv=none; b=nZXYtC9kp+Mdsm1M+zAtepeNXPDQ6vW+dNG7Jsr7oJDBugAEPTlFH6r3uqZifr6HUf3/6WZ8Ten6XMAk2DPFww1DuR7Ca21a3S8sthvRn8gU9bjQDVYjQwYNhO6/7VP6WWb8OhRuVqte6ro5KjI9iZ6k25RplrqkSBBumAokeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784274; c=relaxed/simple;
	bh=maAL2PS8gnFAKQ8A9Y3ibGQgpRFn3XhY6zS4oVV/r8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebrFYpx5uEXvDIcFbLMyN78bJ7j876Hu7KOjHZdlAjAomCzuZTlK54EQSus0FT7sI0gO9t+euKU/TNG0VLXLHCczwtOTzRbnUZiT4JCdpEB7Y5e5NYX6cXs/Fh+ySTyHIA2Sc74OkuIlEW0zL98XZEtMK1L9c9CqK5i3ClyitYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k1Dz20DD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b+5gsT4Irai6lhdbFxT+O9QDwikeaX8L5w3F5RUIujU=; b=k1Dz20DDZ7P/rvqykJEPGuaqMB
	NylJGBztz66eERE4y+oRcZipwatJzOUyQ6Zzv55mGSOH54+t3/71TxN8R8eYMKIwgD+sENoRm7s55
	OW2GyHNXt7NskWalNDu2IgPNofeiivSpeHrVi9pNtSETJCZbaen/zbKW9hAPKIG8UFuYzG+3dd4Zh
	QizWC3WRk5bx4yJMPVd8IUlfS9NzDwBFvQ8L4khVffzU9L5rhzPGatq3oFTtwooP4FTD09AT44zrP
	q8zydKv2GT2J8/ePYtxrq3m1kwUurHc4hmkT80NM17dgrKZ12z5I6MVyUsVm2pCi0M5smK+vlf3ro
	Lt2Kjodg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vISiJ-0000000H2Dm-26XR;
	Mon, 10 Nov 2025 14:17:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0517D30029E; Mon, 10 Nov 2025 15:17:47 +0100 (CET)
Date: Mon, 10 Nov 2025 15:17:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: juri.lelli@redhat.com, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, nico@fluxnic.net
Subject: Re: [PATCH 1/2] sched/deadline: minor code cleanups
Message-ID: <20251110141746.GD4068168@noisy.programming.kicks-ass.net>
References: <20251014100342.978936-1-sshegde@linux.ibm.com>
 <20251014100342.978936-2-sshegde@linux.ibm.com>
 <20251110141038.GY3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110141038.GY3245006@noisy.programming.kicks-ass.net>

On Mon, Nov 10, 2025 at 03:10:38PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 03:33:41PM +0530, Shrikanth Hegde wrote:
> > - In dl_server_timer, there is same dl_runtime check above. So
> > this check is duplicate. This could save a few cycles.
> > 
> > - In select_task_rq_dl, there is only one goto statement, there is
> > no need for it. 
> > 
> > No functional changes.
> > 
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > ---
> >  kernel/sched/deadline.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 7b7671060bf9..8b7c4ee41fd8 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1166,9 +1166,6 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
> >  		sched_clock_tick();
> >  		update_rq_clock(rq);
> >  
> > -		if (!dl_se->dl_runtime)
> > -			return HRTIMER_NORESTART;
> > -
> >  		if (dl_se->dl_defer_armed) {
> >  			/*
> >  			 * First check if the server could consume runtime in background.
> 
> That one got lost here:
> 
>   https://lkml.kernel.org/r/20251020141130.GJ3245006@noisy.programming.kicks-ass.net

I deleted this hunk and frobbed the changelog. Should be in
queue/sched/core now.

