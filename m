Return-Path: <linux-kernel+bounces-872824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D77BC121E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2D884FA0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174532F77F;
	Mon, 27 Oct 2025 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="ypygDytn"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3A42DE709
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609511; cv=none; b=CRiOVs2husiZG7T7ETBFvA+ncwIFKartXlTHb2mZeWW48vkuN6067SvqkfAJy2B7RECQ1OuJiL6CEHotQozAkZ32GQf2o1EcMXmUrWx5cnbk1e/HYBgj0qe56Ajb1ZIt9YTp7L0/U5R5A4j/b8pSRxP4L15c7F7LtCEAGI+Hkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609511; c=relaxed/simple;
	bh=NkRPhIpUL0KWyN8WDV3xMQy976SyIF1Lzif54tBlA3c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/UCJJf7eypdNwKkOZ/0/wxsbmRKKR0NPGEMid/HzfUQh6+hsCg8yydrtBMRQzMhIZAZnxqwAXrBI7XfuG5G5zbfQlmqXWzM20ofyHwLNSK1WaBpuhgLMevkNxwB42wDU8Qz0nIcob27G9E1lZ3HcqI4zzdmGE0BvzHQzsMjD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=ypygDytn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RH6Fb51120468
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=K64EqhXoumfbF6yiKLa3
	ujcAskeWcVn5aoQ4CYMOTJE=; b=ypygDytnJdRpsdaNmXklVNoq9zmgG+7h9Lwd
	s30WiwTI5bo+5Lk0wJQUnslvCLD/7z7dv9apxwbw0m1w4B0A+CZEBlS5bxBEKx6v
	2xkhRoF7EaPI+rDiJhG9bScanI620U0VQkSNL9mDAyKxqJzWPPYS53XNrYJPlIZY
	aQyHT4cSkWgmCJzh8U4LQXGQ2qoQGdZ32tP5FjblO6GEQpupt4dmBb71se3/KBPC
	WNFZK/ePOrAmUKizqLplb4l2gfFGflAVDLo5zrZpo0kaLQwvPnWwNgimFBVkqSyM
	15lM0U8iFSjBVOaAdke56kBpq5a744ibHF2/qk2IheVU244FTA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a2cug32qd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:58:28 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 27 Oct 2025 23:58:27 +0000
Received: by devgpu012.nha5.facebook.com (Postfix, from userid 28580)
	id 3B4A147C147; Mon, 27 Oct 2025 16:58:16 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:58:16 -0700
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] vfio: selftests: update DMA map/unmap helpers to
 support more test kinds
Message-ID: <aQAHGCAF9Wj5oGUY@devgpu012.nha5.facebook.com>
References: <20251027-fix-unmap-v5-0-4f0fcf8ffb7d@fb.com>
 <20251027-fix-unmap-v5-4-4f0fcf8ffb7d@fb.com>
 <aQACJucKne4DRv06@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQACJucKne4DRv06@google.com>
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: 7yjPMAYtegdKabCooOrgN-ZihceLPTkp
X-Proofpoint-GUID: 7yjPMAYtegdKabCooOrgN-ZihceLPTkp
X-Authority-Analysis: v=2.4 cv=GoVPO01C c=1 sm=1 tr=0 ts=69000724 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=1XWaLZrsAAAA:8 a=qtSfAhGtrGOdXbEVq08A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDIxOSBTYWx0ZWRfX7e006ylVbEvC
 nYRLVAMTcyRg8KlUdzEnqE0rQGTsh3wGuuljEjJWyMknROzVWHBj/ct3hvLu3Zup1wJ4Es6lTD5
 ikp3EwEObs1paQvm7BW1am04A9SLpZxFtK9L2eX428on1qcwqy6sKR7oLS0JhPf91fIpRIymPPP
 pBfZxqTHfqoo5HJgS3SpOlG8TjA2cElU3njL+x8GyjGmv534Yi2dd1twbR4yhPJO4d0n+NqDp4q
 ntAFZlgGUeHfoCZPFKv5qqUiDgzg2rKBUTHUn17KZ5TP5iSotUcDVKCb2bT/EqXPCfDpLYLaisA
 pWbXAZ8gZoi/Y2h/2lft0+1jgf/KN3U0jxVj8iTDMh7V2TOB9I7YuUzLH5n0iZ7t7FQ9mdarKPG
 dgxqMzC1/VLsVqLoxypJkcmO0cztKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_09,2025-10-22_01,2025-03-28_01

On Mon, Oct 27, 2025 at 11:37:10PM +0000, David Matlack wrote:
> On 2025-10-27 10:33 AM, Alex Mastro wrote:
> > Add __vfio_pci_dma_* helpers which return -errno from the underlying
> > ioctls.
> > 
> > Add __vfio_pci_dma_unmap_all to test more unmapping code paths. Add an
> > out unmapped arg to report the unmapped byte size.
> 
> nit: Please append () to function names in commit messages and comments
> (e.g. "Add __vfio_pci_dma_unmap_all() to test ..."). It helps make it
> obvious you are referring to a function.

Ack

> > The existing vfio_pci_dma_* functions, which are intended for happy-path
> > usage (assert on failure) are now thin wrappers on top of the
> > double-underscore helpers.
> > 
> > Signed-off-by: Alex Mastro <amastro@fb.com>
> 
> Aside from the commit message and the braces nits,

Thanks David. The nits are easy enough to fix.

>   Reviewed-by: David Matlack <dmatlack@google.com>
> 
> > @@ -152,10 +153,13 @@ static void vfio_iommu_dma_map(struct vfio_pci_device *device,
> >  		.size = region->size,
> >  	};
> >  
> > -	ioctl_assert(device->container_fd, VFIO_IOMMU_MAP_DMA, &args);
> > +	if (ioctl(device->container_fd, VFIO_IOMMU_MAP_DMA, &args))
> > +		return -errno;
> 
> Interesting. I was imagining this would would return whatever ioctl()
> returned and then the caller could check errno if it wanted to. But I
> actually like this better, since it simplifies the assertions at the
> caller (like in your next patch).

Yea, I was also worried about errno clobbering up the stack from the ioctl.
The reason for -errno was to keep error values out of band of >= 0 ioctl return
values (e.g. if we ever need to do similar for ioctls which return fds)

> > +int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped)
> > +{
> > +	int ret;
> > +	struct vfio_dma_region *curr, *next;
> > +
> > +	if (device->iommufd)
> > +		ret = iommufd_dma_unmap(device->iommufd, 0, UINT64_MAX,
> > +					device->ioas_id, unmapped);
> 
> This reminds me, I need to get rid of INVALID_IOVA in vfio_util.h.
> 
> __to_iova() can just return int for success/error and pass the iova up
> to the caller via parameter.
> 
> > +	else
> > +		ret = vfio_iommu_dma_unmap(device->container_fd, 0, 0,
> > +					   VFIO_DMA_UNMAP_FLAG_ALL, unmapped);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	list_for_each_entry_safe(curr, next, &device->dma_regions, link) {
> > +		list_del_init(&curr->link);
> > +	}
> 
> nit: No need for {} for single-line loop.

Ack

