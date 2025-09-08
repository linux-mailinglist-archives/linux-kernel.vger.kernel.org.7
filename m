Return-Path: <linux-kernel+bounces-805842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBACB48E25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BA77AF301
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB93054ED;
	Mon,  8 Sep 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NDtWmacT"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA739304BBF;
	Mon,  8 Sep 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335941; cv=none; b=snWox5JCTraXafWqR7Bm3K1gsLsFOITwUe6EqkKUxuDNNF/kMvKjUmkceM5kpgDBbRYMgjR7SkfuKG3FWiVyuIyjlBzuavXcTuhz/uYYZeVzwgvn1E9VVHLdh9EMWOZAP9HMXCsHfvnvIms2/PZBjW1U0xfYTLWwajT4WQvlsNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335941; c=relaxed/simple;
	bh=dWVxJxhUxncQk84A7irpjCAwbTL2ZXZPiLqCXAsCvPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmrNUgY29AZJEBkwLh7ixy3BXaB6svOFkturq3lKTU1aCfgPrIc2QfJl5Hw3nmB2uXU/G74LRJhQ4aU+3hrsTnfm6KkyYRuMdwbRqYvUD1ytCVu3SqV63I4UoyKP/jt3SMZWkSqFhl2DEzBuZSUoBOUHyinVspQZCodUkR4S7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NDtWmacT; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 39B99C6B3A7;
	Mon,  8 Sep 2025 12:51:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C00066061A;
	Mon,  8 Sep 2025 12:52:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA04E102F27D9;
	Mon,  8 Sep 2025 14:51:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757335932; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wtwvoj1RLwznHuyr5PlQVH+9jEoJm5SyipXGk+MavYM=;
	b=NDtWmacTT0cNGnzWNKswyYTctMqsWGdk7LvXo5PM6CCiGkkJtJJUQtgeRsHrjZ4YYp3hkP
	Lx9y4o4igPeePqLGfNDzlZn6/vJD3g/gWclfk77sBIaYPgwmi0DRziZFrclg/cER7yXM9l
	FiZees4mNH9AZzlEKSqJj6Y4XelUadm1ofAXjBWLp7XFJx4DgOPUtOn3OWtKE254DNE+hW
	71Sk+M8H6PKcroi1nSDVrmPjRG89UDHFqaHPZ095OwGYMkoQOa6ZW8q4Tp9fDpkhW5Kjxj
	RGlo7cBxssmr3B2hjXp9UAsgM8TzuBm9BIwWV+ZOuNgZjvBTbk96VyU+IUOiJA==
Date: Mon, 8 Sep 2025 14:51:55 +0200
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
Message-ID: <20250908145155.4f130aec@bootlin.com>
In-Reply-To: <aL5dNtzwiinq_geg@zatzit>
References: <20250902105710.00512c6d@booty>
	<aLkiNdGIXsogC6Rr@zatzit>
	<337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
	<aL5dNtzwiinq_geg@zatzit>
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

On Mon, 8 Sep 2025 14:36:06 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Sep 04, 2025 at 11:15:44AM +0530, Ayush Singh wrote:
> > On 9/4/25 10:53, David Gibson wrote: =20
> > > On Tue, Sep 02, 2025 at 10:57:10AM +0200, Luca Ceresoli wrote: =20
> [snip]
> > > 1) Connector local labels/symbols/aliases
> > >=20
> > > This is not a new idea - both the export-symbols proposal and my
> > > ancient connector proposal had this in one form or another.  I think
> > > something along these lines is almost essential.  Things that plug
> > > into connectors almost always require references to several host board
> > > resources (interrupt controller, gpio, ...).  In order to be pluggable
> > > on multiple host boards you want to refer to those symbolically.  In
> > > order to support multiple instances of the same connector type, you
> > > need those symbols to refer to different things fordifferent connector
> > > instances.

Some of the resources can be "translated" using a nexus node.
It works for interrupt, gpio, pwm, ...

I fact, it should work for all references that use a phandle with a resource
number. I mean any reference in the form 'ref =3D <&ctrl 123>' to reference=
 the
resource 123 of the controller.

=46rom the addon, &ctrl need to be resolved. Using a nexus node at connector =
level
this becomes "ref =3D <&connector 10>;" and considering the connector itsel=
f in the
base tree as a nexus node allows to perform the translation.
   connector {
      gpio-map =3D <10 &ctrl 123>;
   };

but this don't work for a reference that uses only a phandle without any
number (pinctrl for instance) or for busses where devices need to be added.

