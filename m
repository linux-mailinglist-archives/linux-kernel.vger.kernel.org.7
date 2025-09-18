Return-Path: <linux-kernel+bounces-821972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872CFB82BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CE54A3A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B31E25FA;
	Thu, 18 Sep 2025 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eIWRYgd2"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A9221F24;
	Thu, 18 Sep 2025 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165405; cv=none; b=bniobc+9ccRH3TJ9WMle0DYud4guaCzpSvy85RLRQIEN/Hx2tE5czk8m7vhxP81QT6uRPbyC/vI+Q6evlR7W10nJqclrUaAhAP/U0pitf/2FmoeTb1qyyjAoI9CRr93z0lQWUWw+ddJDzHyyNl4G+igxkkCGvQMJ4ZBZodVUleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165405; c=relaxed/simple;
	bh=t7mLH00i2aiejS9j+DNGKRtg0iPWiCcMyYOL0UCancg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFXjQQFwZuP6cioFhwauO/cGUsNRCakxtV4DIk3PH6Gm3mGeH6kINevQpf4eFzAnpO4AaBFNWlt5gcNO8WYaw5/n+Ag+Rz3ZXpOIFuvZ5T1SN0okD418ZCdhpWrl9oPDj030lhR4/ulTxrnxqQaPSxulaql7AQYeYdRQrQyWMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=eIWRYgd2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1758165398;
	bh=n9rNU5NXlpiY60spRn7+pZfs6Uja27FRWabDOI4lohg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIWRYgd29YeUf0K0jArGQv1OpA/2gQST51JiI+Xh/kXrAuM/YMx3Rk3rot1Fd8AHQ
	 uud8wrrNRVzJ6dnHwXxKajXiUp0GlTNR/GJwAy0c0jra9fbAt+V//BzgsdjOzBBwMx
	 AbyQ+omzXO33RimDOMqVNpmdNBLKQFPZqh3nC9AttGqxeJ5GeAMDhjgWhS5yDP/BKO
	 jXxH1C3GPr262XspNALHIt2LEUnMxHSE9C+DkAtk7hzX+J+jS4qSKo5bGCbO2F3bfe
	 vPC6DtPYUYEj+HI6s4DFDvC5w4yVYHAoCDuJ3AHi2GMuOBjn83RwCfVEGq/o2Pcgyv
	 K1OFvw4eTK07A==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cS1522D5nz4wB1; Thu, 18 Sep 2025 13:16:38 +1000 (AEST)
Date: Thu, 18 Sep 2025 13:16:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Ayush Singh <ayush@beagleboard.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Davis <afd@ti.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aMt5kEI_WRDOf-Hw@zatzit>
References: <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
 <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com>
 <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com>
 <aMD_qYx4ZEASD9A1@zatzit>
 <20250911104828.48ef2c0e@bootlin.com>
 <aMebXe-yJy34kST8@zatzit>
 <20250916084631.77127e29@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eK7/A4DDKDyUHle1"
Content-Disposition: inline
In-Reply-To: <20250916084631.77127e29@bootlin.com>


--eK7/A4DDKDyUHle1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 08:46:31AM +0200, Herve Codina wrote:
> Hi David,
>=20
> +CC Wolfram
>=20
> On Mon, 15 Sep 2025 14:51:41 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Sep 11, 2025 at 10:48:28AM +0200, Herve Codina wrote:
[snip]
> > > I have the feeling that the choice of physical connectors to which th=
e addon
> > > board is connected to is a human choice when the board is connected. =
=20
> >=20
> > Yes.  Although if the addons have an EEPROM, or some other sort of ID
> > register, it may be possible for some connector drivers to probe this.
>=20
> Right, I think we agree that a driver is needed to help in the mapping at
> least when multiple connectors are involved.

Yes.  Although it's likely this could be handled by a single, trivial
driver for cases where there's nothing probeable and you just rely on
being told the right thing by the user.  This is kind of the connector
equivalent of "simple-bus".

