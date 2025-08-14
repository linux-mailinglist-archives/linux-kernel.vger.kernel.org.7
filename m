Return-Path: <linux-kernel+bounces-769560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF76B27057
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444BA5C0A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC4272E5D;
	Thu, 14 Aug 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyljDCIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DA26FA46;
	Thu, 14 Aug 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204476; cv=none; b=YqYbZEeJ839OvBWtlIiJA40bSnA4M1yJzX7SzR2wSxst6yds8RT+7AO7QlP+sTfvG2ggJ3EqGD2qfNIxIjWH9c4O0vP+YVue0kA8+oaWZv/kleQdlHAOfNZFSGk8Fjnw5/+Xr/eN1gDeese35r/UgRevnRFnIr5Ihjvo0iTMZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204476; c=relaxed/simple;
	bh=dW2X3K+YNEEybIjB/hvQn0QPs5bkqXpod+RF3HGN1Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNo+ceVhaxlRrLwbhU5aUWnpNUT8kWnCdlcCsJykzLNV0ac42QYBVNmFGal4aQXIHXmtQ+HGl0ngAdL3Vtrwd6p4lvxpYagyEAt44gwz9ew/jewJkmA4BAPr8bFJDY7L39KZ521QFbHDuMpLCw7dm127oVrfl1ujap3yl6Vp7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyljDCIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ACCC4CEED;
	Thu, 14 Aug 2025 20:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755204476;
	bh=dW2X3K+YNEEybIjB/hvQn0QPs5bkqXpod+RF3HGN1Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyljDCInxy4DZe5+LqOU5BtQaF5XM9gDosYxRaa9juQwUuvcrW1FvamJ6xPGg91DD
	 fUXRlTttT3XiiH9eSF4b10REomGxBctST+vQl/x/jXBHI5hWswt2LY+nAp+Ik82kRx
	 acWzZcsFBNLk6/krrevxXoKhaz3je3+uqoNuqT3eB6iUyUANeU2XLgytpA53nl8ofM
	 744IpUoHWzklkEkIxDQopORQmjQ7MYWLp7Joh58cLQ5n/9GvAMSVh+eMzSOwJLgxwh
	 2f3A30uAwiyXH7koz6bjOMpq47yhcxWqS7lcSmHdS1ZoCp2//pnxNfolysQfhT6z2o
	 x2pH/NAwuISgA==
Date: Thu, 14 Aug 2025 21:47:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Heidelberg <m.heidelberg@cab.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Eggers <ceggers@arri.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jiri Prchal <jiri.prchal@aksignal.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: eeprom: at25: use "size" for FRAMs
 without device ID
Message-ID: <20250814-platinum-imminent-43a126e82871@spud>
References: <20250814111546.617131-1-m.heidelberg@cab.de>
 <20250814111546.617131-2-m.heidelberg@cab.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2bYXlAxP2do4p8E"
Content-Disposition: inline
In-Reply-To: <20250814111546.617131-2-m.heidelberg@cab.de>


--t2bYXlAxP2do4p8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 01:15:30PM +0200, Markus Heidelberg wrote:
> Link: https://lore.kernel.org/all/20250401133148.38330-1-m.heidelberg@cab=
=2Ede/
> Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>

Missing commit message body explaining why this change is needed.

> ---
>  Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documen=
tation/devicetree/bindings/eeprom/at25.yaml
> index c31e5e719525..d6fe84091ad4 100644
> --- a/Documentation/devicetree/bindings/eeprom/at25.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
> @@ -56,6 +56,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        Total eeprom size in bytes.
> +      Also used for FRAMs without device ID where the size cannot be det=
ected.
> =20
>    address-width:
>      $ref: /schemas/types.yaml#/definitions/uint32
> --=20
> 2.43.0
>=20

--t2bYXlAxP2do4p8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJ5LdwAKCRB4tDGHoIJi
0jQSAP426ncFjNObVwHIFLzAYrq15xnNP9fneSFS5jCBOx/spwD+JhnOgosXTbLH
2sybJAZUGxRtdwDVPEZpf1tg3JKzVgw=
=bsl9
-----END PGP SIGNATURE-----

--t2bYXlAxP2do4p8E--

