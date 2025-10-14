Return-Path: <linux-kernel+bounces-852281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0EBD896A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0675A18A3C66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3B2E7BC0;
	Tue, 14 Oct 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OtbbamBV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3AE222587
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435653; cv=none; b=uHZ/lJuQJQdvqQvXJjH6v1zY73oGmQ3y3siZuwaSN5/hnfJXY3xB3v3hHDGTuvFueE/X1L4RJZ0lPD+NYxKkFCuXzuLnFlRPx1eAQJ0Dnbj4mlsVrao7VWtnRHxx9yiOU/IXUnm8BMvZVSxxBHt+zRDRCzYw6iriv071K9hgGRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435653; c=relaxed/simple;
	bh=AQsd3tszvMzMFI7EyskeFQST3Zl/n3StTV/Ej7mwCg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMc5dpjimq6IJ1AK1dh0YniUfD+T+JqBD+WKzUQQdo9/r6ZRQeIH1Q+tYemLXzvymw3D2CH4xj11zY8AA/TukaaZnG++d278q6J6b9BKXR44JzCXmBwJfJ6uRDk+MJVqOjeelU6Od9Aa5EYFtAh9N4M0SN2TdirZuEkpubofyNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OtbbamBV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OUuElKex+YjpTZz+0yh5h7s4/4h/ma9PSVmn3e6TGQU=; b=OtbbamBVjIDMuBw/2bwJuJJXb8
	q5shAqZIyeFrf3ZYXUxxZoTU0I7L1PG79gtVGU+hl+Lijr7jibkrUHahpCZM1Irq74FzjVINJs9jo
	wkEqEVZ7IYc64VJHype7YT27AeqWyH7PNyO0TI4b+nvMCzYJYMYphxaTwF2fCYtGPjxoN70i3NKTp
	WDEF8eaFPXON3Kpi2qmFxz9Gf9Ut+tIJdwmsrIGmyPQ0q+VB3ZvK0XFM7QW3jKfjk1rD8Ys3I/GIM
	gX90Et8U5B9OjJkW5ZyFV3dzcPMJz1g5/nw/vaMBCmpJ65MLOXpm+yPVLTJ2vygunj6Ow8cwGZkEJ
	pmbGwSmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8bjL-00000008DDR-0soO;
	Tue, 14 Oct 2025 09:54:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA487300212; Tue, 14 Oct 2025 11:54:07 +0200 (CEST)
Date: Tue, 14 Oct 2025 11:54:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
References: <20251007122904.31611-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007122904.31611-1-gmonaco@redhat.com>

On Tue, Oct 07, 2025 at 02:29:04PM +0200, Gabriele Monaco wrote:
> Recent changes to the deadline server leave it running when the system
> is idle. If the system is idle for longer than the dl_server period and
> the first scheduling occurs after a fair task wakes up, the algorithm
> picks the server as the earliest deadline (in the past) and that boosts
> the fair task that just woke up while:
>  * the deadline is in the past
>  * the server consumed all its runtime (in background)
>  * there is no starvation (idle for about a period)
> 
> Prevent the server from boosting a task when the deadline is in the
> past. Instead, replenish a new period and start the server as deferred.
> 
> Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> To: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
> 
> This behaviour was observed using the RV monitors in [1] and the patch
> was validated on an adapted version of the models. The models are not
> exhaustively validating the dl_server behaviour.
> 
> [1] - https://lore.kernel.org/lkml/20250919140954.104920-21-gmonaco@redhat.com
> 
>  kernel/sched/deadline.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 72c1f72463c7..b3e3d506a18d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2371,6 +2371,17 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
>  			dl_server_stop(dl_se);
>  			goto again;
>  		}
> +		/*
> +		 * If the CPU was idle for long enough time and wakes up
> +		 * because of a fair task, the dl_server may run after its
> +		 * period elapsed. Replenish a new period as deferred, since we
> +		 * are clearly not handling starvation here.
> +		 */
> +		if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
> +			dl_se->dl_defer_running = 0;
> +			replenish_dl_new_period(dl_se, rq);
> +			goto again;
> +		}
>  		rq->dl_server = dl_se;
>  	} else {
>  		p = dl_task_of(dl_se);
> 

I'm a bit confused, should not enqueue ensure deadline is in the future?
And if it doesn't shouldn't we fix the enqueue path somewhere?

