Return-Path: <linux-kernel+bounces-823992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB03AB87E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B9F1C84220
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91F26E16A;
	Fri, 19 Sep 2025 04:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JHbqVxpU"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E2225D6;
	Fri, 19 Sep 2025 04:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758257600; cv=none; b=HqqKBnaSrO7mqNHICaRBte7R7OAu4/2dG2RaY4U2J1tkVZbv1yEwrlKJFzjedKJygMPISqQeK9IQP8rg/WMdurJzjx2QFjd5D0/TFMcoh1Tti2YixauDPWT/AykPMjdw7+nIC5CZnfBwM0KtcwIyTgfuNy0ZTXrsziIq7JLe5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758257600; c=relaxed/simple;
	bh=niu7L+XutTuM3epi/bM8qF5I6wt7+HOjmYexFOsl1UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahXOluqpbufmlUMktjBi8ktgiCLll4dCRUNE0w4fbfhQF/RJN3aP0j4yHwMVsxhn8fUGPv8DZm+yo4C+kJbLX1IunrUKsLVYdJHX/Sl4zrztlo9QNJVhfidCxDcwkWiPDkO9ZQDyY4itj65dPxiAwjtCDI4nwxHaU1qSNCPR0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=JHbqVxpU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1758257587;
	bh=onjWscOdRIHhKfOV71/ABj9CnTyOdEOjdicJ6axOKFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHbqVxpUH0n3TUEyNVoowW7u18AX60XuyY14nUNseZtxgqh30HFFEgjXhKPFCJ+iK
	 rnYelAGmNpeYRKZL3axvFw/4BYVtT4Y7+qJncABpLid18YCMy0Oh2Eru3+8Iz7z3DX
	 C5AG6RkDmcycxJqbhMHF6Lg1Uih99a7frIoQpYtcZ1F2405nTz/xm/suiuo620t/Fy
	 ogZ9V9X8IYqmI7RK5eHjWFEhabj1m+t0knsFV0J2Ha0rMauiJJSX0fD3P9KDz3CrNE
	 +bhKSxkFFy0iM2s2EwINK1IKAhPRNJaoM6Jh3+b3K/qGnKDfrTSEo/0IoIdFlW+uHf
	 /FZpuLiCgWHxA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cSg9v5DF3z4wCP; Fri, 19 Sep 2025 14:53:07 +1000 (AEST)
Date: Fri, 19 Sep 2025 14:52:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ayush Singh <ayush@beagleboard.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	devicetree@vger.kernel.org, Jason Kridner <jkridner@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aMzhgDYOuG4qNcc0@zatzit>
References: <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com>
 <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com>
 <aMD_qYx4ZEASD9A1@zatzit>
 <20250911104828.48ef2c0e@bootlin.com>
 <aMebXe-yJy34kST8@zatzit>
 <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit>
 <20250918094409.0d5f92ec@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H7/fQSG5jrECq+gd"
Content-Disposition: inline
In-Reply-To: <20250918094409.0d5f92ec@bootlin.com>


--H7/fQSG5jrECq+gd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 09:44:09AM +0200, Herve Codina wrote:
> Hi David,
>=20
> On Thu, 18 Sep 2025 13:16:32 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> ...
>=20
> > > > Thoughts above suggest a different direction, but here's what I was
> > > > thinking before:
> > > >=20
> > > > base board:
> > > >=20
> > > > 	connector {
> > > > 		/export/ "i2c" &i2c0;
> > > > 	};
> > > >=20
> > > > addon:
> > > > 	eeprom@10 {
> > > > 		compatible =3D "foo,eeprom";
> > > > 		bus-reg =3D <&i2c 0x10>;
> > > > 	}
> > > >=20
> > > > Or, if the addon had multiple i2c devices, maybe something like:
> > > >=20
> > > > 	board-i2c {
> > > > 		compatible =3D "i2c-simple-bridge";
> > > > 		bus-ranges =3D <&i2c 0 0x3ff>; /* Whole addr space */
> > > > 		eeprom@10 {
> > > > 			compatible =3D "foo,eeprom";
> > > > 			reg =3D <0x10>;
> > > > 		}
> > > > 		widget@20 {
> > > > 			compatible =3D "vendor,widget";
> > > > 			reg =3D <0x20>;
> > > > 		}
> > > > 	}
> > > >=20
> > > > Writing that, I realise I2C introduces some complications for this.
> > > > Because it has #size-cells =3D <0>, ranges doesn't really work (wit=
hout
> > > > listing every single address to be translated).  Likewise, because =
we
> > > > always need the parent bus phandle, we can't use the trick of an em=
pty
> > > > 'ranges' to mean an identity mapping.
> > > >=20
> > > > We could invent encodings to address those, but given the addon with
> > > > multiple connectors case provides another incentive for a single
> > > > connector to allow adding nodes in multiple (but strictly enumerate=
d)
> > > > places in the base device tree provides a better approach. =20
> > >=20
> > > and the "place in base device tree" is the goal of the extension bus.
> > >=20
> > > The strict enumeration of nodes enumerated is done by two means:
> > >  - extension busses at connector level
> > >    Those extensions are described as connector sub-nodes.
> > >    The addon DT can only add nodes in those sub-nodes to describe dev=
ices
> > >    connected to the relared extension bus.
> > >  - export symbols
> > >    An addon DT can only use symbols exported to reference symbols out=
side
> > >    the addon DT itself.
> > >=20
> > > Can I assume that bus extensions we proposed (i2c-bus-extension and
> > > spi-bus-extension) could be a correct solution ? =20
> >=20
> > Maybe?  I prefer the idea of a universal mechanism, not one that's
> > defined per-bus-type.
> >=20
> >=20
> > Also, IIUC the way bus extension operates is a bit different - nodes
> > would be "physically" added under the bus extension node, but treated
> > logically as if they go under the main bus.  What I'm proposing here
> > is something at the actualy overlay application layer that allows
> > nodes to be added to different parts of the base device tree - so you
> > could add your i2c device under the main i2c bus.
>=20
> I think we should avoid this kind of node dispatching here and there in
> the base DT.

