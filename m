Return-Path: <linux-kernel+bounces-869218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27898C07511
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D35E1C40D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC733769A;
	Fri, 24 Oct 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1jDcVgD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C15258ED5;
	Fri, 24 Oct 2025 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323376; cv=none; b=Jyj+QyIOEWnkbdykFgqXDqAsokkrx0Zx3Blsxx41X4y8Er1f/hVFDgeruUE/0g9inrD/T8UEvRqIRzIrYiQu5JetkPu308CuIaQnSG1Ya8Yg2xB4IuqZdwiHwnqKSgWFXHWJ6rPGbdwV51bl46fjEeugXYJZuTyqfVuouzWm93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323376; c=relaxed/simple;
	bh=J7OMjg4+GfzNY1ARYj6hyRpVfLZJNzOfQdY9BTlvpsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBMneGAaQlsxTgmoQmx5FqHyf6HKEkDvKFFUpyHz7M5dcTvyZq4eLY6YfKR2MCEsjV+FeTgA48dw/nu/nh1kHjI1G2VW/+5v+CCrrK6C3f2bM2Rz2zCfWqoOaK7Eb5FOX9hpdrRngITp9x14ZKaTdyZeeElUy0wvKUKEirfB//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1jDcVgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84656C4CEF1;
	Fri, 24 Oct 2025 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761323376;
	bh=J7OMjg4+GfzNY1ARYj6hyRpVfLZJNzOfQdY9BTlvpsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1jDcVgDap9U54WInJ8YbqD6QpOMUXvRpL4//FMU+fvnu5dZvjaDevwUNEHbvkrkC
	 kVoCzRaL9Xz1c1Sxams385EMs/ud14kQNl51l7j8A8ok6KQpmeZv4l48SlhIwSvtdu
	 rqHMATQeut3nWjloZC82kayoS/DPzX8GWHKSLkN2KYK3ZCA38UD1IoAkdzxEFra/nk
	 0mIyFuPFHly+dcbqHMYhYXDBUqBYZubxKyEyeHIcBkY0N63Fngt9vDZ3LmMOMXeq06
	 T5eWeG4s0jtN27Kuegh89IyiwUio38ugIt100xXao4R/Ed/BqgV6ATZTaE/u7Br06V
	 2kRBbsnsKr22g==
Date: Fri, 24 Oct 2025 17:29:31 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v10 1/9] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
Message-ID: <20251024-think-handwoven-504634ca620d@spud>
References: <20251024083221.25758-1-angelogioacchino.delregno@collabora.com>
 <20251024083221.25758-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adpN37SuSkUm8sD7"
Content-Disposition: inline
In-Reply-To: <20251024083221.25758-2-angelogioacchino.delregno@collabora.com>


--adpN37SuSkUm8sD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:32:13AM +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks.
>=20
> This chip is fully controlled by SPMI and has multiple variants
> providing different phase configurations.
>=20
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../regulator/mediatek,mt6316b-regulator.yaml | 78 +++++++++++++++++++
>  .../regulator/mediatek,mt6316c-regulator.yaml | 78 +++++++++++++++++++
>  .../regulator/mediatek,mt6316d-regulator.yaml | 77 ++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,=
mt6316b-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,=
mt6316c-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,=
mt6316d-regulator.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6316b=
-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt63=
16b-regulator.yaml
> new file mode 100644
> index 000000000000..65b70dd90728
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regula=
tor.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6316b-regulator.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6316 BP/VP SPMI PMIC Regulators
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The MediaTek MT6316BP/VP PMICs are fully controlled by SPMI interface,=
 both
> +  feature four step-down DC/DC (buck) converters, and provides 2+2 Phase=
s,
> +  joining Buck 1+2 for the first phase, and Buck 3+4 for the second phas=
e.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6316b-regulator
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^vbuck(12|34)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      regulator-allowed-modes:
> +        description: |
> +          Allowed Buck regulator operating modes allowed. Valid values b=
elow.
> +            0 - Normal mode with automatic power saving, reducing the sw=
itching
> +                frequency when light load conditions are detected
> +            1 - Forced Continuous Conduction mode (FCCM) for improved vo=
ltage
> +                regulation accuracy with constant switching frequency bu=
t lower
> +                regulator efficiency
> +            2 - Forced Low Power mode for improved regulator efficiency,=
 used
> +                when no heavy load is expected, will shut down unnecessa=
ry IP
> +                blocks and secondary phases to reduce quiescent current.
> +                This mode does not limit the maximum output current but =
unless
> +                only a light load is applied, there will be regulation a=
ccuracy
> +                and efficiency losses.
> +        minItems: 1
> +        maxItems: 3
> +        items:
> +          enum: [ 0, 1, 2 ]

This property has no default, and the property is not required. Is one
of these modes the default, or is there another mode beyond what's here
that is used if the property is absent? Or are all modes allowed with no
property?

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'

Why is address-cells required here? Your bucks don't have addresses.
If it is actually required, Rob's bot has pointed out that the property
isn't defined for the device anyway.

pw-bot: changes-requested

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/spmi/spmi.h>
> +
> +    spmi {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <0>;
> +
> +      pmic@8 {
> +        compatible =3D "mediatek,mt6316b-regulator";
> +        reg =3D <0x8 SPMI_USID>;
> +        #address-cells =3D <0>;
> +
> +        vbuck12 {
> +          regulator-name =3D "dvdd_core";
> +          regulator-min-microvolt =3D <450000>;
> +          regulator-max-microvolt =3D <965000>;
> +          regulator-allowed-modes =3D <0 1 2>;
> +          regulator-enable-ramp-delay =3D <256>;
> +        };
> +      };
> +    };
> +...

--adpN37SuSkUm8sD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPupawAKCRB4tDGHoIJi
0tP5AQDTEDGCok9YeXiwjucuPp5QDUW1WDyirZEYNOB8nLm3NQD/XZWXvV8E/94V
LqudmxMVSSFy3pt6GNMlPr0im8tgWgU=
=xSW1
-----END PGP SIGNATURE-----

--adpN37SuSkUm8sD7--

