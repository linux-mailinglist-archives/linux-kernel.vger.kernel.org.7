Return-Path: <linux-kernel+bounces-807167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F7B4A11D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB81B24456
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58922EB849;
	Tue,  9 Sep 2025 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="an6tm7Xn"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F0221F26;
	Tue,  9 Sep 2025 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394578; cv=none; b=pkV99nIkDMzUKHZOb00SDCQIwe7NdOWl9kNHuy1BK4jilzTwQS0mhZDYGlPZ1KTYxeQtWocZPtL0M1s/7lwrEcAmD4UHsT72TGpYPNQEjb75KeILGsi/DtuNaiAFfBADfFOY0K2LxaHgJJWz2x2uS8OpGs4IxKxVkWGioepI3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394578; c=relaxed/simple;
	bh=3hqi8nlFEGPiPvIWwD7rrY1j1fH0hrAWBU5I8SEAtYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR5QxV+9HRObMmNPkhAg/e/D55czpjY8BLXGg3bi5QOwiN/L79QlJwFbbDBXOtmF2KST924pDh8r9hjpGDeFoB+ardmM2tpN1z+goVVAbxn5LT43eoETg351xuqPb3BCyutIyPDje7JzI05vKu9/ieQEVg10FEFpQmmzm0/9Ag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=an6tm7Xn; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757394571;
	bh=+MA4KqA+LAlzHpCJGi4D20X2DF4o7JYRNuZhgn0y4ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=an6tm7Xn0c/kZIyePMTR0zIrbiFBkf0ujHFf3E+QkSgSq9YR6h2yTmZda5CLisptu
	 0oRpUWmVoahdi5frCM5shnwmzJnlYSVGxwA1BZu+h/8FpUcswSV/GyTpjmAOsICsW8
	 DioanWz0d0XxJ9nMPACR+MkR2V+5DeKG8CQKe5JpQLH4F3mqCQJOl+0tLiK3qazjBj
	 QQ7cOqIeQIuJo9J45VbEniu/OhxpxNRPH+QEjY3+tslepaChk2i4+fsaS+0qECv/ft
	 FNcSRU4hy5VNofeFnS/iKbdLsA8sy2LuVOpVmAPRoqPjSdkZNHSM6RnR70EhB/EbIz
	 8pa2QlAeQs5nA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cLX1R5HLLz4w9k; Tue,  9 Sep 2025 15:09:31 +1000 (AEST)
Date: Tue, 9 Sep 2025 15:09:18 +1000
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
Message-ID: <aL-2fmYsbexEtpNp@zatzit>
References: <20250902105710.00512c6d@booty>
 <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
 <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S7wZp+CnZ37F+QWG"
Content-Disposition: inline
In-Reply-To: <20250908145155.4f130aec@bootlin.com>


--S7wZp+CnZ37F+QWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 02:51:55PM +0200, Herve Codina wrote:
> Hi David,
>=20
> On Mon, 8 Sep 2025 14:36:06 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Sep 04, 2025 at 11:15:44AM +0530, Ayush Singh wrote:
> > > On 9/4/25 10:53, David Gibson wrote: =20
> > > > On Tue, Sep 02, 2025 at 10:57:10AM +0200, Luca Ceresoli wrote: =20
> > [snip]
> > > > 1) Connector local labels/symbols/aliases
> > > >=20
> > > > This is not a new idea - both the export-symbols proposal and my
> > > > ancient connector proposal had this in one form or another.  I think
> > > > something along these lines is almost essential.  Things that plug
> > > > into connectors almost always require references to several host bo=
ard
> > > > resources (interrupt controller, gpio, ...).  In order to be plugga=
ble
> > > > on multiple host boards you want to refer to those symbolically.  In
> > > > order to support multiple instances of the same connector type, you
> > > > need those symbols to refer to different things fordifferent connec=
tor
> > > > instances.
>=20
> Some of the resources can be "translated" using a nexus node.
> It works for interrupt, gpio, pwm, ...

