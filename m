Return-Path: <linux-kernel+bounces-888811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71ABC3BFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC5256748E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD43168E5;
	Thu,  6 Nov 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kbOT5u5x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FxxOp2mI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83E22D4F6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441643; cv=none; b=ngluf029ElYB9CJjebssQveL1ZhtLAF4B0ISSOwvd+yLB3s2iHpsN5+p+A4xBdbXvu+qNegKWlAMMlKnfBWcb2uREyG0LNpbVSLeFFe8BJRxdco/o0wAozsgx1Is0C8P/LnftBpDh9sxHtDbt7GWkzEVVCIm0KtleA6Xf18orDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441643; c=relaxed/simple;
	bh=9iogqzbnKmUSvFY1/eyKlxu0HAE0a7i3u3l/uV04PcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OP3DCBA8IOO4zmzH/pTqgbCkeH7rG/yvrtGB2VlMmXUYanEVTtxPr9sdRNxSmz3vcNUb9FLiMnR7GCEYUKNdLPN8CE4Av+MPV4ldrnZSGw6ItcFFzYCTL/fmnIbK5c2LZ44Yxtw0Z0pboE5K/7wc4jwfctzmUBqfZNjvHELNOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kbOT5u5x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FxxOp2mI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Nov 2025 16:07:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762441639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAfiLbGJY90S6vCvbYmZuEXQsRt5XQBTnm3BkGgQnjQ=;
	b=kbOT5u5xqXuoQ/FzMzMxeVzZrGrGIanv+MK75hw9BpjXmDQg7KL5RwJQS7HCSPBCq78c1S
	N/5giDon8O+4pAv+hbzIHrkdDW5DPc+FMXUKVp7GW2tnFhN0kahXUpyBodIUoEWmoFegQO
	OOU26K601LTbKnAX1++EZuFl3aLcNO6fNPEWKjA21m5UdVew62BOSBbve0YTjbZhaGF+/1
	DKZh3Hvq1F/54S2wq22S5+KEhCwYX6Z+a6khkJJdvRMRGNyuguF/mv6pIpdl/GtleLXamY
	hTZR968behX+wkTkbUYpEq/lupahdKTASX+DVsmLgXbkHa66ZSEfNPJtyMvMHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762441639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAfiLbGJY90S6vCvbYmZuEXQsRt5XQBTnm3BkGgQnjQ=;
	b=FxxOp2mIycExHZg9Bn3R4vefKlUXB65Ms6hUXXXiuBccq+BGl1XGVu4Y2njoBM9skR2W3i
	njxAOGTuVUYN8FDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH cgroup/for-6.19] cgroup: Fix sleeping from invalid
 context warning on PREEMPT_RT
Message-ID: <20251106150717.cZuPZnF5@linutronix.de>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <aQpUY7fEp6_ZqGel@slm.duckdns.org>
 <aQtqXfMfy8SWjS67@mozart.vkv.me>
 <aQufmyZ7X7NdfiCL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQufmyZ7X7NdfiCL@slm.duckdns.org>

On 2025-11-05 09:03:55 [-1000], Tejun Heo wrote:
> +#ifdef CONFIG_PREEMPT_RT
> +/*
> + * cgroup_task_dead() is called from finish_task_switch() which doesn't allow
> + * scheduling even in RT. As the task_dead path requires grabbing css_set_lock,
> + * this lead to sleeping in the invalid context warning bug. css_set_lock is too
> + * big to become a raw_spinlock. The task_dead path doesn't need to run
> + * synchronously. Bounce through irq_work instead.
> + */
> +static DEFINE_PER_CPU(struct llist_head, cgrp_dead_tasks);
> +static DEFINE_PER_CPU(struct irq_work, cgrp_dead_tasks_iwork);
> +
> +static void cgrp_dead_tasks_iwork_fn(struct irq_work *iwork)
> +{
> +	struct llist_node *lnode;
> +	struct task_struct *task, *next;
> +
> +	lnode = llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
> +	llist_for_each_entry_safe(task, next, lnode, cg_dead_lnode) {
> +		do_cgroup_task_dead(task);
> +		put_task_struct(task);
> +	}
> +}
> +
> +static void __init cgroup_rt_init(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		init_llist_head(per_cpu_ptr(&cgrp_dead_tasks, cpu));
> +		init_irq_work(per_cpu_ptr(&cgrp_dead_tasks_iwork, cpu),
> +			      cgrp_dead_tasks_iwork_fn);

How important is it, that it happens right away? Written as-is, this
leads to an interrupt then wakes irq_work/$cpu thread which then runs
this callback. That thread runs as SCHED_FIFO-1. This means the
termination of a SCHED_OTHER tasks on a single CPU will run as follows:
 - TASK_DEAD
   schedule()
     - queue IRQ_WORK
     -> INTERRUPT
     -> WAKE irq_work
   -> preempt to irq_work/
      -> handle one callback
      schedule()
 back to next TASK_DEAD

So cgrp_dead_tasks_iwork_fn() will never have to opportunity to batch.
Unless the exiting task's priority is > 1. Then it will be delayed
until all RT tasks are done.

My proposal would be to init the irq_work item with
	*per_cpu_ptr(&cgrp_dead_tasks_iwork, cpu) = IRQ_WORK_INIT_LAZY(cgrp_dead_tasks_iwork_fn);

instead which won't raise an IRQ immediately and delay the callback
until the next timer tick. So it could batch multiple tasks.

[ queue_work() should work, too but the overhead to schedule is greater
  imho so this makes sense ]

Sebastian

