Return-Path: <linux-kernel+bounces-839704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A2FBB2331
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1D9322123
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DEBDF59;
	Thu,  2 Oct 2025 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pzJAo28G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5D34BA57
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366911; cv=none; b=NOYTpwv2TN89Zwh6Fk8JvrXicVZcYaCvUab/OX3zq3qOa8zbJw5hyIrL3oe4imk+RKd/dpFOEGeaE9URo1KSyDyeiB+Hl44YFA9Pxr1gNYnHw5W+57yIH8pmqBRZbsGwyknbmmMG5xA1vCggorX07VUjpYKx9xdqlgWtmyk7EQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366911; c=relaxed/simple;
	bh=HCZdNAoMBnXI97RBUrQ9js+GcawBirknDeCnyIBfdF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/CtLmbveILxyavG12nklOW9molGyHSfgaGC3DUJfXhylmGagNdGccY5B55ylExizfUXXGkXv2mM2Cki8e60IA5RxGoVuBitII4UQgIm1rFd1sFMP+Ei2/hr+bNuzcCFTTRd1fEXCRCAJGNQVcun2Wav9OmT49naBDv4igEBeQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pzJAo28G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcF6x010221
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 01:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+uuV+cAEUShNKUExukS8Sgyd
	D6777ETGVMv3jAdKCJQ=; b=pzJAo28GyVqZx1sMk+eBu2npT920kGL71Izeb9ie
	5Sv1dzeXKseKZQpR6MRLHAUdZTQhn9lZI1VA2Tr1CG/guG4ptPbv/EqNjdbZ3lBI
	YS2+vGtRN/g1FHQ8A4vvoHJVpYXOo6BWE5NE3Cpq/joefc9THzWLWwERRU4TzW+O
	aU3+Qqn1/Ww3pk6dJoz1LNFZ/b+SrxJEhks3p3a/vxYFJqGXT/5ARVCMZBk+WTeP
	Hmt2YUjhWVZDtdpfjHfbcwsEvCQyHDsUncpSkhBSRjpcee/3ZFTVM4QGPyksrPOI
	9RUUmlmKcRQakxMFYTFiIG9oNgZG035AY3j1TEyNGLCeYg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hp1mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:01:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4dfe8dafd18so21065231cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 18:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759366908; x=1759971708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uuV+cAEUShNKUExukS8SgydD6777ETGVMv3jAdKCJQ=;
        b=lvwsFxfNXy459bMOQyCN2GQEejdrZUMFLvWuslttVWNEblSicNus8PHdVKEubQEOiB
         IFWgRei8R2RhRxNxENfSr1T4eBMxxev7HjQZdEMCXmSYWVcPJg+aBAfG6SeihujFnlKR
         ppBuuqy/lHNkvWMqiU2M7TaHGCYYC6UiqkdNmLyskpMXYcK/9EVybD7I99A3Bi7xmpef
         LDU2YO2fdkFpb7KibDtRnRW2wLeh2BOaVA2dJ7Jtl8kvn5ZCge2BLLT0Fp48hFi4EHR7
         hvMIUBZsmu97ZGCSj0AHlVwLkHlFAw7t4YOJhCage56A7XbIT2DfveHP4m6E3MF0wtPN
         JGrg==
X-Forwarded-Encrypted: i=1; AJvYcCXGQbazVdFcmg0DWNb/hAx6Lz/BKPx+ZA9hPj30yPi2yQmhRKqiYlncTKMJmDXr0Aw1B9kWc+mPuQJhYA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKT40oCIW3MkybV2o/zoKkyLvR1uPk2DvHZzvf+EfIcn4reHx0
	Wn9UNr12rbiCWR4m/lfo+YTxZHFDYOgSy+LdqEkqk4LQUNCr6v4PA6myP5e+hZrsn/PjWMOPMP+
	BqoQzDw6LdUv/jY20Ulb3pRo+7IW4aMcT2mRCvfpxpUbbDD0pGGUOvhJYU3FY4Qd8BEw=
X-Gm-Gg: ASbGncvQQwjeLStACeDm6eED3U/qqtxpYIOG/6Gm+3PneJboEE3Wr2gVLMJvUDwUBlK
	hnrDVJJ6ejBE7QuBQRbj/ENUcaf4SEVXR/qysbaNcX9u2RfkM7sOTNY/g7Y/BsldhCbM4gQJ8Hy
	fWKMTHgFbcD9jvm/R14oirqrKbTPIUHB8HXY/2qaXzT9IuiGIDKNhDK4LfA0Pd/TFHo5ksyNQWQ
	mkWdd8Nk8fpNubAIG6O3JyRkXtOby41c3wSDY88OR4e+9Xv04btxlSi9GcSMDv8lVWLyysjDOkx
	LtlSflCD/bFZINusBVtAq7t9o9YUOIj5mv/gq3qFd6ukX17pas3jqpk48wxm6rW2I9mwOiCwCSD
	zDbNFSw1td0R6xOntjc5m8HaZslxZag5Rz0gesz3BWCPz5MsiMpICYIipyg==
