Return-Path: <linux-kernel+bounces-846541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A9BC84AD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B110188A2C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F312D63E5;
	Thu,  9 Oct 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkXcNGpV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA115241CB7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001973; cv=none; b=sMuurZmNGcexqsSI6fhQQ17CUFrQZkkZ8gtPNc5fosWm+VEzAfkLsSGrO37JsUCH7s4jSHqacpOOhS/+pkQnnTFKz7G9l8kdI33zUEWuPM2cnFrMsUaybJGC6S2fOV3xml/kD8x8Y5LSLNc+ODA7CpCQjZjBtbRo9PLzSG21WNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001973; c=relaxed/simple;
	bh=utxI/ULBqHNoRHaa98abrqVVhdCZaM5+EZRg0gJ11UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QECsXzZycJw4D0YSYhS3taH1TLOXDmNS7eiwghfKLC4M6BtcRImWmSp2hHYx1Iek8+jPhUbU816IYV7B0DKYwWxFONLf6B1azT6AvlBGECdK78u02puwvgAMAUZmmrfEeaGc+7QRwT8mCPsRW6u0y/HdLAYHtQz6fMxC6V/oUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TkXcNGpV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EQRv029793
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 09:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3OVHAa5V6RkvtP12fLWJPioi/xyeh80to3fyM1SmruI=; b=TkXcNGpVNow8DpFM
	54D7T6YiqyJQKORDYNEjV0dXZ/iEQurj+JRSvjgH2QHSAUm+/GAQn8gh719jNLCo
	6LjwyjYmaIOC9Fz+idLGqT4SkPGWzROjqOK+dRunaH3Z0FtwvVSBSfTEzwQL70it
	0yf+hBsrjkaOFsOEQLSJRZZsr/5LL0dVBvHhG3OYYG4zhxGUiL17glot0+UhwElg
	5NkXEPnjWEGhyToVUEpjKo6J+pUEH7jQBsOBAReGqTEaP2P0J2v3/YBhEF6LYSM0
	mNRZ0gyF50zd9bAJ3G66P5t6kqXLkipH9TegPUo/Cv7F+Enk9aRWYgu8ErCC+20b
	i9uQcw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4na7sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:26:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e6d173e2a2so2967941cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760001970; x=1760606770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OVHAa5V6RkvtP12fLWJPioi/xyeh80to3fyM1SmruI=;
        b=R2m96lsFRqmwSnfFscM+cR8fWO5RZJ1u/fZn2tXj2hysjlFxHn68MikBVYMsJceQsz
         U+4S1m5ucxi9UOJshaIkk5es5PlKfZ+uvXGWnv6K/z4HMgRHlJQ/SgkwUV4qz1IFRMSk
         QEcpkgJmXp0fu6F4cHvkzZvWdPkf22e4mpkCf6EHsuOV1aBClFuGIWvPGuPVliKD1y0E
         l8bZPCEdZkGM5Hnmh/ahMZ+g/I1ZWgk46CqU7oRlPQcvn/7RxvLzDz0EnWQ21b7oSg9g
         y6oThgzAAEeXFeDHe3k60uMZHxcG+o4KiD46jt2yNT718Q+l+/v8Dqr0h8E+01XXIDam
         H+lA==
X-Forwarded-Encrypted: i=1; AJvYcCVCPgpJAZH1zxDI34nqguHqc+6U1i/Fz83VSmKYw/by16esmq6Hc83SNxztBGfFf+n/UCUk+48LgnJwevg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB2N9QyTmhBygt/k7igrDJ3cXrcUrcPr2L/bMNbKfzqdvH9Vjn
	HBwx6M3emIAyoA48+sEREFjjI3bosHxD5lQ6zbxcFlcGbhfjCmygGOW/HWRumzkm6vx9rUe+iGK
	msT/h9mHgyEwFiTFaZazdvItnVYGIujbZi1GzmBaf7kv1elbeTZFAWN4TGMhjpkPS4Xw=
X-Gm-Gg: ASbGnctA/x9uCfb38cXjqUfc7p2Z7VSCIbKU6Ly90qcnaMiPFwfTTIQIWt8v24VjWzS
	Kf3UEOa51mzyFdoTxhXmRfHXBUj/0p8EEq4lC/UfSKrqmSHZ5CeCFZVucENw43/z9qvTJJWpvIn
	0RGCaLrIgWdmnos7xq+J1IktiAHv65EK9lRuKXzSA4JBYayq78su4CkrhmBJuUHsD8PRBodUdxO
	lsDNA5+tfMV0U4UrkDPMf6rs68w5KTKuS51DcqZSYk9Uj3u9MCOtEJdIWQgWZi1xPog1a9BzKLq
	Ou+ekQXMS99ICUZ4mXKEdzSD5xAcy/ZoVR+XLAp/xCmPVgGABGI7bcTqQwHCFzELCogm8zuyDkQ
	pA73+VjST6q2BR0VICjYXrXNz+KM=
