Return-Path: <linux-kernel+bounces-864541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CABFB06F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3A65354C02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099E30EF88;
	Wed, 22 Oct 2025 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ptYYMjmX"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAA274659
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123651; cv=none; b=VgfoSl1uwdQC/ataPBpHBKb1ed0SK+d8PU+/Ya4J9NjabGrz3wg2Qa4CmqIgbOr1pA0elB6iMqJtMWBXNFEEVSxwnD9iten8RmIKH7jqeN3u3a25VMN4ADqHQm39ufxHkR8LOEKw1jbQNoh4wY88TlvDJgAVVD6vmdniIln+VQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123651; c=relaxed/simple;
	bh=xM0mRvnCnxrq8qrBayle8Vn8kADKts0PdydU+a9IdEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kX0z0O7SomWTt50flSDIJONwuLrGiFIrgsXdTKDf5WVouXasZGwgVi6MBiuviHWq4oGORXHNnsDuY8RJyv4r/NRbgu6HG5eFk1apnRUeFPTKpz1PW8PdYD+Y75jgRSCQEIa0BeS6U5KhWVxG0FZ0rMKnfD/P9gALvfvVSCLJQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ptYYMjmX; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761123640; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=dvsliT5+X3hg8ePEtHv+3tm4bcT3hp4UnhYiD7EpFVE=;
	b=ptYYMjmXPKgBxtiRR2FcLDpyqH9vrXHcgtbt1X7WQX6o7Il+lK8Ihxw19T9TZKyQjDrdAfLG6RbYanSruc2QGXOPNzIwQ3d8uV+2ZF/84aywpv1gTSW5ffjyeiI2WhA416fp1N/Cpf9yf2s3OKInlVa2YIEGljvf/Nzb+vW0EKA=
Received: from localhost(mailfrom:peng_wang@linux.alibaba.com fp:SMTPD_---0WqmHuQH_1761123638 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 17:00:39 +0800
Date: Wed, 22 Oct 2025 17:00:38 +0800
From: Peng Wang <peng_wang@linux.alibaba.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, vdavydov.dev@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Clear ->h_load_next after hierarchical load
Message-ID: <20251022090038.GA88368@j38d01266.eu95sqa>
Reply-To: Peng Wang <peng_wang@linux.alibaba.com>
References: <bc08fcd528bad11311cd25de37962eb1ce0e7879.1760530739.git.peng_wang@linux.alibaba.com>
 <20251015124422.GD3419281@noisy.programming.kicks-ass.net>
 <CAKfTPtD-RJoMEHSQToF_578KZ=WszR+xStxNghiWpv4asnHBoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtD-RJoMEHSQToF_578KZ=WszR+xStxNghiWpv4asnHBoA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Oct 15, 2025 at 03:14:37PM +0200, Vincent Guittot wrote:
> On Wed, 15 Oct 2025 at 14:44, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 15, 2025 at 08:19:50PM +0800, Peng Wang wrote:
> >
> > > We found that the task_group corresponding to the problematic se
> > > is not in the parent task_group¡¯s children list, indicating that
> > > h_load_next points to an invalid address. Consider the following
> > > cgroup and task hierarchy:
> > >
> > >          A
> > >         / \
> > >        /   \
> > >       B     E
> > >      / \    |
> > >     /   \   t2
> > >    C     D
> > >    |     |
> > >    t0    t1
> > >
> > > Here follows a timing sequence that may be responsible for triggering
> > > the problem:
> > >
> > > CPU X                   CPU Y                   CPU Z
> > > wakeup t0
> > > set list A->B->C
> > > traverse A->B->C
> > > t0 exits
> > > destroy C
> > >                         wakeup t2
> > >                         set list A->E           wakeup t1
> > >                                                 set list A->B->D
> > >                         traverse A->B->C
> > >                         panic
> > >
> > > CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memory
> > > ordering, Y may observe A->B before it sees B->D, then in this time window,
> > > it can traverse A->B->C and reach an invalid se.
> >
> > Hmm, I rather think we should ensure update_cfs_rq_h_load() is
> > serialized against unregister_fair_sched_group().
> 
> The bug has been reported for v5.10 which probably don't have fixed
> done "recently"
> commit b027789e5e50 ("sched/fair: Prevent dead task groups from
> regaining cfs_rq's")

Hi, Vincent and Peter,

We have already integrated this commit, but the bug persists.

Do you think we should explicitly clear the h_load_next list?

Even though update_cfs_rq_h_load runs under an RCU lock, ARM's
weak memory ordering could still allow readers to observe stale
values in the list.

> 
> >
> > And I'm thinking that really shouldn't be hard; note how
> > sched_unregister_group() already has an RCU grace period. So all we need
> > to ensure is that task_h_load() is called in a context that stops RCU
> > grace periods (rcu_read_lock(), preempt_disable(), local_irq_disable(),
> > local_bh_disable()).
> >
> > A very quick scan makes me think at the very least the usage in
> >
> >   task_numa_migrate()
> >     task_numa_find_cpu()
> >       task_h_load()
> >
> > fails here; probably more.

