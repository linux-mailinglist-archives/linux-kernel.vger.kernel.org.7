Return-Path: <linux-kernel+bounces-836285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A946BA9316
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF8A16FD04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642F305954;
	Mon, 29 Sep 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4DhP4wUk"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739DD2DFA25
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148761; cv=none; b=rFlVsY9fOMpEkrABjA3+qxSLhpyMCAOgxTKBbz1T0jMy7460f5H0HnTiQF2ABIJ+bEvZfnAs4RQQhDGdeN/tOhVLJnGRXlr3rVQVFm8hjjoZvWk9HuzRIb1NdfjQbcKDCnoO/60eAZByTX/LRy8RnOkzZl4i0aOWQRLXKSCQafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148761; c=relaxed/simple;
	bh=IPfBHgXBIWGkmCbENeVsi96BJ7N4st3OLtzOumLhCzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3p2xGbjhbu3ZhKKspoXBbm96WaTOnSR4BfGSt2t2lIk7+qG5SCrN88FTZDrdD7YcOznq01pEbOB2yJHU4yN3yRpcK68FhN0NoZNNH9ljtM3e+eU2ipbsLd7yvBNO5wJ+yh99h2w4+1BcpX1k4dCiEUxACPDPjrg+nJeVMwUndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4DhP4wUk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e32c0e273so105885e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759148758; x=1759753558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rX8QNnM/VfgNSl8joey8ya0plk5QpjGP/jUnyfo2ncE=;
        b=4DhP4wUkUpKjJCVQkwf7bVsotlPZMNPsaD65JWn7dh3G3h8S7xjQ8Og2SmI6iU7jiC
         gogj/VUWdWQ14MybYb95Bjid5STdd0SlACsxbhgJpAfNhvJlk+8dJOvwUKhQQtWq1Xgx
         KdT5oLjkqz+XGTWgPM96tLhjZ0RJ2OXXBhQq9ZVFZ3Jb62wViczes13QDYyfT7ak52jz
         VHZQWChbDU19x6pDONMx3vQiL7WGe3WiM0N6ljKdrNgJBpBVOg+DyAp8LHWsiTL+38Pu
         7Z5dzsewCKynD499MEMtytnRljJdDyDL/99NhOVSPoA6ijrHFtA5nZg5DBA2E89hwWJq
         efXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148758; x=1759753558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX8QNnM/VfgNSl8joey8ya0plk5QpjGP/jUnyfo2ncE=;
        b=JESr/Qh8xp/iTBhKXU2OfjegKyFsHgEwsMR8b48pmyei2N2paNMV9Ce8malHcSFhMW
         Km/hmW2K3krGL/Nbc8h5MubP41q62xhtPGUtw5jBOZxYTIPxTohChISc8p1ZTYGK6qZa
         EeTB0C8f1Dgp9iNUxej63+ElaGTIGbCPfzO11V7D208HzXg+JkR4nLsEPUmCo1vAkiPW
         R7n84EmSYHklCmek7XDk/wn2t/RPXLzynUy+fq0yqXvjKHpXhv+L57POhFM299KzaKg5
         o7Wtc4C28tuum1f4sugoU6SHhddExUtiocLOqYlSxZMC9qUKY0KkUT+1qgw30FFPW2VI
         aknA==
X-Forwarded-Encrypted: i=1; AJvYcCXX+w3dIr0h2+mTM9Z3udHL2+JRI3QK1q8gex9w0CS+Ou4wF1hQbJI8UZqWu/5OKJlkTK2nnqBUYjwb/xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvKpb6yoVqV4xCT0cdMIBfUHNgthQfxHIn7q5IG5lIRAxNtHKO
	r+DfJDyAWW+MU1i21hwpxgY4DBPJdBHDFjbztu4ePHx9opf/UzpLQ83HK7oRyBkO7g==
X-Gm-Gg: ASbGncttZcVbBq6kc2YmD5ORPyGMwlu10Z7uflHYDQtv5M5KlIfTrILrdngD/gCMifU
	ITVu+Rp/AQ19dYLZqA/R+jz8bpty3i9IW8Xd/ISKcf/D/iAj51WKCUvTjsYseBpnsFfDwED4HnM
	LoOo8tTYNZ6kciBRDMC72sfNgic2dcP2aZu/f8cVqc5Pt7bV245YRLbhTmagkfG+qi3BZAgrwiV
	l3jgCQC9/gAHTCX4w2QOSGxmvW52+VkXRryJl1WNO8z/0jDJVnce4UkN2vMJWyBhZ29wnHc7fpv
	EBPCisrgr+/sYzoN/xJognIZxyEBbIwfNhxwtuaLEIHPGZLOKnUQP6Nt4HiIJA4DVtGEKdSkbb0
	/U5HbBAvgl1s42H+xPRSUwibUtkETkaAkSOoYSQtdSiPRdCGJIoZCTouRKGLViHqAxug8q9nHZP
	f/r3uoNbh9C1KH
X-Google-Smtp-Source: AGHT+IHglrqxMx9eJ6fNXPXFkzLGw3noYR5M/ZCP/DdPP9T4uHc8AX5l/UCkLJ7NIRLr0sQHonn2ig==
X-Received: by 2002:a05:600c:8594:b0:45f:2db6:5202 with SMTP id 5b1f17b1804b1-46e5758ffc1mr335055e9.3.1759148757558;
        Mon, 29 Sep 2025 05:25:57 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6cf3835sm18265146f8f.46.2025.09.29.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:25:57 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:25:53 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNp60ak6OASbPd_J@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927223953.936562-2-danielmentz@google.com>

On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> Implement .iotlb_sync_map callback based on the new callback in the
> io-pgtable code.
> 
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2a8b46b948f0..0ffcc6c8e4bf 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2541,6 +2541,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  	pgtbl_cfg = (struct io_pgtable_cfg) {
>  		.pgsize_bitmap	= smmu->pgsize_bitmap,
>  		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
> +		.defer_sync_pte	= true,
>  		.tlb		= &arm_smmu_flush_ops,
>  		.iommu_dev	= smmu->dev,
>  	};
> @@ -3366,6 +3367,18 @@ static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  	return ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, gfp, mapped);
>  }
>  
> +static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
> +				    unsigned long iova, size_t size)
> +{
> +	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> +
> +	if (!ops || !ops->iotlb_sync_map)
> +		return 0;
> +
> +	ops->iotlb_sync_map(ops, iova, size);
> +	return 0;

Shouldn't that be
	return ops->iotlb_sync_map(ops, iova, size);

As now we ignore the return from the ops and mask it to 0.

Thanks,
Mostafa

> +}
> +
>  static size_t arm_smmu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
>  				   size_t pgsize, size_t pgcount,
>  				   struct iommu_iotlb_gather *gather)
> @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
>  		.map_pages		= arm_smmu_map_pages,
>  		.unmap_pages		= arm_smmu_unmap_pages,
>  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
>  		.iotlb_sync		= arm_smmu_iotlb_sync,
>  		.iova_to_phys		= arm_smmu_iova_to_phys,
>  		.free			= arm_smmu_domain_free_paging,
> -- 
> 2.51.0.570.gb178f27e6d-goog
> 

