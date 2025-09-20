Return-Path: <linux-kernel+bounces-825756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E53DB8CC1B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B6B67ADF97
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58B2309AA;
	Sat, 20 Sep 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nm9siE/h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AD7261D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383217; cv=none; b=lW4gaRUTYZ63hGef7+5XI1UyEGgBKrQlfftBJLrOlZcZTb9e/eFU7B+/9/4Vmvge44Z+Y+/IK/rEOmRYCFh0Gi74kdEZhAhLfw2hF+6mUNVqarv2zUgli+jP7HshHmksHjQvtDab8Bs7oj0lCHIQ+kTzApmU46hsuvnguWg5ymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383217; c=relaxed/simple;
	bh=jOmWz03Ia8/ArDone93w5+2EdXOcDXmwCrpQnZgR/bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ7jXDZCfPercTjEiQ4gWkwEKgAHtZNySGDVMMmA8KOxdSywA33+dDwk/GH1q61S3wljBH2KAFFVMU3fCjRqWLD+7u9DM1JKeLnXfAuht4EH38ux5bH8PiG8UcXVdAdlyIRXXGpQr2g69WoR26DZFEjELZl0E9R7j0sLFd7Xy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nm9siE/h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K4BvdZ023154
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Mvv9Y6aHZOLeHDqC9HwSVvWqQJx4/TBvwZeSqiwehY=; b=nm9siE/hmLNWWPJi
	u3l/re+PRSexcoJrs7vJQ1zZTnOj3udNmC4rSN1UZ8bPBLaNVox/poUgHhioZc18
	8veX3Hvccmn2aAJ/Kmrli5qnIyW2bb840v41WZRbaxXPIzeXXl536imfk5rNxbEZ
	BBSrt89k5x2RBEGcFubBTJVqWxzRWS9UdftwyvBrlA9FzdPN+UUvZ45zFICeGgA6
	HtTG3Y01JR6F+yA4byN6P9m3JkuypLd2bpm5O2EBUekXr1kooR0jFqX2Xa0Fd2dL
	nncpWnflKHsJ6jarjJDr11SjUIemTvfD838mEFlDCx4guKwrmxO28cNyTLHcKp9v
	vc9UcQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1f8u5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:46:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78f28554393so44142746d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758383213; x=1758988013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mvv9Y6aHZOLeHDqC9HwSVvWqQJx4/TBvwZeSqiwehY=;
        b=aczsZzstzjxpCwWc25InoSQIfQRchLWVnMTvoNcZu++JsFjzcl/rd1zNzskODX797l
         WuYLT58JuKTJzu4Lidrh+f/BGsrUBNRRBTjMUPFxfvRsejNBaHNp631IOisxv1rwRiZN
         s4gu9btpR28O2V1D3RP8dlW/Hg8oSsDAonb8VDP0N1gs8w9EMMqE/JlMgosv67gDEHgS
         ezeNZqGHi+hfsjkrgaYYKnb3s7QKpMSMEJonNMsNA3iOmGiCqVmz+vmGnvxCDc4f2G5J
         CnYcNsAy0hRuMzcY27tIdjqgaHWVntN25BTGd9rh9M1+h8YLDsYzPgjl9iQW7cSPa2bJ
         OpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2R9WBJ0l+uU+6uFRhw4Jn23Uc8Bsyy1Z0tQrgJGB8IFbdA3Jxf7d7ET/GT9ykGwGz9vYe5YyL/wStVhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4n2ggIZ9jrhIiwhXabfRODTzX1uHEni++aUhMIscsi9PXeYD
	xXiJSi7VAEArsZyaAu1+Fngp5XmNnCqiSOjoU3JGCFTPfrdzmpsaVePgkrKxOjoNq46Dvdzv/ok
	oKcxKYUnlnBFjZabMtrAivplqKPjoaC6WLvYwnLdXdt1lUNnq1gXIuHMKgBrbnOuAYJ4=
