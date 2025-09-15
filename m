Return-Path: <linux-kernel+bounces-816106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1457B56F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE397A91CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D086272E56;
	Mon, 15 Sep 2025 04:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LPfJFKjz"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E461F2361;
	Mon, 15 Sep 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757912077; cv=none; b=Glf4+wYlCzpmP0J2NUuf5RszDCB1ctrk8ir6BYOju9447tWeNxqvk1Oxc/uDaOO2rlmRMhwxe42O1Wm6z2RN7tWHlTD0hDZ8WR+1e5DfuD76qR3gxyhfqJFJMy+pJAj9sOWxbMLgNX02soB8FVmqB2V4ojBb/rFfc1dF0pZqn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757912077; c=relaxed/simple;
	bh=4khJECPiAoY6Ov3urQvBXzjMh8GUEyC5qrHNvw0C5OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwYLfIv4Ke/vkWYQZ/wbm+MNtmdnXj9MY0m973kJatj3VhdbM7rDvxwtC12RhGPqdKLejri+jWEoq4GXEiU/VH1FL/iuB2rXTK64FW8ZxAwWNLCf/3gIp3pelGhfdsmiwnhsBDLbWc2e8IS65mneA+kDfZANGuY/oG1UE3WuX7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=LPfJFKjz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757912063;
	bh=meXJkml2lM7Fzx0kZ4z63MG7HQRV8c+V9RLrobfZFcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPfJFKjzB4mT/Jmr4GodbRCWlL+tqnh9zzLi4OV9FQ1iZ0RRuVfcwM8vQmhZIq+mg
	 FgKdrDSKKMsROaJYqpNDRLQghW8r5zCy97aP3LiIk3f1Ywkn5NyPEdMDb7YB9MiIYm
	 tav4s4shvIbh80J7Lsu+c2bu8/KrBeijctUAWzz1CGCHzxZF+mrAeaCwZybBBl8U7u
	 EVzr5RgBOIYURG7f6P7Ut7irg7dnTJ4euivFY88zSLqr+9AqwQU2PFi+UA4HfXkMb4
	 x6lxfe7PDgmq/ddrv1JEiJjjyLJ50Q1OohP/dOtJyQJ7k0yCOpSXlwxNyWsyQyiePQ
	 pWHEblkTFzl1w==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cQCPC1v7Gz4w9v; Mon, 15 Sep 2025 14:54:23 +1000 (AEST)
Date: Mon, 15 Sep 2025 14:51:41 +1000
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
	Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aMebXe-yJy34kST8@zatzit>
References: <20250902105710.00512c6d@booty>
 <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
 <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com>
 <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com>
 <aMD_qYx4ZEASD9A1@zatzit>
 <20250911104828.48ef2c0e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3KKDU2GFxq0b2RoE"
Content-Disposition: inline
In-Reply-To: <20250911104828.48ef2c0e@bootlin.com>


--3KKDU2GFxq0b2RoE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:48:28AM +0200, Herve Codina wrote:
> Hi David,
>=20
> On Wed, 10 Sep 2025 14:33:45 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Sep 09, 2025 at 11:41:26AM +0200, Herve Codina wrote:
> > > Hi David,
> > >=20
> > > On Tue, 9 Sep 2025 15:09:18 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > ...
> > >  =20
> > > > > I think that a connector is something with a bunch of resources p=
rovided
> > > > > by the board where the connector is soldered. Those resources are=
 wired
> > > > > to the connector and defined by the connector pinout.
> > > > >=20
> > > > >      3v3   ------- Pin 0
> > > > >   i2c_scl  ------- Pin 1
> > > > >   i2c_sda  ------- Pin 2
> > > > >     gpio A ------- Pin 3
> > > > >     gpio B ------- Pin 4
> > > > >      gnd   ------- Pin 5
> > > > >=20
> > > > > IMHO, this need to be described and defined in the base board and=
 an addon can
