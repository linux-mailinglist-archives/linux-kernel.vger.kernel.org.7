Return-Path: <linux-kernel+bounces-805036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF19B48348
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62B618992C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1021CA0E;
	Mon,  8 Sep 2025 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XNL4BS1j"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CD189F5C;
	Mon,  8 Sep 2025 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306176; cv=none; b=pG0RPG2Uf79gcjiAG8SYheIcPTqGlt3dBMc9qsK6kVycwNQvx+VTS1nh0idLVGTzjxliyPNEYyRw3CZl6KLifNBrQUJ0PyuuoSPQuRxRGFSxKyoc1fCXB+TJBhtGszJcGElKeEBCRoB8a/+2+qpKstZ8RC4mQ0oa8wdCwkYtBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306176; c=relaxed/simple;
	bh=njTCJ3DsxEQWm4cbfCEDGr5CyacBUX9I3KdTu3fTp4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhLgqkLz8L9DJigKjnvaLvZwXg5ZhsEtGxEidyHRI/W4dkRB2M/Rn7zAwp7Ym2FFrFTJg7RrkORfNemPNciQ/U5RUxcfDc2qZ2lhWre6np8eznH/E7g+36ZZrgSHgnwg5LydqxM3RnU4J39aj9pNjpqrTa4nQx3aW18/Hv17YMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=XNL4BS1j; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757306171;
	bh=Nsp0NHfgvJ4BO8nB1fiAOEfoFS6pBizOKrzuOZATX28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNL4BS1j692z21Kci/QgZu4SulZOrq7/lNCpcIyOOAcghFOT94GfRS0rLhknwDAjK
	 +lk3husNZgcD20K1e/mrkd3qcIcJ3D8GglUyOsQqXgktiTS7d4iJ4lJOTEhEjLwaBw
	 /Z0+UnshOkEvk4zcI5bKOx7XaDyLEgu1xoQQs4R2zHgh9Wjc+t0wogHwh8UtVE+WFI
	 I7wCPeBgGVCgVwr5mrYgG78bT3VjPrqpNXePYxQhH9u3q3G6z0ShWrKIS3oilHUDN8
	 LlqMl4QHCakmOZYCwL3aPimjkRnORufPdCfmo5c5UTnm9staRBLcZRTb408XqE2+43
	 XD8phD9++yk3A==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cKvKR5R07z4w9Q; Mon,  8 Sep 2025 14:36:11 +1000 (AEST)
Date: Mon, 8 Sep 2025 14:36:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>, Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aL5dNtzwiinq_geg@zatzit>
References: <20250902105710.00512c6d@booty>
 <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agbwFMC2ICUAYb/T"
Content-Disposition: inline
In-Reply-To: <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>


--agbwFMC2ICUAYb/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 11:15:44AM +0530, Ayush Singh wrote:
> On 9/4/25 10:53, David Gibson wrote:
> > On Tue, Sep 02, 2025 at 10:57:10AM +0200, Luca Ceresoli wrote:
[snip]
> > 1) Connector local labels/symbols/aliases
> >=20
> > This is not a new idea - both the export-symbols proposal and my
> > ancient connector proposal had this in one form or another.  I think
> > something along these lines is almost essential.  Things that plug
> > into connectors almost always require references to several host board
> > resources (interrupt controller, gpio, ...).  In order to be pluggable
> > on multiple host boards you want to refer to those symbolically.  In
> > order to support multiple instances of the same connector type, you
> > need those symbols to refer to different things fordifferent connector
> > instances.
> >=20
> > Whhat I think is a mistake is trying to tie this too closely to the
> > existing __symbols__ structure.  Those have an ugly encoding that
> > requires tortured processing in a way that's not natural for dtb
> > handling.  Plus they already kinda-sorta duplicate old-school aliases
> > in an odd way.
> >=20
> > You want some sort of string =3D> node mapping on the connector side,
> > and a way to mark portions of properties on the plugin side as being
> > resolved to some string reference.  But we can take the opportunity to
> > design a better way of doing that than the ugly one we have now.
>=20
>=20
> Isn't export-symbols exactly this. We do take inspiration from __symbols_=
_.
> However, in case of export-symbols, its string =3D> phandle mapping (as
> opposed to string =3D> string in __symbols__).

