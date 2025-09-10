Return-Path: <linux-kernel+bounces-809382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92FEB50CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523D2464495
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2EC2BE05B;
	Wed, 10 Sep 2025 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="e7Fa9+l+"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169F28935A;
	Wed, 10 Sep 2025 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479015; cv=none; b=lVVGtFrQhOkbAhV3fqsih3aRSjOPwZSw2lZvAUF50mrqQG/SNIC0JAFAs8NNQOo92ovf3fi0h6wFWPB6UOr5S02csf2d7pVERzl2S/qY1aKK8hkEkCDWEMFwwUGuIFuvwqEuv0tKw5K1vMLXhhK+jKLK6TeqGHVulFnXkx3pmV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479015; c=relaxed/simple;
	bh=QxFca0B6zy/RhnuCoo+cLySG8+mfSS3UOAL38NLIBZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT2Wu5x1ff1gABJL0K0D3+FMyr9k3Z1JnY8vP23vH+kpVcwnwoesCS3x/f96wXp1H/BtNSD9sjZbO768oVIDFQ4SMhbB3G77lmRULGTJwP6A5zVfawkfp4+lIuvyLVH1wcF+lLNzE7k4dxbmisa0IpH6tfVjcIhsrmvquhToUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=e7Fa9+l+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1757479009;
	bh=3LBxkxVlO/DH83L5i6u3Ve5QQtrpcojj+5LOPzxl5Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7Fa9+l+j5+WnsDAwsImkNSRn1lkX0/61KQUujIlsCjAb9u9ut/KFLejZVCpqzBjS
	 0zbgfr5Zz9T57dsM89dOg6JbkFhBmdqd1ZPEXHuFst1Y27aG2f550EKlH+uW+GCl1E
	 azpi8AB+12/fux+02E3Y21OL21uGhORdwjBUicYAuMFRxkJMrJORqlPxgb8XUwHVRB
	 LPBsYNpcgv5knblAeuOt35skut++4B240hOZhu3Zh4taJ0dz8VKg+QD/y2Vpcudeat
	 9oVna/WAqz1bEQpXhPpVed5/HMIgfuJ3lx1j+cQLrXuCwYOA6l5eGdfZWQWzLRler1
	 lak8RV2Hgi6Ow==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cM7FF5bppz4w23; Wed, 10 Sep 2025 14:36:49 +1000 (AEST)
Date: Wed, 10 Sep 2025 14:33:45 +1000
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
Message-ID: <aMD_qYx4ZEASD9A1@zatzit>
References: <20250902105710.00512c6d@booty>
 <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
 <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com>
 <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9cCcRp5xFl45gxT9"
Content-Disposition: inline
In-Reply-To: <20250909114126.219c57b8@bootlin.com>


--9cCcRp5xFl45gxT9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 11:41:26AM +0200, Herve Codina wrote:
> Hi David,
>=20
> On Tue, 9 Sep 2025 15:09:18 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> ...
>=20
> > > I think that a connector is something with a bunch of resources provi=
ded
> > > by the board where the connector is soldered. Those resources are wir=
ed
> > > to the connector and defined by the connector pinout.
> > >=20
> > >      3v3   ------- Pin 0
> > >   i2c_scl  ------- Pin 1
> > >   i2c_sda  ------- Pin 2
> > >     gpio A ------- Pin 3
> > >     gpio B ------- Pin 4
> > >      gnd   ------- Pin 5
> > >=20
> > > IMHO, this need to be described and defined in the base board and an =
addon can
> > > only reference resources wired and described by the connector node. =
=20
> >=20
> > Yes, that's exactly what I'm proposing too.
> >=20
> > > Now, questions are:
> > >   - 1) How to describe a connector?
> > >   - 2) How to reference resources provided at connector level from an=
 add-on? =20
