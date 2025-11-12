Return-Path: <linux-kernel+bounces-896930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE92C51944
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D52FA4EF277
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2832FFDFF;
	Wed, 12 Nov 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kAGdreiM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qf+pUksZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFD2FD1D5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942071; cv=none; b=umNnE2vBDepy+nLWc+KUBfu4WE9mZ42i3U+KvUkYIo/ZZtm08E7gOBJ4SQkK6uocZ5zCZNteABBV+WL/JvWfqm42Bt/ccdamee9UdLdNq7A8f7RCUMotBet7C5nJK8k9w4uf4n5o38QdldOr/ZhntvRXPDdmF1GVjooPMYXf4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942071; c=relaxed/simple;
	bh=TVAcGPnABcNOszTgcAJl5hDoV/qMbNyV12hdTLLHVSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5/mxoYNw7y/rRPyOvdPvChylymsIG2O3G3oe3ai787NzOnGsGLbIeHmVM7dsiRY71aGcJ+zxyTRR43H7Hy/8Zuru51eDoirHQzPB2tA80jlxX8fTIPgikM1GercH/vR3B/3yeoLruhZPRchr1GT/lfNpYoKbKUYsVp1YmEsng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kAGdreiM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qf+pUksZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9hXxO907905
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5tMUAPHj3MTUC9Ymia6xtrQkXoeMohe0oVZfqEDumFs=; b=kAGdreiMYqZZcG2C
	a0uUG51Xyaex5zm8dEzDifgrYM5roPuhPx6kulk58BS+3W4TQOgTjoDq/LETD+5v
	toGP7tnj8cm8v2VOP+Lz/IpXCakCM90iM38mvClvDOeFEsYdpaWGBXd1aHjxLjpp
	AG2iXmEwEz9WwP5KH0yLT47UkP4ZycamLGgCsOVpOXREEsSXGEPofqjIuh1/A6cl
	8LeM5ogKJJzUCQJLJcS3TvjBK/3S3BtpOkBOzEhYPUkaFk6OcMno02VIYZ06WDsx
	ptIuEYHOCgcE0bzK3p9fTf3uJs5R1wFxbW1ukttPz3Fs2uSqO/F6CPSlVCgrZfQs
	ttvkZA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqur82yh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:07:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edde056714so411821cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762942068; x=1763546868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tMUAPHj3MTUC9Ymia6xtrQkXoeMohe0oVZfqEDumFs=;
        b=Qf+pUksZREPSNXsoz9oOS/eHyEasl2qTaaC847PiZRVOdajV0AHuwYOO/sPqfSR53d
         K2vMc9ZHEvRPE21AQ2eN7N6/7W3hCYJ7M2ZKRkPEfkg3fr8ZbimbQW2oQBvBI7+tuT6k
         0g/0ww3nfQNH8O1wd3PIkzmWsvTGQbc2RGqfDxtxPu758GkgD2Ck5Lg1kw7N3MaQLL4N
         KA3WMyhJCZ1PoPLtkkMmpa+5T/q1r5o4a48QWeWi6kusZlswhoD5fJOpRt5c1NslIIxE
         mCGp8iutttVWYUQ6tdd1+UpEi1+Ep3JIQjuXM7/soZoCb8DOuFbtD44pIBPr4mVgkbcl
         0ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942068; x=1763546868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tMUAPHj3MTUC9Ymia6xtrQkXoeMohe0oVZfqEDumFs=;
        b=sNmGNdfPtgnV9DrEYZHez8wAidJhrGxMDdrcavUTLH9KxKOXq+GwGjhgzso/M+kScR
         1rNuNyVs+VkpQzoKJqbZ9xPbOxjwfDpGdV2ZkeAtIZ8CCgaJYm0RvStrk5dSUERHYSZK
         Cujjo8kzHnzv6JTk2n8TDSVWeD8itd9sTNuNcIL0nGyMmFmvjrNHwwPc45DjPXCEY8V/
         hCktHTrITOugjWIVlf5eBnBaWcRCQPjAktGhOYlIhbqL2XduCxb0cZYqnfKUiO4qc3ye
         O1UVVZMkVGIgUM8bL0STzHY14YYDTcyJCYplqK8yn7CslrVNp0hbuujI2kKTLDsvedLC
         nQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCUqJzFfwdr+WXz8gaeThEWkSODetiVwm2cF9gEgZLYhewt2WbMXW7NYxoEwVfLZqfWwCjuSn8tDP4l2jgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFeSbTpcmAVl/qpVFBv1vlkJq4PSQCb69D94x1DEVyJ/Y7yPYh
	7K85pL2+R26nG39qhh/NipJjX+eEwXuwx6eHcCXTC7U9hf8/3k93afHEFOSjLh+fuEYU/X8MKoV
	zVxoGkPT5XSnJWbeHvgg1X5AK8vks/8AWqq43dcvmvMc2ZH/eSCibyaqVKQGwMw2L9oE=
