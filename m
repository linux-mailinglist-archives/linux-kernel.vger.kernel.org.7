Return-Path: <linux-kernel+bounces-730857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A4B04B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEC189DC5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097B8276046;
	Mon, 14 Jul 2025 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="HEo2aUJk"
Received: from mail31.out.titan.email (mail31.out.titan.email [3.66.49.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868822127C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.66.49.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533823; cv=none; b=Kg8nEcG5LUVYGDCE8KhghO3j41P+08sHsVuf9nTXI+yyhWP02Y25bZjOeq2RA1iqGoM18tJNvmsSpJ8MapgzHF5MxOKD/5zGMNFy1zRHztObiP9bBxPSQljYNxUjHkzG0v1l7YR5mN2pO6I5Sp33l5k9nyUx0+zKs1SIzdnBZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533823; c=relaxed/simple;
	bh=Vc31Y/l+gK5OUpy4QdmEHL4SRxM5j0Yp0b1BKQu39P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKRoaN9eKYKIoIswJg/KasFrnK26cbSrdlqYBuzCHg6XjLvu47ibO3IB/5eoZ9UbXSZ1ulsS4YqRGqQ9D1orl+wUC+flTrzpQjXR/BLBewg5MviFcVyXIRHQE7cmUxIcWQp0eS4z5DcrLUkP2Q2oQc/g+js8QtBpPfO8a5D8bfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=HEo2aUJk; arc=none smtp.client-ip=3.66.49.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id EA2BF100007;
	Mon, 14 Jul 2025 22:56:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=NhBif2ullsgc/mDNMUhF9l8X4OpRQcY3pmf6MWxhAXk=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=subject:message-id:from:mime-version:in-reply-to:date:cc:references:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1752533815; v=1;
	b=HEo2aUJklBnBhTD7fHpExCO6bs1OagTjAJ4MhGb1NsKytfStvbVvlyqEqYxvLdSFtEeyXMkZ
	QaGnYZFp9PBKUmCruS/uSbaq75gy52qori1ft6jjhTvn1diEiH9muY4PhHFVyZIUXRsSyVnFXkI
	BV+ZL5dQW2XppztA35wXabk8=
Received: from mail.blacknight.com (ip-84-203-196-90.broadband.digiweb.ie [84.203.196.90])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 0C016100002;
	Mon, 14 Jul 2025 22:56:54 +0000 (UTC)
Date: Mon, 14 Jul 2025 23:56:50 +0100
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server
 handling
Message-ID: <22aju4edxl4hf7tihzl6672cg234eam5kcgazxbf2ga5thsmm6@l2wwkn2wth7r>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.465086194@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20250702121158.465086194@infradead.org>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1752533815762704398.2332.6684230464540954113@prod-euc1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=HKo5Fptv c=1 sm=1 tr=0 ts=68758b37
	a=+XWPlUOTt03IZrtNKHUAqA==:117 a=+XWPlUOTt03IZrtNKHUAqA==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
	a=VabnemYjAAAA:8 a=R_Myd5XaAAAA:8 a=jY4YyGprjQRmmtv6ocgA:9
	a=PUjeQqilurYA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=gKebqoRLp9LExxC7YDUY:22
	a=L2g4Dz8VuBQ37YGmWQah:22

On Wed, Jul 02, 2025 at 01:49:26PM +0200, Peter Zijlstra wrote:
> Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
> bandwidth control") caused a significant dip in his favourite
> benchmark of the day. Simply disabling dl_server cured things.
> 

Unrelated to the patch but I've been doing a bit of arcology recently
finding the motivation for various decisions and paragraphs like this
have been painful (most recent was figuring out why a decision was made
for 2.6.32). If the load was described, can you add a Link: tag?  If the
workload is proprietary, cannot be described or would be impractical to
independently created than can that be stated here instead?

> His workload hammers the 0->1, 1->0 transitions, and the
> dl_server_{start,stop}() overhead kills it -- fairly obviously a bad
> idea in hind sight and all that.
> 

Obvious in hindsight but even then a brief explanation as to why it
triggered that particular corner case would be helpful. i.e. was throttling
the trigger or dequeue for a workload with very few (1?) tasks?

> Change things around to only disable the dl_server when there has not
> been a fair task around for a whole period. Since the default period
> is 1 second, this ensures the benchmark never trips this, overhead
> gone.
> 

I didn't dig into this too much but is that 1s fixed because it's related to
the dl server itself rather than any task using the deadline scheduler? The
use of "default" indicates it's tunable but at a glance, it's not clear
if sched_setattr can be used to reconfigure the dl_server or not. Even if
that is the expected case, it's not obvious (to me).

> Fixes: 557a6bfc662c ("sched/fair: Add trivial fair server")
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.507378961@infradead.org

Patch looks ok but I'm not particularly familiar with the deadline
scheduler. Even so;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

One nit below

> ---
>  include/linux/sched.h   |    1 +
>  kernel/sched/deadline.c |   25 ++++++++++++++++++++++---
>  kernel/sched/fair.c     |    9 ---------
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -701,6 +701,7 @@ struct sched_dl_entity {
>  	unsigned int			dl_defer	  : 1;
>  	unsigned int			dl_defer_armed	  : 1;
>  	unsigned int			dl_defer_running  : 1;
> +	unsigned int			dl_server_idle    : 1;
>  
>  	/*
>  	 * Bandwidth enforcement timer. Each -deadline task has its
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1215,6 +1215,8 @@ static void __push_dl_task(struct rq *rq
>  /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
>  static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
>  
> +static bool dl_server_stopped(struct sched_dl_entity *dl_se);
> +
>  static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
>  {
>  	struct rq *rq = rq_of_dl_se(dl_se);
> @@ -1234,6 +1236,7 @@ static enum hrtimer_restart dl_server_ti
>  
>  		if (!dl_se->server_has_tasks(dl_se)) {
>  			replenish_dl_entity(dl_se);
> +			dl_server_stopped(dl_se);
>  			return HRTIMER_NORESTART;
>  		}
>  
> @@ -1639,8 +1642,10 @@ void dl_server_update_idle_time(struct r
>  void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
>  {
>  	/* 0 runtime = fair server disabled */
> -	if (dl_se->dl_runtime)
> +	if (dl_se->dl_runtime) {
> +		dl_se->dl_server_idle = 0;
>  		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
> +	}
>  }
>  
>  void dl_server_start(struct sched_dl_entity *dl_se)
> @@ -1663,7 +1668,7 @@ void dl_server_start(struct sched_dl_ent
>  		setup_new_dl_entity(dl_se);
>  	}
>  
> -	if (!dl_se->dl_runtime)
> +	if (!dl_se->dl_runtime || dl_se->dl_server_active)
>  		return;
>  
>  	dl_se->dl_server_active = 1;
> @@ -1684,6 +1689,20 @@ void dl_server_stop(struct sched_dl_enti
>  	dl_se->dl_server_active = 0;
>  }
>  
> +static bool dl_server_stopped(struct sched_dl_entity *dl_se)
> +{
> +	if (!dl_se->dl_server_active)
> +		return false;
> +
> +	if (dl_se->dl_server_idle) {
> +		dl_server_stop(dl_se);
> +		return true;
> +	}
> +
> +	dl_se->dl_server_idle = 1;
> +	return false;
> +}
> +

The function name does not suggest there are side-effects. If I'm reading it
correctly, it's basically a 2-pass filter related to the sched_period. It
could do with a comment with bonus points mentioning the duration of the
2-pass filter depends on the sched_period of the dl_server.

>  void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
>  		    dl_server_has_tasks_f has_tasks,
>  		    dl_server_pick_f pick_task)
> @@ -2435,7 +2454,7 @@ static struct task_struct *__pick_task_d
>  	if (dl_server(dl_se)) {
>  		p = dl_se->server_pick_task(dl_se);
>  		if (!p) {
> -			if (dl_server_active(dl_se)) {
> +			if (!dl_server_stopped(dl_se)) {
>  				dl_se->dl_yielded = 1;
>  				update_curr_dl_se(rq, dl_se, 0);
>  			}
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5879,7 +5879,6 @@ static bool throttle_cfs_rq(struct cfs_r
>  	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
>  	struct sched_entity *se;
>  	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
> -	long rq_h_nr_queued = rq->cfs.h_nr_queued;
>  
>  	raw_spin_lock(&cfs_b->lock);
>  	/* This will start the period timer if necessary */
> @@ -5963,10 +5962,6 @@ static bool throttle_cfs_rq(struct cfs_r
>  
>  	/* At this point se is NULL and we are at root level*/
>  	sub_nr_running(rq, queued_delta);
> -
> -	/* Stop the fair server if throttling resulted in no runnable tasks */
> -	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
> -		dl_server_stop(&rq->fair_server);
>  done:
>  	/*
>  	 * Note: distribution will already see us throttled via the
> @@ -7060,7 +7055,6 @@ static void set_next_buddy(struct sched_
>  static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  {
>  	bool was_sched_idle = sched_idle_rq(rq);
> -	int rq_h_nr_queued = rq->cfs.h_nr_queued;
>  	bool task_sleep = flags & DEQUEUE_SLEEP;
>  	bool task_delayed = flags & DEQUEUE_DELAYED;
>  	struct task_struct *p = NULL;
> @@ -7144,9 +7138,6 @@ static int dequeue_entities(struct rq *r
>  
>  	sub_nr_running(rq, h_nr_queued);
>  
> -	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
> -		dl_server_stop(&rq->fair_server);
> -
>  	/* balance early to pull high priority tasks */
>  	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>  		rq->next_balance = jiffies;
> 
> 

-- 
Mel Gorman
SUSE Labs