> >=20
> > Right.
> >=20
> > > Our current approach was:
> > > ---- base board DT ----
> > >   connector0 {
> > > 	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 cont=
roller */
> > >                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2=
 controller */
> > >         i2c-one {
> > > 		compatible =3D "i2c-bus-extension";
> > > 		i2c-parent =3D <i2c5>; /* i2c-one wired to i2c5 controller */
> > > 	};
> > >=20
> > > 	i2c-two {
> > > 		compatible =3D "i2c-bus-extension";
> > > 		i2c-parent =3D <i2c6>; /* i2c-two wired to i2c6 controller */
> > > 	};
> > >=20
> > > 	/*
> > >          * From the addon we need to reference:
> > >          *    - The connector itself,
> > >          *    - Maybe some pinctrl related to signals wired to the co=
nnector,
> > >          *    - In some cases the i2c bus (HDMI, ddc-i2c-bus =3D <&i2=
c-two>;)
> > >          *=20
> > >          * This was solved introducing the controversial export-symbo=
ls node.
> > >          */ =20
> >=20
> > I think the type of connector should also be named on both sides (with
> > 'compatible' or something like it).
>=20
> It makes sense.
>=20
> >=20
> > >   };
> > >=20
> > > ---- addon board DT ----
> > >    {
> > > 	some-node {
> > > 		compatible =3D "foo,bar";
> > > 		reset-gpios =3D <&connector 0>; /* gpio A used as a reset gpio */
> > > 		ddc-i2c-bus =3D <&i2c-two>;
> > >         }
> > >=20
> > >         i2c-one {
> > > 		eeprom@10 {
> > > 			compatible =3D "baz,eeprom"
> > > 			reg =3D 10;=20
> > > 		};
> > > 	};
> > >    };
> > >=20
> > > The addon board DT can only be applied at a connector node. =20
> >=20
> > Right.  This is not how overlays work now.  By the nature of how
> > they're built they apply global updates to the base tree.  That means
> > we need to spec a new way of describing addons that *is* restricted to
> > a particular connector slot (or slots, as Geert points out).  Since we
> > have that opportunity, we should _not_ try to make it a minimal
> > extension to existing overlay format, but define a new and better
> > encoding, designed to meet the problems you're looking to address.
>=20
> On the kernel side, overlays can be applied at a specific node.
> The node is chosen when the overlay is apply.
>   https://elixir.bootlin.com/linux/v6.16/source/drivers/of/overlay.c#L970

Huh, I wasn't aware that had already been merged.

> This allows to apply an overlay to a specific node without any modificati=
on
> of the overlay dtb (dtbo).
>=20
> Ajush proposed an update to support this feature in fdtoverlay
>   https://lore.kernel.org/all/20250313-fdtoverlay-target-v1-0-dd5924e12bd=
3@beagleboard.org/

Yes, and I've been disinclined to merge it because I think extending
overlays in this way, without a more wide-ranging redesign, is not a
great idea.

> ...
> >=20
> > > > > > 3) bus-reg / bus-ranges
> > > > > >=20
> > > > > > One thing that makes connector plugins a bit awkward is that th=
ey
> > > > > > often need to add things to multiple buses on the host system (=
MMIO &
> > > > > > i2c for a simple case).  This means that once resolved the plug=
in
> > > > > > isn't neatly a single subtree.  That's one factor making remova=
l =20
> > >=20
> > > It can be a single subtree if decoupling is present at connector node=
 available
> > > in the base device tree. =20
> >=20
> > Right - allowing that decoupling is exactly what I'm proposing bus-reg
> > for.  Note that the case of an addon that plugs into multiple
> > connectors that Geert pointed out complicates this again.
>=20
> Geert's use case needs to be clarified.
>=20
> Suppose a base board with 2 connectors:
>  - connA
>  - connB
>=20
> Case 1: Addons are independant
>                +--------+
>   connA <----> | AddonA |
>                +--------+
>                           +--------+
>   connB <---------------->| AddonB |
>                           +--------+
>=20
> With addonA and B two addon board each connected at one connector without=
 any
