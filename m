Return-Path: <linux-kernel+bounces-646931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C08AB6280
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 07:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96991B43E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 05:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A051F4CB8;
	Wed, 14 May 2025 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpGDP0hM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4E1F4262
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747201409; cv=none; b=Bpx/l/z1WNd2T9ACE+SkQs73H5u8/RlP4T6SnS8rgVduyZl7LNHOp1LK1dI3UI+7mKbOpZeJ7voNVjH9vyUbAxsAA03bQnEC3gPkBi16STK9BSLRunuzTN7zRkLzH1T2lUfhA6gkfad9bWnKjd/V7LJnU9INQnQx/WCin4oe9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747201409; c=relaxed/simple;
	bh=ngkdWREDhxJP3Z8+vA88rzmJHoCKElBQPHF6jlZulMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DovWerlqY1tUutLTtUZIamqhjQ/v/ThoaJQrNDr1mhfMFT2wmZfORZVOkzq94rcgrBDjGoBGylc7TkT/RjZ+T5P/mnjc/QyYuFDuNzZgTcIR7RKgDqWaRheOtrFG7yeQX1eTjzlA9lXuhoIBT9QuWNsvpbNnycT8VP7BeVtJd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SpGDP0hM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so47507415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 22:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747201405; x=1747806205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WekKOZDHzata3CIxzPDhxW/QBdknDrhZbw8Dut8DkN8=;
        b=SpGDP0hMCCN7x+CcjdnbDQWm4c22I+5OxLvnAGs1+YekNptlIJtOyz7F7xj+E5+1vu
         LdyyQUYN9AlxP5AUzRYlHA63N46OyWO+GRi/+YLlRgLFll2L1W1JJ44hxijoCXIVQiUb
         ZpJlzByS/9OeegoQbKJq5ef66LipTIoo0f6kZDhXOZQodqMTtS8HMUT6DmSM025kRNX0
         um0G/hSpzdQc9K8w+VMGkaXspr6xIJ8vMbxyyKuXiQxb0nipNNgd2S8iUAuc9ilYJYjY
         /G8bhnr+O7IhtaP+SyYU4aQZrbqqE5MmcS4QSLJpRW2anrpVgD4jSlqyjl1YxucRSfOG
         E2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747201405; x=1747806205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WekKOZDHzata3CIxzPDhxW/QBdknDrhZbw8Dut8DkN8=;
        b=VE0BCiM2RlAaXLyXiaRFoowWCbgC7QiB/8PR8jU25J4Yz7miNvQgpebcHg/9OmqMjX
         fTlX+tHyGXWrxH/gXnrU8vjbsB5EIDbuOzXVSzPoyFiUKintBWAlYI70+LjCScA27H5L
         zkLIgaMsPmwFaXx/IzZ59Vo0axiK6cLXQmAZL36ZSWEM6kSalhmrlhZwwn6dz8Tjt+Tb
         a31qcRa0Y3cOzs7xHn/bgBzQ9QnFP3dMXKYEeI/7m3KMhjtIhScVPJkLpV5Wk4P53D7i
         7yXppTYwYsEDuaonMlStYCjp+uGR43UuoAmWp9kFA7D7qBL3jsQoBXglUWLZ3ruGelpp
         60Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXkdacRMk86nTOX7cvJS4/o7WMLwLkFaQEAMzOj7B3IF7gLHPMwiAPlKV1j3bMnEKs+KIeVrin9hRtH+ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcdl4zN13QWeOlw8V+GbYTWnBgWe7Wa5HlxJip7zbYIV1GSzId
	1kg9ARqJTR0MTm6EjmpiBH3pTbGosg5tvmxkk00YH7O2CP69J3x3HqyvL9X5N1s=
X-Gm-Gg: ASbGnctQOHSI/n/jKNz4KeKghbHKh7uRwkFwSZytnnlVfrg+KHvoxzR7w4ux+wf2obl
	jytdPGkQ+gyCMe94QMi2g6raM9GHLg5iIpv3cWmdMUL55sRGjww6F17g9XzkafZN/QvNCayxZzw
	6BOLygCMcyBu4He4IwxtBslmGLleX72qpBa7anh/nXhve6+wtU08DsmM/onoXUkYfDugr/38XuH
	KBq3CcThGa3uC/nkUdcACK1S4VY3LMlKRlP7Qg3F+0/OYMxRqZrBn5aNirde33V5+fYggYoVH9r
	cZA0S185bnl1SxoNnZ4tHMxNuj2pPyIIqdJ2gCq1D19Vzx8CEpMtHkLBEDnYhWyLGN9jVi3KByk
	dTTenf18j1Aya
