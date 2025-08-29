Return-Path: <linux-kernel+bounces-791159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F56B3B29C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF57A6C95
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65301217F3D;
	Fri, 29 Aug 2025 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hj6cmJL0"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1141E1401B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445956; cv=none; b=NIuhPfjzBcuVyo+qokVwr+TUkB5JyIN0z4gSJcP3L1506SBku5fxv6U6H9vmjznR2eykdHMm9cvRAzFUWWz98Q/vfPCK2DUX+on3pJA8POdygHuYR3olymyFIguw7AVNEf84pwXL6QbZhRfgKGNQqO95JO+DDS9Fp0vuyUmT7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445956; c=relaxed/simple;
	bh=dBEimnyqFErvRDaw6n29Zwqdf1lNF2xCJ+zGmMqLgvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1JlQEXCn9Qmso5sxl3dUi4xx8LJSCpLWxlJTDQsrVyXduHvQeeGXskMcsQKC9zueu8Ie5lkki46XIoORdg9R6C9vOlStG0NiJ0zGdPyrbwn0Pmn0ynXO7W99/DAdOX6BSq6m6tHlZRKMWlbpcEZ4mTeoZhrV7un1Y9mAUJJZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hj6cmJL0; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-327d47a0e3eso715914a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756445954; x=1757050754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XBNZun+DsWEuFjpuYogmLUWGnvKNXpUg6KanJ2bj/Q=;
        b=Hj6cmJL0o65D4jSVKTCop8q9jjPVpuVMtdw9hYW8Ph5XWjRS//PNmeIxoWBdVW9Jv4
         /Xb90mE4UKkDq3wSRaOvmi6YFd+8TPr5ks0O6/dBgqy52Xiz3bvpd9YbQnk7A4DtWiuz
         iRrOUqgrU/hJzyE1VEIlVkTpLSnq/5ht0lO5JyO0Ctl8qnOPW9Je91zW2B6cpHBg6js1
         VTuWfuDyYyFbajMvq6I/CudkidUcWBPnT0P4BNyMlqRspbHcENEUGoC8dytemgSVUngW
         7QSQSDT2j06bfgrZmbFpoz9xl40HypYhMemk9wewECi5RPf/PxUdTh3Ufd+KmV2JwRLi
         XPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756445954; x=1757050754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XBNZun+DsWEuFjpuYogmLUWGnvKNXpUg6KanJ2bj/Q=;
        b=igNUQGGPL/wHljBTYpcuFxolFv89Ktw54Ruulim8Uyz5w6teKIVZBcD9mPTT4AaiSF
         YUDHTLfKkfECOECVr1ZU2zYHIUfHniNOk/3rvDF6g5RUPzu4fIcTb1hEeMunQ224i4t3
         66vgQlNpQe+iBfCOPt5YPBXdUxyUjVKSQg8Bme9QVh1GR/cqgg4898TtYZhr3XzccsX6
         Tw0gmyULkVnuRCuj55aPNRiL2KQfUdUNghe9deGCU4GQMX9iRbXrfD85XVpY44/9nFjr
         Rc7qFfYkVwZvrYEr6eyBTSn/AqoEINr7UqN/Wg0StwERbdlpysS+nCWD1+sIwee5kf1t
         LdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGc4sWTvUCBpIcH8D8+3aOFynZOrf1bloUarp/SuRLclzJtD2r0WhtbjqkCD+WePWSQ746RqzVmY1/x0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLH2nmKy4S8dnKOuZaQGxx1WoAr1P9/hIQWdUILMQR7JzMdtqd
	bA21Vnj8uHr23BJ5y55Viw2whlgKABBmfZ+xAJbaEjNep1LMUXLaHN2TT75c/GIeFIqOWZ9wexg
	eDcch
X-Gm-Gg: ASbGncvnBCbJj61ylvIsPYImPK3UV2k/xLTojBbepUBXSFyeMt9HD6wv7UkJaRMTGTv
	tTjolKLIYezSGwpKSEqIlowfDvVRKg/XJCZtmfFfBtNorIvW2de0v2XvngDI8PIW7CieEV9CedJ
	VyNI14RW8GfVd0WIE0D5wvOVpBInDgdDwZ/BSfmy8LP3oRYkHg9WzTKCrJLrdZV6LugpMeYOeoW
	maomBZcqNN5eWfoBILwrC412sw23VqMYiEC+T1EsVf3pDimJWvVRJ3F+pqcbkJDfdkcjbC7lemo
	ZdIOBZwJhRaNDA7c9HrVfW+nQFT6ysUEmuwyghw52N0BavI0TRTk5N/VFp8NC8DfHC5bV4vntNL
	1i4l9+qjio48pgdKE7n66fZ0dC89XV7ehBP8=
