Return-Path: <linux-kernel+bounces-823201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19466B85C72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D7E1749AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C231355A;
	Thu, 18 Sep 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QctwkPXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885AC30FF2E;
	Thu, 18 Sep 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210536; cv=none; b=FaoTdoANx82iIK7dZNl3cw/85QlQ6XmJKIHrDqNal5elt6gvi9gUYVZcW0A/oKUuRfuHs+eG64rgbKYUj+yDElvP0aeHLFHLg8Ua0pKO1KpwV8ayyvVZpqtOYXY+5wF9/L8FMSvyAj29ZF2Y3zOz5866fwyT6yHEizO6GMGc6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210536; c=relaxed/simple;
	bh=nhdHKFO5bR2X2/D/hMT1di3VRboSYDncxCVlGCDhYws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWqkOGXZ1lT32c6JjOPB2eDpkV3oNAvrTjXazkee5LevPYHut7clzNHecC+U0XsbA5bj39anzUUmz8EUMHAxxsQUHhQRCgq4ZmvIB3oYePy8NdoBTWqJie1byNfhmC+NecAWjM7pYniuU4R2wpDOYcjiJVLZhZVwrA1SYhqzgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QctwkPXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A1EC4CEE7;
	Thu, 18 Sep 2025 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758210536;
	bh=nhdHKFO5bR2X2/D/hMT1di3VRboSYDncxCVlGCDhYws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QctwkPXgZezc5Uo0p1TcUvL7QB0Sc82tqkeG3pnWMZM+eSrBlp+itzVXFN9zJxO5H
	 p8LB4kSiNTjMTUymK1ItQx5yb2NhQycUIH66QUAoHTDAX5OtUBnbojCYQ3h2EnZaF4
	 zt2tTNcv8isdLiHzt8NVKJuGwBhwTcQcZozCs/sEh0uI4N+CmZu074qQqyjVOH051M
	 /BOUUCzD2v0jkhoENdU80q7Q2bVbdkaSJfEoQ0zrW9gx38a0wczqPOj/wY8fOZ7tH5
	 /QmtCAQChpY9iSvAgTjl9La62Ca5MiFuVQtmbpBL5PrP/DEf9l1Xy4P2YRW3X2hy7p
	 5Giv6O+Iq4a2g==
Date: Thu, 18 Sep 2025 16:48:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Durai Manickam KR <durai.manickamkr@microchip.com>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	balamanikandan.gunasundar@microchip.com,
	nicolas.ferre@microchip.com
Subject: Re: [PATCH 4/4] ARM: dts: microchip: add I3C controller
Message-ID: <20250918-award-cursor-d564edf710e0@spud>
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
 <20250918095429.232710-5-durai.manickamkr@microchip.com>
 <aMwoxsACdicpAFup@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w1hi8Aenph44Z7K4"
Content-Disposition: inline
In-Reply-To: <aMwoxsACdicpAFup@lizhi-Precision-Tower-5810>


--w1hi8Aenph44Z7K4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:44:06AM -0400, Frank Li wrote:
> On Thu, Sep 18, 2025 at 03:24:29PM +0530, Durai Manickam KR wrote:
> > Add I3C controller for sama7d65 SoC.
> >
> > Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> > ---
> >  arch/arm/boot/dts/microchip/sama7d65.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/=
dts/microchip/sama7d65.dtsi
> > index c191acc2c89f..3a5da27f7d83 100644
> > --- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
> > +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> > @@ -721,5 +721,17 @@ gic: interrupt-controller@e8c11000 {
> >  			#address-cells =3D <0>;
> >  			interrupt-controller;
> >  		};
> > +
> > +		i3c: i3c@e9000000 {
> > +			compatible =3D "mchp,sama7d65-i3c-hci";
>=20
> Need update binding doc for "mchp,sama7d65-i3c-hci"

"mchp" isn't even a valid vendor prefix. It's not acceptable for a v2 to
be like this after the feedback on v1.

--w1hi8Aenph44Z7K4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMwp4wAKCRB4tDGHoIJi
0hTeAQDnpMlsIfqKchO9c7i8p0jUcVfWOYT6zlgMmGj5JLJ9DwD/Qi/0BsK8n1i2
ti7cdxLs5npgg3H7zlwDkBth5D0+2w8=
=IrZi
-----END PGP SIGNATURE-----

--w1hi8Aenph44Z7K4--

