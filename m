Return-Path: <linux-kernel+bounces-811657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E9FB52C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F99B165E18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83D2E54DA;
	Thu, 11 Sep 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b4mVn3/f"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777F29BD9E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580541; cv=none; b=Svt2WgfMa7yq5dHUzNVafXcD5Z7kFsiaz2EbKOPW3G/ElJbmJ/cXA4jOm6Q8hhtvjguTxT0gEU+ZuAHXq2yx3rcC0e3bIJnJAVpSBDws9j3nAmadegPGj8yBVcZSQU8jmxkzUvWaxmU2Wj3rII1XAjxmtvFBw3zXZ3sB9qWL1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580541; c=relaxed/simple;
	bh=TtssiDQT+N20F8x+xyXKAbzt7Dr6Ge5hOzyMNclywx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqjH75jRCoaM3MVJLvpxJvk5yGNLc/rhQGNYv4fJyqINzRMzp0TCqTixEwGPlDBmpDmwh1xtXzpNu+/eRiGbXRk8HHb0EU8qOqzSs2Yl6c+M3E97u1ux6YjAJQJuj9Jwf7JZa97qYqEQfimxvGesEggp345f7ooNcdRGkiXuCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b4mVn3/f; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 84C4CC6B3B3;
	Thu, 11 Sep 2025 08:48:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3E19A606BB;
	Thu, 11 Sep 2025 08:48:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 675A0102F2833;
	Thu, 11 Sep 2025 10:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757580530; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N0acf9GIHR46fSmDWAzvXvIhc426nPY9NTDRnBWzeS8=;
	b=b4mVn3/fEGx/qCo05ogyojCxT20y/bF4ETpypQen0E5M6z4QUEqHfvR7xn3uJRCd1w3Hy/
	gYr3I+SCWQGEw4B6zvm351umRklK0WejpBDBCaGn+s6BPdfLnW55teeFXbP16YaZyxYDvE
	12kYQZmGdxD7Z/zCtOqjPE6c9586MJeuch8yeVd61J57MuD3Cc3m8ewR2cX1tgJ9jpTg0z
	ccaZjDRfCjLDxwgxqihPRGB5pprW7kE8QxNyj/aO+uM1TQgOKuep6/0a3HF+wX4otGlwYo
	+UldDwVx3XhvtID94r0xk55fRk11cl0gDten5S5LXXct4AVX75GXuMk2OlzTYw==
Date: Thu, 11 Sep 2025 10:48:28 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Ayush Singh <ayush@beagleboard.org>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, Jason Kridner
 <jkridner@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250911104828.48ef2c0e@bootlin.com>
In-Reply-To: <aMD_qYx4ZEASD9A1@zatzit>
References: <20250902105710.00512c6d@booty>
	<aLkiNdGIXsogC6Rr@zatzit>
	<337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
	<aL5dNtzwiinq_geg@zatzit>
	<20250908145155.4f130aec@bootlin.com>
	<aL-2fmYsbexEtpNp@zatzit>
	<20250909114126.219c57b8@bootlin.com>
	<aMD_qYx4ZEASD9A1@zatzit>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi David,

On Wed, 10 Sep 2025 14:33:45 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Sep 09, 2025 at 11:41:26AM +0200, Herve Codina wrote:
> > Hi David,
> >=20
> > On Tue, 9 Sep 2025 15:09:18 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > ...
> >  =20
> > > > I think that a connector is something with a bunch of resources pro=
vided
> > > > by the board where the connector is soldered. Those resources are w=
ired
> > > > to the connector and defined by the connector pinout.
> > > >=20
> > > >      3v3   ------- Pin 0
> > > >   i2c_scl  ------- Pin 1
> > > >   i2c_sda  ------- Pin 2
> > > >     gpio A ------- Pin 3
> > > >     gpio B ------- Pin 4
> > > >      gnd   ------- Pin 5
> > > >=20
> > > > IMHO, this need to be described and defined in the base board and a=
n addon can
> > > > only reference resources wired and described by the connector node.=
   =20
