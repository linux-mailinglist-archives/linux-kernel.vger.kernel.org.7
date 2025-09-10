Return-Path: <linux-kernel+bounces-809381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A2CB50CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12081BC543B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C475E2BDC14;
	Wed, 10 Sep 2025 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dCt0toIE"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16241F30BB;
	Wed, 10 Sep 2025 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479015; cv=none; b=OOUAFWLDlG4lDwOTIrYESGw9cFc+9bO7cRP0+Bb0rpFDjnGuAs/VoVpdDtVM6it2f4dTJV+81Hgoljm1rT1z6+QxzaXTN9984X4Vw1DTwJ8MMF+++vph1g7YpOBt9RcyOYyFs+XK4bfcwRHMMan8IsW8SeZ0YhjTzvBBk12Uxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479015; c=relaxed/simple;
	bh=DCSqe53vU124q0EwnbujnLc3tmCYahzzL7debzb+XMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrRMU+EoYbsv0T+oeriMZg63rV5AdIerI5GlIWkz+qcm4zPrkDesFJyXhTKpFg+LDr5m/oiCrC0eCtFjhtyIN4opKjyR8I3sYp7q6lC1U3KoOdoMavBy4gonurLGLWU6k03LVf2P7pU3fh16si2LvIc/yCszVb0pmeKEuAUgOew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=dCt0toIE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757479009;
	bh=3GtRQfZzRpEaJz6gHxFx3UzqHniimRMjRVU2+E8zxFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCt0toIEhiLMOYa+t92eUdb4BPoLNw65ACzOOF4QJwQOsYNF47KeucShgFq9d4zPt
	 LRfjfKvpSvS5lMSsiupemlC43pqcGHVzx/mTP4CIoygDzDFgcq4EU6KvbBdanvxDn+
	 2K+D30K+1cF4/9RvAds/FVaY4X0QqMAzy79VHFTifAN+o3EB1jyOkG+kWMAn3hw5tr
	 Jmv9gN4hKqV+xcc5BROrJm69su5tgHeDjoqzHc/j5bBpujsepDPyEcOGJyS8dYyZ0I
	 9u+kN5V+04OIrNDoEfymNuUtAw1WVlfjBZm+0vx6zq3ue/rsEzXdPYjjIDCXejDpnA
	 sZLrSfGEouBtg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cM7FF5zmhz4w1l; Wed, 10 Sep 2025 14:36:49 +1000 (AEST)
Date: Wed, 10 Sep 2025 14:36:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Ayush Singh <ayush@beagleboard.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aMEAXrAC0uEW2sCc@zatzit>
References: <20250902105710.00512c6d@booty>
 <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
 <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com>
 <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com>
 <CAMuHMdVarhTFEhQoYHWCnJp0iWRCjm0wh_ryP73aOdUwVa0X4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2k+m2IrLtKgN7TWa"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVarhTFEhQoYHWCnJp0iWRCjm0wh_ryP73aOdUwVa0X4Q@mail.gmail.com>


