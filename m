Return-Path: <linux-kernel+bounces-841827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D373BB8548
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9352E188A2D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B04274FDE;
	Fri,  3 Oct 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3ToQn1M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB21891A9
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530815; cv=none; b=rYKUMEHF6UyCt8w6gW61A4WQNXaqTOV9T7XHgYC1jvLBH0JN9GOw+MSoHiq1RMbluplccXcDA1XnomAaESVf2KlNXNkergucOlb47mD3+qgT0VP4e659AT3ZhnRrYsZlQPlcZCtwQlka8G+9wuv3zQEj8QVnv4LYMP0aW9U1p58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530815; c=relaxed/simple;
	bh=c8xSrLBPEZsi8mOVMz2L4a3EPWsxkSplh2VLhh7RLdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RebwnXfqLqyWzgzcjdGvBY0Cwu5lrHemSuPZCFzgJLvjuwSRRAjI0aCJw0fCYO4Y4Nr4uXorkV9vv9VFHa2tSsjxZUQ1iVyTlJM+tTxL8Bp2RdFg85Uh2UxJqqA2Bi0DRH2pXJlyTou1qoL5EfkHXkyeW0c23qFR9zgak+s92LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3ToQn1M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593IG6n2007888
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 22:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6Y4F//iHLAsR+G0IMOGy3VBF
	/GLgqOiAMCaLQ7uIbkI=; b=k3ToQn1MiZjSrRTp/1woXmPM6h+Er19dDOfpnOdU
	lSpdJUfoivmcHCzA77Pr4TpHLFTfvA3Rpezic4HMMalQ+cvbclZRyKtMO10eaZTM
	XKyh5JBpLYn9ceaHbrTQRydLbK68vr5bfFJjwGXYwYPIynrAbauRpE7Gpww0p0sV
	CRDvFBlllasMHedVwTGjchjr+UZTuL+Yp6K4miK7ile2VqSruAfr3L9LWhrE5ZzV
	FkQRZz8OskPV9UiDKSo46xiBnSTc4lR2ySX3kNn1dCj5Uu9e6gI8gnaa3IvqtgfX
	KZ5u6nIOs4/MuqQoAcl7gbiq50WVcduBx3z3jYfa2qXCfg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49hkhh59dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 22:33:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e5739a388bso53294351cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 15:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759530812; x=1760135612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y4F//iHLAsR+G0IMOGy3VBF/GLgqOiAMCaLQ7uIbkI=;
        b=oSO8Sf8TF0yeuHKAFxvG8dACLPpiQB7rDCMMUBQZV7mqrsTVNu/UxW215zqyp/E5KW
         jMUAXSq5AQJUFfOgyvJNtlK6IhQDinAeTRxKe5N2n1OmGQBiQ0FiWiNJiWbKBgRpuCkb
         rlGL9RdekdffThRlt2XxkXVCP/Cns6OXe51igCrw9W6YoXP9SJobxpMx8T9d4ZVUcDM8
         //Me0jqbAUg7wlOi8/i3+Y4kRZ5bAeh85sdGXxtP0v95vWXY+CX8chT88hWLBLi31BH4
         +xe+iL4fIhQUjHB0x2ZrwDYRccY9rNCWB1321py5FKKD4muVvexBbyAGY8tNxEJIcIv1
         mqyg==
X-Forwarded-Encrypted: i=1; AJvYcCWlm3cbBpvQIAD4pgVFQR3o3ba35x1F4N9AU6Tz02/NJCejEBpDm+J9h54/3CxyETeoxLazSZV6PmMF/ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwStgNJfNJ2ZQruzadSKcvMWRhcdiU7nqBE34wN2FovVYSyfkaC
	PVCtG3agPCdejOrrOTEyoxXhXy+zfcs1ZmhGb4fd27v7Vsh/qnZJFqMCHKbPaYZIbW6io2qz2Hw
	MiP6kqma6UIal97RE1Xg3+2m48XtMtsK2CApkLq5fAFm++FcAZrctmvLr91LIPMu0T2g=
