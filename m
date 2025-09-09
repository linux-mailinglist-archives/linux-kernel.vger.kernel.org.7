Return-Path: <linux-kernel+bounces-807742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8CFB4A89E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66404E0364
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA72D3EEE;
	Tue,  9 Sep 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KvD/xBvu"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C52D3759;
	Tue,  9 Sep 2025 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410914; cv=none; b=MndkjVEycjRN6t7rkTiePI8Cz+GtC/SZNI2nJuPUdMVOxe6bXY4jH4vMbCV4yGIkzY1dGYW5c1XfmP97kSXzSJRO/HTWE6b1vdeB7l6uo+oNvvdVU2g55dOSE0YzZuXybxRgatlyE5z5GJwEa9tBSOJzp5+T6wAhS0yhOSPDLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410914; c=relaxed/simple;
	bh=e7UYasOYGtTZq+ZtMuU25FBXt2S7pooNSuZnmwNsnMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtFWd3rDkI6z27iHQ5IVkmaUXvZkgxAQpw9S0sqJqyqFtK/L1MFYjp5UP3DKmWuyAaicd3LJwKlrsQp9THhrGyj53+9ok+UKDCX1MeSUpbHY/FtT1fyoI74M6mxIWSNpaWGtkxf3+8TTtXUGTfTYE037SVdMFyG6MQwtSaX13iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KvD/xBvu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5CA711A0E36;
	Tue,  9 Sep 2025 09:41:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F96C60630;
	Tue,  9 Sep 2025 09:41:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD80A102F27E5;
	Tue,  9 Sep 2025 11:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757410903; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=X5A2AY+MXh4lm7lJvub1+o03Q19c0vcycDJ1fDb5yjE=;
	b=KvD/xBvubushTQq6ie5aLd9a3zvntJk6c1GBG90MxCHS6xvDDSSDmCc1GN8ZCnTJZzXlHE
	lDTN8z2PIJ3TcXRGXjcM195K/9ygegUxwUGBR6dqEVJcgIfjeovmcWy2CnXDnslGeEnviH
	ct2miESrt/vUpPE7jLKY7ykJootpsGtXllqAUXPe2FDlP77k9mEhUc34WaZAq3VsQfzL/K
	Og9uKLDKFqzeSW98FRJ2/eMUe0BeoImzta8oeWfI+D/TWQJ1gRtc95cMKbGLBhLUWYOpby
	TIRkBnfZ30bhMEu+Q/z3E2Xo15Vk4v+Oqjop6H2hmveBsADSL2qVUEKvOsWFPg==
Date: Tue, 9 Sep 2025 11:41:26 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: David Gibson <david@gibson.dropbear.id.au>, Ayush Singh
 <ayush@beagleboard.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, devicetree@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250909114126.219c57b8@bootlin.com>
In-Reply-To: <aL-2fmYsbexEtpNp@zatzit>
References: <20250902105710.00512c6d@booty>
	<aLkiNdGIXsogC6Rr@zatzit>
	<337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
	<aL5dNtzwiinq_geg@zatzit>
	<20250908145155.4f130aec@bootlin.com>
	<aL-2fmYsbexEtpNp@zatzit>
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

On Tue, 9 Sep 2025 15:09:18 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

...

