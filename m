Return-Path: <linux-kernel+bounces-742608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD95B0F43D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E01D9678A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDDB2E5427;
	Wed, 23 Jul 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdGk9JPI"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCF8F58
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277881; cv=none; b=rjgSmZaQb1wzn9oI9gMbw2aigfVpJNdUZQl2TrqGEFZdPJ+Ifdgl94wVcpvlee0DYsAMotw1PHZSsCLP/ck2CftahHi08gCAeVbUfmM0An08e7sKRAhR99DFSWeQ6Lnviop+Emft4q+lzjhSdz+LcFKbukT1iRe1IwWuioCXTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277881; c=relaxed/simple;
	bh=loj95alexQ30u6RYGhFIYnYsaA5hCj9ehW16PyQpKvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+rrHY4Fb1xIfjhtIk5rgt6jE5B8/1dX2SM4rOzKYjL+vJ4uYcS1SBpoQJKlSzaneZOx+xxCui1ZZDsSgISP//N39NHxFlI1WVmVU8zqlXzJOYUtQHGnB9UfdIhCnNi9r77XF26RHL4iSJDDM2xBx4bcbDG8MvKTy7++dlS1dUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdGk9JPI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2357c61cda7so117045ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753277879; x=1753882679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+JLK8o3lT0td/MYczWJEZnb2L8d00AyuRGacnswf14=;
        b=JdGk9JPI8X4t66bEVRyd90KaD6AvgRS2ajscRpw0gn84aBeIcLgVNDHJOuHuEvNCdh
         ymv9soxA9fVMMK/Lna7aPTK8R+KjSz6sg55UGFbvqdjM51Q0JLfzdr0RMfke7dXmH3iy
         5rnOHdwh6NVnW7jmkNYfxZdj2fr2zgvVIbyuNxk0vTGU2M2+EUAUTsRi/UlwUvxdD8m6
         On3Q0VtiekwK17M2oTwxGXB+mR6pIEjXZJhe/qsdvYBpVMGC0rHfy+n/hm81b3XYgqBt
         emIFcb/P11lbkctNscVFaQsh7kjjaLHSkXiAJwlVWLHAwW4SC97VdQPN3AU1WVfWMudr
         HvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277879; x=1753882679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+JLK8o3lT0td/MYczWJEZnb2L8d00AyuRGacnswf14=;
        b=oI0eTg1ndO7FOkqqCs41joZ/N25ini3bn/hzRQam+AdMYz3Crki1eNyrey0sXcjnvs
         v0w5IHwEaqc3i6sctq18PetjIp/PaG0oKQYYHUzk1+0r36Q7GvxAFBtrahstPbuZW/S7
         m2bcRLVw2ySvJ4NFaai2LWT9GvGzFdcdfEjrMxKBgeVI2mnUt3Gsq2oo4SzH2Wl0Uyji
         v2ac/nC4Fx7IKd1pohm3oIhaTuV3ZMRwzFZTeOq8meqVs0hU9Lo/9dPeCy8lpyqz6Of1
         l1Y0cpvz2CIgmYmgqAEtSrPFuEQLrELoKlJydi7flaoF7/bhJwZFtWWtP2kei2DR5Ihe
         us5w==
X-Forwarded-Encrypted: i=1; AJvYcCUPs8QVtkDXyrb0dWu0qTIG3ClM5GLOl2L5gau1Falw1tj+0yunpR10QSWZV8wLgVsLhVNbepYRiAFVNsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2eodMCTh/GIe3Z9GsTpRNrW+fO5tNx6pYjwZrU0HDpMj/t+7Q
	Eh5/dH3+ulFSQp/gm63N/ggLZJpsDn2vs9mnAc8ajDeMBnnVfyhp94M+Y1YTn5zsnA==
X-Gm-Gg: ASbGncuNikmM13kMS+m31H6e4neEtpfS29kB+ftynByuyiOrzfmhwF3oAW93ghemR2w
	5n64jo8zmq0OTlSqbuSDk86tLrYUKH03Pek5SJsbdGKKy0Iu/ygUQmZCPI0IJAqN8j6TyFDkCMq
	IMHGLh6JWwsKmgz5xk7ntkw4ln2wMqrOZWgyF2LkeA661EToQYzqyeONL++59vYD8+p5SlUct7T
	jrzcwAXYmgT8zaU2HDT9hWCD7C+jhlv1XxNCCvrT9Tbp1L44LEXxtnOGYe2UbWZfCYwwRDl3Gig
	qpgnutXsQfzapSl0wMMDb1nQnmX4QsxQ3CSUg4pCOzt5qAMFZReWOE09DBLzRvNX77bzjcFrgC4
	e7Xei4Odr3I3PLwf4Rzcpuet7L0iMdtLjZRsURzwEFwa9WkMejv6PAwqJ/T6tSBAP0ho=
