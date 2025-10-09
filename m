Return-Path: <linux-kernel+bounces-847068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4587BC9CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5331A63213
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F21FF61E;
	Thu,  9 Oct 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE5kcC50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCC1DE8AE;
	Thu,  9 Oct 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023636; cv=none; b=TFli3M/3UfmbbGv5axd9ZbhrQRL0bsqC6VhpiYfo3gyMjH2jDnMixgnG6I0dqYbggKLYQiGohZh2Fl8T/4jFOGwYif5F1hJxSsnW2fUuY2P190Jm0P84PSbceGoujw+SHK1yvSrBdS0xaIHoeur5ailSnNQDg8zU8mt805pSH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023636; c=relaxed/simple;
	bh=mmGYKciRNdjxJeWKpsJv6Woc1jASOtzqRmKHlNJJKRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/rnSHu053FROIeAaDmYiWSmzt95DT6gcYIlDmyVzMWk4L/+8v6GONe7fo6CO5+QE5U7/QIwqnFoPk/8oximNCsJ08wsndmbMSTb+Wv/UtkQjGxfYAzk/hA5D8bb5p0ov202eakAi44b7kMlJ8BRbzmFuQjP5+n0JbrCIgnpUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE5kcC50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDFAC4CEE7;
	Thu,  9 Oct 2025 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760023635;
	bh=mmGYKciRNdjxJeWKpsJv6Woc1jASOtzqRmKHlNJJKRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fE5kcC50z+Off25M9rzlEmb3rVm9DTmA1FsHLUM+sy6uE+szyKARzhu5PuYHJNejx
	 m+fYpfQNC7RmWaR4ffMy06GFdBRgMhLtLi8uCl8b4x7cFaoizmJ36LGekJtXJl//pM
	 yHhhV1K6YumXVfHTC3UMLx8RdqK1hHLA3r1OQp+j20uCynU7EK1HaKoeLeJ9cou56c
	 jVHL+SwOeCjGhK1otMdtt5A1FpkInAoAXeSGt2djiKYehtW/rDIQYLRjjXt5Hmj4eG
	 /7K5LTBCu0FN92gEPKVKqaFAI7fPoqC4QtgtKotQ0Van8nLvXJ02ZI9EdboH/49DE1
	 YkqRxh2ZGhwRQ==
Date: Thu, 9 Oct 2025 16:27:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@gentoo.org>, Troy Mitchell <troy.mitchell@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: riscv: spacemit: Add MusePi Pro board
Message-ID: <20251009-crazy-outhouse-fe3e47d0dbe7@spud>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
 <20250928074914-GYA1344940@gentoo.org>
 <20250929-challenge-molecular-947bb1f5962b@spud>
 <A5845378AE731404+aOdtKmFPaYfc2n7n@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TTeySwOLHeYm7U/L"
Content-Disposition: inline
In-Reply-To: <A5845378AE731404+aOdtKmFPaYfc2n7n@kernel.org>


--TTeySwOLHeYm7U/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 04:07:06PM +0800, Troy Mitchell wrote:
> On Mon, Sep 29, 2025 at 06:48:22PM +0100, Conor Dooley wrote:
> > On Sun, Sep 28, 2025 at 03:49:14PM +0800, Yixun Lan wrote:
> > > Hi Troy,
> > >=20
> > > On 12:16 Sun 28 Sep     , Troy Mitchell wrote:
> > > > From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > >=20
> > > > Document the compatible string for the MusePi Pro [1].
> > > > It is a 1.8-inch single board computer based on the
> > > > SpacemiT K1/M1 RISC-V SoC [2].
> > > you could wrap at slightly more characters, I remember 72 chars
> > > (haven't spent time to find a formal document link..)
> > >=20
> > > >=20
> > > > Link:
> > > > https://developer.spacemit.com/documentation?token=3DYJtdwnvvViPVcm=
koPDpcvwfVnrh&type=3Dpdf
> > > I'd suggest to list core features of this board, while using this lin=
k as a complement,
> > > base on previous experience, vendor may change the link address, thus=
 the link vanish
> >=20
> > The link doesn't even work for me.
> Could you double check if it really doesn't work now?
>=20
> > Is this board actually made by spacemit as a developer platform?
> Yes.

With the link, that seems pretty clear. Not sure why the link didn't
work before, but it is working now.

Cheers,
Conor.

--TTeySwOLHeYm7U/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOfUSgAKCRB4tDGHoIJi
0m1+AP0eT/PWdBBoKEsVOyd51NTvO64ceUYNyzdvNKX+jrdvAAD/RUig3ZZAszrn
9sEmMD7SB2/wCBYFNmp+18Vv1noH4AU=
=TzA+
-----END PGP SIGNATURE-----

--TTeySwOLHeYm7U/L--

