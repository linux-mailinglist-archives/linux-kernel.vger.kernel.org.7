Return-Path: <linux-kernel+bounces-895767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C1CC4EDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 532E64F222E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C49926E146;
	Tue, 11 Nov 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD0pqxP/"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48463590C5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876022; cv=none; b=KKFv4TigUaV0+SQkufq3kMs2VXQdb9fw4ob0YmjvzsVqjS5flYgBsm6AHSRAZGGEZHU4i+vykxBhJRwecHW9KJmpY/g+cuQ9tOwFzxUgjWtumzquEbC64o/BCE17yblFjFtei7vWPXDyr3T+1BE1qyEM1C4ZcFlc0J1Q+GQWVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876022; c=relaxed/simple;
	bh=Vr9ilakB/2CSSmgnPYWz9nZv6Sj3mxOnkEwRwrfp1Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5ew/IInwH0dk+gHdX931MAGr1Cb2ylNkRt+vxIftZTvqHCiPrweuJ0okzu3fOxUlPKJtWOmIa3bFFVPtkqSYkItWh/b2Qhl7e9u4BWdQn8N3ARYDZ3vd59aMfHC7DECjTd9FXdjWn2IwBFfxJV3vpl4SLhEUMPbSV2H0rk0r+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD0pqxP/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87c13813464so55738176d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876020; x=1763480820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQOnWL663gEoiQsyC67UNYm0FgIt/gai4983BOc4+nk=;
        b=gD0pqxP/q3tYyIjd2Qx1JvNl5QUtYQ7hmS5n9jfX+YKW0Ox4tpteUhhN5vEQFENK5i
         nDW3zC099SRwy7AsVoG/+V9HwVFHshWq0YRY8ixt5P+MkXp3jPdTIfMcPVj+P9zOZO3B
         Y9CgImixGGMcQyOHGNMLATdRHD87atvAF6DgwnhCySbj+kLlX5aIAOg3BIQ3yzFHgg6r
         Jnhlvtvk5XdXSnQPa4NeLV1dNTUbw1DnTlG53HDLc9podSWtgKyZgjRLiWc3/szxHfWe
         xPbWSMaCOVpTVb50KHv9TtxKt6T/WkS4r9JDbdlYWSr8mJQs3przHP61OZ4VWDc5t3cr
         XVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876020; x=1763480820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQOnWL663gEoiQsyC67UNYm0FgIt/gai4983BOc4+nk=;
        b=TsMFqYIQmMoVG7ExooQK0VG+LnpEE2Ta7rzcEwRAn3ZVeclZodLZ54DCtVYm2XsyVS
         QmhpMrC+SAkKP+rBRU4GB3ywMPjTQA1eSGXdLp95OM9odxx1g3mMJWrHHpbNpdsITHPC
         wFEZx1IlYQv1kBuzVqVEL4Gv8FBkBRglaNXoH7IF3OorKc2qaVEFu/v5SAumSff5D38F
         8a6N1elwmDtQVLMq3xFMJ0ZDvCBL0BUcWYgvUvp3NvnXv+KZw518HvedymD/FA1KqSYP
         JrWSsX/XKo6JHQEVnpOOlM3c7SQJDFRWhe+8mc/gWW6Nx7jGjB7ur+clXv+wIJQj8Int
         8D7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk+UtrMvrih76SvFrIu+WT0hxBFyrHY9fpoOyszn3pP0e7VnMAyOJyntq5TGR27Kis97YQGcWYk/9Dl6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnx5ipspnnANWhOLR4nYZZ0MaLjdUEkkMkbU0cwlCb1/Bg/2bG
	ZCfHGo4HU2yv25RxkJyXP/MvhXIMT3n0jWzrYMxJf2OY6T/7qDGz9kf/WwTZ9Q==
X-Gm-Gg: ASbGncsHB/g32QPiHNZH5+QjcmJxtkbnvC/5qgtTcFZNFcsqxfrYQFA68FIXGBC+FNo
	1eXOscjdaoGtppupPJeHnnddmknasoman8GBZZ2b3GRpYsFcPjLwxT6xTqofdufyzzq+ulmaVJO
	f83Qr6e6eP5Fj0ZEnrs1w414CZT4zscOPShvnyaDAmTvoAPs+hen1ayhWXrEFx1bMZT533CJvFA
	Sz9qcxtBXhd1q5KZaa7V7pvXOPsgLFyVwZ/ZBGWzaRfR2v9CF1IuQdy5rzxtH2IR8pkqXJWgFQ4
	xnG8isLG/zQrGOxy725kHCrkVAFfF/ID/pC3cFwCBUGbSHehUjFZJikhMGDSCvUaniO1gxzhZDq
	Hj/fENMRyDdzZZfT8H95Y25GQsqmKBcYkmf/dbd6Xpn4/ov0ve0kCYWjU6LfMUf2JXBjMiQZH+i
	as7FReasjYK44cebub4yVQtjYc
X-Google-Smtp-Source: AGHT+IE5FRQSNy/tqsIIZPpM8gFYbvNlp2nU7N9a0Xxi+QoFXmqQc/Qa5vMKYGay9Xi+xR6krlCrlQ==
X-Received: by 2002:a05:6214:5f84:b0:882:3b63:f7f5 with SMTP id 6a1803df08f44-8823b63fa19mr160022966d6.41.1762876019693;
        Tue, 11 Nov 2025 07:46:59 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda564858fsm68522411cf.14.2025.11.11.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:46:59 -0800 (PST)
