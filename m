Return-Path: <linux-kernel+bounces-753008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A0B17DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B68B1C208FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C081E835B;
	Fri,  1 Aug 2025 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFE0cfzl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB972624
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033830; cv=none; b=FvXsHPsDyPrv9/rDv4NulzI+0MJtN4EaO4PaYU6FpDau5OtkDO+xClHEf5gemU+blpkh1cX7Y3d6mqpZh+VmzHOzX4vbF6Njkn2XDCPpmtIX+dH/YLJyQN2RlCBo1JG9g/DPMc/qUnW0+yF9O9gTveHUcEn/xg3fqc93sp0WcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033830; c=relaxed/simple;
	bh=9PksvV60rPpkHXM49AYBINimvOYKjRD+kBMp7Fglaec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayNfQO+6ZGAt0zPIQH+tRTaSHIujwHkdT2nZi8PggFdbET3pXe+/5FYtitYW48e2O+/2uSkEqJc/DgoIRQxxXtr/UOK+ZJFMOt8UCv0hwwVpmNIAXv4KmDGlsGb7GwH8X0fO4HNIejb9zBCMdp2aD2GxnPhrUombDX1JsMcqG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFE0cfzl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754033827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQRmO76ymO9d1FjhA+KyC8CA+pyqdQrBvGUMGWyi74o=;
	b=hFE0cfzlvsv6v/437Jr24QodNclWaNllmon6G8VrPgz3LOkokmw9KK2qn52UCejhtkg5Oh
	tuw2ELAdwnLZ0xXRicC6x19N/MnsAuSP9cvxScdMIULVip1ATHkqJmATE4J5CnA7zI5I2f
	jCwOWukUz1LeLa/m5Zsbm8SW1+4WNkw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-OmTeBxUjNf6w9u0NreQZJw-1; Fri, 01 Aug 2025 03:37:06 -0400
X-MC-Unique: OmTeBxUjNf6w9u0NreQZJw-1
X-Mimecast-MFC-AGG-ID: OmTeBxUjNf6w9u0NreQZJw_1754033825
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4586cc8f9f2so2717105e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 00:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754033825; x=1754638625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQRmO76ymO9d1FjhA+KyC8CA+pyqdQrBvGUMGWyi74o=;
        b=XuoZ6HY5cVvGyRbopsMsbi8cfNLRZ3gc57ArwAm1Piny9/kRnkf8x0YEo7fGDcxZcJ
         VpFFVzLBizpsXI+nNZwSlNV/xtZWUrd1crin1819O0ShLBuAZrAs8PXrWLKz2KQWFje+
         1No7HfQdrlo8xblnsvzLNRJgcAl74agS7tlZsBQbzPKJ9wvvk0R+xdzZTX4mdxjjA2Oq
         aUU2rCrdeyGKQQhTik8p2T32BBis9r0ieSaKnNCeezG7jSzP0wrKymw+UCVigwDqsQOq
         f8E17b+6bp9qLR9clVtrYehgdUA1y6T2CuOT1g/U94ivt7qZ+uCvWrrrRdXZmgEGh+zI
         Ke4w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6kGbOP4vJdE4wBOEvMrCyelm7woE9zYZbQTjpDTkZM+lQtEwq3WH4aq6WnVpitup2jx6dT1N2yqOdVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymwfFEgVthtQL0Ch2FDUVYJcpMFnlrq/RWgmbvRdRg1xomnzIu
	Ovm+pdBVJYtJx2Trb1DzsqOYZg0XrfzS+/L/Khl8qnUDregrzOIzuf6eaXPTDRpaNB3XsX3jMEe
	yUigB6ztmK2F80xZWV/r7c/1l1qD8+F4oWUQljBoVpn0vLCF0uAhOGlEAvlizt7FDzA==
X-Gm-Gg: ASbGncuXsykMK4EE8i7nHMUBR/HHxpDyQzwHa7K5D3TJWcT5x1fTbFSw/8dPrlEhoyY
	uabxY5U/mJzN5ZMRwVWVYw4BwPmg76joLUGxmNCkhb7l//nZkKVXfwyhFTQKRJ91/40huanNYVy
	+zo2QkSOxkjfZgdkZZtMfoMs14sdE3iGXk1Kkq/MGrmE8+uxYGHe3/39l336Hy8m6cUCgGqnFRH
	tC3BVIvVE7qo0W+JpLSs3FBqGU0kwexR8hWxw+ehbCsaYuMajlcj4PFSLqRSXJLR/fItJaVtyDN
	7Ukwhx/hMZKUvL20X9ldtrqY26uCeV6TARLQxCdpOIRuJzbjFkqDx1LrmoPaVNP2gKzw5w==
X-Received: by 2002:a05:600c:c177:b0:456:c3c:d285 with SMTP id 5b1f17b1804b1-45892b94d53mr86278875e9.1.1754033825012;
        Fri, 01 Aug 2025 00:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF24FUQ/Q3kShbLBfjxre55PIDzRBaRc02gcnWhZSCIw8TXypuo4hlDxwc11bKhk3tdzHkPJw==
