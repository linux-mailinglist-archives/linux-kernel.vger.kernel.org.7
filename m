Return-Path: <linux-kernel+bounces-865364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B9BFCE3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24FD84E3E58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808934FF47;
	Wed, 22 Oct 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bkEZnLBu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DC34C987
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146848; cv=none; b=HYBm+OAbas3mW3XrCaZ32gzUte83HqMXaS2BvBayoc+b1+7pu8Ea1efQox3dvLXpEfRea6hMMc4osuVLjTDpTXasbmqoxFcroerVDF3HVkc3NvbQQieIAjGhWlATZP0SSDMIBgkksWkOOgEQN4INOxxu9eU0iRG4Xouut6US4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146848; c=relaxed/simple;
	bh=1QBplYuRdegJvfJ0QvMbSZOyGdzUajRV4zloL4AZLb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQ1zE5Mm7rdRIjiG36rnkRSS03Qg2gPmoMnKY9N1RriVq8cZkWDXCZy3JT6gYe7E3tcS6dLI9HQ42XPd97ddSMkTBOaNRZ/j9INGHL8PFwl5Zt2qEdW/8lTTaSiad6Lt8HoRtiX2N1AY3MMc3ISTx8vpg8BVMgpbNy0+5My2db8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bkEZnLBu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBELhk027492
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8k/FmEKkL858bw0NvFllXkz9skuIxCCBY/vWAZsgTMY=; b=bkEZnLBucAJH7pXS
	V2M0/a2S9dpvkoIdlZ/FDdD7fjQzTwoGURX1SaU9aggJIieHyBgV9+dZeeMsbxd2
	PTTlxlkAKVkyRlb0uP9czwXuhBqDdwK8gEs/5OCNtKGrMIakilydsLHxHGNaH20Z
	mCQcqAa7QgkEk5ydwnyLrYz93Hnd56JXjCUh8WMrHWtqmqk5TwESltvcUafv1vhp
	AK9X3pnGwNksDAbLQ8AtOEYrqbhgULbB+kmtSxUmLykYaEYE1NzID3E4ee/MleFF
	2lxZwWPqBxWRGDEall2/N2agY4Eti/189H5rifc9C39DU88mQ5cX1XermOgq5nUT
	7zOo8Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j534t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:27:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c1c70f1faso26715306d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146844; x=1761751644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8k/FmEKkL858bw0NvFllXkz9skuIxCCBY/vWAZsgTMY=;
        b=k+Et8mOINVzS4PFRG4I/oQxoZs9w1GJ6lxj0wRetfueTaSQTbtNJr4GYCUtvoi4R2K
         3Fmgj1kFzPgAPVUkHqDtugvXWLnHVLdPg6OgqdDzXgdh2mqhen8d+G3wMIrb4vtA5Ut2
         pky2dRbVHQhX2tz25pkewRU2wYqZ5Rxld9zogE5ZIlUlQH9xE3wFuTXQ0nmx92an/inV
         WKm4gcZ60FzMswiwi7rWolvo9tfnGMOIFYidcwwrJny73A5SJF600uhGsQFZBM5d/Clo
         ad9JGl9OGn1nN9es+mVKmxfwNHDH9rbzF+bbFXARdfvexUXb/5VnGfi4EgbpqHNrBDg8
         6h9Q==
X-Forwarded-Encrypted: i=1; AJvYcCURKF3NXTiQ+MeSCD0ykyPcy9RwB4RyNtdHA8d7XD8xPBj6sOsAuGt//1/HY6G1LIYmIVBiVktCXhrhIww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfJtMKPOGRdQqGwIwf8vEheHcnffc3TIqngUtm6xJPzmZiNsL
	bAOlmJfH6uB+RyJRDVu0P0ZvEJjPgD1vfoMXvCtdwOJcoVC7eW9++zVlzfpgPyARuP0SyocVJW4
	q9rxgdVxBCSeraThhuG9gMiSFlOf70aNZmbh6rEI4AWt+V8DGU7I/AdWeWAuWPi37/HM=
