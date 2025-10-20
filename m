Return-Path: <linux-kernel+bounces-863440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DA8BF7DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DA54623EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7BC34F27D;
	Tue, 21 Oct 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wwut9i+G"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA134D4F4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067148; cv=none; b=UACFhQkmeVWojkBnZkFgwP6nt5LW1jwZglA39p5xm2nQ4i5aRGf1vS/Nwwnaewm2K57h3/51PFkvZ8k9HTTcGSWH5ky7KBFXL9nU2HyoFP8rHRKgU0RmqSmk0eQaDe4tMwyK4CjcB1fKrb9RE9igNX/V55sjmUReSc6vkOYhk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067148; c=relaxed/simple;
	bh=vz2UGXVx0mYUXxEgXNPFfNPVb2TH+PVsUhfKqw3NPIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7iMiOqUcNRQRjwHIw6I4SZWSK0EeCBxDbz0pq41BL3M5zlJfouV/ZjtZB7MlTTponkzzjcLqmppnISuP4m4JAZgDBNhVEHt+Hu6dCJnRTTfN6o4R+2ljqkymN5N0lxu0+BK/0baGKB+JiYThzi594b4juxr+qFRXzDbe2evUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wwut9i+G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I/Pmgrqggg6nsOF93qCYp51bZ0hRlSq6Qo5iJCI6Hk0=; b=Wwut9i+GHA3/H2w9x69lMHEGBE
	JyjOOnnDmACcR/1maMbEljX91hfYkR3635KKpkf1jvO5XCAYRfCH1VE1dxjsRTt7Uv2cWn6mXktx0
	r4ZAiaHDblHmlxqelp8KVImAWOg6w+wB5Soh3BR8SsRZik+wUkGiQbZkhCXZVLWt6p77bF+ilu9gs
	M5bUlOMknd2DxQYooGTfAsQbqGwSZOGSGV4RF2JMNAltlySy8ff5oCDXFp0vBD9Kqmd+rQO+QK73h
	nZoj+2p7virKjT2sZv+hbwOVT2GTrrIG4eHx+6VBwA9fEV43lC9a1q/7P8Z0pimEPUYo7NkA8Xseu
	85KqT6ow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0e-0000000DsYe-1fTL;
	Tue, 21 Oct 2025 17:18:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7A9C8302FD7; Mon, 20 Oct 2025 11:13:25 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:13:25 +0200
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
Message-ID: <20251020091325.GG3245006@noisy.programming.kicks-ass.net>
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

FWIW, an alternative to using task_rq(t) in combination with the guard()
above would be something like:

	CLASS(task_rq_lock, rq_guard)(t);
	struct rq *rq = rq_guard.rq;

> +	if (t->mm != mm)
> +		return false;
> +	if (cid_on_task(t->mm_cid.cid)) {
> +		/* If running on the CPU, transfer the CID, otherwise drop it */
> +		if (task_rq(t)->curr == t)
> +			mm_cid_transfer_to_cpu(t, per_cpu_ptr(mm->mm_cid.pcpu, task_cpu(t)));
> +		else
> +			mm_unset_cid_on_task(t);
> +	}
> +	return true;
> +}