For busses where devices could be added by the add-on, bus extensions were
introduced (i2c-bus-extension).

In any cases, some symbols need to be referenced from the addon.

> > >=20
> > > Whhat I think is a mistake is trying to tie this too closely to the
> > > existing __symbols__ structure.  Those have an ugly encoding that
> > > requires tortured processing in a way that's not natural for dtb
> > > handling.  Plus they already kinda-sorta duplicate old-school aliases
> > > in an odd way.
> > >=20
> > > You want some sort of string =3D> node mapping on the connector side,
> > > and a way to mark portions of properties on the plugin side as being
> > > resolved to some string reference.  But we can take the opportunity to
> > > design a better way of doing that than the ugly one we have now. =20
> >=20
> >=20
> > Isn't export-symbols exactly this. We do take inspiration from __symbol=
s__.
> > However, in case of export-symbols, its string =3D> phandle mapping (as
> > opposed to string =3D> string in __symbols__). =20
>=20
> As far as the specific It kind of is, yes, and that aspect I like.
> What I'm not convinced by is how export-symbols is proposed to fit in
> with and be used by surrounding logic.  export-symbols has been
> designed to fit in with the existing (ugly) overlay mechanism.  I
> think that's putting the cart before the horse.  Instead work out how
> to logically define connectors first - which will involve information
> equivalent to export-symbols - then work out how to update or replace
> the overlay mechanism to work with that.

I think that a connector is something with a bunch of resources provided
by the board where the connector is soldered. Those resources are wired
to the connector and defined by the connector pinout.

     3v3   ------- Pin 0
  i2c_scl  ------- Pin 1
  i2c_sda  ------- Pin 2
    gpio A ------- Pin 3
    gpio B ------- Pin 4
     gnd   ------- Pin 5

IMHO, this need to be described and defined in the base board and an addon =
can
only reference resources wired and described by the connector node.

Now, questions are:
  - 1) How to describe a connector?
  - 2) How to reference resources provided at connector level from an add-o=
n?

Our current approach was:
---- base board DT ----
  connector0 {
	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 controller=
 */
                   <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2 contr=
oller */
        i2c-one {
		compatible =3D "i2c-bus-extension";
		i2c-parent =3D <i2c5>; /* i2c-one wired to i2c5 controller */
	};

	i2c-two {
		compatible =3D "i2c-bus-extension";
		i2c-parent =3D <i2c6>; /* i2c-two wired to i2c6 controller */
	};

	/*
         * From the addon we need to reference:
         *    - The connector itself,
         *    - Maybe some pinctrl related to signals wired to the connecto=
r,
         *    - In some cases the i2c bus (HDMI, ddc-i2c-bus =3D <&i2c-two>=
;)
         *=20
         * This was solved introducing the controversial export-symbols nod=
e.
         */
  };

---- addon board DT ----
   {
	some-node {
		compatible =3D "foo,bar";
		reset-gpios =3D <&connector 0>; /* gpio A used as a reset gpio */
		ddc-i2c-bus =3D <&i2c-two>;
        }

        i2c-one {
		eeprom@10 {
			compatible =3D "baz,eeprom"
			reg =3D 10;=20
		};
	};
   };

The addon board DT can only be applied at a connector node.
It described the addon board connected to this connector.

>=20
> > I suppose export-symbols could follow aliase conventions, but that stil=
l is
> > a string =3D> string mapping, which seems worse to me than a phandle (s=
ince
> > phandle size is constant).
> >=20
> >  =20
> > >=20
> > > 2) Extend dtb itself
> > >=20
> > > A maor thing that makes current symbols and fixups ugly is the fact
> > > that they are encoded into properties in the device tree itself,
> > > despite being logically at a different semantic level.  Obviously you
> > > *can* do that, but it's not natural.  It would make more sense to add
> > > fixup tags into the dtb format itself. =20
> >=20
> > Having something akin to fixup in dtb format itself would be nice. =20
>=20
> Yes, it would.

What could be the modification expected at dtb to support the connector
use case?

Also what could be the modification expected at dts to described the
connector?

>=20
> > > 3) bus-reg / bus-ranges
> > >=20
> > > One thing that makes connector plugins a bit awkward is that they
> > > often need to add things to multiple buses on the host system (MMIO &
> > > i2c for a simple case).  This means that once resolved the plugin
> > > isn't neatly a single subtree.  That's one factor making removal

It can be a single subtree if decoupling is present at connector node avail=
able
in the base device tree.

All resources wired to the connector should be described in the connector n=
ode
A add-on board should only see resources provided and described at the conn=
ector
node or translated by something (nexus, export-symbols) present in the conn=
ector
node.