> relationship between addon A and B
>=20
> Case 2: Only one Addons using ressources from both connector
>=20
>                 +------+
>   connA <-----> |Addon |
>                 |      |
>   connB <-----> |      |
>                 +------+

Case 2 is what I'm talking about.  Case 1 is the easy one.

> The addon is connected to both connector and uses ressources from connA a=
nd
> connB in a dependent manner.
>=20
>=20
> The Case 2 can be solved using a connector that described both connA and =
connB.
> Having the split connA and connB is a mechanical point of view.

I don't think that's a good solution, because it means you have to
make that decision at the board layer.  If I understand his case
correctly, you have a board where you could do either case 1 or case 2
at runtime.  We'd want the differences between these cases to only be
reflected on the addon device tree, not the base board device tree.

> Also adding and Addon on only one part (connA for instance) should not be=
 an issue
> if the connector describe both parts.
>=20
> but well, here again I can miss something.
> Geert, can you provide details?
>=20
> ...
>=20
> > > > >=20
> > > > > There is an i2c-bus-extension [1] and spi-bus-extension proposal =
to do the
> > > > > same. But, if we can figure out a common way for all buses, that =
would be
> > > > > great. =20
> > >=20
> > > Exactly, this is the purpose of bus extensions. =20
> >=20
> > Right, but redefining it for each bus type seems silly.
>=20
> Nexus node properties are re-defined for each kind of resources (interrup=
t,
> gpio, pwm, ...).

Yes, for historical reasons.  In IEE1275 days, interrupts was
basically the only thing that worked this way.  gpio and pwm were
added much later using interrupts as a model.  If we were designing
=66rom scratch having a common way of defining a nexus would make sense
too.

> Why not for bus extensions.

So that we don't need to keep defining new bindings for it.

> Also I am pretty sure that some bus extension will need to define some
> properties specific to the bus related to the extension.

Maybe, but then only those buses that specifically need it need the
extra binding.

> > > Also, I don't thing that the 'ranges' property should be used for tha=
t purpose.
> > > The 'ranges' property is used to translate addresses from child addre=
sses space
> > > to parent addresses space. =20
> >=20
> > The rationale for bus-ranges is that the add-on board could re-expose
> > one of the buses on the connector (say MMIO for simplicity) to several
> > chips physically included on the addon board.  We don't want those
> > sub-chips to need different device nodes depending on whether they're
> > on an addon board or wired directly onto a main board.  bus-ranges
> > would allow the root of the connector to create a subtree in which
> > regular MMIO (or whatever) devices can be described, and then routed
> > via the connector onto the bus on the main board.
>=20
> bus extensions supports this feature without bus-regs nor bus-ranges.

bus-reg & bus-ranges allow it for any bus without having to create a
new binding.

> A bus extension ended by a sub node in the connector node.
> Applying the addon DT at the connector node allow the addon to had
> subnode to the extension node.

I don't really understand what point you're making here.

>=20
> >=20
> > > For instance, in case of i2c, where is the address translation? =20
> >=20
> > I think i2c multiplexers can sometimes do that.  But in any case,
> > ranges can be used for 1:1 translation as well.
>=20
> i2c multiplexers are physical devices performing some internal logic.
> They are real bridges and route an upstream i2c bus to downstream
> i2c busses.

Yes... and bus-ranges could encode exactly that.  It just means that
the downstream bus doesn't have to be physically located in the tree
below the upstream bus.

Or, you can use a node with an identity mapping bus-ranges to allow
bus extension without translation - just as as sometimes done for
transparent MMIO bridges.

> They are handled by a specific driver.
>=20
> >=20
> > > The address of a child (device) is its I2C address. This address is
> > > device in its datasheet. There is no reason to have this address depe=
nding
> > > on the I2C bus this child is connected to. =20
> >=20
> > Maybe not for I2C, but other buses can certainly allow translation, so
> > the flexibility is needed.
> >=20
> > > In your example, the bridge@XXXX is not related to any hardware compo=
nents. =20
> >=20
> > I'm not sure what you mean by that.
>=20
> We have just wires from a controller to a connector. No bridges
> nor other devices between the controller and the connector.