X-Google-Smtp-Source: AGHT+IF2FBDuAslWQRB95r2d29vZcZOpSZcreczLMQg0tt9Qhwo66M6nj6sHGldIm2UhdvS/fRstfQ==
X-Received: by 2002:a17:90b:2e8c:b0:327:e34e:eb15 with SMTP id 98e67ed59e1d1-327e34eed3cmr2048590a91.2.1756445954282;
        Thu, 28 Aug 2025 22:39:14 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d8f66f16sm1493229a91.0.2025.08.28.22.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 22:39:13 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:09:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <luceoscutum@gmail.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 2/2] cpufreq: tegra186: Initialize all cores to max
 frequencies
Message-ID: <20250829053911.pzrkfvzes3bsrvtm@vireshk-i7>
References: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
 <20250828-tegra186-cpufreq-fixes-v3-2-23a7341db254@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-tegra186-cpufreq-fixes-v3-2-23a7341db254@gmail.com>

On 28-08-25, 21:48, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> During initialization, the EDVD_COREx_VOLT_FREQ registers for some cores
> are still at reset values and not reflecting the actual frequency. This
> causes get calls to fail. Set all cores to their respective max
> frequency during probe to initialize the registers to working values.
> 
> Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> index 6c394b429b6182faffabf222e5af501393dbbba9..bd94beebc4cc2fe6870e13ca55343cedb9729e99 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -138,13 +138,14 @@ static struct cpufreq_driver tegra186_cpufreq_driver = {
>  
>  static struct cpufreq_frequency_table *init_vhint_table(
>  	struct platform_device *pdev, struct tegra_bpmp *bpmp,
> -	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id)
> +	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id,
> +	int *num_rates)
>  {
>  	struct cpufreq_frequency_table *table;
>  	struct mrq_cpu_vhint_request req;
>  	struct tegra_bpmp_message msg;
>  	struct cpu_vhint_data *data;
> -	int err, i, j, num_rates = 0;
> +	int err, i, j;
>  	dma_addr_t phys;
>  	void *virt;
>  
> @@ -174,6 +175,7 @@ static struct cpufreq_frequency_table *init_vhint_table(
>  		goto free;
>  	}
>  
> +	*num_rates = 0;
>  	for (i = data->vfloor; i <= data->vceil; i++) {
>  		u16 ndiv = data->ndiv[i];
>  
> @@ -184,10 +186,10 @@ static struct cpufreq_frequency_table *init_vhint_table(
>  		if (i > 0 && ndiv == data->ndiv[i - 1])
>  			continue;
>  
> -		num_rates++;
> +		(*num_rates)++;
>  	}
>  
> -	table = devm_kcalloc(&pdev->dev, num_rates + 1, sizeof(*table),
> +	table = devm_kcalloc(&pdev->dev, *num_rates + 1, sizeof(*table),
>  			     GFP_KERNEL);
>  	if (!table) {
>  		table = ERR_PTR(-ENOMEM);
> @@ -229,7 +231,9 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
>  {
>  	struct tegra186_cpufreq_data *data;
>  	struct tegra_bpmp *bpmp;
> -	unsigned int i = 0, err;
> +	unsigned int i = 0, err, edvd_offset;
> +	int num_rates = 0;

You don't need to initialize this AFAICT.

> +	u32 edvd_val, cpu;
>  
>  	data = devm_kzalloc(&pdev->dev,
>  			    struct_size(data, clusters, TEGRA186_NUM_CLUSTERS),
> @@ -252,10 +256,21 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
>  	for (i = 0; i < TEGRA186_NUM_CLUSTERS; i++) {
>  		struct tegra186_cpufreq_cluster *cluster = &data->clusters[i];
>  
> -		cluster->table = init_vhint_table(pdev, bpmp, cluster, i);
> +		cluster->table = init_vhint_table(pdev, bpmp, cluster, i, &num_rates);
>  		if (IS_ERR(cluster->table)) {
>  			err = PTR_ERR(cluster->table);
>  			goto put_bpmp;
> +		} else if (!num_rates) {
> +			err = -EINVAL;
> +			goto put_bpmp;
> +		}
> +
> +		for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
> +			if (data->cpus[cpu].bpmp_cluster_id == i) {
> +				edvd_val = cluster->table[num_rates - 1].driver_data;
> +				edvd_offset = data->cpus[cpu].edvd_offset;
> +				writel(edvd_val, data->regs + edvd_offset);
> +			}
>  		}
>  	}
>  
> 
> -- 
> 2.50.1
> 

-- 
viresh

