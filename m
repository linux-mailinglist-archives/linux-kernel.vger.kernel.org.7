Return-Path: <linux-kernel+bounces-742570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945F2B0F3D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDF41885789
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4F2DEA89;
	Wed, 23 Jul 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+P8p2a6"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B715B0EF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276781; cv=none; b=rtIKHhca+2ziVRmZ1qCcULgbTtTvsvixFiiBNj4no4fJOpY7DDVYDkeVLEq6Z0ov/UYFFNBbLrGnpz9f3rglIwzGLZc+Igv7+uXLNgFeLNoeL8DxpdtFG2mgegnAS1+AOSo2sImOZyYVVUKPzuBn+kOnTDH01XRwfF4RBZqoRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276781; c=relaxed/simple;
	bh=3wO7ofU7WlEoFNNaUev6B9+Jglx7cQTZpeu6LIwLyC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAQKbbgQlnfqhEirHDw8YWvBVYPDjK0/zAHWXDhJH0ZAD/dvpcnaLDYxorRpSSiko9tmRQ4pC81UIXJ+p1mCPUFpmLhAwg3fYjP4/vE6jZdG9y4IdOPEhWSlPo4r6B9NCaEOZ9Amr3zZShG85tERni+czmKgKVsDjLehyRCdDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+P8p2a6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-237f18108d2so177115ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753276779; x=1753881579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb0/7yMT9K2SX5uLjkUISpIiyNMkZYnJ5i8nHLSmhqw=;
        b=N+P8p2a6Oz+zjaZ8ZI+ZpwAaIAAorYI5+Erutavo+TRA/b+xhY+bfTbVpt6ComWEMG
         k356PJGgL0/boX2pcAFOsL9AtwKpppQ4ebDmelTsS/KjbIjH8+ZV7GESJxHHqBZ+S7q/
         nVdcR260wt99f3AUVWQQW8IB6GI1vbFlzmF7uMa018rEY5CWaIUj1zg3y2JApp+x+OzX
         0FZ5XDJHmB8d5dF0LTaR1zzvkat+do8tAPQw2yMx2gt4OEJb8c/GvCkttu6vU2jT2OPs
         oXdttAfNkQtnuPcO6mpSZ8eMFROZais8jpIVpN/cCAM+At+I/0Hs+Yc62FlvQafMTMQX
         AKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753276779; x=1753881579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb0/7yMT9K2SX5uLjkUISpIiyNMkZYnJ5i8nHLSmhqw=;
        b=urg2KE8uh63X2La38oOcIlzbpzAl4KYk1mKfZ75WfKO7pqqDUvzrGPP31ZL/ypaBa1
         hHssfSSR30lheFpSHcQoy5TRnqE7c2+ykWZQL1FWl8nN8ORX+gqgkj8ZbL+QyxxmC3jd
         Cdy9cmRxyIhu9KLu2PHYZYwxKMpLHmF++PKkR7aw8FQvy3JkZW0FHs1iQCCtLRfuGO+k
         3qRjgfrIdfJuHTsnwWEpxQhwlG9PhdYeM/Qe2B7YuGR3tcVxci63ebMAN0kRLECYSRYN
         atFrPSTiRUkI2uqnviK7mH2APsynit5nR16HrGGfx9rU7P4EN6Yg1THlLKcxbjLuxI5r
         nG0A==
X-Forwarded-Encrypted: i=1; AJvYcCU316mwmg6OmQZfVN8m1eST4GfEIJgcz8C/6Eqzcvh1/QJ3IV4YKLtM5Z/BUNhXPKwUAewkZkwiCt9PMRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGbyr0Wdb7+KCthRnhduZUpzp9v9jlgB4gR9w8cNm6MkmTZuC
	vPkTzmUG6zWxE9xy7DUr9Y9wCz95o6gxRp264G7bFL+V8kUhE4iQJMtd5mu7b9MT7w==
X-Gm-Gg: ASbGncsdI1mOhwPt43CdqyFZtR2CUXMWEvRmFBy+RjzAOBjZoBAI9Ma07X9apJTXk9R
	q2rg9RHmx4AAwp63ZUTeyBb3kMA7WyQVaSgxVo0iVtovalTqcCAoFRPIUtEhpRPnPNz02hrYI/y
	qk+6f4kYJ1trzgloycuyWwCypFg5USkq7UOCW5TXlYOj4TgK9edDktHMx3+57GUKYUObOHIeD2f
	MoGwuW486ziAj2x/V+RoijSsNTM5k+a0WWy5MEWivSyyXQ9a1ojiiYweDPbn5x+fpqDvFIKqHi8
	t0Rz2fEzvF4jukB+tzrW1G+zP8Fb5hb8SyQJogFr/VyBNOnPxaMtR0nPzR8dHAZZr5/Pu40Vtuq
	VP0K0y8UjAVhiL0X0jhMd3rBOeGUUqLGNzUT19sXf9Quao6LHJjcz0FR86zoYpu4699U=
