Return-Path: <linux-kernel+bounces-828579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF246B94EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FFE1903956
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154F318138;
	Tue, 23 Sep 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="uc6Dur1F"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91F265CAD;
	Tue, 23 Sep 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614972; cv=none; b=DvTT1WzEJd92lgHcDeoGwzI8YrYQ1HcwQ1KP68Uijf8uEV+MH/vUy4/Ewa/DlH4OdAvOr8E05yq+FKU4GhcJOp62nKYFcXZZWMwsrdjU26aV1EN0uM7gIj5A88LrluYFKa9bo59A3Ynx+cIXujB2ixa+qbXbfX/jdZPLADghqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614972; c=relaxed/simple;
	bh=7kc6jlZD7X62wZB0M8B9+bz4psXxD7A9CNwsZ3pJ5Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScLMloS90LDvF0iQPFAgdEpIX+rFgTFBbzVQxgp0EQRnDs4sQN8X/JMwyLVSTE1Agz+6MmEB4feTyAaRbgya7zL7tdQujF2Kds0QyRiYRgU5PRIHr+Bt53+kMJg3ECGYRPuE2BtXF7CEIcYTaIWP7f/7//jPx4TYxBMlgr92s80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=uc6Dur1F; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1758614966;
	bh=zzeqtwEj5UTJKBZZILUt2MPbCrrrroWXRmHWpJZjSXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uc6Dur1F4v41rVHPdfzJFw80EzCcCxJAmN+Ld/h1WAU/6LZODUYH/jZIaAUNv5rtG
	 gpkgVKvOwf0lmYtlArYaJfx8bIpS/2CT9/NVYjhDt1Dv2MC4bOeben9y7LsQsaWmoC
	 AYMPFDaWhCUUYSYl/HXFgWuB69lIinLhvbOLEMc7d+8T9tJXymhrSUDLtx1/QouhOF
	 Aig1HZ76IDyNDqgw8Iuy58ke0WsBGtOsEXqKdsmoW+79J6YAM3lCpnCDmLpPMtFsgH
	 8YrSHM+jrahmDPnLqqZ7AyhXTWOGSwBRuRVHdevfHH7W/IQVUmPEXRb47RTXLT/hs0
	 N4AvuW9mzOtPQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cWCLZ1Czcz4w9Q; Tue, 23 Sep 2025 18:09:26 +1000 (AEST)
Date: Tue, 23 Sep 2025 18:09:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
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
Message-ID: <aNJVqSpdAJzGliNx@zatzit>
References: <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com>
 <aMD_qYx4ZEASD9A1@zatzit>
 <20250911104828.48ef2c0e@bootlin.com>
 <aMebXe-yJy34kST8@zatzit>
 <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit>
 <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xyxstg8Uj0Y3qEx9"
Content-Disposition: inline
In-Reply-To: <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>


--Xyxstg8Uj0Y3qEx9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 10:47:17AM +0530, Ayush Singh wrote:
> On 9/19/25 10:22, David Gibson wrote:
>=20
> > On Thu, Sep 18, 2025 at 09:44:09AM +0200, Herve Codina wrote:
> > > Hi David,
> > >=20
> > > On Thu, 18 Sep 2025 13:16:32 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > ...
> > >=20
> > > > > > Thoughts above suggest a different direction, but here's what I=
 was
> > > > > > thinking before:
> > > > > >=20
> > > > > > base board:
> > > > > >=20
> > > > > > 	connector {
> > > > > > 		/export/ "i2c" &i2c0;
> > > > > > 	};
> > > > > >=20
> > > > > > addon:
> > > > > > 	eeprom@10 {
> > > > > > 		compatible =3D "foo,eeprom";
> > > > > > 		bus-reg =3D <&i2c 0x10>;
> > > > > > 	}
> > > > > >=20
> > > > > > Or, if the addon had multiple i2c devices, maybe something like:
> > > > > >=20
> > > > > > 	board-i2c {
> > > > > > 		compatible =3D "i2c-simple-bridge";
> > > > > > 		bus-ranges =3D <&i2c 0 0x3ff>; /* Whole addr space */
> > > > > > 		eeprom@10 {
> > > > > > 			compatible =3D "foo,eeprom";
> > > > > > 			reg =3D <0x10>;
> > > > > > 		}
> > > > > > 		widget@20 {
> > > > > > 			compatible =3D "vendor,widget";
> > > > > > 			reg =3D <0x20>;
> > > > > > 		}
> > > > > > 	}
> > > > > >=20
> > > > > > Writing that, I realise I2C introduces some complications for t=
his.
> > > > > > Because it has #size-cells =3D <0>, ranges doesn't really work =
(without
> > > > > > listing every single address to be translated).  Likewise, beca=
use we
> > > > > > always need the parent bus phandle, we can't use the trick of a=
n empty
> > > > > > 'ranges' to mean an identity mapping.
> > > > > >=20
> > > > > > We could invent encodings to address those, but given the addon=
 with
