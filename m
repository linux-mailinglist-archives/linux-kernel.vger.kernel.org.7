Return-Path: <linux-kernel+bounces-759107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905FEB1D88B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC1F1AA45C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227932580E1;
	Thu,  7 Aug 2025 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ePLhwen8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XCuziCiB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0921CA0D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571977; cv=none; b=t+EKx4xBumN8G3bMjzVt8upL7urkhkCgLhMpr27TYb5JEczg3s5tPNCMv5pX4+TqGLqGj31F41Ipd3NaYmoO9QmtlqeguGO84tvpUDbt/UeQ1oSkvLJmenEYrv8pO+HwoZx24/TEghqm2O+wghn44H4xfy1uAXpqr7wGTOZOdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571977; c=relaxed/simple;
	bh=Px/TmjMUj69Ve1XwduN06GFeTouigfgfT0zn70zodVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNwHcA23gBphwAJ/uIWmgcOOjKMaAyv3ojhxKXCR1Pdn5tD+qpedPz5L4T4x75GlEDaoxCJYs2L7O4xAIdduNiQxldXAlwb2PY/SkWei1mQzsCU7Gjhh3yJhhdLNy6RMVgZsUPCQGQSWXUtEdRV8o1Y0isBzciQ4fYBXe11yKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ePLhwen8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XCuziCiB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754571974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FwBVqX2KevXt/0M9kZF1n93/njjfHZHdZPD0JJXBaxk=;
	b=ePLhwen89iC9tKIQsyz8iAHqoDej+U+EYDScxpJOPl4fZUf6FCDV8GbQ0P4W50xJEp107I
	y/2qwzYmv5GsDVwAebHjVGi5BWhjOmJc8y0tYYdRAxWqZB4BZJgWXAWelyH8zJCWDnyOxv
	QqyC1lQdt6smyqE+WILMHQqm2/3qEXxBcUYjtY6vMISwrYR4MBCqG5OSyIY7VcKUwVT4/m
	tyTIfVmcAoSWHerL2XM3ewa8ppbjWxV2NzZkRHDzkutaMhcHHOFHHyNQDg+gfveA1jzSCI
	DhWW3/qTz8tBXm3vg08V+35zgswHFTHhqxePVKOKZqOEORRRQgY1R4VI3pXo8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754571974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FwBVqX2KevXt/0M9kZF1n93/njjfHZHdZPD0JJXBaxk=;
	b=XCuziCiB/z4Bv61M8AExYui9wWqlPJFpgRfDiut2do80u+b6HFE6Lez901+CG6zl+X5JhL
	e9eUC1u5kNufy6Bw==
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, bigeasy@linutronix.de,
 kprateek.nayak@amd.com, vineethr@linux.ibm.com,
 prakash.sangappa@oracle.com
Subject: Re: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
In-Reply-To: <20250724161625.2360309-3-prakash.sangappa@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-3-prakash.sangappa@oracle.com>
Date: Thu, 07 Aug 2025 15:06:12 +0200
Message-ID: <87a54bcmd7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 16:16, Prakash Sangappa wrote:

Indicate this to whom? Can you please write descriptive subject lines
which summarize the change in a way that is comprehensible?

> +void rseq_delay_resched_clear(struct task_struct *tsk)
> +{
> +	u32 flags;
> +
> +	if (tsk->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED) {
> +		tsk->rseq_delay_resched = RSEQ_RESCHED_DELAY_PROBE;
> +		if (copy_from_user_nofault(&flags, &tsk->rseq->flags, sizeof(flags)))
> +                        return;
> +                flags |= RSEQ_CS_FLAG_RESCHEDULED;
> +                copy_to_user_nofault(&tsk->rseq->flags, &flags, sizeof(flags));
> +	}
> +}
>  #endif /* CONFIG_RSEQ_RESCHED_DELAY */
>  
>  #ifdef CONFIG_DEBUG_RSEQ
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e75ecbb2c1f7..ba1e4f6981cd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6752,9 +6752,8 @@ static void __sched notrace __schedule(int sched_mode)
>  picked:
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();
> -	if (IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY) &&
> -	    prev->rseq_delay_resched == RSEQ_RESCHED_DELAY_REQUESTED)
> -		prev->rseq_delay_resched = RSEQ_RESCHED_DELAY_PROBE;
> +	if(IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
> +		rseq_delay_resched_clear(prev);

Yet another unconditional function call for the sake of something which
is only used by special applications. This is the scheduler hotpath and
not a dump ground for random functionality, which is even completely
redundant. Why redundant?

The kernel already handles in rseq, that a task was scheduled out:

    schedule()
       prepare_task_switch()
         rseq_preempt()

rseq_preempt() sets RSEQ_EVENT_PREEMPT_BIT and TIF_NOTIFY_RESUME, which
causes exit to userspace to invoke __rseq_handle_notify_resume(). That's
the obvious place to handle this instead of inflicting it into the
scheduler hotpath.

No?

Thanks,

        tglx

