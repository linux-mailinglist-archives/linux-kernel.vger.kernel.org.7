Return-Path: <linux-kernel+bounces-813962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBC3B54D92
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9084117B235
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C2285CBB;
	Fri, 12 Sep 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZWL+0u1X"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75E2561A2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679866; cv=none; b=T50ki6/S8lnCOsy0oLQwyXR2518XvYVGr9c89ivsw31UcNVKT94NzkSIwb/sG0nnEJE00XlkNjUjCvIZAwFv3kXKFmFerbws/dO9peOwNWUYlGjzwypAJ9PhhM5xlPa6TkPRD19xkC+0UIItEoFxniprqQzarvphVeXrwdGlwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679866; c=relaxed/simple;
	bh=L/Kp0ZpCQjnQzViZ58decDE1KZjP+nvqlfKbSHwyGL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5MpUDyVcglG+jK6NuYymPhEaqt/WQTlnMIj4I21+IBoTX27TNrVulNmzNc5GBxxV+Mn6HXSVOQ2WeK6mEe5pcGhRRbz6e1S9feSK2ruqcu5QXzsp//NIAnoZ90k3SS6LmBdLG8V+9yGG5A0C5KKpqV+7Se28G0JJDVbvMA/w+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZWL+0u1X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fDi2018555
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k/00Zp88Pc7XaLrl9L+7J4tNKaqmsJpoZiLQwxfLj78=; b=ZWL+0u1X+U9Y+wc3
	gAIxqphUxtjWT3NeaoMeTueozCEAzTrgRpIkBv+lmfURRgF5vGKgqY59/fV+JWM0
	PkOiH0pnQfe5ol4XaVf6fFGHX8LT2NTOYNnCZgbhyjwlEjYYL6v9mRNN3rsbtNKh
	rz+pzRvRDKpNkmcIerqOgm/TLfWAO07tcmWkqu1lMBGuw0yTERFbIx1lHAHwT8Tj
	7WTM6c/C40RMQPv1PR51EHo48erMM28JCbNP7xhiH1zEy888yeIs9K1DeU/yFPKR
	zWStsn37NS8/Y3qYcUGYx/WabDSqKef32mb8s6bibgOvFNdY/ehd3BWfF1zkn7l5
	19pi2A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8akkyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:24:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b600d0a59bso6348281cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679863; x=1758284663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/00Zp88Pc7XaLrl9L+7J4tNKaqmsJpoZiLQwxfLj78=;
        b=L1gJ0ujlgxuyZhlIN9CADCy8SCCBaV+jF2fXjx0BX/3WRLSL+iHV7Gk3qDPIwRDOuf
         ZML2zTn3QbsvkLzTy+dB+tXMxq77TMXRlkNfs+IxKwOgfdOVJzoRadr7J/zLgPvaIPwY
         zz8s2ooQlCjKFKoJ8DofM5oQY136CXtgqgwd8kpvcZ480zt2ie2gzomJ+WllI9+VUu0B
         PF6rU7nSDUJSMcqQevV/KKMSo+V5UPem8ejy5J2AX6wp8teehVTRuh4D55mGp0PARf5i
         WhR8hNwLiKpisFM12+ojJXh0JJchAMB1ch7jmo8eYJ+Ck4BPntBXb5wIzTmVhYkPKmx7
         tVnw==
X-Forwarded-Encrypted: i=1; AJvYcCUVFeSmw5IKW9fbj40vsq2JVGab3bHOutMb3R3KCQJNOdjP3VJLj4QrtJ/DMK8DFUysar/mdW4AErxdGMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEid4E6KXhzmQPSzW56Mc8DN89ASMozSosnlsYKjdHm0pdueIX
	J3RPVOYEgOCwLVO+Rh4n6ldNp0Z/h7TnV9kVSN7n4VKWsuVsmiXOrelENhegLyEmP4uxqODaLE4
	ZzkVDh7CbB6n4VQBfrasTPf67gDI1w1siGyPxXceLqXCCJcLmj0iSI2QXCEg9QZBXRms=
X-Gm-Gg: ASbGncsqQJbop0T3xVxmuje4JAp4fnEJAeLh7ENqb6lUvw5a7oJSOCWh9EjBcIC1qeQ
	km19+bb8MYOyvxdBfX9Rv6K5vnQMVHdiUnp6MybmhHfjrSxmFB8k6TnESbzhMgBpW7ySMbS9NeW
	9Vl4OCTJ4YcalnSk5wpPE+aUDsGBKmC+w/xA0JGzsBMcju/9hq33LNg2zRrN1tyr2o4wrErowvS
	RynQu/rq3Z09/PT0j8y+OSz/nWSZUu+/TpjIk7IY40QHKDfeoG2aKPUZ21HqyRWkSWFrd2oyl8M
	F850Ot7Kian18Kl/XLcJiyqHcbQE+sHi0k8BiKvsrfmjfpNV4k2deA1cWnBGLmQovXrirHu0s21
	1blks4ep7pu3hupMGbkeI8g==
