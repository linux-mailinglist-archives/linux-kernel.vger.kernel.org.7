Return-Path: <linux-kernel+bounces-854249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D967EBDDEA1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E05C3E3AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E238131B81E;
	Wed, 15 Oct 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h/duVX+7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4531BC88
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522872; cv=none; b=c0zagxnFr3v30X/DrYD25CHBu1hczXFjoCzRvto8631feKnEqC71bus6UNi1FtS0cfEdQoMDNWpktHTGikF+xEDq16uAvvxywE8Tdz1T1wcd9+gI6RGNm2hJlM+BDrqoHXcstm9EZJKjGQu2ihjpVAmmG5lChMX0bG5Qxl87qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522872; c=relaxed/simple;
	bh=AyERBfq+RQvAoN1T4iTzBY9LK80j7jh40Ick5el4NFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AroxnlNV2LscJEL36POwiDfHPDaztIJeh0AymV5OGrpSWBPfR+52X21YoWMmZp7NZvrs7ajFudCYynIiBPMEZ5Pr3vgeQBUVdI5TeA3SSkZuO74HopYnpZtsm0iVh6g4ts65kxzaFjjwrLHG+EG/Z5WDipvQIZ7brEKDL6aNByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h/duVX+7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s8Su004423
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Plo72r9vuYhq4837E+ASzQQ2
	vnfrofTlUlT0CX2gzYU=; b=h/duVX+7IQp+5tGiv//K47kPEZI6Sd+OSPcI2CLa
	9bT52LvhylH+y/nrtLRNw7kR+bEr6GrNI1yRfEMNWOWQZXnA3vmeD7VABIBDPqYa
	yAsgZHcWcyUZkRdToQDtaEQW/gfMqxJfPpUX+HnicxRctVxLf4o8mCUUHQDYtsnC
	SkG9P7Q+Bia6h3m6pMddEZi5kiGo9QCmQ/tst0oFwKu3On+k82nGHtk8UpK52xQf
	ABYdzboo2MR6C47R2YOlKhmbCEc70AnSCebok9N5RzwyMT5tnO8I3Fix2NjSmJud
	fNJG9JCUGmU4MiSkEQ7kuUS8j0bh6xExyi2H1bJYfqqRLg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1aga72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:07:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-818bf399f8aso398736866d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760522867; x=1761127667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Plo72r9vuYhq4837E+ASzQQ2vnfrofTlUlT0CX2gzYU=;
        b=oofN/V7nKHccKFR0rbZbfrCAMj6ZSc2UYTdWGxvxezF3e/FZI+QT/AT7JVnWRaYNz0
         dEvWWkwa+wDRUufmt0wGR72pn4C7wPARalKWPZwZ2oYHAnbXI8FktklcwHjga0NviYlz
         mY3OobOG6FxTY+kcwmUKzN2USeRiZmn9h1XcDwGcb7vkyCSGAu6mZn6l6gIl31EyIZ5l
         1xKNvxF6Wu1cqzOvismv3x8SO5QTUB7bivm3z4Rl4IdtfPs8aoYdWemYil5Dc20HzQTc
         bg1Xfv/ZeOFdRDFW8Gwcltxkn8cSZHLr5pcaOZ7U3ONBzFkz1LG+/CqM3bDxDakZEW2r
         CKSw==
X-Forwarded-Encrypted: i=1; AJvYcCUr9x8HK20bhB+y/wwjJYgpQsSwDY5Ihs3Niltrcar/nPsWaj2xoOFuztprF28SJiDRBQELq5SaLYFVuq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfHiILGVQyRb387gneJz5phQzQIs6LkdqvJ4671tVibrNmhgm
	/eKZ8GWTVLxKQLMqlvDzN/A7JQ78Vg4xqtV5rbm1ivw5MSllPQ/jDp4V/Q4d9P6rni1kiys1IEa
	4sWVWevZLCA3pEMh/FSOA8r/NeFV+ROok12cSJVSdLJEm8T4BPlO3KhBqYcE28IxKQ543kg+HR8
	c=
X-Gm-Gg: ASbGncsk+TzQ04yS50k3MSxNLBmgEhgT5/awTaAejtGucA6P3OsHFjFvm/pJYRCInoy
	JkNdX1oNslnAwaYz9bRCHgaiDj6xbjUxqZ9miPXGhV/+iifwbM9F4A/Qzawc5QZu3FHPAQCIPDN
	U2aarh1lMW1YT9T/s1QPkywPOQBxbGA54AJFTfmkA2bXu41ELDEA5vDqEvsGHCY/zxgh2AxYRic
	+pUUgkcUmKBJwNjLLapKtniHUhK/3Odc9fc/YNc9aOdfYamSMvMbk9OCK2ZSK5c8EtIARjsz3/n
	FBVqvT/uj+QXvu1p71msDpF3KiR6+392aAUgMxTt+FaFzkK2Sdj639rWdxf/8XCrwC7Xf+cq/i/
	rZ0F0UKgRKp3ZxJ6iyTTwu5XVQMxdWCijG0KRDHpilLEYObwxC+If
X-Received: by 2002:a05:622a:5592:b0:4df:6583:a5c3 with SMTP id d75a77b69052e-4e6eacfad65mr397959631cf.31.1760522866698;
        Wed, 15 Oct 2025 03:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG720qHgaxVVn/tMDskc+Fb5CVEdJRkO+FFfXZC4YdLvxqG8hCwJFnA1hXqIvZ1BHwzYpNiuw==
