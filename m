Return-Path: <linux-kernel+bounces-888029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4DCC399E7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F7A3BC026
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A0B3090CA;
	Thu,  6 Nov 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXbiUoiK"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE43081C8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418588; cv=none; b=XpR7pmWjLyQXWus6VLcFa2eqUnA7rbUbupIE5noffPAWZy04jZUmxTkTAA/CNEtOmip8AtssaqcDHitO7uK22/V14G/AIzpHvZuxUlmAFiYHf0knZG4jkeTQPYbIJkN35dtD3RFIUrT+K0OXz/xHB+5BkyHaHXenDQ/ES+e+LZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418588; c=relaxed/simple;
	bh=v2YRLhXm0HrSxf8BfnjaxENfVrRRGKx6UO6gEm876iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJv74XemvXF9qiwx7h1xf+YvhUhNtLOeDyLfF1sGJRFtPy/OKmmzCJW96/sjg8o7uX6g2pIRHsOXFAxkqw7HKyCsOVKAD6DuVZDto1UQ4WKPmuAU1K/sP35Ms1S2BHke0hTXWnC2GCsLLJ/Z0oMRRe55xBEdbgR0bM85kix/Tso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AXbiUoiK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710022571cso6554125e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762418585; x=1763023385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEZG+cPMJvuhS066wIUvNEiIclF+bAdS7OADAJRzuRM=;
        b=AXbiUoiKwSEwThe20kSTf78zkHpVd/2/3SqzU5MOBRHnhqE3mTEYqd6hpTPEoNxDE6
         wV+DIqjENsTYICmtrViu/MW8NXB9VhXDDR+Omye/uT961VCM5awgSu/kQdQG4w4jYxVA
         q2frONyxUILlcJlJ1t6RAKpamMxhg5rzysN6A4CgxSLMeJTpGeMiVCmWzP183xK7Ckw+
         HMbF+q0OJibWGZYzBY8wfLHmBHV+BvWbH4XO34JPYJyRzHuJIkBTEyhO2bScg6F9ZmyT
         J2p9pfOrFikyVs3tXlLJpH9zziKb1q0HayI1Y2Bs7+/xrsG+Ju189ERklaZBJXEu5+m3
         fQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762418585; x=1763023385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEZG+cPMJvuhS066wIUvNEiIclF+bAdS7OADAJRzuRM=;
        b=ffo/pgUxiocqnfoW6UsPbUrGcqqx/sYx3Ls9XaP2tKXDQGz1xF0Ep33IsM9wmgJLHm
         W5dS0eCzpGml9g0N/Rq9ElMD7knODT/6agwViIzheKw+qyF+CCzVkF+8+sAXxyN4u9GO
         JicX1F6V7NnORusduEHon9Hf3GGY6u8vRKj23ZeefsDud9OyONg6QB5zz0I5gQeyW/aD
         cXd+sMaVZq7SaVJSZrjX6swY48l5hQ4Fz50rzkKw5fiGu3mLBGs5p7NzIgUs3TdhZTXV
         Nv2ZNKrqimwruvP4EpOsMEkaQwNnC0LS5rKM6ZD4PYWgtd11I1Ol6hjmfJziv7MI6sDi
         wCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXolneDFHwSG/5trWwjs0+Kt86soFGj0yXnFB2AF4gEaN7ytbIl+EUeH0brVK7Dy3gXBfnJ+qq3u3J3VYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WRBc/2LXfYNy6GiYcn8K+Rz71bs001PO+0rzXVIV0Ka1Cglz
	elPF0ST8yYYUqPqG9JlLfXW63bTMZMzAHoPCwCglUUKQ5FmgLF+FzwHnpJ+lMCZHZjg=
