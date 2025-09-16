Return-Path: <linux-kernel+bounces-819033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CABCB59A66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0310527100
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417B324B1B;
	Tue, 16 Sep 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1WzdFiB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADEC2EA489
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033056; cv=none; b=F9J5yowNcIibZLir7ZaEc3H7J6SmwWGoxz4sYDXqLVyhX8MEwsmnanHjeow/8oOZd/RcWmN38ylRee/kAUo3Upi/ht9tGKWsNOBvuul2/hOaGWKfoEPc91KPaTk146NsYBhwfonIIIyVndnfwQesIXFR5nBGNw5Tt/a38qn1Qq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033056; c=relaxed/simple;
	bh=+trAVtA/0EbWkj/7hbe68mcCHJVeD4GHIk4+IXLr0KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCkfJ3eEDLdAvHkJ4u6WsyjT4K6Xt4AJdAEcxsNJ9WMxpcD6Rrvl3UzY1Lw0z/5/89w7s1Y0k9QQ/rP+L6mlTct4//wHRlCCf98HHQxzfqzb/uLXmSgcJIGRg5UuvLdp4YktJf4SBRilp4qErtxUuS4QNUV2HY/Y5tw8NmvFccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B1WzdFiB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hw7+LBg9WA2gnlZUob3Phb5kC61ygv5fJ0boTwKhn+M=; b=B1WzdFiBPVSHuKnWvNtEfr/hHL
	5XmEavo6HFRMDjWriEDVi30ZMNZKOcWStTHZPZ2kTADuAokhPNesxKkx02Cry0Z+/CTIKnr/KpdcH
	g5h1GIKGKb9pEN0MlLX0S0G6kE3V9Vi1izUlRFxSUikorfvUOmyeH3mNbP4izg0HWCL/VacqOZe3P
	4xbZmYYwfpCOjaDFr67LxgOwMFuQ2A1apnSAi1pg2AIMNFfGvq4VekN9W03mB+wNrLptC/uFEEfPL
	ssjtzHdInouRt56bAjVum7GAlyEwbpH+sSd+YpwPMYhmlyoh8KUS7gmCxNjZmHxV9ta7SH2o2o4Gk
	OMqRQo+Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyWhh-00000006KdN-1Ly5;
	Tue, 16 Sep 2025 14:30:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 363BA300328; Tue, 16 Sep 2025 16:30:44 +0200 (CEST)
Date: Tue, 16 Sep 2025 16:30:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
Message-ID: <20250916143044.GL3245006@noisy.programming.kicks-ass.net>
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com>
 <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <aMldnFrGfcMECbmK@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMldnFrGfcMECbmK@jlelli-thinkpadt14gen4.remote.csb>

On Tue, Sep 16, 2025 at 02:52:44PM +0200, Juri Lelli wrote:
> On 16/09/25 13:01, Peter Zijlstra wrote:
> > On Tue, Sep 16, 2025 at 10:51:34AM +0200, Juri Lelli wrote:
> > 
> > > > @@ -1173,7 +1171,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
> > > >  
> > > >  		if (!dl_se->server_has_tasks(dl_se)) {
> > > >  			replenish_dl_entity(dl_se);
> > > > -			dl_server_stopped(dl_se);
> > > > +			dl_server_stop(dl_se);
> > > >  			return HRTIMER_NORESTART;
> > > >  		}
> > > 
> > > It looks OK for a quick testing I've done. Also, it seems to make sense
> > > to me. The defer timer has fired (we are executing the callback). If the
> > > server hasn't got tasks to serve we can just stop it (clearing the
> > > flags) and wait for the next enqueue of fair to start it again still in
> > > defer mode. hrtimer_try_to_cancel() is redundant (but harmless),
> > > dequeue_dl_entity() I believe we need to call to deal with
> > > task_non_contending().
> > > 
> > > Peter, what do you think?
> > 
> > Well, the problem was that we were starting/stopping the thing too
> > often, and the general idea of that commit:
> > 
> >   cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
> > 
> > was to not stop the server, unless it's not seen fair tasks for a whole
> > period.
> > 
> > Now, the case John trips seems to be that there were tasks, we ran tasks
> > until budget exhausted, dequeued the server and did start_dl_timer().
> > 
> > Then the bandwidth timer fires at a point where there are no more fair
> > tasks, replenish_dl_entity() gets called, which *should* set the
> > 0-laxity timer, but doesn't -- because !server_has_tasks() -- and then
> > nothing.
> > 
> > So perhaps we should do something like the below. Simply continue
> > as normal, until we do a whole cycle without having seen a task.
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 5b64bc621993..269ca2eb5ba9 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -875,7 +875,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
> >  	 */
> >  	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
> >  	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
> > -		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
> > +		if (!is_dl_boosted(dl_se)) {
> >  
> >  			/*
> >  			 * Set dl_se->dl_defer_armed and dl_throttled variables to
> > @@ -1171,12 +1171,6 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
> >  		if (!dl_se->dl_runtime)
> >  			return HRTIMER_NORESTART;
> >  
> > -		if (!dl_se->server_has_tasks(dl_se)) {
> > -			replenish_dl_entity(dl_se);
> > -			dl_server_stopped(dl_se);
> > -			return HRTIMER_NORESTART;
> > -		}
> > -
> >  		if (dl_se->dl_defer_armed) {
> >  			/*
> >  			 * First check if the server could consume runtime in background.
> > 
> > 
> > Notably, this removes all ->server_has_tasks() users, so if this works
> > and is correct, we can completely remove that callback and simplify
> > more.
> > 
> > Hmm?
> 
> But then what stops the server when the 0-laxity (defer) timer fires
> again a period down the line?

At that point we'll actually run the server, right? And then
__pick_task_dl() will hit the !p case and call dl_server_stopped().

If idle==1 it will actually stop the server, otherwise it will set
idle=1 and around we go.

