Return-Path: <linux-kernel+bounces-871410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3134C0D29C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916E119A3A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0862F7AA0;
	Mon, 27 Oct 2025 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQyQc2T2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820392E093B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564950; cv=none; b=u/Tgyj1XouzbkZ1DTqCTVlM82BlIuSIE2yKvWJ3E/Cayb+kbggF3P4Bn/vau4v/QtTsdanYSUPI3nN/tCytKjuqj/81N+/HvQHDtG0dLnzK9VoulBMJwExIieRifLfVsQdHK/lnl5qsqf3ZTrj8Xt7kQjJIJkOG9THHkstsyZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564950; c=relaxed/simple;
	bh=z8JMmtO5pPNwnHupK7VV8WcW+3BYrdml7mecpOldSXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qf8yNTQ77emMxEIRlww+yip+jN3Ic8Z0RP+TpRpBeOYRbUVvYPW4RCMgDShwWHuQXSVCiBn5nanM6A7xTA2dHjotzife7WZde2vUcImCLMk/iFjo5OuPAG+uiH3Sv/2xBmQrWL9i+N0NFowxbSVdPZ09opvyb20wJ/2ZKWRunyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZQyQc2T2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R94J8Z1237388
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TU1kj7nq4ocDun8TqNLhxKbF9wpc+NkFZouW7rYkBz0=; b=ZQyQc2T2h+tLoAgm
	qVrNqEsapCOLmOefQnrDW29hYm4RtSy/thpCiCtKRfBzVHdXiaiEgvdutlY+Ejzu
	yaZB7NQ7BME+hmTKQeaf21gEqWRmDlvTyZCnCzjX02PIANnul5Q3X2qpFBXrgPxB
	/pwAyNibDmGh9lRQQMTVD1pVjAoea8QBRpz+uc4kKazHVfpZ9SnrYz3R2kF6XeWC
	CJc0nQ3JYmBYz1Kq4wdonvPzZF+9ERQUSQ/IS/C7BMytg6SaZ2LPN7i37MwWXOIJ
	E3Tze/89WmpLnx0jJ3/56yDIQ6fq3p2dRdq9m9FSr7YFab7rCLgWZwGt3rELKOOO
	ln8SyQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1uc59ruf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:35:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-826b30ed087so13806096d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564948; x=1762169748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU1kj7nq4ocDun8TqNLhxKbF9wpc+NkFZouW7rYkBz0=;
        b=NfnjHZ0FlaAzjZt25AVXIAp8/4cA31X4IjfXdAk5jSVK3hoUnWu8Se0LlUmVYKsNNU
         OpH3aGt++GmwJI0xSPhlVU3LGgoAvTg1WOCVQMaB/faE65Vs8eJqw/AwxoUsvtcNcOGc
         OI1/DtQs9oLZLtgVDbeuFB46hkOhkk8VcyaTj8LmVNZ6EFYsMpbRnvMTZo4BaE6X3+Ok
         H56jClSXyHL47IlhP74jBhU3ML1B6NlWySIfdhe0ZZoQ2WrS6JdURTjQNltFK54vbPZ+
         76BVwiTEVkPDImHThKKZkFm6BQeBrp3l/1Gu1EdjihfZMUbvg/VID4H0eK29JA5V6ZM0
         yGww==
X-Forwarded-Encrypted: i=1; AJvYcCUQwfE9C27A5hfP2wwQHWQ/0u5WOyLjZlMKtwZXiLNfeTW4AvPuydtBqSl/0wV0SStWMJz0fK1kcwm7qS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXSNjMcwKE0ABDbTaMfs3EPZMDUDhz77lPqDJwwkXpyPW/4lY
	/NjXht6Vf1t3aPI35ihuFtBPV4U2Irp6Q60SnRF4avd+8ZSkN1OGrOT0dI3fgQEfRO5/5raeIvG
	Irvk7zE5xGD4BuZ5qWAgXVZNvMAmTXd/7Zg1THYARjzm1spA188M2UcK4QJDCBp2Qw+U=
X-Gm-Gg: ASbGnctpUdLkwjwg+ZoPoAHP4mbxGseK7rEQw2MijJELNgQIrOOeu/X47cMfSQ2Kox1
	XYMLmCCkK0Wc3k6Gp4oSFPgaA3VGX7HwZesOVY8HoOwCnsZjUUn68e8EHTdgkWMqD+d1lfxG3yB
	Bm0qKnsOshsMO0MVicoV6OHnmfaTa3rxIqScgtVUuvLUVhoqcioSeaxR3i4OFJKoLyxrbH/alSp
	b/jolI+ys3GQEz4QtMjj1SiK78pu4wVaTY7OkhwyOVYeq1eBoaTA1IDucemdjkwHlVyHb1aJKNp
	0PpSKU3/110z4fB9+VrJ4+KseaGo34SVGbKnpeCHIJB/PNdDLkV6W80TRWAnkjsXfO1E7RdeHQ/
	Abah210KwZlUeIrfJO6C0JuYX2YzBsJVklgwkqzlfOp6aj6Ha1mnbLVZ7
X-Received: by 2002:ad4:5de6:0:b0:87c:19b6:398e with SMTP id 6a1803df08f44-87de70b4724mr201372546d6.2.1761564947755;
        Mon, 27 Oct 2025 04:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1KFM9AHLmnI7IFMN2DcxC11NSgWpPMDkmEheNEQeOvudyiBGTHMvMjndvOo4TT8fYmLKjJA==