X-Received: by 2002:a05:600c:c177:b0:456:c3c:d285 with SMTP id 5b1f17b1804b1-45892b94d53mr86278575e9.1.1754033824517;
        Fri, 01 Aug 2025 00:37:04 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.46.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfe56sm97779725e9.20.2025.08.01.00.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:37:03 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:37:01 +0200
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
Subject: Re: [PATCH v2] sched/deadline: Remove fair-servers from real-time
 task's bandwidth accounting
Message-ID: <aIxunUAqdecVuUMs@jlelli-thinkpadt14gen4.remote.csb>
References: <20250725164412.35912-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725164412.35912-1-yurand2000@gmail.com>

Hi Yuri,

On 25/07/25 18:44, Yuri Andriaccio wrote:
> Fair-servers are currently used in place of the old RT_THROTTLING mechanism to
> prevent the starvation of SCHED_OTHER (and other lower priority) tasks when
> real-time FIFO/RR processes are trying to fully utilize the CPU. To allow the
> RT_THROTTLING mechanism, the maximum allocatable bandwidth for real-time tasks
> has been limited to 95% of the CPU-time.
> 
> The RT_THROTTLING mechanism is now removed in favor of fair-servers, which are
> currently set to use, as expected, 5% of the CPU-time. Still, they share the
> same bandwidth that allows to run real-time tasks, and which is still set to 95%
> of the total CPU-time. This means that by removing the RT_THROTTLING mechanism,
> the bandwidth remaning for real-time SCHED_DEADLINE tasks and other dl-servers
> (FIFO/RR are not affected) is only 90%.
> 
> This patch reclaims the 5% lost CPU-time, which is definitely reserved for
> SCHED_OTHER tasks, but should not be accounted togheter with the other real-time
> tasks. More generally, the fair-servers' bandwidth must not be accounted with
> other real-time tasks.
> 
> Updates:
> - Make the fair-servers' bandwidth not be accounted into the total allocated
>   bandwidth for real-time tasks.
> - Remove the admission control test when allocating a fair-server.
> - Do not account for fair-servers in the GRUB's bandwidth reclaiming mechanism.
> - Limit the max bandwidth to (BW_UNIT - max_rt_bw) when changing the parameters
>   of a fair-server, preventing overcommitment.
> - Add dl_bw_fair, which computes the total allocated bandwidth of the
>   fair-servers in the given root-domain.
> - Update admission tests (in sched_dl_global_validate) when changing the
>   maximum allocatable bandwidth for real-time tasks, preventing overcommitment.
> 
> Since the fair-server's bandwidth can be changed through debugfs, it has not
> been enforced that a fair-server's bw must be always equal to (BW_UNIT -
> max_rt_bw), rather it must be less or equal to this value. This allows retaining
> the fair-servers' settings changed through the debugfs when chaning the
> max_rt_bw.
> 
> This also means that in order to increase the maximum bandwidth for real-time
> tasks, the bw of fair-servers must be first decreased through debugfs otherwise
> admission tests will fail, and viceversa, to increase the bw of fair-servers,
> the bw of real-time tasks must be reduced beforehand.
> 
> This v2 version addresses the compilation error on i386 reported at:
> https://lore.kernel.org/oe-kbuild-all/202507220727.BmA1Osdg-lkp@intel.com/
> 
> v1: https://lore.kernel.org/all/20250721111131.309388-1-yurand2000@gmail.com/
> 
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---

Thanks for this. I have been testing it and it looks good. Just a couple
of comments below.

...

> @@ -1688,17 +1690,14 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  
>  	cpus = dl_bw_cpus(cpu);
>  	cap = dl_bw_capacity(cpu);
> +	max_bw = div64_ul(cap_scale(BW_UNIT - dl_b->bw, cap), (unsigned long)cpus);

fc975cfb3639 ("sched/deadline: Fix dl_server runtime calculation
formula") essentially removed cap/freq scaling for dl-servers. Should we
rather not scale max_bw here as well?

> -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> +	if (new_bw > max_bw)
>  		return -EBUSY;
>  
>  	if (init) {
>  		__add_rq_bw(new_bw, &rq->dl);
> -		__dl_add(dl_b, new_bw, cpus);
>  	} else {
> -		__dl_sub(dl_b, dl_se->dl_bw, cpus);
> -		__dl_add(dl_b, new_bw, cpus);
> -
>  		dl_rq_change_utilization(rq, dl_se, new_bw);
>  	}

...

> @@ -3149,10 +3138,13 @@ int sched_dl_global_validate(void)
>  			goto next;
>  
>  		dl_b = dl_bw_of(cpu);
> -		cpus = dl_bw_cpus(cpu);
> +		cap = dl_bw_capacity(cpu);
> +		fair_bw = dl_bw_fair(cpu);
>  
>  		raw_spin_lock_irqsave(&dl_b->lock, flags);
> -		if (new_bw * cpus < dl_b->total_bw)
> +		if (cap_scale(new_bw, cap) < dl_b->total_bw)
> +			ret = -EBUSY;

It's kind of a minor one, but can't we return early at this point already?

> +		if (cap_scale(new_bw, cap) + fair_bw > cap_scale(BW_UNIT, cap))
>  			ret = -EBUSY;
>  		raw_spin_unlock_irqrestore(&dl_b->lock, flags);

Thanks!
Juri


