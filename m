Return-Path: <linux-kernel+bounces-858453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B979BEAD61
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317B294595B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74229B239;
	Fri, 17 Oct 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="h+yf/BFO"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8E29ACFD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718581; cv=none; b=LYyLBgV76Pb/Uim2ASeOteWpNkBTzNSySbVp5XUTjJhZiJsHic/CZRrlTCN2itEvPDTMnbWhGX1mtDn/yoqtaDPFnQaqb3ywKPoYaRz6skAhY65e12PkHH1HD9ThnKd3E9ETNp6VwN0pERY4b0IBiZaZ1KydDuMBsvZyGRwEDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718581; c=relaxed/simple;
	bh=eV1WddDeHMTZSyEjfX0bIHbGWLdnj4dm4RsOBi2TVy8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEuLJd3OWhJyNsyJ4NfLzg18bBEi3isShUiMvARNYozsQLU+sGeQZ2XoQU4ui8otSxJi4XviPBDiBwqdCyGjD0gN3jrc9aBQiUs/5XUJge024z+V3eOGZ7UpDW8IxTbNia2hbPNeVXm3q/NpMb3x+lz2/RE/F8SoK83Gdojhu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=h+yf/BFO; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 59H6KqHh2325437
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:29:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=Bkyn0FBJ6g8s0v6Hz+7R
	E2uFqPMbmbU7KYaLZN2Gtv4=; b=h+yf/BFO4eWQ2YNlKXYCAzoOy6O+EVbrigmF
	fVBiduEvnKALWQMf6JZsUpNl7scvTXH5f1y2otm2y7zk+0HM96n1YJxFZ6UqWXQa
	IQYSm2Asje6hvvvZjJ1nGUu9krps0a1jSa65wSRx3+K3lRsyDc7VOpM8YcPHiJrZ
	h7xL/ZZYDwad1PUztuGYFZ3/2lq7v0/n173Bk1TeAynsf59ipRaBkf8f5zzj1txV
	om/Sc4PBA6lRcrI+VwdbGbe9kUcimSxy+4PeQxbhf0XbMcI1z9VYfDtncqyc0rBp
	l1pi3uPH30F4zV/PflDiTNhiQ5c/X17IWSiN1yKAWgFDqsuztg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 49ugey3kbn-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:29:37 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Fri, 17 Oct 2025 16:29:36 +0000
Received: by devgpu012.nha5.facebook.com (Postfix, from userid 23751)
	id C07981C0074; Fri, 17 Oct 2025 09:29:26 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:29:26 -0700
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] vfio: handle DMA map/unmap up to the addressable
 limit
Message-ID: <aPJu5sXw6v3DI8w8@devgpu012.nha5.facebook.com>
References: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
 <20251015132452.321477fa@shazbot.org>
 <3308406e-2e64-4d53-8bcc-bac84575c1d9@oracle.com>
 <aPFheZru+U+C4jT7@devgpu015.cco6.facebook.com>
 <20251016160138.374c8cfb@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251016160138.374c8cfb@shazbot.org>
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMSBTYWx0ZWRfX4uIPdvLkJyru
 kzVzFeSj6zAri/p14Fqu2jGiCsSxAxY5UC0limb3iSh/RUplMeypXO4MWjuGNBy7pMB8DA8Qb0a
 54is3K2ZzRMVeEmGnDiqUK3m+urL2xwHakzuw/3oj5GOZxcu5GihJYil/A4lAEaS4fe4SwFubJn
 CiRH6RAB/Iiyy8HncE/IgeqIOB+kbJ07OaTA/Bm04QrLwafwZ4eF3IsgcoWddccS9wrD1+WIFi2
 5aldg4lU+MAUygPO5GXHIr3kaAAmUdMQQRSna+gk4euVzZ4GWcU9fEPmcAHEJkfELIeftW6zWb8
 jwAr6vhKA/IQ0idNUjQBwQ2roNm/VbVar1acM/f3Pmfh51PVnZ0skz9ATMVpT82hFlwoX7zC/qK
 qpInIiuOtNtBd+sjCR7XxrWL7/7uBg==