> > I think that a connector is something with a bunch of resources provided
> > by the board where the connector is soldered. Those resources are wired
> > to the connector and defined by the connector pinout.
> >=20
> >      3v3   ------- Pin 0
> >   i2c_scl  ------- Pin 1
> >   i2c_sda  ------- Pin 2
> >     gpio A ------- Pin 3
> >     gpio B ------- Pin 4
> >      gnd   ------- Pin 5
> >=20
> > IMHO, this need to be described and defined in the base board and an ad=
don can
> > only reference resources wired and described by the connector node. =20
>=20
> Yes, that's exactly what I'm proposing too.
>=20
> > Now, questions are:
> >   - 1) How to describe a connector?
> >   - 2) How to reference resources provided at connector level from an a=
dd-on? =20
>=20
> Right.
>=20
> > Our current approach was:
> > ---- base board DT ----
> >   connector0 {
> > 	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 contro=
ller */
> >                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2 c=
ontroller */
> >         i2c-one {
> > 		compatible =3D "i2c-bus-extension";
> > 		i2c-parent =3D <i2c5>; /* i2c-one wired to i2c5 controller */
> > 	};
> >=20
> > 	i2c-two {
> > 		compatible =3D "i2c-bus-extension";
> > 		i2c-parent =3D <i2c6>; /* i2c-two wired to i2c6 controller */
> > 	};
> >=20
> > 	/*
> >          * From the addon we need to reference:
> >          *    - The connector itself,
> >          *    - Maybe some pinctrl related to signals wired to the conn=
ector,
> >          *    - In some cases the i2c bus (HDMI, ddc-i2c-bus =3D <&i2c-=
two>;)
> >          *=20
> >          * This was solved introducing the controversial export-symbols=
 node.
> >          */ =20
>=20
> I think the type of connector should also be named on both sides (with
> 'compatible' or something like it).

It makes sense.

>=20
> >   };
> >=20
> > ---- addon board DT ----
> >    {
> > 	some-node {
> > 		compatible =3D "foo,bar";
> > 		reset-gpios =3D <&connector 0>; /* gpio A used as a reset gpio */
> > 		ddc-i2c-bus =3D <&i2c-two>;
> >         }
> >=20
> >         i2c-one {
> > 		eeprom@10 {
> > 			compatible =3D "baz,eeprom"
> > 			reg =3D 10;=20
> > 		};
> > 	};
> >    };
> >=20
> > The addon board DT can only be applied at a connector node. =20
>=20
> Right.  This is not how overlays work now.  By the nature of how
> they're built they apply global updates to the base tree.  That means
> we need to spec a new way of describing addons that *is* restricted to
> a particular connector slot (or slots, as Geert points out).  Since we
> have that opportunity, we should _not_ try to make it a minimal
> extension to existing overlay format, but define a new and better
> encoding, designed to meet the problems you're looking to address.

On the kernel side, overlays can be applied at a specific node.
The node is chosen when the overlay is apply.
  https://elixir.bootlin.com/linux/v6.16/source/drivers/of/overlay.c#L970

This allows to apply an overlay to a specific node without any modification
of the overlay dtb (dtbo).

Ajush proposed an update to support this feature in fdtoverlay
  https://lore.kernel.org/all/20250313-fdtoverlay-target-v1-0-dd5924e12bd3@=
beagleboard.org/

...
>=20
> > > > > 3) bus-reg / bus-ranges
> > > > >=20
> > > > > One thing that makes connector plugins a bit awkward is that they
> > > > > often need to add things to multiple buses on the host system (MM=
IO &
> > > > > i2c for a simple case).  This means that once resolved the plugin
> > > > > isn't neatly a single subtree.  That's one factor making removal =
=20
> >=20
> > It can be a single subtree if decoupling is present at connector node a=
vailable
> > in the base device tree. =20
>=20
> Right - allowing that decoupling is exactly what I'm proposing bus-reg
> for.  Note that the case of an addon that plugs into multiple
> connectors that Geert pointed out complicates this again.

Geert's use case needs to be clarified.

Suppose a base board with 2 connectors:
 - connA
 - connB

Case 1: Addons are independant
               +--------+
  connA <----> | AddonA |
               +--------+
                          +--------+
  connB <---------------->| AddonB |
                          +--------+

With addonA and B two addon board each connected at one connector without a=
ny
relationship between addon A and B

Case 2: Only one Addons using ressources from both connector

                +------+
  connA <-----> |Addon |
                |      |
  connB <-----> |      |
                +------+

The addon is connected to both connector and uses ressources from connA and
connB in a dependent manner.


The Case 2 can be solved using a connector that described both connA and co=
nnB.
Having the split connA and connB is a mechanical point of view.

Also adding and Addon on only one part (connA for instance) should not be a=
n issue
if the connector describe both parts.

but well, here again I can miss something.
Geert, can you provide details?

...

> > > >=20
> > > > There is an i2c-bus-extension [1] and spi-bus-extension proposal to=
 do the
> > > > same. But, if we can figure out a common way for all buses, that wo=
uld be
> > > > great. =20
> >=20
> > Exactly, this is the purpose of bus extensions. =20
>=20
> Right, but redefining it for each bus type seems silly.