Yes, I expect that will be necessary.

> I fact, it should work for all references that use a phandle with a resou=
rce
> number. I mean any reference in the form 'ref =3D <&ctrl 123>' to referen=
ce the
> resource 123 of the controller.

Well, as long as they have a way of defining a nexus / map.  That's
true of interrupts of course, but I'm not really familiar with the
more modern instances.

> From the addon, &ctrl need to be resolved. Using a nexus node at connecto=
r level
> this becomes "ref =3D <&connector 10>;" and considering the connector its=
elf in the

Right, this requires at least 'connector' to be resolvable as an
external resource.  If that's possible, I'm not sure that allowing
multiple symbols to be resolved to the base tree is notably more
complex.

> base tree as a nexus node allows to perform the translation.
>    connector {
>       gpio-map =3D <10 &ctrl 123>;
>    };
>=20
> but this don't work for a reference that uses only a phandle without any
> number (pinctrl for instance) or for busses where devices need to be adde=
d.

That might be true in practice, but there's nothing inherently true
about this - it just depends on what the bindings define in terms of
nexus / remapping options.

> For busses where devices could be added by the add-on, bus extensions were
> introduced (i2c-bus-extension).

I think bus-reg is a more natural way to do this for any bus without
needing to set up bindings for each new bus type.

> In any cases, some symbols need to be referenced from the addon.

Well, certain base tree nodes need to be referred to by the addon, so
"symbols" in some sense.  That doesn't necessarily have to be done by
the existing symbols mechanism.

> > > > Whhat I think is a mistake is trying to tie this too closely to the
> > > > existing __symbols__ structure.  Those have an ugly encoding that
> > > > requires tortured processing in a way that's not natural for dtb
> > > > handling.  Plus they already kinda-sorta duplicate old-school alias=
es
> > > > in an odd way.
> > > >=20
> > > > You want some sort of string =3D> node mapping on the connector sid=
e,
> > > > and a way to mark portions of properties on the plugin side as being
> > > > resolved to some string reference.  But we can take the opportunity=
 to
> > > > design a better way of doing that than the ugly one we have now. =
=20
> > >=20
> > >=20
> > > Isn't export-symbols exactly this. We do take inspiration from __symb=
ols__.
> > > However, in case of export-symbols, its string =3D> phandle mapping (=
as
> > > opposed to string =3D> string in __symbols__). =20
> >=20
> > As far as the specific It kind of is, yes, and that aspect I like.
> > What I'm not convinced by is how export-symbols is proposed to fit in
> > with and be used by surrounding logic.  export-symbols has been
> > designed to fit in with the existing (ugly) overlay mechanism.  I
> > think that's putting the cart before the horse.  Instead work out how
> > to logically define connectors first - which will involve information
> > equivalent to export-symbols - then work out how to update or replace
> > the overlay mechanism to work with that.
>=20
> I think that a connector is something with a bunch of resources provided
> by the board where the connector is soldered. Those resources are wired
> to the connector and defined by the connector pinout.
>=20
>      3v3   ------- Pin 0
>   i2c_scl  ------- Pin 1
>   i2c_sda  ------- Pin 2
>     gpio A ------- Pin 3
>     gpio B ------- Pin 4
>      gnd   ------- Pin 5
>=20
> IMHO, this need to be described and defined in the base board and an addo=
n can
> only reference resources wired and described by the connector node.

Yes, that's exactly what I'm proposing too.

> Now, questions are:
>   - 1) How to describe a connector?
>   - 2) How to reference resources provided at connector level from an add=
-on?

Right.

