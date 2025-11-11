Return-Path: <linux-kernel+bounces-895978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0416C4F67E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E81394ED243
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E2928468D;
	Tue, 11 Nov 2025 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE1UvpH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D83824BD;
	Tue, 11 Nov 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885105; cv=none; b=YFreWjXa98H/9NdR/z6B1ndgKIrp3amzgi3A4beEZcs4dN2aKwf6sI9C0oytqHLexc9AG6gFjtlkzLPDkjfEExQge4baMujyN4CrOfyruA1wvgXu+Ienk6JwNrNJOrquLqjlMOWqSvaoIAKBrQZZgv/f2KEENUgXrUC/N2dNoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885105; c=relaxed/simple;
	bh=9A1g77d6NETJrsVEFwCGkGYcg7oNe/734nbYe0R1toY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNggRN7seV+eA+TouBnQusnTt5o+ZfRrJ0QWBxNrZXCPmuhQD2JFABT4+dw3bB643Ja+El0vxaT6iI9ajaoyGdatwNIpj8NHLOU6lHcjqjTwblT9TJqSzaPkjokO3f3MP32uruNi/XUQ9ezA0iFO6lF9YTPKswWFz70Up5H0O4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE1UvpH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0EDC116D0;
	Tue, 11 Nov 2025 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762885105;
	bh=9A1g77d6NETJrsVEFwCGkGYcg7oNe/734nbYe0R1toY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DE1UvpH/bC9UZ2eBNdd8mq2OkWzJrQvT+sAdgbmfNQQBPEh/tAnmIjmopSsH+/i5E
	 U1rDhQJM6MweLo/ufwiBDM1lFfgKcPglJWSBD8nWcdG+Vr4fZgBqLOGcWOkbbkTgFP
	 qxrcE5TT/HeNEs2/29sSMaAT3+TvBpLE0BqHvBX3DLzbFSNvkQbKU/GZjwnEPwEnUC
	 jC93p3cJ384/NXhhyYsEV/eB0Jm+haN1qW16cidNuUY6nM7B/Q8WDq45uLjgnaf5td
	 /1NW0yt7iA2gNM7b0Id+r8yDnMfYFl70ge4s3ljjhcgKNlcbxqbej4tvEWtzceK24a
	 JhfIq7TMhW33g==
Date: Tue, 11 Nov 2025 18:18:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Andy Yan <andyshrk@163.com>, Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC 01/13] dt-bindings: soc: starfive: Add vout-subsystem
 IP block
Message-ID: <20251111-massager-twistable-1e88f03d82f8@spud>
References: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
 <CGME20251108010453eucas1p2403ec0dd2c69ae7f3eabe19cf686f345@eucas1p2.samsung.com>
 <20251108-jh7110-clean-send-v1-1-06bf43bb76b1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LyJKcpcoYORwRgse"
Content-Disposition: inline
In-Reply-To: <20251108-jh7110-clean-send-v1-1-06bf43bb76b1@samsung.com>


--LyJKcpcoYORwRgse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 02:04:35AM +0100, Michal Wilczynski wrote:
> Add the dt-binding documentation for the StarFive JH7110 Video Output
> (VOUT) subsystem.
>=20
> This node acts as a parent for all devices within the VOUT power domain,
> including the DC8200 display controller, the VOUTCRG clock generator,
> and the HDMI MFD block. Its driver is responsible for managing the
> shared power domain and top-level bus clocks for these children.
>=20
> It is a bit similar to the display subsystem qcom,sdm845-mdss DT node.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../starfive/starfive,jh7110-vout-subsystem.yaml   | 156 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   5 +
>  2 files changed, 161 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh71=
10-vout-subsystem.yaml b/Documentation/devicetree/bindings/soc/starfive/sta=
rfive,jh7110-vout-subsystem.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..4ad9423ea139a537b4cfea26b=
0ed4ed263aa14a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-vout=
-subsystem.yaml
> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-vout-sub=
system.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 VOUT (Video Output) Subsystem
> +
> +maintainers:
> +  - Michal Wilczynski <m.wilczynski@samsung.com>
> +
> +description:
> +  The JH7110 video output subsystem is an IP block that contains
> +  the display controller (DC8200), HDMI controller/PHY, and VOUT
> +  clock generator (VOUTCRG).
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-vout-subsystem
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +patternProperties:
> +  "^display@[0-9a-f]+$":

Personally I'd like to see these being regular properties, since there's
exactly one possible setup for this.

> +    type: object
> +    description: Verisilicon DC8200 Display Controller node.

Can you add the relevant references here instead of allowing any object?

Cheers,
Conor.

