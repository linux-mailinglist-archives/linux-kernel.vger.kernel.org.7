Return-Path: <linux-kernel+bounces-869212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A037C074A5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AC33B8C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF56326D7E;
	Fri, 24 Oct 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTy1hkKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD61EEA5F;
	Fri, 24 Oct 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323118; cv=none; b=k4dXmGy4lrK+DxPbXyvJmJC/o6sLpRe0RBO/wnJPblAspkBnDkfaHY87BmIGjHAkLAoBnQRn61uYCaY9CxX3qSzDPlNjSagcuY+WEiMxcOvl142p39CQEgaltSd2XLxVqKTPkgyOvr/TmP1x+ul8LWm/l1dpJrM8hk5dX4G7axo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323118; c=relaxed/simple;
	bh=zIhatHOop5VHM1hZdEuI5gEL89I036E+FwCPc6EAmEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6GSX78C7bQQ09Hc6Wxum/REkE8G54tJQva/2XZq0n4jOQwMRENMKnyNDk8vuaXOFQjEzkKtDx1wdJNajL/0lY5LhqEUsJO3SA7McptnFzxs6dN9LycRaZ55lOmz8aS+oNDKlUuu9AIBn6P32wNHKoenN3B2xstLvr212prupms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTy1hkKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8554C4CEF1;
	Fri, 24 Oct 2025 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761323118;
	bh=zIhatHOop5VHM1hZdEuI5gEL89I036E+FwCPc6EAmEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTy1hkKYjvbOgv2kLRk2TvNW80C9TCuxq2mtd0FmSy/AorkHB5ZQ8pOdw3yU1mQDf
	 6bw2EDpQy4QZtUYEvQww1yExApzVIyfq3Q4+W5hSYmqd6SZhIiTE2ZJ0dDHac4iR+B
	 fKHt5wIrBIuUEOxm3bojACr42eIVtpARcCcrqsO7B3z3skSfK4uTJ8hmdCE0RNkx0+
	 LqVszcL9x/W9POT7XnyRf2LeM1Tu4wDEuAe3LfPDN4vQ71D926C6r46/D5CWPraz9l
	 5PKBbbZNaK5xOmeDKQ5IR5y+rnprD1vVS7Fjfo3IrHPK0PlPJFEsDR01rCrE8PnCj3
	 99jTCVFVepF8Q==
Date: Fri, 24 Oct 2025 17:25:12 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	laura.nao@collabora.com, nfraprado@collabora.com,
	wenst@chromium.org, y.oudjana@protonmail.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 6/7] dt-bindings: clock: Describe MT6685 PM/Clock IC
 Clock Controller
Message-ID: <20251024-trophy-clause-7db540d073fa@spud>
References: <20251024083301.25845-1-angelogioacchino.delregno@collabora.com>
 <20251024083301.25845-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwCfY64Se0JycgpW"
Content-Disposition: inline
In-Reply-To: <20251024083301.25845-7-angelogioacchino.delregno@collabora.com>


--hwCfY64Se0JycgpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:33:00AM +0200, AngeloGioacchino Del Regno wrote:
> Add bindings to describe the SCK_TOP clock controller embedded
> in the MT6685 IC, reachable over the SPMI bus.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>=20
> NOTE: This does not contain any example because the MT6685 RTC
>       will be added to the mfd binding for MediaTek SPMI PMICs
>       and examples will be there.
>=20
> ** For reviewing purposes, this is how the example will look like: **
>=20
>   - |
>     #include <dt-bindings/interrupt-controller/irq.h>
>     #include <dt-bindings/spmi/spmi.h>
>=20
>     spmi {
>       #address-cells =3D <2>;
>       #size-cells =3D <0>;
>=20
>       pmic@9 {
>         compatible =3D "mediatek,mt6363";
>         reg =3D <0x9 SPMI_USID>;
>         interrupts =3D <9 1 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-controller;
>         #address-cells =3D <1>;
>         #interrupt-cells =3D <3>;
>         #size-cells =3D <0>;
>=20
>         clock-controller@514 {
>           compatible =3D "mediatek,mt6685-sck-top";
>           reg =3D <0x514>;
>           #clock-cells =3D <1>;
>         };
>=20
>         rtc@580 {
>           compatible =3D "mediatek,mt6685-rtc";
>           reg =3D <0x580>;
>           interrupts =3D <9 0 IRQ_TYPE_LEVEL_HIGH>;
>         };
>       };
>     };
>=20
>  .../bindings/clock/mediatek,mt6685-clock.yaml | 37 +++++++++++++++++++
>  .../dt-bindings/clock/mediatek,mt6685-clock.h | 17 +++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt66=
85-clock.yaml
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6685-clock.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6685-cloc=
k.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
> new file mode 100644
> index 000000000000..5407ebf2f3b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mediatek,mt6685-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Clock Controller for MT6685 SPMI PM/Clock IC
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description: |
> +  The clock architecture in MediaTek PMICs+Clock ICs is structured like =
below:
> +  Crystal(XO) or Internal ClockGen -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate

Is this the intended formatting? Looks weird with "dividers" being
unaligned with the --> above it, but maybe you were just going for x
number of spaces?

> +
> +  The device nodes provide clock gate control in different IP blocks.

I think this is more understandable as "This device provides clock gate
control", if this sck-top is only doing gating. Otherwise, not clear if
the dividers and muxes are here or elsewhere.

> +properties:
> +  compatible:
> +    const: mediatek,mt6685-sck-top
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> diff --git a/include/dt-bindings/clock/mediatek,mt6685-clock.h b/include/=
dt-bindings/clock/mediatek,mt6685-clock.h
> new file mode 100644
> index 000000000000..acc5e2e15ce1
> --- /dev/null
> +++ b/include/dt-bindings/clock/mediatek,mt6685-clock.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (c) 2025 Collabora Ltd.
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delre=
gno@collabora.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6685_H
> +#define _DT_BINDINGS_CLK_MT6685_H
> +
> +/* SCK_TOP_CKPDN */
> +#define CLK_RTC_SEC_MCLK		0
> +#define CLK_RTC_EOSC32			1
> +#define CLK_RTC_SEC_32K			2
> +#define CLK_RTC_MCLK			3
> +#define CLK_RTC_32K			4
> +
> +#endif /* _DT_BINDINGS_CLK_MT6685_H */
> --=20
> 2.51.1
>=20

--hwCfY64Se0JycgpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPuoaAAKCRB4tDGHoIJi
0ly3AP4pc/Q42FkFxA6oNLhl+wg3/cb/OYk9KtGv66YEAQp1IQEA9ffWiNgLR8Zb
ZwOZZtAY+ZI7j3t7lTe+lRh7yR13Eww=
=8AKD
-----END PGP SIGNATURE-----

--hwCfY64Se0JycgpW--