> > > really awkward.  Here's an idea I had a while ago to allow plugins to
> > > be a single subtree, by extending what's allowed in the tree content:
> > >=20
> > > Currently a node can only really have a presence on its immediate
> > > parent bus, as encoded in the 'reg' and 'ranges' properties.
> > > 'bus-reg' and 'bus-ranges' would extend that having a similar format
> > > to 'reg' and 'ranges' but adding a phandle for each entry saying which
> > > bus it lives on - somewhat similar to interrupt-map.
> > >=20
> > > For example, here's an MMIO bus bridge of some sort, which has control
> > > registers on I2C:
> > >=20
> > > 	mmio-bus@... {
> > > 		#address-cells =3D < 2 >;
> > > 		#size-cells =3D < 2 >;
> > > 		bridge@XXXX {
> > > 			ranges =3D <...>;
> > > 			bus-reg =3D <&i2c0 0x407>
> > > 		}
> > > 	}
> > > 	i2c0: i2c@... {
> > > 		#address-cells =3D < 1 >;
> > > 		#size-cells =3D < 0 >;
> > > 	}
> > >=20
> > > In a sense this extends the device tree to a device DAG.
> > >=20
> > > Obviously this does need changes at the OS device core level, but it
> > > gives you a lot of flexibility having done so. =20
> >=20
> > There is an i2c-bus-extension [1] and spi-bus-extension proposal to do =
the
> > same. But, if we can figure out a common way for all buses, that would =
be
> > great.

Exactly, this is the purpose of bus extensions.

Also, I don't thing that the 'ranges' property should be used for that purp=
ose.
The 'ranges' property is used to translate addresses from child addresses s=
pace
to parent addresses space.

For instance, in case of i2c, where is the address translation?

The address of a child (device) is its I2C address. This address is
device in its datasheet. There is no reason to have this address depending
on the I2C bus this child is connected to.

In your example, the bridge@XXXX is not related to any hardware components.
If is allows to physically perform I2C transaction from a MMIO device
connected to MMIO bus, this is a traduction I2C controller with a bunch of
registers to configure an perform I2C transactions.
In that case, this "bridge" looks like all I2C we already support in the
kernel.
Having the additional indirection with the "bridge" between the MMIO bus
and the i2c@... node seems not a hardware representation of the system.

Did I miss something?
 =20
>=20
> Heh, right.  That reinforces my thought that this could be a good
> idea.
>=20
> [Btw, the theoretically correct IEEE1275 way to do this is change
>  addressing across the whole tree.  e.g. set #address-cells =3D <3>,
>  with the first cell being, say, 0 for mmio, 1 for i2c, 2 for SPI,
>  then the remaining cells are the address within that bus.  So, this
>  sort of thing is technically possible in old-school OF trees.  That
>  would become pretty unmanageable though.  The idea of bus-reg is to
>  encode the same information in a less awkward way]
>=20
> > [1]:
> > https://lore.kernel.org/all/20250618082313.549140-1-herve.codina@bootli=
n.com/
> >=20
> > [2]: https://lore.kernel.org/all/20250729-spi-bus-extension-v1-0-b20c73=
f2161a@beagleboard.org/
> >=20
> >  =20
> > > 4) You don't necessarily need to build a "full" device tree
> > >=20
> > > Flattened device trees (as opposed to original IEEE1275 device trees)
> > > - by design - allow certain information to be omitted.  The most
> > > common example is that for introspectable buses, like PCI, it's normal
> > > to have the DT only include a node for the host bridge, with devices
> > > under it being discovered by their own bus specific methods.  That's
> > > discovery is handled by the bus/bridge driver.
> > >=20
> > > Connectors usually aren't introspectable, but it's still possible to
> > > use an approach like this where the connector driver's discovery
> > > method is "look at a different device tree".  So, for example,
> > >=20
> > > Board device tree:
> > >=20
> > > / {
> > > 	compatible =3D "board-with-foo-connector";
> > > 	. . .
> > > 	mmio@... {
> > > 		foo-connector@... {
> > > 			compatible =3D "foo-connector";
> > > 			ranges =3D < ... >;
> > > 		}
> > > 	}
> > > }

I would expect a description of resources wired to the connector
available at the foo-connector node.

