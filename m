Return-Path: <linux-kernel+bounces-799949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C490B4318C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2131B25681
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609523D7C3;
	Thu,  4 Sep 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pPAGSOeS"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701D22C355;
	Thu,  4 Sep 2025 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963400; cv=none; b=S00i+sKYKYcUJH6xad2Obmdfsgm56ww6ja9MRGZJMsfd1MozkGYHYV4Jb+gsftF6Ozi/jnIv1ZIdU+viAlHSzXzNhzSMo0XEiJiQRYn3+/mQ4L/+4n8g2MZcOZjw9K8o4JjV3UCQvdIC1llbs37oPgXp2vJrZlrUACZomnoKCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963400; c=relaxed/simple;
	bh=9Ncc76f7r6X3/WIpidg9syWc+9qLbxJ6LwGkKPfzdB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMyuSikSYx9xcAR13HHscDBIY+DF9UZuHRcmfX/R9uHoTiTaAQHOsdvbJKb4zUTiUZiUoAOvYpRPM/Uy6AVcX6xnWxFAoCWGDDYSy7OnCk+h+FJ3TQLcpuwIScX59WS/JivBJuFZe9udLBDc9pl2Y62W8aYN0f0MB1Dj/P0Af+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=pPAGSOeS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202508; t=1756963393;
	bh=FxWP4Q8hke5JPl6divIUiMrs2seCWXdaxgvLompvkXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPAGSOeSmZpvSEk5yaJGKSi2CahX0YI0xPartYDKpMN4KvNKrqF78HAuIxQmipcqc
	 b/pmOQOJV0oD+ltSSKlL8dD3qQthCg+RDHB+i4rJPirzhgreuO/Rkljymo4ZlFV4Be
	 PeZog0qlJ3PmVwa42DJm30o3L/jj7tnXJc0uSDDqAZObLUcV+iX5d5428PTnAx0FC6
	 8OdVn8s/xVrtwYu4LtOnGYSRwBHz3+3NzYBDIBewBuDcKJbjUi8xhuVQ8KcDp4pD2z
	 H4aO4ZG775xZJtKlV7NzjVIlmGGDCobARNkFB4TtqH9ruHNa8Y0uQyQEe7uKplcmQS
	 n0zFR4zihhs0g==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4cHSYY37f4z4wB5; Thu,  4 Sep 2025 15:23:13 +1000 (AEST)
Date: Thu, 4 Sep 2025 15:23:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Ayush Singh <ayush@beagleboard.org>,
	Jason Kridner <jkridner@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>, Andrew Davis <afd@ti.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <aLkiNdGIXsogC6Rr@zatzit>
References: <20250902105710.00512c6d@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bfxbpu956IhQajja"
Content-Disposition: inline
In-Reply-To: <20250902105710.00512c6d@booty>


--Bfxbpu956IhQajja
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 10:57:10AM +0200, Luca Ceresoli wrote:
> Hello,
>=20
> [this main was co-written by Herv=E9 and Luca]
>=20
> Herv=E9 and I are working since 1+y to allow describing hot-pluggable
> add-ons and their connectors with device tree overlays. Our work is not

So.. I think this is a poor way of framing the question.  Device tree
overlays were, frankly, a quick hack to get some sort device tree
variability happening.  They were pretty easy to implement, but they
have a bunch of limitations.  Then, as such things so often are, they
were used and overused.

IMO, a lot of the problems being encountered now are really those
fundamental limitations of the overlay approach.  Trying to address
them "with device tree overlays" is constraining you to a poorly
thought out approach, adding hacks on top of hacks.

I proposed a possible "connector" format years ago (which I still
think could do with renewed consideration) as an *alternative to*
device tree overlays, not as an extension of them.