X-Gm-Gg: ASbGncubhKqxsyay99qYVg6yMvzkcmeGtF2yjTXLKM3mdIxghUPFcTci/cCHtEYwkMJ
	EiNanSJtUUpRXJjkDjj1rSV0jP9HVJCDQ1+al1odgOE2Bh4cnPcfh4mWGrHJPDsKDtTcobVI8XC
	cOKkvjCLa3f+xACYzkHCZSuDAnkX5yNRJi8R2W4kF1yrywIX8+muf10L2tqpCzTRU73t5OJdxwH
	XQdQQOb9Emei+MU4FjYhROQTlnhYG6VFYJ9Dh3/yMaPDzwvDWCauiEmB5WRye/0Z7iwp/6+HjSu
	k36csk0bQl9cK7K5MKvj0KuKM4ii5XCH5iv+Le7eONKqAWclNBMKfrpwKTXuiczWfs1dnA/PsK5
	1Gu47TUFnqfO41fF3Uah9jibdHF4FeqFDoH1nvLHa8SwttAD4EPXUhwEoDg==
X-Received: by 2002:a05:622a:1344:b0:4b7:a8ce:a416 with SMTP id d75a77b69052e-4e576a7b744mr64829901cf.24.1759530811634;
        Fri, 03 Oct 2025 15:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn2bJnyKOInrEHOD8MFIsLq9WFcFcabDqb5urdGikf2oY/QBMkqU4XgOty/PdlV8LNbvKdVQ==
X-Received: by 2002:a05:622a:1344:b0:4b7:a8ce:a416 with SMTP id d75a77b69052e-4e576a7b744mr64829521cf.24.1759530810890;
        Fri, 03 Oct 2025 15:33:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141f09sm2207021e87.62.2025.10.03.15.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 15:33:29 -0700 (PDT)
Date: Sat, 4 Oct 2025 01:33:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingzhou Zhu <newwheatzjz@zohomail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add support for Huawei MateBook
 E 2019
Message-ID: <pbrrkfjrqoyj4qspdrordksfueyqejxcsz2oxqctczeoll6ywn@ixpaa6v4mwlv>
References: <20251001142107.21860-1-newwheatzjz@zohomail.com>
 <20251003131925.15933-1-newwheatzjz@zohomail.com>
 <20251003131925.15933-3-newwheatzjz@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003131925.15933-3-newwheatzjz@zohomail.com>
X-Proofpoint-GUID: y3xpdUftkD_NfWsQPngoW4JTp6UkYxLs
X-Authority-Analysis: v=2.4 cv=cILtc1eN c=1 sm=1 tr=0 ts=68e04f3c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=WV1l7McVAAAA:8 a=90yxgAhdmVl2AmlIJZIA:9
 a=CjuIK1q_8ugA:10 a=dK5gKXOJidcA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=ly-PvpxawfTmY1UqWLBn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDA0NyBTYWx0ZWRfX2OwbdYzs0bw+
 jtkIJlMK/kIHNQDtHxnCjwgATsrfIGDBNcAH/3Tj20xK4kw1hiaMtml6NTHKB9gP5Rw4GM8vRtM
 G0cvRjsNq8/aMPMcF1cAHkz5bswLzwLyncztK5cuKiv1ugIc0N+orYjXmAjah5jIkNxkuIqDZte
 D6Q7RR1r/SBemE0JE6DM5xiB83Wck5hnBAyABsGBb2+0DsGqUut3/ANdwEN8VSD8477X4aINJR9
 4xqx902hieM7ZDQfNGuHoxgE2LvDiEAfbKEm8bZZMmgr7OrDktaas2mHuyBaX//YNjXu9kBwzvn
 jQGTEScmvFGgTSHiiuXmCCbQSGM48+L8QNyeQbdSL0LqRmLpVOfPcLWG9iEsmJyNIr8MypdpZpM
 u9jhoPcQJdKEdAC1uk+fxXIlBuU6tw==
