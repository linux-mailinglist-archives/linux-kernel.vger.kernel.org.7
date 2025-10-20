Return-Path: <linux-kernel+bounces-863435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E90BF7DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5360518C8CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DF534E744;
	Tue, 21 Oct 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S3BkYC3Y"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4934B673
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067146; cv=none; b=i43/uDLWZQwRQpJOwLriu0OcXB01Tc+iO3sT7NA06uXv2N8TvQSnkYU1B2aZG+3GJy34Z9MEP5pGCgqAcxd9S0e6NMe7gM32ToKumeMJWmVy3hySBerLef/c/1iTsJWO1jHUwNUOSuE1VHRxBxvM13P9JcMjE19K3epE5yW0EaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067146; c=relaxed/simple;
	bh=bVm3wj0rdBh+AJbk0Usgg6WfDlhUd11mnBwuH0QUZdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjR9EVbX3tgrFfatBvf6etNxl0N6yBB4k9c0I2GFDvcDSAHP5JcFwWYwdfaAWablujEwlJUUbsybC9KQ2DMifMKvOUmMondg4mMPzd0ymuXX/lcoI8M5ys2/cZ2zoSyWuqVy4Yd5mzwA/vHwkOGk+RSuuvrzzE4TkweNa2AX2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S3BkYC3Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FaZru9bBOAeoaWKt5uRkTSnegYw7yISFtb4fmI4q2lM=; b=S3BkYC3YwFrdw3o2szORw4T9Te
	Uw7K3paaCB5l+oq+VHnF4U1nLL4K2Ir9eYSUKqXi6IpRgjx9EsF1SlyMOX8UX5Av+sKDmJ2L13/RC
	JEnPKNlHaBimpv7D7Dqe1Jnyz4h1IXdz+pOLcasnARZAMXGOCBRgUHd82Vw+nQ2aoycPVHMRq6+K+
	UUlIbMlkIMOOJbIuprV87l11XpJGCmYGU0F02QY7sZJG3nw5IrVD1npvTTA/wHq4vfzcvV1M6lhFu
	gx49XMZTj74a1udeG9FBCbQFe9OJpmpwy7cI6ZsZg1OTP9d0HU52z5uqQaIXqIqtDjDTn140lxo6h
	Co2AOKhg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0c-0000000DsWg-1k1h;
	Tue, 21 Oct 2025 17:18:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0DB89303077; Mon, 20 Oct 2025 11:27:27 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:27:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 16/19] sched/mmcid: Provide CID ownership mode fixup
 functions
Message-ID: <20251020092727.GI3245006@noisy.programming.kicks-ass.net>
References: <20251015164952.694882104@linutronix.de>
 <20251015172835.313805515@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015172835.313805515@linutronix.de>

On Wed, Oct 15, 2025 at 07:29:54PM +0200, Thomas Gleixner wrote:

> +static bool mm_cid_fixup_task_to_cpu(struct task_struct *t, struct mm_struct *mm)
> +{
> +	/* Remote access to mm::mm_cid::pcpu requires rq_lock */
> +	guard(task_rq_lock)(t);
> +	if (t->mm != mm)
> +		return false;

I'm slightly confused about this one; I'm assuming it is a double check
of mm for the VM_CLONE case below, once before lock once after. Except,
none of the scheduler locks actually serialize t->mm ...

IIRC the only way to actually change ->mm is exec(), and that is under
task_lock().

> +	if (cid_on_task(t->mm_cid.cid)) {
> +		/* If running on the CPU, transfer the CID, otherwise drop it */
> +		if (task_rq(t)->curr == t)
> +			mm_cid_transfer_to_cpu(t, per_cpu_ptr(mm->mm_cid.pcpu, task_cpu(t)));
> +		else
> +			mm_unset_cid_on_task(t);
> +	}
> +	return true;
> +}
> +
> +static void __maybe_unused mm_cid_fixup_tasks_to_cpus(void)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct task_struct *p, *t;
> +	unsigned int users;
> +
> +	/*
> +	 * This can obviously race with a concurrent affinity change, which
> +	 * increases the number of allowed CPUs for this mm, but that does
> +	 * not affect the mode and only changes the CID constraints. A
> +	 * possible switch back to per task mode happens either in the
> +	 * deferred handler function or in the next fork()/exit().
> +	 *
> +	 * The caller has already transferred. The newly incoming task is
> +	 * already accounted for, but not yet visible.
> +	 */
> +	users = mm->mm_cid.users - 2;
> +	if (!users)
> +		return;
> +
> +	guard(rcu)();
> +	for_other_threads(current, t) {
> +		mm_cid_fixup_task_to_cpu(t, mm);
> +		users--;
> +	}
> +
> +	if (!users)
> +		return;
> +
> +	/* Happens only for VM_CLONE processes. */

Right, sorry for reminding you about this :-)

> +	for_each_process_thread(p, t) {
> +		if (t == current || t->mm != mm)
> +			continue;
> +		if (mm_cid_fixup_task_to_cpu(t, mm)) {
> +			if (--users == 0)
> +				return;
> +		}
> +	}
> +}