X-Gm-Gg: ASbGncuNPQ4zwN8iCYEq64pTtUKeQVz5Di51IF5XCRjyjl5uC9GbvYR4jB1jHgo5Uow
	owzRK6dcCNYQiMDD9hbG8VKsN2nYXD6fpM1qdQqGOuglFnKjEwrNTLJIAvqVZ2jXZXnciBBqphz
	kEUYR+3q1BiAVa6FwGQxhQV/oPQg4msnBuB/b1yjC9z5/jFlghTjE2m+xw7sPJVB44tJP8k2Hnf
	y8lx0NeYNALmf404EXX2WzEnHUOxdbCZhOsqio63ykQqH3fsWoOHpQ+TWEJRDA7W+SNRkT+Hea1
	jTjCZ8wJOEkwJsE2i+7W0ifiNq5qv+jRD/13fRj2KLBn1XE2AXNSK2oUL7msBLOIE8+e9aO8Aav
	xl1DytKMvD/pU6hRrUlXMxq7Xx4s6e1iao9tUJ0qqqWSwM+VCyrk58GYB
X-Received: by 2002:a05:622a:18a2:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4eddbdad648mr18859841cf.8.1762942068463;
        Wed, 12 Nov 2025 02:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd6taWWH3kgb8r8uxKAXxyDkXj9rB9AL10HGL6oyqqdNWof71H5ltc/gx7kawJfP1MWxxJCw==
X-Received: by 2002:a05:622a:18a2:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4eddbdad648mr18859471cf.8.1762942067993;
        Wed, 12 Nov 2025 02:07:47 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d3baf872sm1427413366b.27.2025.11.12.02.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:07:47 -0800 (PST)
Message-ID: <da9e9d31-7745-4eb6-ac24-50905dc2a133@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/21] drm/msm/a6xx: Flush LRZ cache before PT switch
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-1-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-1-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4MSBTYWx0ZWRfX8xuU4XKHFfGR
 iG568skmnO99cATt3eXugJ8i1wA3U9JyAp2LlVa52/uIUtoO27vRw+IvjXLIVs+gCl1PNXi/U9l
 PltFYbw54yyUz/tLgTmF2Kpt+mPKGaOdtHUX3qhYb7wwtua/Sjrlnp0OvU7SQhzvgA3n8ZBImvZ
 gUajt7JCE3lIXit3uGIfnLJxTY4/p6oa72IWyUf/W4o0Mh+i4JbKlGEtRb62M1VKt4mbFouoJF9
 WCHzLEm9bsts4PuR6gEHUMmvif3lAt1RWr1lS8SbhXNpF1138PHkGXMpJP1gOmdXRqpU9blosMw
 dmrguH9QKSFG/LFPv4Gf74hsbVpa2dnynhu7DkGY2iY3VY5L8qxJGBl+URplzO39ZkC1q4X9+Vm
 V/zd1lLwY3199Nko6CXI5zXxI3YFDQ==
X-Proofpoint-GUID: zCyxAXdwQBTe4XePYDEXb_Gje0SAsX1B
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69145c75 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FVkm2KtGXHSZZ5XTrLgA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: zCyxAXdwQBTe4XePYDEXb_Gje0SAsX1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120081

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> As per the recommendation, A7x and newer GPUs should flush the LRZ cache
> before switching the pagetable. Update a6xx_set_pagetable() to do this.
> While we are at it, sync both BV and BR before issuing  a
> CP_RESET_CONTEXT_STATE command, to match the downstream sequence.
> 
> Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index b8f8ae940b55..6f7ed07670b1 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -224,7 +224,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
>  		OUT_RING(ring, submit->seqno - 1);
>  
>  		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> -		OUT_RING(ring, CP_SET_THREAD_BOTH);
> +		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
>  
>  		/* Reset state used to synchronize BR and BV */
>  		OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
> @@ -235,7 +235,13 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
>  			 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
>  
>  		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> -		OUT_RING(ring, CP_SET_THREAD_BR);
> +		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);

IIUC downstream doesn't sync here since there's a sync after the LRZ
flush, but I don't think that's a meaningful difference.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

