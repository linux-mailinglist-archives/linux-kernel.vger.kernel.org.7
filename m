Return-Path: <linux-kernel+bounces-736906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC949B0A4F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF799174C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674261C4609;
	Fri, 18 Jul 2025 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="ZzdIhJCv"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55A2E370B;
	Fri, 18 Jul 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844919; cv=none; b=DCQsvmfIbnx/hRFJtQ4IlR6MeL8aevKuLjTLYt2KDTCRhp56EKK4LyEqCPdbG5Rxv7wtMjUy83eFqa/bF4YcDItjLPLGlJmMu69mlRaDg55CbkdhVh1aGACKP5kvpdpvzMG8Zjp0hbREeIHS1drZaVkJMS52JlpQfiSRmeqaByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844919; c=relaxed/simple;
	bh=gFqa07GuZLWjPhMOTb9JYXP+kYKe334i95u4Rjn0D6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGLa1FjvpoNWb37ltIN/Bw2jCif22794RqPhJOBei9plpuDudvsbRb4S/QLfhV950dgjV33ZWRVmZxFwfX1VE9Y6UYeA5JaPRyXx9xYl22HQwIstcHIOZGr2ln1x0y8S8oqLC0c0uz1WFimhOKHUuAO/GCgcgQuYvGDw2UzuZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=fail (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=ZzdIhJCv reason="key not found in DNS"; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1752844916;
	bh=gFqa07GuZLWjPhMOTb9JYXP+kYKe334i95u4Rjn0D6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZzdIhJCvyl9S+9c/bFW/Tr8/3XrTzcJoJgRPppGcKEOP1+m+RbYDB7ESUW7W3a8PX
	 asJkIC/tuma0UinGh+vO4xR+q/vxfEpotWbrcLtgSmZLpP/4KMHcp1eJ5qTIspZAL3
	 gb5DegAwymQvv5L+tzVTNlxn3+OqDmoHL3Z7adwxuqqIkS2FfH9aR5XtJOvFlG1bKb
	 YdYejz/7f8bOPYfF97fzPmUUow8xJFXqPgafFR9yEaYhSveVTzP9HZqe6xbg9+9Wjk
	 9msjJXcGQ9ueNSqPQ9aA5wyJGTbmrqaKOC0DTvQ43TxtYdsgrVtDmaBOrul2+Uf89p
	 52kW67jG1o0kw==
Received: from WahpenayoPeak.tahoma.link (unknown [IPv6:2600:4040:50b7:b604:3b13:d53e:3e62:ce43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 8A18F27E434;
	Fri, 18 Jul 2025 13:21:56 +0000 (UTC)
Date: Fri, 18 Jul 2025 09:21:55 -0400
From: Erik Beck <xunil@tahomasoft.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH 1/1] arm: dts: rockchip: Add initial support for
 LinkStar H68K-1432v1 Board with RK3568 SoC
Message-ID: <20250718092155.5c756e3f.xunil@tahomasoft.com>
In-Reply-To: <10784977.EvYhyI6sBW@phil>
References: <20250718075058.243a5619.xunil@tahomasoft.com>
	<10784977.EvYhyI6sBW@phil>
Organization: Tahoma Soft
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for the prompt feedback Heiko!

I'll get to work on responding to your comments, which are quite
helpful.

Regards,

Erik


On Fri, 18 Jul 2025 15:13:21 +0200
Heiko Stuebner <heiko@sntech.de> wrote:

> Hi Erik,
>=20
> Am Freitag, 18. Juli 2025, 13:50:58 Mitteleurop=C3=A4ische Sommerzeit
> schrieb Erik Beck:
> > Hello,
> >=20
> > Below please find a patch to three files to provide initial support
> > for the LinkStar H68K-1432v1 board with Rockchip rk3568 SOC.=20
> >=20
> > This has been tested on the hardware and works well in support of
> > router features. Namely, it supports:
> >=20
> > * Two 1 Gbs Ethernet ports
> > * Two 2.5 Gbs Ethernet ports
> > * Two USB 3.0 Type A sockets
> > * One USB 3.0 Type C socket
> > * One USB 2.0 Type A socket
> > * WiFi
> > * LED
> > * Debug console
> >=20
> > I look forward to receiving and responding to questions, comments,
> > concerns, and critiques.
> >=20
> > Thank you for your reviews.
> >=20
> > Regards,
> >=20
> > Erik =20
>=20
> The above test reads more like a cover-letter instead of a commit
> message. Please take look at how other board additions are worded.
>=20
> > Signed-off-by: Erik Beck <xunil@tahomasoft.com>
> > Tested-by: Erik Beck <xunil@tahomasoft.com>
> >=20
> >  .../devicetree/bindings/arm/rockchip.yaml          |   5 +
> >  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
> >  .../dts/rockchip/rk3568-linkstar-h68k-1432v1.dts   | 777 =20
>=20
> please split this into two commits, one adding the yaml binding and
> one adding the board devicetree.
>=20
> Also please check scripts/get_maintainer.pl to see who to Cc
> explicitly (like the devicetree maintainers)
>=20
>=20
> >  +++++++++++++++++++++ 3 files changed, 783 insertions(+)
> >=20
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > b/Documentation/devicetree/bindings/arm/rockchip.yaml index
> > 28db6bd6aa5b..e48b168cfffe 100644 --- =20
>=20
> please try to use "git send-email" to send patches, because it looks
> like your mail program mangled the patch by adding line breaks
> (more of them below). So the patch most likely won't apply.
>=20
>=20
> > diff --git
> > a/arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dts
> > b/arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dts new
> > file mode 100644 index 000000000000..f8f80c7616cd --- /dev/null +++
> > b/arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dts @@
> > -0,0 +1,777 @@ +// SPDX-License-Identifier: (GPL-2.0+ OR MIT) +//
> > Copyright (c) 2022 AmadeusGhost <amadeus@jmu.edu.cn> +//
> > +// Copyright (c) 2025 TahomaSoft xunil@tahomasoft.com
> > +//
> > +// Support for Seeed LinkStar H68K-1432v1
> > +// Also likely supports LinkStar H68K-1432v2
> > +// NB: Hinlink H68K is same or very similar under different trade
> > name =20
>=20
> please use preferred comment style - see other kernel devicetrees.
>=20
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include <dt-bindings/soc/rockchip,vop2.h>
> > +#include "rk3568.dtsi"
> > +
> > +
> > +/ {
> > +        model =3D "Seeed LinkStar H68K-1432V1 (RK3568) DDR4 Board";
> > +        compatible =3D "seeed,rk3568-linkstar-h68k-1432v1",
> > "rockchip,rk3568"; +
> > +        aliases {
> > +                ethernet0 =3D &gmac0;
> > +                ethernet1 =3D &gmac1;
> > +
> > +                /* fixed eMMC */
> > +                mmc0 =3D &sdhci;  /* sdhci:=3D @fe310000 */ /*
> > mmcblk0... */ =20
>=20
> no need for the comments before and after the alias, same below
>=20
> > +
> > +                /* removable uSD/TF Card */
> > +                mmc1 =3D &sdmmc0; /* sdmmc0:=3D @fe2b0000 */ /*
> > mmcblk1... */ +
> > +                rtc0 =3D &rk809;
> > +
> > +               led-boot =3D &led_one; /* status LED, green */
> > +               led-failsafe =3D &led_three; /* heartbeat LED */
> > +               led-running =3D &led_one; /* status LED, green */
> > +               led-upgrade =3D &led_two; /* function LED, amber */ =20
>=20
> I don't think those are specified? What is supposed to use those?
>=20
> > + =20
>=20
> unneeded empty line
>=20
> > +        };
> > + =20
>=20
> [...]
>=20
> > +        gpio-keys {
> > +                compatible =3D "gpio-keys";
> > +                pinctrl-0 =3D <&reset_button_pin>;
> > +                pinctrl-names =3D "default";
> > +
> > +        /* Middle inset/recessed button,
> > +                  marked by clockwise arrow/circle */
> > +
> > +                button-reset { /* gpiochip=3D0, line=3D0 */ =20
>=20
> again unneeded comment ... that content is contained in the gpios
> property already
>=20
> > +                        label =3D "button:system:reset";
> > +                        gpios =3D <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
> > +                        linux,code =3D <KEY_RESTART>;
> > +                        debounce-interval =3D <50>;
> > +                };
> > +
> > +        };
> > +
> > + /* gpio chip 0, line 24 responds to console key press */
> > +
> > +        gpio-leds {
> > +                compatible =3D "gpio-leds";
> > +                pinctrl-names =3D "default";
> > +                pinctrl-0 =3D <&led_white_pin>, <&led_green_pin>,
> > +                         <&led_amber_pin>, <&led_blue_pin>;
> > +
> > +                /* White LED inset in power button */ =20
>=20
> that commment is helpful, so could stay
>=20
> > +
> > +                led_zero: led_white   { /* gpiochip=3D0, line=3D14 */ =
=20
>=20
> preferred naming would probably be
>   led_white: led-0 {}
>=20
> similar for the other ones
>=20
> > +                        color =3D <LED_COLOR_ID_WHITE>;
> > +                        default-state =3D "on";
> > +                        function =3D LED_FUNCTION_POWER;
> > +                        gpios =3D <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
> > +                        label =3D "power_button_led:white_led";
> > +                        linux,default-trigger =3D "default-on";
> > +
> > +                };
> > +
> > +        vcc12v_dcin: vcc12v-dcin { =20
>=20
> vcc12v_dcin: regulator-vcc12v-dcin {}
>=20
> same for the others
>=20
> > +                compatible =3D "regulator-fixed";
> > +                regulator-always-on;
> > +                regulator-boot-on;
> > +                regulator-min-microvolt =3D <12000000>;
> > +                regulator-max-microvolt =3D <12000000>;
> > +                regulator-name =3D "vcc12v_dcin";
> > +        };
> > + =20
>=20
> > +&gmac0 {
> > +        assigned-clocks =3D <&cru SCLK_GMAC0_RX_TX>, <&cru
> > SCLK_GMAC0>;
> > +        assigned-clock-parents =3D <&cru SCLK_GMAC0_RGMII_SPEED>;
> > +        assigned-clock-rates =3D <0>, <125000000>;
> > +        clock_in_out =3D "output";
> > +        phy-mode =3D "rgmii-id";
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&gmac0_miim
> > +                     &gmac0_tx_bus2
> > +                     &gmac0_rx_bus2
> > +                     &gmac0_rgmii_clk
> > +                     &gmac0_rgmii_bus>;
> > +        snps,reset-gpio =3D <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
> > +        snps,reset-active-low;
> > +        snps,reset-delays-us =3D <0 20000 100000>;
> > +        tx_delay =3D <0x3c>;
> > +        rx_delay =3D <0x2f>; =20
>=20
> please see other recent mails about those
> The rgmii-id above should not need those delays?
>=20
> > +        phy-handle =3D <&rgmii_phy0>;
> > +        status =3D "okay";
> > +};
> > +
> > + /* combphy0/multi-phy0 supports one of: usb3.0 otg, sata0 */ =20
>=20
> drop the comments
>=20
> > +&combphy0 {
> > +        status =3D "okay";
> > +
> > +};
> > +
> > + /* combphy1/multi-phy1 supports one of:
> > +                         - usb3.0 host
> > +                         - sata1
> > +                         - qsgmii/sgmii
> > + */
> > +
> > +&combphy1 {
> > +        status =3D "okay";
> > +};
> > +
> > + /* combphy2/multi-phy2 supports one of:
> > +                         - pcie2.1
> > +                         - sata2
> > +                         - qsgmii/sgmii
> > + */
> > +
> > +&combphy2 {
> > +        status =3D "okay";
> > +};
> > + =20
>=20
> I did stop here for now.
>=20
> Heiko
>=20
>=20
>=20


