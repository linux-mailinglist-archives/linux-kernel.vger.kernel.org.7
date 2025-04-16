Return-Path: <linux-kernel+bounces-602902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4CA880C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 14:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437F8189775E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FED28C5D0;
	Mon, 14 Apr 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hH0gb+8Y"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E529CB47
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634945; cv=none; b=rZqwrkH6egIYqAZonnUiWviNd9yuHdjuF1LE/EVsR3QH8OeluH+ERfGrk996hMSdZdvOYlmsBPpaDTTiIb79PMKX2TGt4Asu0VAfXCBN4vctqSItQbxIBdR43BSlo3THhbr2A65EGbSBqO0wvQcQb0w9kKzHM0vA3/cRA2IsTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634945; c=relaxed/simple;
	bh=pgTXZ7T0kREJFhqQfhjzGMWPlR9y7pVF4ppbZuRjtYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7sii07ezptedrFiECipue9YAjRmLux3Gjx0F+Mu5kJqJi7jkFoWg8wGXa0AkXg6SPo3NjCbRpGxuomH5j0WLys9kyVxK3yJMMKbW/zpxzK4xutBkGp7ocFBfq7vE5LJdH0URqC9+ku4Uc30YtmshHoGzlsImh8j19pOVjm49ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hH0gb+8Y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43690d4605dso33270135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 05:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744634942; x=1745239742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAiRwoIBQeS8CLJ0a9KnyQoPyTuXm99/84zDGKBFhxE=;
        b=hH0gb+8YxhU5JeA/nHAVxlIP/GA2V9oHeo0OAj8dxCJCVe3GjldCByx2DzxU9dZYqx
         zUmLt7/c6I+V4wm7rD/pHJNCuhT8xDtk+UhfZhtYMj9EoiXBqi40tuvAAhwkXLNLFIbo
         FNDa+L9GPCrik/YDukEdmM4LvdtfAQs4jh04t3AhFsGIHnnof7zurxubXYCFcycStnFc
         0fZual7PLrnMm8NgCRWMA1bzM/xtRoapbUuZhJFMYe1qGSmVPZHcytN1ueIhas/2ea7q
         0PVAZYKMDS8ZtX50I6ueSiWIjad7A1ITsS/tJsW7FeF8/ggqGrK1MT5U5Mu37M5U6CZZ
         QHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634942; x=1745239742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAiRwoIBQeS8CLJ0a9KnyQoPyTuXm99/84zDGKBFhxE=;
        b=vSUxweKMRfF480kHf0V76ndzsW1nIsziwBGdu61GDjxJlRRcCErHqELwE18k4rUady
         FMGQF3gEErYLlNhxsugRhjtbQ5YrvGADwQJVO1i/Gx6iT/qx++8SU4Y3VnF7zD8LHrAE
         OnT2DvNNlvI0yUmAWz1YpRndRT+F8EHJc/41agkxxzHhfwF8RtfVTBCSF5F9gVdil4cz
         rCj1lbkSDOdYEswMaQxM6U2e318ZZ+P386s09oFtykq6UibDMSnT+tgBGeVbdHMKvETY
         LIcaBsGZURq1ssY479jbx7eGnfTJ06uFzQtcljC32l0/MlyJa69oWdi+oJ4Kzx36foqN
         To1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW28GkEV9rOlXJHakddQb7Xp0mnUhYjxQvayyf7QJuX8+ikHSnWCC9EwrJzzAbglkUo5GEwOoqDtqfS0bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpz2vQfpdS228HABFismE0lwGyWHCGJyyWhsykKz5KBLzKyPsg
	V45d2szl5snSX1K+fKY2G34t42nXy1KWVCvi6T2R0c2WFt3D6y3fXvCZKHPag6o7XWHQU6cjaBV
	eqvg=
X-Gm-Gg: ASbGncvP6yYT5glszNuMHu9m4S+wABR0K7sxSsbkqi/rl3qO1ukYCgMs4EPYhuNVB74
	zFfXLqRFaq08r0hHcM/jp+iGw0efNRF4S2I7sQKQgaBKs5MqbZBFz3ws6BGdIVmR21g4bZ3o2RV
	1ilGEWjUZTazEV4nGX/TX0lvj6hZJBeSp5QDENXiBm+t1kJuObaCbOaprHKV/T5ez3ALQq7y8bv
	9bLJd4m9e474Uf03xJ/ltZvEhWnSQAu1ixXiaheNe/jiMb16xOCX/I1FgCUy1wTfB6e66cfPI4y
	efCbKeIy3XWPD/BvoiebTXhAhXMDp43Q7xBHYl7Bs7PDZ3+9kAz9762zXT3J+BNEJ6HlgNo=
