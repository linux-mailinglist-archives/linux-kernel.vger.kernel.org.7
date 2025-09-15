Return-Path: <linux-kernel+bounces-817558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F97B583BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1A9481404
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0F2882D4;
	Mon, 15 Sep 2025 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka5h4uKJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4B1B423C;
	Mon, 15 Sep 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957672; cv=none; b=hglWPQyuwK1NTYgCzdiEPmeW273q6tred0X79FtHAEuIbOdDzSPlZ47IFZizBFVwjYBOFnJ21cNt/GVegUmAAT9fGB0ZZhUtWkNuDAhRk+tRGCoeBm0aMWamgNGSZpYV4slRwUxSzXk56w7EDBFh4bNdm4NHTR5nHNlY2hqzGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957672; c=relaxed/simple;
	bh=xdyN8QrgkcXiiXUNlzZ3kC6oiVOEfV3O4Qxzv4ZDyKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIl6p7zhaDxK4lD1o5MybAmED1QoGdt67WnPM3nWPIphw/6D0SLuCHuSSRQ/pPatYB05V5zS0PcEWbXEYWLxQDmFegdJgP/J6pDkxWQrVe2RzN7GWkLToVFVf4yRxtH/TsCcFDPx3U9Crgqoo/nDtBEP1Tsz21bepsPo3PWVh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka5h4uKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DFDC4CEF1;
	Mon, 15 Sep 2025 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757957672;
	bh=xdyN8QrgkcXiiXUNlzZ3kC6oiVOEfV3O4Qxzv4ZDyKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ka5h4uKJh54wZiBGZv0PfDuMGVBIvW7Foiz8zo9UC7TM40528+a8l+NKb35pGFW5x
	 wmDyIG/cF+492DKdJWz+5NMRh2TTp2rANkJ/1TLrdCjexINADSfa/1blsuQS9+yxoQ
	 HQI6pZvyDncCWkf0up8o2MNQ/XC4dS7Wk01HEWy3elc8T096ORBVdxBS6JeV+P2Jns
	 TWt5/xdDMKKfeTGMbJbbtPNh5mC0OL38lWiGt+xqOlktADmMsSEN26+PNKEZwBt7BL
	 YCuBbJBp+3Y2biSQsraOKRTr9nO4z8/jEB30ONqPb6pTh/7b8fIZFzb9VR/DFbfUGK
	 +oalKP98tWkoQ==
Date: Mon, 15 Sep 2025 18:34:27 +0100
From: Conor Dooley <conor@kernel.org>
To: caohang@eswincomputing.com
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add ESWIN EIC7700 USB controller
Message-ID: <20250915-affair-halves-4f881f6c7cdb@spud>
References: <20250915085329.2058-1-caohang@eswincomputing.com>
 <20250915091024.2128-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lHp9f8rPZ3s0Ln+b"
Content-Disposition: inline
In-Reply-To: <20250915091024.2128-1-caohang@eswincomputing.com>


--lHp9f8rPZ3s0Ln+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 05:10:24PM +0800, caohang@eswincomputing.com wrote:
> From: Hang Cao <caohang@eswincomputing.com>
>=20
> Add Device Tree binding documentation for the ESWIN EIC7700
> usb controller module.
>=20
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> Signed-off-by: Hang Cao <caohang@eswincomputing.com>
> ---
>  .../bindings/usb/eswin,eic7700-usb.yaml       | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-u=
sb.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml=
 b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
> new file mode 100644
> index 000000000000..37797b85f417
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/eswin,eic7700-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ESWIN EIC7700 SoC Usb Controller
> +
> +maintainers:
> +  - Wei Yang <yangwei1@eswincomputing.com>
> +  - Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> +  - Hang Cao <caohang@eswincomputing.com>
> +
> +description:
> +  The Usb controller on EIC7700 SoC.
> +
> +allOf:
> +  - $ref: snps,dwc3-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-dwc3
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: peripheral
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: cfg
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: vaux
> +
> +  eswin,hsp-sp-csr:
> +    description:
> +      HSP CSR is to control and get status of different high-speed perip=
herals
> +      (such as Ethernet, USB, SATA, etc.) via register, which can close
> +      module's clock,reset module independently and tune board-level's
> +      parameters of PHY, etc.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to HSP Register Controller hsp_sp_csr n=
ode.
> +          - description: usb bus register offset.
> +          - description: axi low power register offset.
> +          - description: vbus frequency register offset.
> +          - description: mpll register offset.

As I mentioned on the shdci binding patch, I'm not happy with the
justification for this phandle. What exactly is the clock that this
controls and why does it not have a dedicated clock-controller driver
and reset-controller driver?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - resets
> +  - reset-names
> +  - eswin,hsp-sp-csr
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    usb@50480000 {
> +        compatible =3D "eswin,eic7700-dwc3";
> +        reg =3D <0x50480000 0x10000>;
> +        clocks =3D <&clock 170>,
> +                 <&clock 171>;
> +        clock-names =3D "aclk", "cfg";
> +        interrupt-parent =3D <&plic>;
> +        interrupts =3D <85>;
> +        interrupt-names =3D "peripheral";
> +        resets =3D <&reset 84>;
> +        reset-names =3D "vaux";
> +        dr_mode =3D "peripheral";
> +        maximum-speed =3D "high-speed";
> +        phy_type =3D "utmi";
> +        snps,dis_enblslpm_quirk;
> +        snps,dis-u2-freeclk-exists-quirk;
> +        snps,dis_u2_susphy_quirk;
> +        snps,dis-del-phy-power-chg-quirk;
> +        snps,parkmode-disable-ss-quirk;
> +        eswin,hsp-sp-csr =3D <&hsp_sp_csr 0x800 0x818 0x83c 0x840>;
> +    };
> --=20
> 2.34.1
>=20

--lHp9f8rPZ3s0Ln+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhOIwAKCRB4tDGHoIJi
0k4TAQD00MoLrBg/p4HBswrQboDCa4DZvvsqxuybAHG1SjT6OQEA+2FnmEAbpdbr
J4JLXZXu+T/fmtBtyZE9pAycJs964gQ=
=nMB6
-----END PGP SIGNATURE-----

--lHp9f8rPZ3s0Ln+b--