> very much progressing because discussions about device tree bindings
> has raised some issue that are not obvious to solve.
>=20
> This e-mail is a report of the efforts we did last week during the
> Embedded Linux Conference Europe to try to address the currently
> blocking issues.
>=20
> First, I gave a talk about the overall hotplug work, to provide a
> status update but also to clarify the goals and use cases. Slides are
> available at [2]. Goals include:
>=20
> - decoupling base board and add-on, so an addon can have a single dtbo
>   valid for any base board, and vice versa

Good goal.  This one can be somewhat addressed within the dtbo format
(e.g. the 'export-symbols' proposal').  However doing so leans into
the limitations of the dtbo format, which I think won't serve you
well.

> - supporting main boards with multiple connectors where multiple
>   instances of the same addon model can be connected independently

Such as right here.  The basic overlay approach is really badly
suited to this.

> - allowing overlay insertion and removal at runtime (hotplug)

Again, I think that's poor framing.  You want to be able to insert and
remove things into connectors.  Thinking of that as inserting and
removing overlays hotplug limits you to crappy solutions.  The basic
definition of overlay application is fundmentally lossy - making them
removable requires a pile of ugly hacks.  Better to look at an
approach at a different semantic layer.

> The first goal implies that addon overlays do not refer to anything
> (phandles) beyond the connector node.
>=20
> The talk has attracted a lot of people. All seats in the 200+ room were
> taken, and when I asked who has a connector use case about 40-50
> attendeed raised their hands. I also had several questions asked after
> the talk and in the hallway.
>=20
> After the talk we had planned a discussion about the topic. Krzysztof
> Kozlowski was present in person (thanks!), while Ayush Singh and
> Wolfram Sang connected remotely. Jason Kridner (beagleboard.org) and
> Geert Uytterhoeven were present and actively constributing to the
> discussion. Unfortunately Rob Herring was not connected, but still we
> tried to make the best out of the discussion. So we focused on
> discussing the current proposals to go past the issues with our
> export-symbols proposal raised mainly by Rob.
>=20
> Here is a summary of the ideas we have discussed, in order from
> simplest discussion (looking like not doable) to most complex (which
> look like doable).
>=20
> ---------------------------------------------------------------------
>=20
> Idea #1: Label on __overlay__
> Proposed by Rob in [0]
>=20
> > Couldn't we make something like this work:
> >
> > connector: __overlay__ {
> >    node {
> >       foo-gpio =3D <&connector 0 GPIO_ACTIVE_HIGH>;
> >    };
> > };
>=20
> This would be OK for simple cases but it only allows exporting one
> label, for the connector (i.e. the overlay target node). More than one
> label need to be referenced from the overlay for cases such as:
>=20
> - pinmux, where each pinmux configuration is a node, and is defined
>   in the pinmux node outside of the connector
> - HDMI ddc-i2c property, for HDMI chips in the overlay which needs to
>   point at an I2C adapter in the base tree

Even wiring up plain old interrupts could be hard with this approach.
It's also not clear how it would be encoded in the dtb.
=20
> ---------------------------------------------------------------------
>=20
> Idea #2: add /export/ keyword to mark labels to be exported
> Proposed by Rob in [1]
>=20
> The idea is to mark modes in the base tree that can be referenced by
> overlays:
>=20
> > /export/ label: node {
> > };
> >
> > And then __symbols__ can be only those exported labels (unless -@ is us=
ed).
>=20
> This is an opt-in version of the "global" __symbols__ to limit the
> issues __symbols__ introduces. However it is not sufficient for
> connectors because it tells what can be exported but not on which
> connector. Also, overlays would need to refer to the nodes in the main
> tree, thus not decoupling mainboard and addon.

Sounds like a strictly worse version of export-symbols.

> ---------------------------------------------------------------------
>=20
> Idea #3: label on empty (*) node
> (*) until overlay applied
> Proposed by Herv=E9 at LPC2024 in a discussion with Krzysztof, later
> abandoned
>=20
> This is based on Idea #1 but tries to make HDMI ddc-i2c work:
>=20
> connector1: connector1 {
>     #gpio-cells =3D <2>;
>     gpio-map =3D <0 0 &soc_gpio 12 0>;
>     gpio-map-mask =3D <0xf 0x0>;
>     gpio-map-pass-thru =3D <0x0 0xf>;
>=20
>     i2c8: i2c-hdmi {                [**]
>       i2c-parent =3D <&soc_i2c8>;
>     }
> };
>=20
> connector: __overlay__ {
>    node {
>       foo-gpio =3D <&connector 0 GPIO_ACTIVE_HIGH>;
>    };
>    i2c_hdmi: i2c-hdmi {
>      //empty
>    };
>    hdmictrl@99876 {
>       ddc-i2c =3D <&i2c_hdmi>;
>    };
> };

Having symbol / glue information that's local to a particular
connector is, I think, the way to go.  But again, I think encoding
this in terms of overlays semantics is going to make it harder than it
needs to be.

> This would leverage the i2c-bus-extension work (also under discussion
> [3]). Since for HDMI an I2C device is not added it would have a node
> (i2c-hdmi) that is empty in the overlay (but not in the base tree and
> thus not in the live tree after the overlay is applied). This empty
> node is needed to ensure we can have a label (i2c_hdmi) that can be
> referenced from elsewhere in the overlay (ddc-i2c).
>=20
> However there are various issues with this approach:
>=20
>  - mainlin, it does not handle pinumxes nicely
>  - if the node that is overlayed by the empty node (i2c-hdmi) has a
>    label in the base tree (line [**]), then the overlay-provided
>    phandle ID would screw up the base-tree phandle ID
>  - in dtbo, the empty node (i2c-hdmi) has a property in the overlay
>    (phandle) but the node exists in the base tree, thus the property
>    would leak on removal
>=20
> ---------------------------------------------------------------------
>=20
> Idea #4: resolving phandle errors by the connector driver
> Proposed by Rob in [1]
>=20
> > I'll throw out another idea. What if we make resolving phandle errors
> > something that can be handled by the connector driver? The driver
> > knows 'connector' resolves to the connector node it is applying the
> > overlay to.
>=20
> This idea looked promising, so we tried simulating the process with a
> dts/dtso example:
>=20
> Base tree:
>=20
> connector1 {
>     compatible =3D "myvendor,myconn";
>=20
>     #gpio-cells =3D <2>;
>     gpio-map =3D <0 0 &soc_gpio1 12 0>, <1 0 &soc_gpio3 42 0>;
>     gpio-map-mask =3D <0xf 0x0>;
>     gpio-map-pass-thru =3D <0x0 0xf>;
>=20
>     i2c-sensors {
>        compatible =3D "i2c-bus-extension";
>        i2c-parent =3D <&i2c@abcd0000>;
>     };
>=20
>     hdmi-ddc-adapter =3D <&soc_i2c8>;
>=20
>     // All pinctrls that addons may need
>     pin12-pinctrl-i2c =3D <&pin12_mode_i2c>;
>     pin1-pinctrl-gpio =3D <&pin1_mode_gpio>;
>     pin2-pinctrl-gpio =3D <&pin2_mode_gpio>;
> };
>=20
> Overlay:
>=20
> / {
>  fragment@0 {
>   __overlay__ {
>    node {
>       foo-gpios =3D <&connector 0 GPIO_ACTIVE_HIGH>,  <&connector 1 GPIO_=
ACTIVE_HIGH>;
>    };
>    i2c-sensors {
>       thm: thermal@15 {reg =3D <15>;...};
>    };
>    hdmictrl@12345678 {
>       ddc-i2c =3D <&ddc_adapter>;   [*]
>    };
>    some_other_node {
>       pinctrl-0 =3D <&pin12_pinctrl_i2c>;
>       thermal =3D <&thm>;
>    };
> };
>=20
> This is what would happen for the HDMI ddc-i2c at line [*]:
>=20
> 1. of_overlay_fdt_apply_new(..., resolve_dt_error_cb) is called;
>    it is a variant of of_overlay_fdt_apply() (name to be defined!) that:
>      a. takes a function pointer to invoke the connector for resolving
>         unknown labels
>      b. does not even try to resolve phandles beyond the connector
>      c. if target node has no phandle, creates one with next unused
>         number
> 2. resolver does not find 'ddc_adapter' label
> 3. before calling it a fatal error, resolver calls connector driver
>    callback
> 4. connector driver callback knows the "ddc_adapter" string must be
>    resolved using the "hdmi-ddc-adapter" property, returns soc_i2c8
>    phandle ID
>=20
> connector driver callback in pseudocode:
>=20
>   resolve_dt_error_cb(conn, label)
>   {
>     switch (label) {
>       case "connector":
>         return conn->of_node;
>       case "ddc_adapter":
>         return resolve(conn->of_node, "hdmi-ddc-adapter");
>       case "pin12_pinctrl_i2c":
>         return resolve(conn->of_node, "pin12-pinctrl-i2c");
>       }
>   }

The idea of putting logic into a connector driver makes sense.
However, it's unclear to me where those strings its resolving are
actually encoded in the dtb.

> We discussed some possible issues, such as: what if a label is actually
> found in the base tree and thus resolved? This is handled by point 1.b.
> above: the OF core does not even try to resolve phandles beyond the
> connector, it would not make sense for connector anyway. In other words
> it only resolves local fixups, which are internal to the overlay, such
> as "thm" in the example above.
>=20
> This looked like the most promising approach because it handles nicely
> HDMI DDC and pinmux and minimize pollution in the phandle ID space.
>=20
> ---------------------------------------------------------------------
>=20
> So that was what we discussed in the meeting last Tuesday. We hope this
> will help in setting the current point and let the discussion move
> forward.

Let me throw a few more ideas in the pot.  None of these are total
solutions, but I think they may make good components of solutions.

1) Connector local labels/symbols/aliases

This is not a new idea - both the export-symbols proposal and my
ancient connector proposal had this in one form or another.  I think
something along these lines is almost essential.  Things that plug
into connectors almost always require references to several host board
resources (interrupt controller, gpio, ...).  In order to be pluggable
on multiple host boards you want to refer to those symbolically.  In
order to support multiple instances of the same connector type, you
need those symbols to refer to different things fordifferent connector
instances.

Whhat I think is a mistake is trying to tie this too closely to the
existing __symbols__ structure.  Those have an ugly encoding that
requires tortured processing in a way that's not natural for dtb
handling.  Plus they already kinda-sorta duplicate old-school aliases
in an odd way.

You want some sort of string =3D> node mapping on the connector side,
and a way to mark portions of properties on the plugin side as being
resolved to some string reference.  But we can take the opportunity to
design a better way of doing that than the ugly one we have now.

2) Extend dtb itself

A maor thing that makes current symbols and fixups ugly is the fact
that they are encoded into properties in the device tree itself,
despite being logically at a different semantic level.  Obviously you
*can* do that, but it's not natural.  It would make more sense to add
fixup tags into the dtb format itself.

3) bus-reg / bus-ranges

