Return-Path: <linux-kernel+bounces-879815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C47C2420C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEB85680CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272EC32E6B3;
	Fri, 31 Oct 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVl1MOvc"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DD29AAE3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901933; cv=none; b=PqARXZGvwN/OyJqyb2DWoNlzEQtJXleX5pd+dPyECR909rTc8zeWYwPvi8qxC/PzhhynXkpIlmfOY8N5uhz3ou1w11kWgPQ3ZcU3Jt6nfZDLu0R3wfsiDRg9CJP2IzKxyuKl7DXTEq8Yy7Vix8DBsq8sJtuEOx8M9nImrkHP5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901933; c=relaxed/simple;
	bh=uv1MU+2h/dHKaKCna2SW2utKMG8X2yv37j7iiTl7hkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RC1oYbO7EdRhUIgchh2sqN240jP4TqivdJRgHVc2cPxnHz6QpEjyZZ4UUVd/2uw1MQzHRbpEaqSlxKK7b98LGcPTYnfJJL5ScXLnup+HpSAosXfLUtAZCpkxp4NTm2eve3K//MHPAjZBMykgxUvlYrgQqyZnQD6vhfzd/cMe8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVl1MOvc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34003f73a05so2429436a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761901931; x=1762506731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQ6kTJFJyOkpv8xppXEKLMnWHFpde+HIcuW+cl9fw00=;
        b=OVl1MOvcWbJ9oS0UtUFDeWeddEuI9htZHLPKuuFGGVWwSbKxikN6oGB8KSSqjFU5yj
         rZMXjckH8YV+X5xnhH3kVPE/3WbY/DKHkWRKZWmbvma9wjB2gT5k8mahs2dTPwdVGuZu
         d722SFCR5mn/h4gwKS6iEw8uUyPad1StzC4JFb1A79koNyoOiiBY/sLkTpVvsPspYVAU
         fUovsFE/wO1dBVXihkkyLD4kykpss+EfFn75bgFFeFr/JCwiHQrrAlMO/dyo66ywG2i6
         rEp7YxOJHR3ZbY4lqhWJWv1BYjGHNI42WDZGXRySHo70GJeIlHQbRl7Ta40qtak3AfoQ
         7azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901931; x=1762506731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ6kTJFJyOkpv8xppXEKLMnWHFpde+HIcuW+cl9fw00=;
        b=k0rZJiwLxnn+y47MtLaDEn8vt4hZ3WcD83deBSgL1FmTG+vlqMWKYH6ykLyQdr8cv5
         NPDBaHau1TtToDEvGfHKKbmy3EZZH1dPU8eeTcHNCyOuigbvZy7B+BdjAcK2qvdSXr2J
         c+tIFqJXD/6KEjQwHXc2237t6ljH0LUTj9cLAzoaBUR0EPBQpeKSdUaxNa9BwGcI4TdH
         nz57fS//b+Iw20k6Fx35PzUmrSjLsbBgtEj99IvQUqvvovDmuDj3Z0s5Y5EmdaMcQhpV
         lPb+YVOmYxS4mW0iN+uRTJHkTDEGLo2vGOi4wovH9XDqdqu1qi2+0elaoSjbavYBK2bi
         Lthw==
X-Forwarded-Encrypted: i=1; AJvYcCUB/wFw+vp1gUD6pSNx5RyC3kGoz6m36Kvgv8XMEBow2fAccsHk+czvoHeIpGorjD0Ruu45FeEoAdcxGWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlxe3rWcfDZC+GMc5vjHo3WH3m4HtgoqpPwIifqLhBDUIgiLJv
	NCwWGKCDdgkQg2/mpogH88a8v+WXoqIDW8xpIV7kNfSTl9LNE2jRlVCH
X-Gm-Gg: ASbGnctWt8oOpJO05P3rGDF3HAJ5TaaEQNgQcHj/LtTdaXtmDuPg/E58YFKEGJ4ig7b
	RwaxpEhBbqBdiRSji02G0GnYPFHBNnk2RYYSZ6VyHzBzHTm8YPkLmbkOuoZ79gHbYi2Bu1ci0LU
	fwSyCdLjuZse9/zCkfzW9PMST6MYkB7n1rIb0o5S70pGRthAX9r06FKGDWZw5J/Ep+kZE+YdjEu
	kkWHUYXN5Q75637jzIkKVo6PCrCaQyF8g8oKBhERP77n/5wBPY6kwS4kergBNGkxKefHpx7PuY4
	EarunKC1m4SFbRCl6mn7o53GTvr7yHYmFS3twJRD1DDgAZvk3GAYfSoRKss0rUprBRaiN0E/eBU
	Azaavg4EzoQ5S4fO34ldNUqVo6Jy3WFT0S938xmI5pbFEBbTqzvQN0zA127eSO9j19dpmbsJ0XI
	A6D2vs4STIsM364gkB35sUTuM=
