Return-Path: <linux-kernel+bounces-813726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09532B549F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8C9461230
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CCB2EA467;
	Fri, 12 Sep 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PRXaSTge"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295219992C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673407; cv=none; b=aGQ5T4DhTv4k1+y3B6gdhamJNPCh1rjW2HVl9F0jmkms2vl/QW4Cb6368eK87AZ4xv1yJJh1lNt5hnL7aBkRPMTLdlaNwOEMsxfto75VQmEQpM7xJnbNWGTvTE95CQ2dJ6QXgyUD4pTCSDPd1jpSj1LRRgCsozrBDOT8NNYb2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673407; c=relaxed/simple;
	bh=nJ3+l5v55fpLJ9xg3lY7KIMVNF6NVqMD4GX1L9S7lTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUVNGC2bxbRmMMhLJTCQs1PJZVP0x6RMxLVPSpoxFd9Ie870cxWlqsbYSCIZ0QRWqJAeOB963vV/dP6pHkJxfU2jqSGEwgRxCegPLBNOzX7of/uj3NFQgrB/iXYc1siMl+HhexAAMYVikUGTun7gP3gR+uoRFeLfNI11xolOm88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PRXaSTge; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fNfX023361
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kuHENK0DYgi7JlXzy3OZov0FtKUnSjJcORNhHeAJWYU=; b=PRXaSTgetmg7zo0w
	8p3lbwOJ6d1M9WnZe5isUSyBKGnV4OhtM8zPP/FpHxml5tOvmt3B7qVE8jx9FxTu
	yyhuwKmp2dAW4/MBgOPuCax387Ou86SPB43fMN9Eva1YdUn82fopsZOLJsm9/iVI
	AzJdj06Nr62QF3zOmG06y8KSKA0dMSG6zidkRBTY0JpHQOtQ89WUY+xe+xpqc27w
	dLv8fpjJOeXTsImOjEKhLqKqzlSY4kipXpLdk42+pkq9WTt5dWhC7YG8iucSHMP2
	mJ5qlUDmCEVzu1ojjyY1YgQO7LBk9C8Qouoi0UG4hSs7MtznxgDcDqPDbP4blvx2
	iEPk7Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2f9bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:36:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-81621e5b962so44603185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673404; x=1758278204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuHENK0DYgi7JlXzy3OZov0FtKUnSjJcORNhHeAJWYU=;
        b=IzPFFuUktiemAe6n+ZQ5oIMKSxYxae4+gyxeu3+7D/WB/WaMRAlgxZmIRap/hKD5hN
         t4nK0fM+tXomJwD6ljR76dijxyohOYZ9RqyqP5cBGeJayJu1GGMuolC7oCbPH5hPt5fB
         PHRE2uAI8mGqcBOzvwpanXqsxS2LRGCqquFIZ1r8qvlZZjaIq/uV0hlPpy1IAQb+b+0E
         dRu/ofJvzdY/ZZnYM21UfqFrrD9TF5Lu+kkYCdUDk9AYrdzrU9NcigfQel/E8OZJuZcs
         fqg6qv4e5d4fw98vDJuCTbjupQD9Xk7VrHARFCwprEFNfF0RLOLy7oXF0hKe/I+6fnIz
         MluQ==
X-Gm-Message-State: AOJu0YztizvzUmEDGruHTLna/esY7P1/mdxBvxpa0s9nvtIp0cTj4ArU
	2xBEwk3QBiA+VbDf4d6TrwgokYbGJm4ECzkHiurXacUzhifJ7esnW3PVbkUL0hMJeA8FYA4Qrvy
	46m/9vWCf+SBualHCa06aqZa+mI4Hao6q9LBOqV4GTCaYnUtVeB3QlPzYAz7KV6Bggbk=
X-Gm-Gg: ASbGncuAmLcymIvZXx3z4M38kaVOyD1Sxcjs4CRHDuOtpfhr73R41+FcwBBL+7o0vt7
	6sJxvKewSV+NowVRfWDL1czp6ezsRxzua0JWPaL51KkrrkCoKcApzaw4g1BVwwPUudSpY2q+DUQ
	mRg+A8rkEBVpKuMLtIoqI1yaCoFiOgV4XZUt3Y9on3B3sQSc7mvJEUMiVqsSMh/ML09fGa1/hoF
	te0Xv9Tt9MV3juILWCO20fZ5Rch887yG2PGb7TQdGmsK07drivjNfVoBpV7CDuPHpu/i4ub5cX6
	mgkybxATuovXr52IfOyV0n9qs9PYVWSIlRCb/QzldwD0ivOD+2Jr8FHSY/0BldwdAd7glG70Zkt
	P543sWziq0Q+D3Faqh+sI1Q==
