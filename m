Return-Path: <linux-kernel+bounces-896954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54ADC51A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FE83ADD55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874802FFF9B;
	Wed, 12 Nov 2025 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHG/U/xg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hSDKofYN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B03019BE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942692; cv=none; b=al3Lw7OQY5Nz7+iW4KGAwslJiuXCgOSWX8OHDGPtj8JwrNUi7y3oSwdJ8EV4PE3l2R7OKfIw0heW1gJf1+UrtnNRx7FwPq/hAbSj4CXuTuv0m+KGhJFsxuVxMBpUxASO0YUcLsvGeG/5nDm01XjqLlozVqibL9JpSO3hWVKM3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942692; c=relaxed/simple;
	bh=6ExUaprOrb7bYmHFnlrq+UtunG+UsbsFRXBeLvcjM0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et/yOGNvzlC1Zs4IaRYx0CVYJVaUnwJDjdmTCzmGKBTq9E2f9xs5sYXlCe5Z/ED8XSu4HC943+osRgJ9Yh5UQJsF5VAiF+GCkciivDQ0ecN4Ag1pFYrwuMQO7d+wP12bdVnOpTg+KVrHMo1myuYnZSMRnX3asakLip/vAYTbJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XHG/U/xg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hSDKofYN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9X0V91001753
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/lopT9opyCf90Ve+odq78rypOpIc2a0jmLTtA1UVZ8=; b=XHG/U/xgXOWnwci/
	cbr10cJY9Vt1KgKxrd5wTZGGN7zmOyK3bgcF4K16kGw2s+flbPOVsa5yuY+U9C71
	GUdBTbMP0/9VrCf6+FqRxann05mQXG1D6YLuLAQXMEIFZSf0AUa5FG+JoX3RiyAB
	RR2hEBqBi1jo18d4cxDgheO984q1tR9tsiBCi6yksRqG1uO2QaOVtW+GxTpRASn+
	Rwl5DE0SBlnvtnEfMDP1pKUdc8H4naeKgABrfuOEZOvelQhB6UKWgk69l3UKWmIF
	/z5QGbCOmHcBTIBO7rx0gkghX2PaWhX3rGTitX/HYNfaSywUOHYw6jsPsXOxVZwS
	PykLqQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqq207ex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:18:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-882414eeb90so2020836d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762942689; x=1763547489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/lopT9opyCf90Ve+odq78rypOpIc2a0jmLTtA1UVZ8=;
        b=hSDKofYNWze5tcK0sSYaFi57CPDlREcU0jGeJg3//+YBBd+Oi6mgB7CthlCBB0uFhR
         hMPmyB3yDD9tnUPxGnVqq006MyT6yPsrPG93LNukq4pXlvzuQd3IMMc7NJOtC3pYjuFw
         Vb1xnzH7kICiHp32XEh291fiR0dTAKJqQmXAL7NCgKlztqkf2Cj1OkQJQ/srUb7Mjdpq
         YG5cHKVJ69J95KvCZ2bD/PWPEIz+DLevZMu6o+xQNDi3AbL8EBZi1ZFTf1Q322VsX0+P
         IRj7Nj+wMgQk9F1ByYfifDIrh5okKgzuLv0VQWuJBrMLk+vx+Yvn3ik4/GrSs3CKVbX3
         Bd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942689; x=1763547489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/lopT9opyCf90Ve+odq78rypOpIc2a0jmLTtA1UVZ8=;
        b=s6Ih0ITIYz9jImzEL5cqwJjozBWciUxW9l7hXEIOLiyzD2jiEYKzOXZ96u3EvQkVj8
         YE4mITi9fSeaxqG7l+0RCpi9KrirCKWJ2cKd26D70ZVEMf22sg7dNsgytCXPhzFoJFwB
         RKy8Ot/NTJiIMmNBA6Yonz9xOuDbxlwZETdT3Cj6CV1DRIeVpB213IXnRVPfEMKXc17T
         oFk0Kd6qqzE4olb4SLHBateMKNwasgA3VEtakyb4Akak6hAZqErm+TnLAKOwsZNNEZLe
         zGtoAvR4gZTRlBj1XiijO90ToeXJSxk5Ui2Rzt3YLyxIeQl4TUpzDMcTxyPieNG7EruI
         UCog==
X-Forwarded-Encrypted: i=1; AJvYcCVgRSMdBk+b4TEGvYIA3WtgJHn3ZSNVlsMx4qTEEGyyQC3ZVK23nJygM2grqbFKEnrrSSdFBAey9bmTc0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxz3dnN7hDVBlehExn5VtBnZzu04D0LXLFqPlfDBsmS+g3tvk/
	cw7PQh1ZZi+2aqhU7ds94wLLj2EYq/YPpgU/W4TsIDBH0cpOMEbjZCfUoi/W9moZiuudxEQXa0L
	+rAtqh3+HeUJrTnPinNYDIsae8pi895LWVdWhbGG1XTxYF891/rKVz3LSleLbvC4YnDA=
