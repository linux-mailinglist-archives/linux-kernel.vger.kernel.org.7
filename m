Return-Path: <linux-kernel+bounces-838580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB04BAF9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAC97A3511
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D295D27B35B;
	Wed,  1 Oct 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iKeOwXXw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441127FB31
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307367; cv=none; b=UaeuDicJT6iswCxzG9BSQwZgB5MtIzMtdr+IuVyKmZ5qhcHf/50Dwwd3lnuWqi8cI/Wg93Bn4WXrOAxJwJidcjhCMZvHvhoCWIcQUzethN9il5+7z22XAayi9Xg6KAzQzZBSYJHpeInUmfk987QHzi0Hr2d6IrvS+j7QLgP6TXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307367; c=relaxed/simple;
	bh=GJyYeYBHgy3xU5bBVM/7TBQUpVqwyswe9ISkR//AIrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDm4SZOnAdXUk5tnvYbjrbY1dWpN+2pRYL63QeKnMFj4GtM2hYjYXpokXG2INyQ2djiLGWXDGRFoyqO13hbpC7AqP4ZLki5wpPMSRDGKkLN5P/hxVH/kXys+xNyArX3DSLehBeSP81mfDBXmo9dKmGTFC/DOdeTLwGY2fq45E2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iKeOwXXw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKkbAX020325
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tlGyIBE+5l5QzImcJDdIrFcGN7HtYMPqbdjDmPS9GTo=; b=iKeOwXXwxHqn0lv2
	S89T90rOjaSXW1R50jxrbHh8M42QKQcO6KDkTqXh042ZYQuJOfcGQy490v8NUkL/
	vgu0NmGD0DhZptmRhx3HthjkVRzSCu288/T6npvjXOSOOo9I9z3cNx+tszJDXt+R
	2vl2/FqXZUop/VnyX3pX9NKnMWPk7bOoy6QbOygHMh1MPzeanAXuR67JqZbVh6vf
	CQG2iPwKZ22ecLXE+03NU8n/u+SvPvEJbCCkr+33wLpwfxjT52BtYMFKXecMxmVS
	t3FxKnj/J0Jo3xh5ijVCfpnhMewCZZUmzK322iXdcnsSwRtvPyRR1CJr4eotZdqa
	KP446Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5v0wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:29:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-860fe46b4easo187153485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307363; x=1759912163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlGyIBE+5l5QzImcJDdIrFcGN7HtYMPqbdjDmPS9GTo=;
        b=Vcb8Uond+HeIqXXEzJ4p22fiiKvkJeZizHjqSZCnLXKorkoDRuezvuLUcWgxyy9ziz
         uTue3+K/F8Uf7RiwH4/5P2hmQTXujqfQqn6c3Tzh5Ii06cqddBfgJwugaPm8YspDd78q
         hU3H9ng405njvWB3BluHHyN/2iVI+Nz2lEs+p/H3UUwCN3y7Jw2QRKgtwbjsZb4cvI9z
         6ZdjBfE8pKsN8+pOKj7J/Z4eZqvtfUz+DheaiNMJWjCHMTcmySNC/YmaNlFx79oDpv+r
         A14U7EZPVyEaOhcLmObJHCOWycym/JfUgodprp/gVIb2Jb3sPYkrSEjcsTMj9sMpDzwB
         sTFw==
X-Forwarded-Encrypted: i=1; AJvYcCVrB1R9t57CWsGzPmvgZFUFTVMZxlGRSiIsDhkLOtKzAD7igkj6A6n//GGW4Rb1wTId/tuvfnBvcSv6X8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGt+6tAd2NJBEWdexUC2HTwf5wsJ3ZkbdKExYTJLNQLjDqiGyC
	styvJEnj3wkf3rbevCsU8F937Q05C6sAeQw/96tL3fly2t2BqUaXZnjgHOKfKZrJAveAR6X+JuT
	cGazEqrkDNdiAWsiQpGaR8Pg3wP8Egd4Y9p5REnbbYWFO3B5IpnnwbS3h0HqsCEsYa7E=