Nexus node properties are re-defined for each kind of resources (interrupt,
gpio, pwm, ...).

Why not for bus extensions.

Also I am pretty sure that some bus extension will need to define some
properties specific to the bus related to the extension.

>=20
> > Also, I don't thing that the 'ranges' property should be used for that =
purpose.
> > The 'ranges' property is used to translate addresses from child address=
es space
> > to parent addresses space. =20
>=20
> The rationale for bus-ranges is that the add-on board could re-expose
> one of the buses on the connector (say MMIO for simplicity) to several
> chips physically included on the addon board.  We don't want those
> sub-chips to need different device nodes depending on whether they're
> on an addon board or wired directly onto a main board.  bus-ranges
> would allow the root of the connector to create a subtree in which
> regular MMIO (or whatever) devices can be described, and then routed
> via the connector onto the bus on the main board.

bus extensions supports this feature without bus-regs nor bus-ranges.

A bus extension ended by a sub node in the connector node.
Applying the addon DT at the connector node allow the addon to had
subnode to the extension node.

>=20
> > For instance, in case of i2c, where is the address translation? =20
>=20
> I think i2c multiplexers can sometimes do that.  But in any case,
> ranges can be used for 1:1 translation as well.

i2c multiplexers are physical devices performing some internal logic.
They are real bridges and route an upstream i2c bus to downstream
i2c busses.
They are handled by a specific driver.

>=20
> > The address of a child (device) is its I2C address. This address is
> > device in its datasheet. There is no reason to have this address depend=
ing
> > on the I2C bus this child is connected to. =20
>=20
> Maybe not for I2C, but other buses can certainly allow translation, so
> the flexibility is needed.
>=20
> > In your example, the bridge@XXXX is not related to any hardware compone=
nts. =20
>=20
> I'm not sure what you mean by that.

We have just wires from a controller to a connector. No bridges
nor other devices between the controller and the connector.

The controller is described in the base device tree, the connector is
described in the base device tree and the physical links between the contro=
ller
and the connector are wires on PCB.

If a physical device is present between the controller and the connector
such as a i2c mux, this physical device is allready described in the base D=
T.

In that case, your "bridge" will be betweeh the i2c mux and the connector.

In the extension bus case, the extension bus is between the i2c mux and the
connector.

>=20
> > If is allows to physically perform I2C transaction from a MMIO device
> > connected to MMIO bus, this is a traduction I2C controller with a bunch=
 of
> > registers to configure an perform I2C transactions. =20
>=20
> Yes, absolutely.  The i2c in bus-reg there is not supposed to indicate
> that the bridge is used to access i2c devices.  Rather it's saying
> that the bridge itself has configuration registers accessible via i2c.
>=20
> If a device does have its own i2c bus hanging off, then as you say
> there should not be a 'ranges' property.  It would have its own i2c
> controller driver.
>=20
> bus-ranges could be used when a connector has pins on multiple MMIO
> buses, and an addon could have sub-devices on either one of them.
>=20
> Note that bus-ranges translated between i2c buses isn't theoretically
> impossible: that would represent a case with some sort of I2C "relay"
> device that forwards I2C commands from one side to the other altering
> the address on the way.  I don't know if such devices exist in
> practice, but they're certainly theoretically possible (and could be
> used, e.g. for allowing 10-bit I2C devices to be accessed from an old
> 7-bit I2C bus).
>=20
> > In that case, this "bridge" looks like all I2C we already support in the
> > kernel.
> > Having the additional indirection with the "bridge" between the MMIO bus
> > and the i2c@... node seems not a hardware representation of the system.
> >=20
> > Did I miss something? =20
>=20
> I think so.  That's representing the bridge itself being configured
> via I2C, not allowing I2C access to devices _on_ the bus.

If I understand correctly the addon board can configure the bridge availabl=
e on
the base board.

How do you describe that when you have everything soldered on a base board
and described in a base DT?

I think that the description should be the same with when some devices
are soldered on an addon board connected to a connector.

The only difference should be the location of the nodes. Indeed, those
devices, on the addon board, behid the connector, should be described
as subnodes of the connector.

