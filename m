Return-Path: <linux-kernel+bounces-883051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D8FC2C59A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDE4D34A648
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314B92F7AAE;
	Mon,  3 Nov 2025 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chqN+X+9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F019F127
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179268; cv=none; b=BV9Zo8wr6/GwxOW1UVpwMlUH/OlAoeAGz5qFbv/yiudsMvUh+dwk8MowP2E4sEGT9jFCLkYpVMc1FBfS1WkmyJ+XRHccdvHlZ450ILvefuMEqiZ572KABKR+P/bhDt38G6h9I/B+OeeemhC0MyzOGef69isJxrsgUuXYNwLn3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179268; c=relaxed/simple;
	bh=JGaArpyjlVW/76SFOKStdpgXS3RCeB+iXVixw2rgAJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2JgWKN7PL91dpsJsQ2fIMLAyCkaUH8pBwQeHM3g6oOoJ8TobK6mcPUOx4XCDYa95et079F6COo1JaMUpP1/KIdLOhMrLEcKpagaGMN/FD1Yfeb51nudDE2d67R1AIR/rm3PO8GeipFY7gHaJwtoPAWUwlmAT3sO/7OVCwPs6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=chqN+X+9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cCbR8BW+licPz9CLpgORR1v7fuvmYJ7LlKX3uzYVqLU=; b=chqN+X+9wFGec/93Uq/evRSkyH
	LuVaBZoV0gcookgG/5Ts/reQLB5EPUV61blyJSzfarcWIhImZQl8BzIUfOFtta+pFG1gDWgCGv084
	0FbJZ59cOF5aLJFCqsu3A+suUgfuYaLcrVIz8iu4NNX+/f6dYM45lngFv18WE26xnH/lM9mdEhWuy
	V6BMqQwF7urix6OiZACoxfCKmc5E/TIMY4hS1TKhpE9zXXXDfM7xuTCI0jH7OgZ6v/XBo7Bq7pqSW
	Ua4tXlaHLHhixhrROxWGR3uM5kIiX06g7oOBcskHwVEmAn0wTWE3PuOQXcce0XzQuwYDDPLNWhmAI
	1B/qFycQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvK8-00000008Ip8-1fNw;
	Mon, 03 Nov 2025 14:14:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2034E300220; Mon, 03 Nov 2025 15:14:21 +0100 (CET)
Date: Mon, 3 Nov 2025 15:14:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <20251103141421.GW4068168@noisy.programming.kicks-ass.net>
References: <20251103110445.3503887-1-mgorman@techsingularity.net>
 <20251103110445.3503887-3-mgorman@techsingularity.net>
 <20251103140711.GB3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103140711.GB3245006@noisy.programming.kicks-ass.net>

On Mon, Nov 03, 2025 at 03:07:11PM +0100, Peter Zijlstra wrote:

> > @@ -8734,7 +8819,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  	struct sched_entity *se = &donor->se, *pse = &p->se;
> >  	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
> >  	int cse_is_idle, pse_is_idle;
> > -	bool do_preempt_short = false;
> > +	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_NONE;
> 
> I'm thinking NONE is the wrong default

That was unfinished, kid interrupted me at an inopportune moment and I
lost my train ;-)

Anyway, the current code defaults to what will be 'pick'. And I suppose
we could make the default depend on WAKEUP_PREEMPT but meh.

