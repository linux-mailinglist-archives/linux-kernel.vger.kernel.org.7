Return-Path: <linux-kernel+bounces-808496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF08B5008A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C68784E313E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF913081A4;
	Tue,  9 Sep 2025 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YXWfFaKk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0E2FDC22
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430099; cv=none; b=gJVWmH1yQpYujcpTJPvTP+gVzPgqNlt3auQornmEb9c+w/Cym6J2681nJ8QcuewXfmay80vUMqfByiAoTwyZd1HIsyhUxXwEqoZ5/poXiyy/pGz7HaVGV8mg25YO+Rja3cPpXLHUaq0NotZvE6wjgtEHbB7/EZnbA/neYWRSuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430099; c=relaxed/simple;
	bh=4LjeH4GNzPac6D3Qy2qp8apPQ0tzCR1kJkThxZ3Q/yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH4Syo0tSi0DndfeE7x4VuO7IZ1eDmCRxVyVn7jNnTTb9aiKmDVaMlB/9oBC++gi3Z+SPtK4OO1YiLO68XgkJA63yIpy4XyDZpQFHvl6QTMK+u2syIhziqe+ykGLnNa2oHSd8FC38IlCZYUTNlGJbXY64bZocmIleq8qgipKqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YXWfFaKk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LVZG029190
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 15:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PGW3tJNZDteIP3YWspfNxoS6
	+2pzYXFb7hKBbebA/DM=; b=YXWfFaKkMC1+j5b1iYb6QUPrqIk7nP6cr8L/UC16
	Cl+bpVKeRzCRGQtXdtvTpP7BVGjRCz4rswD1ScxBqUGkOAevNK3ZsQSkYVEw3296
	odiZJzF1WEuWmus0e7fSEpl2iorE6UbrjKU+fl4Xr4uZcEvNGV65h9xmjchkFE66
	O1o5K/6IDPWh3b19rVk9FPUdmuUOTPFV//LLoI7T7V8quO8SM62kmEbrV25Xjzy1
	LXLq9BUMEsbVwm1avYXcKbWNlNh/gVKGmzhzq/XP2pkDIJQpOFTihbt74QfLXKt8
	7lz7FyxIiL8uhg1gdyCk+eUDBIIMGYpvYJ+VpACymMbxZw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8gmen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:01:36 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-53b17394ddaso2417188e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430096; x=1758034896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGW3tJNZDteIP3YWspfNxoS6+2pzYXFb7hKBbebA/DM=;
        b=AlQfZONO0nouJzdZ0vg/BzGHfN13DOr914ygReiZrCWLB9dDERUmY8LByCK+hvg6UV
         ktsWc3nz1hYuCHvECgSDdVL8+Qo61e8U43sTi7ZlEqpbQb0KR2HANhrGRz5aACJwxCVT
         i7mp/1WOKwQffG127Y7tG+UFT2utymBML19BpXSJZeU1ecB+xSqEo/UAgg7bl4J9Z6lV
         FoLCIEPLwCZgTHBdTyoXsztz2DSKh/R7XInJS31coFmqTsVClo/MyS45VjjW8EO3pkiz
         CGwQSHngmOFmF5HukdG/GyQZfNVsXHknCbQoVrG8c6G5UPv4mJ9VgEQCSkmXOyfzcui5
         V5gA==
X-Forwarded-Encrypted: i=1; AJvYcCUOiC/fyxDuUYSLB9Pp1NZEs4+4DHDsftpGDO0IEj+hheRv9gqng1uq3CmYWMgZ6St3kVMsfJO/Ml2PLIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGcc4VSa+v90PYXBZt0RPn447Pi9QMQpuak7MnKXMKePc9SM+
	CWp/VoZwo9kKdtMxq6aoWukXsvvRkvm7TMIfoypuNSBKPOlYpJnOo+gnp93tH3OwWNMC6WK0x5B
	TABFV+KnqxQ7LoEORq3nLj0mybEkhZErRH+LX50KfI+IPhMtV8oVkcUcrBFkFe0oCklw=
