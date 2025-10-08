Return-Path: <linux-kernel+bounces-846016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A5BC6C98
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 00:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9916140510F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB512C1586;
	Wed,  8 Oct 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="q365JHcc"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1612C08BE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759961964; cv=none; b=ewI+1fyNApkiD/NHLKsPFpe4/sYiKxKDjsSNOZ9IFXNfhyuiecR2XYg+2rhGZa4pYaJjRijIphYuQhacu2HdcekmDPUdZo3Utay7g7VuYD6/qdboAxyGFDfXrGvsxCPu32bfo1+pMLGqskc2/B7TywGlrXsnEwy92cmXs12W70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759961964; c=relaxed/simple;
	bh=fAXEPOHO3trn1E7hD2zLSIJkO7XCLU68Qn77QDPBzf4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAHvirvSpuU6FBwjN1foWoMm7lJE8l/RIEpEVNpq8F8IVCAlonZHPqCq7P2Wuxl7MHzzuWelHRosJ6ERaznnwLKDs16E2g0+/yzofR0eQ4/k8uMoInbOkFOIql9iXvlDKn23lucEFbvr2rQzEbWwungSCslS1Ag1E7mWEZxAAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=q365JHcc; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 598JMgB2357244
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 15:19:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=3GhOqpM/QtZCc3tuQWKH
	9wChozUtewv02QyeR0fwG14=; b=q365JHccixGucn8f0v/QbWUHALSpu0E82Khb
	MSnWmwHVKx4YBprmIVd/UJS1rzF2KLi0oIz5uAP/Zq7RUcYntnkriYg6KfyIXzuU
	1LCFGqvgmznXHbtwQJCSAfA883JyEFJo0Asp10Syj7jA8cWE9u4RmnlQnQWpuI5d
	WezZ5s7FXsm9RAIeOk+lbSFUjJtCMZ3sHGUhPwRkXyfi6h6b0BnygaTdfWn9vRzI
	gCEDf1aclY6uIYvuGAFpTIRucpbovVZmmUXVjv/oJWxg+ob8EvSW7SBuXHaJtcSb
	HOi8Uv4g6y6MFOhNXEU/95OriVAGa3i7F61gITp0VD01uD9EQQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49nx2f9gu0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 15:19:22 -0700 (PDT)
Received: from twshared23637.05.prn5.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 8 Oct 2025 22:19:20 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id 73586DAA86E; Wed,  8 Oct 2025 15:19:07 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:19:07 -0700
From: Alex Mastro <amastro@fb.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] vfio/type1: sanitize for overflow using
 check_*_overflow
Message-ID: <aObjW9VxYMkFQ1KB@devgpu015.cco6.facebook.com>
References: <20251007-fix-unmap-v2-0-759bceb9792e@fb.com>
 <20251007-fix-unmap-v2-1-759bceb9792e@fb.com>
 <20251008121930.GA3734646@ziepe.ca>
 <aOaFqZ5cPgeRyoNS@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aOaFqZ5cPgeRyoNS@devgpu015.cco6.facebook.com>
X-FB-Internal: Safe
X-Proofpoint-GUID: DT9UoIKw8iO-QVuEaoGbrgAfna-kK5F7
X-Authority-Analysis: v=2.4 cv=WuYm8Nfv c=1 sm=1 tr=0 ts=68e6e36a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=JNmNDusZ2E8XnTGOuJUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: DT9UoIKw8iO-QVuEaoGbrgAfna-kK5F7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDE1NiBTYWx0ZWRfX94A3VD5kuD+D
 N4UtqrZi9OINdAMmiAG0FJVDM38r6vZlsbpOnpis9PAn7dnWg1jrzH5BVfgskBkEe1bqNc4EOj8
 2OFhrboM8s1pBpTC65H37X0xW+uwww2q3RjvbMHlcC8spF7x0pAA6Iyvq53iaJeJg0pcDDuomFE
 iQiF7+/3/C+S3MFJqAXinZcUR3yg7EqIlFH0yHUqp5SeTURFddIcP9M4tQJ/edMm3Y4E//yMiev
 sP5fuu21WNa3x/yHnS32KhGHtmETrvsPuOt6v4mCKD8uH6vxyNWogltWJFr/yR1LDJKd/saXfL7
 B/aNUx1IUxAdKhLAbzElyktKpmGdPtcGAP9ZsfGrSRrQdUnZVwP3UithR2uzHI2tsE6TiUJPPsb
 uxV+F8ljsKlVXMe53XPEou7ERq5fiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_07,2025-10-06_01,2025-03-28_01

On Wed, Oct 08, 2025 at 08:39:21AM -0700, Alex Mastro wrote:
> On Wed, Oct 08, 2025 at 09:19:30AM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 07, 2025 at 09:08:46PM -0700, Alex Mastro wrote:
> > > +	if (check_add_overflow(user_iova, iova_size - 1, &iova_end))
> > > +		return -EINVAL;
> > 
> > Let's be consistent with iommufd/etc, 'end' is start+size 'last' is start+size-1
> > 
> > Otherwise it is super confusing :(
> 
> 
> Both suggestions SGTM.

I'm not sure about the latter anymore. There's somewhat pervasive precedent for
using 'end' as the inclusive limit in vfio_iommu_type1.c. I am all for making
things less confusing. I don't think I can introduce 'end' 'last' convention
without preparing the existing code first.

Thoughts? Spend another commit renaming this to 'last'? Tolerate inconsistency
between vfio and iommufd?

116  struct vfio_iova {
117          struct list_head        list;
118          dma_addr_t              start;
119          dma_addr_t              end;
120  };
...
2037                  end = resv->start + resv->length - 1;
2038
2039                  list_for_each_entry_safe(n, next, iova, list) {
2040                          int ret = 0;
2041
2042                          /* No overlap */
2043                          if (start > n->end || end < n->start)
2044                                  continue;
...
2052                          if (start > n->start)
2053                                  ret = vfio_iommu_iova_insert(&n->list, n->start,
2054                                                               start - 1);
2055                          if (!ret && end < n->end)
2056                                  ret = vfio_iommu_iova_insert(&n->list, end + 1,
2057                                                               n->end);