> > >=20
> > > Yes, that's exactly what I'm proposing too.
> > >  =20
> > > > Now, questions are:
> > > >   - 1) How to describe a connector?
> > > >   - 2) How to reference resources provided at connector level from =
an add-on?   =20
> > >=20
> > > Right.
> > >  =20
> > > > Our current approach was:
> > > > ---- base board DT ----
> > > >   connector0 {
> > > > 	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 co=
ntroller */
> > > >                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpi=
o2 controller */
> > > >         i2c-one {
> > > > 		compatible =3D "i2c-bus-extension";
> > > > 		i2c-parent =3D <i2c5>; /* i2c-one wired to i2c5 controller */
> > > > 	};
> > > >=20
> > > > 	i2c-two {
> > > > 		compatible =3D "i2c-bus-extension";
> > > > 		i2c-parent =3D <i2c6>; /* i2c-two wired to i2c6 controller */
> > > > 	};
> > > >=20
> > > > 	/*
> > > >          * From the addon we need to reference:
> > > >          *    - The connector itself,
> > > >          *    - Maybe some pinctrl related to signals wired to the =
connector,
> > > >          *    - In some cases the i2c bus (HDMI, ddc-i2c-bus =3D <&=
i2c-two>;)
> > > >          *=20
> > > >          * This was solved introducing the controversial export-sym=
bols node.
> > > >          */   =20
> > >=20
> > > I think the type of connector should also be named on both sides (with
> > > 'compatible' or something like it). =20
> >=20
> > It makes sense.
> >  =20
> > >  =20
> > > >   };
> > > >=20
> > > > ---- addon board DT ----
> > > >    {
> > > > 	some-node {
> > > > 		compatible =3D "foo,bar";
> > > > 		reset-gpios =3D <&connector 0>; /* gpio A used as a reset gpio */
> > > > 		ddc-i2c-bus =3D <&i2c-two>;
> > > >         }
> > > >=20
> > > >         i2c-one {
> > > > 		eeprom@10 {
> > > > 			compatible =3D "baz,eeprom"
> > > > 			reg =3D 10;=20
> > > > 		};
> > > > 	};
> > > >    };
> > > >=20
> > > > The addon board DT can only be applied at a connector node.   =20
> > >=20
> > > Right.  This is not how overlays work now.  By the nature of how
> > > they're built they apply global updates to the base tree.  That means
> > > we need to spec a new way of describing addons that *is* restricted to
> > > a particular connector slot (or slots, as Geert points out).  Since we
> > > have that opportunity, we should _not_ try to make it a minimal
> > > extension to existing overlay format, but define a new and better
> > > encoding, designed to meet the problems you're looking to address. =20
> >=20
> > On the kernel side, overlays can be applied at a specific node.
> > The node is chosen when the overlay is apply.
> >   https://elixir.bootlin.com/linux/v6.16/source/drivers/of/overlay.c#L9=
70 =20
>=20
> Huh, I wasn't aware that had already been merged.
>=20
> > This allows to apply an overlay to a specific node without any modifica=
tion
> > of the overlay dtb (dtbo).
> >=20
> > Ajush proposed an update to support this feature in fdtoverlay
> >   https://lore.kernel.org/all/20250313-fdtoverlay-target-v1-0-dd5924e12=
bd3@beagleboard.org/ =20
>=20
> Yes, and I've been disinclined to merge it because I think extending
> overlays in this way, without a more wide-ranging redesign, is not a
> great idea.
>=20
> > ... =20
> > >  =20
> > > > > > > 3) bus-reg / bus-ranges
> > > > > > >=20
> > > > > > > One thing that makes connector plugins a bit awkward is that =
they
> > > > > > > often need to add things to multiple buses on the host system=
 (MMIO &
> > > > > > > i2c for a simple case).  This means that once resolved the pl=
ugin
> > > > > > > isn't neatly a single subtree.  That's one factor making remo=
val   =20
> > > >=20
> > > > It can be a single subtree if decoupling is present at connector no=
de available
> > > > in the base device tree.   =20
> > >=20
> > > Right - allowing that decoupling is exactly what I'm proposing bus-reg
> > > for.  Note that the case of an addon that plugs into multiple
> > > connectors that Geert pointed out complicates this again. =20
> >=20
> > Geert's use case needs to be clarified.
> >=20
> > Suppose a base board with 2 connectors:
> >  - connA
> >  - connB
> >=20
> > Case 1: Addons are independant
> >                +--------+
> >   connA <----> | AddonA |
> >                +--------+
> >                           +--------+
> >   connB <---------------->| AddonB |
> >                           +--------+
> >=20
> > With addonA and B two addon board each connected at one connector witho=
ut any
> > relationship between addon A and B
> >=20
> > Case 2: Only one Addons using ressources from both connector
> >=20
> >                 +------+
> >   connA <-----> |Addon |
> >                 |      |
> >   connB <-----> |      |
> >                 +------+ =20
>=20
> Case 2 is what I'm talking about.  Case 1 is the easy one.
>=20
> > The addon is connected to both connector and uses ressources from connA=
 and
> > connB in a dependent manner.
> >=20
> >=20
> > The Case 2 can be solved using a connector that described both connA an=
d connB.
> > Having the split connA and connB is a mechanical point of view. =20
>=20
> I don't think that's a good solution, because it means you have to
> make that decision at the board layer.  If I understand his case
> correctly, you have a board where you could do either case 1 or case 2
> at runtime.  We'd want the differences between these cases to only be
> reflected on the addon device tree, not the base board device tree.

