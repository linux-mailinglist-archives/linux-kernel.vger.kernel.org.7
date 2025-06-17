Return-Path: <linux-kernel+bounces-690329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB083ADCF23
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18B317BF5B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E422EE608;
	Tue, 17 Jun 2025 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bY8+66kK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5882EE604
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169279; cv=none; b=Ltm2UybOSY0BGd2+vHBy/EsEp/BDRy+5e3UFRdwvC8JsxkJ6ITPwA3HFKfYETYKqCtLTqTFhDb7s6daFAz6fLuat6g2rBRsIr0Cvq8gpEvr0liPs/Lfst6iiuY0eFh6Q0JkZS6gjuH6KDvx7nJEv4o1Z3Yl+cqAWVEXaGl6Mfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169279; c=relaxed/simple;
	bh=mrVz5aQbXDSkFCUfa28x+our51fySbAWuqOQYZ7A8Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unSR2NgxECD/F0DLMbWaHZHq5GM91a0EANPEliWIvPAqrCCYA/qU4Z+vfvGgUv+W/U395bPNI8a5HBU0O8hl3wRsiTOerFf9W9BiIzNJl9U+nvtdyP2z2BbfaeqBjxCC0gfFV2HCYaHyE7xmMhqzDugx+ZRLGmPLVGfqe+nkVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bY8+66kK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750169276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0Q2MBzTTKliPXoPTodX154c6A+J9aen4rIOAnQ4Lk=;
	b=bY8+66kKVI8E/ezyXa7uqVTTymRJUor2STZuLBinHYKVaa2i3ismT0huYDfqMryt2ZD5Ul
	0ZasnshrZjSV5FkGINMc3uQdjjm4xDNvJ8OqAX8YGekXTvCoFxYSOHErNCJKnf1l12CUQz
	j/p0yDskjueyLVPuZnH8ZMPvxt+us78=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-7qoSejBiOZS5vYt1MFZrYQ-1; Tue,
 17 Jun 2025 10:07:52 -0400
X-MC-Unique: 7qoSejBiOZS5vYt1MFZrYQ-1
X-Mimecast-MFC-AGG-ID: 7qoSejBiOZS5vYt1MFZrYQ_1750169270
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E890180AE04;
	Tue, 17 Jun 2025 14:07:50 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.173])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B0311195E342;
	Tue, 17 Jun 2025 14:07:42 +0000 (UTC)
Date: Tue, 17 Jun 2025 11:07:40 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, David Vernet <dvernet@meta.com>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <b3lzfprjfzuyk5x2xhd2xx2v7mhuzkkkugvfuvl3hmqlsbvtfc@o6bz42judcyy>
References: <aFF1BKtdQCnuYMaS@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFF1BKtdQCnuYMaS@uudg.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Jun 17, 2025 at 11:00:36AM -0300, Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> with a mutex enqueued. That could lead to this sequence:
> 
>         rt_mutex_adjust_prio_chain()
>           put_task_struct()
>             __put_task_struct()
>               sched_ext_free()
>                 spin_lock_irqsave()
>                   rtlock_lock() --->  TRIGGERS
>                                       lockdep_assert(!current->pi_blocked_on);
> 
> Fix that by unconditionally resorting to the deferred call to
> __put_task_struct() if PREEMPT_RT is enabled.
> 
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
> 
> v2: (Rostedt) remove the #ifdef from put_task_struct() and create
>     tsk_is_pi_blocked_on() in sched.h to make the change cleaner.
> v3: (Sebastian, PeterZ) always call the deferred __put_task_struct() on RT.
> v4: Fix the implementation of what was requested on v3.
> v5: Add the "Fixes:" tag.
> 
>  include/linux/sched/task.h |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 0f2aeb37bbb04..51678a541477a 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -134,11 +134,8 @@ static inline void put_task_struct(struct task_struct *t)
>  	if (!refcount_dec_and_test(&t->usage))
>  		return;
>  
> -	/*
> -	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Under RT, we can only call it in preemptible context.
> -	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> +	/* In !RT, it is always safe to call __put_task_struct(). */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
>  
>  		lock_map_acquire_try(&put_task_map);
> @@ -148,11 +145,13 @@ static inline void put_task_struct(struct task_struct *t)
>  	}
>  
>  	/*
> -	 * under PREEMPT_RT, we can't call put_task_struct
> +	 * Under PREEMPT_RT, we can't call __put_task_struct
>  	 * in atomic context because it will indirectly
> -	 * acquire sleeping locks.
> +	 * acquire sleeping locks. The same is true if the
> +	 * current process has a mutex enqueued (blocked on
> +	 * a PI chain).
>  	 *
> -	 * call_rcu() will schedule delayed_put_task_struct_rcu()
> +	 * call_rcu() will schedule __put_task_struct_rcu_cb()
>  	 * to be called in process context.
>  	 *
>  	 * __put_task_struct() is called when
> @@ -165,7 +164,7 @@ static inline void put_task_struct(struct task_struct *t)
>  	 *
>  	 * delayed_free_task() also uses ->rcu, but it is only called
>  	 * when it fails to fork a process. Therefore, there is no
> -	 * way it can conflict with put_task_struct().
> +	 * way it can conflict with __put_task_struct().
>  	 */
>  	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
>  }
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>