X-Gm-Gg: ASbGncu027o8zJslm8H4xMW29GeBN9rEhEu17HZveqcJfU9IleR/nfkCPEu7ePkW0Ur
	i1e9Qm8q2FmtOOJandWjVGNhw2MDOm+yklwfionr1RJvIApHjt1IOCYlmr4cAmu5eGUBhsy10B0
	V5IzQH0geoydoLn43QeZyrr3mMngzPvDbL6VjkNuBT04jw4zf1WEkurWxijkKJlc/pJMYQ9l0gy
	CwIQRZLzG4vzizkvhpcsBSJI2RuOp5WX7rxmRRCxwjuLv4HpYyt62aW0drdFP0lxOpytnu6KHV7
	a2KeBUB+O8zueDMxmgGUJE3yPEhmhWTrWzr6KNgpUENblnJk+rO4/EdlKdpCNEhQ8OQgMkvERS0
	eGlZT4RxRexKWa82tACJhz/0Pdck=
X-Received: by 2002:a05:620a:17aa:b0:856:40d2:b1a5 with SMTP id af79cd13be357-873765c02d2mr260636585a.13.1759307363441;
        Wed, 01 Oct 2025 01:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIHr/OLBZEdgkn80ZN1dE9xO81kbu8cI04yKLGhC2XiEY6aWxZ/xP+utxgdYGLZbef2R3pXw==
X-Received: by 2002:a05:620a:17aa:b0:856:40d2:b1a5 with SMTP id af79cd13be357-873765c02d2mr260634885a.13.1759307362978;
        Wed, 01 Oct 2025 01:29:22 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d7351sm1332312266b.7.2025.10.01.01.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:29:22 -0700 (PDT)
Message-ID: <fc5d2d9c-7200-416f-ad89-4c1907e313c9@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:29:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: qcm6490-shift-otter: Enable RGB LED
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@lucaweiss.eu>
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
 <20250930-otter-further-bringup-v1-5-7fe66f653900@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-otter-further-bringup-v1-5-7fe66f653900@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qibyKmv5ftIC4jM2EABHaRYL0emniZBf
X-Proofpoint-ORIG-GUID: qibyKmv5ftIC4jM2EABHaRYL0emniZBf
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68dce664 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=dlmhaOwlAAAA:8 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=RgqGmV79IvFMSyKAuVEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=y4cfut4LVr_MrANMpYTh:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX8WgG5IdXctwt
 qSuWj1j+e2pJz3YXrNF+Nq4/wRHlyT//NNRs7z0KIp4YH8Ew2Ju0Tc33aZMojMM8DwQmnKp2KBS
 wPvNt2b+AiiNLKtAjggCO3s/Ysqf36UJldA0Q7fsgqc7viVA4lhaxXk/0MWDEj/vpEVVZqUj230
 ZzdHsGVMI8jL74gPhwq+Y3doQ4yblxuzSK9Y2jW3Rqv+xivGYPp3Fc1Dg9oL+CGHzt2AYpUnTYm
 N4oSSLtlHYoLEWOU9cuQJLyQz5Am15IN142/qij2Jw8kzaK6QsGtRr6o7XwweLfaLBfdbJ7t9dj
 2sL2cHPKKYyEVgFfHosiZVXi2YavnPi1yTRiS9qS/+2bbI5hJlbW+9eQX8FbfMagtGf+S4z8Ov5
 5P2/NUgJqjt7O8rD+vOm7ad+Y6iA4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

On 9/30/25 4:32 PM, Luca Weiss wrote:
> From: Luca Weiss <luca@lucaweiss.eu>
> 
> Enable the RGB LED connected to the PM7350C (PM8350C).
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 27 ++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> index 36cc67469615974c193ea3a9db1b2362869d56bb..b4c69dc50ed0f0b3cb45341a01c89210bd261993 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> @@ -632,6 +632,33 @@ led-0 {
>  	};
>  };
>  
> +&pm8350c_pwm {
> +	status = "okay";
> +
> +	multi-led {
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@1 {
> +			reg = <1>;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +
> +		led@2 {
> +			reg = <2>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led@3 {
> +			reg = <3>;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};

I assume you managed to confirm these mappings are correct.. sometimes
they are not what you'd expect

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