X-Google-Smtp-Source: AGHT+IG+3TNrM0TUrHdUyJXWOShIKsXvcyKhriY5sc/GEJhp8byyCrjzheMxPynRGxPI+f0IKwcCeg==
X-Received: by 2002:a05:600d:1b:b0:442:f4d4:53a with SMTP id 5b1f17b1804b1-442f4d43e20mr4691955e9.2.1747201404948;
        Tue, 13 May 2025 22:43:24 -0700 (PDT)
Received: from [10.61.1.70] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3950bccsm14069945e9.19.2025.05.13.22.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 22:43:24 -0700 (PDT)
Message-ID: <2e9d06be-719c-44e4-af14-7839ee5957b7@linaro.org>
Date: Wed, 14 May 2025 06:43:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qcs9075-rb8: Enable IMX577 camera
 sensor
To: Wenmeng Liu <quic_wenmliu@quicinc.com>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vikram Sharma <quic_vikramsa@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org
References: <20250514-rb8_camera-v1-0-bf4a39e304e9@quicinc.com>
 <20250514-rb8_camera-v1-4-bf4a39e304e9@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250514-rb8_camera-v1-4-bf4a39e304e9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/05/2025 03:40, Wenmeng Liu wrote:
> The qcs9075-iq-9075-evk board has 4 camera CSI interfaces.
> Enable the third interface with an imx577 sensor for qcs9075-iq-9075-evk.
> 
> An example media-ctl pipeline for the imx577 is:
> 
> media-ctl --reset
> media-ctl -V '"imx577 '0-001a'":0[fmt:SRGGB10/4056x3040 field:none]'
> media-ctl -V '"msm_csiphy3":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -l '"msm_csiphy3":1->"msm_csid0":0[1]'
> media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
> 
> yavta -B capture-mplane -c -I -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video0
> 
> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts | 110 +++++++++++++++++++
>   arch/arm64/boot/dts/qcom/sa8775p.dtsi            | 132 +++++++++++++++++++++++
>   2 files changed, 242 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts b/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
> index eadc59739a4baafedfa456bdb71b72214810b1c1..83c286b3b1428bc90445f41740997f2421824a54 100644
> --- a/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts
> @@ -20,6 +20,38 @@ aliases {
>   	chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
> +
> +	vreg_cam0_1p8: vreg_cam0_1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam0_1p8";
> +		startup-delay-us = <10000>;
> +		enable-active-high;
> +		gpio = <&pmm8654au_0_gpios 7 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vreg_cam1_1p8: vreg_cam1_1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam1_1p8";
> +		startup-delay-us = <10000>;
> +		enable-active-high;
> +		gpio = <&pmm8654au_0_gpios 8 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vreg_cam2_1p8: vreg_cam2_1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam2_1p8";
> +		startup-delay-us = <10000>;
> +		enable-active-high;
> +		gpio = <&pmm8654au_0_gpios 9 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vreg_cam3_1p8: vreg_cam3_1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam3_1p8";
> +		startup-delay-us = <10000>;
> +		enable-active-high;
> +		gpio = <&pmm8654au_0_gpios 10 GPIO_ACTIVE_HIGH>;
> +	};
>   };

I would submit the regulators as a separate patch - especially because 
you only use 1/4 of the regulators you are adding here.

That in itself deserves a commit log explanation.

