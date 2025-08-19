Return-Path: <linux-kernel+bounces-775384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A6B2BE88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F211887B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2805320CD2;
	Tue, 19 Aug 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IPT20K5K"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B4253B56
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598136; cv=none; b=qTjccZkGWPmZFmCuONI3oVRm5hdEJUBG4KD+aASkVc0aLR3Sgrx2lmiNNMmwb5ek0cDHkniK/P2TZRqaul2TCGWcmuOHKBAlj7fUiI0L90vf4VAGrr8re0JarbMzoWRTrd/PocHY4+ZC8oyMP0suRZAQ1kKcUjeQ7uo6gEOHulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598136; c=relaxed/simple;
	bh=+txACB+X3vc3b5peBHCJLtbu+Xn8ZQNS4ue+1NJqTKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULzeaivRQeMaVNhprbB8j8MBat5P6lP86iwr+RAVvu7EtdVuljVh5Zz+bPVaUiMggF8dR0bz/MCJuzY3X77GdHAIyoEW6zy8gcqzed2lRjguA5ux7pDocYVETDEGbUSiSC93fXqzHxYStUWVtAGau615gxSQI5E1CPSYjfGvMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IPT20K5K; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qVhCXGbmsJJwi8S4yhVCxLw4FwXst5ChE6QK/bHZT4w=; b=IPT20K5KC2Fw8GdxloUUv9JIko
	TAzhz/CocvenxHK8WLuRDfjQyffThXQ70cvNCqU+qwEY8BBlPmcu97F7M9zCvb2B+YZP0TbBh+Esf
	L6qqv7lEIIwBARch1KqJJp+dSYrdnM9/5FND74aU7FNkxgliAu2pYAiL6EBqXWVDBFQ3gdj7XVFHH
	y4uMX8Xdc+SCc7eaCJXCW6LnsRkf3/VBjGGn0uAm9hbRxy0yeArrU9LdVXEcTy63F9fWIw5OAh79m
	EuJZ0zNmKCSP4S9kaNIOy0PeGnabk5jA7f7lsrnLcRycncbeaCbXlf8M/W1tRH2Dv0wbzFhENuNkG
	DHYDjU1A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoJGi-000000000fj-09qX;
	Tue, 19 Aug 2025 10:08:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0D8CF30036F; Tue, 19 Aug 2025 12:08:39 +0200 (CEST)
Date: Tue, 19 Aug 2025 12:08:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: liuwenfang <liuwenfang@honor.com>
Cc: 'Tejun Heo' <tj@kernel.org>, 'David Vernet' <void@manifault.com>,
	'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>,
	'Ingo Molnar' <mingo@redhat.com>,
	'Juri Lelli' <juri.lelli@redhat.com>,
	'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	'Ben Segall' <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>,
	'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	joelagnelf@nvidia.com
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjQgMi8z?=
 =?utf-8?Q?=5D_sched=5Fext=3A_Fix_cpu=5Frelease?= =?utf-8?Q?d?= while RT task
 and SCX task are scheduled concurrently
Message-ID: <20250819100838.GH3245006@noisy.programming.kicks-ass.net>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <814bebd2ad844b08993836fd8e7274b8@honor.com>
 <228ebd9e6ed3437996dffe15735a9caa@honor.com>
 <8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>
 <20250819074736.GD3245006@noisy.programming.kicks-ass.net>
 <55d707b1f4e1478ea19b022e60805b98@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d707b1f4e1478ea19b022e60805b98@honor.com>

On Tue, Aug 19, 2025 at 08:47:38AM +0000, liuwenfang wrote:


> > Oh gawd, this is terrible.
> > 
> > Why would you start the pick in balance and then cry when you fail the pick in
> > pick ?!?
> > 
> > This is also the reason you need that weird CLASS_EXT exception in
> > prev_balance(), isn't it?
> Yeah, you are right, because there is task migration in our exception process.
> > 
> > You're now asking for a 3rd call out to do something like:
> > 
> >   ->balance() -- ready a task for pick
> We must clarify that the target SCX task is currently located in the global queue, and it's CPU selection maybe CPU2,
> when the current CPU0 will be idle, this SCX task should be migrated to CPU0.
> >   ->pick() -- picks a random other task
> The rq lock of CPU0 will be released during task migration, and higher priority task will be placed on CPU0 rq,
> So the CPU0 will not always pick the target SCX task timely.
> >   ->put_prev() -- oops, our task didn't get picked, stick it back
> The higher priority task may cost a long time on CPU0, so we need to get the SCX task back for its low latency demand. 
> > 
> > Which is bloody ludicrous. So no. We're not doing this.
> > 
> > Why can't pick DTRT ?
> This's why the CPU0 cannot pick one SCX task directly which task_cpu() is not CPU0.

Can you please have a look at these patches from Joel:

  https://lkml.kernel.org/r/20250809184800.129831-1-joelagnelf@nvidia.com

I think it is dealing with a similar problem, and possibly making your
issue worse. At the same time, it might just be sufficient to solve
both.

It would be really good if we can get rid of this prev_balance() hack and
instead make sched_class::pick_task() able to deal with the whole thing.

Notably, I'm thinking that by passing &rf to pick_task() it becomes
possible to do something like (and I'm sketchy here because I'm never
quite sure how ext actually works):


  pick_task_scx(rq, rf)
  {
  again:
    p = pick_local_task();
    if (!p) {
       /*
	* comment that explains why we can drop rq-lock here
	*/
       unlock(rq, rf);
       ... get task from global thing ...
       lock(rq, rf);
       if (rq->nr_running != rq->ext.nr_running)
	 return RETRY_PICK;
       goto again;
    }

    return p;
  }


And Joel's code seem very close to that, but doesn't seem to deal with
your issue.

Anyway, the above has this: 'rq->nr_running != rq->ext.nr_running'
thing, which is supposed to check if there is a higher class runnable
task, in which case it must 'abort' and re-try the pick. We should do
this every time we drop rq->lock.

Now in the case of a dl-server, we'll obviously have the dl-server be
runnable (in fact, its pick is what gets you here in the first place).
But its presence will then make you re-try the pick.

It might just work, it might need a little help -- please carefully
consider that case.