Wires are a hardware component.  Not a very interesting one, but a
device tree node doesn't have to represent active logic.

> The controller is described in the base device tree, the connector is
> described in the base device tree and the physical links between the cont=
roller
> and the connector are wires on PCB.
>=20
> If a physical device is present between the controller and the connector
> such as a i2c mux, this physical device is allready described in the base=
 DT.
>=20
> In that case, your "bridge" will be betweeh the i2c mux and the connector.
>=20
> In the extension bus case, the extension bus is between the i2c mux and t=
he
> connector.

Yes... and, so?

> > > If is allows to physically perform I2C transaction from a MMIO device
> > > connected to MMIO bus, this is a traduction I2C controller with a bun=
ch of
> > > registers to configure an perform I2C transactions. =20
> >=20
> > Yes, absolutely.  The i2c in bus-reg there is not supposed to indicate
> > that the bridge is used to access i2c devices.  Rather it's saying
> > that the bridge itself has configuration registers accessible via i2c.
> >=20
> > If a device does have its own i2c bus hanging off, then as you say
> > there should not be a 'ranges' property.  It would have its own i2c
> > controller driver.
> >=20
> > bus-ranges could be used when a connector has pins on multiple MMIO
> > buses, and an addon could have sub-devices on either one of them.
> >=20
> > Note that bus-ranges translated between i2c buses isn't theoretically
> > impossible: that would represent a case with some sort of I2C "relay"
> > device that forwards I2C commands from one side to the other altering
> > the address on the way.  I don't know if such devices exist in
> > practice, but they're certainly theoretically possible (and could be
> > used, e.g. for allowing 10-bit I2C devices to be accessed from an old
> > 7-bit I2C bus).
> >=20
> > > In that case, this "bridge" looks like all I2C we already support in =
the
> > > kernel.
> > > Having the additional indirection with the "bridge" between the MMIO =
bus
> > > and the i2c@... node seems not a hardware representation of the syste=
m.
> > >=20
> > > Did I miss something? =20
> >=20
> > I think so.  That's representing the bridge itself being configured
> > via I2C, not allowing I2C access to devices _on_ the bus.
>=20
> If I understand correctly the addon board can configure the bridge availa=
ble on
> the base board.

In this particular example there isn't (necessarily) an addon in play.
I'm just giving an example of a plausible device that has a presence
on two upstream buses - MMIO for the data path, and I2C for the
control path.  There's not a natural way to represent that with
regular 'reg' and 'ranges'.

I'm saying that the *OS* can configure the bridge via I2C, nothing
about the hardware (addon or otherwise) configuring the bridge.

> How do you describe that when you have everything soldered on a base board
> and described in a base DT?
>=20
> I think that the description should be the same with when some devices
> are soldered on an addon board connected to a connector.
>=20
> The only difference should be the location of the nodes. Indeed, those
> devices, on the addon board, behid the connector, should be described
> as subnodes of the connector.
>=20
> Extension bus is exactly for that purpose.
>=20
> ...
>=20
> > > > > > 4) You don't necessarily need to build a "full" device tree
> > > > > >=20
> > > > > > Flattened device trees (as opposed to original IEEE1275 device =
trees)
> > > > > > - by design - allow certain information to be omitted.  The most
> > > > > > common example is that for introspectable buses, like PCI, it's=
 normal
