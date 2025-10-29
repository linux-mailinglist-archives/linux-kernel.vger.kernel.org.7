Return-Path: <linux-kernel+bounces-875118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1186C1841E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F94E4628
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85522ECD28;
	Wed, 29 Oct 2025 04:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4mSweBL"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC885221294
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761713426; cv=none; b=aU2SOcmPTRv11505VCoNRngxmO1z0lHs26X4TZO/jIaFnFRusMmW/i5KXpEU18F1RYUnS1Dx0sRGvVbOg9c/nJ7rAjDIeE6uybUHEJfXOutdgaE4Ee67OrdMV+xAq/B3Xu77/qtnv63guxeW4iRDz08NoBq8Wdyy5JQKKiAhL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761713426; c=relaxed/simple;
	bh=2dLebzq2ZNso7xMLAfzP7gpDwCY8AED7dw+bc6a1V0c=;
	h=Mime-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvoEglBOJCq2dojX4U12sDbL9fgVXJSrR8e/6DvP9gyatX1+gwkoh6TgXQGl8CIM9QuAznW/cZNK1OjfKIRI1ndwtYJACulYFd2+SqGNHJAFYpfMF+PXLodO4erga1HCzAnaOzRdOJJbbC/1jNF3PZdL7nXuI0xny2rOGhZQth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4mSweBL; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b6d5b756284so1454813566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761713421; x=1762318221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNRwQDw9lfAXPDWA5DyNoL+Hqg52/VQciHJmyd0c0xY=;
        b=K4mSweBLfD5FYPzkt/Ghld5mpzjI2DbRW63IG5TLjqBg1M4FbujEStAsXp7DTsHVZ3
         CQ/RmeT8Ek4JERCrEkdyspJ3H2NMyw5xJaaLNqU17yH6Jl9Q0gZIQUNYdMJK4APyc+n7
         8Hi1zK6gQl3MgdBEm0hki2bQ+CoOH49B/T8eMq/o7FRXRpD9M2tPaWt3O+64sUWVzlVr
         IEBQQ7n8CTqd9GoaRUkK7MooOvtN8qvGeZTuy0NlzHizsfhBK0JaNfczHWPH4Q2qikUA
         YEmWKsLrhHl5DjJbpp/Tw4B5ecOgFxFGLkG67YACF15vO4ocaxNIlZ0TM8m4jpELaZmH
         Ed2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761713421; x=1762318221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNRwQDw9lfAXPDWA5DyNoL+Hqg52/VQciHJmyd0c0xY=;
        b=j3z2SkWC0kJFWxAWyA93/s0zKLYPFFMYeQC62SJz+wbwDPIZlF7s4gCGkSUanKs/W1
         tAbNNHoZpL3Vq/ehBNjhbpDY6pTA1KfJOQj0mocKmQ++MtEnCxlm84z7tGOneNk+vGCP
         lTIADhmXzbYnDNVOYlm/d7rE8cTHjdGvrrrSnWNAGwG2XW7FGHWjVY+IXN/RReIvDLVI
         q3PQ34dYjUhc5uY5dFRF6bkc+HZHxuyaoqYMv/1qBdjzWUIBQtkTveUXw99WSEvDVxbb
         8qurGxAKUsZeRjw35ipgwCC4RaKX654Bo1yaP1BPl1Q63BvOlnlFCGj58eBSMjK5f3uP
         Erow==
X-Forwarded-Encrypted: i=1; AJvYcCXOozmTI+Chm8GEqY8rlO5BG1jodz4axw49oIhoMRcZELCtG6rxre1f95myCaiNvmC0ZaMvT68k2p3x50g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1HuTykBSWHV1kh+BOqpzxOh2GMB975qnCoXERvynTKX6iiba
	YiMbAP+cXxmIT+Qug+yPLavpCmgS3wh8Hu41xKXqs5pgniYq0SpBYh8tJ6LpmVmVQJt2tH17nZt
	d0o8LnD8Jk8hcUxsrGRYAeDmDWLJCpvs=
