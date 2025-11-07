Return-Path: <linux-kernel+bounces-890648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477EC408FD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3186C4F0D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF12EDD4D;
	Fri,  7 Nov 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EE9YBVw/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrHbe4Fr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB390220F38
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528779; cv=none; b=D05jTTRZlkr3F9P7U6147aWlsf+E6/xko9SENPQVTMF9aFQ1VCSaazXjhRmJGyKXax+jQrvhILVaeV+qXZoIzjaMGjLmsmy1xZFGYR3WLI/sRJOA9IrxjBoIAPWr2A1M6GllL8ZZ2wwZWXQmRwisSwCaqzO2D+my99kkagBpfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528779; c=relaxed/simple;
	bh=edr/lkaOuTCTyvPNCU3sC0NiFYTWChs4jos0Oe2v9c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/Dr1mp/CM2UbkN2nIOGFEaSQwnU77Y85vpZRsdF61jSgxjNFAkJ0qya3kR++++M9jS7XFKY/f/h/fKqJTZDT04OqfAp5hdKTXH+x38BqOo/yabe3btM7bzfMbm/mArZE2SG61YMGgCy5VipOD5Wi2wX/bo0I8jYBzxE5Bpwy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EE9YBVw/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrHbe4Fr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762528776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pEqaoboZeQr2HPVcictvI9mXo/22ZUbUWYmT7tbCing=;
	b=EE9YBVw/VIG5g3gRE3sNAPiWXOqSQJyvZ6sybW2Lv/31ZrhaCFBa/RHPMBhOTQ8Gly9ho0
	dW56tKCp31CRfHLUS4KqZDeM4HIABB3X025Wg8N5Mq4UO5hwf5PRmpDGCbCkXkTuype0UV
	85q01GXQnO/zO5FiNppfSlOJCXg8ORw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-BAIpeXSVM5SPhuQOzDJfQg-1; Fri, 07 Nov 2025 10:19:35 -0500
X-MC-Unique: BAIpeXSVM5SPhuQOzDJfQg-1
X-Mimecast-MFC-AGG-ID: BAIpeXSVM5SPhuQOzDJfQg_1762528774
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2ad2a58cso91716f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762528774; x=1763133574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEqaoboZeQr2HPVcictvI9mXo/22ZUbUWYmT7tbCing=;
        b=KrHbe4FrgjiKsGeKqaHhFRYov6yrx4GDb1wGk4FYEzHMbsZPe28vWWIQTL1uioagmn
         0SwPPzzv8MhfJ+YOX3h6L+FDFFa9vrcm8u3zShVPQfX2NYQG/T4th4mmm23Z7KmaIoO0
         0ePdHBHohKg47zhKFox6GdcS1yx/UDIdzUkIZsoFZ1E63GErnQKHh1JPtN2nVlUlvrGQ
         dOiRAqKLLGyo4OKSR80VKvNEXjS8GF7CRl4AdV7wzbOt5qzcvH6Peu+CjysSMoJUPlIo
         jP5xDn+3Rz10DKU1l+62R3HkOCQXhQLpaV8iquQfplTK1FD3H5tsF/SydPXxWVlJnwIF
         axBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762528774; x=1763133574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEqaoboZeQr2HPVcictvI9mXo/22ZUbUWYmT7tbCing=;
        b=nOTX4U4XdSU6jqKmnrbZF6Krg3NhOot8nJtB0wN33hc8bmRNkuhh80XuRsJFR9Nfvl
         ERdr+m2KdnFLR4ObSUkZECqfuBd28AJTpKxZl4hM8SiBiMnsUdtm07kiuTWu+thxrqJA
         2p7DtOpTpiYYzVxVB5fYW96izwbDEPDeYAE2LBWAE/8MX2bShBQ0iRxJbUdKHVmFxGmC
         mFc6ys5fwTpRdLSal44TaJ0SyiD2kV6Ua3hI41k5MZT2EA5g3hyS+RG4bhmgaYPRZNxC
         cdebx0vuwNgTMx8r8ES9QeH7H27UFy12Hn3r8zsdFzPIgXBcJ5G64m8Rut1O283+wtOP
         XvUg==
X-Gm-Message-State: AOJu0YzG95KN9+pP5M7I1+RXxgKESm1wciOEqVbK0XZXDxynTcUGJuxt
	VGHv2VG8nugv88SCSQ4YG5tjqkIEg3Bb5FVrPdbIXlwr5KFM6A96ywT+cOuMJYWlVaSLw5c6zfA
	Ygs87cydgtiuLUeJ2Ts04uZpAxngiqIF9cGLFLAFTKXj/N68HHR17kRiw7Q7na+sQNw==
