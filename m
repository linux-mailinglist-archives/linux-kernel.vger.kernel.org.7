Return-Path: <linux-kernel+bounces-856506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C269BE4582
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25124273F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B6350D5E;
	Thu, 16 Oct 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQiGzob/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8FF1C84B2;
	Thu, 16 Oct 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629668; cv=none; b=W5vAQ701Wxa8Bwq+E/31QPgIZH+RuriLbyhZQNByrawlKshRc0mA4IvwL0DDX0aiWQmQW1mWq7bWHyHbFzw43bPO3JjG2S35fG55LW9SzRdSF1UAvBCzUjaqe9Th0kfPIogPq9H1A3ErIipty1TwMeMTgjrNZtWAHn6A/RoLtbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629668; c=relaxed/simple;
	bh=FlKNufpuhBcgk9SN4QuiloHjSfMgs0UC4KeGBdebjrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W16H0OhwoUhMsxWiWczUa93WZHDYjjv0y/oV+baH+FovDYHXdxyDLPIAj8w4amnFk10V7FZ0S7axavWKD/z0nFtBPdfGbT/BU1UrBYGgVCsHDKLkrljyiEVR9F7Dr+NSO4bpmdtPsbbXfl1WpFvx+ntF5+N91YwyFdVs+cp2WG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQiGzob/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF368C4CEF1;
	Thu, 16 Oct 2025 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629668;
	bh=FlKNufpuhBcgk9SN4QuiloHjSfMgs0UC4KeGBdebjrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQiGzob/dazeSYg9CUbgQ5holsVMP1Ke7AMaIv2jyr0NpY6Ijr1H0vjWROoCu9Jvg
	 9q9+JydTIZ75UYJBPa4GvE9hvGUA+Jo3F8UMBlWkDOm2vCNHcX0tfvaJ665P6q/wq4
	 mnI3OhsYn5gvsMH01GtKjlgeURrSy6lQ345JRVsW+F21jLU4o04GPeQcLRCzdQpT0R
	 AR/uvvRBU2jta1Ps7jYam6eLi+KSyhQVZHzL2XzSribOHNJ76seZ8fVohruQ4n1nNd
	 +Z0siXUFO1Xj5bWCUBiEbZxK6Uc0zHUHxJOEu2eYb3tvo2y6R0Ej4RZ2e3Q4MoJ/Lr
	 3YpkSIk70gxeQ==
Date: Thu, 16 Oct 2025 16:47:43 +0100
From: Conor Dooley <conor@kernel.org>
To: caohang@eswincomputing.com
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH] dt-bindings: usb: Add ESWIN EIC7700 USB controller
Message-ID: <20251016-oil-reuse-01758b4165ea@spud>
References: <20251016094654.708-1-caohang@eswincomputing.com>
 <20251016094748.722-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7vMLZRVbrLLy4j5D"
Content-Disposition: inline
In-Reply-To: <20251016094748.722-1-caohang@eswincomputing.com>


--7vMLZRVbrLLy4j5D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 05:47:48PM +0800, caohang@eswincomputing.com wrote:
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
> index 000000000000..589a3ab6c644
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
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: cfg
> +      - const: usb_en
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: vaux
> +      - const: usb_rst

Drop the _rst here, since this can't be anything other than a reset.

> +  eswin,hsp-sp-csr:
> +    description:
> +      HSP CSR is to control and get status of different high-speed perip=
herals
> +      (such as Ethernet, USB, SATA, etc.) via register, which can tune
> +      board-level's parameters of PHY, etc.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to HSP Register Controller hsp_sp_csr n=
ode.
> +          - description: USB bus register offset.
> +          - description: AXI low power register offset.

This looks better than before, thanks.

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
> +        clocks =3D <&clock 135>,
> +                 <&clock 136>,
> +                 <&hspcrg 18>;
> +        clock-names =3D "aclk", "cfg", "usb_en";
> +        interrupt-parent =3D <&plic>;
> +        interrupts =3D <85>;
> +        interrupt-names =3D "peripheral";
> +        resets =3D <&reset 84>, <&hspcrg 2>;
> +        reset-names =3D "vaux", "usb_rst";
> +        dr_mode =3D "peripheral";
> +        maximum-speed =3D "high-speed";
> +        phy_type =3D "utmi";

> +        snps,dis_enblslpm_quirk;
> +        snps,dis-u2-freeclk-exists-quirk;
> +        snps,dis_u2_susphy_quirk;
> +        snps,dis-del-phy-power-chg-quirk;
> +        snps,parkmode-disable-ss-quirk;

If any of these "quirks" are required for the device to function
properly, please mark them as required so that they don't ever get left
out. If it is board dependant, that's fine. I'm only interested in what
is set on the SoC level.
If most properties from the common snps binding are not possible, please
use additionalProperties: false and only permit those that are.

pw-bot: changes-requested

> +        eswin,hsp-sp-csr =3D <&hsp_sp_csr 0x800 0x818>;
> +    };
> --=20
> 2.34.1
>=20

--7vMLZRVbrLLy4j5D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPETnwAKCRB4tDGHoIJi
0lE9AP0RYcahckW+TyawV1n5NagY3zGsvVuIM/siZKHv97ZftQD/dvbM5ZVZbXQh
RSVtUQpDVXbOxasrnvFaQpkBkdBnSAE=
=JWPt
-----END PGP SIGNATURE-----

--7vMLZRVbrLLy4j5D--

