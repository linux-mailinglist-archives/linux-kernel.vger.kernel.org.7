Return-Path: <linux-kernel+bounces-822379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006ABB83AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F62918802BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEE12EDD6D;
	Thu, 18 Sep 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LHKYY+aH"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DE2F7AC2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186297; cv=none; b=rPKTGjMatMy1RbHGIg3nBcXWqbBVsjkakhxzdT8KR9/mYK73M+a1d7Fhl/81M/aar50Fl7OsEly33/SGUOnWuQc3CCKYuolH+tKFrDaxO5PACwpOrX/0uPNFyP6s3G2X3UFikLXXO7+6VCLp1htznVJ2aBRoyD+pXugRdCui+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186297; c=relaxed/simple;
	bh=WROJ5UAhmj6yG72KCI6liZtTIr6SlTLF9BgEFiVK0Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWwjS6wtjIAyANwP40Ut1TOj5VKQ8/WfQEmOZc0hWNqyp1hsthQkjphA3NS9dspyUTD1/11O5ud4wuINCb7jmuG/I2WzwxyQ1BhXhVSLds4UXAT3/SO9VCGIjhTaeJGGorssjdzvTGoUJwH7UW0uF5W4H0U+U0IR94bGK3NlDDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LHKYY+aH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CiJL1NvszKsta2bEjH6BckdLboddngDH1Ubq4vwfurM=; b=LHKYY+aHOghii7U/vdgtgJ4Hpk
	MgQldAteEtFeJ/gqVyucWlQcADCaGTq0ua1NKKoiZPPtaYC3h0jaPjdXmkw1mFWIX/bxTH7dixtBF
	QAiH0ufWeRddMBlvgxTe7CE+nf9h1G0+dbV8P2iPkOKpQUZMlM8fazMZj/iiXeXCAsO6iVQzG1/Qx
	JSMu+WW75ibwoizgLsEcFiHMGVudb44/aYepnGV5DJgNckWDd3X/I+/hiOlQGAuQ2IG9TgJs+MEih
	DDihtp6/ZgoEDYfhclhiTxUlI2+hOf5jMbcpFoW54Z12YSa+km9znysNT9PrAHVRltuSafAyB/vqB
	EIQhJ6LA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzAZK-00000007a0W-0zie;
	Thu, 18 Sep 2025 09:04:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D3C7300328; Thu, 18 Sep 2025 11:04:45 +0200 (CEST)
Date: Thu, 18 Sep 2025 11:04:45 +0200
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
Message-ID: <20250918090445.GF3289052@noisy.programming.kicks-ass.net>
References: <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
 <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
 <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>
 <20250917093441.GU3419281@noisy.programming.kicks-ass.net>
 <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
 <aMq-BKLSIG9JrRb7@jlelli-thinkpadt14gen4.remote.csb>
 <20250917173038.GA973992@noisy.programming.kicks-ass.net>
 <aMvEsIkSv21kksrL@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMvEsIkSv21kksrL@jlelli-thinkpadt14gen4.remote.csb>

On Thu, Sep 18, 2025 at 10:37:04AM +0200, Juri Lelli wrote:
> On 17/09/25 19:30, Peter Zijlstra wrote:
> > On Wed, Sep 17, 2025 at 03:56:20PM +0200, Juri Lelli wrote:
> > 
> > > > + * By stopping at this point the dl_server retains bandwidth, which, if a new
> > > > + * task wakes up imminently (starting the server again), can be used --
> > > > + * subject to CBS wakeup rules -- without having to wait for the next period.
> > > 
> > > In both cases we still defer until either the new period or the current
> > > 0-laxity, right?
> > > 
> > > The stop cleans all the flags, so subsequent start calls
> > > enqueue(ENQUEUE_WAKEUP) -> update_dl_entity() which sets dl_throttled
> > > and dl_defer_armed in both cases and then we start_dl_timer (defer
> > > timer) after it (without enqueueing right away).
> > > 
> > > Or maybe I am still a bit lost. :)
> > 
> > The way I read it earlier today:
> > 
> >   dl_server_start()
> >     enqueue_dl_entity(WAKEUP)
> >       if (WAKEUP)
> > 	task_contending();
> > 	update_dl_entity()
> > 	  dl_entity_overflows() := true
> > 	  update_dl_revised_wakeup();
> > 
> > In that case, it is possible to continue running with a slight
> > adjustment to the runtime (it gets scaled back to account for 'lost'
> > time or somesuch IIRC).
> > 
> 
> Hummm, but this is for !implicit (dl_deadline != dl_period) tasks, is
> it? And dl-servers are implicit.

Bah. You're right.

So how about this:

  dl_server_timer()
    if (dl_se->dl_defer_armed)
      dl_se->dl_defer_running = 1;

    enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH)

 __pick_task_dl()
   p = dl_se->server_pick_task(dl_se);
   if (!p)
     dl_server_stop()
       dl_se->dl_defer_armed = 0;
       dl_se->dl_throttled = 0;
       dl_se->dl_server_active = 0;
       /* notably it leaves dl_defer_running == 1 */

 dl_server_start()
   dl_se->dl_server_active = 1;
   enqueue_dl_entity(WAKEUP)
     if (WAKEUP)
       task_contending();
       update_dl_entity()
         if (dl_server() && dl_se->dl_defer)
	   if (!dl_se->dl_defer_running) /* !true := false */
	     /* do not set dl_defer_armed / dl_throttled */

Note: update_curr_dl_se() will eventually clear dl_defer_running when it
gets throttled.

And so it continues with the previous reservation. And I suppose the
question is, should it do update_dl_revised_wakeup() in this case?

