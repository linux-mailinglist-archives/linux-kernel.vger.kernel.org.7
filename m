Return-Path: <linux-kernel+bounces-855116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01B2BE047C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98390544005
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078C30171F;
	Wed, 15 Oct 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHpTziac"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFB30170B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554644; cv=none; b=mIhADEFgNWJeULEgymyjiGHYArXjgcVhepZkkMD96qHSqjFO24Xxc25yyFUTbbUAKPHLyUwHd0+se3zKrXzJ5nbK9TxhvDR5l5wan9sx+gQNuDf3kVTEVUnurGRKdi74rUfreqnpSnKFqbqaIRBfYy81dEOjjQ6PcErSE3Qq7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554644; c=relaxed/simple;
	bh=yFAYAzsCtahC4P6JDRX/+JDxOrD86QZ4jTF69Kbzd3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzUa20J0WQIOWMqkF8Cgr+cgSvvahoyqVfzUJ8rllGDwNKVcw4VM++/tSwAy6Z4ZDUwA0QxFcob7Y6tJqrrBaaL4L44Op9qgnlE+oWgB0fiY/Vs2cYc2rB7xJFpU72tNvPxGAm1zWTnKJmdNuGWxMLmakD+HwQ2OELgGxAkiQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sHpTziac; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-582067563fcso1147513e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760554640; x=1761159440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbGZO2JzBM3C8yY+OgT+lQXCHpnKxv2MA/NXQz9rs8k=;
        b=sHpTziacj22NVGC2NljTPiAe3abMAgojwhnh7itAWHvNWRnaKLkKgMpqSHzlcCE0Jk
         7YUD4LwSolRWJrU3PC/pMeoUsNiRXd29Me8th+Ng38BA5k/qAxyFCliSN2qogakBmP33
         FxvbpA9udU5gDi//rRm5q+inBtS8gWPaKlxhbkrzI24k2nNi+5NHFpNWZm9WKHLBq4Jj
         uA45xd+bBr8tBDFpEX/I72D3MOx7wG4rVtGIAmqdq6BFW6tf75djFXO/zp+Gpln3USH2
         yPDCom7m/kT3//sb67jWvgRUfFQv2AIfZ1ypM2ceUkXrZfogagFIBe/eF4TPgCIWjLi7
         qQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554640; x=1761159440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbGZO2JzBM3C8yY+OgT+lQXCHpnKxv2MA/NXQz9rs8k=;
        b=JHeP53i2BFW8l+yJMoC8JS3GDWTDFsC1jzC2XHCUU5tNszXbGBqjbElYwSE0FjHfUJ
         ArcCpuwOUdE9Sy4/eDfv6nYUGHaGh/Z2ECK+E5sEgMjvB360RyLde6WAr1x21ShbVfen
         Zq090CjS8dYyEqKH283Utruwgc3tr3iZZQnfu9M3BVLb0QKEV73rdRmEBi9SMfY2cy89
         iMtaFpTRtnGn3JIxrhCUFKzoGZVZZZP2Ngr0F3LKQl2oMXSa2emFEgBA0BlWy1bjiet6
         UXO1+Kzppv5vKnWjpkwfWUhm/7l+oXHmv+s4pQPbZSgE+/GG/oSmOIxEo1aFbDZkNo37
         /svQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzOxDtngdqgKwwfs0FmRZMBRfEOVVsxA2sy9Xk/wnBCKa5nIEkZPHGN2greGsvxf2oIs0dORq6Xdk3dPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8W8gTAYlUSZ4D7kvCUy1cVzsKC11Y0DEaafvYq8WwnzkXWEuq
	dd1xbc9bpozBiz82bvty6JQhMzp2wwX7wFI32PX2Ar5wbBNxcDUkqW1xp1EDPbM7Cjk=