X-Google-Smtp-Source: AGHT+IETwcdqSWAHTq3QoeUATJXYSc4gAa1L7vf/YNEJK/cRM1V6QRl3HprdoCFJadXMO+Mj9tQQ4w==
X-Received: by 2002:a05:600c:4e09:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-43f3a9b035fmr130109435e9.30.1744634942029;
        Mon, 14 Apr 2025 05:49:02 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B76.versanet.de. [94.134.59.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc78sm180134335e9.27.2025.04.14.05.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 05:49:01 -0700 (PDT)
Message-ID: <511f8414-bbb1-4069-a0a6-f7505190c1e0@linaro.org>
Date: Mon, 14 Apr 2025 14:49:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
 <20250414-perst-v2-2-89247746d755@oss.qualcomm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250414-perst-v2-2-89247746d755@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/25 07:39, Krishna Chaitanya Chundru wrote:
> Move phy, perst, to root port from the controller node.
> 
> Rename perst-gpios to reset-gpios to align with the expected naming
> convention of pci-bus-common.yaml.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 5 ++++-
>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 5 ++++-
>   arch/arm64/boot/dts/qcom/sc7280.dtsi           | 6 ++----
>   4 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 7a36c90ad4ec8b52f30b22b1621404857d6ef336..3dd58986ad5da0f898537a51715bb5d0fecbe100 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -709,8 +709,11 @@ &mdss_edp_phy {
>   	status = "okay";
>   };
>   
> +&pcie1_port0 {
> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +};
> +
>   &pcie1 {
> -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>   
>   	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
>   	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 2ba4ea60cb14736c9cfbf9f4a9048f20a4c921f2..ff11d85d015bdab6a90bd8a0eb9113a339866953 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -472,10 +472,13 @@ &pcie1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pcie1_clkreq_n>, <&ssd_rst_l>, <&pe_wake_odl>;
>   
> -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>   	vddpe-3v3-supply = <&pp3300_ssd>;
>   };
>   
> +&pcie1_port0 {
> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +};
> +
>   &pm8350c_pwm {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 7370aa0dbf0e3f9e7a3e38c3f00686e1d3dcbc9f..3209bb15dfec36299cabae07d34f3dc82db6de77 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -414,9 +414,12 @@ &lpass_va_macro {
>   	vdd-micb-supply = <&vreg_bob>;
>   };
>   
> +&pcie1_port0 {
> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +};
> +
>   &pcie1 {
>   	status = "okay";
> -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>   
>   	vddpe-3v3-supply = <&nvme_3v3_regulator>;
>   
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0f2caf36910b65c398c9e03800a8ce0a8a1f8fc7..376fabf3b4eac34d75bb79ef902c9d83490c45f7 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2271,9 +2271,6 @@ pcie1: pcie@1c08000 {
>   
>   			power-domains = <&gcc GCC_PCIE_1_GDSC>;
>   
> -			phys = <&pcie1_phy>;
> -			phy-names = "pciephy";

Isn't this a huge API breakage that will break using new DT with old 
kernels? It will also break U-boot which uses upstream DT.

This is bad enough, but at least let's break it a clean break by 
changing all platforms at once.

As I understand it, we seem to allow these breakages in DT for now (and 
this patch landing will confirm that), but perhaps we could at least 
track them somewhere or at acknowledge the breakage with a tag in the 
commit message pointing to the relevant dt-bindings patch.

Breaks-dt: 
https://lore.kernel.org/linux-arm-msm/20250414-perst-v2-1-89247746d755@oss.qualcomm.com

Kind regards,

> -
>   			pinctrl-names = "default";
>   			pinctrl-0 = <&pcie1_clkreq_n>;
>   
> @@ -2284,7 +2281,7 @@ pcie1: pcie@1c08000 {
>   
>   			status = "disabled";
>   
> -			pcie@0 {
> +			pcie1_port0: pcie@0 {
>   				device_type = "pci";
>   				reg = <0x0 0x0 0x0 0x0 0x0>;
>   				bus-range = <0x01 0xff>;
> @@ -2292,6 +2289,7 @@ pcie@0 {
>   				#address-cells = <3>;
>   				#size-cells = <2>;
>   				ranges;
> +				phys = <&pcie1_phy>;
>   			};
>   		};
>   
> 

-- 
Caleb (they/them)


