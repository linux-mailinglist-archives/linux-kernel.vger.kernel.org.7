Return-Path: <linux-kernel+bounces-897020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FE9C51D32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B53A45C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E43090FB;
	Wed, 12 Nov 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YlTfbT+T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jtISGwLA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CF23ABAA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944970; cv=none; b=gQuyeVgoiNMoxnwDoE2imzzpM9pW2qaGCFLJwBInM+ok2jNDY4ZPKI9FcnCkNINmOgXLjtmfXp61gz+W31f2G70oQvnAD6Prcm3LfTrwVyYOGsD2u3bHtZugKqfAA+hmX64aYLyeeL32JsOTlKOzzwDebshPmXEB+uWG9Dk3Tl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944970; c=relaxed/simple;
	bh=ZzpEI9WgfiZ5kliVes5Y9Jfc8V8uQhcrISym6yczJ2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLhyyt3x/KClzJCJaCYvPUXD/X83hc3wuBqoCHro89e3VgSpYt9Cb/xkc69J05wS/ysEqfmhK8CCzfRfjV3gLsS7jkCMQBiZSpblKCg4e3ynI8hg12btquzNt3JPU1o7b7RA2m6WMahBHtA1msi6T7GNIAg3cAOkVlA0LUkOIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YlTfbT+T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jtISGwLA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9gi2r1109175
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7J8baXgxyTkhN2ZdMYqtwC3Hhdgc0z63es0iUEKVbE=; b=YlTfbT+TpP6Q//J2
	88dZBFYjCM7mJWQbvLvCgNBnt79B1djKmdfOGuzl/+iuS3qaHSbgt8nZm9geeWJM
	EwucGUm3IpaplnqdDfeWTdrpoCVvJeAa0SlphjJx/CipbmbNbfOWCvoG9sMatwTH
	tHQ/dxIhZuY1GhAaGECAtuO+JzvLQACttntfzqIZC7a19Cw7Bzvqfd0Re5N1viYa
	OGTENQuDwMfZhdelpH3rWa43UBIvTuMqKThNYEGIjsZjkllXWb++ZOtls0/VL7U2
	NUr1jhbOIGY/esw833NUGvru2Hdy5K62Xkeftl/wTpZSV2SxrX/ssMhfqEsxgAec
	VRvoBA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqum0769-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:56:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed83a05863so2058111cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762944965; x=1763549765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7J8baXgxyTkhN2ZdMYqtwC3Hhdgc0z63es0iUEKVbE=;
        b=jtISGwLAumaL3cq/Xvoi3TWYMeYMkMJQ+webV257MiqHE1m6pJwvvP7b2cz7ifbjGT
         pMWNRUXleQnDf7OMXfvAu+VT05Ki9ihhk4PRGCgfs1tCLv8MvbU8NO9RzvLu0OQOhO1W
         kSKHSjIcIyrWSMkB1N2PQm0/xx1s7CRY4E6U2fdCIYMG9pmX/zFpfxrPRKPoEYK8imaX
         /DYQhqzZHlp7RQAU1lmHwUW9yXyGBm3iVPWLgrheq870MwIUYKZ+PiQ2sIMt+TiX0PNa
         Ksnn3g/JIRCi2zVjTNx3ygED099EpRyY1JGkPVoef0U9Cp1SulV028ckMY5nTXZZiSm3
         PVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944965; x=1763549765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7J8baXgxyTkhN2ZdMYqtwC3Hhdgc0z63es0iUEKVbE=;
        b=Oy6hmyHXQ+m6IOc9LApVcReyZWeubhflpv44vD5TsrFsxlSqrPJHPcPG+dOACOtYcd
         Vz5I6xnXqBr1WxPaoKo99i5gNYyGnUEKEF0dvG2pwG6Cne06TzZbH0XkavgVTE0l1g/o
         V5Sz6YUDIxZ1qPTkY8PcqAwks4nfm0s+vgXMj1QZ3crWEOYEcBGZ3W9pVRiQ2ibWSekJ
         GbY8cDhpI3Z3Fg/PVShazRgtOpe1QLV+EIuayVjSa7lJdN9apkaJjnXv6imPwFcMzUIR
         RLph0/R2aJrMC1cXokPMLo45828nR7rp8oYcQnSGd7cq5YjFBhzN2eDseW4x3O6b3iHX
         nBDw==
X-Forwarded-Encrypted: i=1; AJvYcCW42+SZPGYHNy+NmrGwzdwpm0JoLzPrM2WJcB7O+woxLk8o2IrY1jV4gqDXhoYmQDZdQ2USwZCUIdw9YaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+BmbmBSjxoRuv3okfXcaSg0077Vw+X2kkUwr3/xkZx5CfDVl
	PwDEtMXUvLeGHpwyKmimCc2GtJirmYuLAxp6X3qHUPTG5iqBcskRj6q5hK9ubRf+BnzEPF2ORuS
	iSmyfm9aXcWUFydqARu9gbsic6sPG0/+8eog9rtAh0RlBbnYpAVyyGZcaXCtYX2PoERo=
