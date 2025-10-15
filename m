Return-Path: <linux-kernel+bounces-854502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02713BDE866
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB719401254
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147AD1C3BE0;
	Wed, 15 Oct 2025 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W1w2oEvu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE31AA1F4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532275; cv=none; b=cuZoLBqY+fE3lP/uvnD5H/clfMvmpQyTFH2z15kUYnQ41cZNy1MFItc/wHEvd1dm9GQkhB3oOuKJZr5CBEVNuhODVRNTrk/Hb2QrutGowxasivE3nuOyXHioeonfoYZMQeioUn+yq/VfXx21U96QsXJT8BsN2h7SKLNogjvKPgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532275; c=relaxed/simple;
	bh=kpLsOrDrUNBhGk5fqunCMyPWPwglI2qmrJl16Ox9DXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j80+Z6mKQDdxf6FoYaOOxS068rHv9LWx5GLTgPwm8q6JozFoYt3uxE2+AOOnRUYq0w/X3IF/D5SpbWrO0626ZssQuh3o3AOAX3to3L+TxH2FJ1lHeJZs0b8vVBvyWpNZhnua0zlSIX3rKbeYxeutOOW8If++DXfBKbnnp6MQgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W1w2oEvu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/3aQ15XZfFR1YHBXPfrlBpXsyAFL3oyFZPgvIQ/26iI=; b=W1w2oEvuhzmAX3+Ay2mCgzR5DK
	rszpH9tyPfP3IAYfcc2U4Cq1VZP64hp7jO2srCJJqQMFj8bWw5QN35BsgNpOQWKWxnAQNlH/w7VIV
	f9bHuQZY3GvM27viXxn9IoRgm/DH2gG29ciL9jr9+WqPmfQ58ze3Ekak1IWAVL1G3BFaYdp9p9Wpv
	V+0FzkpU0ueeDF4IaLyhAc51wivRJBFDAIQelm1oY8jpjG57KC0hJFRhyowVIeXUgDOfo2H/4aH1n
	IuhS6psfd6+u4wxhqnRjENnARt4ZHHrjbvJzARjR3G4yaRgWyuZWFbTMggtpeBRY/ERt1zG37DU6O
	sORKiftQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v90rd-0000000FThH-1dZe;
	Wed, 15 Oct 2025 12:44:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D83E300220; Wed, 15 Oct 2025 14:44:22 +0200 (CEST)
Date: Wed, 15 Oct 2025 14:44:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Peng Wang <peng_wang@linux.alibaba.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, vdavydov.dev@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Clear ->h_load_next after hierarchical load
Message-ID: <20251015124422.GD3419281@noisy.programming.kicks-ass.net>
References: <bc08fcd528bad11311cd25de37962eb1ce0e7879.1760530739.git.peng_wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc08fcd528bad11311cd25de37962eb1ce0e7879.1760530739.git.peng_wang@linux.alibaba.com>

On Wed, Oct 15, 2025 at 08:19:50PM +0800, Peng Wang wrote:

> We found that the task_group corresponding to the problematic se
> is not in the parent task_group’s children list, indicating that
> h_load_next points to an invalid address. Consider the following
> cgroup and task hierarchy:
> 
>          A
>         / \
>        /   \
>       B     E
>      / \    |
>     /   \   t2
>    C     D
>    |     |
>    t0    t1
> 
> Here follows a timing sequence that may be responsible for triggering
> the problem:
> 
> CPU X                   CPU Y                   CPU Z
> wakeup t0
> set list A->B->C
> traverse A->B->C
> t0 exits
> destroy C
>                         wakeup t2
>                         set list A->E           wakeup t1
>                                                 set list A->B->D
>                         traverse A->B->C
>                         panic
> 
> CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memory
> ordering, Y may observe A->B before it sees B->D, then in this time window,
> it can traverse A->B->C and reach an invalid se.

Hmm, I rather think we should ensure update_cfs_rq_h_load() is
serialized against unregister_fair_sched_group().

And I'm thinking that really shouldn't be hard; note how
sched_unregister_group() already has an RCU grace period. So all we need
to ensure is that task_h_load() is called in a context that stops RCU
grace periods (rcu_read_lock(), preempt_disable(), local_irq_disable(),
local_bh_disable()).

A very quick scan makes me think at the very least the usage in

  task_numa_migrate()
    task_numa_find_cpu()
      task_h_load()

fails here; probably more.

