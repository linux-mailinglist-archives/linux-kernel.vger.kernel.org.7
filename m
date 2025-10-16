Return-Path: <linux-kernel+bounces-856511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B8BE45BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 449AE4F92A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7100734F472;
	Thu, 16 Oct 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyU80uoG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE62FBE1A;
	Thu, 16 Oct 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629898; cv=none; b=OloH1SFzc40NPbHBLDYkvpt9HiGEm4LKjOmYD4d5oc8klY4Q2x1mOkm+qhRpNTKJpWgiqBX4m6bx43nA7oHA6BMMBtXbw70s9qGaCVQ6IoKNYeeEYZq/EC/jnZ9T/Qe3tQ3ndJWlwFOCVg12aYXNsXWNx2MOajzXUVeEXkLPKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629898; c=relaxed/simple;
	bh=oq62L0QEd7GMpJS9eO2BskgBIJhoVEYg5AjMxl/aOgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtMl4i1x+EILWA5h+IWFc5kWwbPmzfLbgY9JUFra+SizGVhEmc+952spg34lYP/yMDVWy0buqven8489IuqiTnihKy4tb8rkkdlCtnZ7MZsYzmgIkWgp6Jlz+QvT1QmYtPx6/gqS4Hvrxqztuzk6J89puoCaiqZFRGnWUXsBk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyU80uoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F3AC4CEF1;
	Thu, 16 Oct 2025 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629898;
	bh=oq62L0QEd7GMpJS9eO2BskgBIJhoVEYg5AjMxl/aOgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyU80uoGG5kkW2++eUWu/SaamQze8xl4dWD0p4gadFBX6zlV4xiC2kRdqhSN8KTfv
	 0tzoGlONFV2sfqft42lulCb0CBRRddTlq8P5aUovib+1Ymmmiulw+sKKtZHw26Kljh
	 BwbYybapIwG+terlVH+cN/sa/Muyl5xe8dacgFlN21nP2UssMMuTOf1/1o8P3RZWSq
	 X2+NBTgvg7WFQ7+uMTXf+dshmkgqbkW5MHLsKxF+UF/IRDjXOjkuXHMfQb71Vk3GDq
	 YnoRWAke6Va5ytrbKmO57fhyMWVEV5FiC77Yw/GinFZmKGJmYi4bIdtRK2QYFpEEjM
	 y2XkgdeRysKyQ==
Date: Thu, 16 Oct 2025 16:51:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	E Shattow <e@freeshell.de>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 2/7] dt-bindings: PCI: starfive,jh7110-pcie: Add
 enable-gpios property
Message-ID: <20251016-countable-probing-062cd0504baf@spud>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
 <20251016080054.12484-3-hal.feng@starfivetech.com>
 <a4c5e7fd-a37d-4729-ad58-81523f813fb3@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0gGGbfbrsf7Gc4JG"
Content-Disposition: inline
In-Reply-To: <a4c5e7fd-a37d-4729-ad58-81523f813fb3@canonical.com>


--0gGGbfbrsf7Gc4JG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:58:41AM +0200, Heinrich Schuchardt wrote:
> On 10/16/25 10:00, Hal Feng wrote:
> > Add enable-gpios property for controlling the PCI bus device power.
> > This property had been supported in the driver but not added in the
> > dt-bindings.
> >=20
> > Fixes: 22fe32239770 ("dt-bindings: PCI: Add StarFive JH7110 PCIe contro=
ller")
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >   .../devicetree/bindings/pci/starfive,jh7110-pcie.yaml         | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie=
=2Eyaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> > index 5f432452c815..f254c7111837 100644
> > --- a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> > @@ -60,6 +60,10 @@ properties:
> >       description:
> >         The phandle to System Register Controller syscon node.
> > +  enable-gpios:
> > +    description: GPIO used to enable the PCI bus device power
> > +    maxItems: 1
> > +
>=20
> Shouldn't we try to keep the entries alphabetically ordered?

Grouping the two gpios together also has some value. I don't think it's
particularly important which way it is done.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

>=20
> Otherwise looks good.
>=20
> Best regards
>=20
> Heinrich
>=20
> >     perst-gpios:
> >       description: GPIO controlled connection to PERST# signal
> >       maxItems: 1
>=20
>=20

--0gGGbfbrsf7Gc4JG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEUhQAKCRB4tDGHoIJi
0kHnAP91tU6Elbe7EoQ06v9wFqPRkrxkwtDTP1VqY/ANSWwhiQD+IXGZb8bDIsQY
1ijBK46Ge9swvJk32RZqngcbnhRZ+A8=
=rpz9
-----END PGP SIGNATURE-----

--0gGGbfbrsf7Gc4JG--