Extension bus is exactly for that purpose.

...

> > > > > 4) You don't necessarily need to build a "full" device tree
> > > > >=20
> > > > > Flattened device trees (as opposed to original IEEE1275 device tr=
ees)
> > > > > - by design - allow certain information to be omitted.  The most
> > > > > common example is that for introspectable buses, like PCI, it's n=
ormal
> > > > > to have the DT only include a node for the host bridge, with devi=
ces
> > > > > under it being discovered by their own bus specific methods.  Tha=
t's
> > > > > discovery is handled by the bus/bridge driver.
> > > > >=20
> > > > > Connectors usually aren't introspectable, but it's still possible=
 to
> > > > > use an approach like this where the connector driver's discovery
> > > > > method is "look at a different device tree".  So, for example,
> > > > >=20
> > > > > Board device tree:
> > > > >=20
> > > > > / {
> > > > > 	compatible =3D "board-with-foo-connector";
> > > > > 	. . .
> > > > > 	mmio@... {
> > > > > 		foo-connector@... {
> > > > > 			compatible =3D "foo-connector";
> > > > > 			ranges =3D < ... >;
> > > > > 		}
> > > > > 	}
> > > > > } =20
> >=20
> > I would expect a description of resources wired to the connector
> > available at the foo-connector node. =20
>=20
> Possibly yes.  Here I was assuming a case where the resources
> presented by a "foo-connector" are fixed and described in a
> foo-connector binding.  But an approach which explicitly describes the
> exposed resources could certainly have advantages.
>=20
> > > > >=20
> > > > > Foo device tree:
> > > > >=20
> > > > > / {
> > > > > 	compatible =3D "foo-device";
> > > > > 	foo-port-id =3D < 0x1234 >;
> > > > > 	component@... {
> > > > > 		reg =3D < ... >;
> > > > > 	}
> > > > > }
> > > > >=20
> > > > > Obviously a "foo device tree" would have different conventions th=
an a
> > > > > board device tree.  It wouldn't have /cpus, /memory, /chosen - bu=
t it
> > > > > could have its own "magic" nodes that make sense for the properti=
es of
> > > > > the specific connector type. =20
> >=20
> > I agree with the fact that /cpus, /memory, ... wouldn't be present at t=
his
> > node.=20
> >=20
> > Can you provide an example of the "magic" node and what do you have in =
mind
> > to store this information in DTB? =20
>=20
> One obvious one is somewhere to store a mapping / renaming of
> resources for local use on the connector.  Another might be for
> metadata, like an ID code, if this connector type supports it.
>=20
> > > > > Again, that would require work in the device core part of the OS.=
  The
> > > > > bonus is that runtime addition and removal is now trivial.  No ha=
cking
> > > > > of the base device tree is needed, and so doesn't need to be reve=
rted.
> > > > > The connector driver just adds/removes the reference to its own
> > > > > private tree. =20
> >=20
> > Here also, I don't see exactly what you have in mind. Can you provide s=
ome
> > details and example? =20
>=20
> What I'm suggesting is that the "main" DT managed by the kernel would
> never include devices from the addon board.  Instead the connector
> driver would locally a store a different device tree representing just
> the things under the connector.  It would present a bus to the kernel
> device core that would "discover" devices on the bus based on that
> local device tree.

We agree with that and this is what we have proposed with our connector
binding.
The main DT has to provide (describe) busses that can be used by the addon
(adding devices to those busses).

Our binding with bus extension fulfills this requirement.

>=20
> > > > > This would, of course, need some way to refer to board resources
> > > > > (interrupt controller, gpio controller) etc.  I think that can be
> > > > > assembled using some of the previous ideas, though.   =20
> > > >=20
> > > > I would need to wrap my head around this a bit, specially in contex=
t of
> > > > chaining connectors. It does seem like it will still require the po=
ints you
> > > > mentioned above to be present in one form or another, i.e. some way=
 to
