Return-Path: <linux-kernel+bounces-810206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01490B5173D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B04681AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BD431AF37;
	Wed, 10 Sep 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eb/iU509"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B24245005
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508530; cv=none; b=Xog8UiA2afJyqwxhPti3YEeRoxV1VsCMWg3TEeUZpHeLH/daTI6Hqm+VmmWSe4Z4Oyixxat8nJYRIAzak8FNk2FfWjC+NrQdxFvphdoAoF70PXNHtLwxlK7u9xiBCreuJkqWgNb1pZ8lK5plIrbCqXUmwp/a0dogJqqd8OBLXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508530; c=relaxed/simple;
	bh=Sa5XlTaknz8Q2bGhSjnRD0BypV8mOQK0jc3f3H4in3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7W0b6+rFafKyzXiUl1MJzHyNZUN3zlx3FxwEYWHjGjobK4XDmEdYHLgZXh9fr0Zy+uOTucL9PwlxhwQSEa/094INZxbXybpHoS1BEFuBnZT2TprW8qvDnqThngXpeipYi6byhqKBPy2dwMx1qYdQdsskaOM0OaLsIFkygMZNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eb/iU509; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgE26024531
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2hLzDCHQ287+835m55C/xeetdRQfkul00hmOXMYpJPE=; b=eb/iU509PSQTrGCB
	gdxgseS4bxmqf6d5tCf6/BZIv7GJhIiXcJ7IDFYc1VPr0rVPsBaZoFxQckC6ChUO
	8xrxv+71kRnFabbee08/GiUHWb5FIYLLyzEJsb0MFYUZmL/r4FXK0l5oRoiQk4UG
	H1gn7e0SKV37BmH6ssECSBzyWkgnA4Z2UBH6GHV6gQ+Ikfx31PEOlQHbWPxlEQMw
	8XveI8/zo+/rblh0B+Fc5HRAwfRRs2qobZBldpVhJIoLzlq4BUlPzNWVRmsoeSs3
	tbCgv858lHWRhFV3vDyJF1UbWr6b3LbJHfM05+5NMoeddvMGdQbXLrqTX8qBRUak
	4apKKw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8kw1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:48:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f92a6936so16390511cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757508526; x=1758113326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hLzDCHQ287+835m55C/xeetdRQfkul00hmOXMYpJPE=;
        b=L8oZBldrbzuqFbBAdNVXInk6i3VAFH77JuEMe1srcfKMUzWHMo/JvJh12VJ2oCpo9y
         fo8Uj0clTss+NGXHZpTUncbC8zMcrAy3j4YplJbSVNVReLRE1Nf/d8VrelDxVc+V0WVT
         A0DOPUde99nUDg/aP33NWxNBX+yycPWA21dB3Y2dX3JH9jQp54qLqNpraGw0nVjOOPS4
         UUV1++9Cl4gcr66sT3N3NjMHSxFFGmY6dfU7D4+GsnOK5BzaF8vVVttqT2gLQ9vj++nO
         VSU4QK98+USM5Y3khT9mc2NCzqrOrX30J7RtPahAgeVflVBoGTAxVZDvwZ/Pvg96A4Dm
         aQHw==
X-Forwarded-Encrypted: i=1; AJvYcCVd2043uYf3pdZ+43igQ1EQ8Vztth/PE69CJo8s+JnEzFU6L2Rpd26+BYBtFLGb8De/TemmLHhXz19kYEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7QWnVvosSBBsA3QcrYiGMZ5/Mqj45O3W+Qo0N0Z+cmOxwkiV
	ujJXscazBKyGQkz6coIATh/URbnxPJsS4BRNIVuRF3kK4dDo/rh/1pe92TVTMU4k3IBqlM1nZP1
	acvC4nzXyKQBMI7Eix0q8/McGN5nZNx9B7YEc8ieJmv5F7v9GGbQq6mbRG4qB5u04Wsg=
