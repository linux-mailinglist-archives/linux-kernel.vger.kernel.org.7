Return-Path: <linux-kernel+bounces-845118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04072BC38F9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 227D234E566
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5D2F1FED;
	Wed,  8 Oct 2025 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfutat+y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127D2EBB80
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908540; cv=none; b=RR0VQ1OMYK1BZz3IeIHzLfpz9wFEhoJq8lRD/JiwdsOLF0KbFnIVT/ijfO5hJHZsWTxvpmMcgY4RY9sA21yPQaKefQjooW4EIVSEBtWwkk+6Ekez2dop7Un9YW0zZJRsPSVByMwZ/hjPelKbho/sSblJaiVluBTmZh7Ygk9GA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908540; c=relaxed/simple;
	bh=QVyB4inrTbh/m4y88HI0IJM66yxmVMxyZspcKcK6VNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1IHu+0Od+hiK3+T7bltnDsVASLBTc2WgCzDW1D7PDOrdqsV8q74dxOK8O6UGQP4cL1RpWyXYGLQUNP4UZ60gCtSKnaca3HEC/ycTeEyOwBVHAQiuaA7/Pjdnpb3LhpbftKmtZOiLZzRRd911JxD9/HQ/S3Cu60ddaATLejzaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rfutat+y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759908537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ul81DRuoWdkpYH3U+h1h1uN7zCupMZr/gma+VRdpYxU=;
	b=Rfutat+yb2q2/7q74XNfa3etkHyXCzML3fye2w4fkUfOXzC+srKKOnq5/FaCZOcWpNoCmA
	JsYzTR3+qNoa26hrR5PikRxoxtSHZNzuMQ4QF4j0z7/+5pVoGDeqNYFIL3ST6ygnwRsEes
	ECWiDC1PKYkVD6WkhaQz9MYvGacaMp0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-Qv0KWMpZOWKU_yf93ZKNDg-1; Wed, 08 Oct 2025 03:28:55 -0400
X-MC-Unique: Qv0KWMpZOWKU_yf93ZKNDg-1
X-Mimecast-MFC-AGG-ID: Qv0KWMpZOWKU_yf93ZKNDg_1759908534
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e3d43bbc7so27388005e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908534; x=1760513334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul81DRuoWdkpYH3U+h1h1uN7zCupMZr/gma+VRdpYxU=;
        b=ZDZtH0n+rQCaSvhp0hJU8j9/MbI/xRDA7UFEUJ6RmejsQJnuk0PHgK9mWsw6+6ojqk
         4BhAgokkIHyLvpLFmC/Ql5FkG6GDQ7ObydGnJt+SIR4ofm2J9Jy65qjdzuRsSRNESATS
         6ukUrWBWsUgXXKWqeFWX3hjSMibB+/DQuQmLbjvabvOv+jgqj3RyfLSJUhzoqQQuBKX/
         th4NNXS1ygOkc5Nx3PlWwgRgMz7xGkqjRppTkQtOSWK6fwC3s1Fwf/fL3VW/l2fp4WV4
         9qAA5L9gwFXtXgAj3nMSgzParxX4Ye2UL/BKrpcIRCu3T8YIKnPbdmk5YUUNh6gNbna3
         5MIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDPMhC0nrNwDP/WrMHtvZoELBI60fotx6jg16FHB96y0m1QW5jPD2sHGdCD+5e+NgQNnOcyGRyskpLs7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTm1BuL0AGC4b64ZuGXhXzD51bzqCAnF/iDkmyNrs9c4vWMWX
	A2g175nxFudCOjXV9Mue9A3XgwOxJMKyaQ3IVVCYs2KB4fYI+xrtbtlcMjw8lvGUm9khwSYzWRt
	e6FAhF6HH0eKdlg+8uWWAzDh7YNPKBjcVOyFAl62269KLxP9V5LYZnwToWeJD1v2D7Q==
X-Gm-Gg: ASbGncvffY92aa0ExJfJZ2oWqdQZY3TvJ9O4VpC6h+9voBUfOzMGQlUnO21wReM5NRA
	FIB4ELCnDPKlVvlaNlTpuJLeOBY3Vlk4cpZVa0okpU42/X+Uisfww4rggD94bAhz12lPDV8RuSE
	qQHAKKUVtB6+uhnhzHQijDrPGBmuzqULjtrtqbQ+HJTNbKleuDEJf05wUzEIC6IJIWggdmDPldy
	dzGGhHNrdiRF7pYVSoQtpMLp4xyIEhpWngZWrEEoUZmXzy5tu5VS4DkvjKKu5r5lDKJNXGh2z+E
	bjmCfzkmqlAc6d40WdQ3sAhHrJNQFVDCYSb63rqG+sfjPzCFxISuqMXERa68K0J+1EUkQLYnEur
	UNQ==