> > > > extend busses to different nodes/trees and connector (even a chaine=
d one)
> > > > local symbols/aliases.   =20
> > >=20
> > > Yes, it would still require those mappings.  I don't think chained
> > > connectors introduce a lot of extra complication.  An intermediate
> > > connector would need to be able to "re-export" things it got from its
> > > parent connector to its child connector(s) - renaming them if
> > > necessary.
> > >=20
> > > I think those two elements would be enough to make something that's
> > > useful in at least a few cases.  However, the pretty common case of a
> > > connector with pins from multiple different parent buses would need
> > > bus-reg or something similar.  Or else the nasty multiplexed encoding
> > > described above.
> > >=20
> > > I say, "nasty" and in many cases it would be, but I think there may be
> > > some cases where that approach does make sense: e.g. a connector that
> > > has several logically separate address spaces but which always travel
> > > together and are typically handled by a common bridge device.  PCI is
> > > a case of this, if you squint - a host bridge provides a config space
> > > bus, and an MMIO bus and a PIO bus.  Also sometimes some sort of
> > > interrupt controller / interrupt routing, complicated by the fact that
> > > there are several different models for that across PCI and PCI-E. =20
> >=20
> > To move forward on the topic, some concrete example would help to
> > understand how to describe link, how the information is stored in DTB.
> >=20
> > This would help us in moving in the right direction.
> >=20
> >=20
> > If the issue with export-symbols is having it described as a DTS node, =
this
> > could be changed with a new DTS keyword.
> >=20
> > /export/ <symbol_name_to_resolve> <resolved_symbol_name>
> >   - <symbol_name_tp_resolved>: Symbol name seen by a user
> >   - <resolved_symbol_name>: Symbol used once resolved. =20
>=20
> I might have some quibbles with the details, but I'd be open to
> something like that.

Ok