X-Gm-Gg: ASbGncsoL0ybGTJTlUvojMKLQV2w4PrcfAOeNV39PsKTznmM536XU4PrZDYW58dv1Pb
	g85rhHAWocVjd0YC7wjNHlNyu6mQ5Ibo2rL+rduXXWKMeoE4rsmnmiGUtE6pKMqB1go2UBAqX4i
	fM+Own74n13WH612eabgCnhf1tsskFUDRlGpvyoG0XT+ifoS0s/Z9gXRz0Afz/wehbKETVICzVT
	0NZ2O8YZMtBhcKPQ5lvU5auZUk2GW43gcdTB5jr5TuFu5csV1SJAYgUDPUTmOUHY7DafTaTSABc
	LRv2IfnuuivD8t5i5oQC2hI4mq5f+5jSyrMg4dq395ClHmelTjyw5LzaOnnpq3r+jUyicfTUrGR
	k6zra1VDnD9w4kE9MwaQNsA==
X-Received: by 2002:a05:622a:19a7:b0:4b4:9070:f27e with SMTP id d75a77b69052e-4b5f826059cmr106840781cf.0.1757508525888;
        Wed, 10 Sep 2025 05:48:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJJlCuiyW/pcIWNAfk0Cxu+p3Dd7IMOZXLW6sjV+Sj7pqR7+0vV4WzKU91XkLNccK+WxwgQ==
X-Received: by 2002:a05:622a:19a7:b0:4b4:9070:f27e with SMTP id d75a77b69052e-4b5f826059cmr106840241cf.0.1757508524991;
        Wed, 10 Sep 2025 05:48:44 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783049ecbsm163687966b.8.2025.09.10.05.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 05:48:44 -0700 (PDT)
Message-ID: <9463ba5b-f305-47f4-854e-2ba0dd41bb32@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 14:48:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
References: <20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com>
 <20250910-a663-gpu-support-v6-3-5da15827b249@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250910-a663-gpu-support-v6-3-5da15827b249@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX4vOp8vUo2YAm
 6OV4Lm2qoeQbkaK2D5fP8cvKV/+rhW5T4+9b8xtHGR9FzpwFdr17Z266xXAqej2GwOGEiaCzyC+
 eTBIvf55J+2aVElpUfkTuuuuN+WYi0H/4se11Vq2s2lOGbjRJcLWd5udfI/Tr4vrO0H1bJYCo1V
 dXdYw+VCZJcfIvdZ8pAiXkrhnmRshvEq3wsJz3ZL5gf1HI3/8FDISTRDVmnYyn8oyfu2Jja761R
 OAb4VhXq5GkY5z3QrZZPeiXsso48RQmpgnJvl7AZCY+xdb79mkDh8wCUBB8tOctBE0PRqQT2tQG
 ZKniuzdXdEsQrqwT+NJfHoN63XRS62W7qi/UUAtsXDkqun7+iJ8mK9e5DxyeJYE8X0H6lTR+I8W
 QQ9sv2fe
X-Proofpoint-ORIG-GUID: z4xH9S6PixfRjWE-5I_BovXHRuAozhNj
X-Proofpoint-GUID: z4xH9S6PixfRjWE-5I_BovXHRuAozhNj
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c173ae cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=EGTmXSwiq2C_3XJcCkUA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On 9/10/25 1:25 PM, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> 
> Add gpu and gmu nodes for sa8775p chipset. Also, add the speedbin
> qfprom node and wire it up with GPU node.
> 
> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

[...]

> +		gmu: gmu@3d6a000 {
> +			compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
> +			reg = <0x0 0x03d6a000 0x0 0x34000>,
> +			      <0x0 0x03de0000 0x0 0x10000>,
> +			      <0x0 0x0b290000 0x0 0x10000>;
> +			reg-names = "gmu", "rscc", "gmu_pdc";
> +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hfi", "gmu";
> +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_CXO_CLK>,
> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;

Akhil mentioned offline that having this clock under the GMU node
is a hw team recommendation that's rather platform-specific

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