>   &apps_rsc {
> @@ -241,6 +273,84 @@ vreg_l8e: ldo8 {
>   	};
>   };
>   
> +&camcc {
> +	status = "okay";
> +};
> +
> +&camss {
> +	vdda-pll-supply = <&vreg_l1c>;
> +	vdda-phy-supply = <&vreg_l4a>;
> +
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@3 {
> +			reg = <3>;
> +			csiphy3_ep: endpoint {
> +				clock-lanes = <7>;
> +				data-lanes = <0 1 2 3>;
> +				remote-endpoint = <&imx577_ep3>;
> +			};
> +		};
> +	};
> +};
> +
> +&cci0 {
> +	status = "disabled";
> +	pinctrl-0 = <&cci0_0_default>;
> +	pinctrl-1 = <&cci0_0_sleep>;
> +};
> +
> +&cci1 {
> +	status = "disabled";
> +	pinctrl-0 = <&cci1_0_default>;
> +	pinctrl-1 = <&cci1_0_sleep>;
> +};
> +
> +&cci2 {
> +	status = "disabled";
> +	pinctrl-0 = <&cci2_0_default>;
> +	pinctrl-1 = <&cci2_0_sleep>;
> +};
> +
> +&cci3 {
> +	status = "okay";
> +	pinctrl-0 = <&cci3_0_default>;
> +	pinctrl-1 = <&cci3_0_sleep>;
> +};

You should only have to enable the bus you are using..

> +
> +&cci3_i2c0 {
> +	camera@1a {
> +		compatible = "sony,imx577";
> +		reg = <0x1a>;
> +
> +		reset-gpios = <&tlmm 135 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default", "suspend";
> +		pinctrl-0 = <&cam3_default>;
> +		pinctrl-1 = <&cam3_suspend>;
> +
> +		clocks = <&camcc CAM_CC_MCLK3_CLK>;
> +		assigned-clocks = <&camcc CAM_CC_MCLK3_CLK>;
> +		assigned-clock-rates = <24000000>;
> +
> +		dovdd-supply = <&vreg_s4a>;
> +		avdd-supply = <&vreg_cam3_1p8>;
> +		/* dvdd-supply = <&vdc_5v>; */

Either include vdc_5v or drop the comment.

> +
> +		port {
> +			imx577_ep3: endpoint {
> +				clock-lanes = <7>;
> +				link-frequencies = /bits/ 64 <600000000>;
> +				data-lanes = <0 1 2 3>;
> +				remote-endpoint = <&csiphy3_ep>;
> +			};
> +		};
> +	};
> +};
> +
>   &qupv3_id_1 {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index a867694b15b307344b72041e972bae6e7543a98f..d50f0d84fdb5130d8386b107702800382bcaac47 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -4756,6 +4756,138 @@ tlmm: pinctrl@f000000 {
>   			gpio-ranges = <&tlmm 0 0 149>;
>   			wakeup-parent = <&pdc>;
>   
> +			cam0_default: cam0-default {
> +				mclk {
> +					pins = "gpio72";
> +					function = "cam_mclk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rst {
> +					pins = "gpio132";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			cam0_suspend: cam0-suspend {
> +				mclk {
> +					pins = "gpio72";
> +					function = "cam_mclk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rst {
> +					pins = "gpio132";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +					output-low;
> +				};
> +			};
> +
> +			cam1_default: cam1-default {
> +				mclk {
> +					pins = "gpio73";
> +					function = "cam_mclk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rst {
> +					pins = "gpio133";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			cam1_suspend: cam1-suspend {
> +				mclk {
> +					pins = "gpio73";
> +					function = "cam_mclk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rst {
> +					pins = "gpio133";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +					output-low;
> +				};
> +			};
> +
> +			cam2_default: cam2-default {
> +				mclk {
> +					pins = "gpio74";
> +					function = "cam_mclk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rst {
> +					pins = "gpio134";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			cam2_suspend: cam2-suspend {
> +				mclk {
> +					pins = "gpio74";
> +					function = "cam_mclk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rst {
> +					pins = "gpio134";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +					output-low;
> +				};
> +			};
> +
> +			cam3_default: cam3-default {
> +				mclk {
> +					pins = "gpio75";
> +					function = "cam_mclk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rst {
> +					pins = "gpio135";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			cam3_suspend: cam3-suspend {
> +				mclk {
> +					pins = "gpio75";
> +					function = "cam_mclk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rst {
> +					pins = "gpio135";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +					output-low;
> +				};
> +			};
> +
>   			cci0_0_default: cci0-0-default-state {
>   					pins = "gpio60", "gpio61";
>   					function = "cci_i2c";
> 

---
bod


