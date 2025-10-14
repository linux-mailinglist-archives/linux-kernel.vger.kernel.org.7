Return-Path: <linux-kernel+bounces-852358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A7BD8C15
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AE9C352873
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846112E2EF8;
	Tue, 14 Oct 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E/6qTfJn"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BC2E3B03
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437548; cv=none; b=O5upsDFdduzHnx3cU3HvlXemO2F1QBcqsQoY44sywYVEIUpkab0rBk0ptspf97TFI+gtPciLx9KVNJN2Q/a5lAgZPijRllQ1ojJcoo6Mahg9JQGZ0b0jRVO5RSQQjYRlju+rNvkfPJzlcvVqYnSUctHMvVoWz+TFmZrgGBun2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437548; c=relaxed/simple;
	bh=hldQPC/V4ErsVRdYyG2c1n4CJWf23iEAquj+v9aVAMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaySGsDhNKeiN4vw8d+N837JzMe4FQ829/P+0G45vnUeQISCgsbv/rg3rH8ONt/Miv73EctSk/rDYg1oJDYg5gWIYKAPLJxhkfRjmSSNabZn2VIZKj/9OGPGEVDZma5hkapWawupRdrhmW+MhyXQcDzLl2Qd8cmpPSq2CLyMSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E/6qTfJn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yTcvj/m+8T9fDMdpZRmWFmFgYnbasklbK0kXEkPx88U=; b=E/6qTfJnjimHmEVOjHfVEvSyM2
	+/cwrazW/Qhy4OOPqYTzI+chQ36cGEZzEhdoPtuuLaksf4jTuPllb77ZXaRJPlyc26Bg+2o7XDII+
	IvYL7IaX8RSfGpyvAjj1cU13g1x7pje4s6viv6lQWwTK8VVYBzDdKMAdDAwG69n7x13fcZniyMy6T
	+xBr8fPyX8ErWtdWFr2BKVSh1J0OCR3R7pPRdIT8FEwInEFMOXk4rV0aUIyhhXlyX2/qqpVPo1exI
	zO3xATqGiQwMiAHTe4/yyKWgwajAW/Y/LW/HhLQlT0kp0Rx/66i9UnOX5Hdk+xTVlAHXN61joDuPR
	v7iTOQPg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8cDv-000000055ji-1Y2C;
	Tue, 14 Oct 2025 10:25:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EB9C4300289; Tue, 14 Oct 2025 12:25:41 +0200 (CEST)
Date: Tue, 14 Oct 2025 12:25:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
References: <20251007122904.31611-1-gmonaco@redhat.com>
 <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>

On Tue, Oct 14, 2025 at 12:05:06PM +0200, Gabriele Monaco wrote:
> On Tue, 2025-10-14 at 11:54 +0200, Peter Zijlstra wrote:
> > On Tue, Oct 07, 2025 at 02:29:04PM +0200, Gabriele Monaco wrote:
> > > Recent changes to the deadline server leave it running when the system
> > > is idle. If the system is idle for longer than the dl_server period and
> > > the first scheduling occurs after a fair task wakes up, the algorithm
> > > picks the server as the earliest deadline (in the past) and that boosts
> > > the fair task that just woke up while:
> > >  * the deadline is in the past
> > >  * the server consumed all its runtime (in background)
> > >  * there is no starvation (idle for about a period)
> > > 
> > > Prevent the server from boosting a task when the deadline is in the
> > > past. Instead, replenish a new period and start the server as deferred.
> > 
> > I'm a bit confused, should not enqueue ensure deadline is in the future?
> > And if it doesn't shouldn't we fix the enqueue path somewhere?
> 
> Enqueue of a deadline task should handle the case, here the CPU is idle and the
> deadline server did not stop yet (and won't until the next schedule, if I'm not
> mistaken).
> The following enqueue of a fair task triggers a schedule where the server (no
> longer deferred) boosts the task straight away.
> 
> Now the only check for deadline is in pick_next_dl_entity, where the earliest
> one is chosen, despite being in the past.
> 
> Do you mean to check for deadline when enqueueing the fair task too? I believe
> again nothing happens here because the server is still up.
> 
> Does it make sense or am I missing something?

Lets be confused together :-)

So dl_server is active, but machine is otherwise idle, this means
dl_server_timer is pending, right?

This timer is in one of two states:

 - waiting for replenish; which will trigger and switch to 0-laxity.
 - waiting for 0-laxity

So that 0-laxity case is the interesting one; when the machine really is
idle, no fair tasks will run and its runtime budget will not get
depleted. Therefore, once we hit 0-laxity, it will do
enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH).

This enqueue should ensure dl_se->deadline is in the future, right?

Anyway, we run this deadline entity (there ain't nothing else to do
anyway), and it finds there aren't any fair tasks, it does
dl_server_stop().


Then, if a fair takes wakes (nr_running: 0->1) and dl_server isn't
active, we do dl_server_start(), which in turn does enqueue_dl_entity().
Now this enqueue is supposed to check if the dl_entity can still run;
does it still have time left in its current period, if not, its
replenish timer time.


So where exactly does the fair task start, and result in dl_se being
on_rq such that dl_deadline is in the past? That sounds like an enqueue
problem to me.




