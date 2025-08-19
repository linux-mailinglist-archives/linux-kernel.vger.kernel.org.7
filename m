Return-Path: <linux-kernel+bounces-775080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF7B2BB09
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B07E1BA62FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8993101CD;
	Tue, 19 Aug 2025 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UXIR+HFl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921E25A324
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589682; cv=none; b=bfQq8Zn5o72WMnbZOqhm1WhyTGWGw3vjNKrn3OTaf0qeryE50pZIvOiAUFNGj3N3qJkyNaG/nb48Bf4R1OWLjsjJM0Dy+uZxxX1TItfwMeV4XnwCVB8so4hBC6lMiWZsnfSWOLUn7mFxdm/ZC4nzbeedy34ArQ1F6X+hXyrJk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589682; c=relaxed/simple;
	bh=wWyrGkGiN7qAYP0rt0kcyd7T7gofRJhY67113fSyugM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRn/Na0hFUDihfvbLdu23Pxdwtmmlt5L/UMwTM002rzKY1m7U+BQEbel2ZvfT853T6iKzav4wtWGHvAmKagxHpNRri0hE2qUEMnDKIinPABOpXh1+9JfOzh+fDpXNfBtONSuMZ3QuQmVMnzjbkPvp/U/MSVzGbh9tG25fg2DFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UXIR+HFl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5ge7IJXYe47yW+RfY3cNicDwVa+uZRqRZOWDV9eyHJY=; b=UXIR+HFlCLZKxYMwCkgaZnuE0q
	Kx3KZlYqkGDdujXMb/TOe7jV3Cp9trALWCF2shnR2sv17t2UvipEOeWIseBiJObdGRrNKFdEzZAiG
	tqC3W0hl723znKkuo7MQGM5DvCqv2J2ehVSARa8XbZStNih+eYd51qHsNQR9GkIgu3a/0cJ/B5CuU
	P0gQKZnbn7a7JASqoCxhAS3pHG/ASr7cWOR4zJjAuhNOT0KN3BRKWCPrm4Segewc2OMqPu8hsZRZB
	czAmgdg3O5VrM57VLnRBWD8sUpAvBLZo2+WTw57IWnIerToVTM0O4jM8PikCRRnRpfX8HR56Tn779
	d+sM0iow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoH4D-00000001JpS-0yH6;
	Tue, 19 Aug 2025 07:47:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA6CA30036F; Tue, 19 Aug 2025 09:47:36 +0200 (CEST)
Date: Tue, 19 Aug 2025 09:47:36 +0200
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
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Message-ID: <20250819074736.GD3245006@noisy.programming.kicks-ass.net>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <814bebd2ad844b08993836fd8e7274b8@honor.com>
 <228ebd9e6ed3437996dffe15735a9caa@honor.com>
 <8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>


Could you please not thread your new patches onto the old thread? That
makes them near impossible to find.

On Tue, Aug 19, 2025 at 06:55:38AM +0000, liuwenfang wrote:
> Supposed RT task(RT1) is running on CPU0 and RT task(RT2) is awakened on CPU1,
> RT1 becomes sleep and SCX task(SCX1) will be dispatched to CPU0, RT2 will be
> placed on CPU0:
> 
> CPU0(schedule)                                     CPU1(try_to_wake_up)
> set_current_state(TASK_INTERRUPTIBLE)              try_to_wake_up # RT2
> __schedule                                           select_task_rq # CPU0 is selected
> LOCK rq(0)->lock # lock CPU0 rq                        ttwu_queue
>   deactivate_task # RT1                                  LOCK rq(0)->lock # busy waiting
>     pick_next_task # no more RT tasks on rq                 |
>       prev_balance                                          |
>         balance_scx                                         |
>           balance_one                                       |
>             rq->scx.cpu_released = false;                   |
>               consume_global_dsq                            |
>                 consume_dispatch_q                          |
>                   consume_remote_task                       |
>                     UNLOCK rq(0)->lock                      V
>                                                          LOCK rq(0)->lock # succ
>                     deactivate_task # SCX1               ttwu_do_activate
>                     LOCK rq(0)->lock # busy waiting      activate_task # RT2 equeued
>                        |                                 UNLOCK rq(0)->lock
>                        V
>                     LOCK rq(0)->lock # succ
>                     activate_task # SCX1
>       pick_task # RT2 is picked
>       put_prev_set_next_task # prev is RT1, next is RT2, rq->scx.cpu_released = false;
> UNLOCK rq(0)->lock
> 
> At last, RT2 will be running on CPU0 with rq->scx.cpu_released being false, which would
> lead the BPF scheduler to make decisions improperly.
> 
> So, check the sched class in __put_prev_set_next_scx() to fix the value of
> rq->scx.cpu_released.

Oh gawd, this is terrible.

Why would you start the pick in balance and then cry when you fail the
pick in pick ?!?

This is also the reason you need that weird CLASS_EXT exception in
prev_balance(), isn't it?

You're now asking for a 3rd call out to do something like:

  ->balance() -- ready a task for pick
  ->pick() -- picks a random other task
  ->put_prev() -- oops, our task didn't get picked, stick it back

Which is bloody ludicrous. So no. We're not doing this.

Why can't pick DTRT ?

