Return-Path: <linux-kernel+bounces-847318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BFBCA851
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FA61A6641D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5E244677;
	Thu,  9 Oct 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="7Lb7ZzcB"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665744503B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032875; cv=none; b=UfZ56pBLC+ZHnx2XXp6KYfPJB207L4NvHJXsq36qEwPFFdg8PaJlVhOT83ydQl3j3cVpMwM7C4TMa/xC3dfKtXCLXG5Dbz+0G8g6nPmXXhUvOLO8KTdUBMSytLDFkArIXo38+DYy3zfqlUXUJAzyhIqyapqPD/9F8+ILvf6sO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032875; c=relaxed/simple;
	bh=jDQnBOeMR4K8RtmYDOy/mV8HsMl1rd3Xm2GY9wBy+tE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIcmnYenotjvGjC+RF0B+YwsCQzs5SRKmi99Ztu8HzKMY8UDLs6b5xhqDKUW5zFQF84ocNNXy3d7CyNYOpKuMb73u/tjc/Ab3Se58CzMx/E5samb6NCHtxnhMWmVYXqyfbkUZxJj3hCCoMMLfg6v8jKMHqYG/ULIZptCpLirsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=7Lb7ZzcB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 599GkMQ73668321
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 11:01:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=VpMttIoAYwAX5IhyXIDH
	k6ss54satDkALB6F6ybqk6M=; b=7Lb7ZzcBlqoqFtjtfc4sDBu/MBso6s8nZJKi
	wrYyacCQhfrO7fZj0f+P1XbN0IjJncUZg8238Z7pF2oHxGKICQEJlloop0BeqUZ7
	yevJ4M5acBjtsFteuQSgJxqF7t2TKBup5XFUUrBqZgooWJvbqv6ZXMM/YawlBC7F
	JaaLpfmfDRUVNj49gpOkER7fTuXIpfP/6HvbjEUZ6ce+LyvnarPs7CZNDR0XBZVI
	3p5OwvBL3uHpjcaiVPNP/1i5sskNEGQCgy64fWxZUfwnHIreOLHvRc9BUq9FlElT
	XY85qjXBxGLU9+Rl7BoyZEHbHAXmwawskq6FFpYcQAtgsVcyQg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49p9admqyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:01:12 -0700 (PDT)
Received: from twshared18070.28.prn2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 9 Oct 2025 18:01:11 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id D3BF2E3D69D; Thu,  9 Oct 2025 11:01:00 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:01:00 -0700
From: Alex Mastro <amastro@fb.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] vfio/type1: sanitize for overflow using
 check_*_overflow
Message-ID: <aOf4XBo3/mA/7Thx@devgpu015.cco6.facebook.com>
References: <20251007-fix-unmap-v2-0-759bceb9792e@fb.com>
 <20251007-fix-unmap-v2-1-759bceb9792e@fb.com>
 <20251008121930.GA3734646@ziepe.ca>
 <aOaFqZ5cPgeRyoNS@devgpu015.cco6.facebook.com>
 <aObjW9VxYMkFQ1KB@devgpu015.cco6.facebook.com>
 <20251009011535.GB3833649@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251009011535.GB3833649@ziepe.ca>
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=SfT6t/Ru c=1 sm=1 tr=0 ts=68e7f868 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=0YFmlc9dj0qkOJkx9h0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: XkCpVUptcxFItb7tSA6fVt4deyI7O0T5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDEwOSBTYWx0ZWRfX9u8DWEygkqSr
 xfyw/1WlUMHwND0zsHx1ELn057I6Z/7zVGFdWiLiovpf3zhX01I6OM3mHcD0nawNw8fmZb528CF
 tbwCPME4B2D1oTHSTaCoyOa4FE8qQv6aZP57nFfx8WjPqr6h4ZIXjTFV96cBdZ3exBiqiRorC80
 cjDEKEyq4wvktvKjsidNgTdrFNynHFrJ2g5S6HhNqSk/a91xCISr9OqST9L7qCX9utOC+DKsJph
 mRAZvVgSDzF3f7sBg2ghxAmLrY1180Lux32iQ21ObWX3NSYGhEgSpf2s5HydG5srmmXXjpWwtrQ
 3Juxc4Uv8eoDUBSGzM6k6cG8Lw61CSEtSEdna8+KVmX806EGye3PYdHQUqb1A/NOr3IdYEWxdMw
 vXhN5R2YzBe2TK653m8vGB71q3jFfg==
X-Proofpoint-ORIG-GUID: XkCpVUptcxFItb7tSA6fVt4deyI7O0T5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_06,2025-10-06_01,2025-03-28_01

On Wed, Oct 08, 2025 at 10:15:35PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 08, 2025 at 03:19:07PM -0700, Alex Mastro wrote:
> > On Wed, Oct 08, 2025 at 08:39:21AM -0700, Alex Mastro wrote:
> > > On Wed, Oct 08, 2025 at 09:19:30AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Oct 07, 2025 at 09:08:46PM -0700, Alex Mastro wrote:
> > > > > +	if (check_add_overflow(user_iova, iova_size - 1, &iova_end))
> > > > > +		return -EINVAL;
> > > > 
> > > > Let's be consistent with iommufd/etc, 'end' is start+size 'last' is start+size-1
> > > > 
> > > > Otherwise it is super confusing :(
> > > 
> > > 
> > > Both suggestions SGTM.
> > 
> > I'm not sure about the latter anymore. There's somewhat pervasive precedent for
> > using 'end' as the inclusive limit in vfio_iommu_type1.c. I am all for making
> > things less confusing. I don't think I can introduce 'end' 'last' convention
> > without preparing the existing code first.
> > 
> > Thoughts? Spend another commit renaming this to 'last'? Tolerate inconsistency
> > between vfio and iommufd?
> 
> IDK, if it is actually internally consistent and not using end
> interchangably then it is probably Ok to keep doing it. If it is
> already inconsistent then use last for new code and leave the old as
> is?

The only references to 'last' are for elements in a list, tree, unrelated to
iova, and 'end' refers to (iova+size-1) for all cases that I saw.

For the sake of internal consistency, I'll keep 'end', and after this series,
if it's worth it, we can take a pass to unify the terminology between iommufd
and vfio.

