Return-Path: <linux-kernel+bounces-855460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CAEBE1537
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8E164E7E38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA311D5160;
	Thu, 16 Oct 2025 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xPtJkPEd"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3731494DB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760583990; cv=none; b=e9CaFtXsPGompv1kmsaHBH4oqvwNB3+dawbVb7cBC+lZiYZPBA+SgBQgRPQva+Sjea4s58laa5CZtZK97LMpgyqnTnxAlit4/ENaJnHjkZCU4ZJyEaPU0yY3TkhXwjZ7VtnlQq8Z5CjAem4r6O6lx3L9YVwBkpRKaYDls2htGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760583990; c=relaxed/simple;
	bh=CK1Pe9bLRBk4rM/xLBmChhC3l/42pvShKW5wkTT5Mlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckdSNd1Ft+8C2t0dOqpPI6wGC7+H6H9eaNT1w1XL7EEp4jvlBVG86OpoTTA+0b8YjNjWrJyFFzsnev3UVDPT6AuBiKJ15KKd4F9EN2OCbFd00whxa7JSe4ybQtHLRDc1WLArZrYSsMXIvcuvPNv5gf/paHWr+sCNx9/5MJ4uXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xPtJkPEd; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760583979; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=8gW9xLKQb+dPegXplQm1+NUjhqP0je2GH/X7gsvwsDM=;
	b=xPtJkPEdS8Bf1VZ+YwMe6qJkwA4waUKYZcTkGM3712fZZjw12pqOM4UM2kNrlSgUHQ+EQWdHEXLK/fHrfHgg1QDeBloEUV+4g3gkXeT/EyHCGsUfnGXmo9k9WNBMPoFXZM8MZ9F5yTcVW3TELYoMI7Lyq9E2cICzhGQmN2MVvY8=
Received: from localhost(mailfrom:peng_wang@linux.alibaba.com fp:SMTPD_---0WqIalBn_1760583978 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 11:06:18 +0800
Date: Thu, 16 Oct 2025 11:06:17 +0800
From: Peng Wang <peng_wang@linux.alibaba.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, vdavydov.dev@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Clear ->h_load_next after hierarchical load
Message-ID: <20251016030617.GA46570@j38d01266.eu95sqa>
Reply-To: Peng Wang <peng_wang@linux.alibaba.com>
References: <bc08fcd528bad11311cd25de37962eb1ce0e7879.1760530739.git.peng_wang@linux.alibaba.com>
 <20251015124422.GD3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015124422.GD3419281@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Oct 15, 2025 at 02:44:22PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 08:19:50PM +0800, Peng Wang wrote:
> 
> > We found that the task_group corresponding to the problematic se
> > is not in the parent task_group¡¯s children list, indicating that
> > h_load_next points to an invalid address. Consider the following
> > cgroup and task hierarchy:
> > 
> >          A
> >         / \
> >        /   \
> >       B     E
> >      / \    |
> >     /   \   t2
> >    C     D
> >    |     |
> >    t0    t1
> > 
> > Here follows a timing sequence that may be responsible for triggering
> > the problem:
> > 
> > CPU X                   CPU Y                   CPU Z
> > wakeup t0
> > set list A->B->C
> > traverse A->B->C
> > t0 exits
> > destroy C
> >                         wakeup t2
> >                         set list A->E           wakeup t1
> >                                                 set list A->B->D
> >                         traverse A->B->C
> >                         panic
> > 
> > CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memory
> > ordering, Y may observe A->B before it sees B->D, then in this time window,
> > it can traverse A->B->C and reach an invalid se.
> 
> Hmm, I rather think we should ensure update_cfs_rq_h_load() is
> serialized against unregister_fair_sched_group().

I might be mistaken, but it seems that, even with RCU protection around
update_cfs_rq_h_load(), there remains a risk of reading stale values.


 CPU X                   CPU Y                   CPU Z

 wakeup t0
 rcu_read_lock()
 set list A->B->C
 traverse A->B->C
 rcu_read_unlock()
 t0 exits
 destroy C

After the prior RCU grace period has elapsed, C has already been reclaimed,
yet the stale A->B->C remains.


                         wakeup t2
                         rcu_read_lock()
                         set list A->E           wakeup t1
                                                 rcu_read_lock()
                                                 set list A->B->D
                                                      ...
                         traverse A->B->C
                         panic

A subsequent rcu_read_lock() only guarantees that A/B/D/E will not be
reclaimed while the list is being traversed; C had already been freed
before the next grace period even began.

> 
> And I'm thinking that really shouldn't be hard; note how
> sched_unregister_group() already has an RCU grace period. So all we need
> to ensure is that task_h_load() is called in a context that stops RCU
> grace periods (rcu_read_lock(), preempt_disable(), local_irq_disable(),
> local_bh_disable()).
> 
> A very quick scan makes me think at the very least the usage in
> 
>   task_numa_migrate()
>     task_numa_find_cpu()
>       task_h_load()
> 
> fails here; probably more.

