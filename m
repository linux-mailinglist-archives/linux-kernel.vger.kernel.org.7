Return-Path: <linux-kernel+bounces-727957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC40B021C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071B51C404A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED092EF640;
	Fri, 11 Jul 2025 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTupPdIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346EC2ED161;
	Fri, 11 Jul 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251343; cv=none; b=R9QleY4cSnLsDuZZyL4kjQwfMjgPc6jUONY/5S6pX6LgUbAfC6spiXxd/UZzHpQwu0T9sX7Y/kwMLnpgYtrIJ97aAGMZzASzZKJ8g8skRR+IqXuYZeUF2xRvwoGews67sqr50YgThoX365LJxtFQw2eL5C7jtXdtXhjm2pyMiDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251343; c=relaxed/simple;
	bh=b+Z4o3/eh+PDmySIWDOrDrcQtnjrf0ThYXaUFJVR9jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPtYSYXHIz1tzWJDgW9leFaW1YHPU6Zc98xDb0RNI4PKnXRIiRFkYlVcheND5C0JatcVq0jYVyH5tVPNCQL7vUbp0ezYzIqIvNNTM7yV/b9eXWnzlOU+VVGxxubepdcLX3noTa2Yfmj64heAAH3bggepR8xv8PYiGRrGBGiZ1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTupPdIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB1CC4CEED;
	Fri, 11 Jul 2025 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752251342;
	bh=b+Z4o3/eh+PDmySIWDOrDrcQtnjrf0ThYXaUFJVR9jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTupPdIRIyUyX3r5iP9edWdm4p8NccbZGvcXTJGs2s8+VJ29KyYJ3Cu/yNbUAb9Gr
	 4KUJHaXNBiRW/3y6dY7MIzw63tmo2sETHnolwDlM7lqwW8t8E20ZdrRBkesELKF1Cb
	 TjUVQSeqg/kYSPgf85rsywP8pIoB9RpUsbcJlYHzJgCy/7X701HMJWpmcmr5WEPJ2G
	 yddciCYRYlfWzjob5GvNNryS3zxuUruL65M2oDr3XTTdxTmngncKkGnDIuiwf+3Bnr
	 hImQPnEIb5iBJVM7HuCLJTNe17NJS/cQrTgHPcH6JqOaUUOv1B3YKkoJEY/jEYBvml
	 deibpuLwJP+7g==
Date: Fri, 11 Jul 2025 17:28:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Devid Lechner <dlechner@baylibre.com>,
	Adrian Costina <adrian.costina@analog.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <20250711-eradicate-vendetta-ea6d44737e0c@spud>
References: <20250626-adi-i3c-master-v4-0-3846a1f66d5e@analog.com>
 <20250626-adi-i3c-master-v4-1-3846a1f66d5e@analog.com>
 <20250627-steadfast-ferret-of-expertise-5c8ff2@krzk-bin>
 <tl5fckhrivaqfyzwyb2o2a7gykpigwend7z2nduqgbbej3hqbs@vxxtsadhtdmt>
 <41782ded-908b-46ef-8f75-4d2565476b7c@kernel.org>
 <cfi6rzhco2ba6pcbk57l7tblimuks5jnpgaly7nbedbrpyhtma@u46if22kurwk>
 <v2ybju75bpjdqxfkell47nlkeyal36ylmnqt2yvpncxnmp2irb@pygx56jsyxkr>
 <20250702-armchair-favorite-c734b53444e2@spud>
 <pbaxwzj3gmjwkqbh32wfcac4zqjyg4sfkgit3hs6v372cxf3wa@kp5qg6m2tqlm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QSvdFjFjJD5j+J0F"
Content-Disposition: inline
In-Reply-To: <pbaxwzj3gmjwkqbh32wfcac4zqjyg4sfkgit3hs6v372cxf3wa@kp5qg6m2tqlm>


