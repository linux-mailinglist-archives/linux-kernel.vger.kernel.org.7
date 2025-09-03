Return-Path: <linux-kernel+bounces-799390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E078B42AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4181674B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074362E1F03;
	Wed,  3 Sep 2025 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZHfMoWI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6162E1731
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931249; cv=none; b=rgh3ol5N1TItO37UQFul7ncPW1AOsyvB4YgXqHJIYd32fwjAGZ1pIVYo+mkf8Mq/hjwPeNUIZDmPkdl1DAz+Q1rJBeRsjVx/UNG9yB7GS0rSC3qusvdFDYqOT1HJkJlG01Sh/jsHrgJSRDeOYOADYvzDM2Kn/HrdwVw4Hh8e+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931249; c=relaxed/simple;
	bh=Jr1n5XwYDZtidgjIwVuh/zoz4bMUbmbe8AYG41xc9+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyacufqKjJJ+/cw2lSPJ4LC4qY2QVQTpHuiu4hTJASWtNNnu4fR2C0EqAkccHP+ygiNgniUdYjP19DwUhI0tZyAu8D+qdDKqNQfXSRaKEvZ02fdjAWmCUUypkRCUeIIp/xkdwz/HbDaAs1qVSvAnGzvCXv+iBk0yZpL+uKV3Z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aZHfMoWI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2ikzh2LTyzpZJfefedC+37ZhO843CMUHQi/UiDpz/jw=; b=aZHfMoWIp/XZGkP3S45plCiziU
	ou4alC3PbwHO69APrzEbKC7wXt99tyG4NC/NDKH685wptM4DzpkauryDNt0c3mnP4sqR0l+AcBfnk
	Gn7C1v+VUw5mj7kctPPtzdzljdhxoiPvhjWvvyJSyTmUYmqs/aNyO5fsCfxade6HsUStuj0txjGhY
	EchLx4oXajQ6dOOf5TLzJZpots6l9CNosopFsJyJpFKSArezakrFxzOqqgTzJyo8Q3bZpa8C27ywm
	PK/2dqPOCnIs/Of8AkV6bvC4coMsqwkLOPll1OWOaQXgSXIWTZNPQnlBX91xYCQ9uRktDawZZsaK5
	iFjiUnZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utu4N-00000007fJR-3euZ;
	Wed, 03 Sep 2025 20:27:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7FA7B300220; Wed, 03 Sep 2025 22:27:03 +0200 (CEST)
Date: Wed, 3 Sep 2025 22:27:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Aaron Lu <ziqianlu@bytedance.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250903202703.GP4067720@noisy.programming.kicks-ass.net>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>

On Wed, Sep 03, 2025 at 10:42:01PM +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 9/3/2025 8:21 PM, Peter Zijlstra wrote:
> >>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>  {
> >> +	if (task_is_throttled(p)) {
> >> +		dequeue_throttled_task(p, flags);
> >> +		return true;
> >> +	}
> >> +
> >>  	if (!p->se.sched_delayed)
> >>  		util_est_dequeue(&rq->cfs, p);
> >>  
> > 
> > OK, so this makes it so that either a task is fully enqueued (all
> > cfs_rq's) or full not. A group cfs_rq is only marked throttled when all
> > its tasks are gone, and unthrottled when a task gets added. Right?
> 
> cfs_rq (and the hierarchy below) is marked throttled when the quota
> has elapsed. Tasks on the throttled hierarchies will dequeue
> themselves completely via task work added during pick. When the last
> task leaves on a cfs_rq of throttled hierarchy, PELT is frozen for
> that cfs_rq.

Ah, right.

> When a new task is added on the hierarchy, the PELT is unfrozen and
> the task becomes runnable. The cfs_rq and the hierarchy is still
> marked throttled.
> 
> Unthrottling of hierarchy is only done at distribution.
> 
> > 
> > But propagate_entity_cfs_rq() is still doing the old thing, and has a
> > if (cfs_rq_throttled(cfs_rq)) break; inside the for_each_sched_entity()
> > iteration.
> > 
> > This seems somewhat inconsistent; or am I missing something ? 
> 
> Probably an oversight. But before that, what was the reason to have
> stopped this propagation at throttled_cfs_rq() before the changes?
> 
> Looking at commit 09a43ace1f98 ("sched/fair: Propagate load during
> synchronous attach/detach") was it because the update_load_avg() from
> enqueue_entity() loop previously in unthrottle_cfs_rq() would have
> propagated the PELT to root on unthrottle?
> 
> If that was the intention, perhaps something like:

So this is mostly tasks leaving/joining the class/cgroup. And its
purpose seems to be to remove/add the blocked load component.

Previously throttle/unthrottle would {de,en}queue the whole subtree from
PELT, see how {en,de}queue would also stop at throttle.

But now none of that is done; PELT is fully managed by the tasks
{de,en}queueing.

So I'm thinking that when a task joins fair (deboost from RT or
whatever), we add the blocking load and fully propagate it. If the task
is subject to throttling, that will then happen 'naturally' and it will
dequeue itself again.