One thing that makes connector plugins a bit awkward is that they
often need to add things to multiple buses on the host system (MMIO &
i2c for a simple case).  This means that once resolved the plugin
isn't neatly a single subtree.  That's one factor making removal
really awkward.  Here's an idea I had a while ago to allow plugins to
be a single subtree, by extending what's allowed in the tree content:

Currently a node can only really have a presence on its immediate
parent bus, as encoded in the 'reg' and 'ranges' properties.
'bus-reg' and 'bus-ranges' would extend that having a similar format
to 'reg' and 'ranges' but adding a phandle for each entry saying which
bus it lives on - somewhat similar to interrupt-map.

For example, here's an MMIO bus bridge of some sort, which has control
registers on I2C:

	mmio-bus@... {
		#address-cells =3D < 2 >;
		#size-cells =3D < 2 >;
		bridge@XXXX {
			ranges =3D <...>;
			bus-reg =3D <&i2c0 0x407>
		}
	}
	i2c0: i2c@... {
		#address-cells =3D < 1 >;
		#size-cells =3D < 0 >;
	}

In a sense this extends the device tree to a device DAG.

Obviously this does need changes at the OS device core level, but it
gives you a lot of flexibility having done so.

4) You don't necessarily need to build a "full" device tree

Flattened device trees (as opposed to original IEEE1275 device trees)
- by design - allow certain information to be omitted.  The most
common example is that for introspectable buses, like PCI, it's normal
to have the DT only include a node for the host bridge, with devices
under it being discovered by their own bus specific methods.  That's
discovery is handled by the bus/bridge driver.