> > > > > > to have the DT only include a node for the host bridge, with de=
vices
> > > > > > under it being discovered by their own bus specific methods.  T=
hat's
> > > > > > discovery is handled by the bus/bridge driver.
> > > > > >=20
> > > > > > Connectors usually aren't introspectable, but it's still possib=
le to
> > > > > > use an approach like this where the connector driver's discovery
> > > > > > method is "look at a different device tree".  So, for example,
> > > > > >=20
> > > > > > Board device tree:
> > > > > >=20
> > > > > > / {
> > > > > > 	compatible =3D "board-with-foo-connector";
> > > > > > 	. . .
> > > > > > 	mmio@... {
> > > > > > 		foo-connector@... {
> > > > > > 			compatible =3D "foo-connector";
> > > > > > 			ranges =3D < ... >;
> > > > > > 		}
> > > > > > 	}
> > > > > > } =20
> > >=20
> > > I would expect a description of resources wired to the connector
> > > available at the foo-connector node. =20
> >=20
> > Possibly yes.  Here I was assuming a case where the resources
> > presented by a "foo-connector" are fixed and described in a
> > foo-connector binding.  But an approach which explicitly describes the
> > exposed resources could certainly have advantages.
> >=20
> > > > > >=20
> > > > > > Foo device tree:
> > > > > >=20
> > > > > > / {
> > > > > > 	compatible =3D "foo-device";
> > > > > > 	foo-port-id =3D < 0x1234 >;
> > > > > > 	component@... {
> > > > > > 		reg =3D < ... >;
> > > > > > 	}
> > > > > > }
> > > > > >=20
> > > > > > Obviously a "foo device tree" would have different conventions =
than a
> > > > > > board device tree.  It wouldn't have /cpus, /memory, /chosen - =
but it
> > > > > > could have its own "magic" nodes that make sense for the proper=
ties of
> > > > > > the specific connector type. =20
> > >=20
> > > I agree with the fact that /cpus, /memory, ... wouldn't be present at=
 this
> > > node.=20
> > >=20
> > > Can you provide an example of the "magic" node and what do you have i=
n mind
> > > to store this information in DTB? =20
> >=20
> > One obvious one is somewhere to store a mapping / renaming of
> > resources for local use on the connector.  Another might be for
> > metadata, like an ID code, if this connector type supports it.
> >=20
> > > > > > Again, that would require work in the device core part of the O=
S.  The
> > > > > > bonus is that runtime addition and removal is now trivial.  No =
hacking
> > > > > > of the base device tree is needed, and so doesn't need to be re=
verted.
> > > > > > The connector driver just adds/removes the reference to its own
> > > > > > private tree. =20
> > >=20
> > > Here also, I don't see exactly what you have in mind. Can you provide=
 some
> > > details and example? =20
> >=20
> > What I'm suggesting is that the "main" DT managed by the kernel would
> > never include devices from the addon board.  Instead the connector
> > driver would locally a store a different device tree representing just
> > the things under the connector.  It would present a bus to the kernel
> > device core that would "discover" devices on the bus based on that
> > local device tree.
>=20
> We agree with that and this is what we have proposed with our connector
> binding.
> The main DT has to provide (describe) busses that can be used by the addon
> (adding devices to those busses).
>=20
> Our binding with bus extension fulfills this requirement.

Right, but I'm saying even for the OS's runtime copy of the device
tree the addon device would not be (directly) included.  I'm not
saying that's the only way or the best way to do it, just that I think
it should be considered.  It makes runtime device discovery more
complex - not just one DT must be traversed, but possibly several
depending on connector drivers.  However, the plus side is that the
core DT management doesn't ever need to deal with hotplug or hot
remove.

> > > > > > This would, of course, need some way to refer to board resources
> > > > > > (interrupt controller, gpio controller) etc.  I think that can =
be
> > > > > > assembled using some of the previous ideas, though.   =20
> > > > >=20
> > > > > I would need to wrap my head around this a bit, specially in cont=
ext of
> > > > > chaining connectors. It does seem like it will still require the =
points you
> > > > > mentioned above to be present in one form or another, i.e. some w=
ay to
> > > > > extend busses to different nodes/trees and connector (even a chai=
ned one)
> > > > > local symbols/aliases.   =20
> > > >=20
> > > > Yes, it would still require those mappings.  I don't think chained
> > > > connectors introduce a lot of extra complication.  An intermediate
> > > > connector would need to be able to "re-export" things it got from i=
ts
> > > > parent connector to its child connector(s) - renaming them if
> > > > necessary.
> > > >=20
> > > > I think those two elements would be enough to make something that's
> > > > useful in at least a few cases.  However, the pretty common case of=
 a
