Return-Path: <linux-kernel+bounces-798875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8604FB42420
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC09D16F03F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF707309DA4;
	Wed,  3 Sep 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P89TTnK2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91123128D5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911248; cv=none; b=EwLp8Zf90TjudhkHJPfQsZK7VKY4QWuin+rJs44NYPvmfiMcr4UhLcPivG9iX4GaODVJtQ3d0UqeEn37FkpDfn3gaguo3lz87yQFkUka7504kuDhfxGHyTUwPk/SBySz+nxNaDMUqo5ZAY3S+Gan1iM6afcioeZJHbLfXCkSV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911248; c=relaxed/simple;
	bh=D09xO5RtMUNz+lUT9eFiY2W62ZdVcE+VZvtzoAaVQOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8NbZidxuTrCpFQzxJgNf59au8KLFkoMXk8/8A70DvA2vSm6FSdsuPIOWtWODbPO2dr0yP+mAnXudw0/AZmyVduC1hsJVGvhxCyDoYj6OhxVY3SiPJs8VKSXD/TV9l/fsHBcam19rbGrRX/nVwP/i052e8ywD9ohdPZItKkYqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P89TTnK2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756911245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2MyENo2QT2Z2l7/9urVI2q4UwayK4sw/QbcWj6VjSw=;
	b=P89TTnK2NxRhcy9A8bNpypnAoD9Sbm5LXOHW/eM7BpQn/zjGIbJTa6Jdt4LtKemAUbgPI6
	i4dnTXdNHE5jXolxV2nACXiYni5Wd1UZM4x0Y6viMxqCG41NkxhF7HtqBkfzDy+0+vEfB5
	axs+k040PWE1DFZ602aYFlLtqpJA5aY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-BDuzI3UeNPuapzLgEG4dmw-1; Wed, 03 Sep 2025 10:54:04 -0400
X-MC-Unique: BDuzI3UeNPuapzLgEG4dmw-1
X-Mimecast-MFC-AGG-ID: BDuzI3UeNPuapzLgEG4dmw_1756911243
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ce059e3b83so5221f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756911243; x=1757516043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2MyENo2QT2Z2l7/9urVI2q4UwayK4sw/QbcWj6VjSw=;
        b=hmWgLjV0p1bMiBzqim5VarLus/6OhJHfrNMY8AfikfPucZTSyutSIHE7XwL7eE35Yp
         BsfyZ884xyfYvaKFGbgJoFjCC+HGto9K4zLKqRxH5w1LNGfkwA1hyL1JNgrFuSTTxsT/
         K1T7elmIeDw/vYBYE+fxeJYAB23q68wqkYJARVb5vCgU+K4Are9GLQE7NzQ3ZoiJSGxD
         dy5cHBI+0qERtpqgASqw/QYAfpLjDmnzpNFv55Bw8XYN8yPHkR7JDrvZC7/ZymsuIHd+
         TsZZZkU2FfPRqYsgJWgz9oiuEQHKv574zB0pRUCPuE0gPSj7sjMo9N5DJ8S/r3bksBtn
         ty7A==
X-Forwarded-Encrypted: i=1; AJvYcCUCk6x5E4rIujDSNPJAo7T2o/79UlJKDFW6IWRA2Ov7AXHGi2v2qI5ParHXjPlVO163Ng6lfQC/+HJrb8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5zJwCP/5SzyXe10j1I5nvOWwgfv672uzmrDla8KOg15HbzhKN
	Zk5MSzNSgRbSxV/rEOmxug6A1SN8q3wpoo4fCs3cD62WRn1WUEuWMBhXIq23IKHuG7JB1nMs36N
	8FYQ690X0FQmy8cpES483BLQnwIJHy7uMSxSGpdPGQ5fAxKVJ6tSYaiPAnGoCF+vnAw==
X-Gm-Gg: ASbGncvJl5CfIsGACgzY1flBwamtC3ojCDSTPoPdvNGvH6ILB6oYMc26lMIGfbCAJRz
	iroKIM6iAT+8UzkpLWf0Dmxw0CKMnYTpDKTibrS5YneTll6hBVlG1ZkVtRoKqrwqcmdHNuu2pQG
	rItZHt9SHNeZd87Aa4gUyizsjKFJ1TbsF2TPG//ebyGGPTvF8F9Oah/d5FE0YvKi/I05m/uNLaD
	JjzQOxbXHhO7ctQcxR3H6b6MCC0eYokceQlU4ZFSsqiWZvFlugarFigatNtgyesBM1DPYpiJFUK
	NpX13eSkct6zw2vd/5dhtAODmvPPkKqb6namlOS/WcSjCslxWpyaWS6p6oJ5ivtA3hpXd0s=
X-Received: by 2002:a05:6000:22c7:b0:3c9:f4a3:f146 with SMTP id ffacd0b85a97d-3d1e0a998f2mr10955990f8f.62.1756911243306;
        Wed, 03 Sep 2025 07:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD8shCJ79KhLYK9+uhC+SBWdMCfYQ++ofyEC0akwGhyiSFjwx2jya62N77J1MtC4Rs0XVkqg==
X-Received: by 2002:a05:6000:22c7:b0:3c9:f4a3:f146 with SMTP id ffacd0b85a97d-3d1e0a998f2mr10955970f8f.62.1756911242865;
        Wed, 03 Sep 2025 07:54:02 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dcc19a386dsm3544726f8f.4.2025.09.03.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:54:02 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:53:59 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903095008.162049-6-arighi@nvidia.com>

Hi,

On 03/09/25 11:33, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Hotplugged CPUs coming online do an enqueue but are not a part of any
> root domain containing cpu_active() CPUs. So in this case, don't mess
> with accounting and we can retry later. Without this patch, we see
> crashes with sched_ext selftest's hotplug test due to divide by zero.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/deadline.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3c478a1b2890d..753e50b1e86fc 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  	cpus = dl_bw_cpus(cpu);
>  	cap = dl_bw_capacity(cpu);
>  
> -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> +	/*
> +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> +	 * with accounting and we can retry later.
> +	 */
> +	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
>  		return -EBUSY;
>  
>  	if (init) {

Yuri is proposing to ignore dl-servers bandwidth contribution from
admission control (as they essentially operate on the remaining
bandwidth portion not available to RT/DEADLINE tasks):

https://lore.kernel.org/lkml/20250903114448.664452-1-yurand2000@gmail.com/

His patch should make this patch not required. Would you be able and
willing to test this assumption?

I don't believe Peter already expressed his opinion on what Yuri is
proposing, so this might be moot. But if we go that way all dl-servers
should share that non-RT portion of bandwidth I would guess. And we will
need to probably add checks and subdivide among active dl-servers, don't
we? Peter, others, what do you think?

Thanks,
Juri


