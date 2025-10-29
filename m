Return-Path: <linux-kernel+bounces-877244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE36C1D8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C22E14E3CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C82DF143;
	Wed, 29 Oct 2025 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY126+3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254052BD02A;
	Wed, 29 Oct 2025 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761775246; cv=none; b=ecEQrJIkum1JpCllUC4BUC9i0il0f/h5Oscn6MpfMopP3MNJa1pD/XD5C9xwzHQYGiOki4bE2Jgh5YeQJlCTG6hrgMvjb3ebvzxSfwdXvMKkeWzmgz2yi7tYvvUNVgax6m07tDCP/EhitAth8RQFvaRmH/xsAR1/YfLTxTvHQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761775246; c=relaxed/simple;
	bh=UG+4fuONeRQ1cWoSjwr1LIBK1O3GDDB5HHs82pgfiUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6nECdCkLitc4+AdQlbdd7Q36U35D0IkkbaJcYqcLHmH1YIEg6tGWBG+ZzdGCnRzBiLz2AM7g/AjXt525UOR6evduRUOwa/894flmavdfyShzIqLnxmizzvKK1cqflsLcgBSo8AuTphCILwO71ohSNbcm+4XD3MOFa3dLjiBmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY126+3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BCEC4CEF7;
	Wed, 29 Oct 2025 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761775245;
	bh=UG+4fuONeRQ1cWoSjwr1LIBK1O3GDDB5HHs82pgfiUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IY126+3SPFu6FCODz0mLrFkM7Jl2I9jrtyiLAw5BSTDZE7Uk3Yr/nMtiAfeT9KC6W
	 YoXLqm3eBizTLGO/boLUg3tJyPPlQT08cyNVgm8CiygWT2LY2XXlwGN0fUqUIzASJE
	 AfMOtjSRSbXvs9sWyNqBZjLpDKVgar8wvm0tTpaHuWzRxC1VUM6Nqb7/mPIALgyJOK
	 Xrck9iWLQyrxe1DUEc/JRmlYSzvcBqv3ijM3PKoN4y2lOvfGsnBOPprJROBEPLN4w6
	 AYcqVsByb2QmsfGZzhdZbEAZ1eXXZvGSjP6TTh5ZqGVpo7oBoscQ7qTaPPa36j7TWI
	 SS46edb6z2qWA==
Date: Wed, 29 Oct 2025 22:00:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: introduce no-auto-mmio
 property for syscons
Message-ID: <20251029-bleep-decipher-33b22f06b588@spud>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>
 <20251029-ambiance-snooper-43dc00dcee68@spud>
 <aQJR36s0cY34cLrr@stanley.mountain>
 <20251029-embroider-plunging-6356f50c7acd@spud>
 <aQJhTbNJkezeipoc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikLWM3FwB708GUxA"
Content-Disposition: inline
In-Reply-To: <aQJhTbNJkezeipoc@stanley.mountain>


--ikLWM3FwB708GUxA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 09:47:41PM +0300, Dan Carpenter wrote:
> On Wed, Oct 29, 2025 at 06:37:26PM +0000, Conor Dooley wrote:
> > On Wed, Oct 29, 2025 at 08:41:51PM +0300, Dan Carpenter wrote:
> > > On Wed, Oct 29, 2025 at 05:33:48PM +0000, Conor Dooley wrote:
> > > > On Wed, Oct 29, 2025 at 08:27:05PM +0300, Dan Carpenter wrote:
> > > > > Generally, syscons are created automatically and accessed direclt=
y via
> > > > > MMIO however sometimes syscons might only be accessible from the =
secure
> > > > > partition or through SCMI etc.  Introduce the no-auto-mmio proper=
ty to
> > > > > tell the operating system that the syscon needs to be handled man=
ually.
> > > >=20
> > > > "System controller node represents a register region containing a s=
et
> > > > of miscellaneous registers."
> > > >=20
> > > > If this isn't actually a register region, but is instead an interfa=
ce
> > > > provided by SCMI or whatever "secure partition" is (optee?), why is=
 the
> > > > syscon compatible being used for the device in the first place?
> > >=20
> > > In the case that I'm looking at, it really is a syscon.  So right now
> > > we're upstreaming it and it's an MMIO syscon.  Very straight forward.
> > > But later, I guess, they want to have a new firmware which will only =
let
> > > you access the same registers through SCMI.
> >=20
> > When the programming model changes, the compatible should too, no?
> >=20
>=20
> I wasn't planning on it.  I haven't been asked to upstream the SCMI
> module but once my thinking was the transition would work like this.
>=20
> Step 1: It would work as is with an MMIO syscon.
> Step 2: We would upstream the SCMI driver which would provide an
>         MMIO syscon as a fallback.  At that stage you would still get an
>         MMIO yscon regardless of whether the phandle was parsed before
>         or after the driver loaded.

I don't understand what step 2 even buys you here. It just seems like a
pain where you are going to have to serialise access to the register
region between two mechanisms, which is ultimately pointless if MMIO
access is permitted and you can just use that still without making a
driver change at all. Alternatively, if you're presenting the device
as a custom regmap like the samsung pmu, and can just redirect every
access into SCMI and not use MMIO at all?
The only way your stage 2 makes sense to me is, if, when you talk
about upstreaming an SCMI driver, you mean upstreaming a driver to
?an/the? SCMI project and linux wouldn't actually change during the
step at all.

> Step 3: We would set the no-auto-mmio property so you have to use the
>         driver and update the firmware so only the SCMI interface can
>         be used.

If you're going to have to change the devicetree to add this property
when the special firmware comes around and the old programming model
becomes invalid, why not just change the compatible while you're at
it? I just don't understand the reluctance to use different compatibles
for different programming models.

If the device is no longer MMIO, the reg property is not going to be
accurate anymore either, and then you have to remove the node from the
soc@foo bus to avoid warnings due to having no reg property. With both
of those changes you're looking at a pretty different device node, even
without changing the compatible.

Additionally, I don't think the property name actually reflects what it
means. "no-auto-mmio" is a direct reference to linux driver registration
implementation detail, but actually no MMIO access is even going to be
permitted at all!

Cheers,
Conor.

--ikLWM3FwB708GUxA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQKOiQAKCRB4tDGHoIJi
0rLNAP9+VIEOo+kw/fdn4o62hVLh+VuQJLwaD/v9RmbcpjRKgAEAzvyLgoBHH0Ww
iKZqTjCtc+9LUp75G9gMvgshPY8yhQY=
=KQnu
-----END PGP SIGNATURE-----

--ikLWM3FwB708GUxA--

