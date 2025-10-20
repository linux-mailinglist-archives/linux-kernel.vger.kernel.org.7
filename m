Return-Path: <linux-kernel+bounces-861034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB90BF1A52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4C444F60CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387B31B133;
	Mon, 20 Oct 2025 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDUw3PpE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB431D399
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967962; cv=none; b=tQoGgqXm3hqROK/KsjY32nv3HID3wK2ZGWYazTkpsA0MXCyt+dCgArpUEikq/uE/S4XFFMLuCSmkCgBRy4iFlyo/6AN3nw5Y7MNuodYsX0EaZm1wy5DhEot0r6qd3ISTQH0/nj70MlEnWumnmCxoyIXB47025C2lkve/3J2aK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967962; c=relaxed/simple;
	bh=tqmAXFIUqMJJYe2TezHGEYoHz+RbiIgC7MYcdc7oCuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYF+GZKFTPxFwS9npXpFKgrUYkrn3vvxNRZJBa7FYzwcbASADMK/rni5h0k0Eb7aumuSWbJBtceg5PzIuzW9VzJNGEVtqE7P6wiJBe8tgtZtznkRnjmURRy+nF1ySKjzSTM5PDhTHqaPoroEzV3c1MAa0k9tK/b5h+2+ic4YiLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDUw3PpE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c0eb94ac3so7760987a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760967959; x=1761572759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsdSXxtK2e/jSRjlYL+PvN4ai9sNqYnnc+D+KNBqw4s=;
        b=iDUw3PpENFEx3AmLQ1yCUtH2UCmmfLLQbvPqCMlz46mJahrCoVcXVEJ8832IV/VO+R
         Gu0RqmwcE7oTAy8szJyHe0SnzqpLsE9e/T8Vn8PhxuW0NivSzZWCX360SM1lbGaXiG/N
         DQ3M0q06//rJXwKPLKpCpDmFCFZwqDtlmNxSgsj44kAqeHAXklte2mKVpoQDFAp9p5Eq
         NFkVWjAtlByiJxFCljdJpkZk2xVFs+gAdj9G50G03IX4qmi6VTYT8i0Now1sfnnAib+z
         on/908xS8lHrsreV2CQwWOWMnQedbmEEmTzIkPP8Msd4y7rEDX7EXRv6uEI6HhGlBwQd
         t/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760967959; x=1761572759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsdSXxtK2e/jSRjlYL+PvN4ai9sNqYnnc+D+KNBqw4s=;
        b=vcLrmlWJQyd77vVnfnyic80nwxAqOL3VDhJZWmYrHxCYB+ghZz2iepJ/xURWGq7Evx
         YEwB6kBTuyA1xUGgpkyt6GEMfxSnZDKsHNLQTU+sFPAeOUhbE+GwJ6EYcUM3KtR6/Cni
         6ojRLVFK/DwMHt/xe4g8aaqy8409TlKu/sPl/Fhy9fSTYUuL1Xcx2Y5lk54X66Sp5c3j
         NIzkG/EM/hFot77g7A+o4qGLWT7xlwQzPxZa0Jycj0rpSV46nzwYRfngKMcAEvBUzriB
         RI20jHY+FNfSd3/8QRM5t/Lft/2BfcJXqims5ZhQgyKH9jQ1xLdyBFg7PRtHbubPsRnn
         ag5w==
X-Forwarded-Encrypted: i=1; AJvYcCUxaKo9wEni+D5cy7GX1cHtQwt38XMslqPvVDIBXAEbt/COJeJm8sJ3h1JE1SlHseflDhNbiSpvp5RlvYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijLVA//N0zTwdcX+n33EJGZEM0W+L7mCEHaHVSig2rf/nIgJK
	emz1Dyy09hKHQIB4InR6OFZXVx2OC/9pP7m558f25Tyv+snQB7CaghtJt69ikzXq8aA=
