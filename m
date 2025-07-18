Return-Path: <linux-kernel+bounces-736899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44CB0A4E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E604E115D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB782DC32B;
	Fri, 18 Jul 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jV95u3dN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A6218EA8;
	Fri, 18 Jul 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844413; cv=none; b=eZ0hhYG3JPBb9HJVA9qaZVCaghzj0Kh8SqYLLcZ/P+Z3VugepWmNn1RLGjhiomIpyTRO98S7uPsRo48uZPjG7pHdnud4XyDyAHbEkLnY8OG3XHR+NPrpCUELlTEksrEyd+zNW49HUvRP22djh+JKq8y8n4THI7s7FEqETOlvNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844413; c=relaxed/simple;
	bh=k5Lvd6QsK9i9CQiyoBh4UKXppPI6pOqni0PK6x7BnYY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLd6gx8ZHJDyzIFQYr5+1VI7IA13sCF6pUFeBncwTnHXDDfS5zmLG1g1yWv0KRYwrGDjmiDWKz/jYA3ji42vLE4dfV9hYbmb4fnxXYt9Da9GPflmBDQ5GOGQBeduchUI4oV8eyLveYl5yB2CxHwY0hAJCUMz0Hg+Xg4JiZb7BhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jV95u3dN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:Cc;
	bh=y0H/c0Ji+eywIdBM4fr0ycDaR0fc5KCfJryYKKmDwVo=; b=jV95u3dNl3PKnP2QHxBGu6zErr
	F5zuKxGoYXPPBziJNCgTpDTuDRy4JPZJa7RlMlHUhun2mDiLUQ5lRL7qJpdU1t5Bhq5+TM4ruDmbb
	8HcjiRJV28yrttM7Uqa92pfdISc9V0YKhz0NIH/kIAWU6C5d4vTMERBxhnFbaUW6OWHP/dIs1+jEO
	A503BzZbmVDdY0TKgUIjaGncscelcuUIK7Yi6sCTM7SEkISqpdDbGB+vFOJujwqBdOnWKzYv6Dxcq
	9jpBdcITtwpxuXdKkkeCk79VBa1NvNtH8Q8ZyDSRXK9L55YFMtysDEcnqVKKOLcdwkuWu8yAb4s/L
	qGjVZrLQ==;
