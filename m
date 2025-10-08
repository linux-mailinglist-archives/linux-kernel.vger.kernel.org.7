Return-Path: <linux-kernel+bounces-845378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38041BC49F9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEBFE351375
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464B2F619F;
	Wed,  8 Oct 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LwqS+2Up"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842F2F5339
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924286; cv=none; b=to27/W/G914MtZec2Q58MMtvljh4uVEqCgK8YkN8YZ9lrKLCfv4mUWuajhntNEwcttVn04oTyiEkWG5+9ZoWZ/ymuh8mnAe3Rge/0gy8tzjl4PA9580Y1iKrADu6yh1zlv865JQWZlHg5Q7nZ4QixuwfIctD80qnO3kim1UgMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924286; c=relaxed/simple;
	bh=pa+gkLWrp2QAqUUYjdb+zf9q7W84puc3aqeGewFO0Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxBjbpjzRuGG+QvUiNAQWOFSbycT5MWIVpucZEAGFs2gbVl/+8qCcgtsj+1nRzdFzs2gtj2l1atTQvknwTdaJZ257bAu20aCUU55xeI94fhML67AMRv7f4xm2FP85ZK6DUThHVnZjkIByPI7a+7Dg9BdVwW7pc3v5WsGHf9wWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LwqS+2Up; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Lj3001556
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y0WlonZzhT+aPa6S+klAQl8ZLyn+O2jbA9B6NJTdYUU=; b=LwqS+2UpafhDGXMn
	Md4iM6GKpIekhqaCFz7wXsm620Hpq15SUXKTd5hrq6u4CMxSSbdB7NU/JgbYYor6
	eIl9p6Ie88g2nnDXQysZo3YslcjeJjAw4TY44eTsOyGaAKtyLrddepQrFtebSDTc
	JpOBlhFTNmSqWwnGt2mJj8u2H2p6MNyKJJrrStfnifBDGgnnGQOPs13qnRePKx8S
	fcKcgr8jWXjH/sWfDDIM+Zq96LbQZbEwxH4W6pxh9JMKq9VqI7JuuFNM/ShdG3C6
	IhH9Jl/28oWOmhozi0AC8Zf4fLErFyoPHdnkp3DeXLaqKD3jMP4SdeFa7Z0Hje9v
	rxAukg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxnakk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:51:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dc37a99897so18902991cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924282; x=1760529082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0WlonZzhT+aPa6S+klAQl8ZLyn+O2jbA9B6NJTdYUU=;
        b=k41bWqr2grEbkhgdayxhBQHz0rAOWI3IgUkV39wOKDkGu4n/DoUeUdWUiUVTPXC8fB
         ivNo7+W5ulAmG79dkoSgZhaMHcBI/AtOVKGVultTfZm/X6Sm27xV3xR5MiVICS5+wAs1
         Lo8XmbBL3XHrvIavMP/oMSgduRvSMHSN6NMTGWvGM+vWbyneNSgTrkOWdNZlVBPYGYxn
         vEQHe5GCt3hC5fI07VzO4LGIDIvUmj7qKKBYTfvVW1shoD7pJ6Lhh8wet7ab09SdtTTy
         his7a09IVzJNilAM7M7zmaNBiQvECkiDniDuYA7DwqwEemuno5oZKjESAPJa2v+6X2JJ
         W5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWRJ8uXCe4gatprTl7HcGsxqUExeFxgZDa5WGo8JJZKKEiSs+goMbjhHdAtgBnEaAdYo1hm2P7l+An0QEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSRJ+C/yMaYXgir12bOZ736wCx1A9WKl89LMelYqu06Khtltg
	UdPhi1uvlaQBUUpMSiagkKmiaKDmdifhoN7z0A48byThG0U+y6BOKGW7PDRGHoQFYIF3TX8lmsk
	me1BuyzwKXSZ02+Oi+RojNrX4RkiZRIjQlp33xy/9tmL9UApw+aPub1g6c9eqOmFUDaw=
