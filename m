Return-Path: <linux-kernel+bounces-802589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A2B45445
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2A05A335D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4536E2D1F69;
	Fri,  5 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="zJqRQEc4"
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088F2D23A8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067329; cv=none; b=IgDgZG/2ENylB5zlaRpkEBb4emsZzx1Pt1twN7wnLcJ/K8X4NncVW9RzP8jTBr3tdUgFjblrSCBsgXngd8wnwBdkPf6o4HF7ddRdmt6zh+38+xDCdpHcwrmEA21H3S0PV1rjmHPU1zsoTWeO27nJX/0s6GOrMCsASq4zaeW7m7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067329; c=relaxed/simple;
	bh=p/uiPovj10ICfWpo4b/GpUl0eTwbtCjb4Q8Ox6U6FqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXpTRyI+IzEMER2KVtkTyHy6+YMdrzuNA+eum2JYm6l6t92zm1dCx3tCE2d5c/Ofp8rIz4NZ79kqqZ3RNhYPAlvn+dRvHCI6pDdrspFyuVZV/ffWlbf7R/kYKpMrt6la9nNvgIyuoiraC5Fx18Xj85r9JAsX7DHsMhfTbj7zWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=zJqRQEc4; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757067323;
	bh=SDv4Poav655Z7AD9iiHWpHJzqs+HAT+cnYy3QViU30I=;
	h=From:Subject:Date:Message-ID;
	b=zJqRQEc4Jksd1YFrVLl2qKo0ViggirReHeIGfBSklc+5P5jnLlq/Toq9p+0LWi6qr
	 i6d0hcrlZFwo2fXs+mSuigASgyMO3sp7U92rPntiiVEGUHKG3WgSilvqOxUDLellbm
	 c6TBam5vHlcgzVox1QENSUaL6PibNuyMi9upvm44=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68BAB82D00004AB2; Fri, 5 Sep 2025 18:15:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7022586685263
X-SMAIL-UIID: E3733E30E4614B2A8D06D23F523A1283-20250905-181511-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/3] softirq: Provide a handshake for canceling tasklets via polling
Date: Fri,  5 Sep 2025 18:15:01 +0800
Message-ID: <20250905101502.6525-1-hdanton@sina.com>
In-Reply-To: <20250904142526.1845999-3-bigeasy@linutronix.de>
References: <20250904142526.1845999-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  4 Sep 2025 16:25:24 +0200 Sebastian Andrzej Siewior wrote:
> The tasklet_unlock_spin_wait() via tasklet_disable_in_atomic() is
> provided for a few legacy tasklet users. The interface is used from
> atomic context (which is either softirq or disabled preemption) on
> non-PREEMPT_RT an relies on spinning until the tasklet callback
> completes.
> On PREEMPT_RT the context is never atomic but the busy polling logic
> remains. It possible that the thread invoking tasklet_unlock_spin_wait()
> has higher priority than the tasklet. If both run on the same CPU the
> the tasklet makes no progress and the thread trying to cancel the
> tasklet will live-lock the system.
> To avoid the lockup tasklet_unlock_spin_wait() uses local_bh_disable()/
> enable() which utilizes the local_lock_t for synchronisation. This lock
> is a central per-CPU BKL and about to be removed.
> 
> Acquire a lock in tasklet_action_common() which is held while the
> tasklet's callback is invoked. This lock will be acquired from
> tasklet_unlock_spin_wait() via tasklet_callback_cancel_wait_running().
> After the tasklet completed tasklet_callback_sync_wait_running() drops
> the lock and acquires it again. In order to avoid unlocking the lock
> even if there is no cancel request, there is a cb_waiters counter which
> is incremented during a cancel request.
> Blocking on the lock will PI-boost the tasklet if needed, ensuring
> progress is made.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/softirq.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 513b1945987cc..4e2c980e7712e 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -805,6 +805,58 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
>  	return false;
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT
> +struct tasklet_sync_callback {
> +	spinlock_t	cb_lock;
> +	atomic_t	cb_waiters;
> +};
> +
> +static DEFINE_PER_CPU(struct tasklet_sync_callback, tasklet_sync_callback) = {
> +	.cb_lock	= __SPIN_LOCK_UNLOCKED(tasklet_sync_callback.cb_lock),
> +	.cb_waiters	= ATOMIC_INIT(0),
> +};
> +
> +static void tasklet_lock_callback(void)
> +{
> +	spin_lock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
> +}
> +
> +static void tasklet_unlock_callback(void)
> +{
> +	spin_unlock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
> +}
> +
> +static void tasklet_callback_cancel_wait_running(void)
> +{
> +	struct tasklet_sync_callback *sync_cb = this_cpu_ptr(&tasklet_sync_callback);
> +
> +	atomic_inc(&sync_cb->cb_waiters);
> +	spin_lock(&sync_cb->cb_lock);
> +	atomic_dec(&sync_cb->cb_waiters);
> +	spin_unlock(&sync_cb->cb_lock);
> +}
> +
	CPU0			CPU1
	----			----
	lock A
				tasklet C callback
				lock A
	cancel tasklet B
	DEADLOCK-01

After this work could DEADLOCK-01 be triggered, given no chance for DEADLOCK-02 ?

	CPU2			CPU3
	----			----
	lock A
				timer C callback
				lock A
	timer_delete_sync(timer B)
	DEADLOCK-02

> +static void tasklet_callback_sync_wait_running(void)
> +{
> +	struct tasklet_sync_callback *sync_cb = this_cpu_ptr(&tasklet_sync_callback);
> +
> +	if (atomic_read(&sync_cb->cb_waiters)) {
> +		spin_unlock(&sync_cb->cb_lock);
> +		spin_lock(&sync_cb->cb_lock);
> +	}
> +}
> +
> +#else /* !CONFIG_PREEMPT_RT: */
> +
> +static void tasklet_lock_callback(void) { }
> +static void tasklet_unlock_callback(void) { }
> +static void tasklet_callback_sync_wait_running(void) { }
> +
> +#ifdef CONFIG_SMP
> +static void tasklet_callback_cancel_wait_running(void) { }
> +#endif
> +#endif /* !CONFIG_PREEMPT_RT */
> +
>  static void tasklet_action_common(struct tasklet_head *tl_head,
>  				  unsigned int softirq_nr)
>  {
> @@ -816,6 +868,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
>  	tl_head->tail = &tl_head->head;
>  	local_irq_enable();
>  
> +	tasklet_lock_callback();
>  	while (list) {
>  		struct tasklet_struct *t = list;
>  
> @@ -835,6 +888,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
>  					}
>  				}
>  				tasklet_unlock(t);
> +				tasklet_callback_sync_wait_running();
>  				continue;
>  			}
>  			tasklet_unlock(t);
> @@ -847,6 +901,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
>  		__raise_softirq_irqoff(softirq_nr);
>  		local_irq_enable();
>  	}
> +	tasklet_unlock_callback();
>  }
>  
>  static __latent_entropy void tasklet_action(void)
> @@ -897,12 +952,9 @@ void tasklet_unlock_spin_wait(struct tasklet_struct *t)
>  			/*
>  			 * Prevent a live lock when current preempted soft
>  			 * interrupt processing or prevents ksoftirqd from
> -			 * running. If the tasklet runs on a different CPU
> -			 * then this has no effect other than doing the BH
> -			 * disable/enable dance for nothing.
> +			 * running.
>  			 */
> -			local_bh_disable();
> -			local_bh_enable();
> +			tasklet_callback_cancel_wait_running();
>  		} else {
>  			cpu_relax();
>  		}
> -- 
> 2.51.0

