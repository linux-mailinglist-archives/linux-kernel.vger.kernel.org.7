Return-Path: <linux-kernel+bounces-750243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C563B15904
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9475D18A127C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932D91F2BAE;
	Wed, 30 Jul 2025 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwwhYGYT"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBB199BC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753857576; cv=none; b=ZqVhT7oZDOFiRmiFKfhKjSfqXppncUC67QYxb2Dh6Ztgd2eqo71A7zkP3gEPtZJ21/StC8JesXbJesSUDf+T7ROydW11JWjtqP61eIGK98tLbkUr60mrQ9xDpb0vqmTxfwOxsOSlUI0FC9XUAGsLAgjr2jtfmeJ6HBjwrUZ1afs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753857576; c=relaxed/simple;
	bh=s3oAeiGMCGpEUY4W0CLVktyAxCLyAnDPTL2QrMiUGXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4+D5F7xtPBR3Z/1YAFo/lqlwIlZjWocVd/Ent8+++hxsJ45cxcdyXhxDNfSzNDvdp7N0b1dGaf9jdBTMf+r/rfHmG3CzyH4nnApSH8qu+ia1E0nFVKAE4LAZWiHpSwOAAYyXv0lqjjW0CCgGHQZe0jVYNypQO5EM9rl4Ke98Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwwhYGYT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76b77a97a04so63745b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753857573; x=1754462373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxqq0Cq3rXpDHMk3wnpPiQiHk/GfScecX6DtSmTnXPU=;
        b=iwwhYGYTGq5VvhZtiC+JbMX1lbXf59xzWjh0EoFZk+Tvz2uL1yJbMvOcFdTR7CCUC+
         hr4NMrfkkLDWhUT67Y2NsLOBy5SDzbXKrDpikowQRXK8PqSDMewwh5AFmPS6B2dQKMXJ
         DMoknMHiQrsNEwTVzhTsC4p6J4lKkBVmL6fPiS3Mu7/3guINLCil2JipvX+jwcAVUcJI
         xJ4BhIyINiCcbod86yCDTxS5MnUDghMknOmXgr1dz2LX2fapVIbKIs+FvI8BrASZToNZ
         j9TRpsCfSoLHKFv+IEF876U/QxYpr2b/VMuviNIltHhJAV/dAuiCqvIpl+cFIuRLMAsw
         nm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753857573; x=1754462373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxqq0Cq3rXpDHMk3wnpPiQiHk/GfScecX6DtSmTnXPU=;
        b=fs0s1IxrsOIilLiSOrlaQEht4pL+OmYVBe91U7lNK/P6e7JfzZJitWentVLzEolBTc
         cZdvn515Tgw4Punus5XG+JKIwxgFU85j6oq4uU6LHZcVhE6F+C1HrKP3+G7OAUKX01zQ
         XkNFE/JVvo3RvqeME4Nrx34GOJJEFeTkgrsBY7jj8c6US6KYyTf+9GZi0Fostd45oFSI
         h/0UXJqtFDLtxjUgbVAsqF2rXqMJBx74XVqGYvy7zAKMwXBEU0GKP+ill9tVwCMaqIxD
         TpLgte9tjZ3gOgBVpdvlvYCp6GzemJmyuqZYEBOOxzBXpi6shnidr79C3fAEblgVp/bP
         HfIg==
X-Forwarded-Encrypted: i=1; AJvYcCVZERLOvg2AP41Hkln0pLO1K2aJjGvhxQHaow0Zr/9+svJkKdutb5YY6/afwhqDNL9enZ0fPX4O57CpBOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypalU5kUiuDLVHM+kVNrOIIj+Kl5dAsKQWV8Ks8NaOgPRIPKrr
	T1Vu/9Y4LtLXEr8Ir3mcqDQkW288lZxblnDhwn4X1sWuaA0i3u94LrqkhSoaJIkj8Uc=
X-Gm-Gg: ASbGncv1IgkL2frOwnVIAXiW5IuKLmCFhNOvhW1VtEbzIHBtaVLG/Jns5HtC6tBX6wg
	gWz8LO2o2XZ2MS4uJ+DgzVSLgbgf8Lxc9CpRYR2JWDsnb+lp7v9qqGD2Vhin0feGvuc8ZZ1/3FI
	t9zx0hvQ5Ji/4IsMho/9FXY05y/icj+FubF9r9cQGHhqfeRb1qm4MXMOTNayDpxCLOeugUcwEgL
	ErRtmAwfndcRydyOJd92rneirDvM5Kd7pCAX1g1w+IVYQjZ632MHTU0UJysm7G0RuuKaMmC3FcS
	1xaZIQ173Nl4LUuRraXhbl1ojqb3ggyobKTAkxU0d4FzkzLhddxBWcEPhkaIEFTay+VSIDn7EuB
	OduW7RBpLdYxFsKfcW1lu2ag=
X-Google-Smtp-Source: AGHT+IHxxY7HQAsnbPM3mEwljLdyelb9+TlSrMF7nkdPAIT593PMDdIyHE4C4wABCZ568IM+pGtllg==
X-Received: by 2002:a05:6a00:4b02:b0:748:2d1d:f7b3 with SMTP id d2e1a72fcca58-76ab30d04c2mr2941003b3a.22.1753857573262;
        Tue, 29 Jul 2025 23:39:33 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76a794e7eebsm1921693b3a.123.2025.07.29.23.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:39:32 -0700 (PDT)
Date: Wed, 30 Jul 2025 12:09:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bowen Yu <yubowen8@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, zhenglifeng1@huawei.com,
	Prashant Malani <pmalani@google.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
Message-ID: <20250730063930.cercfcpjwnfbnskj@vireshk-i7>
References: <20250730032312.167062-1-yubowen8@huawei.com>
 <20250730032312.167062-3-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730032312.167062-3-yubowen8@huawei.com>

+ Prashant/Beata/Ionela

On 30-07-25, 11:23, Bowen Yu wrote:
> From: Jie Zhan <zhanjie9@hisilicon.com>
> 
> Perf counters could be 0 if the cpu is in a low-power idle state. Just try
> it again next time and update the frequency scale when the cpu is active
> and perf counters successfully return.
> 
> Also, remove the FIE source on an actual failure.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 904006027df2..e95844d3d366 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -78,12 +78,23 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>  	struct cppc_cpudata *cpu_data;
>  	unsigned long local_freq_scale;
>  	u64 perf;
> +	int ret;
>  
>  	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
>  	cpu_data = cppc_fi->cpu_data;
>  
> -	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
> +	ret = cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs);
> +	/*
> +	 * Perf counters could be 0 if the cpu is in a low-power idle state.
> +	 * Just try it again next time.
> +	 */
> +	if (ret == -EFAULT)
> +		return;
> +
> +	if (ret) {
>  		pr_warn("%s: failed to read perf counters\n", __func__);
> +		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC,
> +						 cpu_data->shared_cpu_map);
>  		return;
>  	}
>  
> -- 
> 2.33.0

-- 
viresh