X-Received: by 2002:a05:622a:3d3:b0:4d8:85db:314 with SMTP id d75a77b69052e-4e6ead5eeb7mr59493521cf.11.1760001969685;
        Thu, 09 Oct 2025 02:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTRPTAZvD3wF2/a9+OuTMJj1spFQmgeaFWHJlGbPvOzFAFoUdxrLC4mglua8zi7PyH4hTjIQ==
X-Received: by 2002:a05:622a:3d3:b0:4d8:85db:314 with SMTP id d75a77b69052e-4e6ead5eeb7mr59493431cf.11.1760001969260;
        Thu, 09 Oct 2025 02:26:09 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ea1sm1841043266b.16.2025.10.09.02.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:26:08 -0700 (PDT)
Message-ID: <39ebaf4e-e91f-4568-8de6-9fc1f805a1e4@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 11:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: hamoa-iot-evk: Fix 4-speaker
 playback support
To: leqi <le.qi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20251009072630.460387-1-le.qi@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009072630.460387-1-le.qi@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e77fb3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=GZ-sSbIBM5jd_UAKczkA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: RjyPLYlHV8krQREc_OX5plqkkq1x5DVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzKyU3HhSxCiN
 8tyCisPPg7bb3QvVVnF6N5v8p4P8o/lPA1QQzRfIR++we3DodvUiA13BQ7VQlbHbM/huJ9cdRB0
 lO1jbKDPDsM1TGqOWzqMpikv506cWHCv5Y0lRQ0czr/FIoYVJJElmgyMi7rK2+g/Alz1HkiHVzy
 UM6Kp+7PZcdZpRxqZdg0sr5zQo6F2bNZoGoWvCwmZFbO050Iqb+McMXhxvOAQTD73D/POf5wtZN
 wFootxfrbc+kEn7L4D0MD4r+yZTygAiiH47lzb0DGtBvxQvwZHRIKkcZxf1fZ6mwz4XTk0z1auN
 PfhyQx85ri5plzly8yjw1Qkq/LDKjylCvsFsNVZIczaTRNfc1xELfIKW33Shc6O2/TSpobUZLUo
 y/i5ItmNstN0/wForvaqLjCuzNZb4Q==
X-Proofpoint-GUID: RjyPLYlHV8krQREc_OX5plqkkq1x5DVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 9:26 AM, leqi wrote:
> On the HAMOA-IOT-EVK board only 2 out of 4 speakers were functional.
> Unlike the CRD, which shares a single GPIO reset line for WSA1/2,
> this board provides a dedicated GPIO reset for each WSA, resulting
> in 4 separate reset lines.
> 
> Update the device tree accordingly so that all 4 speakers can
> playback audio as expected.
> 
> Signed-off-by: leqi <le.qi@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 30 +++++++++++++++++-----
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index df8d6e5c1f45..de9af19be6e8 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -743,7 +743,7 @@ retimer_ss1_con_sbu_out: endpoint {
>  };
>  
>  &lpass_tlmm {
> -	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
> +	spkr0_sd_n_active: spkr0-sd-n-active-state {
>  		pins = "gpio12";
>  		function = "gpio";
>  		drive-strength = <16>;
> @@ -751,13 +751,29 @@ spkr_01_sd_n_active: spkr-01-sd-n-active-state {
>  		output-low;
>  	};
>  
> -	spkr_23_sd_n_active: spkr-23-sd-n-active-state {
> +	spkr1_sd_n_active: spkr1-sd-n-active-state {
>  		pins = "gpio13";
>  		function = "gpio";
>  		drive-strength = <16>;
>  		bias-disable;
>  		output-low;

output- properties should be removed in favor of in-code gpiod_
function calls, otherwise the reset gets asserted by the kernel as
the OF node is being processed, unbeknownst to the then-not-yet-
bound driver

[...]

> -	pinctrl-0 = <&wsa_swr_active>, <&spkr_01_sd_n_active>;
> +	pinctrl-0 = <&wsa_swr_active>, <&spkr0_sd_n_active>, <&spkr1_sd_n_active>;

Similarly, because these pin configs relate to GPIOs connected to
the speaker amps, and not the soundwire host, these entries should
be split between each individual device

Konrad

