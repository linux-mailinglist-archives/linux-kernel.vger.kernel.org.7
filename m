Return-Path: <linux-kernel+bounces-869240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0AC07625
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F731B84676
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552BB337699;
	Fri, 24 Oct 2025 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSwD/cs5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B731D74E;
	Fri, 24 Oct 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324370; cv=none; b=ufb4MVorgwNsM8kcP1rO+eWSN3y3uIzcyDHUFr7NLAOiTHYSawZdZnHAwAQ10s85/Th6V2PXcOzJnBwC5x671WFfdHw5t0QO4mAGGsIw1eIoGvnJ12i+AWYsNBg8Xy694T3x9KrfaoWnAXdwTOUOzfohNnGclZsZmX2haXWNvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324370; c=relaxed/simple;
	bh=oH2uo8kUvZvaWDuaKBK5Ia3tKQOcMF+N8RlJE5fLuNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1eWPxKyJB85BBoquRmzFxxb5grTu+V1EcwZnrAFZvTtZwKpvn+Os0rF00cLAR2szpmNhHBV5gBp66BvlixwqW3IHlMY//lUpd/VZnU759CLvkHktw6EkE1yipJoTP58RhV36IPRcRm6bSof9E9VnZl7zK4m3fXT5E4UTuXHl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSwD/cs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56CCC4CEF1;
	Fri, 24 Oct 2025 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761324369;
	bh=oH2uo8kUvZvaWDuaKBK5Ia3tKQOcMF+N8RlJE5fLuNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSwD/cs5L6f5qlBmgfQodcXn4hEKJOQyLYx6LmkIVGt9zRcacVOreE4uvk+9JlYxy
	 pI6L5HJGt8wvzSJsvZ+UvEXsT2TFskHEQdHqxw8N/C6uQc5AyusqbRW/xtFuyCMn1R
	 Oj3GqElZImOxVsQIhDCVkwk6yHrcaae6BtwQXWVPR46rxaDM54P09G6/WNGEUSBB7Y
	 skUG3IZ2D38fTg0Jh3ky+KQjIAx/p31peSkUJiuupbYsgq88vJxT2SDqMYr7Ig78xx
	 02Hq7NA1FvUwDT1DXDVmyvxkbwBhuxhALAS0pFa9OAS3BSwB/bKtYGJSw1NTmJk2Jt
	 H+lv1Je1X2+Fw==
Date: Fri, 24 Oct 2025 17:46:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <20251024-hangout-designing-33e96c0d35fc@spud>
References: <20251024030528.25511-1-looong.bin@gmail.com>
 <20251024030528.25511-2-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OpamxSOV8OwCADjJ"
Content-Disposition: inline
In-Reply-To: <20251024030528.25511-2-looong.bin@gmail.com>


--OpamxSOV8OwCADjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:05:14AM +0800, Longbin Li wrote:
> The Sophgo CV1800/SG2000 SoC top misc system controller provides register

Please remind me how it works, sg2000 is just a rebadge and really this
just refers to one device?

> access to configure related modules. It includes a usb2 phy and a dma
> multiplexer.
>=20
> Co-developed-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>  .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,c=
v1800b-top-syscon.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-=
top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv180=
0b-top-syscon.yaml
> new file mode 100644
> index 000000000000..d044ca661fa2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-sys=
con.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800b-top-syscon.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV18XX/SG200X SoC top system controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +description:
> +  The Sophgo CV18XX/SG200X SoC top misc system controller provides
> +  register access to configure related modules.

Here and in the title you have Xs, are those placeholder or is this
going into cv180x.dtsi and going to be used on multiple devices?

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: sophgo,cv1800b-top-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true

Do you actually use ranges?

> +patternProperties:
> +  "dma-router@[0-9a-f]+$":

Do these actually appear at variable addresses, or is it always 48 for
the phy and 53 for the dma router?

> +    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
> +    unevaluatedProperties: false
> +
> +  "phy@[0-9a-f]+$":
> +    $ref: /schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sophgo,cv1800.h>
> +
> +    syscon@3000000 {
> +      compatible =3D "sophgo,cv1800b-top-syscon", "syscon", "simple-mfd";
> +      reg =3D <0x03000000 0x1000>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <1>;
> +
> +      usbphy: phy@48 {

Drop the labels off of these two, since they're unused in the example.

> +        compatible =3D "sophgo,cv1800b-usb2-phy";
> +        reg =3D <0x48 0x4>;
> +        #phy-cells =3D <0>;
> +        clocks =3D <&clk CLK_USB_125M>,
> +                 <&clk CLK_USB_33K>,
> +                 <&clk CLK_USB_12M>;
> +        clock-names =3D "app", "stb", "lpm";
> +        resets =3D <&rst 58>;
> +      };
> +
> +      dmamux: dma-router@154 {
> +        compatible =3D "sophgo,cv1800b-dmamux";
> +        reg =3D <0x154 0x8>, <0x298 0x4>;
> +        #dma-cells =3D <2>;
> +        dma-masters =3D <&dmac>;
> +      };
> +    };
> +
> +...
> --
> 2.51.0

--OpamxSOV8OwCADjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPutSwAKCRB4tDGHoIJi
0trzAP4nfQ6/Wxgh8wcGJdVXjTM5fYSSjyHVynWRqnuELKsrCQD+NmT3Mi9bgtxf
nLsFD4E3jkFuEsA2OafNMSd9+ubbNw8=
=pezZ
-----END PGP SIGNATURE-----

--OpamxSOV8OwCADjJ--

