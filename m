Return-Path: <linux-kernel+bounces-878038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA11C1FA04
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09C6F4EA112
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBE133DEFD;
	Thu, 30 Oct 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqDeOkJ0"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391353358CE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821064; cv=none; b=PpgENHlLzlNz/7UgFfdlJsPHrJcc9EKJQVdhNn2NtXGAcge+IDeuKDYVmWGcrLxhvF6AGMx/aR2D/LrU2fvD5kUjDJeZE7qhL//SZ6710i9x2OYPiIDsVwuumqinKn6zZcwv6XmWqMYEqxXtKGq2pvvTrGSkBT27BMz9znu12x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821064; c=relaxed/simple;
	bh=WBNuq+ZGVxRWTCoDAXYspaxNG/EOMwfhzOF6NNl22pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9WCbj6/+08tKwgl94gGwMwAD3iRe+SUIrydYs+ef1L1w1Ao99nRSKRhYd3cQPdqjE6k4iLTlzEJZthQ+dBaP3ZIxW7gBM0DBpRE5q1Wk497KdSLq8yw5dhDdCSpfpdLFwrjwSuG6gFrcYGVqy6W5T6SSVP8E3EOTGwP3csmMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dqDeOkJ0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3e9d633b78so227240866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761821060; x=1762425860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOErGZpwLMOb7PwfNc34LT3iVngAjXuP7cLtNkH6Fno=;
        b=dqDeOkJ0zee/6wsx7HfVyGLj1p7EWv9PWVfkLMVSDFQlIow8/et3xbkvSN2hRHi8w9
         kl8deXgZkWwb7lenp0FJI5C7GGZ07XeRMwG+AjON0QKKmetxMq7KxSZ8PJpUXv+sAW3Y
         qZIypgPnBEmDi0DO9k2kbL0y4AL1R+wIBAZIohNNw9lmgbs6sWT5v3Zxeqrk+6UQKLIw
         eih3OcjE8fei55tpKuMoV3w7N3/yqcqBw3NBTSk0hDkUTYLjkxm9Dok6nPdkm6mB93Pu
         HFaTdRp/l1Vh0zPwhByPVWeRfIEBSr4JlER7eEdBurUOqPosSng+0oPyxdcaXvgF8DEE
         C9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821060; x=1762425860;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOErGZpwLMOb7PwfNc34LT3iVngAjXuP7cLtNkH6Fno=;
        b=RzAnQz16yI1qiZ/2CatJS0lMLmNPx7zxg9IJYeXdHnT26SSU3+1rqz1bqtuZEDy7Cr
         4I7khHBb+Jjt3wiGZwic1mDT2Zo7FGhORLoUqkmvPyz4xTcSt2BbtKBzgb5Ot7Aqz7jE
         oQ8h6Ugmg1KITX10NeEJ2j4/PzFD7ozlZoLExzY0jkZ9Cq402mg/YyrkzxZSHNwEDR+P
         63vXEN2izq7h7jM4lSm8oXN2jYZmzJ2Ng8fbFuPaCl1yUqGuzRmLLus2U/HtgJZkMPy8
         RfoMeufDo3CBdbXJg9aRuZ+nmWdiDPR7DK5aK6j1bUgFU6cU6CZVKqP5xoBYWrRWHFnv
         92gw==
X-Forwarded-Encrypted: i=1; AJvYcCU+o9MFRinb3tk5cij0G5g0KIjZsFZsKWEmRMasN4gvOAAYyhcVcmz3YXF6Lyak+nDr2JfRo4KnvI2sZWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ0DrxHdo8myOyjUJp5RDDCyfo8hLZU0vV0YjDQH3re7qYx8DP
	LKBUkojwQYQeVkSalVY+srFvbILQ4BLIP6Y/xyHSO+bNWdKFw+Y3L53lJc03I94LbKo=
X-Gm-Gg: ASbGncsr2kmdkWsEctz1uiYVwH8LbcdaBrVoGwEfPmQ0T1AXBGeRWEh4650QZKmi5yK
	SfWL+J5Ns9uZOL668dkZ92y5Z/sQp0se52WrMQ0LO9tfsucsVZuWl7UNXEiu7N7IDpQJz9+sGPw
	JIrbjTAyMRFeFtcMlJqsvNFSgoCdLcXtfDil5orXitA8MkBBYshIqRHEpUTJc8LgP7lUdMCEiB4
	WW/Ix3cDyCQWoAFaVZfKJvWo2QvQgUE8iHFN8lq8TumyMzzWr+mficuSV2hcxT196juFNHFidcR
	CJ7NjjMIBlXe1lpv5tdfBUZgV6O2v2tGCjRdq3iqNTLeSyPEyUjDVLEYGex9QFs5A3D869kJXTs
	8ybJY9MBChdEILfkvtp1ibgRZSNGjsIYxB6eUd9mkkjDx2p7172J2uLGqjA9fC+rZoY7ot8bQJq
	cXu3cic4ujQ1S+fAYwHPh5r4TlVYnHXE7W2lQnzhOBHOKEsS4WSFSKW+Ox6CCCguQ=
