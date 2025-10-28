Return-Path: <linux-kernel+bounces-873736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F2CC1490B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858771AA4BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB832BF48;
	Tue, 28 Oct 2025 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGNTTMMv"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15532A3E1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653711; cv=none; b=U/TEUUC159dLPQ9WsAnq65qBsDYQWp9vh4nc4vjk/jJuTt6XasnfaNiFAcumh5lwvLai4+55YHmNjPV32GAB6p7iIXTNtfNAxumxmWjVr5wX5QB+IhOrm/zrow0tn4oF+apt7Dqv7FE51CcVyCynTnQTkW422YpLv1QuNp0Q2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653711; c=relaxed/simple;
	bh=HZb1NJk9EiYvwXWi/VvLTVxzoQi8tgU2qAmxFsu1Zc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vurve7uxkSBpXRottuCj+gfaxV7Mj6r7g2lyyADdt3dbsDVrHWQcGCglgRP7hY2Q1u9yCtj5pu06CIuN/p6CxFxwYnLRug9V+s+IdwrGuxOkv+BoNizboyDMnGA7nP/bOR0v2FTfK4/o/PZ1GsIOC+cvhcYhVK8P0Hlk86kgS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGNTTMMv; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-376466f1280so88806821fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761653708; x=1762258508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJAViX7/B9WZe7f1Z9+bJz1YrkYOWWpEGINZC+5C01E=;
        b=OGNTTMMvq9mX9viB1m+SEvr09ftMEf4mZlIh6mPUu2Kl4jT7TzH0JKAVa1hkbBT95s
         Jl/2AKGuhPk+msvyGTvLVBRQmiMuvi5REZRjhgCLmAQMhpafvhw3fwmmn8coiqFpYaKz
         Hoz3h2kkEQ1+b+l87rEvw3m4er572kbDuMWOEcRm1TxgGgBp4uu9iYa9Bxo0ljwwl+Om
         uBhrsxxVI6cWf5OMgCjfBLoSmGB9nja51sjPoUPjqYxeaei7lbrbjWP1X5ICgWMbraIf
         c9UpwrOvlKTsDoDBYNfTQVcIkMyYYNjvnZKBH3C9XdRFi3CyfyHNb+jeIGcT50haDOWP
         sNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653708; x=1762258508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJAViX7/B9WZe7f1Z9+bJz1YrkYOWWpEGINZC+5C01E=;
        b=U0+n0V6klM14jMVa3MFZC+b1swMKmiQrULLUOHO6G8is3dLquqkKDA3AXrU2YzCpFN
         +F0XNd2ZBjQjcg5AtKrmERG3+6UIKaG0rl18iWaEoObKbbWFDWKJQluT4sr+gciPSQRV
         DsmMz/yQoQwUaM+Bb1wxahWVv5mR1f1ikzJCVjjME5Hlyp86VaQ4N8Xy8NHh8TjzHwSy
         na8SxGZgzZs+HHIXSHuYkQ8uArkBHayMLpQrFFWKzwq9HPJtLSahx/79qL6x7xIhTudp
         ci7RFGNPjuia8J33suAuoECmKXbSVFm7JWk2JAb9mSYre+9LcvMEPxDGBQuEDZATI0xP
         //aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv3bYV8lNulwV78yKsgwmQLeir8p1xnb7zBpmXuzdH7Qffb8HBsig65Fp22gYdIEesT4/6t2Exz2oa7V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSsMX1P4taymGhUIsrdPBJQV6/xjGAN2iuK4cCYRA2Tr3E7W3
	QhBuOvpjTIJXN9StNfRpTBJv7N7QOtGeVmJXxsEDYYraE6vw2XFohpGz
