Return-Path: <linux-kernel+bounces-873343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B6C13B83
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A38A1B21BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3501B532F;
	Tue, 28 Oct 2025 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cjWFCcDJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4923E355
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642505; cv=none; b=kV5YU6Sq30+THxPk/r6Gt6HaQ+3DKjuVUiNdMw3OzFbhFlFgO1v5qIG9i7lTO4oY1w9HRMt+3BWN6FM4xkwubxcFRgIH1CK0hEq436IiS5QeEabnPlnoaLpIGmuFAd0PnXAHR283dfli2/iIRId2aiKveFLMQU6mjYHiU+zTPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642505; c=relaxed/simple;
	bh=Mjy7PAoHBx36v7HAC236+RJx5SHs8x1JsKTGJ2NS6UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+u2ssTgtsUbr07Gm4j4aaRq41T68q607Tg+O5Z11NyQ7cdqfRSS+VtJJx8zd79aVvHEapDcsY7fUiYCIJ/GJm2i8R1cHcaY0Vga7RA1xJBQ1cz5iaSbx5F+zqckCXjNigQS5c4kNqc6i9VPSSsX4J/Vwa8HYcz2qRIt8tu/MZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cjWFCcDJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7ew682752534
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lNzCwtBrvgtjl8ydwxDZPx2RnyuBjsk244P+LTCOqBw=; b=cjWFCcDJIwlRWvP4
	6+AL2Rg9VjLUH37XJlCwumQhGczMosLlQNq58RlQUWnQ8Y1nnR+lO2lv3VC8d1Yt
	EVDp4zmzGHGPDbFNJ08lfz1SF+aNOm8B95c9TH8rx7kV53vTjU2LNZwKAOPapg6U
	Vq+fyROCB8xEOjIPoWwcbppPcDYKW4xXtETbNp7zMuYfmZgntB1tGFl8Eh+522ml
	7y4fwUUCpORrKAQJw4Xp4ynSAXRtQ8EtEyyp/CGctbdIvkrDmD3c79B0JG742Kvw
	Hzx592468RbxYaXK+AS+9ITJV2IvVkg+qqJdbZuE1z2qfKcZqKeE/GGai2hM0BJG
	LoJBNg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28nsucwb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:08:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c262c72b5so17781166d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761642502; x=1762247302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNzCwtBrvgtjl8ydwxDZPx2RnyuBjsk244P+LTCOqBw=;
        b=RoUvQ1NbMBWZ8s8YQHel+LwD0xmr6vd0ZHwg3+uDbi6wA4YgXTMvI3LRVPpr1DDfLR
         SHg2cGF0xt/uPAA9I4Cg9mmVev14VWNT198r4YOCVBRo2kDfH20PNZPWSKS5e345iAZL
         ISiUv4cNIIXKPqKO3F1UkjTblp3xl533GebPeVVKtvlbp+4hJGBG32XRl7cRVgRiQfkM
         uzmbva5ChcIVSGj26N9XiNyMmVGREj0znvTsHMjeqZ3qBYuMHRWeknZCuukCZYvaI1ZN
         5c9OG3PkD8TKTBjwHrhTB8leC2N8RzKsOEDm2ynplq17CsHjVHgdHKcTOqiIaOCVXLK2
         sSbA==
X-Forwarded-Encrypted: i=1; AJvYcCXuLNaJT1XJP35mqxbtdlYbdc6qrsWqW5aTHnsbvm/z4/HnqL8K5eq4G0ycLpMO+UC+Y824ygMo/SSeXdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCXUNW4jbnMMXf4OIDU8/t0TmiOsQJK6UyN7fjN1ytKmz+Z98
	ler78ba2tv5DrSIkKOVNL8KgJHoYCgGzrTG1eE67/rezAXlZOkdVU9B394MdsXeYXkm3ZQw2Bfz
	ScxzzoI09UWaz06xSk0etpV7+ZAZRYkbZDDPcIhIYjQKWIAnbCRkYghVXNRnrh5XCMsY=
