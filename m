Return-Path: <linux-kernel+bounces-831066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBDEB9B691
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF1CB4E2CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997F531AF1F;
	Wed, 24 Sep 2025 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ket5LCst"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB18834;
	Wed, 24 Sep 2025 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737551; cv=none; b=F9/unuBYiA2wdhqaDnG8sUL1sXhzaS5ptxSsk9Gv5cdrpAJs3GiifFPDYzXNOFOkyXAUnjvs1GzL1Di6VMpuX6CThwLBmWfb2H/YEPqmtQ+yBL8OOaAvSlJX1TorRiSt5wi2KSi6McaaMLhQPAEXDI7t4UrnUekNg6yrDKHVAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737551; c=relaxed/simple;
	bh=6dDbYpQP6T/0n8IAMUokSSIc5xXEzkd5WFxEOz4V55U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ2q4yDHOBhbUvayjSecpcTSfx8sa4w9HbS8Dspvek3nRCYLc5DdtV6UTlHSxVQ5XT+ITvjqpqksfJVYjdqxItl6EdW00vcTrGobinIPXrKJYIVRGq/dSMGHeyZp3qKuFqT3MVr8HBfCLmzz71auQMAXM5aMTa2CbU28N+Zee3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ket5LCst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B61C4CEE7;
	Wed, 24 Sep 2025 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737550;
	bh=6dDbYpQP6T/0n8IAMUokSSIc5xXEzkd5WFxEOz4V55U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ket5LCstjqCM5F13NeFkxwP4RH2Mj6jlmkmj0XBwZ/0gDL5K/EnqRvRNqEzSSORkA
	 ufOiUs1Ylf2UsfnUHtVDUM20gaIxDgpRKTfvpRd+uiMTRof9rROnfNgo/5gD5DhmVg
	 UzEd1DIxp8i/Cs/UlKwOzSAdSGLrpXuao8feQLzt74p5sp3iC3iydwXdStUSDZM8+o
	 me8x05l0FzlxfyKbKmMptDZovNN9vWhBvSC6Ex7Jc9s6owjHcwQJJAJg3j7P+CDCja
	 A/owZPs8CeCMr96Nh5nGHKuKpLUtCvw/crQ40GA9feAZhRkCrI6Jr6L6yzdMrn5PQK
	 shaKU0gJOmqmw==
Date: Wed, 24 Sep 2025 19:12:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: tmp102: Add TMP110 and TMP113
 devices
Message-ID: <20250924-grievance-crisply-8c7da95946f1@spud>
References: <20250915170819.126668-1-flaviu.nistor@gmail.com>
 <20250915-undefined-woozy-15e27ca89a36@spud>
 <5162f7ae-b822-40fc-a966-c7684e5c0997@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="468pvhp9s/gR/UwA"
Content-Disposition: inline
In-Reply-To: <5162f7ae-b822-40fc-a966-c7684e5c0997@roeck-us.net>


--468pvhp9s/gR/UwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 08:55:39AM -0700, Guenter Roeck wrote:
> On 9/15/25 10:18, Conor Dooley wrote:
> > On Mon, Sep 15, 2025 at 08:08:18PM +0300, Flaviu Nistor wrote:
> > > Add a compatible string for TMP110 and TMP113 devices.
> > >=20
> > > Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> > > ---
> > >   Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b=
/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> > > index 96b2e4969f78..840b5306a8cf 100644
> > > --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> > > +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> > > @@ -13,6 +13,8 @@ properties:
> > >     compatible:
> > >       enum:
> > >         - ti,tmp102
> > > +      - ti,tmp110
> > > +      - ti,tmp113
> >=20
> > The driver has no match data and no compatible based decisions added in
> > your patch. Why is a fallback to tmp102 not suitable?
> >=20
>=20
> That should work for tmp110. However, tmp113 does have additional registe=
rs, and it
> might be desirable to report the content of those using debugfs. Fallback=
 for that chip
> would work for now, but that might have to change later if support for th=
e additional
> registers is added to the driver.

In that case, only the driver would need to change not the binding.
That's fine though, of course.

>=20
> Guenter
>=20
> > >     interrupts:
> > >       maxItems: 1
> > > --=20
> > > 2.43.0
> > >=20
>=20

--468pvhp9s/gR/UwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNQ0igAKCRB4tDGHoIJi
0tIUAP0X5O3QVtQDBxV4sIeXgW5usGnwSQmNclcdcOL/uzKrVwEAm0FHHk2tKCJm
Xdc98UZ+W5onAap3uYDyZw1axg9ikwo=
=fGDx
-----END PGP SIGNATURE-----

--468pvhp9s/gR/UwA--

