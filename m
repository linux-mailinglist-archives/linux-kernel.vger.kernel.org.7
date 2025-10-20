Return-Path: <linux-kernel+bounces-863432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E2BF7D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FE2035705F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A790F34D4DD;
	Tue, 21 Oct 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZsZMd12C"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662534C805
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067144; cv=none; b=GdcDU5P1FuaSuPaCwu9q233QTHnjtpLWtQlX0gcNS3gh2SDf7jTtHa1oVxluC06qOmtc1x5Dbla9Cx+DTe37na7oB2nXc37v7Q9gG8qvdyni4Fq3i5j3sDUsudhBWH9nLuCfK9jKKsfREp1+jHrbkpUQGJtS9QqnY81AkNE9nmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067144; c=relaxed/simple;
	bh=00/2+DREpEQlqJ4UA8SPxKC2zjZGhMyKiML2L9cLFUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUUTFJjltUQ3iR6zuXWNAq/+fUYUnmob3CRc6WzLzb1kpWj9cJF2DGaQiJ+uhTpgv2+KzeWOL5TpQB03OTyBA+JOUK+cQoiyFF0GpLo0mj70ApO3wHU1D/3PiyXbFbwIKp/+IhGiWePJ0PLjJKe/4FlM/A946DTZt5YD+hjEH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZsZMd12C; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ctkaacDUhFa+HpzMqK3sEhe9CACWQ7XmbpQ/iyJHGjA=; b=ZsZMd12C0x0LQutyy3Wfmd4ejd
	4nwJvmzg5FZ8TMu4UDs9h6EkJPeOqCIuWINQ6HGCgqLuTKZc1OMKAYsYhvMEckq7rQxLrvHKvBgDh
	ppCUhlvmkIt4hQns5vOOeooQXu5WQPPWYm0TJmp1vpvYpl9BIM370lm4Tzo0i59RMk3bqo/8Flr1z
	d1DOqxCaFXCO0Oddc0XOrXtmtq/E2SvTQ3D6MLFpq6LR0hN3W/hBJnR5WytZLx0DmK3+BNQ86dR5V
	S0xhy37jsPlmpLuAQLXIy+PbixkSK4ndyquX9ZkAVClSUVNB+zuPPIlo9b5eNb7TQzq08QkhJk7dH
	CjMTM/qg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0d-0000000DsXZ-1C1p;
	Tue, 21 Oct 2025 17:18:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6BC9930306F; Mon, 20 Oct 2025 11:16:01 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:16:01 +0200
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
Message-ID: <20251020091601.GH3245006@noisy.programming.kicks-ass.net>
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

> +static void __maybe_unused mm_cid_fixup_cpus_to_tasks(struct mm_struct *mm)
> +{
> +	unsigned int cpu;


Alternatively you could take cpus_read_lock() and iterate online_cpus().
No offline CPU should be running a userspace task and all that.

Doesn't really matter much, this also works fine.

> +	/* Walk the CPUs and fixup all stale CIDs */
> +	for_each_possible_cpu(cpu) {
> +		struct mm_cid_pcpu *pcp = per_cpu_ptr(mm->mm_cid.pcpu, cpu);
> +		struct rq *rq = cpu_rq(cpu);
> +
> +		/* Remote access to mm::mm_cid::pcpu requires rq_lock */
> +		guard(rq_lock_irq)(rq);
> +		if (cid_on_cpu(pcp->cid)) {
> +			/* If rq->curr has @mm, fix it up right here */
> +			if (rq->curr->mm == mm && rq->curr->mm_cid.active)
> +				mm_cid_transfer_to_task(rq->curr, pcp);
> +			else
> +				mm_drop_cid_on_cpu(mm, pcp);
> +		}
> +	}
> +}

