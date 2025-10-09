Return-Path: <linux-kernel+bounces-846086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7A4BC7001
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 02:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5ACF334CD92
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 00:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C817165F16;
	Thu,  9 Oct 2025 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="ymJEhBwg"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80833D8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759969537; cv=none; b=aacfEDsQmpV2bqDdBNqsRJ8Bk7Nv4viP/Z1LY+1L6K3PoOkDeM5fL44v7kyDOMTK95erxFmrrbYUi2ElhcYMgxav+abKEm8/od0Q6GLzMRd2GWKShcijAqynWqtKiP5KD9Rc/q5P52S4/l2HQijNngg8BFuFjlnsX1leo5KqNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759969537; c=relaxed/simple;
	bh=PcaR3ijNAGMyV1U/9vsbgZvxsZcIAbjvyWUQoBaddVU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L40cLUVJVeGO5xb+Lm8SfdYOhLlzJpwJtgOyJrUeo6Ynhn26ko+kEMHADJyznvvKIhGLUUGEY406tqsqD+S+yP2pRzlgusdbz0fXbzN/5zqi0zt7EDhkXrXdFQwvO4EWyEDha7/qVNMRKpWBw3ywY2Ty8iO/Fsaw5ATND/diQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=ymJEhBwg; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 598JMwJK1765614
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 17:25:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=7qHq98nLKQJlzb7f7C1C
	JcnNw/asTQ5NX1VF4pE3/i4=; b=ymJEhBwg5sfAZzur7mQKTXVFpanSPm/yRvhp
	rQ5ieQOwuisp/uS+lExM6ZRdx/SbWPqzu3TzZedsIAJyBnymcfnAXuJBthOi0q4Z
	qz4r9jExkXowB2GIFxXqku2k1qlSioBW4lFfJM4yazHWafRKztEm76eLveGD/o6M
	6OjJy26eJodEHiveprwfIKIOhOyVcMoQScvaC9kHBzGuAZHPKrw9dCbQKLuYd+QC
	zJQOAv6/SE4L0uQ1145SwfLXssxIifG3yQnFWn+YZIz6k/PfBiRaHU6NkRh/DmcE
	0E+OYzHVdkdB3AplfEpMzeA6JSnRL1ddOxq+cVKJe7P9qEfy3g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49nx2kj7tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 17:25:35 -0700 (PDT)
Received: from twshared18070.28.prn2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 9 Oct 2025 00:25:34 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id 9DDD1DBEADF; Wed,  8 Oct 2025 17:25:20 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:25:20 -0700
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] vfio/type1: handle DMA map/unmap up to the
 addressable limit
Message-ID: <aOcA8LhIoWZPNOA5@devgpu015.cco6.facebook.com>
References: <20251007-fix-unmap-v2-0-759bceb9792e@fb.com>
 <20251007-fix-unmap-v2-3-759bceb9792e@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251007-fix-unmap-v2-3-759bceb9792e@fb.com>
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: TGme5PG_BiSGc1OAUA9HHo--NkuYT1zN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDAwMSBTYWx0ZWRfX5BzkB6JhBNmY
 QMRjEH/geNmonHrkWTFobfnozlJAeey3nQvoQLZ7iI/Z0o0eGC79tjomL+FIZCIXgCIpqVf3eUU
 aZcsmxOfX9DWVWI7mhKCgMvjLE0wAs4ig0whdp+vw3fidlsizv/+dnwtsLfynYSTb3iTnRG/lYX
 gL3bTZibbNIRmFCaG/YB7gt3VdgGGLJ0fS+nve253sr2nUbh5fP195qLcdHKLbd62lKWb3/fdzl
 JgRT89WwoiZk6vdrxY4mJWujxPC12EDUDuEdxhHi1kPWixhlyluGbnswe4ysifqGqKNoQIbJXQV
 pNTbYLDL+jfs21nkRma/As18JbLqrP4/fCw8js6yvXXtxgYfgVzXwLK9nhO++gSx8TpDyco7GQo
 xFAao7ETmkExP38b9AJA0zu/vjXdmg==
X-Authority-Analysis: v=2.4 cv=H4LWAuYi c=1 sm=1 tr=0 ts=68e700ff cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=ofdlg-NLLL_6ULEM8BEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: TGme5PG_BiSGc1OAUA9HHo--NkuYT1zN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_08,2025-10-06_01,2025-03-28_01

On Tue, Oct 07, 2025 at 09:08:48PM -0700, Alex Mastro wrote:
> @@ -1401,17 +1409,17 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  		if (dma && dma->iova != iova)
>  			goto unlock;
>  
> -		dma = vfio_find_dma(iommu, iova_end, 0);
> -		if (dma && dma->iova + dma->size != iova + size)
> +		dma = vfio_find_dma(iommu, iova_end, 1);
> +		if (dma && dma->iova + dma->size - 1 != iova_end)
>  			goto unlock;
>  	}
>  
>  	ret = 0;
> -	n = first_n = vfio_find_dma_first_node(iommu, iova, size);
> +	n = first_n = vfio_find_dma_first_node(iommu, iova, iova_end);

I missed updating iova_end to be consistent in the unmap_all case, which is
broken with this change. Currently, iova_end is only assigned by the
check_add_overflow call in the !unmap_all path. Will address in v3.
 