As far as the specific It kind of is, yes, and that aspect I like.
What I'm not convinced by is how export-symbols is proposed to fit in
with and be used by surrounding logic.  export-symbols has been
designed to fit in with the existing (ugly) overlay mechanism.  I
think that's putting the cart before the horse.  Instead work out how
to logically define connectors first - which will involve information
equivalent to export-symbols - then work out how to update or replace
the overlay mechanism to work with that.

> I suppose export-symbols could follow aliase conventions, but that still =
is
> a string =3D> string mapping, which seems worse to me than a phandle (sin=
ce
> phandle size is constant).
>=20
>=20
> >=20
> > 2) Extend dtb itself
> >=20
> > A maor thing that makes current symbols and fixups ugly is the fact
> > that they are encoded into properties in the device tree itself,
> > despite being logically at a different semantic level.  Obviously you
> > *can* do that, but it's not natural.  It would make more sense to add
> > fixup tags into the dtb format itself.
>=20
> Having something akin to fixup in dtb format itself would be nice.

Yes, it would.

> > 3) bus-reg / bus-ranges
> >=20
> > One thing that makes connector plugins a bit awkward is that they
> > often need to add things to multiple buses on the host system (MMIO &
> > i2c for a simple case).  This means that once resolved the plugin
> > isn't neatly a single subtree.  That's one factor making removal
> > really awkward.  Here's an idea I had a while ago to allow plugins to
> > be a single subtree, by extending what's allowed in the tree content:
> >=20
> > Currently a node can only really have a presence on its immediate
> > parent bus, as encoded in the 'reg' and 'ranges' properties.
> > 'bus-reg' and 'bus-ranges' would extend that having a similar format
> > to 'reg' and 'ranges' but adding a phandle for each entry saying which
> > bus it lives on - somewhat similar to interrupt-map.
> >=20
> > For example, here's an MMIO bus bridge of some sort, which has control
> > registers on I2C:
> >=20
> > 	mmio-bus@... {
> > 		#address-cells =3D < 2 >;
> > 		#size-cells =3D < 2 >;
> > 		bridge@XXXX {
> > 			ranges =3D <...>;
> > 			bus-reg =3D <&i2c0 0x407>
> > 		}
> > 	}
> > 	i2c0: i2c@... {
> > 		#address-cells =3D < 1 >;
> > 		#size-cells =3D < 0 >;
> > 	}
> >=20
> > In a sense this extends the device tree to a device DAG.
> >=20
> > Obviously this does need changes at the OS device core level, but it
> > gives you a lot of flexibility having done so.
>=20
> There is an i2c-bus-extension [1] and spi-bus-extension proposal to do the
> same. But, if we can figure out a common way for all buses, that would be
> great.

Heh, right.  That reinforces my thought that this could be a good
idea.

[Btw, the theoretically correct IEEE1275 way to do this is change
 addressing across the whole tree.  e.g. set #address-cells =3D <3>,
 with the first cell being, say, 0 for mmio, 1 for i2c, 2 for SPI,
 then the remaining cells are the address within that bus.  So, this
 sort of thing is technically possible in old-school OF trees.  That
 would become pretty unmanageable though.  The idea of bus-reg is to
 encode the same information in a less awkward way]

