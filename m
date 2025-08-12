Return-Path: <linux-kernel+bounces-765133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFFAB22BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E9503C36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3431E835B;
	Tue, 12 Aug 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhqohvny"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3B2D3235
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013529; cv=none; b=tjjgBXukftjSL1XtGwjvh0Z6upQ8ij4NL+eTtQHAD55xT4jc2aOofhw6UXikS16ERy0vwTWUiUqK9cEfV3rA4hOM67au3Ja2WL3aNmTY0VV1Nm5UJKk0MA41BBLEwf2ISIMGeS2UoQPrYmz3u5UXexPKbuP4GyOWcQKP6GQ8SNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013529; c=relaxed/simple;
	bh=5Se+F+1EMlhc69tsHduseJG4sR0ixpFpMm5/AlgsW7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPhjY+602CW9nTy3980Yrfq2mUmUjC9ODbsDEK3Bk9cdjPwHBweKd3jbeJXAulFYNbkRiWl+xU+FjoAGoHU3U7fZCOfX42jG6hMiO9yhr7Y25XzafFCSjQfww5p8TfwGHfUvTWFsBiowQzV4YaqlbnTDe7wSRBXOGUjJK6dpmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hhqohvny; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so9890251a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755013526; x=1755618326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w7CnICIdbhtr4UaouZj4YBT6fSBX0mSxz7ag9u7Kuww=;
        b=hhqohvnyDtrWigVBbztXbpu8l5A/E9ddO7x6hj2u6h+FGbe9xI9Qp93uXswdQ1znG5
         kaeB1/qlTlHDozUsqHjAYHViBI7Ix6BUepCamdBpWMi029STnXLmLnzOc2BVPOC6+VA9
         7eJEIr5roYWq8QsEf0fOCHVdoshjMCUpDZNcde0o6HJTNVXoEp/XXdrnvul3YuzmZFxV
         YQh1EPdScywB1jgCQIC3pVIgcKjKDF6VZ79H27aJUmrzZWcJxUmR+ZX/JY/F9Tbx3ubv
         JJB5FuJ7V5rFJwkzkUTfPq/4k3EcFuaQsYuCUp2fDGkTk4z4Ulij69ViMvLvrZ1OicdL
         GCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013526; x=1755618326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7CnICIdbhtr4UaouZj4YBT6fSBX0mSxz7ag9u7Kuww=;
        b=Hr0CNam/REhFrmpC6BeQ8lltpiZOPV/Urh+FI8i1+XzlfVENsuclZho477+U6m6ZGr
         Yk4LZ4bVcpMRm9nMDfL3qchpy3j4QzaQVZkPzOOuVCm78rtkAgKbwjOs9TmJNZrIJAV+
         DAuT7fuMQVnLuuOP7+wGTtTqv191CmGaDY4G1C4LG41EplLCMr4GNgtCXWwU+Di0u0uS
         cN7VD6+fVOl/csW718JiVTUNJO2SPz/poZi0GLLhWdv5Py8+mQDTUZ1z0tTfh3b5CHtf
         /wrNsUA5z+/Qo7oPlyddnCorNbnnf99II7agW6iV9tPxD3Vb/DXNT0U+bMARjhfjmGUN
         KH0A==
X-Forwarded-Encrypted: i=1; AJvYcCUR/0cm8tb7WiugpoyQVSCr93E3+SJe6KArGSqyC7FRpNo4FkTVu+KNJ77EdmND8hmUJpXeOXkcpw3sF4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9G7rzI+G8/fdjGlfro/t4gE7lzuX52/OzkbQLcGGsEAPdLPLb
	q0IihnxdUh4EI2Ro5aJAY/dW2C2id2cT63KF8PJ0gjfZXDcFT+3I4MAncN2FN3gpQlU=
X-Gm-Gg: ASbGncvVftJpkZ7QnqTqSGQhl6S2ysaCYz/G7ihSIRreib2CVnFRuE9VoYdcFYPRTcx
	pVYCY4r4Wj+rKDyUCasDcMRt8EfdEZwEqDO5wEOHboRuxr87csrWccBt2u0fKDYlXZ7y2zhRdse
	GRaf3s1OOfQH+qjotB9ajFuCl1K6NG+Ai4h4y3RYtJJjF7SC7W+OtO5d/qqlBf68qw4i+epwcSa
	9CWE36dyNBz2t0nquFuchjZfdPijS6PRJkeRKOVX8+zNNR0s21+u6k1ZDUGY2lQXMPfkG7y/Q98
	bQ3cgKUZ0ICD2iIff7WSe/Co7wcGnHWEHT9gATcRmnXOn0iGb/8065lJXWpTNTQwrbR7e6ZxYDE
	NEcLPztBFfgJ5SUIlmZIYhxr/H3Nbpt+utR9EAv/Pl1JsEQ==