> > > > > only reference resources wired and described by the connector nod=
e.   =20
> > > >=20
> > > > Yes, that's exactly what I'm proposing too.
> > > >  =20
> > > > > Now, questions are:
> > > > >   - 1) How to describe a connector?
> > > > >   - 2) How to reference resources provided at connector level fro=
m an add-on?   =20
> > > >=20
> > > > Right.
> > > >  =20
> > > > > Our current approach was:
> > > > > ---- base board DT ----
> > > > >   connector0 {
> > > > > 	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 =
controller */
> > > > >                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of g=
pio2 controller */
> > > > >         i2c-one {
> > > > > 		compatible =3D "i2c-bus-extension";
> > > > > 		i2c-parent =3D <i2c5>; /* i2c-one wired to i2c5 controller */
> > > > > 	};
> > > > >=20
> > > > > 	i2c-two {
> > > > > 		compatible =3D "i2c-bus-extension";
> > > > > 		i2c-parent =3D <i2c6>; /* i2c-two wired to i2c6 controller */
> > > > > 	};
> > > > >=20
> > > > > 	/*
> > > > >          * From the addon we need to reference:
> > > > >          *    - The connector itself,
> > > > >          *    - Maybe some pinctrl related to signals wired to th=
e connector,
> > > > >          *    - In some cases the i2c bus (HDMI, ddc-i2c-bus =3D =
<&i2c-two>;)
> > > > >          *=20
> > > > >          * This was solved introducing the controversial export-s=
ymbols node.
> > > > >          */   =20
> > > >=20
> > > > I think the type of connector should also be named on both sides (w=
ith
> > > > 'compatible' or something like it). =20
> > >=20
> > > It makes sense.
> > >  =20
> > > >  =20
> > > > >   };
> > > > >=20
> > > > > ---- addon board DT ----
> > > > >    {
> > > > > 	some-node {
> > > > > 		compatible =3D "foo,bar";
> > > > > 		reset-gpios =3D <&connector 0>; /* gpio A used as a reset gpio =
*/
> > > > > 		ddc-i2c-bus =3D <&i2c-two>;
> > > > >         }
> > > > >=20
> > > > >         i2c-one {
> > > > > 		eeprom@10 {
> > > > > 			compatible =3D "baz,eeprom"
> > > > > 			reg =3D 10;=20
> > > > > 		};
> > > > > 	};
> > > > >    };
> > > > >=20
> > > > > The addon board DT can only be applied at a connector node.   =20
> > > >=20
> > > > Right.  This is not how overlays work now.  By the nature of how
> > > > they're built they apply global updates to the base tree.  That mea=
ns
> > > > we need to spec a new way of describing addons that *is* restricted=
 to
> > > > a particular connector slot (or slots, as Geert points out).  Since=
 we
> > > > have that opportunity, we should _not_ try to make it a minimal
> > > > extension to existing overlay format, but define a new and better
> > > > encoding, designed to meet the problems you're looking to address. =
=20
> > >=20
> > > On the kernel side, overlays can be applied at a specific node.
> > > The node is chosen when the overlay is apply.
> > >   https://elixir.bootlin.com/linux/v6.16/source/drivers/of/overlay.c#=
L970 =20
> >=20
> > Huh, I wasn't aware that had already been merged.
> >=20
> > > This allows to apply an overlay to a specific node without any modifi=
cation
> > > of the overlay dtb (dtbo).
> > >=20
> > > Ajush proposed an update to support this feature in fdtoverlay
> > >   https://lore.kernel.org/all/20250313-fdtoverlay-target-v1-0-dd5924e=
12bd3@beagleboard.org/ =20
> >=20
> > Yes, and I've been disinclined to merge it because I think extending
> > overlays in this way, without a more wide-ranging redesign, is not a
> > great idea.
> >=20
> > > ... =20
> > > >  =20
> > > > > > > > 3) bus-reg / bus-ranges
> > > > > > > >=20
> > > > > > > > One thing that makes connector plugins a bit awkward is tha=
t they
> > > > > > > > often need to add things to multiple buses on the host syst=
em (MMIO &
> > > > > > > > i2c for a simple case).  This means that once resolved the =
plugin
> > > > > > > > isn't neatly a single subtree.  That's one factor making re=
moval   =20
> > > > >=20
> > > > > It can be a single subtree if decoupling is present at connector =
node available
> > > > > in the base device tree.   =20
> > > >=20
> > > > Right - allowing that decoupling is exactly what I'm proposing bus-=
reg
> > > > for.  Note that the case of an addon that plugs into multiple
> > > > connectors that Geert pointed out complicates this again. =20
> > >=20
> > > Geert's use case needs to be clarified.
> > >=20
> > > Suppose a base board with 2 connectors:
> > >  - connA
> > >  - connB
> > >=20
> > > Case 1: Addons are independant
> > >                +--------+
> > >   connA <----> | AddonA |
> > >                +--------+
> > >                           +--------+
> > >   connB <---------------->| AddonB |
> > >                           +--------+
> > >=20
> > > With addonA and B two addon board each connected at one connector wit=
hout any
> > > relationship between addon A and B
> > >=20
> > > Case 2: Only one Addons using ressources from both connector
> > >=20
> > >                 +------+
> > >   connA <-----> |Addon |
> > >                 |      |
> > >   connB <-----> |      |
> > >                 +------+ =20
> >=20
> > Case 2 is what I'm talking about.  Case 1 is the easy one.
> >=20
> > > The addon is connected to both connector and uses ressources from con=
nA and
> > > connB in a dependent manner.
> > >=20
> > >=20
> > > The Case 2 can be solved using a connector that described both connA =
and connB.
> > > Having the split connA and connB is a mechanical point of view. =20
> >=20
> > I don't think that's a good solution, because it means you have to
> > make that decision at the board layer.  If I understand his case
> > correctly, you have a board where you could do either case 1 or case 2
> > at runtime.  We'd want the differences between these cases to only be
> > reflected on the addon device tree, not the base board device tree.
>=20
> Based on my understanding of Geer's use-case, I think decision at base
> board level will be needed.
>=20
> base board        addon board
>   connA +--------+conn1
>   connB +--------+conn2
>   connC +
>=20
> Or
>=20
> base board        addon board
>   connA +--------+conn1
>   connB +    ,---+conn2
>   connC +---'

