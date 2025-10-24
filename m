Return-Path: <linux-kernel+bounces-868286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE13EC04C74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0607750004B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE012E8894;
	Fri, 24 Oct 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OQDEc/i7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB32E7F29
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291650; cv=none; b=C21/qB1LIEYK45KvsssFvaj7F8doSqHFCkTxIwouBDT1kLCXSyQ9LGHYgASXd1bstssyA0FdGXh//fFNpeAACzrDJ/2m9fIHzq2tyogxWdrOcGXnEGHFSpuIc1+hpV5Vn7zqLQ/wk70V1jQZEJTLT52wGnkEJKixtM8cai6SSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291650; c=relaxed/simple;
	bh=ODNMMA/CeetLO44Jfr4kg2t4fIza/eWGK/T+iCha1NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qF8x7KE9kT5suMDaqnwHONsTa+mRWq7KC6AvMAvdGRMgeYFEp0wfTbHnK/nff5su38eBwVLsmbfkKKdoxx8A3EqcpFKDhAQRhSgvql7IsTvzNNVJaPm9UhspLuLyip1fTWel5CEfk26H64V3oDS76Xgu1Tb0aHPeUx2T0+6Jt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OQDEc/i7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3MHSY021671
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vPzIitDiH9otQXvVOFZwedMLZY4zXReFnc2YeCNbvik=; b=OQDEc/i7LR3QGwD+
	WXKCp8pGkLRwp/pN8ZnTAjtJxNw2KX2FMeLkaW8yH4nMTD7Z7i383DaLJIWI1ov5
	g8bO4ojQHm3WQc5ts7ZioegpPkUaesYEMrlmlc3ni+Zu2HsidjiH5BqjoxdoXkjT
	had6/f+oMvaOKOE94eHzGHEJEx6ss8Xg/VXWXLa931Pm4uqlp6jj+K7ywoNvFCMf
	E6jlY5bM5+gBpVEqhsklzpBfb8NN1bVKdV+PX8Abus+HLQ7798ZsEQ8o4nuPLf7y
	+a9Nl3Z3OrWnDtETKIf8mTVIcVt1+tCw5ejZUSp0bI8JP+WVm3Anh8W3nbgC1JkK
	zsMwdA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8nd3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:40:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87bd2dececeso5973536d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291647; x=1761896447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPzIitDiH9otQXvVOFZwedMLZY4zXReFnc2YeCNbvik=;
        b=k+k+K5nTjeUWGbC2PWq55kEUwCJCcdKQj0jNmMFT9DPMZXljflqxi4zJKt3bEm+iMk
         JF/5V5rHLT3GpwOLj+7v92T59L6rcyak2rDZ5h04LqHMgjdb6jwWDfADRbyGOm1erWTl
         0gYDUPRPqKUdPJW0mN4KGOCBjnhQK33jeFTm/b4HqugWbsoy8X0pniAj9Q7GjP0rMfAP
         QKYXWzWLIG8Nm8jW2WhLOGZzZJUzhd6UAgZlPdxGtFk+0SQpo/zXUFn+JFRdv38n0y1N
         0ncTMoEMk9x4K9ndi7gnA+hPpdh0ppYnwIuxooIZqWkPht7BIDAWvgyjACmE5kH4Fcdx
         TVSg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5NQgvPrLGqpg346SSirp8DV2WfU8gSKbiWbPXsEhXJDoYf/Rg2wqCvIe8hE7+UyVN68Er/IW1D5iPd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTHdpJCFpBcnk3Q91JRcSJ+Q4PyOu1S9p975vX91l2/Inn4rwG
	yY2bOa3DbC+WSRV3I+LJ9PZEuapDlOPIpfrUEjL59Z5EdaJY6vVF7cmk6mLvfT0Cj3K/d8aDN/m
	A2H4JfyvApcJQlw/RPpxuCdBypt5nb6u2WsFZXJtJl0wWql4IF70FTYmW1f8PqX7dKTo=