> Our current approach was:
> ---- base board DT ----
>   connector0 {
> 	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 controll=
er */
>                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2 con=
troller */
>         i2c-one {
> 		compatible =3D "i2c-bus-extension";
> 		i2c-parent =3D <i2c5>; /* i2c-one wired to i2c5 controller */
> 	};
>=20
> 	i2c-two {
> 		compatible =3D "i2c-bus-extension";
> 		i2c-parent =3D <i2c6>; /* i2c-two wired to i2c6 controller */
> 	};
>=20
> 	/*
>          * From the addon we need to reference:
>          *    - The connector itself,
>          *    - Maybe some pinctrl related to signals wired to the connec=
tor,
>          *    - In some cases the i2c bus (HDMI, ddc-i2c-bus =3D <&i2c-tw=
o>;)
>          *=20
>          * This was solved introducing the controversial export-symbols n=
ode.
>          */

I think the type of connector should also be named on both sides (with
'compatible' or something like it).

>   };
>=20
> ---- addon board DT ----
>    {
> 	some-node {
> 		compatible =3D "foo,bar";
> 		reset-gpios =3D <&connector 0>; /* gpio A used as a reset gpio */
> 		ddc-i2c-bus =3D <&i2c-two>;
>         }
>=20
>         i2c-one {
> 		eeprom@10 {
> 			compatible =3D "baz,eeprom"
> 			reg =3D 10;=20
> 		};
> 	};
>    };
>=20
> The addon board DT can only be applied at a connector node.

Right.  This is not how overlays work now.  By the nature of how
they're built they apply global updates to the base tree.  That means
we need to spec a new way of describing addons that *is* restricted to
a particular connector slot (or slots, as Geert points out).  Since we
have that opportunity, we should _not_ try to make it a minimal
extension to existing overlay format, but define a new and better
encoding, designed to meet the problems you're looking to address.

> It described the addon board connected to this connector.
>=20
> >=20
> > > I suppose export-symbols could follow aliase conventions, but that st=
ill is
> > > a string =3D> string mapping, which seems worse to me than a phandle =
(since
> > > phandle size is constant).
> > >=20
> > >  =20
> > > >=20
> > > > 2) Extend dtb itself
> > > >=20
> > > > A maor thing that makes current symbols and fixups ugly is the fact
> > > > that they are encoded into properties in the device tree itself,
> > > > despite being logically at a different semantic level.  Obviously y=
ou
> > > > *can* do that, but it's not natural.  It would make more sense to a=
dd
> > > > fixup tags into the dtb format itself. =20
> > >=20
> > > Having something akin to fixup in dtb format itself would be nice. =
=20
> >=20
> > Yes, it would.
>=20
> What could be the modification expected at dtb to support the connector
> use case?

I don't entirely understand the question.  It kind of depends what's
needed.  But certainly FDT_REF_PHANDLE and/or FDT_REF_PATH tags seem
reasonable to me.  A new symbols/aliases/whatever section in the dtb
(separate from the structure block) could also be considered.

> Also what could be the modification expected at dts to described the
> connector?

One thing I'm hoping is that the new structure can be defined in such
a way that not much dts extension is needed.

> > > > 3) bus-reg / bus-ranges
> > > >=20
> > > > One thing that makes connector plugins a bit awkward is that they
> > > > often need to add things to multiple buses on the host system (MMIO=
 &
> > > > i2c for a simple case).  This means that once resolved the plugin
> > > > isn't neatly a single subtree.  That's one factor making removal
>=20
> It can be a single subtree if decoupling is present at connector node ava=
ilable
> in the base device tree.

Right - allowing that decoupling is exactly what I'm proposing bus-reg
for.  Note that the case of an addon that plugs into multiple
connectors that Geert pointed out complicates this again.

> All resources wired to the connector should be described in the connector=
 node
> A add-on board should only see resources provided and described at the co=
nnector
> node or translated by something (nexus, export-symbols) present in the co=
nnector
> node.

Agreed.

