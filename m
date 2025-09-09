Return-Path: <linux-kernel+bounces-808919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBB3B5068E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD738443943
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFEC301007;
	Tue,  9 Sep 2025 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgING1j8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665A217F24;
	Tue,  9 Sep 2025 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447216; cv=none; b=stlb3Mp+P9PsyYRlNkCEePC3U0pnxgSd0osNlRw5bWuJYdDks7ttslFuThR4KU+eFbhbvhB3giijnfNqS7dYZ5rtF42iKxN3BLtoMe9JlXUyTkCuoMXtLLpv/qm34J1V4Ab7XKJ552EVAWxmhf1cuOxqgF840IkwrgOZuxrXQT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447216; c=relaxed/simple;
	bh=7ScPPDBLqgTRfpZVYiWUNROBp2LC930SYUNUqIVvSGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMPg3Smz6CLTJE6j6EzFeDY1M70pwjAR414e1T6yRQWlW9JUz4i4BluEF+qgZlzMJ0S4W64ITw1GZ6llFZ5M7CzQm0S6nN3zoElXlL0SPo/sBu/L+d4yMeMNbVohywZ4Cxx3Z0dYCrv63DavNACWxG4s//6LANonU3GYhPpJ62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgING1j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B51C4CEF4;
	Tue,  9 Sep 2025 19:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757447216;
	bh=7ScPPDBLqgTRfpZVYiWUNROBp2LC930SYUNUqIVvSGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgING1j8ITYqo+w+ZE720yT1uAvmfUiHE3V835LRWXenuJ1lk/4/mRRscnat2bsar
	 2cJRK4/rXdd54ryhLk1TaqD1uKJhI+HK36zHCBsEKTRarkMXAsAncGIyiArq0M05gE
	 A0qQYCH8do+8onOr3WJq48phZKCxajOy89tLOFZ7F8Q0QRZEnjH0z4rR4AMkIUR/vz
	 kTmIuZIngv7gtu91Br8aF6t68tFQfsdIed9ePNDTInAW/OYBJvn2uCk6YeuhZeCK1d
	 5lmJGCNX372lzDMeiS2JFtR74kSJTpCVgTp960djrpNQ24RnykxgrfnFftjXzqCAtb
	 pG4nnSeGFao4Q==
Date: Tue, 9 Sep 2025 20:46:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, balamanikandan.gunasundar@microchip.com,
	nicolas.ferre@microchip.com
Subject: Re: [PATCH 0/4] Add Microchip I3C controller
Message-ID: <20250909-pointy-tanning-8e7b4320979d@spud>
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bccwR6h2lKhRSsYP"
Content-Disposition: inline
In-Reply-To: <20250909111333.170016-1-durai.manickamkr@microchip.com>


--bccwR6h2lKhRSsYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 04:43:29PM +0530, Durai Manickam KR wrote:
> Add support for microchip SAMA7D65 I3C HCI master only IP. This
> hardware is an instance of the MIPI I3C HCI Controller implementing
> version 1.0 specification. This driver adds platform-specific
> support for SAMA7D65 SoC.
>=20
> I3C in master mode supports up to 12.5MHz, SDR mode data transfer in
> mixed bus mode (I2C and I3C target devices on same i3c bus). It also
> supports IBI mechanism.
>    =20
> Features tested and supported :
> 	Standard CCC commands.
>        	I3C SDR mode private transfers in PIO mode.
>        	I2C transfers in PIO mode.
>        	Pure bus mode and mixed bus mode.
>=20
> Testing done:
> With this patch we are able to fully configure the lsm6dso I3C slave
> device. Unlike I2C, I hope there is no linux utility to check the
> various transactions supported in the host controller. These features
> will be added later on this driver after testing (probably with I3C
> analyser KIT).
>=20
> Durai Manickam KR (4):
>   clk: at91: sama7d65: add peripheral clock for I3C
>   i3c: master: add Microchip SAMA7D65 I3C HCI master driver
>   ARM: configs: at91: sama7: Add SAMA7D65 I3C HCI master
>   ARM: dts: microchip: add I3C controller
>=20
>  arch/arm/boot/dts/microchip/sama7d65.dtsi    |   12 +
>  arch/arm/configs/sama7_defconfig             |    2 +
>  drivers/clk/at91/sama7d65.c                  |    5 +-
>  drivers/i3c/master/Kconfig                   |   14 +
>  drivers/i3c/master/Makefile                  |    1 +
>  drivers/i3c/master/sama7d65-i3c-hci-master.c | 2705 ++++++++++++++++++
>  6 files changed, 2737 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/i3c/master/sama7d65-i3c-hci-master.c

Where is your dt-binding?

--bccwR6h2lKhRSsYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMCEKwAKCRB4tDGHoIJi
0r7ZAQCTBnAV4Wn+pTN3+wCIOYGS0jYhZs+X+llJ2HIcWkKVdgD/SvAvKvYbuKH+
hwqxPztZvWI/Ee+rfQJb8gQQ0XPEDgA=
=Eui4
-----END PGP SIGNATURE-----

--bccwR6h2lKhRSsYP--

