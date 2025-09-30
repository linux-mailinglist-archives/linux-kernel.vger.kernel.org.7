Return-Path: <linux-kernel+bounces-837243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 581F5BABC47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F267B7A8D23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05882BE03E;
	Tue, 30 Sep 2025 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWBKbjC8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7E26F462
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216289; cv=none; b=oxwzcTYjuSYv3DeCRwoFr1isrhXrSAjr6xqEbTpzsoDOxykcouP56/LLW9k4XY2oyq3zDSjEbqFnKtt9/6pEWHuIgLhKLMWZCvxHNWzb5lVT4KREQccSFGqWJp94eYdHFhSJM8IWOYreMxCNS8M6Tlg9cj7pu8At1eF3UnfEv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216289; c=relaxed/simple;
	bh=j2N7nrmNVrvXiMj+TUS6Y8fXfzHkx71Jm8gjQ86zCIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUXOu6M/Oq3HggII3kU8omte5Ej8cAELbkmta7ViSXGn1KzHr3n55MY5OEGUgbgjyQAl4r6RGyPbIsnQNOnO+zWaUxcePohvOZHkesE4TSnvqj6vvMKrayNuGDpDBW0bPXgP62smPj1Oy+fgRTvC6YPCC6EOGaZGM+lEjjdhYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWBKbjC8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HN9K023779
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kCgcpA/KH22QIJWR6lWCGCo8
	yAwGEj9Grr0AmK4duj8=; b=bWBKbjC8XOLZUBjxlVMArnVyMUk7L/cho3IZ8cAF
	EL5Nz+r54Fs8LIgnnKp8AbYGTg3br1F/XM8U2PrL7PYLnaxGDaTD0JL2uFUtfV50
	V3wAHWQYP4dEKJhvFclfk5q0U3mD6yu3gGTK1NwkDJEx6D9m0AqyNnA+V4M69j26
	PGzcRT+HCKxiNgdXHcMizv+fZtvCp8dSRx/J50S00rvzJlBE10zqROhY4ZkYNuFV
	3V2jA27AXp0UmNXViOWhJ/Dao3UhjAdPPKDHy7dVBl88m4i4xmnbI83xk4iHMjm1
	93jlCRiUpvFuiZjBZj3/BNHnHDUFO6ciosLCHqIIJjqCeQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n0c27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:11:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8645d39787bso898421285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216287; x=1759821087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCgcpA/KH22QIJWR6lWCGCo8yAwGEj9Grr0AmK4duj8=;
        b=BuZm/OKbrKFBOzOPfj3AmKDgPvMCUaOy39NMAgl3mUlGqRf4age4IXnQPp5psXB1Nm
         jIyjJRVHgoAM/3RLN5vwomi2m9s87nqlIkztOhg3foQhc7dMnR9MUWegzyrEMUIJPO0/
         n9/pFe/VGIfCc6m24Ml0a+L01QKmSnXPQvMMTQbO1vRHbpUnc5Xb+0ccA/g2o8yj6YTA
         ZuexpqB85hykbj6qTYGtcUIzF0/PgaQFhWuhBg9X7OFzNeuDKJFhJ1iVpD7eMJW2zBll
         kSWzzWb4NC04efn+xclgDndNMxJLN+mEKH4ikUlPCP4FGPaTBQXKhhQiE46dPvg+qQzx
         llqw==
X-Forwarded-Encrypted: i=1; AJvYcCUIfvZzbZzKWrC0QkTzoT2rTVrgfU9xSUImySze/S4HoVsnS9DjgzUaA1u+QNP7nloylPgN7jQQFrZyouo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwb32UqrOOW+HZ5zVPwk4zKsRibq7l2TF9TsKClmUBTNxrbrJk
	6pBWBavW7ZdhGwDJWtqBKph1/rqSsIaB5JiJzD/4X8TkH1yUw7C1brHtINZmEEwTYJKJ6odCpg1
	5/QaPYgYDjyrvaTkUpDSiJB6bg2Oy3qq3OomHJW5gg+kChmkF/4ocSghN0ABsxrhYLGA=
X-Gm-Gg: ASbGncsaGvssAbXPo8DnFqQJbw4oxGge0wtzT44xhGWi/6vVw+8Saej78aRB5nNVOhX
	MKq09MCaNBpicnZoNO0ppQP2WjVcc7ReKbRNwSGbFuzB7gh+pXkAMR4Wq/9K2yxo89yn1AU6YPh
	RRfsIfmoOXqD1nS38q1Li3eIwtAz/oVxAoyeFKz1qUM9u6qX/5jLQMoCTKceN6M85q8rWvoUSST
	9nSyIxV2uLGD42I2v13J0MPtWWWjvWFrCGwMuzsfn0fByuA8cUHv0jhrntjrQ3UHKSbB5XWljnK
	wLnrdDUzJWNYdUPSXeYrJXy7jgmN0LsuRw/XskvWSi1WxZz2j3AI+lRJXcI1DUP1wTJ5a0UlJM7
	XPWPSo2TwMofogZ5m6m/pU8sG+GhQJRXqiN5q7O0oWzxtHKYrCm0cMVHyvg==
X-Received: by 2002:a05:620a:1a26:b0:858:64c:22cd with SMTP id af79cd13be357-85ae94c6f9emr2830952185a.72.1759216286525;
        Tue, 30 Sep 2025 00:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYRbssu3zrykdvcozSbij6HKAxVNsfP55t5zEwTHN2XSjTz6lWJykcsj3kQZuHoluEGfqVDA==
X-Received: by 2002:a05:620a:1a26:b0:858:64c:22cd with SMTP id af79cd13be357-85ae94c6f9emr2830948585a.72.1759216286049;
        Tue, 30 Sep 2025 00:11:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4772cb8sm31868951fa.10.2025.09.30.00.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:11:25 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:11:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/17] drm/msm/adreno: Move gbif_halt() to adreno_gpu_func
Message-ID: <x7segnx2v4id3qw2zna6vxxbomfcyogib734ggifggynyfsp4h@7zs7savbiz7a>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-7-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-7-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-GUID: yaBz3NecbLB4Pbtpff_pjAEyEv0lOGRc
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68db829f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=scbeE0iXsUk0x8BJeo8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: yaBz3NecbLB4Pbtpff_pjAEyEv0lOGRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX1MIVZ6NZcWbL
 A7vcqU/4Hu9r8zWlnTXkYrjiFety6Y7iyk2BiRkg9xvcpeSeK7f8ms1lM1fSTVCLqOS4I0J0lao
 YAwoH03Ukcs6OyJOjxMQim46BSY6Z9Kv2ADMtmB/RpauKtqNQcd69vjO68xvOsFQJNMM7TNchc7
 lKhd7OP76jt55XndcqoLt9rOkpYOr8jtxxn65VHEW+urp6U3l92qa/FdT9Jxv7OhcLA2WfXgpzf
 CABas6JnToMrPxPMAcpBME6sZMl8snExQg8zEq2gqdvRCxV6Qm6KuKoHn+j5WXry+RJtsdau64O
 l5TTgbpGz2LrFtCBDbraG2vjtUDmnWN0C8npiCSO3sgXPB07pbMWYGLVDGs5q6U8/66zSZVgS3Q
 wE2X2j+CT7W9RgQx8XMiXjbRyA3uAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

On Tue, Sep 30, 2025 at 11:18:12AM +0530, Akhil P Oommen wrote:
> Move the gbif halt fn to adreno_gpu_func so that we can call different
> implementation from common code. This will come handy when we implement
> A8x layer.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 4 ++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 7 +++++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