> > > > really awkward.  Here's an idea I had a while ago to allow plugins =
to
> > > > be a single subtree, by extending what's allowed in the tree conten=
t:
> > > >=20
> > > > Currently a node can only really have a presence on its immediate
> > > > parent bus, as encoded in the 'reg' and 'ranges' properties.
> > > > 'bus-reg' and 'bus-ranges' would extend that having a similar format
> > > > to 'reg' and 'ranges' but adding a phandle for each entry saying wh=
ich
> > > > bus it lives on - somewhat similar to interrupt-map.
> > > >=20
> > > > For example, here's an MMIO bus bridge of some sort, which has cont=
rol
> > > > registers on I2C:
> > > >=20
> > > > 	mmio-bus@... {
> > > > 		#address-cells =3D < 2 >;
> > > > 		#size-cells =3D < 2 >;
> > > > 		bridge@XXXX {
> > > > 			ranges =3D <...>;
> > > > 			bus-reg =3D <&i2c0 0x407>
> > > > 		}
> > > > 	}
> > > > 	i2c0: i2c@... {
> > > > 		#address-cells =3D < 1 >;
> > > > 		#size-cells =3D < 0 >;
> > > > 	}
> > > >=20
> > > > In a sense this extends the device tree to a device DAG.
> > > >=20
> > > > Obviously this does need changes at the OS device core level, but it
> > > > gives you a lot of flexibility having done so. =20
> > >=20
> > > There is an i2c-bus-extension [1] and spi-bus-extension proposal to d=
o the
> > > same. But, if we can figure out a common way for all buses, that woul=
d be
> > > great.
>=20
> Exactly, this is the purpose of bus extensions.

Right, but redefining it for each bus type seems silly.

> Also, I don't thing that the 'ranges' property should be used for that pu=
rpose.
> The 'ranges' property is used to translate addresses from child addresses=
 space
> to parent addresses space.

The rationale for bus-ranges is that the add-on board could re-expose
one of the buses on the connector (say MMIO for simplicity) to several
chips physically included on the addon board.  We don't want those
sub-chips to need different device nodes depending on whether they're
on an addon board or wired directly onto a main board.  bus-ranges
would allow the root of the connector to create a subtree in which
regular MMIO (or whatever) devices can be described, and then routed
via the connector onto the bus on the main board.

> For instance, in case of i2c, where is the address translation?

I think i2c multiplexers can sometimes do that.  But in any case,
ranges can be used for 1:1 translation as well.

> The address of a child (device) is its I2C address. This address is
> device in its datasheet. There is no reason to have this address depending
> on the I2C bus this child is connected to.

Maybe not for I2C, but other buses can certainly allow translation, so
the flexibility is needed.

> In your example, the bridge@XXXX is not related to any hardware component=
s.

I'm not sure what you mean by that.

> If is allows to physically perform I2C transaction from a MMIO device
> connected to MMIO bus, this is a traduction I2C controller with a bunch of
> registers to configure an perform I2C transactions.

Yes, absolutely.  The i2c in bus-reg there is not supposed to indicate
that the bridge is used to access i2c devices.  Rather it's saying
that the bridge itself has configuration registers accessible via i2c.

If a device does have its own i2c bus hanging off, then as you say
there should not be a 'ranges' property.  It would have its own i2c
controller driver.

bus-ranges could be used when a connector has pins on multiple MMIO
buses, and an addon could have sub-devices on either one of them.

Note that bus-ranges translated between i2c buses isn't theoretically
impossible: that would represent a case with some sort of I2C "relay"
device that forwards I2C commands from one side to the other altering
the address on the way.  I don't know if such devices exist in
practice, but they're certainly theoretically possible (and could be
used, e.g. for allowing 10-bit I2C devices to be accessed from an old
7-bit I2C bus).

> In that case, this "bridge" looks like all I2C we already support in the
> kernel.
> Having the additional indirection with the "bridge" between the MMIO bus
> and the i2c@... node seems not a hardware representation of the system.
>=20
> Did I miss something?

I think so.  That's representing the bridge itself being configured
via I2C, not allowing I2C access to devices _on_ the bus.