--QSvdFjFjJD5j+J0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 10:14:45AM +0200, Jorge Marques wrote:
> On Wed, Jul 02, 2025 at 12:38:41PM +0100, Conor Dooley wrote:
> > On Wed, Jul 02, 2025 at 12:58:00PM +0200, Jorge Marques wrote:
> > > On Fri, Jun 27, 2025 at 06:02:26PM +0200, Jorge Marques wrote:
> > > > On Fri, Jun 27, 2025 at 04:49:19PM +0200, Krzysztof Kozlowski wrote:
> > > > > On 27/06/2025 16:38, Jorge Marques wrote:
> > > > > > On Fri, Jun 27, 2025 at 08:56:55AM +0200, Krzysztof Kozlowski w=
rote:
> > > > > >> On Thu, Jun 26, 2025 at 12:07:36PM +0200, Jorge Marques wrote:
> > > > > >>> Add bindings doc for ADI I3C Controller IP core, a FPGA synth=
esizable IP
> > > > > >>> core that implements the MIPI I3C Basic controller specificat=
ion.
> > > > > >>
> > > > > >> How did you resolve my last comment? I don't see any explanati=
on -
> > > > > >> neither here nor in the binding description. Binding descripti=
on is
> > > > > >> actually better place, I think now.
> > > > > >>
> > > > > >> Best regards,
> > > > > >> Krzysztof
> > > > > >>
> > > > > >=20
> > > > > > Hi Krzysztof,
> > > > > >=20
> > > > > > I forgot to condense out discussion on v4.
> > > > > > What about this binding description:
> > > > > >=20
> > > > > >   description: |
> > > > > >     FPGA-based I3C controller designed to interface with I3C an=
d I2C
> > > > > >     peripherals, implementing a subset of the I3C-basic specifi=
cation.
> > > > > >     The IP core is tested on arm, microblaze, and arm64 archite=
ctures.
> > > > > >     It takes one or two clocks, axi and i3c. If only axi is pro=
vided,
> > > > > >     then there is no clock signal to the i3c input clock pin an=
d axi
> > > > >=20
> > > > > This is obvious from the schema, drop.
> > > > Ack.
> > > >=20
> > > > >=20
> > > > > >     clock drives the whole IP. The compatible is suffixed by 1.=
00.a
> > > > > >     foreseeing future controllers by Analog Devices Inc. and br=
eaking
> > > > > >     changes.
> > > > >=20
> > > > > I don't understand that. How are you breaking any changes? And how
> > > > > 1.00.a predicts future? I don't think this reflects previous disc=
ussion.
> > > > > Why you were asked to go with v1.00.a?
> > > > The -1.00.a suffix came from this discussion:
> > > >  =20
> > > >   https://lore.kernel.org/linux-i3c/ildi2pup2zkyv4stuknkrjysex3yzsb=
rrsrwbgcc4xgvdhwrdd@7qh4y6mutgy2/
> > > >=20
> > > > Other adi bindings use this suffix. I personally wouldn't add any s=
uffix
> > > > unless told otherwise, as I expressed on the thread. Should I drop =
it?
> > > > or suffix it with something else?
> >=20
> > >=20
> > > I went after the reason of the historically -1.00.a suffix and
> > > discovered that they came into existence due to AMD Xilinx auto
> > > generation devicetree tool SDTGen
> > > https://github.com/Xilinx/system-device-tree-xlnx
> > > that would automatically suffix with the IP version, defaulting to 1.=
00.a,
> > > and for a seamless experience, the were copied over to the dt-binding=
s.
> > >=20
> > > The adi,axi-pwmgen dt-binding went more creative and suffixed with
> > > -2.00.a, while never enforcing Vivado to yield the devicetree with su=
ch
> > > value (Major version is asserted in the driver through reg access, the
> > > current core version is v2.1.1)
> > >=20
> > > Testing on my side (AMD Xilinx Vivado 2024.2), it seems Vivado now
> > > defaults to 1.0, so the previous bindings from the other IPs are not
> > > accurate anymore, either, (axi-pwmgen auto gens
> > > `compatible =3D "xlnx,axi-pwm-gen-1.0";` (`xlnx` instead of `adi`, al=
so)).
> > >=20
> > > For fun, the current Vivado version thinks the devicetree node for the
> > > i3c master should be as follows:
> > >=20
> > >   i3c_host_interface: i3c_controller_host_interface@44a00000 {
> > >           compatible =3D "xlnx,i3c-controller-host-interface-1.0";
> > >           reg =3D <0x44a00000 0x10000>;
> > >           clocks =3D <&clkc 15>;
> > >           clock-names =3D "s_axi_aclk";
> > >   };
> > >=20
> > > Let me know if we can drop the suffix, or replace with something else.
> > > The current register defined core version is v0.1.0.
> >=20
> > Please, as I requested in the original thread, add versioning
> > information. I'm clearly not asking you to make up some garbage version
> > number, or to add "1.00a" if that's not an accurate version (and never
> > did AFAICT). If 0.1.0 is the version of the IP core, I'd like you to use
> > that.
> >=20
> > If other ADI IP cores are using crap version numbers that came from
> > some Xilinx tooling that don't represent the actual versions of the IPs,
> > that's probably something you should mention to your colleagues that
> > maintain those bindings.
>=20
>=20
> My proposal (1) for the Analog Devices Inc. open source IP Cores is to
> migrate to semantic versioning.
> (1) https://github.com/analogdevicesinc/hdl/pull/1831
>=20
> The dt-binding must end with the major value, with the first supported
> version starting at 1. Therefore, the binding will be:
>=20
> * adi,i3c-master-1
>=20
> At driver level, the debug version value is `v%u.%u.%u`, and the driver
> shall check the minor version value for handling feature changes. While
> the major bump is restricted for breaking changes, which, in some cases,
> also generates a new dt-binding.
>=20
> For backwards compatibility, existing ADI IP Cores that prints `v%u.%u.%c`
> should print `v%u.%u.%u` instead, but keep their current value (e.g.,
> `a`->`97`), until the minor is bumped, when the patch version resets to 0.
>=20
> Rework across register accessed IPs is being handled here:
> https://github.com/analogdevicesinc/hdl/pull/1829
> There are more than 50 IPs with register access, so I need to be cautious.
>=20
> What is your take on this? Does it resolve the bindings concern?