X-Google-Smtp-Source: AGHT+IHbupigD7UyWy96X++uPcWs3IP3RJjiuOFwsDzZsLXWJ+ydnHjuzs1Cy05YPmOdWDc6ThTsAg==
X-Received: by 2002:a17:902:d4cf:b0:23d:d290:70c with SMTP id d9443c01a7336-23f9774ca0amr3106875ad.6.1753276779019;
        Wed, 23 Jul 2025 06:19:39 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d4esm96942565ad.23.2025.07.23.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:19:37 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:19:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Do not bother impl_ops if
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3
Message-ID: <aIDhY3JTaT3JC9T4@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-2-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721200444.1740461-2-nicolinc@nvidia.com>

On Mon, Jul 21, 2025 at 01:04:43PM -0700, Nicolin Chen wrote:
> When viommu type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, always return or init the
> standard struct arm_vsmmu, instead of going through impl_ops that must have
> its own viommu type than the standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3.
> 
> Given that arm_vsmmu_init() is called after arm_smmu_get_viommu_size(), any
> unsupported viommu->type must be a corruption. And it must be a driver bug
> that its vsmmu_size and vsmmu_init ops aren't paired. Warn these two cases.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> ---
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 ++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 14 +++++++++++
>  2 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index d9bea8f1f636..c034d6c5468f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -420,14 +420,13 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
>  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
>  		return 0;
>  
> -	if (smmu->impl_ops && smmu->impl_ops->vsmmu_size &&
> -	    viommu_type == smmu->impl_ops->vsmmu_type)
> -		return smmu->impl_ops->vsmmu_size;
> +	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
>  
> -	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +	if (!smmu->impl_ops || !smmu->impl_ops->vsmmu_size ||
> +	    viommu_type != smmu->impl_ops->vsmmu_type)
>  		return 0;
> -
> -	return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
> +	return smmu->impl_ops->vsmmu_size;
>  }
>  
>  int arm_vsmmu_init(struct iommufd_viommu *viommu,
> @@ -447,12 +446,15 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
>  	/* FIXME Move VMID allocation from the S2 domain allocation to here */
>  	vsmmu->vmid = s2_parent->s2_cfg.vmid;
>  
> -	if (smmu->impl_ops && smmu->impl_ops->vsmmu_init &&
> -	    viommu->type == smmu->impl_ops->vsmmu_type)
> -		return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
> +	if (viommu->type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3) {
> +		viommu->ops = &arm_vsmmu_ops;
> +		return 0;
> +	}
>  
> -	viommu->ops = &arm_vsmmu_ops;
> -	return 0;
> +	/* Unsupported type was rejected in arm_smmu_get_viommu_size() */
> +	if (WARN_ON(viommu->type != smmu->impl_ops->vsmmu_type))
> +		return -EOPNOTSUPP;
> +	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
>  }
>  
>  int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 181d07bc1a9d..9f4ad3705801 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4703,6 +4703,7 @@ static void arm_smmu_impl_remove(void *data)
>  static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
>  {
>  	struct arm_smmu_device *new_smmu = ERR_PTR(-ENODEV);
> +	const struct arm_smmu_impl_ops *ops;
>  	int ret;
>  
>  	if (smmu->impl_dev && (smmu->options & ARM_SMMU_OPT_TEGRA241_CMDQV))
> @@ -4713,11 +4714,24 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
>  	if (IS_ERR(new_smmu))
>  		return new_smmu;
>  
> +	ops = new_smmu->impl_ops;
> +	if (ops) {
> +		/* vsmmu_size and vsmmu_init ops must be paired */
> +		if (WARN_ON(!ops->vsmmu_size != !ops->vsmmu_init)) {
> +			ret = -EINVAL;
> +			goto err_remove;
> +		}
> +	}
> +
>  	ret = devm_add_action_or_reset(new_smmu->dev, arm_smmu_impl_remove,
>  				       new_smmu);
>  	if (ret)
>  		return ERR_PTR(ret);
>  	return new_smmu;
> +
> +err_remove:
> +	arm_smmu_impl_remove(new_smmu);
> +	return ERR_PTR(ret);
>  }
>  
>  static int arm_smmu_device_probe(struct platform_device *pdev)
> -- 
> 2.43.0
> 
> 