X-Gm-Gg: ASbGncv7uzVBc0dPjjkkN4uJK/NNNwe9wd3LI6/rzg7r7Bb3pFHQHSBq288qiAyiCtq
	m9GKNPEh/ual7vWfsiZXqLtLVIMTPjX5wAjWPjoAn73ONxWp8IvRrXZcfoaymjPK6MlwPoIHrex
	HqPR4PDCcdnV0hDb6ulxBTDluGnxcCqMRN6TpFlHqovqVJQUqpxkHkxC0stFnBSGz0BOYfUgJtP
	TeIwbIe0o2wP+3F7kmnBjn7z0MtChYHVQl7gyCPzi/OlzyRHvx4B1BG6l+5cERkoHKjkgUiTiJM
	Q8xvG0YWiUqWxAbECFideuEBQ5iwc3hcIYjZOejWW+5I7ykp3k0kvf7V8yDZypFwT3QNVaTvZoK
	Yak4LjAnPNod5FzDg6qzPdsbdXULrtAnITLvpdeRqj0lTogmWmOilWZ7U
X-Received: by 2002:a05:6214:248d:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-87de714c1c7mr65707226d6.3.1761146844595;
        Wed, 22 Oct 2025 08:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8/xeYz1XYBcdg4T4l6woigaSUVTSHt5t3v8BurU4yppUfVX2LR3sMLl0zpGaHU1+8ugjz3g==
X-Received: by 2002:a05:6214:248d:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-87de714c1c7mr65706846d6.3.1761146843645;
        Wed, 22 Oct 2025 08:27:23 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949beedsm11980254a12.40.2025.10.22.08.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:27:23 -0700 (PDT)
Message-ID: <fdec4bf0-6d88-4a9b-a81a-061476dd9e1b@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:27:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: qcs615: Add gpu and rgmu nodes
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-5-0baa44f80905@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251017-qcs615-spin-2-v1-5-0baa44f80905@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX6ztZcIzYjC7v
 lUF17G1hzYBSv1I28OEE3zRIO9ML3xIVUCVwJeXFGtGIj2lr9P9dfpTDlpkmEsOmHuEjMbcClEy
 z5y+lohZNmRuNNOB3szr7Mb6GjyURH2YS+zTs9m0BfvL/0+eaH/9c8DIPYRnOc1MwNJIQUMIbzN
 FnaEVjqhq2m2iWZJMdH4DsvH1Dd0Cxlo78rP/Gau0Z9B0MDJXSIZRQRbOXQnqfIg+BvH+iMeHFg
 D/kAgMdlhhgMdtvjxv92mQDfExK9rDkaAqgk05K0jg7u1XF8VIP8bgaQ3FMKvIAO/ZUDxlr7SxF
 wUHsV4sDiam0YMC236Di88Dc7U6HOP95Pnc2B1+j2odpSM/4eIur9pFblSAkItPhE3/GS1UEv3D
 dKBjOBr/QnNUq+WsAkmyVcc9nX0FzA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f8f7dd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=e4uKRaRUJts94r9YfvAA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vembOtQpv6b8AY7eDgbW7yAm7NC4jraa
X-Proofpoint-ORIG-GUID: vembOtQpv6b8AY7eDgbW7yAm7NC4jraa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On 10/17/25 7:08 PM, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Add gpu and rgmu nodes for qcs615 chipset.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +			gpu_zap_shader: zap-shader {
> +				memory-region = <&pil_gpu_mem>;
> +			};
> +
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-845000000 {
> +					opp-hz = /bits/ 64 <845000000>;
> +					required-opps = <&rpmhpd_opp_turbo>;
> +					opp-peak-kBps = <7050000>;

Are there speed bins?

[...]

> +		rgmu: rgmu@506a000 {
> +			compatible = "qcom,adreno-rgmu-612.0", "qcom,adreno-rgmu";
> +			reg = <0x0 0x0506a000 0x0 0x34000>;
> +			reg-names = "gmu";
> +
> +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_CXO_CLK>,
> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
> +			clock-names = "gmu",
> +				      "cxo",
> +				      "axi",
> +				      "memnoc",
> +				      "smmu_vote";
> +
> +			power-domains = <&gpucc CX_GDSC>,
> +					<&gpucc GX_GDSC>,
> +					<&rpmhpd RPMHPD_CX>;
> +			power-domain-names = "cx", "gx", "vdd_cx";

I think the gpucc node should reference _CX directly instead,
then genpd/opp should trickle the requirements up the chain

> +
> +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "oob", "gmu";

1 a line, please

lgtm otherwise

Konrad

