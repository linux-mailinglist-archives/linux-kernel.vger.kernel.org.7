Return-Path: <linux-kernel+bounces-832283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48331B9ECFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F623B1BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099E2F3C12;
	Thu, 25 Sep 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLmYY9IS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C022F3618
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797395; cv=none; b=VNnIrIj8sv0ISr61BqwAv590etgEzU7J4tErBTOG0AsN2J5jX8XyMMY7+z8yYzqWM/mNdI0GAJ+pR0zEKjMSqOJafje4BAFCsekkHdzUf314kwcuBDD5gJsCHZuxZ+VQ9kXfmokCs7Cech3skjzm2SA703cCdk5hf/l+3AYtJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797395; c=relaxed/simple;
	bh=hNOysRWoNTQ//zrniCV0ThMsJiD6FL10/IYdbR2ZHb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIYz0OALiM1NsdXUSESQlS3SNfutco3vdKXRAkef6/0ePU3GjyryRWJuVEzZvdvr/DqUnqcEissvyap9/JkrUxVwwRiOnHBltVbZjJUV3Xhn6H9hQ2t7RqAS4jRnBbtv2jGE6y7dQR3vf5Sasme1cBrlntUGES+6CSXhrA2K90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLmYY9IS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P92vrw022115
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h26SUCBcpJnkfQuXjheoV3nT2HRPiqNFhqUpTLbAokA=; b=cLmYY9ISKIY0jefs
	bWDzxN7oRjvnv/qUQ3+25KIJW1Tf2vTt0YcUxr4SX/w1Z1Qk7JuEg06jlh36pxHs
	TW77UDc6SzZP0wqNdaWUCp+yyYOfmDYqsjunwDWFCfQc2amZvqPJNrJ7+ZODpy+P
	VZl01yyb4VaT5t0Q7ZhkBx8/I1rqF/4h6zTMcUZltQTN9RaBHYY9dHn/ceowyypv
	HiysHS+W0MTw/zgbN5tFB2zFxY24atkwxeEsI7/2m0EoIjzvGwDOufbWKcrA5VLw
	3CRbVmBzf8/pYOr1NgUuCT+9agSIKVAp6JuV/9CUcrSmlMsHQgOTqDwJR/LGSpdV
	S755cg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budafcdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:49:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85a8ff42553so24825585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797391; x=1759402191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h26SUCBcpJnkfQuXjheoV3nT2HRPiqNFhqUpTLbAokA=;
        b=cY6YzkVX//U2+1Gg93NkZtmGEmb6h6YfEuVhhxt1SWasOAsLklnhc/HII2/iqcyEm1
         z1AEAdnNJFZM7lowfzDraCPFIF0kkXmbYIs17r7v/Q8iwUbC1k7CKYIqoa8+JhUKot8o
         Yj0SS4Y2ovdd4n7eX1kRF/pu8hxKXPvpo4R+O8fMObzGOKNyYk72uJgEyMQRMsD5Z3SY
         0xuwHKCnHfxS1upIsD8zLgRSiBd8aSxvexUYUaNN3MJyBjts8iKQWQe4ZuzYKZUtVjbY
         Q+cGIynqXTD4ZjMuX9PbGLl2tzIy8tLX2Zkk1y9kSq3BcL6iztw+Z4iEu4aixsOmDUVH
         vibg==
X-Forwarded-Encrypted: i=1; AJvYcCWr9dNouMBdtyknSFrqk3dsnqWhDVSsJdpvUjpDWNQLXyrS/3og0C56F1d0mXtEaeQx8umE+YPgHUnPS8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVZA8rN9bOjCo+kCrbkxewCs/Q9WowtVVkXnwDnLd1bVYjSFx
	tPnWVVYX08LqrNZkTInS9Ts9xFWbrUiJbr5AGCENdulGRNCieOGMc/gvr95GWyE6I+QY5dL82Jo
	5xKH0X0OtcnJOMux5xWD4g3vkXGBCn5fTB0R+XYdHnONW2yKYG+On+UoXK+m3IyUGUxQ=
X-Gm-Gg: ASbGncvDl0MX0HC0Cf6kBk5CTyVgJbOv2h+4a4KyymCXr+dNirxY1vNhzVK+wJzMoSn
	YGmGLmJAcIliKDuUgFewCCbHlf/Suxl3VzW86a3VI/OuQm0jSsvgPSil8VdFvXTH0Fh8bUrML/u
	hiJ8WK7OsRWU8wtM+zMfJvKej0rnMOX+q4KIefbN0WUY0KIs74gSJ114R0P5Ao0PPU188YeaNOT
	QFz0UQ4aFuNcnVvlbm8R6YnWRCbSI+Q+xk9KYkffIckNIxJaJMDyT/yWVd143v7ak2k8RhLHy0F
	5hx792hQtzhbk0giP3P8DJsHIQ6IVmjBH5LcvJVJ08kNQBUq1jpE0VJeDJnsZpj2hDailSFX8ws
	n41nLbyqBxJ+hmh5usId1ow==
