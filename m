Return-Path: <linux-kernel+bounces-874533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E41C16873
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4E2401947
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C734F260;
	Tue, 28 Oct 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="IBcgLS0V"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AB20013A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676953; cv=none; b=IPZwegKrFIy7aMViuI5/f3hNe5ALb2L/bCCW9DA9BOYISkyuqSS3iXHnhg6n5lv5MnPvkd4mT//9JX6P9FWVcUIek9Dr7kXxwiNb8oNiHnPmrQdxoqN0tQU5btmuDyReedkBVGF4fMYkKQRu2nlYFNb+LhHA61CWOvSAbiqUTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676953; c=relaxed/simple;
	bh=HL4Jsmiqq3qZinNDgEWhWXSE9m4WVT1UgDC8ewCAwvI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYK25IWyauCL67D3R3m4Owm0nqkPbZovmjXMRKxAkQLuw0GWzqyB8kO2qDObLf1dBEtyxEdYq2Hkg+njqeiQEQvkw6bcgmx4kfQ49MTMHLMbQPK7uyAuE5cSkUc0jZCeO38olG7BrtjkFohVjYDr1WlPY6nauTiXcqSU8xMC9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=IBcgLS0V; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SILeXJ1469959
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:42:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=O0D22jbflGl1QZqxbJJ1
	lyaMPVaagUGQk+kZCnolltM=; b=IBcgLS0VKenZW7H8cSVqNHwonnmiclflTEMv
	3jaM+H3bmXl1sO+txvPwPozjFnVhcUWTOYV0x1/5g+ACVy82IsFrqtvoFBthK3sg
	ZnbU+oclh08BbfGRbnvIGKON3SfKUL7IdTiYKiuHN6AHF11KXe43zc3dFW0l4Zo6
	8maptMbFtInJ1ODUHuk+mm9qfuPKf0tlPkPgczFWgXFzxxkfYb6r+KMCCjGPLP/s
	yLuTkIvyhw/cvNI9yM2ERWT6r07OmHDBss+nkvdhzI+6B0zJdcNYwguEVg9yprkv
	3GnAZgKYv3sHHMY/L/vrI4pL0yqTGDQY6ygmzdEBBpVITTaQeQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a2xt6b86t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:42:30 -0700 (PDT)
Received: from twshared82436.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 28 Oct 2025 18:42:28 +0000
Received: by devgpu012.nha5.facebook.com (Postfix, from userid 28580)
	id 77C8E53948D; Tue, 28 Oct 2025 11:42:15 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:42:15 -0700
From: Alex Mastro <amastro@fb.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        David Matlack <dmatlack@google.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] vfio: handle DMA map/unmap up to the addressable
 limit
Message-ID: <aQEOhyYQKW4unEfZ@devgpu012.nha5.facebook.com>
References: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
 <aP0S5ZF9l3sWkJ1G@devgpu012.nha5.facebook.com>
 <20251027133904.GE760669@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251027133904.GE760669@ziepe.ca>
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=VK3QXtPX c=1 sm=1 tr=0 ts=69010e96 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yJsSUgGDADgjvR2qnwgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: BE_5KnfNYtMSidEXWmc1rk5MisDx5mlf
X-Proofpoint-GUID: BE_5KnfNYtMSidEXWmc1rk5MisDx5mlf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE1OCBTYWx0ZWRfX1NgMI9E6xnY6
 2urGWvw3CA8jo/4gWb/6KoMW/BENDUer9UR7PBzotVS3qDt2NByg9AS0RS0whkmOVzRoeQ7l4Yl
 mHuWhliJpB4+b/VJcWQ8Zfux0pm2dSAMeK42p2nu1XySlx8Hf66u5hzRo3jjMjvh7N4gYD2VSl+
 /8NpepZIQPgc/KGPYnvSgTyhTUrqrlzXkH/Dwwi/fck90sZ1HR3yoy//eGVHl3lTzF2fB9bW0W5
 yrEROH7isQvcBPOgEFKl1FpTJpzjxPw0V1c58mLGSXC+x8KVqg5Ef4jI2fCNdmNeiMq+DLJkKX9
 K53lHLLS1YGcENQTDefhcst4PKOJCvOWS5rE8OSUYB9LyXaVJ7wpv07XG0MVsSDQu/1kOVjbzyQ
 xfCJu71yxuqG38ZC4mXLMfqAx87g+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01

On Mon, Oct 27, 2025 at 10:39:04AM -0300, Jason Gunthorpe wrote:
> On Sat, Oct 25, 2025 at 11:11:49AM -0700, Alex Mastro wrote:
> > Alex and Jason, during my testing, I found that the behavior of range-based
> > (!VFIO_DMA_UNMAP_FLAG_ALL) VFIO_IOMMU_UNMAP_DMA differs slightly when using
> > /dev/iommu as the container.
> > 
> > iommufd treats range-based unmap where there are no hits in the range as an
> > error, and the ioctl fails with ENOENT.
> 
> > vfio_iommu_type1.c treats this as a success and reports zero bytes unmapped in
> > vfio_iommu_type1_dma_unmap.size.
> 
> Oh, weird...
> 
> What do you think about this:
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index c0360c450880b8..1124f68ec9020d 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -707,7 +707,8 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
>  	struct iopt_area *area;
>  	unsigned long unmapped_bytes = 0;
>  	unsigned int tries = 0;
> -	int rc = -ENOENT;
> +	/* If there are no mapped entries then success */
> +	int rc = 0;
>  
>  	/*
>  	 * The domains_rwsem must be held in read mode any time any area->pages
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index 1542c5fd10a85c..ef5e56672dea56 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -367,6 +367,8 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
>  				     &unmapped);
>  		if (rc)
>  			goto out_put;
> +		if (!unmapped)
> +			rc = -ENOENT;
>  	}
>  
>  	cmd->length = unmapped;

Seems reasonable to me. The only affected callers are 

drivers/iommu/iommufd/ioas.c
366:            rc = iopt_unmap_iova(&ioas->iopt, cmd->iova, cmd->length,

drivers/iommu/iommufd/vfio_compat.c
244:            rc = iopt_unmap_iova(&ioas->iopt, unmap.iova, unmap.size,

So your proposal should get vfio_compat.c into good shape.

I think these locations need more scrutiny after your change

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880..e271696f726f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -777,6 +777,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 
 		down_write(&iopt->iova_rwsem);
 	}
+	// redundant?
 	if (unmapped_bytes)
 		rc = 0;
 
@@ -818,6 +819,7 @@ int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
 	int rc;
 
 	rc = iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
+	// intent still holds?
 	/* If the IOVAs are empty then unmap all succeeds */
 	if (rc == -ENOENT)
 		return 0;