X-Gm-Gg: ASbGncssZv/k/bKbS5qCn8a1+6ZPWfgAvvvlm3XOcYhJXA/584dlEs9CsB1K5qHrqLK
	oIJvi3ZHKa1JRJW7In9IoC4hYWTcOUKvIFTANQA3Fw7axbhuKZrSJLHqDOLQomQCsESuBknncds
	1tX4fRbQowVXvCwD1rfj1tKGu5OSsHk37e1qnj/SEofwJcQqMRx962Zggj93aLSSuZt7FXg5syA
	atrY1hVW1E/k9Ay8gtHKpEjiELnajDU385B05EwlqBcnlhu2XceLr++hT0L81jR2rA3s/6/+jJw
	EEnd36sjn4t6UJ/NxbaZhK45Njsip4zUTBW16OJftdKHqxSPpwnnlvVuzmXg8B9TORPvGMToMYC
	A3oGWBVMsJGb8zFmKb/T6VQ0NcPI=
X-Received: by 2002:a05:622a:3d3:b0:4d8:85db:314 with SMTP id d75a77b69052e-4e6ead5eeb7mr27150121cf.11.1759924281851;
        Wed, 08 Oct 2025 04:51:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2gWRn31Utay2MX1qgHKnxPLPzAbFxKTM0QkU36eLSGUOX9zyx3iPasVrXq6nEJTPeMh4/9g==
X-Received: by 2002:a05:622a:3d3:b0:4d8:85db:314 with SMTP id d75a77b69052e-4e6ead5eeb7mr27149701cf.11.1759924281298;
        Wed, 08 Oct 2025 04:51:21 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b37bsm1681982366b.53.2025.10.08.04.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:51:20 -0700 (PDT)
Message-ID: <5a027440-8720-4df9-a793-5ac3a624ef60@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 13:51:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] drm/msm/a6xx: Rebase GMU register offsets
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-10-73530b0700ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-10-73530b0700ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX1GM4eoe5mW2S
 aPBxUXSSzPMU/AlXSV5RCDwGSVMYmK74v96YTjlYTvJuJG27W1jEzyyl2b+jqdmLAcMdLPo9h/h
 XZ4nWkhMZ8xDXfSy/Muzz7r/eSizyBvKMYRVgjSW3avGrGA82PEZ0RhKXVe9Nl+TyxMrmoLh2mg
 3GJ2pbO/al462zWom9S9Z7aU41pngUSKWIy9zri0jmHCGbn//lkPeKjV3jh77msAUqqze+nszdq
 JsAwBkGKaQRdN6cq9a7SNTJb6/ui958K80BfCnioASEUPxPp177uSZpFtH+gFCesTui4b5fjLth
 BCfK6poxBPcvHpsJo/8lBl3JEo//eoyJ6h9JwZH8BjVMY8w+ObBo/SgFZpE7NlwoY+fZbIhNP62
 GyPqG7zhO9dGRBpuZV6C98H4tJMh9A==
X-Proofpoint-GUID: ED8C3fNOf3FXouCR6N5b0cEDC-MbKQkt
X-Proofpoint-ORIG-GUID: ED8C3fNOf3FXouCR6N5b0cEDC-MbKQkt
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e6503a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=abYYEtMJDLCSMuBgjaEA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 9/30/25 7:48 AM, Akhil P Oommen wrote:
> GMU registers are always at a fixed offset from the GPU base address,
> a consistency maintained at least within a given architecture generation.
> In A8x family, the base address of the GMU has changed, but the offsets
> of the gmu registers remain largely the same. To enable reuse of the gmu
> code for A8x chipsets, update the gmu register offsets to be relative
> to the GPU's base address instead of GMU's.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c             |  44 +++-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  20 +-
>  drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 248 +++++++++++-----------
>  3 files changed, 172 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index fc717c9474ca5bdd386a8e4e19f43abce10ce591..72d64eb10ca931ee90c91f7e004771cf6d7997a4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -585,14 +585,14 @@ static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
>  }
>  
>  static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
> -		const char *name);
> +		const char *name, resource_size_t *start);

Maybe you can keep this offset variant and switch to a simple

devm_platform_get_and_ioremap_resource()

for others (also letting us get rid of a number of iounmap() calls)

[...]

> +	/* The 'offset' is based on GPU's start address. Adjust it */

That's what an offset is, no? ;)

I think we can drop this comment or move it above the #define

Konrad