> [1]:
> https://lore.kernel.org/all/20250618082313.549140-1-herve.codina@bootlin.=
com/
>=20
> [2]: https://lore.kernel.org/all/20250729-spi-bus-extension-v1-0-b20c73f2=
161a@beagleboard.org/
>=20
>=20
> > 4) You don't necessarily need to build a "full" device tree
> >=20
> > Flattened device trees (as opposed to original IEEE1275 device trees)
> > - by design - allow certain information to be omitted.  The most
> > common example is that for introspectable buses, like PCI, it's normal
> > to have the DT only include a node for the host bridge, with devices
> > under it being discovered by their own bus specific methods.  That's
> > discovery is handled by the bus/bridge driver.
> >=20
> > Connectors usually aren't introspectable, but it's still possible to
> > use an approach like this where the connector driver's discovery
> > method is "look at a different device tree".  So, for example,
> >=20
> > Board device tree:
> >=20
> > / {
> > 	compatible =3D "board-with-foo-connector";
> > 	. . .
> > 	mmio@... {
> > 		foo-connector@... {
> > 			compatible =3D "foo-connector";
> > 			ranges =3D < ... >;
> > 		}
> > 	}
> > }
> >=20
> > Foo device tree:
> >=20
> > / {
> > 	compatible =3D "foo-device";
> > 	foo-port-id =3D < 0x1234 >;
> > 	component@... {
> > 		reg =3D < ... >;
> > 	}
> > }
> >=20
> > Obviously a "foo device tree" would have different conventions than a
> > board device tree.  It wouldn't have /cpus, /memory, /chosen - but it
> > could have its own "magic" nodes that make sense for the properties of
> > the specific connector type.
> >=20
> > Again, that would require work in the device core part of the OS.  The
> > bonus is that runtime addition and removal is now trivial.  No hacking
> > of the base device tree is needed, and so doesn't need to be reverted.
> > The connector driver just adds/removes the reference to its own
> > private tree.
> >=20
> > This would, of course, need some way to refer to board resources
> > (interrupt controller, gpio controller) etc.  I think that can be
> > assembled using some of the previous ideas, though.
>=20
> I would need to wrap my head around this a bit, specially in context of
> chaining connectors. It does seem like it will still require the points y=
ou
> mentioned above to be present in one form or another, i.e. some way to
> extend busses to different nodes/trees and connector (even a chained one)
> local symbols/aliases.

Yes, it would still require those mappings.  I don't think chained
connectors introduce a lot of extra complication.  An intermediate
connector would need to be able to "re-export" things it got from its
parent connector to its child connector(s) - renaming them if
necessary.

I think those two elements would be enough to make something that's
useful in at least a few cases.  However, the pretty common case of a
connector with pins from multiple different parent buses would need
bus-reg or something similar.  Or else the nasty multiplexed encoding
described above.

I say, "nasty" and in many cases it would be, but I think there may be
some cases where that approach does make sense: e.g. a connector that
has several logically separate address spaces but which always travel
together and are typically handled by a common bridge device.  PCI is
a case of this, if you squint - a host bridge provides a config space
bus, and an MMIO bus and a PIO bus.  Also sometimes some sort of
interrupt controller / interrupt routing, complicated by the fact that
there are several different models for that across PCI and PCI-E.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--agbwFMC2ICUAYb/T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmi+XTUACgkQzQJF27ox
2GdS7g//XYf2sgIrVNsxJ2GccoWae658hkEbwN0sbFX+4HHx2/lvhYlePr4sqEu4
w9OG3dNmj/VJzFI9TCuw7hXUcQ67tSmY+5MH5+0G0NUFrrmwKMWmWoU909EJHIKK
GGtS0TeT5fgxoHaRzpmnX06gE4YJq2QAU0aeWZopf1nNHX66LAtGV1aqQV4J3l05
VM9x2VJFVUvVxpWM4xDjrI9MUjW7FVWNZPk3OATRFiPZqqPXHDjx7cizcYWMcMZ7
dRkweX20iGdmgYLoRDjg8br/Xh+5xQHAl+terktMLb595Mq146LV8FQFTUDq2BZb
9waTZWbDbtUZ837OgrBV3V0zvcCrFv07Bf0VpFnq6uNoB84fNH5v/DdWCME8TMu3
kv2T0v/VUkH1mo4ZFLXjRa5oQy9ThVqXnFbGorw0jUBDxc9qONvaFZCsFGZv92JD
u/wDw2y1M0njHs07H84fQQhE7WrJ4JCkS/F+eqjSD7TqntppdZJTfmwPMHYTL3NV
6Kx4bxJs8XKGd8C+KEsrt5yiQsDfKNNPVbwDMTpC5mMsquStvqpIsZc6g435nNm7
QqKdZjwuZyh4eUiZsgRLL3aTtMp/TE+GfABOYBwxct1j/Ii+3kGoME2opFJIVEVG
+9asiTB8Ym/m7HTA4QB2jhAXsT/xljH7unRWxtC/u+qz42xHIKc=
=vsl7
-----END PGP SIGNATURE-----

--agbwFMC2ICUAYb/T--