X-Google-Smtp-Source: AGHT+IGtYVJD/Y/pHf4k9CBt97P94Orn8JwMiP/b+9frzwAxKr8mPjQLaIEcIupT/9ucSIpkO3DApA==
X-Received: by 2002:a17:907:d1a:b0:b70:4f7d:24f8 with SMTP id a640c23a62f3a-b70520e4069mr289801566b.22.1761821060521;
        Thu, 30 Oct 2025 03:44:20 -0700 (PDT)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85445e81sm1710205466b.64.2025.10.30.03.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:44:20 -0700 (PDT)
Message-ID: <9b6b1427-9712-4934-8b0c-ab0a8ae97b4a@linaro.org>
Date: Thu, 30 Oct 2025 10:44:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: monaco-evk-camera: Add DT
 overlay
To: Vikram Sharma <quic_vikramsa@quicinc.com>, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 quic_nihalkum@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ravi Shankar <quic_rshankar@quicinc.com>,
 Vishal Verma <quic_vishverm@quicinc.com>
References: <20251015131303.2797800-1-quic_vikramsa@quicinc.com>
 <20251015131303.2797800-4-quic_vikramsa@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015131303.2797800-4-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 14:13, Vikram Sharma wrote:
> From: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> 
> Monaco EVK board does not include a camera sensor in its default hardware
> configuration. Introducing a device tree overlay to support optional
> integration of the IMX577 sensor via CSIPHY1.
> 
> Camera reset is handled through an I2C expander, and power is enabled
> via TLMM GPIO74.
> 
> An example media-ctl pipeline for the imx577 is:
> 
> media-ctl --reset
> media-ctl -V '"imx577 3-001a":0[fmt:SRGGB10/4056x3040 field:none]'
> media-ctl -V '"msm_csiphy1":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -l '"msm_csiphy1":1->"msm_csid0":0[1]'
> media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
> yavta -B capture-mplane -c -I -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video1
> 
> Co-developed-by: Ravi Shankar <quic_rshankar@quicinc.com>
> Signed-off-by: Ravi Shankar <quic_rshankar@quicinc.com>
> Co-developed-by: Vishal Verma <quic_vishverm@quicinc.com>
> Signed-off-by: Vishal Verma <quic_vishverm@quicinc.com>
> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |  4 +
>   .../dts/qcom/monaco-evk-camera-imx577.dtso    | 96 +++++++++++++++++++
>   2 files changed, 100 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk-camera-imx577.dtso
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 296688f7cb26..4df3044639a4 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -36,6 +36,10 @@ lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx5
>   
>   dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera-csi1-imx577.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
> +
> +monaco-evk-camera-imx577-dtbs	:= monaco-evk.dtb monaco-evk-camera-imx577.dtbo
> +dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk-camera-imx577.dtb
> +
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk-camera-imx577.dtso b/arch/arm64/boot/dts/qcom/monaco-evk-camera-imx577.dtso
> new file mode 100644
> index 000000000000..2237f0fc4a14
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/monaco-evk-camera-imx577.dtso
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/clock/qcom,sa8775p-camcc.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +&{/} {
> +	vreg_cam1_2p8: vreg-cam1-2p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_cam1_2p8";
> +		startup-delay-us = <10000>;
> +		enable-active-high;
> +		gpio = <&tlmm 74 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&camss {
> +	vdda-phy-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			csiphy1_ep: endpoint {
> +				clock-lanes = <7>;
> +				data-lanes = <0 1 2 3>;
> +				remote-endpoint = <&imx577_ep1>;
> +			};
> +		};
> +	};
> +};
> +
> +&cci1 {
> +	pinctrl-0 = <&cci1_i2c0_default>;
> +	pinctrl-1 = <&cci1_i2c0_sleep>;
> +
> +	status = "okay";
> +};
> +
> +&cci1_i2c0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	camera@1a {
> +		compatible = "sony,imx577";
> +		reg = <0x1a>;
> +
> +		reset-gpios = <&expander2 1 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&cam1_default>;
> +		pinctrl-names = "default";
> +
> +		clocks = <&camcc CAM_CC_MCLK1_CLK>;
> +		assigned-clocks = <&camcc CAM_CC_MCLK1_CLK>;
> +		assigned-clock-rates = <24000000>;
> +
> +		avdd-supply = <&vreg_cam1_2p8>;
> +
> +		port {
> +			imx577_ep1: endpoint {
> +				clock-lanes = <7>;
> +				link-frequencies = /bits/ 64 <600000000>;
> +				data-lanes = <0 1 2 3>;
> +				remote-endpoint = <&csiphy1_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	cam1_default: cam1-default-state {
> +		mclk-pins {
> +			pins = "gpio68";
> +			function = "cam_mclk";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		ldo-avdd-pins {
> +			pins = "gpio74";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +};
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