X-Gm-Gg: ASbGnctb1KHFWk/sPQnYtvK05l4JaPBG2ZXnT6j8IHCu1ZwuBMQzLp91ASM7VOu3Q4J
	Tc6IZRVFyF2IBUJho/L9CB9WI2QbIXUnmsVM4IGO4B8kkz0nDU84+OddnqRb0RudJfQ6bKuunhS
	aDwamW8vCo3TFdwbhZgb42rqyL0gy93WP0IjI59ktCInr6BzA5ZuiBBgwpJuF2ZHQB7uc0vZKxW
	LvK84wpkoLFnflqnjOcIOz0R+W8Sz3Q0saMliRa7i0d2FveRbx4aJbVROk=
X-Google-Smtp-Source: AGHT+IFuk2FaxCeNWuGZeG1p92/x/zCJWOARInKhQl7iC6jO+0ryT4weOCEM6Dt5SiFg8GXEN3A7n+IAye4+poyG3os=
X-Received: by 2002:a17:907:d8a:b0:b2e:34f1:9dbf with SMTP id
 a640c23a62f3a-b703d29517bmr133818066b.1.1761713420901; Tue, 28 Oct 2025
 21:50:20 -0700 (PDT)
Received: from 724652696919 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 21:50:20 -0700
Received: from 724652696919 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 21:50:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <cfb5dc7f-c7f9-459f-9565-bbacabb86cb3@rock-chips.com>
References: <cfb5dc7f-c7f9-459f-9565-bbacabb86cb3@rock-chips.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 28 Oct 2025 21:50:20 -0700
X-Gm-Features: AWmQ_bmMbyHtNwFdF1tGvtmmTAk36sD-gNvYMEzUeQmLRokBaNleruHcFifWUac
Message-ID: <CALj3r0gbr2=mExgMCCnrmKJW-ueuLcX=ifkOrDx4efxMcw4=aA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the X3568 v4
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My DIY friend found that two LDO regulators are still missing on the
current board revision.

One LDO supplies VDDX and VDDA for the clock (clk).

The other is a LDO providing 3.3V / 3A for the PCIe power rail.

Although these LDOs are still missing, the system can boot normally in
the current configuration. Their absence does not affect the basic
bring-up process.

I will ask my friend install these missing items and test them.
Then I will send PATCH v5.

Thanks.