X-Gm-Gg: ASbGncvqPwHJ3s/pqlz+HxmVhBqn+E51ePjsxNbe+byAaFREH+jFzwsGt5GdEOdm86E
	eWuRDeI4nhOjORNwMjNlEPJtue1LsL5ywn9/TIo3EDy+LNSoNEbSURnnSScvawokKBDe7q5WPMv
	THmSaOd6obs3CueQ6UsAV0ZdxhltU7lDnZ/UDQ2e6ZIde2Clj93gv6jvxal3/ksOlpFHg3q2BZz
	4uYjj9VjvG1luet12k2xS+U74cVYvqdJl3DinU7JOM7Ssx1Prm1Cl0gPCDdsVZvZiCZP43oEUYN
	pvlXkXAsx3o4+7JfxHRFQcK0W4zv+rXa98eoF3ER7mFXPvefRkQkq4Waf4OVFJa+AmT+wlqa/27
	6OSFBIJ91NYfLnZVFr3BeWELZ/u11S18ToPwk8vWDOYd4c/q2Sw2YCYEEYBv62Pq7RCMtRKz+CC
	CJs2wfiYFgzEAgXkqCRtctdlpqFoPh3TXGZAY+FHW0NEzNfIDiz2Osxrcjrg==
X-Google-Smtp-Source: AGHT+IFB+EXEALL0lVPB7zL+t0ISwe5rbBYFS+A45wiTOhrUz5I795qhcCG4TnO4o8BABiT+ozftyw==
X-Received: by 2002:a05:651c:20cb:20b0:378:ddbe:2d95 with SMTP id 38308e7fff4ca-379076c11aemr8817671fa.20.1761653707262;
        Tue, 28 Oct 2025 05:15:07 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee09204esm28490401fa.8.2025.10.28.05.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:15:06 -0700 (PDT)
Message-ID: <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
Date: Tue, 28 Oct 2025 14:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: maudspierings@gocontroll.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maud,

Thanks for the upstreaming work! :)

On 22/10/2025 10:22, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> The Ka-Ro Electronics tx8m-1610 is a COM based on the imx8mm SOC. It has
> 1 GB of ram and 4 GB of eMMC storage on board.
> 
> Add it to enable boards based on this module
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>   .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 439 +++++++++++++++++++++
>   1 file changed, 439 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
> new file mode 100644
> index 0000000000000..46d3ad80942cc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
> @@ -0,0 +1,439 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 Lothar Waßmann <LW@KARO-electronics.de>
> + * 2025 Maud Spierings <maudspierings@gocontroll.com>
> + */
> +
> +#include "imx8mm.dtsi"
> +

// snip

> +	pmic: pmic@4b {
> +		compatible = "rohm,bd71847";
> +		reg = <0x4b>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		pinctrl-names = "default";
> +		rohm,reset-snvs-powered;
> +
> +		regulators {
> +			reg_vdd_soc: BUCK1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <900000>;
> +				regulator-min-microvolt = <780000>;
> +				regulator-name = "buck1";
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			reg_vdd_arm: BUCK2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <950000>;
> +				regulator-min-microvolt = <805000>;
> +				regulator-name = "buck2";
> +				regulator-ramp-delay = <1250>;
> +				rohm,dvs-run-voltage = <950000>;
> +				rohm,dvs-idle-voltage = <810000>;
> +			};
> +
> +			reg_vdd_dram: BUCK3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <900000>;
> +				regulator-min-microvolt = <805000>;
> +				regulator-name = "buck3";
> +			};
> +
> +			reg_vdd_3v3: BUCK4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-name = "buck4";
> +			};
> +
> +			reg_vdd_1v8: BUCK5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1950000>;
> +				regulator-min-microvolt = <1700000>;
> +				regulator-name = "buck5";
> +			};
> +
> +			BUCK6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				/*
> +				 * The default output voltage is 1.1V, bumped
> +				 * to 1.35V in HW by a 499R/2.2K voltage divider in the
> +				 * feedback path.
> +				 */

Could/Should this be described using the:
'rohm,feedback-pull-up-r1-ohms' and
'rohm,feedback-pull-up-r2-ohms'? If I understand the comment correctly, 
that might allow the driver to be able to use correctly scaled voltages.

https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108

> +				regulator-max-microvolt = <1100000>;
> +				regulator-min-microvolt = <1100000>;
> +				regulator-name = "buck6";
> +			};

Yours,
	-- Matti