> +
> +  "^hdmi@[0-9a-f]+$":
> +    type: object
> +    description: StarFive HDMI MFD (PHY + Controller) node.
> +
> +  "^clock-controller@[0-9a-f]+$":
> +    type: object
> +    description: StarFive VOUT Clock Generator (VOUTCRG) node.
> +
> +  "^syscon@[0-9a-f]+$":
> +    type: object
> +    description: StarFive VOUT Syscon node.
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - clocks
> +  - resets
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +    #include <dt-bindings/power/starfive,jh7110-pmu.h>
> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        vout_subsystem: display-subsystem@29400000 {
> +            compatible =3D "starfive,jh7110-vout-subsystem";
> +            reg =3D <0x0 0x29400000 0x0 0x200000>;
> +            #address-cells =3D <2>;
> +            #size-cells =3D <2>;
> +            ranges;
> +
> +            power-domains =3D <&pwrc JH7110_PD_VOUT>;
> +            clocks =3D <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>;
> +            resets =3D <&syscrg JH7110_SYSRST_NOC_BUS_DISP_AXI>;
> +
> +            dc8200: display@29400000 {
> +                compatible =3D "verisilicon,dc";
> +                reg =3D <0x0 0x29400000 0x0 0x2800>;
> +                interrupts =3D <95>;
> +                clocks =3D <&voutcrg JH7110_VOUTCLK_DC8200_CORE>,
> +                         <&voutcrg JH7110_VOUTCLK_DC8200_AXI>,
> +                         <&voutcrg JH7110_VOUTCLK_DC8200_AHB>,
> +                         <&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
> +                         <&voutcrg JH7110_VOUTCLK_DC8200_PIX1>;
> +                clock-names =3D "core", "axi", "ahb", "pix0", "pix1";
> +                resets =3D <&voutcrg JH7110_VOUTRST_DC8200_AXI>,
> +                         <&voutcrg JH7110_VOUTRST_DC8200_AHB>,
> +                         <&voutcrg JH7110_VOUTRST_DC8200_CORE>;
> +                reset-names =3D "axi", "ahb", "core";
> +            };
> +
> +            hdmi_mfd: hdmi@29590000 {
> +                compatible =3D "starfive,jh7110-hdmi-mfd";
> +                reg =3D <0x0 0x29590000 0x0 0x4000>;
> +                interrupts =3D <99>;
> +
> +                hdmi_phy: phy {
> +                    compatible =3D "starfive,jh7110-inno-hdmi-phy";
> +                    clocks =3D <&xin24m>;
> +                    clock-names =3D "refoclk";
> +                    #clock-cells =3D <0>;
> +                    clock-output-names =3D "hdmi_pclk";
> +                    #phy-cells =3D <0>;
> +                };
> +
> +                hdmi_controller: controller {
> +                    compatible =3D "starfive,jh7110-inno-hdmi-controller=
";
> +                    interrupts =3D <99>;
> +                    clocks =3D <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
> +                             <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
> +                             <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
> +                             <&hdmi_phy>;
> +                    clock-names =3D "sys", "mclk", "bclk", "pclk";
> +                    resets =3D <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
> +                    reset-names =3D "hdmi_tx";
> +                    phys =3D <&hdmi_phy>;
> +                    phy-names =3D "hdmi-phy";
> +                };
> +            };
> +
> +            voutcrg: clock-controller@295c0000 {
> +                compatible =3D "starfive,jh7110-voutcrg";
> +                reg =3D <0x0 0x295c0000 0x0 0x10000>;
> +                clocks =3D <&syscrg JH7110_SYSCLK_VOUT_SRC>,
> +                         <&syscrg JH7110_SYSCLK_VOUT_TOP_AHB>,
> +                         <&syscrg JH7110_SYSCLK_VOUT_TOP_AXI>,
> +                         <&syscrg JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
> +                         <&syscrg JH7110_SYSCLK_I2STX0_BCLK>,
> +                         <&hdmi_phy>;
> +                clock-names =3D "vout_src", "vout_top_ahb",
> +                              "vout_top_axi", "vout_top_hdmitx0_mclk",
> +                              "i2stx0_bclk", "hdmitx0_pixelclk";
> +                resets =3D <&syscrg JH7110_SYSRST_VOUT_TOP_SRC>;
> +                reset-names =3D "vout_top";
> +                #clock-cells =3D <1>;
> +                #reset-cells =3D <1>;
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 348caaaa929a519bc0ec5c0c7b587468ef7532d5..99434e54dc39494153677a6ca=
359d70f2ba2ddb3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24044,6 +24044,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> =20
> +STARFIVE JH7110 DISPLAY SUBSYSTEM
> +M:	Michal Wilczynski <m.wilczynski@samsung.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-vout-s=
ubsystem.yaml
> +
>  STARFIVE JH7110 DPHY RX DRIVER
>  M:	Jack Zhu <jack.zhu@starfivetech.com>
>  M:	Changhuang Liang <changhuang.liang@starfivetech.com>
>=20
> --=20
> 2.34.1
>=20

--LyJKcpcoYORwRgse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRN96AAKCRB4tDGHoIJi
0op6AP94in4x/F+djtzX2cdGh5YC4XpNjLGROQ5E+6usNlM+lgEA8CLCphPZFJZM
EEQ1XnVlM99yRJUHnSZmsnWiZzmyCQo=
=wEbO
-----END PGP SIGNATURE-----

--LyJKcpcoYORwRgse--

