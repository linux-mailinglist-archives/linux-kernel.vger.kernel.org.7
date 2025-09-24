Return-Path: <linux-kernel+bounces-829911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA15FB982E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9968B171A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6985233D9E;
	Wed, 24 Sep 2025 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ISAmdLNH"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579C113B58C;
	Wed, 24 Sep 2025 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687435; cv=none; b=RqGBm1bDMu9b0Kwb2QV2NztibkAgsk4vRlcZh+dEu42D5x0QJ7EZkAH0FLgKf0if/HaMSL6psmHQTk4AMdNtqpOzDvS15Kdca3XPyKOJheCdop8VitRhmnq3by8b/YR1ADeRIpkcVdQZ4PAVtHOWNHC2wOs8IyYK9K7+zW8oWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687435; c=relaxed/simple;
	bh=RcWOriQH3wxqPuV8hyOfl023lGgvyuVAPVJ/Q6kjFl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z59EgFZ/lkuyXNrido0KipXpYMwG8WFMrjimwxsqrei7aYe8w9SL+q7tyK7qlxZ/17qO9wM2acqc6+bTdOSZWO/cDQphzpaxkMch96CYHshuKW11DQt449BDPmekM5SpxD7vUyOFTU1xLRvdAHIkqvIE4WfSva+FBbCbs+8eQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=ISAmdLNH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1758687426;
	bh=ATv45uo5ricw5YDbv1fpXanGdfbAJJwEaGvaVwwd6RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISAmdLNHph9rEE4S7uQ7WntBg9GvtSISOTNwaMcccWAvyY3LwFybWvpxudVKNSTs2
	 IsOdUCq8ckopAT5bi68EjXeB0FKB0sGCaqcF3P0oAUksAZGRqCjFr+OF7ZC5Trn9WJ
	 Csjsy1Ys2heq3yu+vTthuU3A2vSbu9exZBeMxBc/j1kBkFSSVvhDu31Y7bqtttG3N4
	 aUkWjBGQ0WNTU3meiZhW+xwmFSgsRE5TbMLrM7B4JdfKl241a7LqXRaj4Y6bB2QgqE
	 UtGSvDwhcnC6i2nF/pCRRB3Din1LzMrCpOX8fWD3CNmq4qXvC/kHmn/vTZPf49fcjL
	 iOxN4k0R8+QXg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cWk820fl2z4wC8; Wed, 24 Sep 2025 14:17:06 +1000 (AEST)
Date: Wed, 24 Sep 2025 13:54:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Ayush Singh <ayush@beagleboard.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Andrew Davis <afd@ti.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	devicetree@vger.kernel.org, Jason Kridner <jkridner@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aNNrbmZfZU-1xJFm@zatzit>
References: <aMD_qYx4ZEASD9A1@zatzit>
 <20250911104828.48ef2c0e@bootlin.com>
 <aMebXe-yJy34kST8@zatzit>
 <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit>
 <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
 <aNJVqSpdAJzGliNx@zatzit>
 <20250923114849.2385736d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZiW09zn6+nXcT26v"
Content-Disposition: inline
In-Reply-To: <20250923114849.2385736d@bootlin.com>


