Return-Path: <linux-kernel+bounces-727642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF0B01D75
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5B51882388
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155DE2D3754;
	Fri, 11 Jul 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XGf2vTeK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF32882AA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240538; cv=none; b=ErpJOnvtj5yhuY7yLIMLfRyKK2Jqskva8bcX0csKv84hBhBRr9RPzjTFiwWG8lcVr4NIDAmgjzJeH67ATD4Qdvd590S3B37+B0lsuJI90RCBI2SX3LiJpDIYldtiw9NBtInsjzYR+UovWJkaqeNW8eoQTWOqKxRiMOi8xtJ+YpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240538; c=relaxed/simple;
	bh=NNYSpfoYhvMUwN47wdh+SiKRzOPfsLp7BsUHFcweUzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIYmGSHoAOdf7zNqlTmHIONiGNtkb1Nu1BMTXva3PKubckyn8y21P6kZc4zMuD+r/i8ggiBFGY+auDnUeT6/TTWcQFBKcpGvJv6OWbu2bVviNp/FJSZqHzE5L3m8k0ZC34ISI07sywr+zHD5ZbJXPcT4lhSEGez2zC9PiZOSIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XGf2vTeK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TKhoFis58EaUC1NN2qtSGAvGZOKBymUVDZkgzs0wK/E=; b=XGf2vTeKLaMhUdlA9MleLY8WSV
	wwMweHRuJ3on8AcZvPa0Jt0o/dkUIUen5hbNhVSJo+b8T/p3rrqgCS5qt6t/gjrPeJfeGIWpmaJ77
	hfTeF5cDbjHXyLPa3gCvMMBjtlbMJunIW3hDz8QXeJoMZs0sYqKqiiyxQyAopB0c5Muk3w27tpXf4
	c30BfR+EhMbhoYyDy5d+tFtzH/+KAHRBd9iG2hWmw2aJSqMvTNvJPdvtvxPviL1a9v5ysrCS0sEnc
	fV2hAGzEeLsJJUvEsv3T2xrq6/595SRau91XxGtiFBrehqbuKhzI5JwIH+0v7VWPWSvQrKxBVigp3
	W9NH1BNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaDnv-0000000D84T-1d74;
	Fri, 11 Jul 2025 13:28:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD3063001AA; Fri, 11 Jul 2025 15:28:42 +0200 (CEST)
Date: Fri, 11 Jul 2025 15:28:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RESEND][PATCH v18 5/8] sched: Fix runtime accounting w/ split
 exec & sched contexts
Message-ID: <20250711132842.GG905792@noisy.programming.kicks-ass.net>
References: <20250707204409.1028494-1-jstultz@google.com>
 <20250707204409.1028494-6-jstultz@google.com>
 <20250710094506.GH1613376@noisy.programming.kicks-ass.net>
 <CANDhNCo0u4bdvMxCpoDaZtFFJw5s2KJU=FOeho116p_8LujAfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCo0u4bdvMxCpoDaZtFFJw5s2KJU=FOeho116p_8LujAfA@mail.gmail.com>

On Thu, Jul 10, 2025 at 10:25:46AM -0700, John Stultz wrote:
> On Thu, Jul 10, 2025 at 2:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Jul 07, 2025 at 08:43:52PM +0000, John Stultz wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index edcc7d59ecc3b..c34e0891193a7 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -1143,30 +1143,40 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
> > >  }
> > >  #endif /* CONFIG_SMP */
> > >
> > > +static s64 update_se(struct rq *rq, struct sched_entity *se)
> > >  {
> > >       u64 now = rq_clock_task(rq);
> > >       s64 delta_exec;
> > >
> > > +     delta_exec = now - se->exec_start;
> > >       if (unlikely(delta_exec <= 0))
> > >               return delta_exec;
> > >
> > > +     se->exec_start = now;
> > > +     if (entity_is_task(se)) {
> > > +             struct task_struct *donor = task_of(se);
> > > +             struct task_struct *running = rq->curr;
> > > +             /*
> > > +              * If se is a task, we account the time against the running
> > > +              * task, as w/ proxy-exec they may not be the same.
> > > +              */
> > > +             running->se.exec_start = now;
> > > +             running->se.sum_exec_runtime += delta_exec;
> > >
> > > +             trace_sched_stat_runtime(running, delta_exec);
> > > +             account_group_exec_runtime(running, delta_exec);
> > >
> > > +             /* cgroup time is always accounted against the donor */
> > > +             cgroup_account_cputime(donor, delta_exec);
> > > +     } else {
> > > +             /* If not task, account the time against donor se  */
> > > +             se->sum_exec_runtime += delta_exec;
> > >       }
> >
> > Bah.. this is all terrible :-) But yeah, I suppose this wil do.
> 
> Yeah, :/ I'm happy to rework it further if you have ideas.

Not really; I stared at this for a bit yesterday. Its a confusing mess,
but I didn't come up with anything better.

