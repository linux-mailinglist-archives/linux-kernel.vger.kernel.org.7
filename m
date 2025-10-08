Return-Path: <linux-kernel+bounces-845388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F0BBC4AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EFA44E9CF6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD8C2F7AB0;
	Wed,  8 Oct 2025 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIMRSor3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38482866
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924873; cv=none; b=lXlIV3LVeixgOj2KPrXHdXcWf5lyfdxfQinqeLSS3/bQtwRaR8b06XBj7FEKioZpzscmF834bhjBfykLocfQ8tHca0XCTe5SJPf5swRwgXifhZiNPZv/ITln0VKa9qzW7fgKVkDZ9WrQaZptCX8ZbRUwUQyXYJl75+qnKhIAwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924873; c=relaxed/simple;
	bh=QfUT1DtV9d+QVs0WgbumZs0pdJWkf14RDIdQPku/mm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=momoolIL37fULkqc2wtZWJ78PNl45YsUMAW6fUS6MvVydRcZJIwqbydwBpz/kLLYtLXN4t1yNoEx2hd5J192E40hRp9YZttGhedUrgD3lCoF7Q4pRcKGI7pm1ON/dEIGRsUBYyGF9tPss/vwHL2FthQNKL+uauXhZLa5J/5fAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIMRSor3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890NsF021137
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YUe30woE5xEimZOnT9raXvhiVzii7F5/lJXV/+rQmpU=; b=eIMRSor3s8f0HqdA
	pkeP+CNNNqq715YMCOKDIEvIXhzK21rEAyE8AKxeGV11sFtZfcRSEWqiWYOV6l31
	CLFJOgcKqXCKvLzgnXLH0MLaL1IiJjrT58mDzQvQZWYfiOmU1MSSdWVsnCF/0GmF
	24SSvVe5dkZRObBoMxoeoc6XnfDZJoTq5N5OC7hOgDuV2LrGeLjqslpcpdvtsSBv
	PaXMMVUSqf8eH7v6YNIhQ2uNOdysGj8ioXnzOt1TGs6jNoNQNQnjGVfPLyCMnGdk
	V1EDZok9m9WVpHqCc8TtZuOo+U/kvJtxr0J1HRlQ2GVaXM6DoXflM1gj63gLWR/X
	j5vGwg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1t965-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:01:11 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-8e48b01c70aso103216241.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924870; x=1760529670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUe30woE5xEimZOnT9raXvhiVzii7F5/lJXV/+rQmpU=;
        b=Q0t//WsS2Uw23tAnTRkD2thE/aY/yxcoUX3mgNW831mxqSJz1CdjA9oZDd0I/D09Ez
         tENHx1HlEtwRNbqDvWLaLos4EOxQds3AWIrk96XtWCkHsyp00NtJO0Ydwz0rNbiZeEtr
         aWdmHM4RIJQetYD8zF3yTDPJTovZjLJaElC42Xf+YxiCjYgVDApfp2dejRXhCu25ENKp
         NyndXWYfrmBmAOKRQE6dph0588BtuE0gFCSugXhbjon2KcktkwHQphTLA7LyfufagK1F
         TWj9T+oVUBL9hdfBA4YaTGuaJPSQea2bXIJyYaN/4LrwhADtvYcG8TWqIG3b+y1ozRG0
         sWgg==
X-Forwarded-Encrypted: i=1; AJvYcCWnWmfJCXsSMWosA7WFWkUs+Tvone1Xo8ASS8HAV/4xoaw4HIaBvisebOGNsPSdECWLwHThOblc9v93kcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywit5rXy1ExdUhjkOtjX7W0mZFG3PqOSGe0Jbsb1mkpt9C0y/D0
	Ef2kuA0RRbX1bPfa2cUUfZLNliFTJROI2JrxH9mc7Z4tXmTPOVEuDNP11yRFaBaY+8YRH3vTXcj
	InCVQ7+ps87NqI2zrpR0fSWObA8c50kmDcJ4kjMiNRd+P+PHK6xFZwds33Y4eAoHKUGo=