--2k+m2IrLtKgN7TWa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 03:04:49PM +0200, Geert Uytterhoeven wrote:
> Hi Herv=E9,
>=20
> On Tue, 9 Sept 2025 at 11:41, Herve Codina <herve.codina@bootlin.com> wro=
te:
> > On Tue, 9 Sep 2025 15:09:18 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > I think that a connector is something with a bunch of resources pro=
vided
> > > > by the board where the connector is soldered. Those resources are w=
ired
> > > > to the connector and defined by the connector pinout.
> > > >
> > > >      3v3   ------- Pin 0
> > > >   i2c_scl  ------- Pin 1
> > > >   i2c_sda  ------- Pin 2
> > > >     gpio A ------- Pin 3
> > > >     gpio B ------- Pin 4
> > > >      gnd   ------- Pin 5
> > > >
> > > > IMHO, this need to be described and defined in the base board and a=
n addon can
> > > > only reference resources wired and described by the connector node.
> > >
> > > Yes, that's exactly what I'm proposing too.
> > >
> > > > Now, questions are:
> > > >   - 1) How to describe a connector?
> > > >   - 2) How to reference resources provided at connector level from =
an add-on?
> > >
> > > Right.
> > >
> > > > Our current approach was:
> > > > ---- base board DT ----
> > > >   connector0 {
> > > >     gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0=
 controller */
> > > >                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpi=
o2 controller */
> > > >         i2c-one {
> > > >             compatible =3D "i2c-bus-extension";
> > > >             i2c-parent =3D <i2c5>; /* i2c-one wired to i2c5 control=
ler */
> > > >     };
> > > >
> > > >     i2c-two {
> > > >             compatible =3D "i2c-bus-extension";
> > > >             i2c-parent =3D <i2c6>; /* i2c-two wired to i2c6 control=
ler */
> > > >     };
> > > >
> > > >     /*
> > > >          * From the addon we need to reference:
> > > >          *    - The connector itself,
> > > >          *    - Maybe some pinctrl related to signals wired to the =
connector,
> > > >          *    - In some cases the i2c bus (HDMI, ddc-i2c-bus =3D <&=
i2c-two>;)
> > > >          *
> > > >          * This was solved introducing the controversial export-sym=
bols node.
> > > >          */
> > >
> > > I think the type of connector should also be named on both sides (with
> > > 'compatible' or something like it).
> >
> > It makes sense.
>=20
> Probably we also want header files under <dt/bindings/...> that define
> the (sole) symbols that are provided by a connector, and can be consumed

Yes.  Connector types should have their own bindings, describing which
symbols are available to things that plug into it.

> by an attached board?  Cfr. C header files defining an API.
> In case of multiple connectors (esp. of the same type), we need to
> specify a prefix before including the header file (see also namespacing
> below).
>=20
> >
> > >
> > > >   };
> > > >
> > > > ---- addon board DT ----
> > > >    {
> > > >     some-node {
> > > >             compatible =3D "foo,bar";
> > > >             reset-gpios =3D <&connector 0>; /* gpio A used as a res=
et gpio */
> > > >             ddc-i2c-bus =3D <&i2c-two>;
> > > >         }
> > > >
> > > >         i2c-one {
> > > >             eeprom@10 {
> > > >                     compatible =3D "baz,eeprom"
> > > >                     reg =3D 10;
> > > >             };
> > > >     };
> > > >    };
> > > >
> > > > The addon board DT can only be applied at a connector node.
> > >
> > > Right.  This is not how overlays work now.  By the nature of how
> > > they're built they apply global updates to the base tree.  That means
> > > we need to spec a new way of describing addons that *is* restricted to
> > > a particular connector slot (or slots, as Geert points out).  Since we
> > > have that opportunity, we should _not_ try to make it a minimal
> > > extension to existing overlay format, but define a new and better
> > > encoding, designed to meet the problems you're looking to address.
> >
> > On the kernel side, overlays can be applied at a specific node.
> > The node is chosen when the overlay is apply.
> >   https://elixir.bootlin.com/linux/v6.16/source/drivers/of/overlay.c#L9=
70
> >
> > This allows to apply an overlay to a specific node without any modifica=
tion
> > of the overlay dtb (dtbo).
>=20
> Which currently supports a single node/connector.
>=20
> > > > > > > 3) bus-reg / bus-ranges
> > > > > > >
> > > > > > > One thing that makes connector plugins a bit awkward is that =
they
> > > > > > > often need to add things to multiple buses on the host system=
 (MMIO &
> > > > > > > i2c for a simple case).  This means that once resolved the pl=
ugin
> > > > > > > isn't neatly a single subtree.  That's one factor making remo=
val
> > > >
> > > > It can be a single subtree if decoupling is present at connector no=
de available
> > > > in the base device tree.
> > >
> > > Right - allowing that decoupling is exactly what I'm proposing bus-reg
> > > for.  Note that the case of an addon that plugs into multiple
> > > connectors that Geert pointed out complicates this again.
> >
> > Geert's use case needs to be clarified.
> >
> > Suppose a base board with 2 connectors:
> >  - connA
> >  - connB
> >
> > Case 1: Addons are independant
> >                +--------+
> >   connA <----> | AddonA |
> >                +--------+
> >                           +--------+
> >   connB <---------------->| AddonB |
> >                           +--------+
> >
> > With addonA and B two addon board each connected at one connector witho=
ut any
> > relationship between addon A and B
> >
> > Case 2: Only one Addons using ressources from both connector
> >
> >                 +------+
> >   connA <-----> |Addon |
> >                 |      |
> >   connB <-----> |      |
> >                 +------+
> >
> > The addon is connected to both connector and uses ressources from connA=
 and