>=20
> > <resolved_symbol_name> can be restricted to phandle values. =20
>=20
> Because we're operating at the dts level here, whether it's a phandle
> is not actually relevant.  We can treat this as a dts label name (or
> optionally path) - how that's encoded in the dtb we get to choose. A
> phandle is the most obvious approach.
>=20
> > Mutiple /export/ can be available inside a node in order to give a list
> > of exported symbols. =20
>=20
> Sure.
>=20
> > For instance with the connector example I previously mentioned.
> > We can replace the export-symbols node by the following:
> >=20
> > ---- base board DT ----
> >   conn0: connector0 {
> > 	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 contro=
ller */
> >                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2 c=
ontroller */
> >=20
> >         i2c_one: i2c-one {
> > 		compatible =3D "i2c-bus-extension";
> > 		i2c-parent =3D <i2c5>; /* i2c wired to i2c5 controller */ =20
>=20
> I think bus-reg or bus-ranges is a more natural way to do this than
> per-bus bindings, but that's not particularly relevant to the rest of
> the proposal.
>=20
> > 	};
> >=20
> > 	i2c_two: i2c-two {
> > 		compatible =3D "i2c-bus-extension";
> > 		i2c-parent =3D <i2c6>; /* i2c wired to i2c6 controller */
> > 	};
> >=20
> > 	/export/ connector &conn0
> > 	/export/ i2cA &i2c_one
> > 	/export/ i2cB &i2c_two =20
>=20
> Since dtc is explicitly aware of this, we could even allow relative
> paths here, say
> 	/export/ connector &.;

Indeed, good point.

>=20
>=20
> >   };
> >=20
> > A reference to connector (&connector) from the addon will be resolve
> > to a reference to &conn0 (phandle of the connector0 node. =20
>=20
> To handle the addon with multiple connectors we might want an
> (optional) remapping / renaming on the addon side as well.  Or maybe
> simpler, we could allow namespacing the references on the addon side.

I think you talk about the Geert use case.
Geert, an example should be welcome.

The plan was to apply the DT related to an addon at a connector node.
Maybe this will not fit well with Geert's use case but to know if it
fits or not and to find the best way to handle this use case, an
example is needed.

>=20
> >=20
> > ---- addon board DT, applied at connector0 node ----
> >    {
> > 	some-node {
> > 		compatible =3D "foo,bar";
> > 		reset-gpios =3D <&connector 0>; /* gpioA used as a reset gpio */
> > 		ddc-i2c-bus =3D <&i2cB> /* Resolved thanks to /export/ */
> > 	=09
> >         }
> >=20
> >         i2c-one {
> > 		/*
> >                  * A device added on the i2c-one bus wire to the connec=
tor.
> >                  * /export/ not involved. i2c-one is a node (bus extens=
ion) available
> >                  * in the DT node where this addon board DT is applied.
> >                  *=20
> >                  */
> > 		eeprom@10 {
> > 			compatible =3D "baz,eeprom"
> > 			reg =3D 10;=20
> > 		};
> > 	};
> >    };
> >=20
> >=20
> > Now, what is expected in term of DTB format?
> >=20
> > I think we need: =20
>=20
> >  - Base DT: List of exported symbols per nodes (/export/) =20
>=20
> Yes.  I'm not necessarily opposed to encoding this as a regular
> property (basically, 'exported-symbols').  It's more the fixup
> information that is horrible as regular properties.  Connectors should
> also probably have a property marking them *as* a connector and giving
> the type.

I thought that exported-symbols (or export-symbols) node was a no go.

With our proposal, nothing change in current __symbols__, __fixup__ and
__local_fixup__ implementation.

We just add the export-symbols item in current resolution process.

Even if a new DTB format landed, we should support already existing format.

>=20
> If we didn't want a regular property we could encode this as an
> FDT_EXPORT tag.  These would go after FDT_BEGIN_NODE, before FDT_PROP
> and each include a (local-name, phandle) tuple.  local-name could be a
> string table reference.
>=20
> >  - Addon DT: List of unresolved symbols and their location =20
>=20
> Not sure we need this as a singular list, see below.
>=20
> >  - Addon DT: A way to avoid collision in phandle values =20
>=20
> I'd suggest maybe three new tags for this, these would appear
> immediately after the FDT_PROP tag to which they're relevant.
>=20
> 	FDT_REF_PHANDLE		(offset, name)
>=20
> This would replace the 4 bytes at `offset` in the previous property
> with the phandle of the node referred to by `name` (which must match
> something in the connector's exported list).
>=20
> 	FDT_REF_PATH		(offset, name)
>=20
> Similar but would insert the full path name of the referenced node in
> the property.
>=20
> 	FDT_REF_LOCAL		(offset)
>=20
> This indicates that that offset in the property contains a phandle
> value pointing to something within the addon - when we adjust addon
> phandles to avoid collisions, it needs to be updated too.

Ok for FDT_REF_PHANDLE(), FDT_REF_PATH() and FDT_REF_LOCAL().

They replace __fixups__ and __local_fixups__ but we need also
something to replace __symbols__ and the "export-symbols"

Solution 1:=20

  A new section is needed.
  we have dt_struct and dt_strings. dt_symbols could be this new section.

  In this section we have table(s) of exported symbols. In term of
  information, I think we need:
   - The symbol name
   - The node exporting the symbol (path)
   - The symbol source:
       - node referenced by the symbol (path)
       - phandle referenced by the symbol
       - original name for symbol remapping


Solution 2:
  At nodes exporting symbols we could had:
     - FDT_EXPORT_PHANDLE(name, phandle)
       with name, the exported symbol name and phandle, the phandle value.

     - FDT_EXPORT_PATH(name, path)
       with name, the exported symbol name and path, the path to exported
       object

     - FDT_EXPORT_REMAP(name, orig_name)
       with name, the exported symbol name and orig_name, the original symb=
ol
       name remapped to the exported symbol name.

>=20
> The addon should also include information on the type of connector(s)
> it wants to plug into.  That should be a stringlist, like
> 'compatible', to allow for backwards compatible future extensions.

This information (if needed) is used by the driver applying the connector.
I don't think if should be involved in the symbol resolution mechanism.

=46rom the symbol resolution point of view, we have:
- A base DT,
- A specific node in the base DT where the addon should be added
- The addon DT.

With this 3 inputs, the symbol resolution should do its work.
It should not check any compatible strings values.

>=20
>=20
> Or... allowing for addons plugging into multiple connectors, possibly
> each of those `name`s needs to be extended to (connector, name).
> `connector` would be either a name or index saying which connector
> we're referring to (numbering/naming controlled by the addon) with
> name being the name of the symbol within that connector (naming
> controlled by the base board / connector type).
>=20

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