X-Proofpoint-GUID: GxsBfqQacT0QfWRaUYZILxcQv3b4PF_N
X-Authority-Analysis: v=2.4 cv=Wokm8Nfv c=1 sm=1 tr=0 ts=68f26ef1 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yjjgb6GWclcem6OkC4IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: GxsBfqQacT0QfWRaUYZILxcQv3b4PF_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01

On Thu, Oct 16, 2025 at 04:01:38PM -0600, Alex Williamson wrote:
> The legacy vfio container represents a single IOMMU context, which is
> typically managed by a single domain.  The replay comes into play when
> groups are under IOMMUs with different properties that prevent us from
> re-using the domain.  The case that most comes to mind for this is
> Intel platforms with integrated graphics where there's a separate IOMMU
> for the GPU, which iirc has different coherency settings.

Thanks, this context is helpful and makes sense.

> That mechanism for triggering replay requires a specific hardware
> configuration, but we can easily trigger it through code
> instrumentation, ex:
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5167bec14e36..2cb19ddbb524 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2368,7 +2368,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>                     d->enforce_cache_coherency ==
>                             domain->enforce_cache_coherency) {
>                         iommu_detach_group(domain->domain, group->iommu_group);
> -                       if (!iommu_attach_group(d->domain,
> +                       if (0 && !iommu_attach_group(d->domain,
>                                                 group->iommu_group)) {
>                                 list_add(&group->next, &d->group_list);
>                                 iommu_domain_free(domain->domain);
> 
> We might consider whether it's useful for testing purposes to expose a
> mechanism to toggle this.  For a unit test, if we create a container,
> add a group, and build up some suspect mappings, if we then add another
> group to the container with the above bypass we should trigger the
> replay.

Thanks for the tip. I did this, and validated via bpftrace-ing iommu_map that
the container's mappings (one of which lies at the end of address space) are
replayed correctly. Without the fix, the loop body

while (iova < dma->iova + dma->size) { ... iommu_map() ... }

would never be entered for the end of address space mapping due to

dma->iova + dma->size == 0

$ sudo bpftrace -e 'kprobe:iommu_map { printf("pid=%d comm=%s domain=%p iova=%p paddr=%p size=%p prot=%p gfp=%p\n", pid, comm, (void*)arg0, (void*)arg1, (void*)arg2, (void*)arg3, (void*)arg4, (void*)arg5); }'
Attached 1 probe
# original mappings
pid=616477 comm=test_dma_map_un domain=0xff11012805dac210 iova=0x10000000000 paddr=0x12ecfdd0000 size=0x1000 prot=0x7 gfp=0x400cc0
pid=616477 comm=test_dma_map_un domain=0xff11012805dac210 iova=0x10000001000 paddr=0x12ecfdd0000 size=0x1000 prot=0x7 gfp=0x400cc0
pid=616477 comm=test_dma_map_un domain=0xff11012805dac210 iova=0xfffffffffffff000 paddr=0x12ecfdd0000 size=0x1000 prot=0x7 gfp=0x400cc0
# replayed mapping
pid=616477 comm=test_dma_map_un domain=0xff11012805dab610 iova=0x10000000000 paddr=0x12ecfdd0000 size=0x1000 prot=0x7 gfp=0x400cc0
pid=616477 comm=test_dma_map_un domain=0xff11012805dab610 iova=0x10000001000 paddr=0x12ecfdd0000 size=0x1000 prot=0x7 gfp=0x400cc0
pid=616477 comm=test_dma_map_un domain=0xff11012805dab610 iova=0xfffffffffffff000 paddr=0x12ecfdd0000 size=0x1000 prot=0x7 gfp=0x400cc0

> In general though the replay shouldn't have a mechanism to trigger
> overflows, we're simply iterating the current set of mappings that have
> already been validated and applying them to a new domain.

Agree. Overflow means that some other invariant has broken, and nonsensical
vfio_dma have infiltrated iommu->dma_list. The combination of iommu->lock
serialization + overflow checks elsewhere should have prevented that.

> In any case, we can all take a second look at the changes there.
Thanks!

Alex

