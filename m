Return-Path: <linux-kernel+bounces-844849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52418BC2E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E1DF4E3B20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669213C914;
	Tue,  7 Oct 2025 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="cF90nOlO"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300125743D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877872; cv=none; b=HLE8/g8vRs/F5FuA5UBB6SJCdpOaN/I3PvP4rb9GaHB+qe9NXPD4woCbwmlmonJdUwrOH33grgenvJxt2fnWZJaw5jH88gMBx8dlGd/Qc5CJ18K0myPrvz55OO/a/kG+ZGDMZQWwwgXlZ7aTKKcrGHZWOjF3k3zVcYhJa7xzZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877872; c=relaxed/simple;
	bh=SR8qr+wxtjyRLMX7Em39GgI/MO+IBcVlx0Qiq/NyLpw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWTm4lYxCcGDga4U0qbVZ7FZMG1Ovk8eAzMLRnT3yez+bvpWM966m+2bbM7Odf7lMK+GV/C5POa55mE1VZfdIvDI6U8PUCUoERGXvCNxyrp0APOxOp6Z/mxu2v/zzC9J5t4U7hlDZIbiSroc9i/76ykoUA0PjU/raw3CCC6XkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=cF90nOlO; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 597Kcwdp671039
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 15:57:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=7RHtWEkPU0TOzxngsLf0
	fxonGEHdvNwEyI5ReCzGuU4=; b=cF90nOlO5cP6sX262yHUp8YWI8/ufRg1FHGO
	6iMhnnonRb9nJCCzmtaOh+vbdJ7NdFKzWMOorrgYMJ54q1lvaNfp207oOg55KnPs
	+5CXbPe1E9CyDyRUBXZcETH67da2BZMUBHoFbPwEye2J0qvzqE3e77NqBXrFPiQs
	v/h2KRu3hIs0NrfnpxxDaMm2C1AuP5T8DV4yYbGuizfFmq9L2VtUg4AX8V1BGh+E
	Sis4DYX/gIddKLpMwtVlooR0rpUeGchxuf3/y1hKgQexlRJqqe7Burmq7dVdpKcR
	r4+5VIXLxTyNhtQLUCSrbgkLTltpBv6EVlEYr28xDnES7DUpOg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49n51dbvtg-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:57:49 -0700 (PDT)
Received: from twshared23637.05.prn5.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 7 Oct 2025 22:57:48 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id E1AC5D057B9; Tue,  7 Oct 2025 15:57:47 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:57:47 -0700
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio: fix VFIO_IOMMU_UNMAP_DMA when end of range would
 overflow u64
Message-ID: <aOWa6yD0oyQSgFTW@devgpu015.cco6.facebook.com>
References: <20251005-fix-unmap-v1-1-6687732ed44e@fb.com>
 <20251006121618.GA3365647@ziepe.ca>
 <aOPuU0O6PlOjd/Xs@devgpu015.cco6.facebook.com>
 <20251006225039.GA3441843@ziepe.ca>
 <aORhMMOU5p3j69ld@devgpu015.cco6.facebook.com>
 <68e18f2c-79ad-45ec-99b9-99ff68ba5438@oracle.com>
 <aOSWA46X1XsH7pwP@devgpu015.cco6.facebook.com>
 <20251007144328.186fc0d2.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251007144328.186fc0d2.alex.williamson@redhat.com>
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=T+aBjvKQ c=1 sm=1 tr=0 ts=68e59aed cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=-tBlBomLHWHVkNyEUrkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: zrXrftXUHmooyZmr0oglIHuDFQRgg6xH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE3NiBTYWx0ZWRfX42wYwv8r76cS
 PnBKS7gucId8DrKbJYxkCIzNhfeZwynO6JpMbzLskxDTiMzFLTE9PU6NwhAV6jmJDx4q9AhC3pW
 LlwR3G6cDIfluULiVD3G+Ne04fv+9qmiHDqo9DVbDl9TbU2wn1RqJ1TLJWjIB+YVsAZWHEHyBWA
 Pi5m0KL66iWUbtmYK7zk7Y9IFS0MLv/idRLRemfwpU7enxka9Ka07GDaQTrSCepL/Lw4ZP/74c/
 qHE/rnTxo+3hvPQ/gtZRiY+KNOF4rvkx6zwGntqGGvqSRzhWRnMOekBiKTD2y442ioiv/taKunb
 PRPeEpvOMYzW7DMqmspPZvDPBlwnRkc8LGgrzZnGoOpXM9ZH++xsbDWMSZ3Kvb7mBMqh307xEKm
 eAQWTMty+un/2JGe253h6JFN1jIzIw==
X-Proofpoint-ORIG-GUID: zrXrftXUHmooyZmr0oglIHuDFQRgg6xH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01

On Tue, Oct 07, 2025 at 02:43:28PM -0600, Alex Williamson wrote:
> I prefer this approach, thanks for tackling it.  Consider splitting
> into a few patches for easier review, ex. discrete input sanitizing with
> proper overflow checking, refactoring the fast/slow handlers to
> increment iova in the caller, remainder to tie it all together.  A few
> comments inline below. 

Alright -- I'll try to stage incrementally. The proposed sequencing sgtm.

> > +	u64 end, to_pin;
> 
> end looks like a dma_addr_t and to_pin ought to be a size_t, right?
> Maybe iova_end and iova_size?

Yes, I think I've been sloppy with the types. Am too 64-bit oriented.

> > -	if (!iommu || !pages)
> > +	if (!iommu || !pages || npage < 0)
> >  		return -EINVAL;
> >  
> >  	/* Supported for v2 version only */
> >  	if (!iommu->v2)
> >  		return -EACCES;
> >  
> > +	if (npage == 0)
> > +		return 0;
> > +
> > +	if (check_mul_overflow(npage, PAGE_SIZE, &to_pin))
> > +		return -EINVAL;
> > +
> > +	if (check_add_overflow(user_iova, to_pin - 1, &end))
> > +		return -EINVAL;
> > +
> 
> Why not the same checks on vfio_iommu_type1_unpin_pages()?

Will see if there's opportunity to stay more consistent.

> >  				if (WARN_ON(!phys)) {
> > -					iova += PAGE_SIZE;
> > +					pos += PAGE_SIZE;
> >  					continue;
> >  				}
> >  
> > +
> 
> Extra white space

Ack.

> >  				size = PAGE_SIZE;
> >  				p = phys + size;
> >  				i = iova + size;
> > -				while (i < dma->iova + dma->size &&
> > +				while (size + pos < dma->size &&
> >  				       p == iommu_iova_to_phys(d->domain, i)) {
> >  					size += PAGE_SIZE;
> >  					p += PAGE_SIZE;
> 
> I think the else branch after this has some use cases too, (iova -
> dma->iova) just becomes 'pos' in calculating vaddr, 'n' should be
> calculated as (dma->size - pos).

Missed this simplification - thanks.

> > +		u64 end;
> 
> Seems like a dma_addr_t.  range_end?  Thanks,

Ack