X-Gm-Gg: ASbGncvRQsuVbBMecIGVIkwLxylsi3aG43pfA7+i4nhPItZhxme0fezZ1PZobBPV/+G
	SnQlvvfGa8xkLZt+Ntog0br/5vj3GNz8fLmclAwBDln0VQ4QPjxC3BHkMefgANTUVfGiQFsn7Qe
	LaBKeVYci28YgHIJS9wjfRU13ZXPoC1EHkeWA0o2caQQYCx4Er4rESbt4jKuKRHlqhYdA5WWfZY
	CjC11yH2987H0z2Qcw5w0hPQdM6KLzNV5TKiMqDMyM+90aaWW4n0WKXETLjkm63ucoo1mAzqN/J
	ROxN1XCc8jSEKwekW8+7czrLYpCunCODq4X3mITKAFX4Vj+mDAZhTybcNYzuOC8qJFvRDGTkeNB
	YPJwOHDYZYGzuV+cJ4Skq27Qcgg3EbT3oeXS2umDhVg0SPuWegjkBvGj9
X-Received: by 2002:a05:622a:2cd:b0:4ed:70bd:d9e2 with SMTP id d75a77b69052e-4ede41f17b2mr892171cf.0.1762942689273;
        Wed, 12 Nov 2025 02:18:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYtQ29X5tXvxSDaU/JA+AKkzXH/dnj2dUKb+nxLC9dFOdNM6v1tgVxXnY84nYUEM2+bTg7cQ==
X-Received: by 2002:a05:622a:2cd:b0:4ed:70bd:d9e2 with SMTP id d75a77b69052e-4ede41f17b2mr892001cf.0.1762942688856;
        Wed, 12 Nov 2025 02:18:08 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm15397422a12.14.2025.11.12.02.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:18:08 -0800 (PST)
Message-ID: <a1273bdf-d926-48b4-877e-48d5ff45e7d9@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:18:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/21] drm/msm/a6xx: Fix the gemnoc workaround
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
 <20251110-kaana-gpu-support-v2-2-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-2-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EbHFgfmC c=1 sm=1 tr=0 ts=69145ee2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=B6ldIsYNqgrP1okBzpgA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: y-j6climntZOb4cTcRxbKwKRetCgj-fc
X-Proofpoint-GUID: y-j6climntZOb4cTcRxbKwKRetCgj-fc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4MiBTYWx0ZWRfXyRC8qwKTlmRd
 f6zTVQrGRENush3fCj7TdtEx6o37xcOU1QCK/PsN21EIX3ph8aHyA3eFJfPQ7bKnH9riBgRSCxI
 Er8Eov/CQGyc4vxyJfI/LgCQipWy6JwyNOQGB0xPYuipv6sha48C1t590OB8G4gzfZ5mTEncLZC
 OpM6q4CsG/Q+JuEeYNPDhGsoaNHwKBb3GIBUCCllD1R/NV09Ysi/0+S5XFJRbRFUy8bxnhcb1XJ
 K7pdj/FhFY1YqbsKazQP7y63FVc4fYI+qY+m18k8MTbQH2fp2bLGmZV98vi3/DHwSbjYHrH4WKj
 n0cW5deXFKcISC6+7W/aeq13G3nk8TEj5t3N89InhR1rdPzyqUnpdaj5dAwVFfgiz3I/jc1ifVH
 zkgWXO7olTPu1RtFAEERIg1CaTev5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120082

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> Correct the register offset and enable this workaround for all A7x
> and newer GPUs to match the recommendation. Also, downstream does this
> w/a after moving the fence to allow mode. So do the same.

It does so for _notify_slumber(), but not for _pwrctl_suspend() in kgsl,
but in my understanding, making sure the bus arbiter doesn't gate access
first makes more sense

> 
> Fixes: dbfbb376b50c ("drm/msm/a6xx: Add A621 support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 4e6dc16e4a4c..605bb55de8d5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -485,8 +485,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
>  	 * in the power down sequence not being fully executed. That in turn can
>  	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
>  	 */
> -	if (adreno_is_a621(adreno_gpu) || adreno_is_7c3(adreno_gpu))
> -		gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, BIT(0));
> +	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
> +				adreno_is_7c3(adreno_gpu)))
> +		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));

Arghhh copypasta, thanks for catching this!

Konrad