I'm not sure what you mean by a decision at the base board level.  I
certainly don't think this should be in the base DT.  I'd see this as
a runtime parameter needed when you apply/insert/activate the addon.
That's not really any different from addons with a single connector.
To allow for base boards with multiple instances of that connector
you'd need to specify at insert time which instance you're attaching
to.

That information could be supplied by the user, or in the case of
connectors that can be probed in some way (e.g. an EEPROM) the
connector driver could supply the information.


Which does make me think, considering this case says to me that
conceptualizing the choice of where to plug an addon as "subnode in
the base tree it goes under" is not a good idea.  That's not really
going to work for a multiple connector addon.

So, we can specify where an addon goes by which "connector" it
attaches to.  That connector would have an explicit entry in the base
tree, but it could reference multiple places to add nodes within that
base tree.  Which means thinking about it that way, we might not need
'bus-reg' / 'bus-ranges' after all, and in some cases maybe not bus
extensions either.

Adding nodes in multiple places makes removal a bunch more complicated
(although it's still much better than overlays being able to modify
*anywhere*).

> Or any other combination that would match.
>=20
> From the addon board point of view, the only think we can
> say is "me, as an addon board, I need a connector of type 'foo' and a
> connector of type 'bar'".

Agreed.

> Also, at base board level, statically defined in the DT
> connA is described (type 'foo'), connB and connC are
> described (type 'bar').
>=20
> The choice to map connA to the type 'foo' connector expected by the addon
> and the choice to map connB or connC to the type 'bar' connector expected=
 by
> the addon can only be done at runtime and probably with the help of a dri=
ver
> that have the knowledge of the 3 connectors.

Agreed.

> I have the feeling that the choice of physical connectors to which the ad=
don
> board is connected to is a human choice when the board is connected.

Yes.  Although if the addons have an EEPROM, or some other sort of ID
register, it may be possible for some connector drivers to probe this.

> > > Also adding and Addon on only one part (connA for instance) should no=
t be an issue
> > > if the connector describe both parts.
> > >=20
> > > but well, here again I can miss something.
> > > Geert, can you provide details?
> > >=20
> > > ...
> > >  =20
> > > > > > >=20
> > > > > > > There is an i2c-bus-extension [1] and spi-bus-extension propo=
sal to do the
> > > > > > > same. But, if we can figure out a common way for all buses, t=
hat would be
> > > > > > > great.   =20
> > > > >=20
> > > > > Exactly, this is the purpose of bus extensions.   =20
> > > >=20
> > > > Right, but redefining it for each bus type seems silly. =20
> > >=20
> > > Nexus node properties are re-defined for each kind of resources (inte=
rrupt,
> > > gpio, pwm, ...). =20
> >=20
> > Yes, for historical reasons.  In IEE1275 days, interrupts was
> > basically the only thing that worked this way.  gpio and pwm were
> > added much later using interrupts as a model.  If we were designing
> > from scratch having a common way of defining a nexus would make sense
> > too.
> >=20
> > > Why not for bus extensions. =20
> >=20
> > So that we don't need to keep defining new bindings for it.
> >=20
> > > Also I am pretty sure that some bus extension will need to define some
> > > properties specific to the bus related to the extension. =20
> >=20
> > Maybe, but then only those buses that specifically need it need the
> > extra binding.
> >=20
> > > > > Also, I don't thing that the 'ranges' property should be used for=
 that purpose.
> > > > > The 'ranges' property is used to translate addresses from child a=
ddresses space
> > > > > to parent addresses space.   =20
> > > >=20
> > > > The rationale for bus-ranges is that the add-on board could re-expo=
se
> > > > one of the buses on the connector (say MMIO for simplicity) to seve=
ral
> > > > chips physically included on the addon board.  We don't want those
> > > > sub-chips to need different device nodes depending on whether they'=
re
> > > > on an addon board or wired directly onto a main board.  bus-ranges
> > > > would allow the root of the connector to create a subtree in which
> > > > regular MMIO (or whatever) devices can be described, and then routed
> > > > via the connector onto the bus on the main board. =20
> > >=20
> > > bus extensions supports this feature without bus-regs nor bus-ranges.=
 =20