> > > > connector with pins from multiple different parent buses would need
> > > > bus-reg or something similar.  Or else the nasty multiplexed encodi=
ng
> > > > described above.
> > > >=20
> > > > I say, "nasty" and in many cases it would be, but I think there may=
 be
> > > > some cases where that approach does make sense: e.g. a connector th=
at
> > > > has several logically separate address spaces but which always trav=
el
> > > > together and are typically handled by a common bridge device.  PCI =
is
> > > > a case of this, if you squint - a host bridge provides a config spa=
ce
> > > > bus, and an MMIO bus and a PIO bus.  Also sometimes some sort of
> > > > interrupt controller / interrupt routing, complicated by the fact t=
hat
> > > > there are several different models for that across PCI and PCI-E. =
=20
> > >=20
> > > To move forward on the topic, some concrete example would help to
> > > understand how to describe link, how the information is stored in DTB.
> > >=20
> > > This would help us in moving in the right direction.
> > >=20
> > >=20
> > > If the issue with export-symbols is having it described as a DTS node=
, this
> > > could be changed with a new DTS keyword.
> > >=20
> > > /export/ <symbol_name_to_resolve> <resolved_symbol_name>
> > >   - <symbol_name_tp_resolved>: Symbol name seen by a user
> > >   - <resolved_symbol_name>: Symbol used once resolved. =20
> >=20
> > I might have some quibbles with the details, but I'd be open to
> > something like that.
>=20
> Ok
>=20
> >=20
> > > <resolved_symbol_name> can be restricted to phandle values. =20
> >=20
> > Because we're operating at the dts level here, whether it's a phandle
> > is not actually relevant.  We can treat this as a dts label name (or
> > optionally path) - how that's encoded in the dtb we get to choose. A
> > phandle is the most obvious approach.
> >=20
> > > Mutiple /export/ can be available inside a node in order to give a li=
st
> > > of exported symbols. =20
> >=20
> > Sure.
> >=20
> > > For instance with the connector example I previously mentioned.
> > > We can replace the export-symbols node by the following:
> > >=20
> > > ---- base board DT ----
> > >   conn0: connector0 {
> > > 	gpio-map =3D <0 &gpio0 12>, /* gpio A wired to gpio 12 of gpio0 cont=
roller */
> > >                    <1 &gpio2 10;  /* gpio B wired to gpio 10 of gpio2=
 controller */
> > >=20
> > >         i2c_one: i2c-one {
> > > 		compatible =3D "i2c-bus-extension";
> > > 		i2c-parent =3D <i2c5>; /* i2c wired to i2c5 controller */ =20
> >=20
> > I think bus-reg or bus-ranges is a more natural way to do this than
> > per-bus bindings, but that's not particularly relevant to the rest of
> > the proposal.
> >=20
> > > 	};
> > >=20
> > > 	i2c_two: i2c-two {
> > > 		compatible =3D "i2c-bus-extension";
> > > 		i2c-parent =3D <i2c6>; /* i2c wired to i2c6 controller */
> > > 	};
> > >=20
> > > 	/export/ connector &conn0
> > > 	/export/ i2cA &i2c_one
> > > 	/export/ i2cB &i2c_two =20
> >=20
> > Since dtc is explicitly aware of this, we could even allow relative
> > paths here, say
> > 	/export/ connector &.;
>=20
> Indeed, good point.
>=20
> >=20
> >=20
> > >   };
> > >=20
> > > A reference to connector (&connector) from the addon will be resolve
> > > to a reference to &conn0 (phandle of the connector0 node. =20
> >=20
> > To handle the addon with multiple connectors we might want an
> > (optional) remapping / renaming on the addon side as well.  Or maybe
> > simpler, we could allow namespacing the references on the addon side.
>=20
> I think you talk about the Geert use case.
> Geert, an example should be welcome.
>=20
> The plan was to apply the DT related to an addon at a connector node.
> Maybe this will not fit well with Geert's use case but to know if it
> fits or not and to find the best way to handle this use case, an
> example is needed.
>=20
> >=20
> > >=20
> > > ---- addon board DT, applied at connector0 node ----
> > >    {
> > > 	some-node {
> > > 		compatible =3D "foo,bar";
> > > 		reset-gpios =3D <&connector 0>; /* gpioA used as a reset gpio */
> > > 		ddc-i2c-bus =3D <&i2cB> /* Resolved thanks to /export/ */
> > > 	=09
> > >         }
> > >=20
> > >         i2c-one {
> > > 		/*
> > >                  * A device added on the i2c-one bus wire to the conn=
ector.
> > >                  * /export/ not involved. i2c-one is a node (bus exte=
nsion) available
> > >                  * in the DT node where this addon board DT is applie=
d.
> > >                  *=20
> > >                  */
> > > 		eeprom@10 {
> > > 			compatible =3D "baz,eeprom"
> > > 			reg =3D 10;=20
> > > 		};
> > > 	};
> > >    };
> > >=20
> > >=20
> > > Now, what is expected in term of DTB format?
> > >=20
> > > I think we need: =20
> >=20
> > >  - Base DT: List of exported symbols per nodes (/export/) =20
> >=20
> > Yes.  I'm not necessarily opposed to encoding this as a regular
> > property (basically, 'exported-symbols').  It's more the fixup
> > information that is horrible as regular properties.  Connectors should
> > also probably have a property marking them *as* a connector and giving
> > the type.
>=20
> I thought that exported-symbols (or export-symbols) node was a no go.

I'm not against 'export-symbols' itself.  I'm just against
implementing it purely to stretch existing overlay mechanisms to do
things they were never really meant to, without considering the end to
end design.

> With our proposal, nothing change in current __symbols__, __fixup__ and
> __local_fixup__ implementation.
>=20
> We just add the export-symbols item in current resolution process.
>=20
> Even if a new DTB format landed, we should support already existing forma=
t.

"Support" in what sense?  Still allow, obviously, but I don't think
it's necessary to squeeze new features into an old format.

> > If we didn't want a regular property we could encode this as an
> > FDT_EXPORT tag.  These would go after FDT_BEGIN_NODE, before FDT_PROP
> > and each include a (local-name, phandle) tuple.  local-name could be a
> > string table reference.
> >=20
> > >  - Addon DT: List of unresolved symbols and their location =20
> >=20
> > Not sure we need this as a singular list, see below.
> >=20
> > >  - Addon DT: A way to avoid collision in phandle values =20
> >=20
> > I'd suggest maybe three new tags for this, these would appear
> > immediately after the FDT_PROP tag to which they're relevant.
> >=20
> > 	FDT_REF_PHANDLE		(offset, name)
> >=20
> > This would replace the 4 bytes at `offset` in the previous property
> > with the phandle of the node referred to by `name` (which must match
> > something in the connector's exported list).
> >=20
> > 	FDT_REF_PATH		(offset, name)
> >=20
> > Similar but would insert the full path name of the referenced node in
> > the property.
> >=20
> > 	FDT_REF_LOCAL		(offset)
> >=20
> > This indicates that that offset in the property contains a phandle
> > value pointing to something within the addon - when we adjust addon
> > phandles to avoid collisions, it needs to be updated too.
>=20
> Ok for FDT_REF_PHANDLE(), FDT_REF_PATH() and FDT_REF_LOCAL().
>=20
> They replace __fixups__ and __local_fixups__ but we need also
> something to replace __symbols__ and the "export-symbols"
>=20
> Solution 1:=20
>=20
>   A new section is needed.
>   we have dt_struct and dt_strings. dt_symbols could be this new section.

I think we want to heavily discourage / deprecate use of global
symbols like we have now, in favour of local symbols (export-symbols
or something like it).  So I don't think adding a new section for
global symbols is a good idea.

>   In this section we have table(s) of exported symbols. In term of
>   information, I think we need:
>    - The symbol name
>    - The node exporting the symbol (path)
>    - The symbol source:
>        - node referenced by the symbol (path)
>        - phandle referenced by the symbol
>        - original name for symbol remapping
>=20
>=20
> Solution 2:
>   At nodes exporting symbols we could had:
>      - FDT_EXPORT_PHANDLE(name, phandle)
>        with name, the exported symbol name and phandle, the phandle value.
>=20
>      - FDT_EXPORT_PATH(name, path)
>        with name, the exported symbol name and path, the path to exported
>        object
>=20
>      - FDT_EXPORT_REMAP(name, orig_name)
>        with name, the exported symbol name and orig_name, the original sy=
mbol
>        name remapped to the exported symbol name.

I think we only need one of these (probably _PHANDLE).  We could allow
the other variants in source, but it should be strightforward to
compile them all to the same thing.

> > The addon should also include information on the type of connector(s)
> > it wants to plug into.  That should be a stringlist, like
> > 'compatible', to allow for backwards compatible future extensions.
>=20
> This information (if needed) is used by the driver applying the connector.
> I don't think if should be involved in the symbol resolution mechanism.

Maybe, but it's still information that should be there.

> From the symbol resolution point of view, we have:
> - A base DT,
> - A specific node in the base DT where the addon should be added

Not necessarily just one for Case 2 above.

> - The addon DT.
>=20
> With this 3 inputs, the symbol resolution should do its work.
> It should not check any compatible strings values.

Hmm.  Why not?  It's not strictly necessary to the process, I agree,
but seems like it could be a useful sanity check.

>=20
> >=20
> >=20
> > Or... allowing for addons plugging into multiple connectors, possibly
> > each of those `name`s needs to be extended to (connector, name).
> > `connector` would be either a name or index saying which connector
> > we're referring to (numbering/naming controlled by the addon) with
> > name being the name of the symbol within that connector (naming
> > controlled by the base board / connector type).
> >=20
>=20
> Best regards,
> Herv=E9
>=20
> --=20
> Herv=E9 Codina, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--9cCcRp5xFl45gxT9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmjA/6gACgkQzQJF27ox
2GeojhAApw+BtPPJ1oumJmwI4v0CoWCEHumh3HYeAL/WHNNhHioRnQr8nH8T6tYz
zKw+c64yvIuZsXxxoyczqodwfZsk0E3BawraN1k6VVoxESTIBIMN2E+Nhyv3pHmr
Q7LK9oOYSWXOeLs9+wwc6zToqZoYskETIkDoSsFyigcU9z6jD73tGyy5h9JthiB9
oSGb1YlhpGRbDYMg4jvCimb26Y+prYR6gS7l5Xjrplfc9dVsXDqAGxj2y8s8+iq6
GJn61fAFXEYl+Uh0tUO1RJ31L8L2ZhgaUzmTzGIp5gcYycXCOtKF37/GGSl6OdyT
fU+Fy06Z/+FKWzF/MHppihoZd/2Cg1Qu/rclEgdHjCtbVOamBYIpJwRThqDsnvuE
V38mY44foDD0w+myOjs9J7maSxXNFcTzCTXVF4Sxx8hV8JxTlx3X6ukaZw51kClV
/is445RqpROw9DO0kOs4L1v0m2ISa5M1+gJlK18A3fccnfXqW3OwWIzFodeA8TbE
5zFrt4PWU9pcfP0OVlf4jqNe5DUvJz2UKIjgKqE16CRz/FEZc/dqsPDgbCmJ9sRU
ghStV4UauPIeJ+tstlH8GJ52xDNwmvzHErJhwF/Dd52mzsZ/Y5b9J0FW1Old6/b9
RoacPAlBD3J+Mz/VZyJ+7QonB2YNLKj+slCJQ7bfTPZypLvUCFU=
=EPkt
-----END PGP SIGNATURE-----

--9cCcRp5xFl45gxT9--