--ZiW09zn6+nXcT26v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:48:49AM +0200, Herve Codina wrote:
> Hi David,
>=20
> On Tue, 23 Sep 2025 18:09:13 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Sep 19, 2025 at 10:47:17AM +0530, Ayush Singh wrote:
> > > On 9/19/25 10:22, David Gibson wrote:
> > >  =20
> > > > On Thu, Sep 18, 2025 at 09:44:09AM +0200, Herve Codina wrote: =20
> > > > > Hi David,
> > > > >=20
> > > > > On Thu, 18 Sep 2025 13:16:32 +1000
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >=20
> > > > > ...
> > > > >  =20
> > > > > > > > Thoughts above suggest a different direction, but here's wh=
at I was
> > > > > > > > thinking before:
> > > > > > > >=20
> > > > > > > > base board:
> > > > > > > >=20
> > > > > > > > 	connector {
> > > > > > > > 		/export/ "i2c" &i2c0;
> > > > > > > > 	};
> > > > > > > >=20
> > > > > > > > addon:
> > > > > > > > 	eeprom@10 {
> > > > > > > > 		compatible =3D "foo,eeprom";
> > > > > > > > 		bus-reg =3D <&i2c 0x10>;
> > > > > > > > 	}
> > > > > > > >=20
> > > > > > > > Or, if the addon had multiple i2c devices, maybe something =
like:
> > > > > > > >=20
> > > > > > > > 	board-i2c {
> > > > > > > > 		compatible =3D "i2c-simple-bridge";
> > > > > > > > 		bus-ranges =3D <&i2c 0 0x3ff>; /* Whole addr space */
> > > > > > > > 		eeprom@10 {
> > > > > > > > 			compatible =3D "foo,eeprom";
> > > > > > > > 			reg =3D <0x10>;
> > > > > > > > 		}
> > > > > > > > 		widget@20 {
> > > > > > > > 			compatible =3D "vendor,widget";
> > > > > > > > 			reg =3D <0x20>;
> > > > > > > > 		}
> > > > > > > > 	}
> > > > > > > >=20
> > > > > > > > Writing that, I realise I2C introduces some complications f=
or this.
> > > > > > > > Because it has #size-cells =3D <0>, ranges doesn't really w=
ork (without
> > > > > > > > listing every single address to be translated).  Likewise, =
because we
> > > > > > > > always need the parent bus phandle, we can't use the trick =
of an empty
> > > > > > > > 'ranges' to mean an identity mapping.
> > > > > > > >=20
> > > > > > > > We could invent encodings to address those, but given the a=
ddon with
> > > > > > > > multiple connectors case provides another incentive for a s=
ingle
> > > > > > > > connector to allow adding nodes in multiple (but strictly e=
numerated)
> > > > > > > > places in the base device tree provides a better approach. =
=20
> > > > > > > and the "place in base device tree" is the goal of the extens=
ion bus.
> > > > > > >=20
> > > > > > > The strict enumeration of nodes enumerated is done by two mea=
ns:
> > > > > > >   - extension busses at connector level
> > > > > > >     Those extensions are described as connector sub-nodes.
> > > > > > >     The addon DT can only add nodes in those sub-nodes to des=
cribe devices
> > > > > > >     connected to the relared extension bus.
> > > > > > >   - export symbols
> > > > > > >     An addon DT can only use symbols exported to reference sy=
mbols outside
> > > > > > >     the addon DT itself.
> > > > > > >=20
> > > > > > > Can I assume that bus extensions we proposed (i2c-bus-extensi=
on and
> > > > > > > spi-bus-extension) could be a correct solution ? =20
> > > > > > Maybe?  I prefer the idea of a universal mechanism, not one tha=
t's
> > > > > > defined per-bus-type.
> > > > > >=20
> > > > > >=20
> > > > > > Also, IIUC the way bus extension operates is a bit different - =
nodes
> > > > > > would be "physically" added under the bus extension node, but t=
reated
> > > > > > logically as if they go under the main bus.  What I'm proposing=
 here
> > > > > > is something at the actualy overlay application layer that allo=
ws
> > > > > > nodes to be added to different parts of the base device tree - =
so you
> > > > > > could add your i2c device under the main i2c bus. =20
> > > > > I think we should avoid this kind of node dispatching here and th=
ere in
> > > > > the base DT. =20
> > > > Until I saw Geert's multi-connector case, I would have agreed.  That
> > > > case makes me thing differently: in order to support that case we
> > > > already have to handle adding information in multiple places (under
> > > > all of the connectors the addon uses).  Given we have to handle that
> > > > anyway, I wonder if it makes more sense to lean into that, and allow
> > > > updates to multiple (strictly enumerated) places. =20
> > >=20
> > > Well, I don't love this idea. Here are my main qalms about the approa=
ch of
> > > adding devices directly to the actual i2c/spi etc nodes.
> > >=20
> > > 1. In boards with multiple connectors, they sometimes share the same =
i2c.
> > > Now assume that someone decided to connect the same i2c device to bot=
h the
> > > connectors. If we are using something like bus extension, while the n=
ode
> > > would be added, it will fail in the registration since you cannot add=
 the