X-Gm-Gg: ASbGncuWq23epT0B3rwBL6Xil+IArtLjGXj9ghWNaS/9NIXtjaVRRcPVGBeDyFmZw+K
	SV2oVJj+yMULV+4IZWcswCPDjCDH8ZY5CWNqZja+gtmfjZ++BsutOcuA+C0ZM1VByd1kLjuZc5f
	xXjOKDYPBVIPNixkcYMULDdRekAxLS3KyAwyjWui+OvmnT7bXzrsFchrYp723O+cJ5wE1BhexBS
	8ZmlQ53aKDLtHf5bImxWbtdCUN9GwT3w23JZttOZ0sAz7hrVRz0BUAXFX9ZZuhHatMVtFt7RBG+
	Zefet0mkjvXuBgm/ZfLsUoaeyIBUEOZeVdBkEV58Uhpyp0PzWjL7CZ0jYxwrwtngHofyop5egc8
	qPB2oAjCWixZ2L35+rpzgnv/6Nn2UqfGenHk7UjXnASSu5cdwClS8qeKykkdsLW1+juoWXdGn9S
	HpIUdxjEk=
X-Google-Smtp-Source: AGHT+IHG3bk5k/CAUj7UuEtNvG0FbRc/6YbDxKYe2c7MR76MuFl90nA72JE7FrRjCKkX4v4cMMJrfw==
X-Received: by 2002:a05:600c:5486:b0:477:5a30:1c37 with SMTP id 5b1f17b1804b1-4775ce9de52mr52438205e9.41.1762418584714;
        Thu, 06 Nov 2025 00:43:04 -0800 (PST)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625eabf3sm40097725e9.16.2025.11.06.00.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:43:03 -0800 (PST)
Date: Thu, 6 Nov 2025 10:43:02 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: hamoa-iot-evk: Add backlight
 support for eDP panel
Message-ID: <vycaiobp3kpwu5pntzwbbzyp753ugvprkiu5sf45een2mu433m@2rbvtg5y5hw5>
References: <20251106-hamoa_dvt_backlight-v2-1-9f844c8f8110@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-hamoa_dvt_backlight-v2-1-9f844c8f8110@oss.qualcomm.com>

On 25-11-06 15:12:06, Yongxing Mou wrote:
> Previously, the eDP panel backlight was enabled via UEFI. Added backlight
> control node in kernel DTS due to some meta may not enable the backlight.
> 
> Aligned with other x1e80100-based platforms: the PWM signal is controlled
> by PMK8550, and the backlight enable signal is handled by PMC8380.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
> Changes in v2:
> - Add hamoa-iot-evk to the commit subject. [Konrad]
> - Correct the property order in the vreg_edp_bl node. [Konrad]
> - Link to v1: https://lore.kernel.org/r/20251028-hamoa_dvt_backlight-v1-1-97ecb8d0ad01@oss.qualcomm.com
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 55 ++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 36dd6599402b..454aad40de34 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -17,6 +17,16 @@ aliases {
>  		serial1 = &uart14;
>  	};
>  
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pmk8550_pwm 0 5000000>;
> +		enable-gpios = <&pmc8380_3_gpios 4 GPIO_ACTIVE_HIGH>;
> +		power-supply = <&vreg_edp_bl>;
> +
> +		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
> +		pinctrl-names = "default";
> +	};
> +
>  	wcd938x: audio-codec {
>  		compatible = "qcom,wcd9385-codec";
>  
> @@ -183,6 +193,22 @@ vreg_edp_3p3: regulator-edp-3p3 {
>  		regulator-boot-on;
>  	};
>  
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
> +		pinctrl-0 = <&edp_bl_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-boot-on;
> +	};
> +
>  	vreg_nvme: regulator-nvme {
>  		compatible = "regulator-fixed";
>  
> @@ -819,6 +845,8 @@ &mdss_dp3 {
>  	aux-bus {
>  		panel {
>  			compatible = "edp-panel";
> +
> +			backlight = <&backlight>;
>  			power-supply = <&vreg_edp_3p3>;
>  
>  			port {
> @@ -879,6 +907,22 @@ usb0_1p8_reg_en: usb0-1p8-reg-en-state {
>  	};
>  };
>  
> +&pmc8380_3_gpios {
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio4";
> +		function = "normal";
> +		power-source = <1>;
> +		input-disable;
> +		output-enable;
> +	};
> +
> +	edp_bl_reg_en: edp-bl-reg-en-state {
> +		pins = "gpio10";
> +		function = "normal";
> +	};
> +

Drop empty line.

With that fixed:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