X-Gm-Gg: ASbGncvx3RHZ16M3jC/7l63VNYo1zdezpGNF9fVpu1auZ02MmUPLIuBNMzoHsI/TE87
	zah9rmQCbFeb7I29fwwPNiI4Qd0A0HxnL+2XvVKPsk01BZ+Wv3/Brz8xjiccUL76reNlZavm8fl
	Hz/IC0S3D4NdOJDoeJOOJKiykAeTZ/QduRPwaTC6VYF8+jFf04hUeg8nklD2ZcaIVKK033xpK2i
	B5zFNWIyGo+rcF+ErHL3TcXCkxxuHFRlo4JOFuW7Yq0yrY5CtdZcnWeNCb9h8o6zVZ5vPPqC8BR
	XjREEQxkj4N57hyxT9+WWkpaPFs0+T9dLz3Ylkpa/U5uLnO2pKyfzyociAd5klZLwaB2GFmpDvX
	bxcYnclcvV9fDUgucBPB/9SYEN5xhFZG0oN8o4aukHqvbQYMEfJsUUcgS
X-Received: by 2002:a05:622a:5d12:b0:4ed:de8b:4436 with SMTP id d75a77b69052e-4edde8b4640mr9664911cf.12.1762944965485;
        Wed, 12 Nov 2025 02:56:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHehnHC4uvc/Oy+HlpbxtFmbNd/Io3lA6JdYlICTyBqU+FS0kyknsLAZ4U0LhGMGqz+5Q6+5A==
X-Received: by 2002:a05:622a:5d12:b0:4ed:de8b:4436 with SMTP id d75a77b69052e-4edde8b4640mr9664541cf.12.1762944965047;
        Wed, 12 Nov 2025 02:56:05 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73381dd3besm103142666b.43.2025.11.12.02.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:56:04 -0800 (PST)
Message-ID: <8f1caccc-8a49-4c26-aeb4-f46f81593a30@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:56:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] drm/msm/a6xx: Rebase GMU register offsets
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
 <20251110-kaana-gpu-support-v2-9-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-9-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NyBTYWx0ZWRfX9BGFsXbPxeOg
 iIpDWFKDsPBpFiVHzjr4r6zHXSAoYyGBBdleL7vBEvYgA9mjancYKLkNSFVbvRCyxEpmOvBWG7P
 vR8QRuRIZdPNh2H01k0q5uQcWL1Ac3ARwMp1/XBIJJgvZdfS0ZCzcBf1jVkNk55xEZBnAhwcFkD
 4kXFPyMnroyA/XtioI+yqvokmwWH3rXA6Sc17fRqDlWYjtTaZl5z64xO5f2M2Ok6xwgSu4QSg4D
 XD0gauan4Jaalec9nfJHrr1wC2Tp9I/tauDPiPnVE5fFusqcLP69YQDhTr3F9bt6IH3KJIiH0Xq
 tV1fYS++d7urZ632qEasoMms58/+9EA5NKjNnk0Vh6r/P6y/EFkY04eOKYKsu2yB+3yNluQ3Nke
 VC072TimsxvdGY7P3RE93Ms75LYTKw==
X-Proofpoint-GUID: MNu7yixEKmd6iIlf-TCRoILWOXen4joR
X-Proofpoint-ORIG-GUID: MNu7yixEKmd6iIlf-TCRoILWOXen4joR
X-Authority-Analysis: v=2.4 cv=KeTfcAYD c=1 sm=1 tr=0 ts=691467c6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LTedVN9yYKzQwah-PCsA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120087

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> GMU registers are always at a fixed offset from the GPU base address,
> a consistency maintained at least within a given architecture generation.
> In A8x family, the base address of the GMU has changed, but the offsets
> of the gmu registers remain largely the same. To enable reuse of the gmu
> code for A8x chipsets, update the gmu register offsets to be relative
> to the GPU's base address instead of GMU's.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

The resulting diff is a little convoluted, but I think it generally
does the right thing

[...]

> +static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
> +		const char *name, resource_size_t *start)
> +{
> +	void __iomem *ret;
> +	struct resource *res = platform_get_resource_byname(pdev,
> +			IORESOURCE_MEM, name);
> +
> +	if (!res) {
> +		DRM_DEV_ERROR(&pdev->dev, "Unable to find the %s registers\n", name);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ret = ioremap(res->start, resource_size(res));
> +	if (!ret) {
> +		DRM_DEV_ERROR(&pdev->dev, "Unable to map the %s registers\n", name);
> +		return ERR_PTR(-EINVAL);
> +	}

You can use devres here too, devm_platform_get_and_ioremap_resource()

Konrad