X-Received: by 2002:a05:622a:901a:b0:4b5:fc2a:f37a with SMTP id d75a77b69052e-4b7888cc278mr1140961cf.3.1757673404434;
        Fri, 12 Sep 2025 03:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU7PAoPRCNJz37EaX6IxNCBg6Jtsm+8T8pgUt1a0L7KS8lH3skeL6+I/GUlg9QPEybmuu4Fw==
X-Received: by 2002:a05:622a:901a:b0:4b5:fc2a:f37a with SMTP id d75a77b69052e-4b7888cc278mr1140821cf.3.1757673404019;
        Fri, 12 Sep 2025 03:36:44 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd88fsm343748266b.51.2025.09.12.03.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 03:36:43 -0700 (PDT)
Message-ID: <fa6f147f-c4fd-4267-82e3-139129caccbe@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 12:36:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arch: arm64: dts: qcom: sdm845-starqltechn: fix
 max77705 interrupts
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250909-starqltechn-correct_max77705_nodes-v2-0-e4174d374074@gmail.com>
 <20250909-starqltechn-correct_max77705_nodes-v2-3-e4174d374074@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250909-starqltechn-correct_max77705_nodes-v2-3-e4174d374074@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c3f7bd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=5anC7vb6YJh9jDJep64A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: rBtqjRLzSOYTA1SP97bADILpbh7eaKI8
X-Proofpoint-GUID: rBtqjRLzSOYTA1SP97bADILpbh7eaKI8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfXyW5fhsfWuK4a
 rzNLwi+RVvyo4NBTv6DrDb0dK5P9F2yx1PDA5WJV4RUgUBK29MJ1767LNFisuOnT3Bbumuw9NJ4
 TtcRLT6zY4knNwJgyVnVUPiEQwr2cdcQlyfj0DS8g7jphzGdiXgH2YA2HHSqfk+zVqfq5aLYI7c
 kXVKd5L4WVyhx9o/xopnx/WLbNlpJKTqlmJ++DBMVb0NWaWuvghEisqRC233lKIC4gR7pS5BMsg
 yaL1DJQjIStDZnic4exg7We8vj3GxvqPzPRjZrDfuU4xvWufcKVuFdcU8ABX8DB/TxWz+LicpON
 W/uXsIRUwXNBWkuYicG8mtu8+9vSHGGf7pUKo1EJAZNw9cTL0mxLldLmO71THbE0+VIHfyZBqWh
 E0DDfOXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

On 9/9/25 9:22 PM, Dzmitry Sankouski wrote:
> Since max77705 has a register, which indicates interrupt source, it acts
> as an interrupt controller.
> 
> Use max77705 as an interrupt controller for charger and fuelgauge
> subdevices.

"""
Direct MAX77705's subdevices to use the IC's internal interrupt
controller, instead of listening to every interrupt fired by the
chip towards the host device.
"""

Fixes: 7a88a931d095 ("arm64: dts: qcom: sdm845-starqltechn: add max77705 PMIC")

Konrad> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes for v2:
> - fix commit msg header prefix to 'arm64: dts: qcom: sdm845-starqltechn:'
> - remove binding header for interrupt numbers
> - make interrupt-cells 1, because irq trigger type is not used
> ---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index 8a1e4c76914c..597e25d27d76 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -584,13 +584,15 @@ &uart9 {
>  &i2c14 {
>  	status = "okay";
>  
> -	pmic@66 {
> +	max77705: pmic@66 {
>  		compatible = "maxim,max77705";
>  		reg = <0x66>;
>  		interrupt-parent = <&pm8998_gpios>;
>  		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
>  		pinctrl-0 = <&pmic_int_default>;
>  		pinctrl-names = "default";
> +		#interrupt-cells = <1>;
>  
>  		leds {
>  			compatible = "maxim,max77705-rgb";
> @@ -629,8 +631,8 @@ max77705_charger: charger@69 {
>  		reg = <0x69>;
>  		compatible = "maxim,max77705-charger";
>  		monitored-battery = <&battery>;
> -		interrupt-parent = <&pm8998_gpios>;
> -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&max77705>;
> +		interrupts = <0>;
>  	};
>  
>  	fuel-gauge@36 {
> @@ -638,8 +640,8 @@ fuel-gauge@36 {
>  		compatible = "maxim,max77705-battery";
>  		power-supplies = <&max77705_charger>;
>  		maxim,rsns-microohm = <5000>;
> -		interrupt-parent = <&pm8998_gpios>;
> -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&max77705>;
> +		interrupts = <2>;
>  	};
>  };
>  
> 