X-Gm-Gg: ASbGncu9wZRpZWd3ogEOQrcd4ax2L/nemMoIbQ9gYagmVaV6+o9pOcIX0pt8AJmJfep
	smXwgRfXA0zxzKnD8vaVM2EXL/KYSF35AHHnuvtyJVLIae/5/LbNHNPa7RKnCSc0CzlMKDH+q9X
	bXf++PfgUxq8gywXLH7yQJf/9VePKUkgUk86KxxDdeQpaUYT4H/gx7RnWz3xgnhs/9/TYYBxLDC
	vcHj6+ZsuUbBNQs12cmPG7e/Gy70d22A4s67ggbjY1dNvjp3RZxmFn8qNICNcl53dWftmFAHxfA
	D54OMZg9rznNfdZEf+vyGmcix4WZGgN+7fdZQBHWbEpno03boNet2X7L16jyvbu1bnbRYiqUAfN
	iFaoocTlRcs0z2R4Z4uTZlLNW5UBUv09om8Lj08ZbFP9R/0ndJtS3
X-Received: by 2002:a05:6122:169b:b0:52f:47de:3700 with SMTP id 71dfb90a1353d-5472aaeafbdmr3072909e0c.5.1757430092428;
        Tue, 09 Sep 2025 08:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3tVoSxr+v5y2YajVPq9Q5lmHZV/iznnupYsR5oyRCsxpu2WpDH/jpQIioCiy1sxWM2IufDg==
X-Received: by 2002:a05:6122:169b:b0:52f:47de:3700 with SMTP id 71dfb90a1353d-5472aaeafbdmr3072611e0c.5.1757430090771;
        Tue, 09 Sep 2025 08:01:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032be5sm39213621fa.34.2025.09.09.08.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:01:28 -0700 (PDT)
Date: Tue, 9 Sep 2025 18:01:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] drm/msm/registers: Generate _HI/LO builders for reg64
Message-ID: <pzj3qurdrz5k6h3nylqeiplfj5rnbayp7itzonxnekdrtzkii7@gh542xo2qm3b>
References: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
 <20250908193021.605012-5-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908193021.605012-5-robin.clark@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX3Iu2S1f74JsI
 2i9Y7C6c3RyuNUJ7XW73xGpi1NkzrEQb4B9s5H0paawYWVT/ttPK2UlhlGJZxHbhvYK9bZO+U+X
 XiXtbrDwmA6BEjbQpNMRBiMvXCVpNyxyD2MqAxkdGtBPBPv0NK9s41Uh1Xxw1AhoTqNmlVMz+ET
 YlSGnCCLQO01ensFG18pjMx5GfK0Xd1IBjdx0YtbThSjCFtlDPHQ5TXeFIXSTibIn+aNR+3J+PU
 NJSNq4+g5MwWzlTJeL8vpK1/OZCcSld/xSoJvzSAUtt2ylN8i/7xSgM4lxbj4UGTt8a2lxsvpcr
 qgjNiRuG+dR4MZcYEJFVEag3vb6n5L8fowVtVJ0O5hlcQh+or/sROU+I30Jq/HbOl2C1yQrFuuy
 deo+PRLo
X-Proofpoint-ORIG-GUID: rvNQdQRw6Lf1M0QqN_ymISmBUxCSBdyQ
X-Proofpoint-GUID: rvNQdQRw6Lf1M0QqN_ymISmBUxCSBdyQ
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c04150 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-2mmMjQWwNZ6YRhNbUMA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Mon, Sep 08, 2025 at 12:30:07PM -0700, Rob Clark wrote:
> The upstream mesa copy of the GPU regs has shifted more things to reg64
> instead of seperate 32b HI/LO reg32's.  This works better with the "new-
> style" c++ builders that mesa has been migrating to for a6xx+ (to better
> handle register shuffling between gens), but it leaves the C builders
> with missing _HI/LO builders.
> 
> So handle the special case of reg64, automatically generating the
> missing _HI/LO builders.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/registers/gen_header.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

