Return-Path: <linux-kernel+bounces-832216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B969B9EABB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6B77B6C89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41D279DCD;
	Thu, 25 Sep 2025 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jaVnSH9T"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD473274B28
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796270; cv=none; b=mfAAAQ0h0HDcLD5GH/3VDvL763QBY7dGlvPJKdfIj8O6VvTC1F/+qsE0FbVtmlY6AqLvcbfts7xV0UPTDfI3UPGI7nZQOcrcZJT33VMAnOsr1UOP3bbHVocTMy6VROxnC/p3Kl7ZgLPo2791teTBrfQ4h9P4isYOkgZn6xull6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796270; c=relaxed/simple;
	bh=wisyOsT1C1Ryv/jHBjcqfX3RaZbeaqQn0I1N4fwU0kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKvVSn/rrh5nnATpf0f9hUYQed6Kl9HPfHZa2x05KsRq0dBwED3jCicoqcZl4BwT4mnpqMTC4iXH/jyyj0PAhDCyE4r4wqjCQZmPovsCbkY4HJEIZDZ191Fj9NrqaJ3K80OQe8JQG+HFXyJ8V5yfLNb3mqLm8S4SJf2yNoI2chI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jaVnSH9T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4a7fu026648
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9va7HlxAnrOb0SWBv/l/eGsyAXzytQ6OTnJXw6Kj/CY=; b=jaVnSH9TL+MauIXV
	ZdEuaaEKl/EaHg+c5k1FktyhOXnSiJA0uyQ/66lSPjIrXw3LVTJiC6l28RHPbgMR
	k9UlMih3XkiqH2Z3lw/+UAYFi3lKaXuAgJE0eNckpBRRbmf+QiQxzEEcO6Q7urEt
	bAJjYcthxJmeidWyZt5gkL8pnz8A83Jp3cuzpC7E02hI+J0PROhScuV5oPkVgc0n
	cC73cS2oaGsGZ4LZDMunMo1SPywKR4rEQfo3LJO35Ew4Z6IjO3bEwYSw5pbthYRF
	Y3XA6xodR4UhOK6YOO8vjnMkOVRr6YVIzZVPjRCV4HfsVF8sKmGGqmcI9JLp52OK
	81wChQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup0yce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:31:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d40407c6acso838751cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796267; x=1759401067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9va7HlxAnrOb0SWBv/l/eGsyAXzytQ6OTnJXw6Kj/CY=;
        b=HMqk3XPf/2iT0OBijEooTQtUIRjK+GQRmcFsvJWy9AxojTiNv+zh6HN5vFteUPy6mA
         lSPSHxJ7CN1ATVnbvUjWrawQVdkc0mTCD+/TYDIJN1A+BqDHmcKGMoINSF2XF5aBZvfQ
         8lfbXKaK7evV7pr2JNYS9QefrcARBdKu5V1g/AgByUrYOV/yUHAez9y27sZTp5DMx0Bp
         xprl8rOuOwAE72O8peJD2pIakhG55fRE5cA1DN1Vj/HP+sYHFfZTgACrRbrs7NO6ksGW
         b3RZRd/2TSm2tll5EWG85SGqLU/3V8rls1LlOuTbyRrR4VX2mM3Vc+Sad6MCKH8Z5TcK
         fZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQUeq/nRKlb6l64j8679wQhmB/9RO3pZxgmBxrvtGq2DPD0TxvEivavfGzCQjAOua9mx5rM2sSTm7lv34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhEoXKMt1+wdbMYUTbVhxxvgWY/CZ+UTVjNKTR0ggrZsEV0d2f
	n5at/m0/8Qu6UeTIjC8kErhx+54sOSzQ8hYA4jRGg5NwATf9yDwvgk+5FMSy5EWAQ7bE4GfhQGd
	dXTXUvr6xktfSSodVxLdxp9aD/5KCkg0GDayusiUbSkBbkqldGbVU0TRyqr1ABu5rUOM=
X-Gm-Gg: ASbGncugaQr5ZPIDzMhSTEhs1XXnNOdnswMzPikhJydrpg1+ouLSF9RdLIXG0qfJNtt
	Umc2CwnhoG8ifQ8iGYZ4f9ygdULI5kELcMH2c5N9lViPBBTGrpw/khO/qJ+BCplX2gvfAZHuNSR
	hw0uZ1w7vOuS5quACBqS/c2XIMBDsI+qKFIBezsIOM7BGh0/iDq1c7XfNJcXz2XK4KNOSHaqjWy
	enYSS9gJr8TPGG9afh7rQuJ+pbpy6ZOPY1eHOll4zwr0hc/8JUsvjtmTrbxUJ5zutwRTPQhuKby
	INz5Zut4LJdFIsvIT1+uwXDIAj05hNB4MBwtcgDtfKeHapFLPXjGm4/CuTuI2cVR4/BkfdtR/BF
	C5gjjAxFNNEztDzo5jbvUcQ==