X-Gm-Gg: ASbGncvh/E6iCVigFIqmViaiRkYKtUWLWJjAZYI89qq3SqEz8lLj5yU+15hHI5QLNb/
	XPsaVgm8ygakpYsp3vAqt7PbchtiV/U0Ba9zgHOX/Vv/VRMEXgudXO9lYfRUjy5dyRhNE8qV4qb
	aa51BaZXNnkJPJfC2XZVrf4sdrdNgAZXgRPtzLM9XXCd29od5zQ5g9zurVbOVWY6y1NI8D/bWgQ
	aRBrlUnoSh8afsQ2KnVz32f9uCci8Yp1E10RTuDnacaEgCzNwxjSY9jlPszPuQRacY466ofx/TU
	J814DSwfGxpcWSfkJ/O6/G9wrLveJNB2lRxMWOqVFg3q1EYGh6IEexHP7WCGNglNruORf4Pltrj
	vwXvmHZtn+Nf3xCgfrCBsVL7YKIM9REt5SmKmm7Tb/0yaUsOstme9ZRs+
X-Received: by 2002:a05:622a:450:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4ea117b0e6dmr115459871cf.12.1761291647200;
        Fri, 24 Oct 2025 00:40:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGDhrS58k/AxKuFVBR7BBI8Y+VWeS0MiqdM4N/c4mARISKSYsDHdoSUEHIWyNAZ4CQaEeDpw==
X-Received: by 2002:a05:622a:450:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4ea117b0e6dmr115459641cf.12.1761291646690;
        Fri, 24 Oct 2025 00:40:46 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144d565sm459794566b.58.2025.10.24.00.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:40:46 -0700 (PDT)
Message-ID: <853e7cb9-2a7d-445d-aacc-49e3a2f07a66@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 09:40:44 +0200
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
 <fdec4bf0-6d88-4a9b-a81a-061476dd9e1b@oss.qualcomm.com>
 <25ad160b-b618-4ade-a978-e4ae56c79e32@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <25ad160b-b618-4ade-a978-e4ae56c79e32@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: U_ml2UA5FgAU5o40O6EGejfTFvt0yt9x
X-Proofpoint-GUID: U_ml2UA5FgAU5o40O6EGejfTFvt0yt9x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX1JsjlredOqKW
 xEuOm2pK3onJ3fMjN5RbeNaw6HXV1fdSXBN2tkgMbfXdq7PdRHFe1RziiZgwF/Gjrz1losY/aF4
 HInLQ9pk8zN5XCPRfjhfRV1fPbSEGsHWc5A/7sMWEyfW8a086sVnphcBCFmz5/uOwfiCoQJEoiT
 eZgEBAWeiuk2vnxUA5iR1xuda05qIFp5vifWHIuW0nBIFwR6YzfCX8fGlTsSPeB9GfAPHP3woQL
 WCYbjeH+rQ9JKpU72LpPiWjs/l5s4RZHFRJPTl23+vSfUChKd2tMVZ9sVRWdKABEqgKeu6WCxrQ
 0kIAvwVURrrmR4OV83ZZ/JfzCSeYoJTeG/t/1dIu8Yg1zVJDrBUL88Hg98KIY8Z53VcnfUy+p7w
 EhcWES42rBrT8x5i+Bp9XpFzR/t+ZQ==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fb2d80 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GWL_uKs5TFOXZ07RABcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

On 10/24/25 12:17 AM, Akhil P Oommen wrote:
> On 10/22/2025 8:57 PM, Konrad Dybcio wrote:
>> On 10/17/25 7:08 PM, Akhil P Oommen wrote:
>>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>>
>>> Add gpu and rgmu nodes for qcs615 chipset.
>>>
>>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---

[...]

>>> +		rgmu: rgmu@506a000 {
>>> +			compatible = "qcom,adreno-rgmu-612.0", "qcom,adreno-rgmu";
>>> +			reg = <0x0 0x0506a000 0x0 0x34000>;
>>> +			reg-names = "gmu";
>>> +
>>> +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
>>> +				 <&gpucc GPU_CC_CXO_CLK>,
>>> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
>>> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>>> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
>>> +			clock-names = "gmu",
>>> +				      "cxo",
>>> +				      "axi",
>>> +				      "memnoc",
>>> +				      "smmu_vote";
>>> +
>>> +			power-domains = <&gpucc CX_GDSC>,
>>> +					<&gpucc GX_GDSC>,
>>> +					<&rpmhpd RPMHPD_CX>;
>>> +			power-domain-names = "cx", "gx", "vdd_cx";
>>
>> I think the gpucc node should reference _CX directly instead,
>> then genpd/opp should trickle the requirements up the chain
> 
> Do you mean the CX rail scaling here should be handled by gpucc clk driver?

Yes, you can simply add .use_rpm = true to qcom_cc_desc in there and
add power-domains = <&rpmhpd RPMHPD_CX> to the node

Konrad