X-Received: by 2002:a05:622a:247:b0:4b5:d5d7:ffc7 with SMTP id d75a77b69052e-4b77d070bc6mr23459461cf.13.1757679862677;
        Fri, 12 Sep 2025 05:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLglj50v0H8yUFfCJsItJZI1D/YYI2k2rFfxjbH7ntfNZM9kwa4/Tn1xpP4EMHdoniu7v9QQ==
X-Received: by 2002:a05:622a:247:b0:4b5:d5d7:ffc7 with SMTP id d75a77b69052e-4b77d070bc6mr23459161cf.13.1757679862090;
        Fri, 12 Sep 2025 05:24:22 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5cbcsm64664835e9.11.2025.09.12.05.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:24:21 -0700 (PDT)
Message-ID: <f00cb00d-1e0b-4968-9f5a-df3ce0d8c8db@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 14:24:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845-starqltechn: add slpi
 support
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250911-starqltechn_slpi-v1-0-93ebf951a932@gmail.com>
 <20250911-starqltechn_slpi-v1-2-93ebf951a932@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250911-starqltechn_slpi-v1-2-93ebf951a932@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c410f8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=ixb8Hu8vVRuwzE1ANvwA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: nJgtahPCHKUVaDfCwyvj8pURXjQUVLQd
X-Proofpoint-ORIG-GUID: nJgtahPCHKUVaDfCwyvj8pURXjQUVLQd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXxBbX4jO5Sg+v
 WW5yrYWXPEamJ37/CUmMrfIirq4x1/dGrmErlJcBpHDosc1b7U5lalJNlDGi+awe5H+1qhZ2s5E
 4KnrNfPYM1JGPW78Rucfx43T2ODD99Juw8yFr+e6RQOV4sGEBoDVQbrq8NMM1y59EYqW3N2yU3j
 cDwlQLaZNF7WAvnCesetIiY2H7s4EpHQE4Z0O8n/jJiCOhmjU4NdDfVftpfQalZqls2FpzpGB+l
 +GDxB9FRyVrrrDDm3VNMmXy26mBo1cFwagGQ+BTL6+ALbV35C4joqHT2nAlyikjof6g8rAKmW9Q
 mcz1+LxsOSBea9Boocm1u3DoQ0uom5ogU+XvjEItn29baYMtEA9yfrhjQpLeqVcX+UQNJRRB23X
 ai1rNMj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On 9/11/25 10:56 PM, Dzmitry Sankouski wrote:
> Add support for Qualcomm sensor low power island.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index 32ce666fc57e..2c1157ee7b2d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -902,6 +902,14 @@ &ipa {
>  	status = "okay";
>  };
>  
> +&slpi_pas {
> +	firmware-name = "qcom/sdm845/starqltechn/slpi.mbn";
> +	pinctrl-0 = <&slpi_ldo_active_state>;
> +	pinctrl-1 = <&slpi_ldo_sleep_state>;

It would perhaps make sense to model it as a GPIO regulator..

I found a downstream kernel for this device and it seems like
this is indeed a Samsung addition

The vendor kernel gates the regulator when the SLPI is shut
off, but I think it would be reasonable to keep it always-on
given you don't really want that to happen, and if you need
to restart the subsystem, not pulsing the regulator should
also likely work
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";

a newline before status is customary

> +};
> +
>  &usb_1 {
>  	status = "okay";
>  };
> @@ -1028,6 +1036,22 @@ sd_card_det_n_state: sd-card-det-n-state {
>  		bias-pull-up;
>  	};
>  
> +	slpi_ldo_active_state: slpi-ldo-active-state {
> +		pins = "gpio8";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-high;

Modeling the gpio-regulator will let you get rid of output-
properties here, which are discouraged in favor of gpiod_ APIs
in drivers

Konrad

> +	};
> +
> +	slpi_ldo_sleep_state: slpi-ldo-sleep-state {
> +		pins = "gpio8";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
> +
>  	touch_irq_state: touch-irq-state {
>  		pins = "gpio120";
>  		function = "gpio";
> 