X-Received: by 2002:a05:622a:7c0d:b0:4e5:c50:54c9 with SMTP id d75a77b69052e-4e50c505d71mr35071891cf.14.1759366908196;
        Wed, 01 Oct 2025 18:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn+cgowdIyCiT+tSd84oPTNAKVxBzdxq8x33fvDr8hPGJVsiMB7AsHFEUbdO1IdCvcYvE2oQ==
X-Received: by 2002:a05:622a:7c0d:b0:4e5:c50:54c9 with SMTP id d75a77b69052e-4e50c505d71mr35071211cf.14.1759366907553;
        Wed, 01 Oct 2025 18:01:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm344791e87.52.2025.10.01.18.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:01:45 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:01:43 +0300
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
Subject: Re: [PATCH 06/17] drm/msm/adreno: Move adreno_gpu_func to catalogue
Message-ID: <edfc7ke5ktoah7ftjbwk7dzihsgh2mq7tatfy6a5oxbn6yt7d6@yf6nz7b7jrmx>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-6-73530b0700ed@oss.qualcomm.com>
 <cp7djnezyp4whhfqcnsfpes5kxfbyvqvc2ceimdrnrl7s7agyk@z7ozx6oihezd>
 <82cd8782-b2ee-46ce-9964-e564ab6a0199@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82cd8782-b2ee-46ce-9964-e564ab6a0199@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXxr8qEC04z1ck
 ADb4wVeT8Ulg5WGWPF7r+Tt5w896orbU0ZHylKavGmafaMCh/0zS6fpMvXMeMSfhn+066qt1R/L
 tgDBvVUDoO4f8aGe1Mudyu34V2u9krUCxcFr5xdyCm5YCdlCqDejIn6DdptllFC+AxNqGwaiXTY
 7uKzumrbOulqlhalGN6SJbWdyKMC7t3h/qTj16K3MWmQXjjlnYjHXJRBnw7Sh8JcC6B2QrOUQ0S
 qK7z1dX8mdORdyuOZT111Dk8g4Dh0B8YsSfT0Giijxvx+KHmkVBEbZkSfgQwuN1FUTy9MXoSEFE
 t4Ue9c4xUJHr8Zqe2uRhHLj7ewtkOax+WvQPHpFOPvjRsNcrKF0YaF8+Yemufq3o8eS80aGip+2
 WH5YivMQ/OMljLev5on/fvWt4Jpq1A==
X-Proofpoint-GUID: -buHx_BYNF6As4LOgPurRakZyIKLbSzr
X-Proofpoint-ORIG-GUID: -buHx_BYNF6As4LOgPurRakZyIKLbSzr
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68ddcefd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=RvmDfw1ThOOzoc4muVMA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Thu, Oct 02, 2025 at 01:24:36AM +0530, Akhil P Oommen wrote:
> On 9/30/2025 12:39 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 30, 2025 at 11:18:11AM +0530, Akhil P Oommen wrote:
> >> In A6x family (which is a pretty big one), there are separate
> >> adreno_func definitions for each sub-generations. To streamline the
> >> identification of the correct struct for a gpu, move it to the
> >> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
> >>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |   8 +-
> >>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c      |  50 +++----
> >>  drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |  14 +-
> >>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c      |  52 +++----
> >>  drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |   8 +-
> >>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c      |  54 ++++----
> >>  drivers/gpu/drm/msm/adreno/a5xx_catalog.c  |  18 +--
> >>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |  61 ++++-----
> >>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  |  50 +++----
> >>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 209 ++++++++++++++---------------
> >>  drivers/gpu/drm/msm/adreno/adreno_device.c |   2 +-
> >>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  11 +-
> >>  12 files changed, 275 insertions(+), 262 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> >> index 5ddd015f930d9a7dd04e2d2035daa0b2f5ff3f27..af3e4cceadd11d4e0ec4ba75f75e405af276cb7e 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> >> @@ -8,6 +8,8 @@
> >>  
> >>  #include "adreno_gpu.h"
> >>  
> >> +extern const struct adreno_gpu_funcs a2xx_gpu_funcs;
> > 
> > Please move these definitions to aNxx_gpu.h (a2xx_gpu.h, etc). LGTM
> > otherwise.
> 
> This is a special case. These symbols needs to be visible only here.

Why? They also need to be visible at the point of the actual definition.
As such, I think they should be a part of the common gen-specific
header.

-- 
With best wishes
Dmitry