X-Google-Smtp-Source: AGHT+IHNDySI/nH+OMkMv0ChQEdtb4UFgDV0ZT5tuGjSaRubSm3kOT/oocHqF0dfxqVXTEfR3wYujw==
X-Received: by 2002:a17:903:15c3:b0:234:13ad:7f9f with SMTP id d9443c01a7336-23f978e398cmr3323895ad.22.1753277878789;
        Wed, 23 Jul 2025 06:37:58 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23f75d13bdfsm77086475ad.51.2025.07.23.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:37:58 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:37:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIDlsUvF2Xbdelvx@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721200444.1740461-3-nicolinc@nvidia.com>

On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> It's more flexible to have a get_viommu_size op. Replace static vsmmu_size
> and vsmmu_type with that.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  8 ++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  4 ++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  3 +--
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     | 14 ++++++++++++--
>  4 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index c034d6c5468f..8cd8929bbfdf 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -423,10 +423,9 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
>  	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
>  		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
>  
> -	if (!smmu->impl_ops || !smmu->impl_ops->vsmmu_size ||
> -	    viommu_type != smmu->impl_ops->vsmmu_type)
> +	if (!smmu->impl_ops || !smmu->impl_ops->get_viommu_size)
>  		return 0;
> -	return smmu->impl_ops->vsmmu_size;
> +	return smmu->impl_ops->get_viommu_size(viommu_type);
>  }
>  
>  int arm_vsmmu_init(struct iommufd_viommu *viommu,
> @@ -451,9 +450,6 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
>  		return 0;
>  	}
>  
> -	/* Unsupported type was rejected in arm_smmu_get_viommu_size() */
> -	if (WARN_ON(viommu->type != smmu->impl_ops->vsmmu_type))
> -		return -EOPNOTSUPP;
>  	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
>  }
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9f4ad3705801..f56113107c8a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4716,8 +4716,8 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
>  
>  	ops = new_smmu->impl_ops;
>  	if (ops) {
> -		/* vsmmu_size and vsmmu_init ops must be paired */
> -		if (WARN_ON(!ops->vsmmu_size != !ops->vsmmu_init)) {
> +		/* get_viommu_size and vsmmu_init ops must be paired */
> +		if (WARN_ON(!ops->get_viommu_size != !ops->vsmmu_init)) {
>  			ret = -EINVAL;
>  			goto err_remove;
>  		}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 3fa02c51df9f..e332f5ba2f8a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -728,8 +728,7 @@ struct arm_smmu_impl_ops {
>  	 */
>  	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length,
>  			 enum iommu_hw_info_type *type);
> -	const size_t vsmmu_size;
> -	const enum iommu_viommu_type vsmmu_type;
> +	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
>  	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
>  			  const struct iommu_user_data *user_data);
>  };
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 4c86eacd36b1..46005ed52bc2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -832,6 +832,13 @@ static void *tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu, u32 *length,
>  	return info;
>  }
>  
> +static size_t tegra241_cmdqv_get_vintf_size(enum iommu_viommu_type viommu_type)
> +{
> +	if (viommu_type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
> +		return 0;
> +	return VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core);
> +}
> +
>  static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
>  	/* For in-kernel use */
>  	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
> @@ -839,8 +846,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
>  	.device_remove = tegra241_cmdqv_remove,
>  	/* For user-space use */
>  	.hw_info = tegra241_cmdqv_hw_info,
> -	.vsmmu_size = VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core),
> -	.vsmmu_type = IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> +	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
>  	.vsmmu_init = tegra241_cmdqv_init_vintf_user,
>  };
>  
> @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
>  	phys_addr_t page0_base;
>  	int ret;
>  
> +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
> +	if (WARN_ON(vsmmu->core.type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV))
> +		return -EOPNOTSUPP;
> +

Nit: I don't think we'd expect a call to this if the vintf_size returned
0? I see that in iommufd_viommu_alloc_ioctl, we already have a check:


        viommu_size = ops->get_viommu_size(idev->dev, cmd->type);
	        if (!viommu_size) {
			rc = -EOPNOTSUPP;
			goto out_put_idev;
		}

And call ops->viommu_init only when the above isn't met. Thus,
if we still end up calling ops->viommu_init, shouldn't we BUG_ON() it?
I'd rather have the core code handle such things (since the driver is
simply implementing the ops) and BUG_ON() something that's terribly
wrong..

I can't see any ops->viommu_init being called elsewhere atm, let me
know if there's a different path that I missed..

Apart from the above nit,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

>  	if (!user_data)
>  		return -EINVAL;
>  
> -- 
> 2.43.0
> 
> 

