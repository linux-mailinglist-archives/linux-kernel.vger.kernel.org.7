Return-Path: <linux-kernel+bounces-837296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4BBABE55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E007A453A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4CF274FF9;
	Tue, 30 Sep 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mbPXCIfs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4822CBF1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218592; cv=none; b=Zx25MA59LOvbzF2YrfLVTVAd3nnDF2s8oWl6vYZZW2J/n+s0hIEcx7UC3TSHToPhJvCa1n9Wi/kFuSAaowETnRABilKjIjTBsSaVVG15cGA+OxUgtDc4RIDoJbJVnNS9ViIYxgyEGTx9U9xgPyGCG8XAzl1BzHpiAV/H1FFBmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218592; c=relaxed/simple;
	bh=vPPstQsecnnkIWa6DxFaHD9gRnqYStgZOVelTzbVHqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcbQ89a89ZMtabS7olglT3WINogdAda//hrX9ipk6x/k5TvvZKt29hbZ7A4tlHFpVXviQCPzOclSA4avqQmFPZS72kOvHdoc/JBkzp2Ee4i5z+VcyQW/C2WWJu8jQ7vzXJV1VU/P6gV8pz4xDgJ2pvVvYMXzcEGc8yEfGQ6eO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mbPXCIfs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4IEFD013512
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tcDYvvx/kWESRIwdIUfePzUj
	wXfd5DkiWsQQ0UqQcPs=; b=mbPXCIfsnKiNtisq0erGetEyK+l37muV+7YinheB
	bYj644FZBNuf1NgkhSgSbqRlm+TYG5UJuTdvExajM+vrUhtwvopVf/wSpTJ/WkqC
	hu2tYYX0OahWkjx/XHHgJ165uF0Hdl0hZ0NmfphU42nznbmNIJHNgJcE+NtGueab
	od5nvAuCN+cVzlntj3IJiIy7FHLagNgVuDVgefB2uDbvVHjVWmKsT3TunRetSyK/
	SXZxXbuQKgsXBy8egQfp4FHYNPv0FfnA5OKfkxqjjmN2DiFC/r0Lp+ZgdSNra7UX
	qUjV2tDvYdey7K8eKSeHm1dSYSwas7M8x+dBmnqjSl5Xfg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a603sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:49:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e0e7caf22eso54678001cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218589; x=1759823389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcDYvvx/kWESRIwdIUfePzUjwXfd5DkiWsQQ0UqQcPs=;
        b=rEUIL5grnxdKjT2z8Ie6NoMKVw8kg2hxqTIf1Pa1xN8R3UEHRpWkT19Vo3pTBsH9VQ
         oUK9xGpSpThKq/rEBu510YSXlKyTyLJC8FhifLBnY1dSJNcmixrcPca6A3aY2bMvntYy
         FGvlZkT7OeboCvk0ZVrysVaoVNZSEFT7VXUZJ1EdNGsdIBCBfPNw82mxZcBgDvGlyvZF
         vkHibl1+JyNSGMiwnCYhYaOK2hfwpGtiHusMMIaVllEgsrvwym92UStpXB8pruS47IM2
         UmxChJAR0l+hYdM4SGeimudm4pyE42ASus9SqPIJaexehCcbiXfSQ+OiZuUKIWHD24Ni
         av9w==
X-Forwarded-Encrypted: i=1; AJvYcCWn30/bG/bCIjZp88h1k/DU1JUOsvjdZ66utly+Jo7BIqQhHGQk8jeslwt2j5yG4fZDaZv3b0Yw/b+bOd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTA8FD8W8os/Q6FUWjpTpXJtKsIIpzss1rQ86LqvmfgW+6YW0G
	HuDeNIGn9TSUF06XWA1Ut62NW0OhDecv6GdpAL4pC5eh0cPQLZDf7LyFBf/cD3kmPusLPSq5Cda
	iuGdjBm0xFmiBdQ3SstkvkDdZ7h4Dlc5OB/oHUvwrxIn7uhjXgtPi+GX9c3v/uTUx89g=