Date: Tue, 11 Nov 2025 10:46:57 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] sched_ext: Exit dispatch and move operations
 immediately when aborting
Message-ID: <aRNacaSw3QkzuL2y@dschatzberg-fedora-PF3DHTBV>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-7-tj@kernel.org>

On Sun, Nov 09, 2025 at 08:31:05AM -1000, Tejun Heo wrote:
> 62dcbab8b0ef ("sched_ext: Avoid live-locking bypass mode switching") introduced
> the breather mechanism to inject delays during bypass mode switching. It
> maintains operation semantics unchanged while reducing lock contention to avoid
> live-locks on large NUMA systems.
> 
> However, the breather only activates when exiting the scheduler, so there's no
> need to maintain operation semantics. Simplify by exiting dispatch and move
> operations immediately when scx_aborting is set. In consume_dispatch_q(), break
> out of the task iteration loop. In scx_dsq_move(), return early before
> acquiring locks.
> 
> This also fixes cases the breather mechanism cannot handle. When a large system
> has many runnable threads affinitized to different CPU subsets and the BPF
> scheduler places them all into a single DSQ, many CPUs can scan the DSQ
> concurrently for tasks they can run. This can cause DSQ and RQ locks to be held
> for extended periods, leading to various failure modes. The breather cannot
> solve this because once in the consume loop, there's no exit. The new mechanism
> fixes this by exiting the loop immediately.
> 
> The bypass DSQ is exempted to ensure the bypass mechanism itself can make
> progress.
> 
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 62 ++++++++++++++--------------------------------
>  1 file changed, 18 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 905d01f74687..afa89ca3659e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1821,48 +1821,11 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  	return dst_rq;
>  }
>  
> -/*
> - * A poorly behaving BPF scheduler can live-lock the system by e.g. incessantly
> - * banging on the same DSQ on a large NUMA system to the point where switching
> - * to the bypass mode can take a long time. Inject artificial delays while the
> - * bypass mode is switching to guarantee timely completion.
> - */
> -static void scx_breather(struct rq *rq)
> -{
> -	u64 until;
> -
> -	lockdep_assert_rq_held(rq);
> -
> -	if (likely(!READ_ONCE(scx_aborting)))
> -		return;
> -
> -	raw_spin_rq_unlock(rq);
> -
> -	until = ktime_get_ns() + NSEC_PER_MSEC;
> -
> -	do {
> -		int cnt = 1024;
> -		while (READ_ONCE(scx_aborting) && --cnt)
> -			cpu_relax();
> -	} while (READ_ONCE(scx_aborting) &&
> -		 time_before64(ktime_get_ns(), until));
> -
> -	raw_spin_rq_lock(rq);
> -}
> -
>  static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
>  			       struct scx_dispatch_q *dsq)
>  {
>  	struct task_struct *p;
>  retry:
> -	/*
> -	 * This retry loop can repeatedly race against scx_bypass() dequeueing
> -	 * tasks from @dsq trying to put the system into the bypass mode. On
> -	 * some multi-socket machines (e.g. 2x Intel 8480c), this can live-lock
> -	 * the machine into soft lockups. Give a breather.
> -	 */
> -	scx_breather(rq);
> -
>  	/*
>  	 * The caller can't expect to successfully consume a task if the task's
>  	 * addition to @dsq isn't guaranteed to be visible somehow. Test
> @@ -1876,6 +1839,17 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
>  	nldsq_for_each_task(p, dsq) {
>  		struct rq *task_rq = task_rq(p);
>  
> +		/*
> +		 * This loop can lead to multiple lockup scenarios, e.g. the BPF
> +		 * scheduler can put an enormous number of affinitized tasks into
> +		 * a contended DSQ, or the outer retry loop can repeatedly race
> +		 * against scx_bypass() dequeueing tasks from @dsq trying to put
> +		 * the system into the bypass mode. This can easily live-lock the
> +		 * machine. If aborting, exit from all non-bypass DSQs.
> +		 */
> +		if (unlikely(READ_ONCE(scx_aborting)) && dsq->id != SCX_DSQ_BYPASS)
> +			break;
> +
>  		if (rq == task_rq) {
>  			task_unlink_from_dsq(p, dsq);
>  			move_local_task_to_local_dsq(p, 0, dsq, rq);
> @@ -5635,6 +5609,13 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
>  		return false;
>  
> +	/*
> +	 * If the BPF scheduler keeps calling this function repeatedly, it can
> +	 * cause similar live-lock conditions as consume_dispatch_q().
> +	 */
> +	if (unlikely(scx_aborting))
> +		return false;
> +
>  	/*
>  	 * Can be called from either ops.dispatch() locking this_rq() or any
>  	 * context where no rq lock is held. If latter, lock @p's task_rq which
> @@ -5655,13 +5636,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  		raw_spin_rq_lock(src_rq);
>  	}
>  
> -	/*
> -	 * If the BPF scheduler keeps calling this function repeatedly, it can
> -	 * cause similar live-lock conditions as consume_dispatch_q(). Insert a
> -	 * breather if necessary.
> -	 */
> -	scx_breather(src_rq);
> -
>  	locked_rq = src_rq;
>  	raw_spin_lock(&src_dsq->lock);
>  
> -- 
> 2.51.1
> 

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>