X-Google-Smtp-Source: AGHT+IE/DFre7Dkj0Kr639ydBYp88P4MCJv/kcPa8lmuCXkFGm+IEWxy7IQ8BXl02A6K0PyH4aL3dw==
X-Received: by 2002:a17:907:3ccc:b0:ad8:87a0:62aa with SMTP id a640c23a62f3a-afca3986331mr19664466b.27.1755013525782;
        Tue, 12 Aug 2025 08:45:25 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:167b:7c8c:a586:8ebd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a750253sm2230386566b.86.2025.08.12.08.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 08:45:25 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:45:21 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-romulus: Describe PCIe
 power supplies
Message-ID: <aJthkXa8BZMoW3CQ@linaro.org>
References: <20250812-topic-romulus_wifi_pci-v1-0-2adbed1b1f1d@oss.qualcomm.com>
 <20250812-topic-romulus_wifi_pci-v1-1-2adbed1b1f1d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-topic-romulus_wifi_pci-v1-1-2adbed1b1f1d@oss.qualcomm.com>

On Tue, Aug 12, 2025 at 03:47:23PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Describe the power plumbing to allow fully suspending the slot and the
> connected SD controller.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Are you sure these supplies really exist on the board? E.g. on the
x1e001de-devkit, Windows toggles all these GPIOs, but there doesn't seem
to be anything connected to two of them, the 12V supply is simply always
on.

Even more importantly, for a laptop I would expect they use some part
that doesn't need a beefy 12V supply. I don't have the datasheet for
RTS5261, but e.g. in [1] this chip is explicitly advertised with 3.3V
power.

I guess it's hard to be sure without schematics and it surely doesn't
hurt to toggle these GPIOs like on Windows, but perhaps a comment that
some of these likely don't exist would be good ...

[1]: https://www.sdcard.org/cms/wp-content/uploads/2023/06/SDA_computex2023_Realtek.pdf

> ---
>  .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
> index 0fd8516580b2679ee425438cb73fd4078cb20581..3a4df8f8066ae699eb7d889530f976fce565757e 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
> @@ -331,6 +331,54 @@ vph_pwr: regulator-vph-pwr {
>  		regulator-boot-on;
>  	};
>  
> +	vreg_pcie_12v: regulator-pcie-12v {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vreg_pcie_12v";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +
> +		gpio = <&pm8550ve_8_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&vreg_12v_x8_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_pcie_3v3_aux: regulator-pcie-3v3-aux {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vreg_pcie_3v3_aux";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8380_3_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&sde7_aux_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_pcie_3v3_main: regulator-pcie-3v3-main {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vreg_pcie_3v3_main";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8380_3_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&sde7_main_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
>  	sound {
>  		compatible = "qcom,x1e80100-sndcard";
>  		model = "X1E80100-Romulus";
> @@ -1022,6 +1070,12 @@ &pcie3_phy {
>  	status = "okay";
>  };
>  
> +&pcie3_port {
> +	vpcie12v-supply = <&vreg_pcie_12v>;
> +	vpcie3v3-supply = <&vreg_pcie_3v3_main>;
> +	vpcie3v3aux-supply = <&vreg_pcie_3v3_aux>;
> +};
> +
>  &pcie4 {
>  	status = "okay";
>  };
> @@ -1066,6 +1120,13 @@ rtmr0_3p3_reg_en: rtmr0-3p3-reg-en-state {
>  	};
>  };
>  
> +&pm8550ve_8_gpios {
> +	vreg_12v_x8_en: 12v-x8-reg-en-state {
> +		pins = "gpio8";
> +		function = "normal";
> +	};
> +};
> +
>  &pm8550ve_9_gpios {
>  	rtmr0_1p8_reg_en: rtmr0-1p8-reg-en-state {
>  		pins = "gpio8";
> @@ -1082,6 +1143,16 @@ edp_bl_en: edp-bl-en-state {
>  		input-disable;
>  		output-enable;
>  	};
> +
> +	sde7_main_reg_en: sde7-main-reg-en-state {
> +		pins = "gpio6";
> +		function = "normal";
> +	};
> +
> +	sde7_aux_reg_en: sde7-aux-reg-en-state {
> +		pins = "gpio8";
> +		function = "normal";
> +	};
>  };

I think you should either do a full configuration (include power-source
and everything else essential as well) or omit this entirely, because
like this you will need the proper configuration from the boot firmware
anyway.

Thanks,
Stephan