Based on my understanding of Geer's use-case, I think decision at base
board level will be needed.

base board        addon board
  connA +--------+conn1
  connB +--------+conn2
  connC +

Or

base board        addon board
  connA +--------+conn1
  connB +    ,---+conn2
  connC +---'

Or any other combination that would match.

=46rom the addon board point of view, the only think we can
say is "me, as an addon board, I need a connector of type 'foo' and a
connector of type 'bar'".

Also, at base board level, statically defined in the DT
connA is described (type 'foo'), connB and connC are
described (type 'bar').

The choice to map connA to the type 'foo' connector expected by the addon
and the choice to map connB or connC to the type 'bar' connector expected by
the addon can only be done at runtime and probably with the help of a driver
that have the knowledge of the 3 connectors.

I have the feeling that the choice of physical connectors to which the addon
board is connected to is a human choice when the board is connected.

>=20
> > Also adding and Addon on only one part (connA for instance) should not =
be an issue
> > if the connector describe both parts.
> >=20
> > but well, here again I can miss something.
> > Geert, can you provide details?
> >=20
> > ...
> >  =20
> > > > > >=20
> > > > > > There is an i2c-bus-extension [1] and spi-bus-extension proposa=
l to do the
> > > > > > same. But, if we can figure out a common way for all buses, tha=
t would be
> > > > > > great.   =20
> > > >=20
> > > > Exactly, this is the purpose of bus extensions.   =20
> > >=20
> > > Right, but redefining it for each bus type seems silly. =20
> >=20
> > Nexus node properties are re-defined for each kind of resources (interr=
upt,
> > gpio, pwm, ...). =20
>=20
> Yes, for historical reasons.  In IEE1275 days, interrupts was
> basically the only thing that worked this way.  gpio and pwm were
> added much later using interrupts as a model.  If we were designing
> from scratch having a common way of defining a nexus would make sense
> too.
>=20
> > Why not for bus extensions. =20
>=20
> So that we don't need to keep defining new bindings for it.
>=20
> > Also I am pretty sure that some bus extension will need to define some
> > properties specific to the bus related to the extension. =20
>=20
> Maybe, but then only those buses that specifically need it need the
> extra binding.
>=20
> > > > Also, I don't thing that the 'ranges' property should be used for t=
hat purpose.
> > > > The 'ranges' property is used to translate addresses from child add=
resses space
> > > > to parent addresses space.   =20
> > >=20
> > > The rationale for bus-ranges is that the add-on board could re-expose
> > > one of the buses on the connector (say MMIO for simplicity) to several
> > > chips physically included on the addon board.  We don't want those
> > > sub-chips to need different device nodes depending on whether they're
> > > on an addon board or wired directly onto a main board.  bus-ranges
> > > would allow the root of the connector to create a subtree in which
> > > regular MMIO (or whatever) devices can be described, and then routed
> > > via the connector onto the bus on the main board. =20
> >=20
> > bus extensions supports this feature without bus-regs nor bus-ranges. =
=20
>=20
> bus-reg & bus-ranges allow it for any bus without having to create a
> new binding.
>=20
> > A bus extension ended by a sub node in the connector node.
> > Applying the addon DT at the connector node allow the addon to had
> > subnode to the extension node. =20
>=20
> I don't really understand what point you're making here.

Hardware:
 +------------------+    +----------------------+
 |   base board     |    |      addon board     |
 |  +------+        |    |                      |
 |  | i2c0 |    +-----------+    +------------+ |
 |  |      +----+ connector +----+ eeprom @10 | |
 |  |      |    +-----------+    +------------+ |
 |  +------+        |    |                      |
 +------------------+    +----------------------+

base board DT:
    connector {
	i2c-ctrl {
		compatible =3D "i2c-bus-extension";
		i2c-parent =3D <&i2c0>;
        };
    };

addon board DT:
    i2c-ctrl {
	eeprom@10 {
            compatible =3D "foo,eeprom";
            reg =3D <10>;
        };
    };

Once addon board DT is applied at the base board connector node, the full
DT is:
    connector {
	i2c-ctrl {
	    compatible =3D "i2c-bus-extension";
	    i2c-parent =3D <&i2c0>;

            eeprom@10 {
               compatible =3D "foo,eeprom";
               reg =3D <10>;
            };
        };
    };

I probably didn't understand the bus-reg and bus-range usage.
In order to clarify my understanding, using the same hardware example above,
can you provide an example of description using bus-reg & bus-ranges?

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