> > connB in a dependent manner.
> >
> >
> > The Case 2 can be solved using a connector that described both connA an=
d connB.
> > Having the split connA and connB is a mechanical point of view.
> >
> > Also adding and Addon on only one part (connA for instance) should not =
be an issue
> > if the connector describe both parts.
> >
> > but well, here again I can miss something.
> > Geert, can you provide details?
>=20
> I think the above describes it well, thanks!
>=20
> However, I am not so fond of having to describe yet another connector
> that contains connA and connB.  E.g. a base board with 6 PMOD connectors
> would need to describe 30 combinations...

And it would mean that the OS can't easily reason about which
connector slots are currently occupied.

> > > > A reference to connector (&connector) from the addon will be resolve
> > > > to a reference to &conn0 (phandle of the connector0 node.
> > >
> > > To handle the addon with multiple connectors we might want an
> > > (optional) remapping / renaming on the addon side as well.  Or maybe
> > > simpler, we could allow namespacing the references on the addon side.
> >
> > I think you talk about the Geert use case.
> > Geert, an example should be welcome.
> >
> > The plan was to apply the DT related to an addon at a connector node.
> > Maybe this will not fit well with Geert's use case but to know if it
> > fits or not and to find the best way to handle this use case, an
> > example is needed.
>=20
> A PMOD Type 2A (expanded SPI) connector provides SPI and 4 GPIOS.
> A PMOD Type 6A (expanded I2C) connector provides I2C and 4 GPIOS.
> Hence a plug-in board that needs SPI, I2C, and a few GPIOs, would need
> to plug into two PMOD connectors.
>=20
> Or:
> A PMOD Type 1A (expanded GPIO) connector provides 8 GPIOS.
> Hence a non-multiplexed dual 7-segment LED display plug-in board needs
> 14 or 16 GPIOS, and thus would plug into two PMOD connectors.
>=20
> To plug into two connectors, a mapping needs to provided between two
> connectors on base and add-on board.
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--2k+m2IrLtKgN7TWa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjBAF0ACgkQzQJF27ox
2GcjsBAAoZqp+3hRaDUzaKOG+3gWob74As9XVDU7lJn+TR0c3Rox6iOMT2rmIfSC
hcxOd+XGmVg+7N7IMF30f3s84fe5d0qBEBbPe5kkiCWaCPjxY9T4k2kHcjJ1Jqwz
sQr0SVNH5YSUMVSFWXrfYdaLVtkZME2rZhI63tqdo7zZGI1Q5yxaROadrVAODFbD
F88Qx02Ef6WDBZO1IhzlLo+btSswF2WCUfIrPmbIzfuIk5w5XEcnNcbrgRVSUPWd
q8eYmSob+zVXAGPIfmzsW9n8YZWXMUiGtsoX5nmQiHlP2UUuJRj6tMUiQynLcT3L
JOqzwQOIFN+A7hZCtSOnAOjKAs6NjJGXUTgD/g7yXj4EtUXXVPIoEpdj1U1WGjxU
j14X+Ko+oeq1ekQ8Sj88Sm12485dMWJ+MHC2oSYFBet6aZ1SIyrOBmny7zdebrbY
XM4nrhn0KayzhOVZA7TOz8E8MVafGj7AceN2CS3X4gKHZH8mnNQAmqBDJ/ZNS5bP
mt33CnRvcfpd49CYcS9KqdqRQxd4HijC84xC5eBb+kgsd4IJs/PGTU6dUuklq/Ay
OcMgFPsZdWDGNzDmlIaNq1VirLR1noygtmH6wAmTaqirunorV3q09fZB5rUyh0+p
ayHhoWNum8cCgh1688115T/vLT2MYnMCI0zFg3E/fv4tMByEcnI=
=RUry
-----END PGP SIGNATURE-----

--2k+m2IrLtKgN7TWa--

