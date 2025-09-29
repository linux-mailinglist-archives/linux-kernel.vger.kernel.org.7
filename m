Return-Path: <linux-kernel+bounces-836099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A6BA8B82
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1EB16D476
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178F2D836A;
	Mon, 29 Sep 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Itdk6z14"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F4274FCE;
	Mon, 29 Sep 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139122; cv=none; b=MuyEhVs5cQ0AVf4cGgukW/o3hK1r+bMEfUt+pKrVe51coAbHy2E47aWkVGVyOev5vRTPdPCxxvJn+51ZQyr1uOMM0qFAhf4o+FpcdFmjfEGm+EpiY8l7lOOm5HHdySIGgvWJVGbmn63bCrpt5iPb/rnxvKT/kprkXb98M2gu3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139122; c=relaxed/simple;
	bh=GmQlPu7gl3wLDOBq2pqX84D3ZWLn6MYjsfs/KGS5GTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbtZzkR+YkBS1dKwSlAcGlfB9z3XgoQUn1TQWdGBGzlCxexeIz0Hl/6f92OgD0R36kYIQID+8mULLnBdtK8ndDJrlCXRc4FkPFVkKHpjYY3ZGJKx3groh3MJnTZSICOBzxsAvRIlv7r6WADXocYwgDJnjD43oIw+y8BvyDpb/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=Itdk6z14; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1759139110;
	bh=IerHrIutIyB5lVdkv5QHBhpAU/+3v08CaZJHmRoxpZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Itdk6z14hDPurte1t4oTqVfQN6KEQKSvjQ0GUqtRdU5YktULtQYj3vAv1LSYkk0jc
	 SzWbtCwZ/JvBS8WegHI6wgFiq12YLjLuKl6F6zJxfH+M2m7vy71AssESDoGMkfLUAX
	 2Dcynk5pqem1KDSXUAwB/63Vis83v/O72GFlQnK093Du2OS76mtsLLl4GlDU8z/6DJ
	 Jb/Pxqb11ji3R4uGJBSanUpAYLuo0DSoZpHP6AiL3J8nWEamQ8nLdHGaMdseV+YLaX
	 O4spjYvRYyx6IfZ445K27C3Ibd+x6cAtlw7WfZtKuVDMbbWSK+AYz1jMV4XR/c9L9E
	 KDiivU5wDVJTw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cZxBG2NsTz4wBj; Mon, 29 Sep 2025 19:45:10 +1000 (AEST)
Date: Mon, 29 Sep 2025 19:23:21 +1000
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
Message-ID: <aNpQCboQimgwIkJw@zatzit>
References: <aMebXe-yJy34kST8@zatzit>
 <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit>
 <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
 <aNJVqSpdAJzGliNx@zatzit>
 <20250923114849.2385736d@bootlin.com>
 <aNNrbmZfZU-1xJFm@zatzit>
 <20250924143130.0a34badb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OUZx14CP7tCARnAz"
Content-Disposition: inline
In-Reply-To: <20250924143130.0a34badb@bootlin.com>


--OUZx14CP7tCARnAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 02:31:30PM +0200, Herve Codina wrote:
> Hi David,
>=20
> On Wed, 24 Sep 2025 13:54:22 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> ...
>=20
> > >=20
> > > IMHO, no extra rules are needed in DT addon rules to constraint i2c d=
evices
> > > to be added in a connector node, a connector sub-node or an i2c contr=
oller
> > > node.
> > >=20
> > > This will be constrained by the connector itself (out of DT addon rul=
es). =20
> >=20
> > At this point I'm just considering the end-to-end rules we want to
> > enforce.  Exactly what stage of the process enforces each rule is
> > another question.
> >=20
> > > I mean, according to rule b), the connector will allow some destinati=
on
> > > places. Either it will allow the i2c controller node or a connector s=
ub-node. =20
> >=20
> > Sure.
> >=20
> > > This is specific to the connector definition and it should be out of
> > > generic DT addon rules. =20
> >=20
> > Hang on... what distinction are you seeing between the "connector
> > definition" and "generic DT addon rules".  As I see it we're trying to
> > create a protocol that defines both the base rules and what a
> > "connector" even means.
> >=20
>=20
> The "generic DT addon rules" give rules related to addon from a DT
> perspective. In other word "What an addon DT can do"
>  - export symbols
>  - import symbols
>  - Add full node only
>  - Don't allow to modify existing node
>  - ...
>=20
> The way addon are used is what I put behind "connector definition".
> The connector is a specific node in a DT with a specific comptible string.
> The definition of this node will tell "how to use it". For instance:
>   - There is 2 gpios available and an addon can use it with <&connector 0=
> and
>     <&connector 1>.
>   - There is an i2c bus available and an addon can use if with <&i2c-a>
>   - The hotplug mecanism used for this specific connector (gpio, eeprom, =
=2E..)
>     is also part of the "connector definition".
>=20
> An external board DT supposed to be connected to this connector should
>   - a) Provide its description using an addon DT (compliant with "generic=
 DT
>        addon rules")
> and
>=20
>   - b) Use resources from connector the board is connected to (compliant =
with
>        "connector definition").
>=20
> "generic DT addon rules": DT specification
> "connector definition": Connector binding