X-Google-Smtp-Source: AGHT+IEfxuMUGt/pseXdEQtFV0OYLaXuVmiEuh4/+/4/Sjz/Uk2EeZecbENP0XZCjEEtplAZgGB85A==
X-Received: by 2002:a17:90b:3947:b0:340:5c2f:4d42 with SMTP id 98e67ed59e1d1-34080e0a538mr4163865a91.9.1761901930706;
        Fri, 31 Oct 2025 02:12:10 -0700 (PDT)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050ba1472sm5206904a91.17.2025.10.31.02.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:12:10 -0700 (PDT)
Message-ID: <90185600-c08d-4548-8e66-16d3d0de8765@gmail.com>
Date: Fri, 31 Oct 2025 14:42:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: talos-evk: Add support for
 dual-channel LVDS panel
To: Bjorn Andersson <andersson@kernel.org>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028061636.724667-1-tessolveupstream@gmail.com>
 <20251028061636.724667-2-tessolveupstream@gmail.com>
 <fvtwdsthi242vxxlaqsbvqec4xkduch3fcslwqsjzkz4fidewn@mku374rrwlp7>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <fvtwdsthi242vxxlaqsbvqec4xkduch3fcslwqsjzkz4fidewn@mku374rrwlp7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29/10/25 21:18, Bjorn Andersson wrote:
> On Tue, Oct 28, 2025 at 11:46:36AM +0530, Sudarshan Shetty wrote:
>> This patch introduces a new device tree for the QCS615 Talos
> 
> "This patch" doesn't make sense when you look at the git log once the
> patch has been accepted, please avoid it.
> 
> Please read https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> 
> Start your commit message with a "problem description", describe what
> this LVDS talos is, why it should have it's own dts file etc.

Okay, will update in next patch.
> 
>> EVK platform with dual-channel LVDS display support.
>>
>> The new DTS file (`talos-evk-lvds.dts`) is based on the existing
>> `talos-evk.dts` and extends it to enable a dual-channel LVDS display
>> configuration using the TI SN65DSI84 DSI-to-LVDS bridge.
>>
>> where channel-A carries odd pixel and channel-B carries even pixel
>> on the QCS615 talos evk platform.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>  arch/arm64/boot/dts/qcom/talos-evk-lvds.dts | 128 ++++++++++++++++++++
>>  2 files changed, 129 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-lvds.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index d5a3dd98137d..6e7b04e67287 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -307,6 +307,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-mtp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-qrd.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-dsi.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-lvds.dtb
>>  x1e001de-devkit-el2-dtbs	:= x1e001de-devkit.dtb x1-el2.dtbo
>>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e001de-devkit.dtb x1e001de-devkit-el2.dtb
>>  x1e78100-lenovo-thinkpad-t14s-el2-dtbs	:= x1e78100-lenovo-thinkpad-t14s.dtb x1-el2.dtbo
>> diff --git a/arch/arm64/boot/dts/qcom/talos-evk-lvds.dts b/arch/arm64/boot/dts/qcom/talos-evk-lvds.dts
>> new file mode 100644
>> index 000000000000..7ba4ab96ada6
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/talos-evk-lvds.dts
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +/dts-v1/;
>> +#include "talos-evk.dts"
> 
> We don't include .dts files, split the existing one in a dtsi and dts
> file and then include the dtsi here. Or provide provide this as a dtso
> overlay on top of the dts.
> 
> It's not clear to me which is the correct way, because you didn't
> adequately described how the SN65DSI84 enter the picture. Is it always
> there, but not part of the standard dip-switch configuration? Or is this
> some mezzanine?
> 
> Regards,
> Bjorn
> 

Thanks for the feedback.
Currently, the Talos device tree hierarchy is organized as follows:

talos-som.dtsi — defines SoM-specific interfaces
talos-evk.dts — adds carrier board (CB) interfaces such as MicroSD, power
button, and HDMI
talos-evk-lvds.dts — enables the LVDS display (includes SoM + CB +
LVDS + disables HDMI)

