Return-Path: <linux-kernel+bounces-836649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BADBAA3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EFF42220A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC4920C038;
	Mon, 29 Sep 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnk+Fs6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7D33EC;
	Mon, 29 Sep 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168108; cv=none; b=Yy2Svq7VJcEheFZQvxuhzcFihSYInCwxaUd1hXlg+S9WEA2OsaHVXrIuN1sT1RcVO8nhQfm9hH38Wm0XN+cvVP5zZmDFgex8KmKMJKYRXRL46U809tgP6DkOdJWzSTkwuwTatbVZ72XlznAKXTYf++Xq43o2XLIhosPojJXukUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168108; c=relaxed/simple;
	bh=QYNJjNkcAi8f1hxQxRPpHKeysPae/MLqNM8ctOgO/eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqVCDRLHjMukfw6MY5wYgml7r+L9ES86SzAlZvhKPMsPphnVJlkFQOqE+Y8QJ6wPD/bgkatIHyp5jNTzdYD/abAACM9eOMuN1vVWYm81BEKCF6zI8Wsa2EJUjqsbalGL7vLvBmQQkJUSQ+roO4LF2Hrkav+tyJjVuR38ohJTUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnk+Fs6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1160C113D0;
	Mon, 29 Sep 2025 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759168107;
	bh=QYNJjNkcAi8f1hxQxRPpHKeysPae/MLqNM8ctOgO/eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lnk+Fs6k9EebnHXbPkvyWtVU1BONOuKH3ce7BMs3Y0U/Z0cB17CrCv9odBtFdJ5w4
	 l74lyv0bm5fELHyt3Zy8iG2ZlfDpGdYZ9ZjDWjtWOrNWjMzg73gsQOgrBRfcKVWlWS
	 1ofJVXY7HhUg9IC1rUnxb+UWvGWevioLdtuQlPVIqli29hAn4HQyIPIsZ57Jjz8dxs
	 q8meddvm47unHiBchMMv53FkEyREEI/xyR3s9qD/ei2KHYR1g4zfIaq/l/c0OhlETO
	 T+B2Gmv4ahhs1WeS2x/hJI7vpF+dkUVsFYvkyA3uOyIZrIKCb2Y3piOMuFcPoOpGjq
	 9BkJ22xbJq/1g==
Date: Mon, 29 Sep 2025 18:48:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: riscv: spacemit: Add MusePi Pro board
Message-ID: <20250929-challenge-molecular-947bb1f5962b@spud>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
 <20250928074914-GYA1344940@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvUen0NxRlUjr0cE"
Content-Disposition: inline
In-Reply-To: <20250928074914-GYA1344940@gentoo.org>


--cvUen0NxRlUjr0cE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 03:49:14PM +0800, Yixun Lan wrote:
> Hi Troy,
>=20
> On 12:16 Sun 28 Sep     , Troy Mitchell wrote:
> > From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> >=20
> > Document the compatible string for the MusePi Pro [1].
> > It is a 1.8-inch single board computer based on the
> > SpacemiT K1/M1 RISC-V SoC [2].
> you could wrap at slightly more characters, I remember 72 chars
> (haven't spent time to find a formal document link..)
>=20
> >=20
> > Link:
> > https://developer.spacemit.com/documentation?token=3DYJtdwnvvViPVcmkoPD=
pcvwfVnrh&type=3Dpdf
> I'd suggest to list core features of this board, while using this link as=
 a complement,
> base on previous experience, vendor may change the link address, thus the=
 link vanish

The link doesn't even work for me. Is this board actually made by
spacemit as a developer platform?

>=20
> > [1]
> > https://www.spacemit.com/en/key-stone-k1 [2]
> >=20
> pleae keep them in one line, no break, and no blank line between SoB,
> something as below
> Link: https://.. [1]
>=20
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Do=
cumentation/devicetree/bindings/riscv/spacemit.yaml
> > index c56b62a6299ac24d3cdef7edcdfc407dc62a1846..52fe39296031f21d1c28c4f=
1ea5ca9fe28caf45a 100644
> > --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > @@ -22,6 +22,7 @@ properties:
> >            - enum:
> >                - bananapi,bpi-f3
> >                - milkv,jupiter
> > +              - spacemit,musepi-pro
> >                - xunlong,orangepi-rv2
> >            - const: spacemit,k1
> > =20
> >=20
> > --=20
> > 2.51.0
> >=20
>=20
> --=20
> Yixun Lan (dlan)

--cvUen0NxRlUjr0cE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrGZgAKCRB4tDGHoIJi
0nnyAQC2RbyZY4DxV9VTcddgsLFj7tNKJ8OGxuJMGloqBaPbzQEA+MImol8+wEvz
kopy4+f2gaph1xiXjMrIP82j4HmnMwc=
=wddC
-----END PGP SIGNATURE-----

--cvUen0NxRlUjr0cE--

