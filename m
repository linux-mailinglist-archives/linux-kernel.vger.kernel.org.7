Return-Path: <linux-kernel+bounces-843624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D457EBBFDBB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38DB189BE41
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6221D6DB6;
	Tue,  7 Oct 2025 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="4mY+aOVE"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE661A9FB8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797573; cv=none; b=sVX7qpd2Rw0K9dc7Lm1FDP/7UaNEKbymfo6Tu5NKsm3rSAA2TZjRP90MH4VhsVbJE4yz2TzbL0ZhGxoTgAxdx1ODMm+CClsN7/tL43adQc9IXKG2RSPrnKTqGdPhdIzCq60P+Bc9k3gEJPou47mmQYG68lhhI3gkmxtML27K5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797573; c=relaxed/simple;
	bh=kO3ODXqs9k7pwqkR/guQ/caM0qB7jAeOF091Dd7wRU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guzymn2QE0208yYsbRdKE8z10X2ct6H12aZ2PZ88wTclrA/kAM0wdkumhF+ShvX7oOEC0g7sFAmTA0MJwBPXtRyXXWXhrQ/3ffetWxEMlFE/1/qaUrLYdPi+GgeGjkeOwyq99q880gWc8Axt1pO7/6FGxsVCYA9vln5MN8PPth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=4mY+aOVE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 596NraQL3885881
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 17:39:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=kO3ODXqs9k7pwqkR/guQ
	/caM0qB7jAeOF091Dd7wRU0=; b=4mY+aOVEe29vUt114OipFP8JGFE5URGXBbpB
	cBAEjpOlVtLyJeu0Wn3NMoZUD5kykJulae3rDQQ69YT0HO480lMJt0k1AicQw9mq
	qrg4NLGx3SewBINxQKLClclARbRTy+chEYrumWLDjUh3STpX/hmt8xrhNP4143bD
	DEaqmNoGMkwvhpPMYiw8h5TrCwqxX7bOBE4KlzPx9maSZrWazrDjoA6rmFIAAWn7
	iF9aNrZZE9CqS/rkcE7IXs1Wm1pMynGUsXhl9qp0Z/9V5efHZyl5FmrfGnP9Ehsr
	kPuAxd+j87toHRzdio291pGeV0Zj9yMU/D5XZLqw7O/I68/7SQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49mjnf2vc7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:39:30 -0700 (PDT)
Received: from twshared18070.28.prn2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 7 Oct 2025 00:39:28 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id 5602EC4B352; Mon,  6 Oct 2025 17:39:12 -0700 (PDT)
Date: Mon, 6 Oct 2025 17:39:12 -0700
From: Alex Mastro <amastro@fb.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Alex Williamson <alex.williamson@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio: fix VFIO_IOMMU_UNMAP_DMA when end of range would
 overflow u64
Message-ID: <aORhMMOU5p3j69ld@devgpu015.cco6.facebook.com>
References: <20251005-fix-unmap-v1-1-6687732ed44e@fb.com>
 <20251006121618.GA3365647@ziepe.ca>
 <aOPuU0O6PlOjd/Xs@devgpu015.cco6.facebook.com>
 <20251006225039.GA3441843@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006225039.GA3441843@ziepe.ca>
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDAwMyBTYWx0ZWRfX85yYjgHOk2l8
 W2TdfDrMflRQLjcaXmPjL1JaKIb2t0sTfIEwcayJtMuJNCWQ281o5KXF5imHJD+3HGEilVr07rK
 rMbELz0D50EKre9WI2aAPczIXDWEqh9FY+NM+pLft1YqA/vQYK5JhYdXG/VnDLqcI6Kgzf/XPh7
 VuWY5dnU2+t39cOr3sICKSGI66VjbnY2rg19ugHJyGqLEZHSneZvtaiTdGzsvnyc4Kx4RYh19VB
 HFKFeHcAVg53w9aB6zr+067c5qKf6LgO80owjNab7SkQpG7sWG/d8Ux0zp9lT5cQ/xFRUOXkmcN
 9/cU330xmfE+TpyVCJ1x4qTr1lPMqQ/2fVs1I8UHrYoB3lz2Q7UGLDSZovEclyjzuY1Xm9v+Eo4
 1erRbM+tsrXJ5+6a6cm8Gxxm9+o0Sw==
X-Proofpoint-GUID: 0rgpzfj6Mz8_SpM81WynU_eyF5vB950c
X-Authority-Analysis: v=2.4 cv=Zo3g6t7G c=1 sm=1 tr=0 ts=68e46142 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=cnzby_Kikf3u7RrYEdwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0rgpzfj6Mz8_SpM81WynU_eyF5vB950c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01

On Mon, Oct 06, 2025 at 07:50:39PM -0300, Jason Gunthorpe wrote:
> Could we block right at the ioctl inputs that end at ULONG_MAX? Maybe
> that is a good enough fix?

That would be a simpler, and perhaps less risky fix than surgically fixing every
affected place.

If we were to do that, I think VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE should
report coherent limits -- i.e. it should "lie" and say the last page (or
whatever) of u64 addressable space is inaccessible so that the UAPI is coherent
with itself. It should be legal to map/unmap iova ranges up to the limits it
claims to support.

I have doubts that anyone actually relies on MAP_DMA-ing such
end-of-u64-mappings in practice, so perhaps it's OK?