> >=20
> > bus-reg & bus-ranges allow it for any bus without having to create a
> > new binding.
> >=20
> > > A bus extension ended by a sub node in the connector node.
> > > Applying the addon DT at the connector node allow the addon to had
> > > subnode to the extension node. =20
> >=20
> > I don't really understand what point you're making here.
>=20
> Hardware:
>  +------------------+    +----------------------+
>  |   base board     |    |      addon board     |
>  |  +------+        |    |                      |
>  |  | i2c0 |    +-----------+    +------------+ |
>  |  |      +----+ connector +----+ eeprom @10 | |
>  |  |      |    +-----------+    +------------+ |
>  |  +------+        |    |                      |
>  +------------------+    +----------------------+
>=20
> base board DT:
>     connector {
> 	i2c-ctrl {
> 		compatible =3D "i2c-bus-extension";
> 		i2c-parent =3D <&i2c0>;
>         };
>     };
>=20
> addon board DT:
>     i2c-ctrl {
> 	eeprom@10 {
>             compatible =3D "foo,eeprom";
>             reg =3D <10>;
>         };
>     };
>=20
> Once addon board DT is applied at the base board connector node, the full
> DT is:
>     connector {
> 	i2c-ctrl {
> 	    compatible =3D "i2c-bus-extension";
> 	    i2c-parent =3D <&i2c0>;
>=20
>             eeprom@10 {
>                compatible =3D "foo,eeprom";
>                reg =3D <10>;
>             };
>         };
>     };
>=20
> I probably didn't understand the bus-reg and bus-range usage.
> In order to clarify my understanding, using the same hardware example abo=
ve,
> can you provide an example of description using bus-reg &
> bus-ranges?

Thoughts above suggest a different direction, but here's what I was
thinking before:

base board:

	connector {
		/export/ "i2c" &i2c0;
	};

addon:
	eeprom@10 {
		compatible =3D "foo,eeprom";
		bus-reg =3D <&i2c 0x10>;
	}

Or, if the addon had multiple i2c devices, maybe something like:

	board-i2c {
		compatible =3D "i2c-simple-bridge";
		bus-ranges =3D <&i2c 0 0x3ff>; /* Whole addr space */
		eeprom@10 {
			compatible =3D "foo,eeprom";
			reg =3D <0x10>;
		}
		widget@20 {
			compatible =3D "vendor,widget";
			reg =3D <0x20>;
		}
	}

Writing that, I realise I2C introduces some complications for this.
Because it has #size-cells =3D <0>, ranges doesn't really work (without
listing every single address to be translated).  Likewise, because we
always need the parent bus phandle, we can't use the trick of an empty
'ranges' to mean an identity mapping.

We could invent encodings to address those, but given the addon with
multiple connectors case provides another incentive for a single
connector to allow adding nodes in multiple (but strictly enumerated)
places in the base device tree provides a better approach.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--3KKDU2GFxq0b2RoE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjHm0sACgkQzQJF27ox
2GeswA/+O9iSmQ9WVoVL4POxMhmYlKbTwWknYN/+AEUw/88Fz0lkCjPdt+ImIGEM
+LlBgI6kHo+rtGuYiQmYXagI4h2T6PBofpV4I8i+Y5Ep+y0RsDY81HjtiQDCzBh/
7cQLGJZhEQIjcoWoUzrKq/vLTurV3AtOZG2hgf7iVNTTAkpcbLAuoY6qDGXVaFy+
qwSx0ycZt+APuRiblCm38FJSgRRpmqCgBG3ynzjHfJzYNCBcfCZFLQ3x5eDtoNLW
jxT8Sr3th1DrwP0d+AJnH5AurI/jCZ2K2uNMOeBiqH/Qf6ragNr5GskcxKH/aWZ8
x0w5o1qCyfe+qp/6gr4D4bZMu0Rikiq6l4uUgPF6quOx1VjXYXrxSAyc4E3QaE7+
1d7We9vj2t0QG9eGB0mCUoBSR1Wj2XC0FMkssbIIDzF6NBnXxvs9RjXjwBm8zjF4
nvfkAAaM2mfRqLCu5EPLvRqM1ik5Ke4TM9kGWntGwMfVuYoi0x1EzpUEXJXLZdGu
e7rzYoe/itBuwvHm0g0oHl79PKKzq2tjQXg//URrChwDuwOca5pqI6RIAbtDlU2u
1cDxGOLsQmY26eZOPAZ3mGe42loVM3cHjF6/1QkvXKMnoOJy9ihHxOW3fDMQJRJP
EGsjaI37AL6BqcOpo134PCcpoXlh1tZP+eZ+y+gBtmORxaPggvs=
=1HnZ
-----END PGP SIGNATURE-----

--3KKDU2GFxq0b2RoE--