Connectors usually aren't introspectable, but it's still possible to
use an approach like this where the connector driver's discovery
method is "look at a different device tree".  So, for example,

Board device tree:

/ {
	compatible =3D "board-with-foo-connector";
	. . .
	mmio@... {
		foo-connector@... {
			compatible =3D "foo-connector";
			ranges =3D < ... >;
		}
	}
}

Foo device tree:

/ {
	compatible =3D "foo-device";
	foo-port-id =3D < 0x1234 >;
	component@... {
		reg =3D < ... >;
	}
}

Obviously a "foo device tree" would have different conventions than a
board device tree.  It wouldn't have /cpus, /memory, /chosen - but it
could have its own "magic" nodes that make sense for the properties of
the specific connector type.

Again, that would require work in the device core part of the OS.  The
bonus is that runtime addition and removal is now trivial.  No hacking
of the base device tree is needed, and so doesn't need to be reverted.
The connector driver just adds/removes the reference to its own
private tree.

This would, of course, need some way to refer to board resources
(interrupt controller, gpio controller) etc.  I think that can be
assembled using some of the previous ideas, though.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--Bfxbpu956IhQajja
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmi5IjQACgkQzQJF27ox
2Gdi7A//fqi//NZ0OfA3rXFkDFd2sELrcPBRiTTmOSv9wQ12PMpYncGB2AVxiL3D
DQeEfJaorimUkhBEghSI65mIssDaser/o7mBKDMrkZOHoL02SaPc8fqObg9gQ9Er
iGFDbG5QxL1BU16dwYSRevYGOo/kkFS6sB8hEST7Fvf+PrgcZvPsUDiBB8qaUtWD
uiUsEHPWj4IWXU1pz28bZ4Se/0/mYSxViEngnPzSCqQGJpiuuomEGBJlccsqTKwM
ciUAK8aVCoLkFjapuDdrkzPyd9PUfAD+cs+032v05NZQTuUI+VsxsKUphSYDE7c4
aE8Ghvu4RPxaZdF8Hy4pPjvrsya1oegGh0TN+KawfZcXuH57SXGjtVmPjyuOzzIM
sAIwgXTy11iW0nE25pG3gmqV42MdimJtPyqYnOIAyp991z2Cz7hTEeYc33FHnC17
AkZWROUQM8HShF+aVrZ09nEfViw/Ojzsm9GlDFVLQauRMGQxuvburMRK3seNmuBT
fwGueRFv7pJ14f06ZzMcw2eoPZRlwNzFvxETfevRXY8NzUbHe0T9SJ7uCJa/uVuD
jtX9QtqYtM+lulx+TgvdpBPSus1/ORRKtUhePXtMpoEEce0r0/5KMjUP5JVFqhyg
nKrElyLW9D19u6dFKhpnBRtUxCqcppqiK0Up+qOLCBPLHUi25QM=
=7CT/
-----END PGP SIGNATURE-----

--Bfxbpu956IhQajja--

