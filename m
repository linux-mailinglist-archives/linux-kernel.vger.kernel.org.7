Return-Path: <linux-kernel+bounces-848367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C414ABCD8D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC83B1873
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A582F5468;
	Fri, 10 Oct 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzpCnfxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A71799F;
	Fri, 10 Oct 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107034; cv=none; b=lcQmy27mvO5rtosth+gDqo2ezdk8pqBroAtEKiY+ZwVZvgxQQqpQBycc11AE54MWdiX0ay39wlQo/AhkBNniFL6Vxpihte3wJLfeXgP+2oOqfs4lNcXFt3RfzRLlXZqRHewBgOjhGnmxbveW2vO2TBtIoblPhDcc0jgR5uKTCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107034; c=relaxed/simple;
	bh=s/1cm3JtYs5oFJ7ybMcIXXvPPIeswgT6HbhP7HdsLJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD7mUb97TKH1L6mFLRJDcrKTY6qqvt10z91jEu3CVhOuYIL2Yv/+spiqu8G7rUrx1Wu+kyOvKwsVoI7OnO0PTaVEg9z5EFLOJEuSWB7UV9RTNma5WH0fhxRwJMsszk2e8GzNEUdW7cDvEVUChcBCS/0LV4jpupAxxaM3dqH/EEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzpCnfxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39795C4CEF9;
	Fri, 10 Oct 2025 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760107034;
	bh=s/1cm3JtYs5oFJ7ybMcIXXvPPIeswgT6HbhP7HdsLJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzpCnfxA91/9uTAy29Ij61WOSsOPL5h11bGJehLK9LoDegETCJQ8aTA5SIaE8fRzq
	 wQjBlh1I4Npgxym4g7S39hi1vVvu2q4QPH+mqWjqgpPQUO9wjSseZSXLvRtXeaG3Un
	 Gp2wzVarGSYj/aPHsiXa4PuT5/pF9fVscqazK2UK7m5yHpiwo85WqsXOoNM/X+0neH
	 9n6oklNfOegosMo+DNDofPenM6dNfl/bEjpn6pRRKXTOavydJKmZYnYea8NAqvsYti
	 1vX6JNb6vXlZYRYbtUDHH4t3otZ4gIgbnAj1ykrWZ+aDlAbYi2JrKk94xYRQWrhEeq
	 +29IiRA8Dyruw==
Date: Fri, 10 Oct 2025 15:37:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] riscv: dts: spacemit: add Ethernet support for
 MusePi Pro
Message-ID: <20251010-confider-raven-0ad7a810e5de@spud>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
 <20251010-k1-musepi-pro-dts-v2-5-6e1b491f6f3e@linux.spacemit.com>
 <a02aec9a-976a-4b63-86cb-126b8ae71185@iscas.ac.cn>
 <59657BBB86F7B678+aOilnA5Z-QL7xF9O@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tSrRefdJZc0Wu8hp"
Content-Disposition: inline
In-Reply-To: <59657BBB86F7B678+aOilnA5Z-QL7xF9O@kernel.org>


--tSrRefdJZc0Wu8hp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 02:20:12PM +0800, Troy Mitchell wrote:
> On Fri, Oct 10, 2025 at 02:13:31PM +0800, Vivian Wang wrote:
> >=20
> > On 10/10/25 09:56, Troy Mitchell wrote:
> > > MusePi Pro features a single RGMII Ethernet port with
> > > PHY reset controlled by GPIO.
> > >
> > > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > ---
> > >  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 23 ++++++++++++++++=
+++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/ri=
scv/boot/dts/spacemit/k1-musepi-pro.dts
> > > index 89a35914710bfd15c6ad27cd8d0de7ccf62e2309..e9a53dc7a417117c82f3e=
467677290bdaeffc845 100644
> > > --- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > > +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > > @@ -47,6 +47,29 @@ &pdma {
> > >  	status =3D "okay";
> > >  };
> > > =20
> > > +&eth0 {
> >=20
> > For node orders in board DTS for SpacemiT devices, usually we follow
> > node name order because there's no unit address to go off of here, so
> > for what we have here it should be emmc, eth0, pdma, uart.
> >=20
> > See e.g. arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts and previous
> > discussion [1].
> Thanks for you point out!
>=20
> >=20
> > Also, personally I think it would be fine to just add the whole
> > k1-musepi-pro.dts in the same patch instead of splitting it up like
> > this. I feel it would be easier to manage this way. For previous devices
> > these nodes have been added piecemeal mostly because the drivers were
> > being developed in parallel, but if you're going to base this on
> > v6.18-rc1 there shouldn't be dependency problems.
> >=20
> > Maybe Yixun can chime in about this as well.
> We have talked here [1]
>=20
> Personally, I think splitting them makes the commit history clearer.
> I'm happy to merge them if others also think it's more appropriate.

tbh, I don't think it makes much sense to add it piecemeal, you'd then
end up potentially with dozens of commits for new platforms later in the
life of the SoC.
When you're adding new boards, add them in as complete as possible a
state from the beginning.

--tSrRefdJZc0Wu8hp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOkaFAAKCRB4tDGHoIJi
0mnmAPoDrRy1juQYH/xYfmDSBCYLSewyZWxEtBQHGn6txXcfdgEAsgoGn6FXGi20
NYtBXo7ojNi8Sje/vnE6muxgoX7MOA4=
=oUEM
-----END PGP SIGNATURE-----

--tSrRefdJZc0Wu8hp--