X-Proofpoint-ORIG-GUID: y3xpdUftkD_NfWsQPngoW4JTp6UkYxLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510020047

On Fri, Oct 03, 2025 at 09:19:25PM +0800, Jingzhou Zhu wrote:
> Add device tree for Huawei MateBook E 2019, which is a 2-in-1 tablet based
> on Qualcomm's sdm850 platform.
> 
> Supported features:
>  - ACSP, CDSP and SLPI
>  - Volume Key
>  - Power Key
>  - Tablet Mode Switching
>  - Display
>  - Touchscreen
>  - Stylus
>  - WiFi
>  - Bluetooth
>  - GPU
>  - USB
>  - Keyboard
>  - Touchpad
>  - UFS
>  - SD Card
>  - Audio (right internal mic and headphone mic not working)
>  - Mobile Network
> 
> Features not supported yet:
>  - Panel Backlight
>  - Lid Detection
>  - Battery
>  - EFI Variable Access
>  - Cameras
> 
> 1. Panel backlight, lid detection and battery will be supported with the
>    EC driver upstreamed.
> 2. EFI variables can only be read with the QSEECOM driver, and will be
>    enabled when the driver is fixed.
> 3. Cameras are tested to work with modified downstream driver, and once
>    drivers for these camera modules are included in the tree, cameras can
>    be enabled.
> 
> Features won't be supported:
>  - External Display
>  - Fingerprint
> 
> 1. To make external display work, more reverse engineering may be required,
>    but it's beyond my ability.
> 2. Fingerprint is controlled by TrustZone, meaning direct access to it
>    isn't possible.
> 
> Signed-off-by: Jingzhou Zhu <newwheatzjz@zohomail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../qcom/sdm850-huawei-matebook-e-2019.dts    | 962 ++++++++++++++++++
>  2 files changed, 963 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
> 
> +
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +	};
> +
> +	vlcm_3v3: regulator-vlcm-3v3 {

vlcm < vph

> +		compatible = "regulator-fixed";
> +		regulator-name = "vlcm_3v3";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		vin-supply = <&vph_pwr>;
> +	};
> +


> +
> +&gpu {
> +	status = "okay";
> +	zap-shader {

empty line between properties and subnodes

> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sdm850/HUAWEI/AL09/qcdxkmsuc850.mbn";
> +	};
> +};
> +
> +&i2c5 {
> +	clock-frequency = <400000>;
> +	status = "okay";

Nit: please add empty line before status property (here and further)

> +
> +
> +&pm8998_gpios {
> +	sw_edp_1p2_en: pm8998-gpio9-state {

Up to you, but there is no need to prefix them with the pmm8998-.

> +		pins = "gpio9";
> +		function = "normal";
> +
> +		bias-disable;
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
> +	};
> +
> +	volume_up_gpio: pm8998-gpio6-state {
> +		pins = "gpio6";
> +		function = "normal";
> +
> +		input-enable;
> +		bias-pull-up;
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
> +	};
> +};
> +
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;
> +
> +	cam_indicator_en: cam-indicator-en-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	mode_pin_active: mode-pin-state {
> +		pins = "gpio79";
> +		function = "gpio";
> +
> +		bias-disable;
> +	};
> +
> +	sn65dsi86_pin_active: sn65dsi86-enable-state {

Please sort these too (by the name, not by the label.

> +		pins = "gpio96";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	i2c5_hid_active: i2c5-hid-active-state {
> +		pins = "gpio125";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
> +	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
> +	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
> +	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
> +	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
> +
> +	qcom,snoc-host-cap-8bit-quirk;
> +	qcom,calibration-variant = "Huawei_Planck";

Did you post the board data to the ath10k@ mailing list?

See https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/boardfiles.html


Also if possible, please include output from BT and WiFi probing to the
commit message.

> +
> +	status = "okay";
> +};
> -- 
> 2.47.3
> 

-- 
With best wishes
Dmitry