X-Gm-Gg: ASbGncudgsASmJrZlvmu5uXnoUAxJJKMKWuPChrTQFoke6p0flCqSZrORMcvwxTGEog
	Ksy5OD6KdvdCHqVoB5mt+qiWwnGEvD8s+wAkcqtdhSdNXA/g4pzMBLikSyaoEUyPLpmeXtZpQXH
	4gIasU89ZyBvNpBb1YZLQp0BDZx5YrkVbCC03EKROx7WOPSbWNnzE3xRN434Vd+GXxzl5cRpQ/W
	Cen2HqDyFrOhCxjMt50oNvYwn87TyNeo9ysteEMJexihr09vN8eKJ190C7IfjlO/a0xAusTKatI
	KXS+d+erDSbGnAXY78mSQ1Ks6TFOM2dtNOn/LKFd6s813pY0NC0jGwFrah3KGihrCRjKr0meVDs
	daxUB6PBj3thufCWbC6OQDeeo3nrATg==
X-Received: by 2002:a5d:64c9:0:b0:429:8d0f:e92 with SMTP id ffacd0b85a97d-42adc688670mr2202028f8f.6.1762528774026;
        Fri, 07 Nov 2025 07:19:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2XYjOhyXbjlUGSbmh5xTfWnmEhZrW2YyB6c/K7DF/9tRrAzjabK51nA78MDvWieIkdf+nfA==
X-Received: by 2002:a5d:64c9:0:b0:429:8d0f:e92 with SMTP id ffacd0b85a97d-42adc688670mr2201986f8f.6.1762528773423;
        Fri, 07 Nov 2025 07:19:33 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca47sm5678060f8f.24.2025.11.07.07.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:19:32 -0800 (PST)
Date: Fri, 7 Nov 2025 16:19:30 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [PATCH v23 6/9] sched: Handle blocked-waiter migration (and
 return migration)
Message-ID: <aQ4OAn0bugNVv1bA@jlelli-thinkpadt14gen4.remote.csb>
References: <20251030001857.681432-1-jstultz@google.com>
 <20251030001857.681432-7-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030001857.681432-7-jstultz@google.com>

Hi,

On 30/10/25 00:18, John Stultz wrote:
> Add logic to handle migrating a blocked waiter to a remote
> cpu where the lock owner is runnable.
> 
> Additionally, as the blocked task may not be able to run
> on the remote cpu, add logic to handle return migration once
> the waiting task is given the mutex.
> 
> Because tasks may get migrated to where they cannot run, also
> modify the scheduling classes to avoid sched class migrations on
> mutex blocked tasks, leaving find_proxy_task() and related logic
> to do the migrations and return migrations.
> 
> This was split out from the larger proxy patch, and
> significantly reworked.
> 
> Credits for the original patch go to:
>   Peter Zijlstra (Intel) <peterz@infradead.org>
>   Juri Lelli <juri.lelli@redhat.com>
>   Valentin Schneider <valentin.schneider@arm.com>
>   Connor O'Brien <connoro@google.com>
> 
> Signed-off-by: John Stultz <jstultz@google.com>
> ---

...

> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +static inline void proxy_set_task_cpu(struct task_struct *p, int cpu)
> +{
> +	unsigned int wake_cpu;
> +
> +	/*
> +	 * Since we are enqueuing a blocked task on a cpu it may
> +	 * not be able to run on, preserve wake_cpu when we
> +	 * __set_task_cpu so we can return the task to where it
> +	 * was previously runnable.
> +	 */
> +	wake_cpu = p->wake_cpu;
> +	__set_task_cpu(p, cpu);
> +	p->wake_cpu = wake_cpu;
> +}
> +#endif /* CONFIG_SCHED_PROXY_EXEC */
> +

...