X-Gm-Gg: ASbGncuLEBoYDiU7MVJf5TDn1IL8Yuh7hUUk8d4QUBb3AwE3RbydmIwTgSVRCbPhMs0
	o9xEB0YKVH004x/U8++9+u0H3Fa+c0EAT3UpmnAqeXWvDjTDBX2xfRxRJqV152FL1eVBQT0rP0p
	UlVil58Rkvyomzg1Qz94Jcb5Cf1a8Dsb8bYM3gonSN5WtxZCmGt01CQPwgtjuxeo/dPUEkF4i2O
	Vr7yY0w34bBpMV/JsPA3jPDJ1QK8Acj76m/CyPm9008xxeOcH77SN8m16wkYtCUVSoVt0tg0SLJ
	IUxhhz/tWM1S84zfHZTgkduCSVz60KngBYvIVpIiMojURkjqFC0ROEbdQWQ4+I6/Y1B4/YM3KAO
	+Gey34pA8qHiJoz7T43k1m/3FOq2k9o5BOgsYzK9hlFhoBpqwqD3cbUv0z+jWG70jb73OVMJ78H
	FzI8O7cVBifYogBY2ShXh7rGULfw2PFHRKYkFH+cDl1xHJDt8QWaAlEIBZVkd/b8GTccdYPg==
X-Google-Smtp-Source: AGHT+IFyiRTaSwsEIiGfhDM9ts2EzTtk0FkdwXLTAfK+ZuWckcwevLUv7QKNU/w7vv2dJ6g6w2mcFg==
X-Received: by 2002:a05:6512:2c03:b0:585:229a:22 with SMTP id 2adb3069b0e04-5906d8b20e0mr4959112e87.3.1760554639869;
        Wed, 15 Oct 2025 11:57:19 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f8c85sm6423982e87.32.2025.10.15.11.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 11:57:18 -0700 (PDT)
Message-ID: <90cb8d1b-ebed-434e-9efd-9357e10a6ee0@linaro.org>
Date: Wed, 15 Oct 2025 21:57:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: qcs8300: Add CCI definitions
Content-Language: ru-RU
To: Vikram Sharma <quic_vikramsa@quicinc.com>, bryan.odonoghue@linaro.org,
 mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 hverkuil-cisco@xs4all.nl, cros-qcom-dts-watchers@chromium.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 quic_nihalkum@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ravi Shankar <quic_rshankar@quicinc.com>,
 Vishal Verma <quic_vishverm@quicinc.com>
References: <20251015131303.2797800-1-quic_vikramsa@quicinc.com>
 <20251015131303.2797800-3-quic_vikramsa@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20251015131303.2797800-3-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 16:13, Vikram Sharma wrote:
> From: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> 
> Qualcomm QCS8300 SoC contains 3 Camera Control Interface (CCI). Compared
> to lemans, the key difference is in SDA/SCL GPIO assignments and number
> of CCIs.
> 
> Co-developed-by: Ravi Shankar <quic_rshankar@quicinc.com>
> Signed-off-by: Ravi Shankar <quic_rshankar@quicinc.com>
> Co-developed-by: Vishal Verma <quic_vishverm@quicinc.com>
> Signed-off-by: Vishal Verma <quic_vishverm@quicinc.com>
> Co-developed-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qcs8300.dtsi | 303 ++++++++++++++++++++++++++
>   1 file changed, 303 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 75fafbcea845..8f2b5f40ce14 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -4769,6 +4769,117 @@ videocc: clock-controller@abf0000 {
>   			#power-domain-cells = <1>;
>   		};
>   
> +		cci0: cci@ac13000 {
> +			compatible = "qcom,qcs8300-cci", "qcom,msm8996-cci";
> +			reg = <0x0 0x0ac13000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
> +
> +			clocks = <&camcc CAM_CC_CPAS_AHB_CLK>,
> +				 <&camcc CAM_CC_CCI_0_CLK>;
> +			clock-names = "cpas_ahb",
> +				      "cci";
> +
> +			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
> +
> +			pinctrl-0 = <&cci0_i2c0_default &cci0_i2c1_default>;
> +			pinctrl-1 = <&cci0_i2c0_sleep &cci0_i2c1_sleep>;
> +			pinctrl-names = "default", "sleep";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disabled";

Please remove empty lines between individual properties above and in two
other introduced device tree nodes.

> +
> +			cci0_i2c0: i2c-bus@0 {
> +				reg = <0>;
> +				clock-frequency = <1000000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			cci0_i2c1: i2c-bus@1 {
> +				reg = <1>;
> +				clock-frequency = <1000000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		cci1: cci@ac14000 {
> +			compatible = "qcom,qcs8300-cci", "qcom,msm8996-cci";
> +			reg = <0x0 0x0ac14000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>;
> +
> +			clocks = <&camcc CAM_CC_CPAS_AHB_CLK>,
> +				 <&camcc CAM_CC_CCI_1_CLK>;
> +			clock-names = "cpas_ahb",
> +				      "cci";
> +
> +			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
> +
> +			pinctrl-0 = <&cci1_i2c0_default &cci1_i2c1_default>;
> +			pinctrl-1 = <&cci1_i2c0_sleep &cci1_i2c1_sleep>;
> +			pinctrl-names = "default", "sleep";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disabled";
> +
> +			cci1_i2c0: i2c-bus@0 {
> +				reg = <0>;
> +				clock-frequency = <1000000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			cci1_i2c1: i2c-bus@1 {
> +				reg = <1>;
> +				clock-frequency = <1000000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		cci2: cci@ac15000 {
> +			compatible = "qcom,qcs8300-cci", "qcom,msm8996-cci";
> +			reg = <0x0 0x0ac15000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 651 IRQ_TYPE_EDGE_RISING>;
> +
> +			clocks = <&camcc CAM_CC_CPAS_AHB_CLK>,
> +				 <&camcc CAM_CC_CCI_2_CLK>;
> +			clock-names = "cpas_ahb",
> +				      "cci";
> +
> +			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
> +
> +			pinctrl-0 = <&cci2_i2c0_default &cci2_i2c1_default>;
> +			pinctrl-1 = <&cci2_i2c0_sleep &cci2_i2c1_sleep>;
> +			pinctrl-names = "default", "sleep";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disabled";
> +
> +			cci2_i2c0: i2c-bus@0 {
> +				reg = <0>;
> +				clock-frequency = <1000000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			cci2_i2c1: i2c-bus@1 {
> +				reg = <1>;
> +				clock-frequency = <1000000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>   		camss: isp@ac78000 {
>   			compatible = "qcom,qcs8300-camss";
>   
> @@ -5063,6 +5174,198 @@ tlmm: pinctrl@f100000 {
>   			#interrupt-cells = <2>;
>   			wakeup-parent = <&pdc>;
>   
> +			cci0_i2c0_default: cci0-0-default-state {

I'd suggest to rename cciX_i2cY_* to cciX_Y_* to shorten the labels,
also it will match device tree nodes. Here "i2c" suffix brings no
valuable information.

Please reference to lemans.dtsi and sm8550.dtsi examples.

> +				sda-pins {
> +					pins = "gpio57";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio58";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +			};
> +
> +			cci0_i2c0_sleep: cci0-0-sleep-state {
> +				sda-pins {
> +					pins = "gpio57";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio58";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
> +
> +			cci0_i2c1_default: cci0-1-default-state {
> +				sda-pins {
> +					pins = "gpio29";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio30";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +			};
> +
> +			cci0_i2c1_sleep: cci0-1-sleep-state {
> +				sda-pins {
> +					pins = "gpio29";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio30";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
> +
> +			cci1_i2c0_default: cci1-0-default-state {
> +				sda-pins {
> +					pins = "gpio59";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio60";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +			};
> +
> +			cci1_i2c0_sleep: cci1-0-sleep-state {
> +				sda-pins {
> +					pins = "gpio59";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio60";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
> +
> +			cci1_i2c1_default: cci1-1-default-state {
> +				sda-pins {
> +					pins = "gpio31";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio32";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +			};
> +
> +			cci1_i2c1_sleep: cci1-1-sleep-state {
> +				sda-pins {
> +					pins = "gpio31";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio32";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
> +
> +			cci2_i2c0_default: cci2-0-default-state {
> +				sda-pins {
> +					pins = "gpio61";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio62";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +			};
> +
> +			cci2_i2c0_sleep: cci2-0-sleep-state {
> +				sda-pins {
> +					pins = "gpio61";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio62";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
> +
> +			cci2_i2c1_default: cci2-1-default-state {
> +				sda-pins {
> +					pins = "gpio54";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio55";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +			};
> +
> +			cci2_i2c1_sleep: cci2-1-sleep-state {
> +				sda-pins {
> +					pins = "gpio54";
> +					function = "cci_i2c_sda";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				scl-pins {
> +					pins = "gpio55";
> +					function = "cci_i2c_scl";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
> +
>   			hs0_mi2s_active: hs0-mi2s-active-state {
>   				pins = "gpio106", "gpio107", "gpio108", "gpio109";
>   				function = "hs0_mi2s";

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