X-Received: by 2002:ad4:5de6:0:b0:87c:19b6:398e with SMTP id 6a1803df08f44-87de70b4724mr201372356d6.2.1761564947284;
        Mon, 27 Oct 2025 04:35:47 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6c0e9sm6005786a12.1.2025.10.27.04.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:35:46 -0700 (PDT)
Message-ID: <ccdd5d44-2382-44e9-a56d-cbc5da23b13f@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 12:35:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8150: Add support for Xiaomi
 Redmi K20 Pro
To: Piyush Raj Chouhan <pc1598@mainlining.org>, linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com
References: <20251022054026.22816-1-pc1598@mainlining.org>
 <20251022054026.22816-2-pc1598@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251022054026.22816-2-pc1598@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xF3waZX8ke8hlZHlzckerdV7_8cUckPG
X-Proofpoint-ORIG-GUID: xF3waZX8ke8hlZHlzckerdV7_8cUckPG
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=68ff5914 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iRxBnbZjw3uyMlr8g3cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwOCBTYWx0ZWRfX724rZV4b4RUg
 xIamA7KCt4FWYux0oNtJqY8MXUbxthmiKs9hMsX5r7wOdgkakbF4OVAjZ4pSPW5FsdUMLJwpoM5
 KVOgnCgAax7mL7mrOAuTu6qugFsN/TPaBAy8KSKAoQi2H0gHO96IJxrtR7G+cq93FE0MZhrs1GT
 gug2zmJVNLTCziRWYm0FZVx9JuQnMA2LpopzkcWw8Pvd0ylI+GovbpFkby+xVsL34EBFlS8f4Sf
 luKG6TCpbiSSA4qVMQKkaewuPDFKZgIQeY8I8nBF0BHF8ZoKqBUm/5DR6ccMxKtE4wRado3P2LG
 Ye1xlct0OzUDuc2/VpHogHlRxDQIQmKRy1eNwU11BbfVZE8tRaiW2gJhIOanhtVeMDA8MBMnLua
 WKYCWId+vd8He0vIcFnGswVPWFkcaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270108

On 10/22/25 7:40 AM, Piyush Raj Chouhan wrote:
> Add initial device tree support for the Xiaomi Redmi K20 Pro/ Xiaomi Mi 9T Pro
> (codename raphael), based on the Qualcomm SM8150 (Snapdragon 855)
> platform.

[...]

> +		ramoops@a1600000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xa1600000 0x0 0x800000>;
> +			console-size = <0x400000>;
> +			pmsg-size = <0x200000>;
> +			record-size = <0>;
> +			ftrace-size = <0>;
> +			ecc-size = <0>;
> +			no-map;

You can probably remove the = 0 entries (although ECC is very useful
to set to e.g. 8)

[...]

> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_n>;

property-n
property-names

in this order, please, file-wide


> +		/*
> +		 * PM8150 LDO8 (L8A) — supplies vreg_l8a_0p75
> +		 * Device spec: nominal 0.752 V, active min 0.752 V, active max 0.904 V, IRATED = 300 mA

Hm?

[...]

> +&gpu {
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sm8150/xiaomi/raphael/a640_zap.mbn";
> +	};
> +
> +	status = "okay";

This shouldn't compile

[...]

> +};
> +
> +&i2c19 {
> +	/* goodix,gt9886 @5d  */

I see there's driver support for the GT98*97* - is there a chance you can
reuse some of it?

> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vdda_mipi_dsi0_1p2>;
> +
> +	status = "okay";

Please add a newline between this property an the following subnode

[...]

> +&pm8150b_typec {
> +	vdd-vbus-supply = <&pm8150b_vbus>;
> +	vdd-pdphy-supply = <&vdda_usb_hs_3p1>;
> +
> +	status = "okay";

ditto

> +	connector {
> +		compatible = "usb-c-connector";
> +		power-role = "source";
> +		data-role = "dual";
> +		self-powered;
> +
> +		source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_DUAL_ROLE |
> +					 PDO_FIXED_USB_COMM | PDO_FIXED_DATA_SWAP)>;

Have you verified this is in line with your specific device's
downstream kernel?

[...]

> +&pm8150l_flash {
> +
> +	status = "okay";

ditto

[...]

> +&pm8150l_lpg {
> +
> +	status = "okay";

ditto> +	led@1 {
> +		reg = <1>;
> +		color = <LED_COLOR_ID_WHITE>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		status = "disabled";

?

> +	};
> +
> +	led@2 {
> +		reg = <2>;
> +		color = <LED_COLOR_ID_RED>;
> +		function = LED_FUNCTION_STATUS;
> +		function-enumerator = <0>;
> +	};
> +
> +	led@3 {
> +		reg = <3>;
> +		color = <LED_COLOR_ID_RED>;
> +		function = LED_FUNCTION_STATUS;
> +		function-enumerator = <1>;
> +	};

Are there really two separate red LEDs?

[...]

> +	/* GPIO 0..3 are NFC spi, gpios 126..129 are FP spi */
> +	gpio-reserved-ranges = <0 4>, <126 4>;
> +
> +	/* Display panel pins */
> +	panel_reset_pin: panel-reset-state {
> +		pins = "gpio6";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;

Please drop output- properites from TLMM subnodes, these are controlled by
the kernel's GPIO framework instead

[...]

> +&usb_1_dwc3 {
> +	dr_mode = "otg";
> +	maximum-speed = "high-speed";
> +
> +	/* Remove USB3 phy */
> +	phys = <&usb_1_hsphy>;
> +	phy-names = "usb2-phy";

Is this a physical limitation, i.e. missing wires?

> +
> +	usb-role-switch;

This property should be moved to the SoC DTSI

Konrad