> > Heh, right.  That reinforces my thought that this could be a good
> > idea.
> >=20
> > [Btw, the theoretically correct IEEE1275 way to do this is change
> >  addressing across the whole tree.  e.g. set #address-cells =3D <3>,
> >  with the first cell being, say, 0 for mmio, 1 for i2c, 2 for SPI,
> >  then the remaining cells are the address within that bus.  So, this
> >  sort of thing is technically possible in old-school OF trees.  That
> >  would become pretty unmanageable though.  The idea of bus-reg is to
> >  encode the same information in a less awkward way]
> >=20
> > > [1]:
> > > https://lore.kernel.org/all/20250618082313.549140-1-herve.codina@boot=
lin.com/
> > >=20
> > > [2]: https://lore.kernel.org/all/20250729-spi-bus-extension-v1-0-b20c=
73f2161a@beagleboard.org/
> > >=20
> > >  =20
> > > > 4) You don't necessarily need to build a "full" device tree
> > > >=20
> > > > Flattened device trees (as opposed to original IEEE1275 device tree=
s)
> > > > - by design - allow certain information to be omitted.  The most
> > > > common example is that for introspectable buses, like PCI, it's nor=
mal
> > > > to have the DT only include a node for the host bridge, with devices
> > > > under it being discovered by their own bus specific methods.  That's
> > > > discovery is handled by the bus/bridge driver.
> > > >=20
> > > > Connectors usually aren't introspectable, but it's still possible to
> > > > use an approach like this where the connector driver's discovery
> > > > method is "look at a different device tree".  So, for example,
> > > >=20
> > > > Board device tree:
> > > >=20
> > > > / {
> > > > 	compatible =3D "board-with-foo-connector";
> > > > 	. . .
> > > > 	mmio@... {
> > > > 		foo-connector@... {
> > > > 			compatible =3D "foo-connector";
> > > > 			ranges =3D < ... >;
> > > > 		}
> > > > 	}
> > > > }
>=20
> I would expect a description of resources wired to the connector
> available at the foo-connector node.

Possibly yes.  Here I was assuming a case where the resources
presented by a "foo-connector" are fixed and described in a
foo-connector binding.  But an approach which explicitly describes the
exposed resources could certainly have advantages.

> > > >=20
> > > > Foo device tree:
> > > >=20
> > > > / {
> > > > 	compatible =3D "foo-device";
> > > > 	foo-port-id =3D < 0x1234 >;
> > > > 	component@... {
> > > > 		reg =3D < ... >;
> > > > 	}
> > > > }
> > > >=20
> > > > Obviously a "foo device tree" would have different conventions than=
 a
> > > > board device tree.  It wouldn't have /cpus, /memory, /chosen - but =
it
> > > > could have its own "magic" nodes that make sense for the properties=
 of
> > > > the specific connector type.
>=20
> I agree with the fact that /cpus, /memory, ... wouldn't be present at this
> node.=20
>=20
> Can you provide an example of the "magic" node and what do you have in mi=
nd
> to store this information in DTB?

One obvious one is somewhere to store a mapping / renaming of
resources for local use on the connector.  Another might be for
metadata, like an ID code, if this connector type supports it.

> > > > Again, that would require work in the device core part of the OS.  =
The
> > > > bonus is that runtime addition and removal is now trivial.  No hack=
ing
> > > > of the base device tree is needed, and so doesn't need to be revert=
ed.
> > > > The connector driver just adds/removes the reference to its own
> > > > private tree.
>=20
> Here also, I don't see exactly what you have in mind. Can you provide some
> details and example?

What I'm suggesting is that the "main" DT managed by the kernel would
never include devices from the addon board.  Instead the connector
driver would locally a store a different device tree representing just
the things under the connector.  It would present a bus to the kernel
device core that would "discover" devices on the bus based on that
local device tree.