X-Gm-Gg: ASbGncvkElKsDJTt0ZZJuc5vtrNNbtD5TVYHBl8ClA03az62jXTDtI7WvzoHIzXw8jA
	sXPhgdDnITjsahBEgOuaF7GPmtLwKv1XjIbDmB21p6wt+DQHInrETPW+cY2uPmerbXTVkLPVSw9
	pCRzmLJcxkmys5XQ8e3k9yJhUN0zBQnhqphXGci9wuGCox9U1ceclEpSFrskXDV+RceEW5PpLIs
	pyteOqsx9N/9Cx2ze6Nm8wbOECx/qY5FIaUR5tBsm7OipRRIpfgkR7+2HvRR6lbMhgdc+eZLnai
	5zfg30AtzuJm1Pcs9mTA/ZLXJRtD/S+eB5kCfZZgoXee/JlvCvVp31uTUtMGMSV13e7lMhbz89b
	BQB42NRFCcKgh5fxotAbS0EMZj4xw03EMPzCDDqNwdCRbr5XeD2vtktDTYg==
X-Received: by 2002:a05:622a:17c3:b0:4e3:25d7:57d4 with SMTP id d75a77b69052e-4e325d772ffmr15078631cf.80.1759218589257;
        Tue, 30 Sep 2025 00:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1NOqQxAPdQp+Dh3rh+AoIDtXwXlBUdceAQk5B9YJWaQLrY/hOzC1FHHQS6Zz8p9Hkpk4YgQ==
X-Received: by 2002:a05:622a:17c3:b0:4e3:25d7:57d4 with SMTP id d75a77b69052e-4e325d772ffmr15078221cf.80.1759218588705;
        Tue, 30 Sep 2025 00:49:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58567242ef3sm2908507e87.19.2025.09.30.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:49:47 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:49:45 +0300
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
Subject: Re: [PATCH 15/17] drm/msm/adreno: Do CX GBIF config before GMU start
Message-ID: <ae2ooybajk6mcjggeztumubht6auw5qlhmsdrblikc5ruoxtmm@oj5kvpxithva>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-15-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-15-73530b0700ed@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68db8b9e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=219S4Ll1wpRkBpzXM0IA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 3K49b11e2nT5apRN3taQAyzJebq35soX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX8Hn1N4gQGveI
 snRTGUSNOSnEpK5cJzyB4m27dsFX8PKQ5se1oMAm4Y+GrhlLEx1s47gkeQbzAEKGrndLYCqgLvc
 87Yr8BvvjFz7kYhLrYGXgjUcAYQvvl+KgWGm+lxAWQlp7TpZv8Y46bPe5zdCTXk8CGr3LSACUpo
 xgzixNMCONTdE29+Zop0CBpy51zgjzYPvir3Ynd7PyB/YAbxqlUkUWewb6EEii2Ur9UpqKA2O1N
 QYAVr1/nSuj4HGmEU3Wh25aBEVQGpPonHuFIGkFG893HUXksLPUg7AElTV34mG/eWbkQii+D/UC
 e3QErR+FbGrDwfKL2hT1nYxWJrR1l/XngP0gecqo0JWA4DdFR5JrNFnpoS6EoFHNZh2sy7uIOLK
 B+PbV6vlIYeycIQFiRXFYK10rkkMDQ==
X-Proofpoint-ORIG-GUID: 3K49b11e2nT5apRN3taQAyzJebq35soX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On Tue, Sep 30, 2025 at 11:18:20AM +0530, Akhil P Oommen wrote:
> GMU lies on the CX domain and accesses CX GBIF. So do CX GBIF
> configurations before GMU wakes up. Also, move these registers to
> the catalog.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Fixes tag?

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 12 ++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 17 ++++++++++-------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 10 +++-------
>  5 files changed, 49 insertions(+), 14 deletions(-)
> 

-- 
With best wishes
Dmitry