The LVDS and HDMI displays share a common DSI output, so only one 
interface can be active at a time. At present, talos-evk-lvds.dts 
includes talos-evk.dts directly so that the base SoM and carrier 
interfaces (e.g., MicroSD, power button) remain available.

However, as you pointed out, including a .dts file directly is not
recommended upstream. To address this, I am considering the following 
restructuring options:

Option 1: Introduce a talos-cb.dtsi

talos-som.dtsi: SoM-specific interfaces
talos-cb.dtsi: common carrier board interfaces (MicroSD, power button, etc.)
talos-evk.dts: includes talos-som.dtsi + talos-cb.dtsi + HDMI
talos-evk-lvds.dts: includes talos-som.dtsi + talos-cb.dtsi + LVDS

This approach avoids including .dts files directly and keeps the carrier
board interfaces centralized and reusable.It also cleanly separates SoM
and CB content and is consistent with how other Qualcomm platforms 
structure their EVK variants.

Option 2: Move CB interfaces to talos-som.dtsi (disabled by default)

Move MicroSD, power button, etc., to talos-som.dtsi with status = "disabled";
Enable these interfaces in each top-level DTS (e.g., talos-evk.dts,
talos-evk-lvds.dts)
While this also avoids .dts inclusion, it may make the SoM DTS 
unnecessarily complex and less reusable, as those CB-specific 
peripherals don’t belong to the SoM hardware.

Let me know your prepared approach here.
>> +
>> +/ {
>> +
>> +	backlight: backlight {
>> +		compatible = "gpio-backlight";
>> +		gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>;
>> +		default-on;
>> +	};
>> +
>> +	lcd0_pwm_en {
>> +		compatible = "pwm-gpio";
>> +		gpios = <&tlmm 59 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-0 = <&lcd0_bklt_pwm>;
>> +		pinctrl-names = "default";
>> +		#pwm-cells = <3>;
>> +	};
>> +
>> +	panel-lvds {
>> +		compatible = "auo,g133han01";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			/* LVDS A (Odd pixels) */
>> +			port@0 {
>> +				reg = <0>;
>> +				dual-lvds-odd-pixels;
>> +
>> +				lvds_panel_out_a: endpoint {
>> +					remote-endpoint = <&sn65dsi84_out_a>;
>> +				};
>> +			};
>> +
>> +			/* LVDS B (Even pixels) */
>> +			port@1 {
>> +				reg = <1>;
>> +				dual-lvds-even-pixels;
>> +
>> +				lvds_panel_out_b: endpoint {
>> +					remote-endpoint = <&sn65dsi84_out_b>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&adv7535 {
>> +	status = "disabled";
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency = <400000>;
>> +
>> +	status = "okay";
>> +
>> +	sn65dsi84: sn65dsi84@2c {
>> +		compatible = "ti,sn65dsi84";
>> +		reg = <0x2c>;
>> +		enable-gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
>> +		ti,dsi-lanes = <4>;
>> +		ti,lvds-format = "jeida-24";
>> +		ti,lvds-bpp = <24>;
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +
>> +				sn65dsi84_in: endpoint {
>> +					data-lanes = <0 1 2 3>;
>> +					remote-endpoint = <&mdss_dsi0_out>;
>> +				};
>> +			};
>> +
>> +			port@2 {
>> +				reg = <2>;
>> +
>> +				sn65dsi84_out_a: endpoint {
>> +					data-lanes = <0 1 2 3>;
>> +					remote-endpoint = <&lvds_panel_out_a>;
>> +				};
>> +			};
>> +
>> +			port@3 {
>> +				reg = <3>;
>> +
>> +				sn65dsi84_out_b: endpoint {
>> +					data-lanes = <0 1 2 3>;
>> +					remote-endpoint = <&lvds_panel_out_b>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&mdss_dsi0 {
>> +	vdda-supply = <&vreg_l11a>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dsi0_out {
>> +	remote-endpoint = <&sn65dsi84_in>;
>> +	data-lanes = <0 1 2 3>;
>> +};
>> +
>> +&tlmm {
>> +	lcd0_bklt_en: lcd0-bklt-en-state {
>> +		pins = "gpio115";
>> +		function = "gpio";
>> +		bias-disable;
>> +	};
>> +
>> +	lcd0_bklt_pwm: lcd0-bklt-pwm-state {
>> +		pins = "gpio59";
>> +		function = "gpio";
>> +		bias-disable;
>> +	};
>> +};
>> -- 
>> 2.34.1
>>