> > >=20
> > > Foo device tree:
> > >=20
> > > / {
> > > 	compatible =3D "foo-device";
> > > 	foo-port-id =3D < 0x1234 >;
> > > 	component@... {
> > > 		reg =3D < ... >;
> > > 	}
> > > }
> > >=20
> > > Obviously a "foo device tree" would have different conventions than a
> > > board device tree.  It wouldn't have /cpus, /memory, /chosen - but it
> > > could have its own "magic" nodes that make sense for the properties of
> > > the specific connector type.

I agree with the fact that /cpus, /memory, ... wouldn't be present at this
node.=20

Can you provide an example of the "magic" node and what do you have in mind
to store this information in DTB?

> > >=20
> > > Again, that would require work in the device core part of the OS.  The
> > > bonus is that runtime addition and removal is now trivial.  No hacking
> > > of the base device tree is needed, and so doesn't need to be reverted.
> > > The connector driver just adds/removes the reference to its own
> > > private tree.

Here also, I don't see exactly what you have in mind. Can you provide some
details and example?

> > >=20
> > > This would, of course, need some way to refer to board resources
> > > (interrupt controller, gpio controller) etc.  I think that can be
> > > assembled using some of the previous ideas, though. =20
> >=20
> > I would need to wrap my head around this a bit, specially in context of
> > chaining connectors. It does seem like it will still require the points=
 you
> > mentioned above to be present in one form or another, i.e. some way to
> > extend busses to different nodes/trees and connector (even a chained on=
e)
> > local symbols/aliases. =20
>=20
> Yes, it would still require those mappings.  I don't think chained
> connectors introduce a lot of extra complication.  An intermediate
> connector would need to be able to "re-export" things it got from its
> parent connector to its child connector(s) - renaming them if
> necessary.
>=20
> I think those two elements would be enough to make something that's
> useful in at least a few cases.  However, the pretty common case of a
> connector with pins from multiple different parent buses would need
> bus-reg or something similar.  Or else the nasty multiplexed encoding
> described above.
>=20
> I say, "nasty" and in many cases it would be, but I think there may be
> some cases where that approach does make sense: e.g. a connector that
> has several logically separate address spaces but which always travel
> together and are typically handled by a common bridge device.  PCI is
> a case of this, if you squint - a host bridge provides a config space
> bus, and an MMIO bus and a PIO bus.  Also sometimes some sort of
> interrupt controller / interrupt routing, complicated by the fact that
> there are several different models for that across PCI and PCI-E.
>=20

To move forward on the topic, some concrete example would help to
understand how to describe link, how the information is stored in DTB.

This would help us in moving in the right direction.


If the issue with export-symbols is having it described as a DTS node, this
could be changed with a new DTS keyword.

/export/ <symbol_name_to_resolve> <resolved_symbol_name>
  - <symbol_name_tp_resolved>: Symbol name seen by a user
  - <resolved_symbol_name>: Symbol used once resolved.

<resolved_symbol_name> can be restricted to phandle values.

Mutiple /export/ can be available inside a node in order to give a list
of exported symbols.


For instance with the connector example I previously mentioned.
We can replace the export-symbols node by the following:

---- base board DT ----
  conn0: connector0 {
	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 controller=
 */
                   <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2 contr=
oller */

        i2c_one: i2c-one {
		compatible =3D "i2c-bus-extension";
		i2c-parent =3D <i2c5>; /* i2c wired to i2c5 controller */
	};

	i2c_two: i2c-two {
		compatible =3D "i2c-bus-extension";
		i2c-parent =3D <i2c6>; /* i2c wired to i2c6 controller */
	};

	/export/ connector &conn0
	/export/ i2cA &i2c_one
	/export/ i2cB &i2c_two
  };

A reference to connector (&connector) from the addon will be resolve
to a reference to &conn0 (phandle of the connector0 node.

---- addon board DT, applied at connector0 node ----
   {
	some-node {
		compatible =3D "foo,bar";
		reset-gpios =3D <&connector 0>; /* gpioA used as a reset gpio */
		ddc-i2c-bus =3D <&i2cB> /* Resolved thanks to /export/ */
	=09
        }

        i2c-one {
		/*
                 * A device added on the i2c-one bus wire to the connector.
                 * /export/ not involved. i2c-one is a node (bus extension)=
 available
                 * in the DT node where this addon board DT is applied.
                 *=20
                 */
		eeprom@10 {
			compatible =3D "baz,eeprom"
			reg =3D 10;=20
		};
	};
   };


Now, what is expected in term of DTB format?

I think we need:
 - Base DT: List of exported symbols per nodes (/export/)
 - Addon DT: List of unresolved symbols and their location
 - Addon DT: A way to avoid collision in phandle values

Best regards,
Herv=C3=A9

