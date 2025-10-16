Return-Path: <linux-kernel+bounces-856970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D55BE58F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1242F4EE7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978322E229E;
	Thu, 16 Oct 2025 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="Er6Sxxgt"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142D2D9EC9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649605; cv=none; b=T0Gfo1YGE2VyvTkWkzSn1hbJWWD8pgffQo6An2XutJx8ARBRxOiNeFVA4kcDNJuepZ8yV6IH1pQVV7f9VxFHyrMIA8LYL8ZRuK4/sW/OCuP2JVZoMntEHNv1rW8aGgapkBT3x9PH0VIkzX/hEgKACmV+V8SHI4QL5sG1sT3JwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649605; c=relaxed/simple;
	bh=n3ixKopgiOXu0j5Gu9Xa8sJEO+cNXcErZs0OrzAD23M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY3T2YQar54O7/vbN5Tp1AYIYjWNJclSUtr9NpqDmAbBRMZH5YQYNNXG7IF1U5EwnChYUeRC9gdlx+8+WDTaeLgABuBOwAgF9mm6PnshWA2Aql56TWc/oIqQU15sdmdRyYJeb7ZVGTq+pPULHvov43kMMyrRuVhHClH+N+8svfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=Er6Sxxgt; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GJU7Be3570266
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:20:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=HTfYx0O/2LqoZlhdDIRd
	qU9HiEQM8Uuj9LLPiMfcY2E=; b=Er6SxxgtnH8X5nDUS++bMuNpLQcXfSf69ptO
	fYWONVPq90iP+kKMWo9qTUL0CABssGqfjbGjUNkk2CoGnwtEVv4KEhUZ0aez9Twp
	Prc/a1bLArxmogVp33TK/KcnHQe3ZnVhb0YSbRO4s0JxCeijn3FsJchwgV8VlhQ8
	R7qJeRHDnVy0r3jDtEkgkka57Yu1yfP/Yr6mtwndbl+vsUgq6iCD1U3FWScDV1TW
	PMSHJdSRP0mWMs3B54aRNuD16TJRWsCrAjOeJbHRmeYAufizb1xyTaVsbTn1mC1O
	ZSwbMlQmdjgeYUgXvCwMht9cbKwlhXEqED71Zkj8UlQdoLgVbQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49u26vbwmr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:20:02 -0700 (PDT)
Received: from twshared23637.05.prn5.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 16 Oct 2025 21:20:00 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id EAE5E12877C3; Thu, 16 Oct 2025 14:19:53 -0700 (PDT)
Date: Thu, 16 Oct 2025 14:19:53 -0700
From: Alex Mastro <amastro@fb.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
CC: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] vfio: handle DMA map/unmap up to the addressable
 limit
Message-ID: <aPFheZru+U+C4jT7@devgpu015.cco6.facebook.com>
References: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
 <20251015132452.321477fa@shazbot.org>
 <3308406e-2e64-4d53-8bcc-bac84575c1d9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3308406e-2e64-4d53-8bcc-bac84575c1d9@oracle.com>
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE1OSBTYWx0ZWRfX/aJbqyZXRE8W
 PU/uptuA9DzNHnfO/GUQ9+BVBMU4BithTwodVPhzNOldDalm3gp0jMVc0aQRbpnaB4mg+BDN4qK
 BiDCOfMlwyrxj4Julp67IE2osijOZuTiUUXOli7eV9lU893ZTdnMwki84G0mY4BEBHksSUkl/ux
 Ki/26dLydHVBIrXn2oZ3AyqG0LpTnLAuR1Ki4L4HjXivhWpHmJ9b4JoPc7zcmhZlRBYzPPORl2l
 nncVDjIwDuO1eTQ3tLuoll64nIFLmY06q7MjEswuOrG0TW+1FNgRcuOc2Bz+cqMeFHvcbI/DAlU
 7TX0Vh4wn/KqBWBd8jBZE95anZDbjPx2uScRbE6E7dvOBj7jAzxUedKnJtsPJonIx7viP0ZMoS5
 +KYf13qXoz56jBpnh3V6CoYTkR/vjg==
X-Authority-Analysis: v=2.4 cv=BYLVE7t2 c=1 sm=1 tr=0 ts=68f16182 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=FOH2dFAWAAAA:8 a=yPCof4ZbAAAA:8 a=lr_byV0os-YnZdEWD9MA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ZQe0tLvV6YLE1rb2eHNCL92sB7rIqQ0z
X-Proofpoint-GUID: ZQe0tLvV6YLE1rb2eHNCL92sB7rIqQ0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01

On Wed, Oct 15, 2025 at 05:25:14PM -0400, Alejandro Jimenez wrote:
> 
> 
> On 10/15/25 3:24 PM, Alex Williamson wrote:
> > On Sun, 12 Oct 2025 22:32:23 -0700
> > Alex Mastro <amastro@fb.com> wrote:
> > 
> > > This patch series aims to fix vfio_iommu_type.c to support
> > > VFIO_IOMMU_MAP_DMA and VFIO_IOMMU_UNMAP_DMA operations targeting IOVA
> > > ranges which lie against the addressable limit. i.e. ranges where
> > > iova_start + iova_size would overflow to exactly zero.
> > 
> > The series looks good to me and passes my testing.  Any further reviews
> > from anyone?  I think we should make this v6.18-rc material.  Thanks,
> > 
> 
> I haven't had a chance yet to closely review the latest patchset versions,
> but I did test this v4 and confirmed that it solves the issue of not being
> able to unmap an IOVA range extending up to the address space boundary. I
> verified both with the simplified test case at:
> https://gist.github.com/aljimenezb/f3338c9c2eda9b0a7bf5f76b40354db8
> 
> plus using QEMU's amd-iommu and a guest with iommu.passthrough=0
> iommu.forcedac=1 (which is how I first found the problem).
> 
> So Alex Mastro, please feel free to add:
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> 
> for the series. I'll try to find time to review the patches in detail.
> 
> Thank you,
> Alejandro
> 
> > Alex
> 

Thanks all. I would like additional scrutiny around vfio_iommu_replay. It was
the one block of affected code I have not been able to test, since I don't have
/ am not sure how to simulate a setup which can cause mappings to be replayed
on a newly added IOMMU domain. My confidence in that code is from close review
only.

I explicitly tested various combinations of the following with mappings up to
the addressable limit:
- VFIO_IOMMU_MAP_DMA
- VFIO_IOMMU_UNMAP_DMA range-based, and VFIO_DMA_UNMAP_FLAG_ALL
- VFIO_IOMMU_DIRTY_PAGES with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP

My understanding is that my changes to vfio_iommu_replay would be traversed
when binding a group to a container with existing mappings where the group's
IOMMU domain is not already one of the domains in the container.

Thanks,
Alex