> > > > > > multiple connectors case provides another incentive for a single
> > > > > > connector to allow adding nodes in multiple (but strictly enume=
rated)
> > > > > > places in the base device tree provides a better approach.
> > > > > and the "place in base device tree" is the goal of the extension =
bus.
> > > > >=20
> > > > > The strict enumeration of nodes enumerated is done by two means:
> > > > >   - extension busses at connector level
> > > > >     Those extensions are described as connector sub-nodes.
> > > > >     The addon DT can only add nodes in those sub-nodes to describ=
e devices
> > > > >     connected to the relared extension bus.
> > > > >   - export symbols
> > > > >     An addon DT can only use symbols exported to reference symbol=
s outside
> > > > >     the addon DT itself.
> > > > >=20
> > > > > Can I assume that bus extensions we proposed (i2c-bus-extension a=
nd
> > > > > spi-bus-extension) could be a correct solution ?
> > > > Maybe?  I prefer the idea of a universal mechanism, not one that's
> > > > defined per-bus-type.
> > > >=20
> > > >=20
> > > > Also, IIUC the way bus extension operates is a bit different - nodes
> > > > would be "physically" added under the bus extension node, but treat=
ed
> > > > logically as if they go under the main bus.  What I'm proposing here
> > > > is something at the actualy overlay application layer that allows
> > > > nodes to be added to different parts of the base device tree - so y=
ou
> > > > could add your i2c device under the main i2c bus.
> > > I think we should avoid this kind of node dispatching here and there =
in
> > > the base DT.
> > Until I saw Geert's multi-connector case, I would have agreed.  That
> > case makes me thing differently: in order to support that case we
> > already have to handle adding information in multiple places (under
> > all of the connectors the addon uses).  Given we have to handle that
> > anyway, I wonder if it makes more sense to lean into that, and allow
> > updates to multiple (strictly enumerated) places.
>=20
> Well, I don't love this idea. Here are my main qalms about the approach of
> adding devices directly to the actual i2c/spi etc nodes.
>=20
> 1. In boards with multiple connectors, they sometimes share the same i2c.
> Now assume that someone decided to connect the same i2c device to both the
> connectors. If we are using something like bus extension, while the node
> would be added, it will fail in the registration since you cannot add the
> same address device a second time. However, if we are adding the device
> directly to the `main_i2c`, the overlay application will just end up
> modifying the exact same device node. There is no error, or even a 2nd
> device node in this case. It is just lost.
>=20
> 2. How well will overlay adding and removing work when the same tree nodes
> are modified by multiple connectors? I have not looked at the internals of
> overlay resolution so not sure, but I don't want dynamic addition and
> removal of devices in independent connectors to somehow become coupled.

Ah, right.  To be clear: we absolutely don't want multiple addons
altering the same nodes.  But I think we could do that in ways other
than putting everything under a connector.  This is exactly why I
think we should think this through as an end-to-end problem, rather
trying to do it as a tweak to the existing (crap) overlay system.

So, if we're thinking of this as an entirely new way of updating the
base dt - not "an overlay" - we can decide on the rules to ensure that
addition and removal is sane.  Two obvious ones I think we should
definitely have are:

a) Addons can only add completely new nodes, never modify existing
   ones.  This means that whatever addons are present at runtime,
   every node has a single well defined owner (either base board or
   addon).

b) Addons can only add nodes in places that are explicitly allowed by
   the connectors they're connecting to.

We could consider further rules as well though.  For example, we could
say that i2c devices in an addon shouldn't be added directly under the
base board's i2c controller, but under a subnode of that i2c
controller assigned to that connector (which would likely have an
empty 'ranges' property meaning addresses are mapped without
translation).  Not really sure if that rule has more benefits or
drawbacks, but it's worth contemplating.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--Xyxstg8Uj0Y3qEx9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjSVZwACgkQzQJF27ox
2Gdn5Q//bpdVz4WXYnlnwXzhN/K8EI3FqIjuDRfTVdvbzpX1peYW+buj9IBFhme1
xBEJ43e/jjU/6S91ITgiDUAx8fyi4D92otfTnRQTDLa97Hy1KWzksDDpbBPZthOn
UQC865pUyD9H2GoitRAvb6hFfnbM/PP+pf3v9Xv1TiPKg7NPvwl7IW9dZ4+K4Axg
ju5e5vO7OHM2YWA7/kQM+n1UOMlhFl7i2APUdVYXJoXeHZ5LYbar7lSues+oNS4T
qc0o2jgVD5pWfhl2/J+0fE3/lw2+vPumkReAONIBGDrvsQ61j+Cn99avOQQPjiqU
mCs7F9U1mgX/teyuc4prkf69V1lldMhhmhhs62XlIsZ7/04IjfSz+Mg9t4ts6zvi
8Qepq2BiBd3hhCTeNXs9+5yb7DYvfK6cJd7dcipbXH5lMBj6nZlpZbV/m3M8KVLD
T9pbx204kUrqWIbh6t89/0DrWeINql0mH0oiIuf7DKn6RL7Q7/R4xtXlqVnYsu0P
lNExEbO8LklcP9rpi1lCp2KTJPgC42HWGzQHOqsMvUbIkPNbpCdOZw997lEtLta7
SXR/+KNue/OYnYlR88Iz8zmsIUkfColBS0X2epHGFWmonR/MG6a/qG8XESYLfJ4j
sfTEfRkGV4TI+ncLSwXEaGxCHVbzX7kNVuTt6vMVZyiBECpHg4w=
=Fsvn
-----END PGP SIGNATURE-----

--Xyxstg8Uj0Y3qEx9--

