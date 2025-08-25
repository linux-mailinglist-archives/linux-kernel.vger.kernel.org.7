Return-Path: <linux-kernel+bounces-784476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FC2B33C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6624C3BCF95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747329D270;
	Mon, 25 Aug 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fmgeo6O3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89203244681
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116973; cv=none; b=K5QGvdTsk4xoYMsIQhuntuASnISpv+TVk3X3BurvocFJpEiHuoki8/i9uMkALVUOLKjEry2RUm5ccqQJk0jeNuqwuNGyvakOQLD5DHxoG6IpPh9vAxgqD0awQs0lC/vdxwy7ZgERKq4+nh577uMpPcgYlExMZuIv8TQ+Xjdk39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116973; c=relaxed/simple;
	bh=0BFTmuxgCi7E3D+te5bL1kxeMXSObQ6kl2H2LNQwS3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2WybfpSwIGDC82Ym0HiKeiyc+iJ9/lF3q4biGeNGhvJuXOX4cTeSC3goVtGpdwPFOQAKregqp+7Kbe9N2qVi5OqfPP7upTu+De9SxWmzFwch6SrteVEOud9X7XRN664apDH2mt0aIYfNQ9kFjZYBGJPgCnEO0BYVFRl06h6fDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fmgeo6O3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8PpTO021591
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0lhsR71KkcIS8wNBPhBZe9mM
	MkgJb5Dic3dujxApeFY=; b=fmgeo6O3teZyGUgySaDpAkYKkjekQ3uPRhxt1ein
	4xMZdPF/+Sq+kF+5CZmc80a8Coq1GhXJJwnTKNHfmBWUJTSGnMaRhy/5mi5pL/aP
	uctdS1l3lnvF79uxFU3WdfdWmv6VI2mDq/6sCTn3O7Be5KgrepDKLKPKAncIX8ZE
	PVjKUJBo3sgoN/FliIlfE5vndA4QOpFcfQbv/NhFEth3aRGeFR91Qsls8smMKhMk
	gqVUnbCZJAH7o9zDFx6801jkyJHcoKIIaJZp1ARO+loyjic5QP6Y4jhQPhObYtdh
	dBngZXh16lI7o2PIdu/ztAKNMW7w2C5xAnum1ZDy8y3sow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2mth8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:16:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b28434045aso174615281cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756116970; x=1756721770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lhsR71KkcIS8wNBPhBZe9mMMkgJb5Dic3dujxApeFY=;
        b=p3dow5jbFyV1NzikjvfisfR30BM+k7GGCE5KEN1GkxzqABxqSUq09hCvm5B9RpiZt1
         eXwddvmX9kOpmC94alzVWnxQEni0LmrDvPToCMDUmIhWfzElOn3taldlQ6Jx88BZB3Sa
         H6JQpne5zCp76IdC50jVOet887RiqKo7W/ZYnnI2w1whRQ2MjoEVr3R7SGz7T9b4Ehzk
         F9jH4HN69t7lufmMgxU5WS52w8AfmNYXNSGd9yW+qTKV3Vy+NctjAHvXslSA8iH0JcCB
         qzFSXQQu0wyVVqhmsVhq1rMTx91b1PZrSyfQ7V2TRkUK7zxeeNVpcm6nOWOiuQnLA5GZ
         FH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtXudgpvkUKobbaXg0RV/1XjEaCIrgYQniS2933M6z4hOwu2bLBhOalHvPyzfkmeDAQJfkSx88jk9VR70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvC0bh6GyQt+aESk6n6Un6hmFGR/BrwvyTxm10wvCa+Xkq1pS
	6YmVjailR212HhsAr2o7kN7bB/aUWTrhSCORU6u2HL/cVpJOZ9XHfs+y4PIBVsB8RNOh8XL3xl3
	TkkP5oGaWuv4TxZJZhHfeoSiB9EbK4ii+UeTLXELPC/H/nBaQqtuFZfndTKvYgAl3Zy8=