X-Gm-Gg: ASbGncuTUbuGbdp0HXLk1eVFdKf41gpJ4kpzI2mLk1a7UFY0zPFd9rt8UHbs5O4L5bg
	4w9lrRXEvqbs49pa8yn12eqwY43EiBrSu+++KiQ9elaT/Wg0uGcyhZBjggjPzI0AQkjIeU3EAN9
	6yLmRf6P8jAWmc9zUlFilWAarFxawpefcCrRxfj0zwM3wAQYFqHspcDYCKl90AqcFuBe1fq76yv
	pleGCTBD6djgErVf4ViNrME83uiVWcHbobCpPLR/tACzKiPPLngPZyscg6qR8ekk2QExYsb4ANh
	Y81V6Qqe5vMJr4Dh1o9cHuocOYyc89Eq0SxFUypStXb4rw6Fx8YbSLfAdH1N0asatrCjyUZSzxu
	4O4OPy80CHqRtRr18Ht5x1Ksnmzw=
X-Received: by 2002:a05:6122:6c01:b0:544:6d56:eef1 with SMTP id 71dfb90a1353d-554b8b9dafcmr382793e0c.2.1759924869693;
        Wed, 08 Oct 2025 05:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT9kYombhVn9vLwV8HVqDP5rHDdMKek8m1Ph8xI5IlH4fvXAiDJcCahZY6sxIbEptqVVlYDA==
X-Received: by 2002:a05:6122:6c01:b0:544:6d56:eef1 with SMTP id 71dfb90a1353d-554b8b9dafcmr382725e0c.2.1759924868891;
        Wed, 08 Oct 2025 05:01:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa040sm1634050866b.20.2025.10.08.05.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:01:08 -0700 (PDT)
Message-ID: <f7f2189b-b182-4616-bba3-ad1a0af3e4da@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:01:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] drm/msm/adreno: Introduce A8x GPU Support
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
 <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MbQCWgoJ6b-p1UPc6zx9lQ_JEsr05S6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX2EISItzqgj40
 OK7qMoblGGqSQxE93pBGxAjiYKClglhQ9o+Uy51Qt3wqRGL1XKDTuKe+WNWqvO88+yE+yDR+BJu
 utUQfwv++FpOZn8MZvuPeBLP37YGJMu8iu1hBYPy21rXk0OA9IGKx8Ws1S/dhtI6F8C5l5ccHUN
 h19Wl8XEAUbBq1+ciacoGppWz3JIA6cyvsGxy41FzJC/xqGEw9ahmp0t81K4cfkllA9+akvyGwa
 Nwptz96RTQBi26+ZIkkqiu4kq2ig9BdyGVUJpbK7ytplSyuIG19ZHGtm1linZF/uZbVRlCJnL/+
 W0di7rfnUvp/id9ZF9R4KspfHOuew9XcdqMH9IltPFtLrzzZfIrFsjJxqyiUVCWYMhgBY/eBQDM
 LBmLwmN2Ule6KGwaPocG8t/95+tePA==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e65287 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=C_0j-PAzlxBuy3Ei6pAA:9
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: MbQCWgoJ6b-p1UPc6zx9lQ_JEsr05S6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On 9/30/25 7:48 AM, Akhil P Oommen wrote:
> A8x is the next generation of Adreno GPUs, featuring a significant
> hardware design change. A major update to the design is the introduction
> of Slice architecture. Slices are sort of mini-GPUs within the GPU which
> are more independent in processing Graphics and compute workloads. Also,
> in addition to the BV and BR pipe we saw in A7x, CP has more concurrency
> with additional pipes.
> 
> From a software interface perspective, these changes have a significant
> impact on the KMD side. First, the GPU register space has been extensively
> reorganized. Second, to avoid  a register space explosion caused by the
> new slice architecture and additional pipes, many registers are now
> virtualized, instead of duplicated as in A7x. KMD must configure an
> aperture register with the appropriate slice and pipe ID before accessing
> these virtualized registers.
> 
> This patch adds only a skeleton support for the A8x family. An A8x GPU
> support will be added in an upcoming patch.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 slice)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	u32 val;
> +
> +	val = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) | A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice);
> +
> +	if (a6xx_gpu->cached_aperture == val)
> +		return;
> +
> +	gpu_write(gpu, REG_A8XX_CP_APERTURE_CNTL_HOST, val);

unless the effect is instantenous, this needs a readback

[...]

> +static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
> +{
> +	return ffs(a6xx_gpu->slice_mask) - 1;
> +}

#define instead?

Perhaps also move it closer to the user


> +static void a8xx_set_ubwc_config(struct msm_gpu *gpu)

You modified a6xx_calc_ubwc_config() earlier in the patch

is one of them unnecessary?

[...]

> +static int a8xx_zap_shader_init(struct msm_gpu *gpu)

You can borrow this from a6xx_gpu

Perhaps moving such common functions to a separate file would be
even better, I glanced over the change and there is probably some
potential to commonize

Konrad