X-Received: by 2002:a05:622a:47:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4da41e11429mr24691431cf.0.1758797391504;
        Thu, 25 Sep 2025 03:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsRZrwKZiqNNQLYcT8cpG6XBOxHcJOuTA0wdEBBX9lKxQLY+5v2aYZ7WqVEiIAOJD4mjh45A==
X-Received: by 2002:a05:622a:47:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4da41e11429mr24691231cf.0.1758797391042;
        Thu, 25 Sep 2025 03:49:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32b4d71csm16900185e9.0.2025.09.25.03.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:49:50 -0700 (PDT)
Message-ID: <b1c12696-9e08-47f4-8fd0-11e415af187b@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:49:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans: add DT changes to enable MDSS1
 and DPU
To: Mahadevan <mahadevan.p@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925-lemans_dual-v1-1-9c371803198d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-lemans_dual-v1-1-9c371803198d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6cZu8B6SsP5g8-KVTJEO3wN1_XUukC3U
X-Proofpoint-ORIG-GUID: 6cZu8B6SsP5g8-KVTJEO3wN1_XUukC3U
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d51e50 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VcSkLwEzsjgrpZKnPmsA:9
 a=Hb6oODzzW8XWRlyM:21 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX+aAmBFPa3fVQ
 vF1HUT293ZkHgivSN2GZR7cxCBVL/YDKdeWy2qec6SAYs1OUuQVkVtceyKNDySbDqEk3fJRtJ8b
 y4xdYOT6ykZscKzjuZUmGrBJyf3DyKJ9I59pzaHFbr5vw2E7AyXBYVptA1Q+CRmdOWwTl2tmMn4
 SxI5UQCVobt3XsyQ4upQ7wQGSlwFoAwzfrUfcoFkuiWxNWjve3pBejBpfPxsj1Uu6T3xC69YBlj
 HzLl7elqkA6Li/pWoexkmWdg0WmkMBzIGjd3Wkn0lT9ktDvhHjeQ/QyRmW1uyx3u1ydpXX92nMb
 vrAapdifdRHrsjyPq3XjZ03ZEaWUdkSGuIOKfo2j8/tOBfvDIFv77siuHvBdqJ8vsVzqRP68ZNS
 w3NsHHTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

On 9/25/25 10:58 AM, Mahadevan wrote:
> Add devicetree changes to enable second Mobile Display
> Subsystem (MDSS1) and its Display Processing Unit(DPU) for
> Qualcomm LEMANS platform.

No need to scream.. "lemans" or "LeMans"> 
> Signed-off-by: Mahadevan <mahadevan.p@oss.qualcomm.com>

Please include your full name in git config

> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 88 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 48f753002fc459a3e9fac0c0e98cbec6013fea0f..45c11c050d3f8853701fd20cf647aef5c6a9a8c9 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -6751,6 +6751,94 @@ compute-cb@3 {
>  			};
>  		};
>  
> +		mdss1: display-subsystem@22000000 {
> +			compatible = "qcom,sa8775p-mdss";
> +			reg = <0x0 0x22000000 0x0 0x1000>;
> +			reg-names = "mdss";
> +
> +			/* same path used twice */

this comment is misleading

> +			interconnects = <&mmss_noc MASTER_MDP_CORE1_0 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&mmss_noc MASTER_MDP_CORE1_1 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "mdp0-mem",
> +					     "mdp1-mem",
> +					     "cpu-cfg";
> +
> +			resets = <&dispcc1 MDSS_DISP_CC_MDSS_CORE_BCR>;
> +
> +			power-domains = <&dispcc1 MDSS_DISP_CC_MDSS_CORE_GDSC>;
> +
> +			clocks = <&dispcc1 MDSS_DISP_CC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_DISP1_HF_AXI_CLK>,
> +				 <&dispcc1 MDSS_DISP_CC_MDSS_MDP_CLK>;
> +
> +			interrupts = <GIC_SPI 865 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			iommus = <&apps_smmu 0x1800 0x402>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdss1_mdp: display-controller@22001000 {
> +				compatible = "qcom,sa8775p-dpu";

Adding nothing more but the DPU isn't very useful at all
and doesn't really let you test the hardware (since you don't
provide a sink)

Konrad