I think it is a good idea to establish version numbers that actually
have a meaning, rather than using something garbage. I think you should
probably put the "v" into the number in the compatible - 1.00 or 1.00.a
is fairly clearly a version number but "-1" is less clear.

Also "the binding must end with the major value" is a bit of an odd
requirement I think. The sort of situations that may cause different
compatibles to be introduced are not likely to be restricted to majors.
That may be something like properties only valid for some versions, or
at worst a bug that requires checking the compatible (even if these
are much rarer when there's a version register, they're still possible).

IDM what number you opt for in the end either, it could well just be the
lowest number where the current register offset/format for the version
number register exists.

It's a bit hypocritical of me to ask this, since I have not yet written
one for the Microchip stuff - but I think you should document whatever
numbering you end up on, like in xilinx.txt and
sifive-blocks-ip-versioning.txt, so that we can point people at it.

>=20
> Adding David to the thread, since the axi-spi-engine already moved to
> `v%u.%u.%u` format.
>=20
> Best regards,
> Jorge
>=20

--QSvdFjFjJD5j+J0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaHE7yQAKCRB4tDGHoIJi
0o42AP47w+sce+uiT/2WjfHUOH2o2VbuebH7Lrtbrqyr7MJfyQEAwYdeSPJIdHQL
vQiXrfinsaNjtmIrwZJ9a4OBDB+E2AI=
=4oMY
-----END PGP SIGNATURE-----

--QSvdFjFjJD5j+J0F--