X-Received: by 2002:a05:600d:416b:b0:46e:3dc3:b645 with SMTP id 5b1f17b1804b1-46fa9a87f3emr14628885e9.3.1759908533834;
        Wed, 08 Oct 2025 00:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv6MDfkHNOGHzfd6ptcZ6hEk1LTW7PdE4ViI5eOYDgXNIcsTBNCdtHph0lfp7hRL8OSlDRSA==
X-Received: by 2002:a05:600d:416b:b0:46e:3dc3:b645 with SMTP id 5b1f17b1804b1-46fa9a87f3emr14628655e9.3.1759908533393;
        Wed, 08 Oct 2025 00:28:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4f3b07sm8095225e9.2.2025.10.08.00.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:28:52 -0700 (PDT)
Date: Wed, 8 Oct 2025 09:28:50 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 09/24] sched/rt: Add {alloc/free}_rt_sched_group
Message-ID: <aOYSsrIjzcq5Av34@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-10-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-10-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Add allocation and deallocation code for rt-cgroups.
> Declare dl_server specific functions (no implementation yet), needed by
> the allocation code.
> 
> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/rt.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 84dbb4853b6..3094f59d0c8 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -93,8 +93,43 @@ void unregister_rt_sched_group(struct task_group *tg)
>  
>  void free_rt_sched_group(struct task_group *tg)
>  {
> +	int i;
> +	unsigned long flags;
> +	struct rq *served_rq;
> +
>  	if (!rt_group_sched_enabled())
>  		return;
> +
> +	if (!tg->dl_se || !tg->rt_rq)
> +		return;
> +
> +	for_each_possible_cpu(i) {
> +		if (!tg->dl_se[i] || !tg->rt_rq[i])
> +			continue;
> +
> +		/*
> +		 * Shutdown the dl_server and free it
> +		 *
> +		 * Since the dl timer is going to be cancelled,
> +		 * we risk to never decrease the running bw...
> +		 * Fix this issue by changing the group runtime
> +		 * to 0 immediately before freeing it.
> +		 */
> +		dl_init_tg(tg->dl_se[i], 0, tg->dl_se[i]->dl_period);
> +
> +		raw_spin_rq_lock_irqsave(cpu_rq(i), flags);
> +		BUG_ON(tg->rt_rq[i]->rt_nr_running);

Crashing is probably a bit harsh. What didn't happen that should have
happened if there are still tasks in the group at this point? Can we
maybe WARN and try to recover w/o crashing?

> +		hrtimer_cancel(&tg->dl_se[i]->dl_timer);
> +		raw_spin_rq_unlock_irqrestore(cpu_rq(i), flags);
> +		kfree(tg->dl_se[i]);
> +
> +		/* Free the local per-cpu runqueue */
> +		served_rq = container_of(tg->rt_rq[i], struct rq, rt);
> +		kfree(served_rq);
> +	}
> +
> +	kfree(tg->rt_rq);
> +	kfree(tg->dl_se);

...

>  int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
>  {
> +	struct rq *s_rq;
> +	struct sched_dl_entity *dl_se;
> +	int i;
> +
>  	if (!rt_group_sched_enabled())
>  		return 1;
>  
> +	tg->rt_rq = kcalloc(nr_cpu_ids, sizeof(struct rt_rq *), GFP_KERNEL);
> +	if (!tg->rt_rq)
> +		return 0;
> +
> +	tg->dl_se = kcalloc(nr_cpu_ids, sizeof(dl_se), GFP_KERNEL);

Nit. Maybe sizeof(struct sched_dl_entity *) is more clear and consistent
with the above (current form is still correct, of course).

> +	if (!tg->dl_se) {
> +		kfree(tg->rt_rq);
> +		tg->rt_rq = NULL;
> +		return 0;
> +	}
> +
> +	init_dl_bandwidth(&tg->dl_bandwidth, 0, 0);
> +
> +	for_each_possible_cpu(i) {
> +		s_rq = kzalloc_node(sizeof(struct rq),
> +				     GFP_KERNEL, cpu_to_node(i));
> +		if (!s_rq)
> +			return 0;
> +
> +		dl_se = kzalloc_node(sizeof(struct sched_dl_entity),
> +				     GFP_KERNEL, cpu_to_node(i));
> +		if (!dl_se) {
> +			kfree(s_rq);
> +			return 0;
> +		}

Are we not leaking if allocation failure happens mid way during this for
loop? Do we free data structures allocated for previous CPUs?

> +
> +		init_rt_rq(&s_rq->rt);
> +		init_dl_entity(dl_se);
> +		dl_se->dl_runtime = tg->dl_bandwidth.dl_runtime;
> +		dl_se->dl_period = tg->dl_bandwidth.dl_period;
> +		dl_se->dl_deadline = dl_se->dl_period;
> +		dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
> +		dl_se->dl_density = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
> +		dl_se->dl_server = 1;
> +
> +		dl_server_init(dl_se, &cpu_rq(i)->dl, s_rq, rt_server_has_tasks, rt_server_pick);
> +
> +		init_tg_rt_entry(tg, s_rq, dl_se, i, parent->dl_se[i]);
> +	}
> +
>  	return 1;
>  }

Thanks,
Juri