X-Received: by 2002:ac8:5fca:0:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4da473524bcmr32387231cf.3.1758796266739;
        Thu, 25 Sep 2025 03:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbCw5K8UPnmPioSAh+xplsbtqWhDI7k96Pzm8sTdNmD7qW/cWHlOH1L3fL1u8UsI42cuBtHQ==
X-Received: by 2002:ac8:5fca:0:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4da473524bcmr32386991cf.3.1758796266217;
        Thu, 25 Sep 2025 03:31:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b367b79d1b2sm38869366b.10.2025.09.25.03.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:31:05 -0700 (PDT)
Message-ID: <333dc302-aee1-41a6-8cc7-f0315f3b2169@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:31:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] arm64: dts: qcom: glymur: Add SPMI PMIC arbiter
 device
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-10-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-10-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d519ec cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=uVuLLN3hS0IF7mqGKV8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX4A/J7IT558CO
 quVwulW6tMPsssEUTB7vlOrP9l/ERe6/3+Jp6j5DrvlJHUZOfAmnuDzl2Ic1QA+6LFHcjvgKQGd
 f2sMPcBAGLPg/Do9tRquvl1XcFnd3VtuTiraNdAlP0wUjk+9O/1hzyKrjoEJN+aL27qodFa9q1J
 87IOjkwQAGdYUhW1SgIryVMrBqiPhSm6ykwzI2xJVZN6cUbH4JE4g7d93deYWKsdEVWXhlA+v5d
 IhQaggoINd5JHQIn6LxPtamWbVFiDTl3XJQ9TPvNxQF85E8B6BqR8rrhHV0W5VUzzfH//HS1x0a
 78oW/w7XvbtPzIrg7G3ZJEgVTxDrg00ImAzYbQvaJ9AGpslzZh/HumCPXTjyQLJq9kWxrlRMQCT
 AvWCfCxZ
X-Proofpoint-GUID: xS10UC7mpRrI5Ni_uZhL6kdg1P6Ske3M
X-Proofpoint-ORIG-GUID: xS10UC7mpRrI5Ni_uZhL6kdg1P6Ske3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add spmi-pmic-arb device for the SPMI PMIC arbiter found on
> Glymur. It has three subnodes corresponding to the SPMI0,
> SPMI1 & SPMI2 bus controllers.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index 2632ef381687c2392f8fad0294901e33887ac4d3..e6e001485747785fd29c606773cba7793bbd2a5c 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -2600,6 +2600,68 @@ sram@c30f000 {
>  			reg = <0x0 0x0c30f000 0x0 0x400>;
>  		};
>  
> +		pmic_arbiter: arbiter@c400000 {

Is this label going to be used?

> +			compatible = "qcom,glymur-spmi-pmic-arb";
> +			reg = <0x0 0x0c400000 0x0 0x00003000>,
> +			      <0x0 0x0c900000 0x0 0x00400000>,
> +			      <0x0 0x0c4c0000 0x0 0x00400000>,
> +			      <0x0 0x0c403000 0x0 0x00008000>;

Drop the padding from the size fields, please

Konrad

> +			reg-names = "core",
> +				    "chnls",
> +				    "obsrvr",
> +				    "chnl_map";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			qcom,channel = <0>;
> +			qcom,ee = <0>;
> +
> +			spmi_bus0: spmi@c426000 {
> +				reg = <0x0 0x0c426000 0x0 0x00004000>,
> +				      <0x0 0x0c8c0000 0x0 0x00010000>,
> +				      <0x0 0x0c42a000 0x0 0x00008000>;
> +				reg-names = "cnfg",
> +					    "intr",
> +					    "chnl_owner";
> +				interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "periph_irq";
> +				interrupt-controller;
> +				#interrupt-cells = <4>;
> +				#address-cells = <2>;
> +				#size-cells = <0>;
> +			};
> +
> +			spmi_bus1: spmi@c437000 {
> +				reg = <0x0 0x0c437000 0x0 0x00004000>,
> +				      <0x0 0x0c8d0000 0x0 0x00010000>,
> +				      <0x0 0x0c43b000 0x0 0x00008000>;
> +				reg-names = "cnfg",
> +					    "intr",
> +					    "chnl_owner";
> +				interrupts-extended = <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "periph_irq";
> +				interrupt-controller;
> +				#interrupt-cells = <4>;
> +				#address-cells = <2>;
> +				#size-cells = <0>;
> +			};
> +
> +			spmi_bus2: spmi@c48000 {
> +				reg = <0x0 0x0c448000 0x0 0x00004000>,
> +				      <0x0 0x0c8e0000 0x0 0x00010000>,
> +				      <0x0 0x0c44c000 0x0 0x00008000>;
> +				reg-names = "cnfg",
> +					    "intr",
> +					    "chnl_owner";
> +				interrupts-extended = <&pdc 72 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "periph_irq";
> +				interrupt-controller;
> +				#interrupt-cells = <4>;
> +				#address-cells = <2>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>  		tlmm: pinctrl@f100000 {
>  			compatible = "qcom,glymur-tlmm";
>  			reg = <0x0 0x0f100000 0x0 0xf00000>;
> 