X-Received: by 2002:a05:622a:5592:b0:4df:6583:a5c3 with SMTP id d75a77b69052e-4e6eacfad65mr397959141cf.31.1760522866163;
        Wed, 15 Oct 2025 03:07:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590885784e7sm6098047e87.111.2025.10.15.03.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:07:45 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:07:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
Cc: kpallavi@qti.qualcomm.com, srini@kernel.org, amahesh@qti.qualcomm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, jingyi.wang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, ktadakam@qti.qualcomm.com
Subject: Re: [PATCH v2 1/3] misc: fastrpc: Rename phys to dma_addr for clarity
Message-ID: <svekpvatqpymzxprc5n2tlndqlwze3tj6kr3bzszjnoay7oulk@zslcxpsyuzdo>
References: <20251015045702.3022060-1-kumari.pallavi@oss.qualcomm.com>
 <20251015045702.3022060-2-kumari.pallavi@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015045702.3022060-2-kumari.pallavi@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ef7274 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ieKUWAqLYShgQCTD6ZgA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: SLLojBfhH3g4B9C4DB15kuY9ZiuqdnX5
X-Proofpoint-ORIG-GUID: SLLojBfhH3g4B9C4DB15kuY9ZiuqdnX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX+e+q7vjbtwuG
 KNDO+vjfDmTSjEkQRl5neOx3xaOqyAQlWnP8gtloG0XuDVPVJuDBn5XC1v8ETZ8byzwpn7t0Asc
 ZDBW6orJCZk9urIRtXpLnAcDgnnLc+8IrhkBuA5y8gu7GAOg7sgkvNTD6mATCETPo7ca3r6nzG6
 GkN3+z47eHWxgiyQpWwFy1PZb83LSdYGdOrdo/h5dBkec2EFFbpXZILeYFlO4ased0tYU8nyoxa
 Op/vfnLjHLgN8YG4MJsm3II37DNNahwFCDKtV+koGypEzTWwwcltqIpEzoqXW7nfhgVJZAGbA72
 40fd1MIHwEEpkyR5+7qdaInUpdLoJgjt3gIAWbxVyg0lo4vgcrTixT4Zaf0gdQj7x8BtfL5cgYV
 l8TzlIixm8nP0C83/B2CfIN5NiOpgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

On Wed, Oct 15, 2025 at 10:27:00AM +0530, Kumari Pallavi wrote:
> Update all references of buf->phys and map->phys to buf->dma_addr and
> map->dma_addr to accurately represent that these fields store DMA
> addresses, not physical addresses. This change improves code clarity
> and aligns with kernel conventions for dma_addr_t usage.
> 
> Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 68 +++++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 621bce7e101c..975be54a2491 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -194,7 +194,7 @@ struct fastrpc_buf {
>  	struct dma_buf *dmabuf;
>  	struct device *dev;
>  	void *virt;
> -	u64 phys;
> +	u64 dma_addr;

If it is dma_addr, why isn't it dma_addr_t?


>  	u64 size;
>  	/* Lock for dma buf attachments */
>  	struct mutex lock;
> @@ -217,7 +217,7 @@ struct fastrpc_map {
>  	struct dma_buf *buf;
>  	struct sg_table *table;
>  	struct dma_buf_attachment *attach;
> -	u64 phys;
> +	u64 dma_addr;

And this one.

>  	u64 size;
>  	void *va;
>  	u64 len;
> @@ -406,12 +406,12 @@ static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
>  
>  	buf->fl = fl;
>  	buf->virt = NULL;
> -	buf->phys = 0;
> +	buf->dma_addr = 0;
>  	buf->size = size;
>  	buf->dev = dev;
>  	buf->raddr = 0;
>  
> -	buf->virt = dma_alloc_coherent(dev, buf->size, (dma_addr_t *)&buf->phys,
> +	buf->virt = dma_alloc_coherent(dev, buf->size, (dma_addr_t *)&buf->dma_addr,
>  				       GFP_KERNEL);

If it was dma_addr_t, you wouldn't have had to typecast here.

>  	if (!buf->virt) {
>  		mutex_destroy(&buf->lock);
> @@ -437,7 +437,7 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
>  	buf = *obuf;
>  
>  	if (fl->sctx && fl->sctx->sid)
> -		buf->phys += ((u64)fl->sctx->sid << 32);
> +		buf->dma_addr += ((u64)fl->sctx->sid << 32);
>  
>  	return 0;
>  }
> @@ -682,7 +682,7 @@ static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
>  		return -ENOMEM;
>  
>  	ret = dma_get_sgtable(buffer->dev, &a->sgt, buffer->virt,
> -			      FASTRPC_PHYS(buffer->phys), buffer->size);
> +			      FASTRPC_PHYS(buffer->dma_addr), buffer->size);

FASTRPC_PHYS trunates addr to 32 bits. Is it expected? Is it a DMA
address on the  Linux or on the DSP side?

>  	if (ret < 0) {
>  		dev_err(buffer->dev, "failed to get scatterlist from DMA API\n");
>  		kfree(a);

-- 
With best wishes
Dmitry