Received: from cst-prg-35-241.cust.vodafone.cz ([46.135.35.241] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ucktu-00045r-BP; Fri, 18 Jul 2025 15:13:22 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 soc@lists.linux.dev, Erik Beck <xunil@tahomasoft.com>
Subject:
 Re: [PATCH 1/1] arm: dts: rockchip: Add initial support for LinkStar
 H68K-1432v1 Board with RK3568 SoC
Date: Fri, 18 Jul 2025 15:13:21 +0200
Message-ID: <10784977.EvYhyI6sBW@phil>
In-Reply-To: <20250718075058.243a5619.xunil@tahomasoft.com>
References: <20250718075058.243a5619.xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Erik,

Am Freitag, 18. Juli 2025, 13:50:58 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Erik Beck:
> Hello,
>=20
> Below please find a patch to three files to provide initial support for
> the LinkStar H68K-1432v1 board with Rockchip rk3568 SOC.=20
>=20
> This has been tested on the hardware and works well in support of
> router features. Namely, it supports:
>=20
> * Two 1 Gbs Ethernet ports
> * Two 2.5 Gbs Ethernet ports
> * Two USB 3.0 Type A sockets
> * One USB 3.0 Type C socket
> * One USB 2.0 Type A socket
> * WiFi
> * LED
> * Debug console
>=20
> I look forward to receiving and responding to questions, comments,
> concerns, and critiques.
>=20
> Thank you for your reviews.
>=20
> Regards,
>=20
> Erik

The above test reads more like a cover-letter instead of a commit
message. Please take look at how other board additions are worded.

> Signed-off-by: Erik Beck <xunil@tahomasoft.com>
> Tested-by: Erik Beck <xunil@tahomasoft.com>
>=20
>  .../devicetree/bindings/arm/rockchip.yaml          |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  .../dts/rockchip/rk3568-linkstar-h68k-1432v1.dts   | 777

please split this into two commits, one adding the yaml binding and
one adding the board devicetree.

Also please check scripts/get_maintainer.pl to see who to Cc explicitly
(like the devicetree maintainers)


>  +++++++++++++++++++++ 3 files changed, 783 insertions(+)
>=20
>=20
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> b/Documentation/devicetree/bindings/arm/rockchip.yaml index
> 28db6bd6aa5b..e48b168cfffe 100644 ---

please try to use "git send-email" to send patches, because it looks
like your mail program mangled the patch by adding line breaks
(more of them below). So the patch most likely won't apply.


> diff --git
> a/arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dts
> b/arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dts new file
> mode 100644 index 000000000000..f8f80c7616cd --- /dev/null +++
> b/arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dts @@ -0,0
> +1,777 @@ +// SPDX-License-Identifier: (GPL-2.0+ OR MIT) +// Copyright
> (c) 2022 AmadeusGhost <amadeus@jmu.edu.cn> +//
> +// Copyright (c) 2025 TahomaSoft xunil@tahomasoft.com
> +//
> +// Support for Seeed LinkStar H68K-1432v1
> +// Also likely supports LinkStar H68K-1432v2
> +// NB: Hinlink H68K is same or very similar under different trade name

please use preferred comment style - see other kernel devicetrees.

> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3568.dtsi"
> +
> +
> +/ {
> +        model =3D "Seeed LinkStar H68K-1432V1 (RK3568) DDR4 Board";
> +        compatible =3D "seeed,rk3568-linkstar-h68k-1432v1",
> "rockchip,rk3568"; +
> +        aliases {
> +                ethernet0 =3D &gmac0;
> +                ethernet1 =3D &gmac1;
> +
> +                /* fixed eMMC */
> +                mmc0 =3D &sdhci;  /* sdhci:=3D @fe310000 */ /* mmcblk0...
> */

no need for the comments before and after the alias, same below

> +
> +                /* removable uSD/TF Card */
> +                mmc1 =3D &sdmmc0; /* sdmmc0:=3D @fe2b0000 */ /* mmcblk1.=
=2E.
> */ +
> +                rtc0 =3D &rk809;
> +
> +               led-boot =3D &led_one; /* status LED, green */
> +               led-failsafe =3D &led_three; /* heartbeat LED */
> +               led-running =3D &led_one; /* status LED, green */
> +               led-upgrade =3D &led_two; /* function LED, amber */

I don't think those are specified? What is supposed to use those?

> +

unneeded empty line

> +        };
> +

[...]

> +        gpio-keys {
> +                compatible =3D "gpio-keys";
> +                pinctrl-0 =3D <&reset_button_pin>;
> +                pinctrl-names =3D "default";
> +
> +        /* Middle inset/recessed button,
> +                  marked by clockwise arrow/circle */
> +
> +                button-reset { /* gpiochip=3D0, line=3D0 */

again unneeded comment ... that content is contained in the gpios
property already

> +                        label =3D "button:system:reset";
> +                        gpios =3D <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
> +                        linux,code =3D <KEY_RESTART>;
> +                        debounce-interval =3D <50>;
> +                };
> +
> +        };
> +
> + /* gpio chip 0, line 24 responds to console key press */
> +
> +        gpio-leds {
> +                compatible =3D "gpio-leds";
> +                pinctrl-names =3D "default";
> +                pinctrl-0 =3D <&led_white_pin>, <&led_green_pin>,
> +                         <&led_amber_pin>, <&led_blue_pin>;
> +
> +                /* White LED inset in power button */

that commment is helpful, so could stay

> +
> +                led_zero: led_white   { /* gpiochip=3D0, line=3D14 */

preferred naming would probably be
  led_white: led-0 {}

similar for the other ones

> +                        color =3D <LED_COLOR_ID_WHITE>;
> +                        default-state =3D "on";
> +                        function =3D LED_FUNCTION_POWER;
> +                        gpios =3D <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
> +                        label =3D "power_button_led:white_led";
> +                        linux,default-trigger =3D "default-on";
> +
> +                };
> +
> +        vcc12v_dcin: vcc12v-dcin {

vcc12v_dcin: regulator-vcc12v-dcin {}

same for the others

> +                compatible =3D "regulator-fixed";
> +                regulator-always-on;
> +                regulator-boot-on;
> +                regulator-min-microvolt =3D <12000000>;
> +                regulator-max-microvolt =3D <12000000>;
> +                regulator-name =3D "vcc12v_dcin";
> +        };
> +

> +&gmac0 {
> +        assigned-clocks =3D <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
> +        assigned-clock-parents =3D <&cru SCLK_GMAC0_RGMII_SPEED>;
> +        assigned-clock-rates =3D <0>, <125000000>;
> +        clock_in_out =3D "output";
> +        phy-mode =3D "rgmii-id";
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&gmac0_miim
> +                     &gmac0_tx_bus2
> +                     &gmac0_rx_bus2
> +                     &gmac0_rgmii_clk
> +                     &gmac0_rgmii_bus>;
> +        snps,reset-gpio =3D <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
> +        snps,reset-active-low;
> +        snps,reset-delays-us =3D <0 20000 100000>;
> +        tx_delay =3D <0x3c>;
> +        rx_delay =3D <0x2f>;

please see other recent mails about those
The rgmii-id above should not need those delays?

> +        phy-handle =3D <&rgmii_phy0>;
> +        status =3D "okay";
> +};
> +
> + /* combphy0/multi-phy0 supports one of: usb3.0 otg, sata0 */

drop the comments

> +&combphy0 {
> +        status =3D "okay";
> +
> +};
> +
> + /* combphy1/multi-phy1 supports one of:
> +                         - usb3.0 host
> +                         - sata1
> +                         - qsgmii/sgmii
> + */
> +
> +&combphy1 {
> +        status =3D "okay";
> +};
> +
> + /* combphy2/multi-phy2 supports one of:
> +                         - pcie2.1
> +                         - sata2
> +                         - qsgmii/sgmii
> + */
> +
> +&combphy2 {
> +        status =3D "okay";
> +};
> +

I did stop here for now.

Heiko