2025-10-29 08:20 (GMT+08:00), Shawn Lin <shawn.lin@rock-chips.com> said:
> =E5=9C=A8 2025/10/28 =E6=98=9F=E6=9C=9F=E4=BA=8C 12:03, Coia Prant =E5=86=
=99=E9=81=93:
> hmmmm
> I think my board doesn't have PCIe clk.
> It works fine.
>
> The OEM documentation does say that, and they provide nopcie and pcie ima=
ges
>
> This is my dmesg for your reference
>
> [    0.336879] phy phy-fe8c0000.phy.7: rockchip_p3phy_rk3568_init:
> lock failed 0x6890000, check input refclk and power supply
> [    0.338587] rockchip-dw-pcie: probe of 3c0800000.pcie failed with erro=
r -110
>
> It should work if only clk is missing.
> My preset scenario is that you mentioned it doesn't have a slot
> installed, the missing part includes PHY power supply, which should
> block the boot if enabling.
> 2025-10-28 11:36 (GMT+08:00), Shawn Lin  said:
> =E5=9C=A8 2025/10/26 =E6=98=9F=E6=9C=9F=E6=97=A5 4:37, Coia Prant =E5=86=
=99=E9=81=93:
> Specification:
> - SoC: RockChip RK3568 ARM64 (4 cores)
> - eMMC: 16-128 GB
> - RAM: 2-8 GB
> - Power: DC 12V 2A
> - Ethernet: 2x YT8521SC RGMII (10/100/1000 Mbps)
> - Wireless radio: 802.11b/g/n/ac/ax dual-band
> - LED:
> Power: AlwaysOn
> User: GPIO
> - Button:
> VOL+: SARADC/0
> VOL-: SARADC/0
> Power/Reset: PMIC RK809
> - CAN
> CAN/1: 4-pin (PH 2.0)
> - PWM
> PWM/4: Backlight DSI/0 DSI/1
> PWM/7: IR Receiver [may not install]
> - UART:
> UART/2: Debug TTL - 1500000 8N1 (1.25mm)
> UART/3: TTL (PH 2.0)
> UART/4: TTL (PH 2.0)
> UART/8: AP6275S Bluetooth
> UART/9: TTL (PH 2.0)
> - I2C:
> I2C/0: PMIC RK809
> I2C/1: Touchscreen DSI/0 DSI/1
> I2C/4: Camera
> I2C/5: RTC@51 PCF8563
> - I2S:
> I2S/0: miniHDMI Sound
> I2S/1: RK809 Audio Codec
> I2S/3: AP6275S Bluetooth Sound
> - SDMMC:
> SDMMC/0: microSD (TF) slot
> SDMMC/2: AP6275S SDIO WiFi card
> - Camera: 1x CSI
> - Video: miniHDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
> - Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3.5mm Headphones / A=
P6275S
> Bluetooth
> - USB:
> USB 2.0 HOST x2
> USB 2.0 HOST x3 (4-pin)
> USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST) [slot may not install]
> USB 3.0 HOST x1
> USB 3.0 OTG/HOST x1
> - SATA: 1x SATA 3.0 with Power/4-pin [slot may not install]
> - PCIe: 1x PCIe 3.0 x2 (x4 connecter) [clock/slot may not install]
> A side note: AFAICT, if clock may not be installed, you shouldn't
> enable pcie3x2 or pcie3x4.. Otherwise it can't boot at all..
> Link:
> -
> https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%B=
F%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
> - https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flas=
h.html
> Signed-off-by: Coia Prant
> Tested-by: Coia Prant
> ---
> arch/arm64/boot/dts/rockchip/Makefile         |  11 +
> .../rockchip/rk3568-x3568-camera-demo.dtso    |  82 ++
> .../boot/dts/rockchip/rk3568-x3568-v4.dts     | 884 ++++++++++++++++++
> .../dts/rockchip/rk3568-x3568-video-demo.dtso | 141 +++
> 4 files changed, 1118 insertions(+)
> create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.=
dtso
> create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
> create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.d=
tso
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> b/arch/arm64/boot/dts/rockchip/Makefile
> index ad684e383..ea36334bb 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -150,6 +150,9 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-rock-3b.dtb
> dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5.dtb
> dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5-display-vz.dtbo
> dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-wolfvision-pf5-io-expander.dtbo
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-x3568-v4.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-x3568-camera-demo.dtso
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-x3568-video-demo.dtso
> dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-armsom-sige5.dtb
> dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-armsom-sige5-v1.2-wifibt.dtbo
> dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3576-evb1-v10.dtb
> @@ -252,6 +255,14 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D
> rk3576-armsom-sige5-v1.2-wifibt.dtb
> rk3576-armsom-sige5-v1.2-wifibt-dtbs :=3D rk3576-armsom-sige5.dtb \
> rk3576-armsom-sige5-v1.2-wifibt.dtbo
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-x3568-v4-camera-demo.dtb
> +rk3568-x3568-v4-camera-demo-dtbs :=3D rk3568-x3568-v4.dtb \
> +	rk3568-x3568-camera-demo.dtso
> +
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3568-x3568-v4-video-demo.dtb
> +rk3568-x3568-v4-video-demo-dtbs :=3D rk3568-x3568-v4.dtb \
> +	rk3568-x3568-video-demo.dtso
> +
> dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-edgeble-neu6a-wifi.dtb
> rk3588-edgeble-neu6a-wifi-dtbs :=3D rk3588-edgeble-neu6a-io.dtb \
> rk3588-edgeble-neu6a-wifi.dtbo
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
> b/arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
> new file mode 100644
> index 000000000..b144d0010
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-x3568-camera-demo.dtso
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +
> +// This is a sample reference, due to lack of hardware can not be tested=
, at
> your own risk
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include
> +#include
> +#include
> +
> +&amp;{/} {
> +	vcc_cam: regulator-vcc-cam {
> +		compatible =3D "regulator-fixed";
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		enable-active-high;
> +		gpio =3D ;
> +		regulator-name =3D "vcc_cam";
> +		vin-supply =3D ;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D ;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&amp;pinctrl {
> +	cam {
> +		vcc_cam_en: vcc_cam_en {
> +			rockchip,pins =3D	;
> +		};
> +	};
> +};
> +
> +&amp;csi_dphy {
> +	status =3D "okay";
> +
> +	ports {
> +		#address-cells =3D ;
> +		#size-cells =3D ;
> +
> +		port@0 {
> +			reg =3D ;
> +			#address-cells =3D ;
> +			#size-cells =3D ;
> +
> +			mipi_in_ucam: endpoint@2 {
> +				reg =3D ;
> +				remote-endpoint =3D ;
> +				data-lanes =3D ;
> +			};
> +		};
> +	};
> +};
> +
> +&amp;i2c4 {
> +	status =3D "okay";
> +
> +	camera@37 {
> +		compatible =3D "ovti,ov5695";
> +		reg =3D ;
> +		clocks =3D ;
> +		clock-names =3D "xvclk";
> +		avdd-supply =3D ;
> +		dvdd-supply =3D ;
> +		dovdd-supply =3D ;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D ;
> +		reset-gpios =3D ;
> +		pwdn-gpios =3D ;
> +
> +		port {
> +			ucam_out: endpoint {
> +				remote-endpoint =3D ;
> +				data-lanes =3D ;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
> b/arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
> new file mode 100644
> index 000000000..901735c6f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-x3568-v4.dts
> @@ -0,0 +1,884 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +#include
> +#include
> +#include
> +#include
> +#include
> +#include "rk3568.dtsi"
> +
> +/ {
> +	model =3D "NineTripod X3568 v4";
> +	compatible =3D "ninetripod,x3568-v4", "rockchip,rk3568";
> +
> +	aliases {
> +		ethernet0 =3D &amp;gmac0;
> +		ethernet1 =3D &amp;gmac1;
> +		mmc0 =3D &amp;sdhci;
> +		mmc1 =3D &amp;sdmmc0;
> +		mmc2 =3D &amp;sdmmc2;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial2:1500000n8";
> +	};
> +
> +	adc-keys {
> +		compatible =3D "adc-keys";
> +		io-channels =3D ;
> +		io-channel-names =3D "buttons";
> +		keyup-threshold-microvolt =3D ;
> +		poll-interval =3D ;
> +
> +		button-vol-up {
> +			label =3D "volume up";
> +			linux,code =3D ;
> +			press-threshold-microvolt =3D ;
> +		};
> +
> +		button-vol-down {
> +			label =3D "volume down";
> +			linux,code =3D ;
> +			press-threshold-microvolt =3D ;
> +		};
> +	};
> +
> +	hdmi-con {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint =3D ;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led_work: led-0 {
> +			gpios =3D ;
> +			function =3D LED_FUNCTION_HEARTBEAT;
> +			color =3D ;
> +			linux,default-trigger =3D "heartbeat";
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D ;
> +		};
> +	};
> +
> +	rk809-sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,name =3D "Analog RK809";
> +		simple-audio-card,mclk-fs =3D ;
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D ;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai =3D ;
> +		};
> +	};
> +
> +	pdm_codec: pdm-codec {
> +		compatible =3D "dmic-codec";
> +		num-channels =3D ;
> +		#sound-dai-cells =3D ;
> +	};
> +
> +	pdm_sound: pdm-sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "microphone";
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D ;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai =3D ;
> +		};
> +	};
> +
> +	spdif_dit: spdif-dit {
> +		compatible =3D "linux,spdif-dit";
> +		#sound-dai-cells =3D ;
> +	};
> +
> +	spdif_sound: spdif-sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "SPDIF";
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D ;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai =3D ;
> +		};
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		clocks =3D ;
> +		clock-names =3D "ext_clock";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D ;
> +		post-power-on-delay-ms =3D ;
> +		power-off-delay-us =3D ;
> +		reset-gpios =3D ;
> +	};
> +
> +	dc_12v: regulator-dc-12v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "dc_12v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +	};
> +
> +	pcie30_avdd0v9: regulator-pcie30-avdd0v9 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pcie30_avdd0v9";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		vin-supply =3D ;
> +	};
> +
> +	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pcie30_avdd1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		vin-supply =3D ;
> +	};
> +
> +	vcc3v3_sys: regulator-vcc3v3-sys {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		vin-supply =3D ;
> +	};
> +
> +	vcc3v3_pcie: regulator-vcc3v3-pcie {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc3v3_pcie";
> +		enable-active-high;
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D ;
> +		gpio =3D ;
> +		startup-delay-us =3D ;
> +		vin-supply =3D ;
> +	};
> +
> +	vcc5v0_sys: regulator-vcc5v0-sys {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		vin-supply =3D ;
> +	};
> +
> +	vcc5v0_usb: regulator-vcc5v0-usb {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc5v0_usb";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		vin-supply =3D ;
> +	};
> +
> +	vcc5v0_usb_host: regulator-vcc5v0-usb-host {
> +		compatible =3D "regulator-fixed";
> +		enable-active-high;
> +		gpio =3D ;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D ;
> +		regulator-name =3D "vcc5v0_usb_host";
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		vin-supply =3D ;
> +	};
> +
> +	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
> +		compatible =3D "regulator-fixed";
> +		enable-active-high;
> +		gpio =3D ;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D ;
> +		regulator-name =3D "vcc5v0_usb_otg";
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		vin-supply =3D ;
> +	};
> +};
> +
> +&amp;can1 {
> +	assigned-clocks =3D ;
> +	assigned-clock-rates =3D ;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D ;
> +	status =3D "okay";
> +};
> +
> +/* used for usb_host0_xhci */
> +&amp;combphy0 {
> +	status =3D "okay";
> +};
> +
> +/* used for usb_host1_xhci */
> +&amp;combphy1 {
> +	status =3D "okay";
> +};
> +
> +/* connected to sata2 */
> +&amp;combphy2 {
> +	status =3D "okay";
> +};
> +
> +&amp;cpu0 {
> +	cpu-supply =3D ;
> +};
> +
> +&amp;cpu1 {
> +	cpu-supply =3D ;
> +};
> +
> +&amp;cpu2 {
> +	cpu-supply =3D ;
> +};
> +
> +&amp;cpu3 {
> +	cpu-supply =3D ;
> +};
> +
> +&amp;gmac0 {
> +	assigned-clocks =3D , ;
> +	assigned-clock-parents =3D ;
> +	assigned-clock-rates =3D , ;
> +	clock_in_out =3D "output";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D  +			&amp;gmac0_tx_bus2
> +			&amp;gmac0_rx_bus2
> +			&amp;gmac0_rgmii_clk
> +			&amp;gmac0_rgmii_bus
> +			&amp;gmac0_clkinout;
> +	phy-handle =3D ;
> +	phy-mode =3D "rgmii-id";
> +	status =3D "okay";
> +};
> +
> +&amp;gmac1 {
> +	assigned-clocks =3D , ;
> +	assigned-clock-parents =3D ;
> +	assigned-clock-rates =3D , ;
> +	clock_in_out =3D "output";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D  +			&amp;gmac1m1_tx_bus2
> +			&amp;gmac1m1_rx_bus2
> +			&amp;gmac1m1_rgmii_clk
> +			&amp;gmac1m1_rgmii_bus
> +			&amp;gmac1m1_clkinout;
> +	phy-handle =3D ;
> +	phy-mode =3D "rgmii-id";
> +	status =3D "okay";
> +};
> +
> +&amp;gpu {
> +	mali-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;hdmi {
> +	avdd-0v9-supply =3D ;
> +	avdd-1v8-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint =3D ;
> +	};
> +};
> +
> +&amp;hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint =3D ;
> +	};
> +};
> +
> +&amp;hdmi_sound {
> +	status =3D "okay";
> +};
> +
> +&amp;i2c0 {
> +	status =3D "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible =3D "tcs,tcs4525";
> +		reg =3D ;
> +		fcs,suspend-voltage-selector =3D ;
> +		regulator-name =3D "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		regulator-ramp-delay =3D ;
> +		vin-supply =3D ;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk809: pmic@20 {
> +		compatible =3D "rockchip,rk809";
> +		reg =3D ;
> +		interrupt-parent =3D ;
> +		interrupts =3D ;
> +		assigned-clocks =3D ;
> +		assigned-clock-parents =3D ;
> +		#clock-cells =3D ;
> +		clock-names =3D "mclk";
> +		clocks =3D ;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D , ;
> +		system-power-controller;
> +		#sound-dai-cells =3D ;
> +		vcc1-supply =3D ;
> +		vcc2-supply =3D ;
> +		vcc3-supply =3D ;
> +		vcc4-supply =3D ;
> +		vcc5-supply =3D ;
> +		vcc6-supply =3D ;
> +		vcc7-supply =3D ;
> +		vcc8-supply =3D ;
> +		vcc9-supply =3D ;
> +		wakeup-source;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-name =3D "vdd_logic";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode =3D ;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +				regulator-ramp-delay =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_gpu: DCDC_REG2 {
> +				regulator-name =3D "vdd_gpu";
> +				regulator-always-on;
> +				regulator-initial-mode =3D ;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +				regulator-ramp-delay =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name =3D "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode =3D ;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu: DCDC_REG4 {
> +				regulator-name =3D "vdd_npu";
> +				regulator-initial-mode =3D ;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +				regulator-ramp-delay =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: DCDC_REG5 {
> +				regulator-name =3D "vcc_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_image: LDO_REG1 {
> +				regulator-name =3D "vdda0v9_image";
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9: LDO_REG2 {
> +				regulator-name =3D "vdda_0v9";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_pmu: LDO_REG3 {
> +				regulator-name =3D "vdda0v9_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D ;
> +				};
> +			};
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-name =3D "vccio_acodec";
> +				regulator-always-on;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-name =3D "vccio_sd";
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG6 {
> +				regulator-name =3D "vcc3v3_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D ;
> +				};
> +			};
> +
> +			vcca_1v8: LDO_REG7 {
> +				regulator-name =3D "vcca_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pmu: LDO_REG8 {
> +				regulator-name =3D "vcca1v8_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt =3D ;
> +				};
> +			};
> +
> +			vcca1v8_image: LDO_REG9 {
> +				regulator-name =3D "vcca1v8_image";
> +				regulator-min-microvolt =3D ;
> +				regulator-max-microvolt =3D ;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: SWITCH_REG1 {
> +				regulator-name =3D "vcc_3v3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_sd: SWITCH_REG2 {
> +				regulator-name =3D "vcc3v3_sd";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +
> +		codec {
> +			rockchip,mic-in-differential;
> +		};
> +	};
> +};
> +
> +&amp;i2c5 {
> +	status =3D "okay";
> +
> +	rtc@51 {
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D ;
> +		#clock-cells =3D ;
> +	};
> +};
> +
> +&amp;i2s0_8ch {
> +	status =3D "okay";
> +};
> +
> +&amp;i2s1_8ch {
> +	pinctrl-0 =3D ;
> +	rockchip,trcm-sync-tx-only;
> +	status =3D "okay";
> +};
> +
> +/* used for AP6275S Bluetooth Sound */
> +&amp;i2s3_2ch {
> +	status =3D "okay";
> +};
> +
> +&amp;mdio0 {
> +	rgmii_phy0: ethernet-phy@0 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D ;
> +		reset-assert-us =3D ;
> +		reset-deassert-us =3D ;
> +		reset-gpios =3D ;
> +
> +		leds {
> +			#address-cells =3D ;
> +			#size-cells =3D ;
> +
> +			led@1 {
> +				reg =3D ;
> +				color =3D ;
> +				function =3D LED_FUNCTION_LAN;
> +				default-state =3D "keep";
> +			};
> +
> +			led@2 {
> +				reg =3D ;
> +				color =3D ;
> +				function =3D LED_FUNCTION_LAN;
> +				default-state =3D "keep";
> +			};
> +		};
> +	};
> +};
> +
> +&amp;mdio1 {
> +	rgmii_phy1: ethernet-phy@0 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D ;
> +		reset-assert-us =3D ;
> +		reset-deassert-us =3D ;
> +		reset-gpios =3D ;
> +
> +		leds {
> +			#address-cells =3D ;
> +			#size-cells =3D ;
> +
> +			led@1 {
> +				reg =3D ;
> +				color =3D ;
> +				function =3D LED_FUNCTION_LAN;
> +				default-state =3D "keep";
> +			};
> +
> +			led@2 {
> +				reg =3D ;
> +				color =3D ;
> +				function =3D LED_FUNCTION_LAN;
> +				default-state =3D "keep";
> +			};
> +		};
> +	};
> +};
> +
> +&amp;pcie30phy {
> +	status =3D "okay";
> +};
> +
> +&amp;pcie3x2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D ;
> +	reset-gpios =3D ;
> +	vpcie3v3-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;pdm {
> +	status =3D "okay";
> +};
> +
> +&amp;pinctrl {
> +	leds {
> +		led_work_en: led_work_en {
> +			rockchip,pins =3D ;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int: pmic_int {
> +			rockchip,pins =3D
> +				;
> +		};
> +	};
> +
> +	sdio-pwrseq {
> +		wifi_enable: wifi-enable {
> +			rockchip,pins =3D ;
> +		};
> +	};
> +
> +	usb {
> +		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
> +			rockchip,pins =3D ;
> +		};
> +		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
> +			rockchip,pins =3D ;
> +		};
> +	};
> +
> +	pcie {
> +		pcie_reset_pin: pcie-reset-pin {
> +			rockchip,pins =3D ;
> +		};
> +		vcc3v3_pcie_en_pin: vcc3v3-pcie-en-pin {
> +			rockchip,pins =3D ;
> +		};
> +	};
> +};
> +
> +&amp;pmu_io_domains {
> +	pmuio1-supply =3D ;
> +	pmuio2-supply =3D ;
> +	vccio1-supply =3D ;
> +	vccio2-supply =3D ;
> +	vccio3-supply =3D ;
> +	vccio4-supply =3D ;
> +	vccio5-supply =3D ;
> +	vccio6-supply =3D ;
> +	vccio7-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;pwm4 {
> +	status =3D "okay";
> +};
> +
> +/* Required remotectl for IR receiver */
> +&amp;pwm7 {
> +	status =3D "disabled";
> +};
> +
> +&amp;saradc {
> +	vref-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;sata2 {
> +	status =3D "okay";
> +};
> +
> +/* used for eMMC */
> +&amp;sdhci {
> +	bus-width =3D ;
> +	max-frequency =3D ;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D ;
> +	status =3D "okay";
> +};
> +
> +/* used for microSD (TF) Slot */
> +&amp;sdmmc0 {
> +	bus-width =3D ;
> +	cap-sd-highspeed;
> +	cd-gpios =3D ;
> +	disable-wp;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D ;
> +	sd-uhs-sdr104;
> +	vmmc-supply =3D ;
> +	vqmmc-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +/* used for AP6275S WiFi */
> +&amp;sdmmc2 {
> +	bus-width =3D ;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	mmc-pwrseq =3D ;
> +	non-removable;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D ;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply =3D ;
> +	vqmmc-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;spdif {
> +	status =3D "okay";
> +};
> +
> +&amp;tsadc {
> +	rockchip,hw-tshut-mode =3D ;
> +	rockchip,hw-tshut-polarity =3D ;
> +	status =3D "okay";
> +};
> +
> +/* used for Debug */
> +&amp;uart2 {
> +	status =3D "okay";
> +};
> +
> +&amp;uart3 {
> +	pinctrl-0 =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;uart4 {
> +	pinctrl-0 =3D ;
> +	status =3D "okay";
> +};
> +
> +/* used for WiFi/BT AP6275S */
> +&amp;uart8 {
> +	pinctrl-0 =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;uart9 {
> +	pinctrl-0 =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;usb_host0_ehci {
> +	status =3D "okay";
> +};
> +
> +&amp;usb_host0_ohci {
> +	status =3D "okay";
> +};
> +
> +&amp;usb_host0_xhci {
> +	extcon =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;usb_host1_ehci {
> +	status =3D "okay";
> +};
> +
> +&amp;usb_host1_ohci {
> +	status =3D "okay";
> +};
> +
> +&amp;usb_host1_xhci {
> +	status =3D "okay";
> +};
> +
> +&amp;usb2phy0 {
> +	status =3D "okay";
> +};
> +
> +&amp;usb2phy0_host {
> +	phy-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;usb2phy0_otg {
> +	phy-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;usb2phy1 {
> +	status =3D "okay";
> +};
> +
> +&amp;usb2phy1_host {
> +	phy-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;usb2phy1_otg {
> +	phy-supply =3D ;
> +	status =3D "okay";
> +};
> +
> +&amp;vop {
> +	assigned-clocks =3D , ;
> +	assigned-clock-parents =3D , ;
> +	status =3D "okay";
> +};
> +
> +&amp;vop_mmu {
> +	status =3D "okay";
> +};
> +
> +&amp;vp0 {
> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg =3D ;
> +		remote-endpoint =3D ;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
> b/arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
> new file mode 100644
> index 000000000..f819eff8f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-x3568-video-demo.dtso
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +
> +// This is a sample reference, due to lack of hardware can not be tested=
, at
> your own risk
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include
> +#include
> +#include
> +
> +&amp;{/} {
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		brightness-levels =3D ;
> +		default-brightness-level =3D ;
> +		num-interpolated-steps =3D ;
> +		power-supply =3D ;
> +		pwms =3D ;
> +	};
> +
> +	vcc3v3_lcd0_n: regulator-vcc3v3-lcd0-n {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc3v3_lcd0_n";
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		enable-active-high;
> +		gpio =3D ;
> +		vin-supply =3D ;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D ;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vcc3v3_lcd1_n: regulator-vcc3v3-lcd1-n {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc3v3_lcd1_n";
> +		regulator-min-microvolt =3D ;
> +		regulator-max-microvolt =3D ;
> +		enable-active-high;
> +		gpio =3D ;
> +		vin-supply =3D ;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D ;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&amp;pinctrl {
> +	display {
> +		vcc3v3_lcd0_n_en: vcc3v3_lcd0_n_en {
> +			rockchip,pins =3D ;
> +		};
> +		vcc3v3_lcd1_n_en: vcc3v3_lcd1_n_en {
> +			rockchip,pins =3D ;
> +		};
> +	};
> +
> +	touchscreen {
> +		touch_int: touch_int {
> +			rockchip,pins =3D ;
> +		};
> +		touch_rst: touch_rst {
> +			rockchip,pins =3D ;
> +		};
> +	};
> +};
> +
> +&amp;dsi0 {
> +	clock-master;
> +	#address-cells =3D ;
> +	#size-cells =3D ;
> +	status =3D "okay";
> +
> +	panel@0 {
> +		compatible =3D "wanchanglong,w552793baa", "raydium,rm67200";
> +		reg =3D ;
> +		backlight =3D ;
> +		iovcc-supply =3D ;
> +		reset-gpios =3D ;
> +		vdd-supply =3D ;
> +		vsn-supply =3D ;
> +		vsp-supply =3D ;
> +
> +		port {
> +			panel_in_dsi: endpoint {
> +				remote-endpoint =3D ;
> +			};
> +		};
> +	};
> +};
> +
> +&amp;dsi0_in {
> +	dsi0_in_vp1: endpoint {
> +		remote-endpoint =3D ;
> +	};
> +};
> +
> +&amp;dsi0_out {
> +	dsi0_out_panel: endpoint {
> +		remote-endpoint =3D ;
> +	};
> +};
> +
> +&amp;dsi_dphy0 {
> +	status =3D "okay";
> +};
> +
> +&amp;pwm4 {
> +	status =3D "okay";
> +};
> +
> +&amp;i2c1 {
> +	status =3D "okay";
> +
> +	touchscreen0: goodix@14 {
> +		compatible =3D "goodix,gt1151";
> +		reg =3D ;
> +		interrupt-parent =3D ;
> +		interrupts =3D ;
> +		AVDD28-supply =3D ;
> +		irq-gpios =3D ;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D ;
> +		reset-gpios =3D ;
> +		VDDIO-supply =3D ;
> +	};
> +};
> +
> +&amp;vp1 {
> +	vp1_out_dsi0: endpoint@ROCKCHIP_VOP2_EP_MIPI0 {
> +		reg =3D ;
> +		remote-endpoint =3D ;
> +	};
> +};
>

