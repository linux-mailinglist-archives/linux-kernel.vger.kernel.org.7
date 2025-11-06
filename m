Return-Path: <linux-kernel+bounces-889467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F069AC3DB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C8C3A6975
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876A30BB88;
	Thu,  6 Nov 2025 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HeLO/m2C"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32C2F6919;
	Thu,  6 Nov 2025 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469696; cv=none; b=mh+ts4hMgDi8SoXmdj4uWkxLV72t5beKGbVelCjwBSK/EP9h5K4JE4gmTIFijHUwqZgOhRPR0j9Q2Xbw723pbwqD6bbN6wWu0zu2Nc53D2C1F+pXKpLYLFBouR0PD0a2jdjQUWDwYP5MIgzYxiUOuZPXT6P6hzvxzxdO8htU0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469696; c=relaxed/simple;
	bh=BrsqOuAdcrcQITO7mEucoO7PQVn5tFuaxhOKLXgrzmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFYVVvQVTlyZuSTOw7Q8Cq9k2+qfdXC3lWzUaAIiioCRHfEh9NzRygfJq/8Vfu6HsruVPlO4FbJI6rnyd5zo4/nP4UgNcqNsJ0cda/Tq2CWqESbK/tYalJHNrF0YQ2gnhAtSLDfHdHlJap5HKlAJVzpteKOUL6Y/d2cpXI0oFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HeLO/m2C; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=1X/CXcnKu0utomIoDVTa8ejjlinauV2USLh4t/RueAg=; b=HeLO/m2CPzKLXigoYGRXggshjT
	mBlEYe3+mSRH4JhbWQahv5wTHPo02zAgAdwp4xkKdrnE8TNMhOMmP2JHeNxLP/IKB3ZfCGNw/1Q7K
	7ZwBNet8eT7aFBxEUukH4xOIUQkjje2WPh8mLsLUNlz8mS/Ms95B2RhyBFzYe1KGZjghcWHirxTNk
	qfpw/pO/dVpLqmnauHd7nV8BEdiLN4lc+dwhAp6E0Fc7l0iTO6PukVqK08aK+hZhPzUdhkNMIT99y
	vc/jRiy4rs04C0TQP1Eifl+bfL7lv+p/YB9E6fsvid2+NaF+yABDumfWDZMGs3SHkNakc9mkKDMOG
	UFr250Gg==;
Received: from i53875bac.versanet.de ([83.135.91.172] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vH8sQ-0001oK-HK; Thu, 06 Nov 2025 23:54:46 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Coia Prant <coiaprant@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coia Prant <coiaprant@gmail.com>
Subject:
 Re: [PATCH v5 3/3] arm64: dts: rockchip: Add devicetree for the 9Tripod X3568
 v4
Date: Thu, 06 Nov 2025 23:54:45 +0100
Message-ID: <3719039.iIbC2pHGDl@phil>
In-Reply-To: <20251103171702.1518730-4-coiaprant@gmail.com>
References:
 <20251103171702.1518730-1-coiaprant@gmail.com>
 <20251103171702.1518730-4-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 3. November 2025, 18:17:02 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Coia Prant:
> The 9Tripod X3568 v4 is an RK3568-based SBC, just like the RK3568-EVB.
> It always uses soldered connections between the X3568CV2/X3568CV3/X3568CV=
4 core board
> and the X3568bv4 I/O board.
>=20
> The differences between the core boards
> - PCB size, layout
> - CPU (RKK3568B2/RK3568J)
> - Memory type (DDR4/LPDDR4/LPDDR4X) and size
> - eMMC size
> - DSI/EDP resistor values
> Although the components vary, they maintain full compatibility.
>=20
> The X3568 board has multiple hardware revisions, and we currently support=
 v4 (I/O board).
>=20
> Specification:
> - SoC: RockChip RK3568 ARM64 (4 cores)
> - eMMC: 16-128 GB
> - RAM: 2-16 GB
> - Power: DC 12V 2A
> - Ethernet: 2x YT8521SC RGMII (10/100/1000 Mbps)
> - Wireless radio: 802.11b/g/n/ac/ax dual-band
> - LED:
>   Power: AlwaysOn
>   User: GPIO
> - Button:
>   VOL+: SARADC/0 <35k =C2=B5V>
>   VOL-: SARADC/0 <450k =C2=B5V>
>   Power/Reset: PMIC RK809
> - CAN
>   CAN/1: 4-pin (PH 2.0)
> - PWM
>   PWM/4: Backlight DSI/0 DSI/1
>   PWM/7: IR Receiver [may not install]
> - UART:
>   UART/2: Debug TTL - 1500000 8N1 (1.25mm)
>   UART/3: TTL (PH 2.0)
>   UART/4: TTL (PH 2.0)
>   UART/8: AP6275S Bluetooth
>   UART/9: TTL (PH 2.0)
> - I2C:
>   I2C/0: PMIC RK809
>   I2C/1: Touchscreen DSI/0 DSI/1
>   I2C/4: Camera
>   I2C/5: RTC@51 PCF8563
> - I2S:
>   I2S/0: miniHDMI Sound
>   I2S/1: RK809 Audio Codec
>   I2S/3: AP6275S Bluetooth Sound
> - SDMMC:
>   SDMMC/0: microSD (TF) slot
>   SDMMC/2: AP6275S SDIO WiFi card
> - Camera: 1x CSI
> - Video: miniHDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
> - Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3.5mm Headphones / A=
P6275S Bluetooth
> - USB:
>   USB 2.0 HOST x2
>   USB 2.0 HOST x3 (4-pin)
>   USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST) [slot may not install]
>   USB 3.0 HOST x1
>   USB 3.0 OTG/HOST x1
> - SATA: 1x SATA 3.0 with Power/4-pin [slot may not install]
> - PCIe: 1x PCIe 3.0 x2 (x4 connecter) [power/clock/slot may not install]
>=20
> Link:
> - https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D=
%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
> - https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flas=
h.html
>=20
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-video-d=
emo.dtso b/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-video-demo.=
dtso
> new file mode 100644
> index 000000000..e7fa1ca48
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-video-demo.dtso
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +
> +// This is a sample reference, due to lack of hardware can not be tested=
, at your own risk

and I've also dropped the 2nd overlay now.
Please only ever submit patches for stuff you have actually tested.

We don't really add stuff with "use at your own risk" caveats ;-)


Heiko



