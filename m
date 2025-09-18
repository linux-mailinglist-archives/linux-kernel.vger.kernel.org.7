Return-Path: <linux-kernel+bounces-823096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7AB857D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1C61612CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FCA22D4C8;
	Thu, 18 Sep 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDe8kENv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA05923B60A;
	Thu, 18 Sep 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208296; cv=none; b=T+kcPP43gQYoC8sAskFNVMWUuYASlxx9h0RcaFkRMCRs5eCNe0JBWMcADYmqsJwpGDvnJ+Rg7kNoybhhto//v+tfqxeomUMb212oXOFO6RVsmNFnesbHbSIz0wd9HOIOzRsSovFWVk+U9fGbEOG4NoXRyDWpHgRMlo+1/Jvf8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208296; c=relaxed/simple;
	bh=zSISbfSAvIt3x62Kcz2q+Cmr5WtqzDMvYwREtN1Ye3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx2A+Ga5508JzTcydlbuG+LstkVDAC6JBxIfa5LcZz9eowboA/dXbef4GqRGga4isPOL0k+M+9iexgRcQLr/u5vkBNWObErkSfdwG5+09RB842l9uK8ItReKmOODCNe6NhLEHbQtxp/PwXgl+RDjRe9JbqAESKbw2VAIkCzIsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDe8kENv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397A8C4CEEB;
	Thu, 18 Sep 2025 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208295;
	bh=zSISbfSAvIt3x62Kcz2q+Cmr5WtqzDMvYwREtN1Ye3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDe8kENvBX+0INSopoFzFkqf332HLouvm8uIc+v7stjAvIdky41ObXlsqXoRSWG0D
	 hcgbA7ZsJSB/F62qUm6RYr7U713ADWdkAKCTVS8La7pSfhA13HaXf6uU8BNk8eTbjw
	 WMljP0vd9rtCLxFVXcpqXQ0+MQIBLctmCBCI1LRD1hNWbeD9a9jbO9Aop3Lsi1JObU
	 gbF0c2yoqx624PI+TkG4iN40VbZQ3KoR3OirY6WGErBaANuArKsvHyFiFemBuEkO4R
	 WMd9E2B7kJ8NomWpRex52KX2HM9EWhibXoXoDpOohEJDEAxBM++uJ88KwDa376htvw
	 jQiblV6r7hOOQ==
Date: Thu, 18 Sep 2025 16:11:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, balamanikandan.gunasundar@microchip.com,
	nicolas.ferre@microchip.com
Subject: Re: [PATCH 0/4] Add microchip sama7d65 SoC I3C support
Message-ID: <20250918-empathy-geology-7aeb6d44921c@spud>
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MHxoOq4p4ayT609I"
Content-Disposition: inline
In-Reply-To: <20250918095429.232710-1-durai.manickamkr@microchip.com>


--MHxoOq4p4ayT609I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 03:24:25PM +0530, Durai Manickam KR wrote:
> Add support for microchip sama7d65 SoC I3C master only IP which is based =
on=20
> mipi-i3c-hci from synopsys implementing version 1.0 specification. The pl=
atform=20
> specific changes are integrated in the existing mipi-i3c-hci driver by in=
troducing=20
> a quirk and SoC specific config option.
>=20
> I3C in master mode supports up to 12.5MHz, SDR mode data transfer in
> mixed bus mode (I2C and I3C target devices on same i3c bus).
>=20
> Testing done:
> With this patch we are able to fully configure the lsm6dso I3C slave
> device. Unlike I2C, I hope there is no linux utility to check the
> various transactions supported in the host controller. These features
> will be tested later probably with I3C analyser KIT.
>=20
> Durai Manickam KR (4):
>   clk: at91: sama7d65: add peripheral clock for I3C
>   i3c: mipi-i3c-hci: add microchip sama7d65 SoC
>   ARM: configs: at91: sama7: add sama7d65 i3c-hci
>   ARM: dts: microchip: add I3C controller
>=20
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     | 12 ++++++
>  arch/arm/configs/sama7_defconfig              |  2 +
>  drivers/clk/at91/sama7d65.c                   |  5 ++-
>  drivers/i3c/master/mipi-i3c-hci/Makefile      |  3 +-
>  drivers/i3c/master/mipi-i3c-hci/core.c        | 28 ++++++++++++
>  drivers/i3c/master/mipi-i3c-hci/hci.h         | 12 ++++++
>  .../i3c/master/mipi-i3c-hci/hci_quirks_mchp.c | 43 +++++++++++++++++++
>  7 files changed, 102 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c

This is actually v2 right? v1 was here:
https://lore.kernel.org/all/20250910-magician-retold-a6835179f71d@spud/

Where is the dt-binding that you also omitted there?

--MHxoOq4p4ayT609I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMwhIgAKCRB4tDGHoIJi
0t9gAQDOkpMj2tViMD06sKNAhxnTkDwdCR2IP1r1ujZ7VOQ2SAEAw0y9nbfOBpbu
nsN6QSqf5uc3Yz7gHuIwhOycF3D/GA0=
=bCaE
-----END PGP SIGNATURE-----

--MHxoOq4p4ayT609I--