> +static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
> +			       struct task_struct *p, int target_cpu)
>  {
> -	if (!__proxy_deactivate(rq, donor)) {
> -		/*
> -		 * XXX: For now, if deactivation failed, set donor
> -		 * as unblocked, as we aren't doing proxy-migrations
> -		 * yet (more logic will be needed then).
> -		 */
> -		clear_task_blocked_on(donor, NULL);
> +	struct rq *target_rq = cpu_rq(target_cpu);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * Since we're going to drop @rq, we have to put(@rq->donor) first,
> +	 * otherwise we have a reference that no longer belongs to us.
> +	 *
> +	 * Additionally, as we put_prev_task(prev) earlier, its possible that
> +	 * prev will migrate away as soon as we drop the rq lock, however we
> +	 * still have it marked as rq->curr, as we've not yet switched tasks.
> +	 *
> +	 * So call proxy_resched_idle() to let go of the references before
> +	 * we release the lock.
> +	 */
> +	proxy_resched_idle(rq);
> +
> +	WARN_ON(p == rq->curr);
> +
> +	deactivate_task(rq, p, 0);
> +	proxy_set_task_cpu(p, target_cpu);

We use proxy_set_task_cpu() here. BTW, can you comment/expand on why an
ad-hoc set_task_cpu() is needed for proxy?

> +
> +	/*
> +	 * We have to zap callbacks before unlocking the rq
> +	 * as another CPU may jump in and call sched_balance_rq
> +	 * which can trip the warning in rq_pin_lock() if we
> +	 * leave callbacks set.
> +	 */
> +	zap_balance_callbacks(rq);
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +	raw_spin_rq_lock(target_rq);
> +
> +	activate_task(target_rq, p, 0);
> +	wakeup_preempt(target_rq, p, 0);
> +
> +	raw_spin_rq_unlock(target_rq);
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +}
> +
> +static void proxy_force_return(struct rq *rq, struct rq_flags *rf,
> +			       struct task_struct *p)
> +{
> +	struct rq *this_rq, *target_rq;
> +	struct rq_flags this_rf;
> +	int cpu, wake_flag = 0;
> +
> +	lockdep_assert_rq_held(rq);
> +	WARN_ON(p == rq->curr);
> +
> +	get_task_struct(p);
> +
> +	/*
> +	 * We have to zap callbacks before unlocking the rq
> +	 * as another CPU may jump in and call sched_balance_rq
> +	 * which can trip the warning in rq_pin_lock() if we
> +	 * leave callbacks set.
> +	 */
> +	zap_balance_callbacks(rq);
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +
> +	/*
> +	 * We drop the rq lock, and re-grab task_rq_lock to get
> +	 * the pi_lock (needed for select_task_rq) as well.
> +	 */
> +	this_rq = task_rq_lock(p, &this_rf);
> +	update_rq_clock(this_rq);
> +
> +	/*
> +	 * Since we let go of the rq lock, the task may have been
> +	 * woken or migrated to another rq before we  got the
> +	 * task_rq_lock. So re-check we're on the same RQ. If
> +	 * not, the task has already been migrated and that CPU
> +	 * will handle any futher migrations.
> +	 */
> +	if (this_rq != rq)
> +		goto err_out;
> +
> +	/* Similarly, if we've been dequeued, someone else will wake us */
> +	if (!task_on_rq_queued(p))
> +		goto err_out;
> +
> +	/*
> +	 * Since we should only be calling here from __schedule()
> +	 * -> find_proxy_task(), no one else should have
> +	 * assigned current out from under us. But check and warn
> +	 * if we see this, then bail.
> +	 */
> +	if (task_current(this_rq, p) || task_on_cpu(this_rq, p)) {
> +		WARN_ONCE(1, "%s rq: %i current/on_cpu task %s %d  on_cpu: %i\n",
> +			  __func__, cpu_of(this_rq),
> +			  p->comm, p->pid, p->on_cpu);
> +		goto err_out;
>  	}
> -	return NULL;
> +
> +	proxy_resched_idle(this_rq);
> +	deactivate_task(this_rq, p, 0);
> +	cpu = select_task_rq(p, p->wake_cpu, &wake_flag);
> +	set_task_cpu(p, cpu);

But, then use the 'standard' set_task_cpu() for the return migration. Is
that intended?

> +	target_rq = cpu_rq(cpu);
> +	clear_task_blocked_on(p, NULL);
> +	task_rq_unlock(this_rq, p, &this_rf);
> +
> +	/* Drop this_rq and grab target_rq for activation */
> +	raw_spin_rq_lock(target_rq);
> +	activate_task(target_rq, p, 0);
> +	wakeup_preempt(target_rq, p, 0);
> +	put_task_struct(p);
> +	raw_spin_rq_unlock(target_rq);
> +
> +	/* Finally, re-grab the origianl rq lock and return to pick-again */
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +	return;
> +
> +err_out:
> +	put_task_struct(p);
> +	task_rq_unlock(this_rq, p, &this_rf);
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +	return;

Thanks,
Juri


