Return-Path: <linux-kernel+bounces-845087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD0BC3780
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8801F3A6983
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5B2E1758;
	Wed,  8 Oct 2025 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gdh+lwDA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2E42A96
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904729; cv=none; b=XKCiy0SH80yh1yBSay3VKsxsNXiCBTtgPTa+Qqr/OuLVASeawN+QApebuDXwAigjE779JE0zsF4ecWoJfyxflHf+23/mJCJPE3oe5XeyHkUMpRAv4m40veQRWfiWbuGDXnA9B3V4XOXt5ishJaJSAGqPs6Da8slrTy7siH4H2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904729; c=relaxed/simple;
	bh=/cDKBWDc9qVqMl0cEmQwZvS+PtA2apOT9bgGwcS2fAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xww8iRwaN+1LPlwLq2nE+gKbZ8lIYKefUaZozhGfDxkDib72eKHpk0x6TDM8USDZScNt5pI33lwXcKY7GX53GZPRTpDTzzo+lQLGZ21kjAs+fyOww+yX3hmIcBZDap4Td+dXQAtLWeeOIs7wcL1NeEAR+XCjaHqrEl2LgKsA6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gdh+lwDA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759904725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2qMQkWWx4UG6wuBDlhBpltiecDgL/sK7ao3XsMEYnA=;
	b=Gdh+lwDAEhDvSlToiIFWezvpYGMjCZpbUFidqZgiz4a7Hd7b4ndsliZd9dNFyO0bix+XzB
	pu0WPMcdJGtqCXac/csAQPxvrXDZ+7JOH5LvLPYS1wQUYrDQSz2dpTDnpQaSN9gkIIbKZL
	Phx46+QqmGz/5xH0/PDIIE6MhRVNjBs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-6K0UzDJWN46l-K2ETiLX_w-1; Wed, 08 Oct 2025 02:25:24 -0400
X-MC-Unique: 6K0UzDJWN46l-K2ETiLX_w-1
X-Mimecast-MFC-AGG-ID: 6K0UzDJWN46l-K2ETiLX_w_1759904723
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ed9557f976so4702499f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 23:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759904723; x=1760509523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2qMQkWWx4UG6wuBDlhBpltiecDgL/sK7ao3XsMEYnA=;
        b=sW0+eiFeLYF3tHM6Vh7GUpdRE0XgiHTdnnaqPE2XxrsOD5NlJKw/1I8WSxx+P4npL1
         V6tOIUrWsPPNJaKmYzAEld6nuGA3zeP34HN5VuPHzRxNIYu+AXD9eXII7tTe7ZLYzZiW
         jbxcSUX8NhH67z/p6bOIbkARCpEupxw/+qpI9bD1MO0L9wOSRO+NnQBt1VZCDquv2P8L
         qFdqe1kVu6UpOKZopeUFIC+fP29N9FjQ5qYlnbuRBfp1LO6Myz9V8PddCkQE/E5C2SQb
         r0O9gibiSoSnjsBrPk1GVz5e1vOYIr9RFvbT3AdWJLe8issyi+d8Y7Cg66iQSs2rSHjs
         SpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtur9XV0ikoaHJpwFB3YwPtRd/JHux0G7RzMVHt9+2hadBjd0OQt/6HFPM1DzLYgC1LWt49UtDpC4H6b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzktnyLM/lHW8PlhAv7hRo5utEC0plIVBqibZpJzmCNC42pAidn
	HtRvM8+LQBH4gHrRj1+4Xu9UL+A0wpWaq/XzbVHsngpglFfX33Roaa2XV6jaTxQ0ZqjuVHk3Edy
	fPrLYK0T8ModEiiJwCRvG6uFDg14YEj6J1oKSV7LvCrO+EMzweomQrtrZ4lLLrc483w==
X-Gm-Gg: ASbGncuAUgAo7xoMsPwoV2mCTR/D2EZRLxK2kEN9iON7rMAzSIszz0UOfgFP1+1uXzS
	KUFTXfLwqn+M1iRYkR93MGxyWEzxKZQxjjrqiCX26bt9NzOQF0XrK5Hz+twqsZShtv3UTnECq3o
	88KaZe8BTTqsiglirnALSj0ysu0lPrRC4FRARS1XwHWhlIt0ObIrU0LNZjVCPCDNkVxXX2kvT18
	C2qHzNNf30d5og1AOJrgs5AnT08xbSRCWezbM0aGaXYedGL/qMWgiu1BhONVjUw5YvgUA6VkCnM
	6c0zD71DWBFMzY2kRLv3gUHVEDCSxhBixe/gVxqoqmDEgl1FPcQhGvl2Yxjql5POFkZ4c1LB4Lx
	oaQ==
X-Received: by 2002:a5d:5f48:0:b0:415:7c56:30d9 with SMTP id ffacd0b85a97d-4266726d554mr1053780f8f.23.1759904722941;
        Tue, 07 Oct 2025 23:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN3e0/yPR4SkuDoB4llnYq58aXn7c7t64gfq3N2JmDm/ULHR4b130hpyJ+ol5xHCzXqFDkBg==
X-Received: by 2002:a5d:5f48:0:b0:415:7c56:30d9 with SMTP id ffacd0b85a97d-4266726d554mr1053764f8f.23.1759904722566;
        Tue, 07 Oct 2025 23:25:22 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6e1bsm28671681f8f.8.2025.10.07.23.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 23:25:21 -0700 (PDT)
Date: Wed, 8 Oct 2025 08:25:19 +0200
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
Subject: Re: [RFC PATCH v3 08/24] sched/deadline: Add dl_init_tg
Message-ID: <aOYDzzC83FZdNNGi@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-9-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-9-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Add dl_init_tg to initialize and/or update a rt-cgroup dl_server and to
> also account the allocated bandwidth.
> 
> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/deadline.c | 33 +++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h    |  1 +
>  2 files changed, 34 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5c8fe80b585..34a1494d782 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -340,6 +340,39 @@ void cancel_inactive_timer(struct sched_dl_entity *dl_se)
>  	cancel_dl_timer(dl_se, &dl_se->inactive_timer);
>  }
>  
> +#ifdef CONFIG_RT_GROUP_SCHED
> +void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)

This is not called from anywhere at this point, is it? I wonder if we
want to introduce dead code for later usage or if it would make more
sense to introduce it together with the calling sites.

> +{
> +	struct rq *rq = container_of(dl_se->dl_rq, struct rq, dl);
> +	int is_active;
> +	u64 new_bw;
> +
> +	raw_spin_rq_lock_irq(rq);
> +	is_active = dl_se->my_q->rt.rt_nr_running > 0;
> +
> +	update_rq_clock(rq);
> +	dl_server_stop(dl_se);
> +
> +	new_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);

Is this correct? Not sure yet where/how dl_init_tg() is called, but
don't we want to compute new_bw using rt_runtime and rt_period?

Thanks,
Juri


