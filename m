Return-Path: <linux-kernel+bounces-748570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189ADB142DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4098A542C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B38222576;
	Mon, 28 Jul 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHZ6wa8Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B132165EC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753733771; cv=none; b=iSF0Gf8vJPH3UQx6tYY+AWAQBFNFDF8VPnFE7kk+chc1VEoDcmzQDZs8FVA1fsI2G8V+Nv/PGkyz8yY6KfWkPqdDOECA5bwkt+3d8Jv4ScUfCKrDXr65ph3wWvYwlSySYBd3uoSfsB8Wppay7uqEbJVZJFwl7REUCT7m5zXlSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753733771; c=relaxed/simple;
	bh=tSdmsZlF3Cyf3QsBATATBxVcKfKaXFUpA/aj0sdIYuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeBTLzkwD6/LVnJ4xxpiBJZKddCzQPX0MFcPqzcTVNjYFThIxfPDUVM6MASGk92F6daDfXf96OJCzcwuarLsKPGa6jc2T+8sxv+PMNOVtCQw3qCnedYkchNHeIhU6UIlPF5wyieKq6gB4n+KBiRD6aU4l5piO8aX+390UB4wuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHZ6wa8Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753733768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ix+6Z4M7VAksEijsBIInwwoxZTs34otlPm1AzOGrkBI=;
	b=cHZ6wa8YtdTBvDl1FHYWHr0+t2eOZwittxzyuAxxQ4kZZ+j1dMQEnuzLdaQceI5nRTfl9Y
	CYp/wW/jgFfE5O2/Qj4YFylJocZ50CZeKBE602WlGlbu7wATu4OoV+4RXQVYjGUQLucVdi
	jlYd6XBHyS/3kLem6XpGUmhxsF1Jhnw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-hJNtQbreP-e8sh6DCiD4hw-1; Mon,
 28 Jul 2025 16:16:02 -0400
X-MC-Unique: hJNtQbreP-e8sh6DCiD4hw-1
X-Mimecast-MFC-AGG-ID: hJNtQbreP-e8sh6DCiD4hw_1753733760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5090319560AD;
	Mon, 28 Jul 2025 20:15:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9A85430001B1;
	Mon, 28 Jul 2025 20:15:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 28 Jul 2025 22:14:50 +0200 (CEST)
Date: Mon, 28 Jul 2025 22:14:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>, lclaudio00@gmail.com
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250728201441.GA4690@redhat.com>
References: <aGvTz5VaPFyj0pBV@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGvTz5VaPFyj0pBV@uudg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/07, Luis Claudio R. Goncalves wrote:
>
> Instead of adding more complex conditions to decide when to directly
> call __put_task_struct() and when to defer the call, unconditionally
> resort to the deferred call on PREEMPT_RT to simplify the code.
                              ^^^^^^^^^^^^^
Confused... with this patch put_task_struct() always uses the deferred
call, regardless of PREEMPT_RT?

Oleg.

> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -135,24 +135,17 @@ static inline void put_task_struct(struct task_struct *t)
>  		return;
>  
>  	/*
> -	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Under RT, we can only call it in preemptible context.
> -	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> -		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> -
> -		lock_map_acquire_try(&put_task_map);
> -		__put_task_struct(t);
> -		lock_map_release(&put_task_map);
> -		return;
> -	}
> -
> -	/*
> -	 * under PREEMPT_RT, we can't call put_task_struct
> +	 * Under PREEMPT_RT, we can't call __put_task_struct
>  	 * in atomic context because it will indirectly
> -	 * acquire sleeping locks.
> +	 * acquire sleeping locks. The same is true if the
> +	 * current process has a mutex enqueued (blocked on
> +	 * a PI chain).
> +	 *
> +	 * In !RT, it is always safe to call __put_task_struct().
> +	 * Though, in order to simplify the code, resort to the
> +	 * deferred call too.
>  	 *
> -	 * call_rcu() will schedule delayed_put_task_struct_rcu()
> +	 * call_rcu() will schedule __put_task_struct_rcu_cb()
>  	 * to be called in process context.
>  	 *
>  	 * __put_task_struct() is called when
> @@ -165,7 +158,7 @@ static inline void put_task_struct(struct task_struct *t)
>  	 *
>  	 * delayed_free_task() also uses ->rcu, but it is only called
>  	 * when it fails to fork a process. Therefore, there is no
> -	 * way it can conflict with put_task_struct().
> +	 * way it can conflict with __put_task_struct().
>  	 */
>  	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
>  }
> -- 
> 2.50.0
> 