> > > > This would, of course, need some way to refer to board resources
> > > > (interrupt controller, gpio controller) etc.  I think that can be
> > > > assembled using some of the previous ideas, though. =20
> > >=20
> > > I would need to wrap my head around this a bit, specially in context =
of
> > > chaining connectors. It does seem like it will still require the poin=
ts you
> > > mentioned above to be present in one form or another, i.e. some way to
> > > extend busses to different nodes/trees and connector (even a chained =
one)
> > > local symbols/aliases. =20
> >=20
> > Yes, it would still require those mappings.  I don't think chained
> > connectors introduce a lot of extra complication.  An intermediate
> > connector would need to be able to "re-export" things it got from its
> > parent connector to its child connector(s) - renaming them if
> > necessary.
> >=20
> > I think those two elements would be enough to make something that's
> > useful in at least a few cases.  However, the pretty common case of a
> > connector with pins from multiple different parent buses would need
> > bus-reg or something similar.  Or else the nasty multiplexed encoding
> > described above.
> >=20
> > I say, "nasty" and in many cases it would be, but I think there may be
> > some cases where that approach does make sense: e.g. a connector that
> > has several logically separate address spaces but which always travel
> > together and are typically handled by a common bridge device.  PCI is
> > a case of this, if you squint - a host bridge provides a config space
> > bus, and an MMIO bus and a PIO bus.  Also sometimes some sort of
> > interrupt controller / interrupt routing, complicated by the fact that
> > there are several different models for that across PCI and PCI-E.
>=20
> To move forward on the topic, some concrete example would help to
> understand how to describe link, how the information is stored in DTB.
>=20
> This would help us in moving in the right direction.
>=20
>=20
> If the issue with export-symbols is having it described as a DTS node, th=
is
> could be changed with a new DTS keyword.
>=20
> /export/ <symbol_name_to_resolve> <resolved_symbol_name>
>   - <symbol_name_tp_resolved>: Symbol name seen by a user
>   - <resolved_symbol_name>: Symbol used once resolved.

I might have some quibbles with the details, but I'd be open to
something like that.

> <resolved_symbol_name> can be restricted to phandle values.

Because we're operating at the dts level here, whether it's a phandle
is not actually relevant.  We can treat this as a dts label name (or
optionally path) - how that's encoded in the dtb we get to choose. A
phandle is the most obvious approach.

> Mutiple /export/ can be available inside a node in order to give a list
> of exported symbols.

Sure.