X-Gm-Gg: ASbGncu1GukPQUe7xiFydI5EZ3f/DvUJ6IT5h1YNb/XoM0jyi982WRUpodeDcWw1Cdh
	NXTHwXvSYvMD722YRMzo6reB7Tydan4qtXdlHikbcpXvlmIyQRh5WCgpOOoGLx0uZQPA/LjxPuG
	R/XObcNhBrYI+ce2nYvhXFJC1bbOpaxf+/mmR5yD5Az3+02yCamGVrTSTTsrYpiZ2Omz/38WxIC
	VdT+mZhgsFY/mVm1+41q/9HR8mWtTwMvJTQzBoUrTzz3a2CHdv69Vckcu8/TYAQw+0wkaHeGLeM
	Cj2H+pO38ERcDIuXRWgyAtPVOQ3Y5BMNZXCL8CpalYhp1OXjC3bUSgrkUkqBy/bfK84CQ5dulBX
	JKRW71i4W8xB+GHMAzUq3448SPLV/o2qTM/xI3lDW0XLHnHTRatSl
X-Received: by 2002:a05:6214:1251:b0:794:309a:870e with SMTP id 6a1803df08f44-79913ac45f3mr87943356d6.27.1758383213094;
        Sat, 20 Sep 2025 08:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF11NkG2032TqJYvincR5awC9HUiRYgdpWgMYOGfHLJnwudA7QnMgQPw+ExDR1SJxBwoGOrJA==
X-Received: by 2002:a05:6214:1251:b0:794:309a:870e with SMTP id 6a1803df08f44-79913ac45f3mr87943036d6.27.1758383212488;
        Sat, 20 Sep 2025 08:46:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5793b1a828esm1637626e87.115.2025.09.20.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 08:46:51 -0700 (PDT)
Date: Sat, 20 Sep 2025 18:46:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: r0q: add touchscreen support
Message-ID: <qdfm5e2uaqplzu3y4gajjhhe6khruxyelwuqn425jvcfrrxlb2@bqrkmzofte4r>
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-3-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250920014637.38175-3-ghatto404@gmail.com>
X-Proofpoint-ORIG-GUID: Idmf8vqcoeb1MKvVMs5K-HUNtVQS2XMW
X-Proofpoint-GUID: Idmf8vqcoeb1MKvVMs5K-HUNtVQS2XMW
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68cecc6e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=BGGuTFjUeKT21jY7AO8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX7ePOZIHZIuew
 uIuGBZOXXbG8NNOCh2CtX2BegtRJkNuVfsLZn2O+7pRu+t/6KiMrdg3MO6A5iKnUQmqrzJZ2SKx
 vgJpv3hpm3YkIUpVntbzmaxdx3AGdkWDGmf1AjxRO+kZz+TCxts1DfAD+5Z1IFLDHM256G5X6zg
 GZPczZYRcpSnizOfw8LzQwK8agrtjph+ay5aOTm9HPeg8uC4TocVwCkCiEGqslhKxNoA3QPxvwc
 sQ8nOGu9ULcUf8P72418jtYvRgbu0rlg7qcNZPamdkS+qsgKP5yIJ47Bmt70amoDXnaC3jQzE6V
 XmUmdJCCFaU/AURkbvXQsPKtU/F8PAV3+kqxfHJXefLzOLtpd1Clx1Y3+PaB2fsaW3kM+mnGD6M
 JZL9RD+q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_06,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Sat, Sep 20, 2025 at 01:46:34AM +0000, Eric Gonçalves wrote:
> Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
> depends on "Input: add support for the STM FTS2BA61Y touchscreen".
> 
> The device has an issue where SPI 8 (the bus which the touchscreen is
> connected to) is not working properly right now, so
> spi-gpio is used instead.
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> index 70e953824996..7bf56564dfc6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> @@ -55,6 +55,45 @@ splash-region@b8000000 {
>  		};
>  	};
>  

Please add a comment that you have to use spi-gpio and ideally a brief
description of the issue.

With that fixed:


> +	spi_gpio: spi-gpio@0 {
> +		compatible = "spi-gpio";
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&spi_clk_tsp_active &spi_mosi_tsp_active &spi_miso_tsp_active>;
> +		pinctrl-1 = <&spi_clk_tsp_sleep &spi_mosi_tsp_sleep &spi_miso_tsp_sleep>;
> +
> +		status = "okay";

status isn't necessary for new devices. It's a default value.

> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sck-gpios = <&tlmm 30 GPIO_ACTIVE_HIGH>;
> +		mosi-gpios = <&tlmm 29 GPIO_ACTIVE_HIGH>;
> +		miso-gpios = <&tlmm 28 GPIO_ACTIVE_HIGH>;
> +		cs-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
> +
> +		num-chipselects = <1>;
> +
> +		spi-max-frequency = <5000000>;
> +
> +		touchscreen@0 {
> +			compatible = "st,fts2ba61y";
> +			reg = <0>;
> +			spi-max-frequency = <5000000>;
> +
> +			vdd-supply = <&vreg_l8c_1p8>;
> +			avdd-supply = <&vreg_l11c_3p0>;
> +
> +			interrupt-parent = <&tlmm>;
> +			interrupts = <46 IRQ_TYPE_LEVEL_LOW>;
> +
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&tsp_int_active>;
> +			pinctrl-1 = <&tsp_int_sleep>;
> +
> +			status = "okay";
> +		};
> +	};
> +
>  	vph_pwr: regulator-vph-pwr {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vph_pwr";
> @@ -132,6 +171,18 @@ vreg_l1c_1p8: ldo1 {
>  			regulator-max-microvolt = <1800000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
> +
> +		vreg_l8c_1p8: ldo8 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11c_3p0: ldo11 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
>  	};
>  };
>  
> @@ -156,6 +207,122 @@ &pon_resin {
>  
>  &tlmm {
>  	gpio-reserved-ranges = <36 4>; /* SPI (Unused) */
> +
> +	spi_clk_tsp_active: spi_clk_tsp_active {
> +		mux {
> +			pins = "gpio30";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio30";
> +			drive-strength = <6>;
> +			bias-disable;
> +		};
> +	};
> +
> +	spi_clk_tsp_sleep: spi_clk_tsp_sleep {
> +		mux {
> +			pins = "gpio30";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio30";
> +			drive-strength = <6>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	spi_cs_tsp_active: spi_cs_tsp_active {
> +		mux {
> +			pins = "gpio31";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio31";
> +			drive-strength = <6>;
> +			bias-disable;
> +		};
> +	};
> +
> +	spi_cs_tsp_sleep: spi_cs_tsp_sleep {
> +		mux {
> +			pins = "gpio31";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio31";
> +			drive-strength = <6>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	spi_miso_tsp_active: spi_miso_tsp_active {
> +		mux {
> +			pins = "gpio28";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio28";
> +			drive-strength = <6>;
> +			bias-disable;
> +		};
> +	};
> +
> +	spi_miso_tsp_sleep: spi_miso_tsp_sleep {
> +		mux {
> +			pins = "gpio28";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio28";
> +			drive-strength = <6>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	spi_mosi_tsp_active: spi_mosi_tsp_active {
> +		mux {
> +			pins = "gpio29";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio29";
> +			drive-strength = <6>;
> +			bias-disable;
> +		};
> +	};
> +
> +	spi_mosi_tsp_sleep: spi_mosi_tsp_sleep {
> +		mux {
> +			pins = "gpio29";
> +			function = "gpio";
> +		};
> +		config {
> +			pins = "gpio29";
> +			drive-strength = <6>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	tsp_int_active: tsp_int_active {
> +		pins = "gpio46";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		input-enable;
> +		bias-disable;
> +	};
> +
> +	tsp_int_sleep: tsp_int_sleep_state {
> +		pins = "gpio46";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		input-enable;
> +		bias-disable;
> +	};
>  };
>  
>  &usb_1 {
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

