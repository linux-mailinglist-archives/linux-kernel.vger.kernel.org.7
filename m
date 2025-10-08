Return-Path: <linux-kernel+bounces-845975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846CBC69D1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E61E404D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241E726E6FD;
	Wed,  8 Oct 2025 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNZRUwTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4B1EB36;
	Wed,  8 Oct 2025 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956804; cv=none; b=eqM1UmHidM4WVxt94+CBvkq7gyRBNL0VdVO6l0OOVtTtqISabIL1rqKxP3k1jrju9kJeCWoiwZRwEkdbsnyoI4iEP6kCRyvib1h+ZR7QlSlFPiw4Lt8HHmkUL92Q34tpFyUAmWqEGRjVb/jX3ClEiNpo03YBcW1BQAy1TJhJ6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956804; c=relaxed/simple;
	bh=kea3RxogjvdILzkpgzWw9gxfFKJCQ1AXuLQYBUx9CRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Psyssz7+gB9wquDKEXif5Gkewh6z88cInhJbBIUm/DS9xZVdk58CSCi2jycKtvmYziYMfZio75g2H2wzisIw/s0+6aWHLO4NeS0bKGTsSp5EmtYz/uODfF8Hls3Lr1S2bdVG14fH/YC45SBcOSjps3ll2h0ly3Nc/KjbJq5bbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNZRUwTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E38C4CEE7;
	Wed,  8 Oct 2025 20:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759956803;
	bh=kea3RxogjvdILzkpgzWw9gxfFKJCQ1AXuLQYBUx9CRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNZRUwTdWwGhsqtnCst4mKL3Yvr3NhMYIU/7hltM7xRZs71ZKgOgc0KlZ2tDUwJT7
	 wnrQgPgy0u3VgxbzXs5y4+1GOTqysPljVKwsYkGEHVGMo110kV91g/aDulcUc9nCiR
	 RIQJo0aEDSKm+FtPlG7o8e7LpgFBZIkz69/KhCbj9gf0g7wCm1ECvurHmm78nMFOpE
	 aXCBzEcQ7QXwg64Lw3LaYILuJJuFlHLOK/aIj6PgoDwowtUf1Ze/QD/8UUiXUJQ5B0
	 Ad8zPQFD0z4LFCHOizNZ0tcXJVCCTd2P3cDQ/VJ0vVMOUCI+zpQnuNLilAHTXr9QZV
	 fzGRcmIL9ahmQ==
Date: Wed, 8 Oct 2025 21:53:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for VBUS
 based on ID state
Message-ID: <20251008-reclusive-cilantro-cafe98a62922@spud>
References: <20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com>
 <20251002172539.586538-2-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O2jSri3ANK3hWGRc"
Content-Disposition: inline
In-Reply-To: <20251002172539.586538-2-krishna.kurapati@oss.qualcomm.com>


--O2jSri3ANK3hWGRc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 10:55:38PM +0530, Krishna Kurapati wrote:
> Update the bindings to support reading ID state and VBUS, as per the
> HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V a=
nd
> asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement th=
at
> VBUS must be at VSafe0V before re-enabling VBUS.
>=20
> Add id-gpios property to describe the input gpio for USB ID pin and vbus-
> supply property to describe the regulator for USB VBUS.

IDK anything about this class of USB device, but I think the binding
patch is acceptable.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/usb/ti,hd3ss3220.yaml       | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml b/Do=
cumentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> index bec1c8047bc0..c869eece39a7 100644
> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> @@ -25,6 +25,19 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  id-gpios:
> +    description:
> +      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS32=
20
> +      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at V=
Safe0V,
> +      the HD3SS3220 will assert ID pin low. This is done to enforce Type=
-C
> +      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
> +
> +    maxItems: 1
> +
> +  vbus-supply:
> +    description: A phandle to the regulator for USB VBUS if needed when =
host
> +      mode or dual role mode is supported.
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      description: OF graph bindings (specified in bindings/graph.txt) tha=
t model
> --=20
> 2.34.1
>=20

--O2jSri3ANK3hWGRc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaObPPgAKCRB4tDGHoIJi
0k4bAPwOmhH3js+ZE10XCEiPUQjV+YFJjF9Xgp/60X3oq7DfNAEAnwxCcKYmCaFt
glEzv5O/+W5lckpMgIxSHozXrlPBVQk=
=wkef
-----END PGP SIGNATURE-----

--O2jSri3ANK3hWGRc--