> > > same address device a second time. However, if we are adding the devi=
ce
> > > directly to the `main_i2c`, the overlay application will just end up
> > > modifying the exact same device node. There is no error, or even a 2nd
> > > device node in this case. It is just lost.
> > >=20
> > > 2. How well will overlay adding and removing work when the same tree =
nodes
> > > are modified by multiple connectors? I have not looked at the interna=
ls of
> > > overlay resolution so not sure, but I don't want dynamic addition and
> > > removal of devices in independent connectors to somehow become couple=
d. =20
> >=20
> > Ah, right.  To be clear: we absolutely don't want multiple addons
> > altering the same nodes.  But I think we could do that in ways other
> > than putting everything under a connector.  This is exactly why I
> > think we should think this through as an end-to-end problem, rather
> > trying to do it as a tweak to the existing (crap) overlay system.
> >=20
> > So, if we're thinking of this as an entirely new way of updating the
> > base dt - not "an overlay" - we can decide on the rules to ensure that
> > addition and removal is sane.  Two obvious ones I think we should
> > definitely have are:
> >=20
> > a) Addons can only add completely new nodes, never modify existing
> >    ones.  This means that whatever addons are present at runtime,
> >    every node has a single well defined owner (either base board or
> >    addon).
>=20
> In this rule I suppose that "never modify existing ones" should be unders=
tood
> as "never modify, add or remove properties in existing ones". Because, of=
 course
> adding a full node in a existing one is allowed (rule b).

Yes, that's what I meant.  I'd add never delete subnodes as well. on
add.  Remove obviously would delete subnodes, but only exactly the
ones that were added on add.

> > b) Addons can only add nodes in places that are explicitly allowed by
> >    the connectors they're connecting to.
>=20
> I fully agree with those both a) and b) rules.
>=20
> >=20
> > We could consider further rules as well though.  For example, we could
> > say that i2c devices in an addon shouldn't be added directly under the
> > base board's i2c controller, but under a subnode of that i2c
> > controller assigned to that connector (which would likely have an
> > empty 'ranges' property meaning addresses are mapped without
> > translation).  Not really sure if that rule has more benefits or
> > drawbacks, but it's worth contemplating.
>=20
> IMHO, no extra rules are needed in DT addon rules to constraint i2c devic=
es
> to be added in a connector node, a connector sub-node or an i2c controller
> node.
>=20
> This will be constrained by the connector itself (out of DT addon rules).

At this point I'm just considering the end-to-end rules we want to
enforce.  Exactly what stage of the process enforces each rule is
another question.

> I mean, according to rule b), the connector will allow some destination
> places. Either it will allow the i2c controller node or a connector sub-n=
ode.

Sure.

> This is specific to the connector definition and it should be out of
> generic DT addon rules.

Hang on... what distinction are you seeing between the "connector
definition" and "generic DT addon rules".  As I see it we're trying to
create a protocol that defines both the base rules and what a
"connector" even means.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--ZiW09zn6+nXcT26v
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjTa20ACgkQzQJF27ox
2GflpA/+NrMe97p2QgiD6kBVWD1K8pxYlD7kMeWjmtyqH6CvqujxhrrMOGtmWBQg
RjHVkLGhSd7HGHp8vYRwHwc9N3RypZi3B3RB0KDLiIyS56fHJSsvQY614a3Rl2V8
upEnD/N0JxvPr1vbv96oEnJKzkizyozy9DFJdPn/TGcZrv21kY71lAOaT5b8rRzb
y2N39fSTHCHKrSLk4UgvSeMyndBnEbznQxHhmjlpmgpWn9yPUtB3G47fMWd/I0VT
BxbEkNkxT+96gf7d6UAZOmTVZBQqBZVDiPANMu7sU770pknKTOhMN6NXslfGnG09
Z61mGw0QVWOa3DR0irl+L6u2WymmifoaCg/GjdamoVELuZO23Ok/hHRniTomj0OL
WLoKbmVfb3r57393rvwG1qYrTDWeBAdYIK1Xxi1v+MnEGXfY1czB0NxbGS0GHoP/
5VrU4CCvIC4XakCPUpuwBiAPITSyzzhrAyfxTCY8RUxL4tz95sKWJZFCHcn+AtLV
P2iiZsVTSPG4d4EWDzU+QutbaSME2v6P+qpFGBXOTV9ZnEI+Njw+ci+sAVNnOCax
0tlq3cjNnH4R16UCaxRIRudZjfj3LURN3SpLwydfUiwUpSAyWbovAFA5ReELVW/h
das4aPjq774lnCY/JQwSm0QO7l54LD5HKxRR1yAdeiYjd7r+guw=
=/PM3
-----END PGP SIGNATURE-----

--ZiW09zn6+nXcT26v--