X-Gm-Gg: ASbGncuzsz3EsyD12TSbTeiw68NxhQyqPKW/xRDWIcgdra5bPb8sPhrtpUpRQ6W7RiX
	/i6pS2YUZNcDujUbrmdBlyi3VZ+68MqQPJlZvw+OBblG7lg+YvhrPk+/VmXxKKYTFIcEmf2nT8R
	c6GqSphLIJjc60NAtNjfCeuGEqosf5acMVr7/c6gKIWpNmpY1CQmL3I3BWOFvEObuDuEiFJlif9
	qGGFzNR42GUeptgOQOyGSoWMbpUPNgPNFJt3lJ3yFo4OYUciSxqn8R/JRgxCaEhuntV//jpSXNs
	cEJnj7s90I9v695VId01bJtXkAi+KGwq+BRmpSEhHuOEYgIzsVmAYQ2gSJcfHkCDKXu6+yy/NK6
	8j7UXndbTeX+vUGTsJb2sCYSaGzubFOaAPteedzkR33A42sUvXiFE
X-Received: by 2002:a05:622a:1115:b0:4b2:8ac4:f077 with SMTP id d75a77b69052e-4b2aab8aca4mr145651251cf.73.1756116970299;
        Mon, 25 Aug 2025 03:16:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBP8bbrhPwwi4dRXsomCDJ3dx5TCVrS2s2eHTccnc6AR1D3zpu4g5/lFfJzDG9qk1UiQwqEA==
X-Received: by 2002:a05:622a:1115:b0:4b2:8ac4:f077 with SMTP id d75a77b69052e-4b2aab8aca4mr145650931cf.73.1756116969712;
        Mon, 25 Aug 2025 03:16:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e20d2aasm15513781fa.6.2025.08.25.03.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:16:08 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:16:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Henrik Grimler <henrik@grimler.se>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm/bridge: sii9234: use dev_err_probe where
 applicable
Message-ID: <eckjfjhs35nagljcjmzjmu7q2eaewvmdzavt3u62gma5xphbzi@7jfgheo5fmqz>
References: <20250824-exynos4-sii9234-driver-v3-0-80849e716a37@grimler.se>
 <20250824-exynos4-sii9234-driver-v3-2-80849e716a37@grimler.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824-exynos4-sii9234-driver-v3-2-80849e716a37@grimler.se>
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ac37eb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ix-_PWS5aj9sFk0hK8kA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX9WecxVvPy4Gu
 qOdVTz8geOK/dw5AiE/7ePuWQ9IyyrnFvJuxUeO4Qnhjq9ODp3cI03Ph2bBaNpzsCKPIFHekrd9
 kvlorav0I7x3eaecsEJ+xK+NW5u9I1U3Pr9H9JkI4HkbSmpq2iv6i5/FMbw+TXL/xz5N7WFUrwx
 nkRsrXeXRkCmCclaAHkKtoAc8Ns441MSEmepSfMHb0pzgMBbvjZT/cpq368oIEE3qD4yLPj+Mu8
 u8I7VDTyC6fF1qyraeLj3as/N8c7i0VGXT27PfE5jCBwMppBNpxFsqnNck1WXSsFBeo3wW/ZIqx
 P0tNsjvV5btMsDnrRnGEIYvW+NgbrTWFQ7FANA06Eqg0CCT8u+TRUmmfC77qRmRtqI+krWPRKzJ
 gtSqUGL8
X-Proofpoint-GUID: VZQxl1p3qD5FuK2KXSO4yS4jkIptEvrN
X-Proofpoint-ORIG-GUID: VZQxl1p3qD5FuK2KXSO4yS4jkIptEvrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Sun, Aug 24, 2025 at 01:16:55PM +0200, Henrik Grimler wrote:
> In case of error during resource acquisition the driver should print
> an error message only if it is not deferred probe. Use dev_err_probe
> helper to handle this, which will also record defer probe reason for
> debugging.
> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
> v3: add missing return in error path, spotted by Dmitry
> v2: no changes
> ---
>  drivers/gpu/drm/bridge/sii9234.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