X-Gm-Gg: ASbGncuXX8jXPWUMKDU+/8PFHrs2L/zrgr8bHyygfDaogULeuZeZqCppPLYtIAZxWUo
	Am/l49Cek+P7/ZpYHx0EicceJW79UuURaQgywEpGplyxNo/zcvnU7UvI+ddfoO6YpsbqdJFrgBG
	ekdGxMwCXaEzwSHhHt1xr+rSgYTz3OyBOyY1ARic/kyp0rpbrtzmpkkr5GP53+xtVcBLpkbgtiM
	16lu6dyJKvvRXZ18X69yNHcuwej5iBpz/fe71D3BrXMqh2U8bworX7EuTFnIiBQ+WfbbIVBfKjm
	5td5tsqtqIjSHzyw0nkJyv+T7VZx+AsSsSsrcIUKGOqGxqLlpj3RXh4y/MEsIR65DKByKOZDm5Y
	LY8hR3ugAJzY4ZNfYrtblvpzXhiLikEfhvIgx2+k72KVoGIRYNVn1x+AR0lc9cTFWswc9FC0xtm
	2LQnhSCYdshCv/PDdGrtYskQI+UQgCo+lOdIGgkrzCGuWPkZ5B/Y0=
X-Google-Smtp-Source: AGHT+IGtChbu+BFRFgmruupaHMS+YTJq85VdKiOgnQsI1T0cofPdNHTi4Ln+S+OBz5ucIxqGiunGkw==
X-Received: by 2002:a17:907:94c1:b0:b4f:ee15:8ae8 with SMTP id a640c23a62f3a-b647453ff06mr1403971766b.58.1760967958539;
        Mon, 20 Oct 2025 06:45:58 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e551.dip0.t-ipconnect.de. [91.41.229.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm793159666b.68.2025.10.20.06.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:45:57 -0700 (PDT)
Message-ID: <aeb9a34a-d9ea-4027-9f61-beae73498266@linaro.org>
Date: Mon, 20 Oct 2025 15:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] arm64: dts: qcom: sdm845-oneplus: Describe panel
 vci and poc supplies
Content-Language: en-US
To: david@ixit.cz, Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
 <20251016-s6e3fc2x01-v3-2-ce0f3566b903@ixit.cz>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251016-s6e3fc2x01-v3-2-ce0f3566b903@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/10/2025 18:16, David Heidelberg via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> There are two additional supplies used by the panel, both are GPIO
> controlled and are left enabled by the bootloader for continuous splash.
> 
> Previously these were (incorrectly) modelled as pinctrl. Describe them
> properly so that the panel can control them.
> 
> Fixes: 288ef8a42612 ("arm64: dts: sdm845: add oneplus6/6t devices")

This Fixes: is not correct, it should be the commit that first added the
panel to the DT since it was added after the initial DT.

The driver changes also need to be backported and may not apply properly
to stable kernels, so we should be careful with this.
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 46 +++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index dcfffb271fcf3..1cf03047dd7ae 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -162,6 +162,34 @@ ts_1p8_supply: ts-1p8-regulator {
>  		enable-active-high;
>  		regulator-boot-on;
>  	};
> +
> +	panel_vci_3v3: panel-vci-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "LCD_VCI_3V";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 26 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-0 = <&panel_vci_default>;
> +		pinctrl-names = "default";
> +		regulator-boot-on;
> +	};
> +
> +	panel_vddi_poc_1p8: panel-vddi-poc-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDI_POC";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&tlmm 25 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-0 = <&panel_poc_default>;
> +		pinctrl-names = "default";
> +		regulator-boot-on;
> +	};
>  };
>  
>  &adsp_pas {
> @@ -429,6 +457,8 @@ display_panel: panel@0 {
>  		reg = <0>;
>  
>  		vddio-supply = <&vreg_l14a_1p88>;
> +		vci-supply = <&panel_vci_3v3>;
> +		poc-supply = <&panel_vddi_poc_1p8>;
>  
>  		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
>  
> @@ -803,6 +833,20 @@ hall_sensor_default: hall-sensor-default-state {
>  		bias-disable;
>  	};
>  
> +	panel_vci_default: vci-state {
> +		pins = "gpio26";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	panel_poc_default: poc-state {
> +		pins = "gpio25";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
>  	tri_state_key_default: tri-state-key-default-state {
>  		pins = "gpio40", "gpio42", "gpio26";
>  		function = "gpio";
> @@ -818,7 +862,7 @@ ts_default_pins: ts-int-state {
>  	};
>  
>  	panel_reset_pins: panel-reset-state {
> -		pins = "gpio6", "gpio25", "gpio26";
> +		pins = "gpio6";
>  		function = "gpio";
>  		drive-strength = <8>;
>  		bias-disable;
> 

-- 
// Casey (she/her)