Until I saw Geert's multi-connector case, I would have agreed.  That
case makes me thing differently: in order to support that case we
already have to handle adding information in multiple places (under
all of the connectors the addon uses).  Given we have to handle that
anyway, I wonder if it makes more sense to lean into that, and allow
updates to multiple (strictly enumerated) places.

> We work on decoupling busses wired to a connector and dispatching nodes
> looks like this decoupling is ignored.

I don't really follow what you're saying here.

> IMHO, keeping devices available on an addon board as nodes under the
> connector is a real hardware representation.

It's *a* real hardware representation, but it's not the only real
hardware representation.  Placing the new nodes under connectors
prioritises the physical connections.  Placing them under various
nodes on the base board prioritises the logical-bus connections.  I'd
argue that the latter is slightly more important, since the primary
consumer of the device tree is the OS, to which the logical
connections are usually more important.

But in any case, real hardware isn't necessarily a tree, so we have to
compromise somewhere.

> Also, at runtime, once an addon board DT is applied, when you look at
> your current DT either using /proc/device-tree or some links such as
> /sys/bus/devices/.../of_node, the connector and extension bus appear
> and clearly identify devices behind the connector.

That's certainly nice, but we already lose this in the multi-connector
case, so I don't think it can be a hard requirement.

> > That approach does complicate removal, but its not as bad as overlays
> > at the moment, because a) it could be limited to adding new nodes, not
> > modifying existing ones and b) the connector would specify exactly the
> > places that additions are allowed.
>=20
> I think bus extensions comply with a) and b).

Bus extensions aren't directly relevant to (a) and (b) - those are
about the actual overlay/addon application mechanism.  Bus extensions
are one of several possible approaches to allowing a more restrictive
(and therefore manageable) way of dynamically updating the dt, while
still being able to represent multi-bus devices.

> Yes, bus extensions need to be handled per-bus types but they have the
> advantage of keeping the hardware reality well described and visible at
> runtime in term of "wiring" topology.
>=20
> Whatever the solution, this will already be handled per-bus types.
> Only busses that support runtime DT node addition/removal (OF_RECONFIG_*
> notifications in the kernel implementation) will support adding or
> removing nodes.

First, I don't see that the implementation need affect the spec here.
Second, bus-reg has possible applications even if there isn't dynamic
reconfiguration.
>=20
> Your approach is more complex, dispatch node here and there and actually
> is also a per-bus types solution.

Again, I don't follow you.

> I think, in order to choose between both solutions, the main question is:
> Do we want to dispatch nodes provided by an addon DT everywhere in the ba=
se
> DT ?
>=20
> IMHO, the answer is no.

Everywhere, no, absolutely not.  That's one of the things that's awful
about the current overlay mechanism.

Multiple places - as specified by the base board / connector, maybe.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--H7/fQSG5jrECq+gd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjM4XAACgkQzQJF27ox
2GeEbQ//XLxZeZ3BQAikMK2v7m4TegAdD5MPyneNrnkXJqSFLS4LuEn85drE9pHg
ILQAxP7oLutvBIVrbLsizEQG+Qp38o82K92Pksgr8uqt/D4qFN4/okKCd1Bhu3Y/
YgWWCeg7/Zy8n1CM69ZV7CSWc0qlKwpXxFf0i1pmw9grnpoe+/Y6iZunjUAB2WFw
4acoFD5DfdVJbnRgPkjyWQjQnWg3g4buzpsRI4b6gka5Xwrl5HEEH1Ms2td+1NPd
cNckBlvYeC+f2QU6ogmRvMZb7B+0pxGSscrg36toGbwpU9KDWXfGnsWxAHE8LCjY
fGGjyzCU9nvbHTukKTcPbk3nJaNWZo95S30ueJRuF7UxCny54dvwzg+z94HZv3Ed
g9jGHzYdw6UImBhT+1vPzHY6AUOdPpjXR/wRgAsagyud3fAsfO52lLHsong049ZB
BsUwg5Q33092QlRUe7/0YNtHdLui4ILQ7C9L+UXoaD2kiqQ4EJv9pL5KnDoXDp0U
ajWxEaPdgE15f6M6aILE4TVIdFCh1RBm+yfDAeAy35pN7wlArBr/RC8h2ZIdxCHU
esgnB8yMicMqEq6nlKl3rhoo0TxpY9WowVNOM9/YuQreexkSeGQUmKeI6l/OXJPF
Vd1tSNzkP5jsPCGoRVZE3IHIzH8S5RHyt2Lp3EcCXLz4AWDsDhY=
=xXWq
-----END PGP SIGNATURE-----

--H7/fQSG5jrECq+gd--