X-Gm-Gg: ASbGnctR2RzR5lIATSUbNCyXjjAl7qfgA+XShdGVdeAYv1X3AsVgx2kN4eapmyaqJDF
	QSrEi1XpFTGp9neB5Sxy28spI5U7twx2QlUFLM9uGFodVgleoyd405l9vY6s3upO18gAr37qlgL
	zGruwFNVEjn2K2WrJUdyMOYqSU/LQenHsFi5+pq4MI9UB5O48Wms5k2RhmI5E+Rk7qmzmstUZtr
	JFofwwK7ncZeMFmgOW/jVFwi5lnI8Pj0LTdyiA382Ie/f+/lfqRUe4CVNzegjGBcLgb81JaYwXL
	zf8pidfnHZXw1oALOpu5HEviBOKa+aJwvXSGEkgHc1yE8exJOEXWyO2BhE6FQ0b+6dRB8RaqUvP
	ZefVz6Lbom8lb7bodQfm/xHMkzvfksO1WYagu0eJ/LlxazsoES5hTyWTK
X-Received: by 2002:ad4:5c6f:0:b0:87d:cb51:4015 with SMTP id 6a1803df08f44-87ffaffe3d1mr25573256d6.1.1761642502349;
        Tue, 28 Oct 2025 02:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSsVgQ4selJ8mk4A008ZLRPPa4YkiK7p7R9VTF5PkagGcPA4cHYsISXb8KpyC6ExxL2/ff3A==
X-Received: by 2002:ad4:5c6f:0:b0:87d:cb51:4015 with SMTP id 6a1803df08f44-87ffaffe3d1mr25573046d6.1.1761642501909;
        Tue, 28 Oct 2025 02:08:21 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853696a3sm1026501966b.27.2025.10.28.02.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:08:21 -0700 (PDT)
Message-ID: <b5d9d47b-7fb2-4ce4-9bc8-0d28395b78db@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:08:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add backlight support for eDP panel
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-hamoa_dvt_backlight-v1-1-97ecb8d0ad01@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-hamoa_dvt_backlight-v1-1-97ecb8d0ad01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA3NyBTYWx0ZWRfX0FSiveXLPgI1
 AQCyYa1UiAEfnG4FczaVm4nQTSdVc7ECvtgzfrZxN/8LhQisFiIadtPjtgCs0paHNwMpUreG+ue
 hISyiBWzd4bWD4PMLQfWWicbvx5YU8WX+elahyiRzHerSxEprZhl8feU2kbeqiVXDTdmZCrlyP1
 Dx253zz4enhUuIGV2bgFkkPTME2LAiJXhfwCZZmBLQyVzfjnXHaiPxpkCeIlt62NXuzm5E8jKdg
 R2tT1eIO9JkB4t2huzoM088JPat99Dg5tmJRJT/knHdek8zlUZWcbt3Ar7RKYmTP9J5g3Q2LHyP
 v2CzbmuAl34O5H1KyBhUmG2ewySPyAPkd+igDri6dzj2a7vwB139urRSKiKgyEXN9xkpElYxQFG
 nabQJ316PUrkAKFSSZmaewNDtoP2Kg==
X-Authority-Analysis: v=2.4 cv=RIW+3oi+ c=1 sm=1 tr=0 ts=69008807 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=gak16K312S0d-va-ULgA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: rayV3f7rn_aQxT_2mTsgL6rzbP_gk8UZ
X-Proofpoint-GUID: rayV3f7rn_aQxT_2mTsgL6rzbP_gk8UZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280077

On 10/28/25 8:04 AM, Yongxing Mou wrote:
> Previously, the eDP panel backlight was enabled via UEFI. Added backlight
> control node in kernel DTS due to some meta may not enable the backlight.
> 
> Aligned with other x1e80100-based platforms: the PWM signal is controlled
> by PMK8550, and the backlight enable signal is handled by PMC8380.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---

The subject must say "hamoa-iot-evk:"
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 55 ++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 36dd6599402b4650b7f8ad2c0cd22212116a25fe..fda1b3a3c7673be74832c27849231cba4bc1f25f 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -17,6 +17,16 @@ aliases {
>  		serial1 = &uart14;
>  	};
>  
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pmk8550_pwm 0 5000000>;

Try adjusting the backlight value.. you'll find some funny behavior
near the max level.. which reminds me I should send some fixes for
some laptop DTs

[...]

> +	vreg_edp_bl: regulator-edp-bl {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VBL9";
> +		regulator-min-microvolt = <3600000>;
> +		regulator-max-microvolt = <3600000>;
> +
> +		gpio = <&pmc8380_3_gpios 10 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_reg_en>;

property-n
property-names

in this order, please

Konrad

