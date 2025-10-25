Return-Path: <linux-kernel+bounces-870091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED135C09E2E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 20:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7113A47AC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055362D0C94;
	Sat, 25 Oct 2025 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="l85FGJiq"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466E26E6F7
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761415924; cv=none; b=kAHGrosDJ3aSjQsBdnKGAA64NOfWrjQme+qCYs21scSqAylui88FyE583h45X4O7Op2dC9bVXrZQ0s4FogdnTFrZR588LgpOYniodu92qpG0dsOmx/2khKCpRtKi+jlCjkaFKFrspKt3dfzSDcVdtu/Oi0m6Zt2EjjuUPjTmvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761415924; c=relaxed/simple;
	bh=/IKhcuNSgMpOamjayHWURydjiZtD6SnaLDkZZFe/CQc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJl2zWxlhT89J+AmcUS1GzCI07v+EGmrZcbY5LVQgxd13MSiLfoQIt62PwCE8TAtR+/xf+hu99/9IGnrzskw1M/mR7WOn5zs5zBLZT/lYfixcT3ePXzxZ4a/DDmvyRGVOrnz946uNgU1uU1s96q52S2efU/+3QW3tdcquELpLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=l85FGJiq; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59PBcnxR3544507
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:12:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=/IKhcuNSgMpOamjayHWU
	RydjiZtD6SnaLDkZZFe/CQc=; b=l85FGJiqEcritGHcf9G+yxkzcFt4CeUBBQ67
	s99qh3h81IVudvTTM2oeiI2ymRAt0ye1gk56yX1iHO0KtwdM1FLjxSjRwgc/m34o
	38t26I4CMiXbvuyzDnjytG5bQnxubaiV5pAbJ6hQntctt6SWqdZhQogrp0iTwiE9
	XqpBTrZad0fxhCKLqcMggO8qj/8h8vIZxLyN7JwWtJlvrVAwUf7JCrX7Aa5A57f7
	1u0jEwcsqlh5XC5vB5cfyXRdUfTatUlADmv0eHE+tTgzJzlddSrWqJrV7tUMtEgR
	EW2ViE+NA3mBHhcydsLq2LRqL+idxRX9Jht3nxP5260wsuSpaw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a0wuhh46f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:12:00 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Sat, 25 Oct 2025 18:11:59 +0000
Received: by devgpu012.nha5.facebook.com (Postfix, from userid 28580)
	id 399052AE426; Sat, 25 Oct 2025 11:11:49 -0700 (PDT)
Date: Sat, 25 Oct 2025 11:11:49 -0700
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        David Matlack <dmatlack@google.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] vfio: handle DMA map/unmap up to the addressable
 limit
Message-ID: <aP0S5ZF9l3sWkJ1G@devgpu012.nha5.facebook.com>
References: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: 2iYcX9wB9NSgraP-88sy0rEAECIGXRG8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDE2NiBTYWx0ZWRfX6qZy2/SrDCyT
 hrVZ3tvdsmBEeb/vi+ajm5e+uxqS2PhjV8JPBTel3By8UL7ALXvg/lmywmc9ZWBD8jz+VRqIeWL
 ckGqCVC7pNzOKvDI5yoe8e6aFTv2bkhov8c+f9HAhlQRDBN6RO28CXnNtgg2l1d0Hj7CA1tMc9K
 RUmA5S0eoNOAIdgRVcYTA+EIdw4/H1CPWpXt3vf1WuHt6Q9Tgw39FUpbIaL98SqVBvlKZ0NhiE3
 Iig7+D61BBLsWLrxIiLiL5ikU6IxR2HLK3BGGhhohw1v45Bh55lWk5ZXKPUz7a3kWKLIJeC64jb
 bvLwf+s8oCMd3E06TZCjQ78JwHYSWEyPYyiap0gcEKwaH+fzV+/MH6k1FJ79qeaAfNiAf/DAjI4
 ZQK1d+Ebo3yTMCIWyi3sh+5oT/DM3A==
X-Authority-Analysis: v=2.4 cv=dMqrWeZb c=1 sm=1 tr=0 ts=68fd12f1 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dzLN2TX3shYeVDC5Iz4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 2iYcX9wB9NSgraP-88sy0rEAECIGXRG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_06,2025-10-22_01,2025-03-28_01

Alex and Jason, during my testing, I found that the behavior of range-based
(!VFIO_DMA_UNMAP_FLAG_ALL) VFIO_IOMMU_UNMAP_DMA differs slightly when using
/dev/iommu as the container.

iommufd treats range-based unmap where there are no hits in the range as an
error, and the ioctl fails with ENOENT.

vfio_iommu_type1.c treats this as a success and reports zero bytes unmapped in
vfio_iommu_type1_dma_unmap.size.

It implies to me that we may need some more shimming in
drivers/iommu/iommufd/vfio_compat.c to iron out observable differences in UAPI
usage.

Addressing it would be outside the scope of this patch series, so this mail is
just to make note of my findings.