Ok.  I think there are some further possible distinctions here between:

 a. Rules for connectors in general
 b. Rules for a specific connector type (defined by the connector type
    binding)
 c. Rules for a specific connector instance (defined by the property
    values in that instance).

Possible we can avoid using one or more of those categories, but we
need to consider them and do so conciously.

> Today, connectors are going to use the addon feature but I didn't want to
> restrict addon feature to connectors.

Hmm.  I'm not sure this is a good idea.  I had been envisaging this
new "addon" support as explicitly tied to connectors - you can't
addon, except in a way the base board allows, and connectors are the
way it allows.

> For instance, a FPGA driver could use the addon feature with an addon DT
> to describe the internal part of the FPGA related to the FPGA bitstream
> loaded by the FPGA driver. That might make sense, right ?

With the distinction from the connector case being that the driver
defines how to interpret the addon at runtime, rather than the base DT
defining it statically?

> Also upstream in the kernel, PCI boards can be described using DT.
>   https://elixir.bootlin.com/linux/v6.16/source/drivers/misc/lan966x_pci.c
>   https://elixir.bootlin.com/linux/v6.16/source/drivers/misc/lan966x_pci.=
dtso
>=20
> Using addon DT in that case makes sense too even if a "connector" is not =
present.

Ok.  So I think the model you're suggesting is this:

 * A bus/port driver (let's call it an "addon driver") can allow addon
   DTs to be plugged in and removed, under constraints defined by that
   driver at runtime.

 * The connector driver would be one specific addon driver, that can
   handle a pretty broad range of not-too-complex addons.  The
   constraints for the addon DT are defined by the properties of the
   connector in the base DT, rather than by runtime logic in the
   driver.

Is that correct?

A few observations

 - This effectively makes an addon driver a special case of a
   discoverable bus/port driver.  Or even DT addons as a library that
   a bus/port driver can use.  Rather than directly updating the Linux
   device model, the driver selects an addon DT and uses that to
   update the Linux device model.

 - The distinction between a connector and a general addon driver, is
   a bit like that between the simple-bus driver and a PCI host bridge
   driver.  The former handles a fairly wide range of relatively
   simple cases, the latter handles a more complex and specialized
   case.

I don't dislike this model, but it does raise some questions (these
are not rhetorical):

1) Is DT a good way of describing the addon?

After all, the addon driver could make updates directly to the Linux
device model from whatever format is convenient.

2) Does it make sense to use the addon to alter the global DT?

Even if the addon is described by a DT, the addon/connector driver
could read that DT and the system DT and make corresponding updates to
the Linux device model without altering the system DT first.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--OUZx14CP7tCARnAz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjaT/UACgkQzQJF27ox
2GeMjw//e5KYzaCYB3I9SlEXy1wnNnGWIYU6jQ8wi8zdcP2AbUem385LTS2rCFQH
hqBuuIafNCnjLTnGFNVS7pg2u7I0nQw4YHgAJK8Miqc9jmrYcm++bjpI1YKAyy5I
dJpVv6jR1uWhVZaDVbA1b2k6+ffWoGoYADl2N00CTt7bBlM4K6cBgGUs1v24AfkU
FWdMec/vusXW9aoU+1AUj94JtERrv0cXuD01oi5cCTLpB7D7wc1POXVUK97XDJCo
wahEWjpCQVMC2sX7+q0jUm++cz7d+/1hPvt5zaiNIKnNp4SDc4mYMpwHciXlw42C
WkGQpAdCTrcQWNzLDBUceQ5LwPgOMJf8FKWdA3vllalwheLrtclELNNy3t92F0bz
y6ZD3+8+cLVnXbLEdFc4O6JUrlaQSYrSwe8LgkKpcf1E1LimH3qKf6vvw7KqvJZC
uolqfrLRAJP2oP8B+MSYRmKnJn48Y3lApkmK4dObR+ABL/+GmQF8s5XR8mB4RcYQ
v/acGL5F8zzuvSl4ovHn7MzpvGvAYEridy7oh/+3pT8KAdct/B7D9e/1Oyxc1+Yj
77jc9+C8zA87pP3xoL/mpfYM55iWh0LmVZHX/qRRnoJDK9o1Giofdobf4lO3sYwi
zfrqOHfNKiMdfrBUN1G1AZncQXr2b6GkEBQDfscspYolNgNPIhk=
=Xc5a
-----END PGP SIGNATURE-----

--OUZx14CP7tCARnAz--

