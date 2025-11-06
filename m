Return-Path: <linux-kernel+bounces-889180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C46C3CE13
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86D1D352896
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098034F494;
	Thu,  6 Nov 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjnOtTtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB830F553
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450638; cv=none; b=V9McKXL7DmJ1ZcXsBsf+aziGHKNsjiqZP8vzA5i/ztly7C66r4pmkjxF8K1KnCgB6qUaKtT9SPYiHM7WuhoMaa7p4wC4bzPBTJZxQtVkAhUxGLkYwccXBo0Fh/jD+8Pf93SfdCqWokmagXFTJuXFtgYBCQZSO7jzKmmCmrdxJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450638; c=relaxed/simple;
	bh=LVWeIoq/VV+8+O1rMvlN+6dXnf3o7pJAYGkyG+L4RW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeOLHz2UMwded/X9vbbn+jdPxDEO95CvSWqL40jnITfP5lTojrqFYEAH+r9XC+8aCqpnnlGnVQdXjRG8ZZqjXOHDTd1fAhjAuUMQ2tGq3SmynmC8LT/SM/TFtp4R9UaRiGvqendCg81ZnMfEEte/6UOxgNEN67JHd9iOMz1Tw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjnOtTtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59879C116B1;
	Thu,  6 Nov 2025 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762450637;
	bh=LVWeIoq/VV+8+O1rMvlN+6dXnf3o7pJAYGkyG+L4RW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjnOtTtEra9cr/xA75e5a06uYiBjtAhcN0UAHeg/Uyad8+1fwRvMXBKE56pvuk5aV
	 iJ+5zIo0KWx8C8D/qubgehMh9mtmE46zxxwk7TY3+XV0vOXi72yDbFdysIX7tzqBa3
	 wmtmy6MZXJweORWRY4BRRqHX6ihEa4u+nGwfeP1l6RWL+BToenVJ/qlM0TbUcNNNt4
	 kDD6eMymv6VCqfA3ndbW9ku+vRKpCXGs25RMMmw9AN+wmQXxjjLIxbDSHbOAE5ZGXM
	 dP3aQOcBQAqAmDUcnZdkNWZWxUJyQGb1EzoWz/rIIZGwTtq8SLeL3JS9jgu+FiPtKC
	 BWl67NHAQpsww==
Date: Thu, 6 Nov 2025 07:37:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH cgroup/for-6.19] cgroup: Fix sleeping from invalid
 context warning on PREEMPT_RT
Message-ID: <aQzczJZFiGPOocKb@slm.duckdns.org>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <aQpUY7fEp6_ZqGel@slm.duckdns.org>
 <aQtqXfMfy8SWjS67@mozart.vkv.me>
 <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20251106150717.cZuPZnF5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106150717.cZuPZnF5@linutronix.de>

Hello,

On Thu, Nov 06, 2025 at 04:07:17PM +0100, Sebastian Andrzej Siewior wrote:
> How important is it, that it happens right away? Written as-is, this

Not important at all.

> leads to an interrupt then wakes irq_work/$cpu thread which then runs
> this callback. That thread runs as SCHED_FIFO-1. This means the
> termination of a SCHED_OTHER tasks on a single CPU will run as follows:
>  - TASK_DEAD
>    schedule()
>      - queue IRQ_WORK
>      -> INTERRUPT
>      -> WAKE irq_work
>    -> preempt to irq_work/
>       -> handle one callback
>       schedule()
>  back to next TASK_DEAD
> 
> So cgrp_dead_tasks_iwork_fn() will never have to opportunity to batch.
> Unless the exiting task's priority is > 1. Then it will be delayed
> until all RT tasks are done.
> 
> My proposal would be to init the irq_work item with
> 	*per_cpu_ptr(&cgrp_dead_tasks_iwork, cpu) = IRQ_WORK_INIT_LAZY(cgrp_dead_tasks_iwork_fn);
> 
> instead which won't raise an IRQ immediately and delay the callback
> until the next timer tick. So it could batch multiple tasks.
> 
> [ queue_work() should work, too but the overhead to schedule is greater
>   imho so this makes sense ]

Will switch to IRQ_WORK_LAZY_INIT.

Thanks for the review.

-- 
tejun