> For instance with the connector example I previously mentioned.
> We can replace the export-symbols node by the following:
>=20
> ---- base board DT ----
>   conn0: connector0 {
> 	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 controll=
er */
>                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2 con=
troller */
>=20
>         i2c_one: i2c-one {
> 		compatible =3D "i2c-bus-extension";
> 		i2c-parent =3D <i2c5>; /* i2c wired to i2c5 controller */

I think bus-reg or bus-ranges is a more natural way to do this than
per-bus bindings, but that's not particularly relevant to the rest of
the proposal.

> 	};
>=20
> 	i2c_two: i2c-two {
> 		compatible =3D "i2c-bus-extension";
> 		i2c-parent =3D <i2c6>; /* i2c wired to i2c6 controller */
> 	};
>=20
> 	/export/ connector &conn0
> 	/export/ i2cA &i2c_one
> 	/export/ i2cB &i2c_two

Since dtc is explicitly aware of this, we could even allow relative
paths here, say
	/export/ connector &.;


>   };
>=20
> A reference to connector (&connector) from the addon will be resolve
> to a reference to &conn0 (phandle of the connector0 node.

To handle the addon with multiple connectors we might want an
(optional) remapping / renaming on the addon side as well.  Or maybe
simpler, we could allow namespacing the references on the addon side.

>=20
> ---- addon board DT, applied at connector0 node ----
>    {
> 	some-node {
> 		compatible =3D "foo,bar";
> 		reset-gpios =3D <&connector 0>; /* gpioA used as a reset gpio */
> 		ddc-i2c-bus =3D <&i2cB> /* Resolved thanks to /export/ */
> 	=09
>         }
>=20
>         i2c-one {
> 		/*
>                  * A device added on the i2c-one bus wire to the connecto=
r.
>                  * /export/ not involved. i2c-one is a node (bus extensio=
n) available
>                  * in the DT node where this addon board DT is applied.
>                  *=20
>                  */
> 		eeprom@10 {
> 			compatible =3D "baz,eeprom"
> 			reg =3D 10;=20
> 		};
> 	};
>    };
>=20
>=20
> Now, what is expected in term of DTB format?
>=20
> I think we need:

>  - Base DT: List of exported symbols per nodes (/export/)

Yes.  I'm not necessarily opposed to encoding this as a regular
property (basically, 'exported-symbols').  It's more the fixup
information that is horrible as regular properties.  Connectors should
also probably have a property marking them *as* a connector and giving
the type.

If we didn't want a regular property we could encode this as an
FDT_EXPORT tag.  These would go after FDT_BEGIN_NODE, before FDT_PROP
and each include a (local-name, phandle) tuple.  local-name could be a
string table reference.

>  - Addon DT: List of unresolved symbols and their location

Not sure we need this as a singular list, see below.

>  - Addon DT: A way to avoid collision in phandle values

I'd suggest maybe three new tags for this, these would appear
immediately after the FDT_PROP tag to which they're relevant.

	FDT_REF_PHANDLE		(offset, name)

This would replace the 4 bytes at `offset` in the previous property
with the phandle of the node referred to by `name` (which must match
something in the connector's exported list).

	FDT_REF_PATH		(offset, name)

Similar but would insert the full path name of the referenced node in
the property.

	FDT_REF_LOCAL		(offset)

This indicates that that offset in the property contains a phandle
value pointing to something within the addon - when we adjust addon
phandles to avoid collisions, it needs to be updated too.

The addon should also include information on the type of connector(s)
it wants to plug into.  That should be a stringlist, like
'compatible', to allow for backwards compatible future extensions.


Or... allowing for addons plugging into multiple connectors, possibly
each of those `name`s needs to be extended to (connector, name).
`connector` would be either a name or index saying which connector
we're referring to (numbering/naming controlled by the addon) with
name being the name of the symbol within that connector (naming
controlled by the base board / connector type).

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--S7wZp+CnZ37F+QWG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmi/tnQACgkQzQJF27ox
2Gf+Rw//VVWmSeKYCZM99TzFghliw6dF5cjfz7n898ZXtdF3lSPGWnFrvn5LLTCv
FKV2oExadFJSoKA6EHctnaXJ10L4+7LvbKm1AaC+lpIflqm5jaH0Ak/Up12Xl4M6
MvAiuDaH9hcTVT1feNXcd0A5ruu4vWs3fKLGWe0uFTXiLIxmyRyJPErTlozIfSJ7
qJ1rKFoNBeNwDOlqCtil7IJF7IFKNdzPhFXQVh+z+KP+NHEapYNgUyYfEwha5ldc
eccP/OvL6AS31hcop40LnFPsYljU3xZiV1jkvuwFowcyOUBGNwKxYCd1sRDnA5kb
OKZumR+tlB3z5Oj/Hk+nSAbqTDEW97ed9aCpeHGvFtAMrQRLjv2Re/VTWC5pDFn7
mXufLMLHDQU3+ckF6143c4RtZ1wREb7QVxRDpqg6hgX4zDHvw4Mt3vYarKVPg+PS
PYqramKS9IN02Ck+ivUcV0nJFphDjGzYUcE9wr0LkrF01aKHdbl9NlpndZ9XSwZH
L/iKoph+nynwXOa3yGSn0/+702U753neNACWbSENQw0/+vlB5cqVALLG4+bbXhMf
Lrb2Epg8NjdSr2TxktYFyuMxCVppprnIkqp6tuJPKNZK0B1zDzpcpeU+/29u0EN1
zxSqcjzboVBgUHz6FSZ0C6Ro/f9/qNnTiKMa3h7cHH2hMeshYJQ=
=ZYUr
-----END PGP SIGNATURE-----

--S7wZp+CnZ37F+QWG--