[snip]
> > Thoughts above suggest a different direction, but here's what I was
> > thinking before:
> >=20
> > base board:
> >=20
> > 	connector {
> > 		/export/ "i2c" &i2c0;
> > 	};
> >=20
> > addon:
> > 	eeprom@10 {
> > 		compatible =3D "foo,eeprom";
> > 		bus-reg =3D <&i2c 0x10>;
> > 	}
> >=20
> > Or, if the addon had multiple i2c devices, maybe something like:
> >=20
> > 	board-i2c {
> > 		compatible =3D "i2c-simple-bridge";
> > 		bus-ranges =3D <&i2c 0 0x3ff>; /* Whole addr space */
> > 		eeprom@10 {
> > 			compatible =3D "foo,eeprom";
> > 			reg =3D <0x10>;
> > 		}
> > 		widget@20 {
> > 			compatible =3D "vendor,widget";
> > 			reg =3D <0x20>;
> > 		}
> > 	}
> >=20
> > Writing that, I realise I2C introduces some complications for this.
> > Because it has #size-cells =3D <0>, ranges doesn't really work (without
> > listing every single address to be translated).  Likewise, because we
> > always need the parent bus phandle, we can't use the trick of an empty
> > 'ranges' to mean an identity mapping.
> >=20
> > We could invent encodings to address those, but given the addon with
> > multiple connectors case provides another incentive for a single
> > connector to allow adding nodes in multiple (but strictly enumerated)
> > places in the base device tree provides a better approach.
>=20
> and the "place in base device tree" is the goal of the extension bus.
>=20
> The strict enumeration of nodes enumerated is done by two means:
>  - extension busses at connector level
>    Those extensions are described as connector sub-nodes.
>    The addon DT can only add nodes in those sub-nodes to describe devices
>    connected to the relared extension bus.
>  - export symbols
>    An addon DT can only use symbols exported to reference symbols outside
>    the addon DT itself.
>=20
> Can I assume that bus extensions we proposed (i2c-bus-extension and
> spi-bus-extension) could be a correct solution ?

Maybe?  I prefer the idea of a universal mechanism, not one that's
defined per-bus-type.


Also, IIUC the way bus extension operates is a bit different - nodes
would be "physically" added under the bus extension node, but treated
logically as if they go under the main bus.  What I'm proposing here
is something at the actualy overlay application layer that allows
nodes to be added to different parts of the base device tree - so you
could add your i2c device under the main i2c bus.

That approach does complicate removal, but its not as bad as overlays
at the moment, because a) it could be limited to adding new nodes, not
modifying existing ones and b) the connector would specify exactly the
places that additions are allowed.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--eK7/A4DDKDyUHle1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjLeY8ACgkQzQJF27ox
2GfLnQ//aL2zBwNsdL6Pt1LINGg0apRypnqJml52TNFjhvTkDFCWqsdkXwtkfLmP
JWDXTzMQxP+SOYyZhQevy5CYezuc2G0kHkrXVVXNL/ZNQpZPgEJ3ePhihATWbGYp
ATEhFyPwevYQ8swmlhEZ/I+JPenf0BPgDt+cjuz+wam/LizFbnNqYhq5KQ8WNVqG
5xf1SBXa3QIkJf2Z+/l1iMowbHPq8JAee5Dt2DYfxSkSSbND4+wiugiUbyG+nvZB
XLhOGAu/PjLBDXxV4DzOMBs7YYLoo/kc3Ou2Fdz3+4sINQLzXdYMCC8bxxiCDtUi
zNZ+nkpa5DHw6Ggv7WCGurhT3vZPhnN2CT2XUo/sLNJzOc5MVvxm0XQVmHjT9SEw
HezNev/sclWp73hg5TrdXeMID2qlo5lXgQlQQ6TQK5YnxoprzFBwMZ+VL8dntACe
Qc4ErVww388b6nbQuUw5nOO7vs1PReVLeKzv2i93qj+f7xUb/SIX6+w2UtvceXWP
t51EFDF3D8Z9DpAX69GGs73MjejMkXPdFoJiyyd/oiYdWmZeWrLL185pXJphz0kV
eySvVq9LTovKn725Z2qTUEq1El1ALhJRgqVuZa+DT+SWQJejpuHyMBFPEHTbhOak
6I9AGQCgqFcveg8e8dY0cnTbVy2oSk6H3J8lkpNie+CZkVb4f14=
=2VAy
-----END PGP SIGNATURE-----

--eK7/A4DDKDyUHle1--

