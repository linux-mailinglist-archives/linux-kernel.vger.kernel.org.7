Return-Path: <linux-kernel+bounces-810792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998AB51F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD643A69AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B5B334388;
	Wed, 10 Sep 2025 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUYb3e2g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B4261B83;
	Wed, 10 Sep 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526904; cv=none; b=W8Machvy4Tx0wP7YEkwYiJREhN6IVTV9BHm6zQNm0xxiMHeXy+GQIhobyiKQ0mw/qwrSzNSmCv6JL6d8325M735HA7WCG1VGS9U2gDJ0B6xuHx66fnCxxmqetUtwsb9XNacnoD2Mq/u9Qqha/EyvG93E52xDdAaYmiBNha5EGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526904; c=relaxed/simple;
	bh=azrvDpWLRoLEgILDy3un95kIXS4nsuMR6SFCe0uv0Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShRpnNJcpBsrcv7Zac0ToskWG32SYqoDr3S6fPSIyixSMF7PjBctZgageXuzH0d5OrPDEro+2jBu38dkr5jUnk5ccoyLxwxTQ6K32PeckKZZkaEdI9uEE7R8elJhdxxAZfxM91+sim0nNTxomQvl1PlitucShVH8+NmFSEbOPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUYb3e2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9893FC4CEF0;
	Wed, 10 Sep 2025 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757526903;
	bh=azrvDpWLRoLEgILDy3un95kIXS4nsuMR6SFCe0uv0Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUYb3e2gbdZy8wiixXLm4XD34LbyRbGP6Jm92K7vvghi7OoicbELkGpFo2LW5QInX
	 vVf/FsVCspyMXZ19zDEbBePnm/65TR96SWRiZC/I8B0ADnOiBeZ1rks64fxzE/U5qi
	 xJOFn6ziO+yLaOWo7N81T10eEWFD5+Qh1ulbQxet57SO8cL4WBqeahMzHL3z/4A5nw
	 TlHZSijMFZO4ObnshfDnTpppKRXKEJm2jijOL+ipL52+IZ5HQIVsRVTjRFgf5LbHA1
	 NN0pnfTAp1Sk/HxATR/IPTbVcP2012OZBJQ6XLqqOLtzL6qtEZewYYj9hKlXBEdLj/
	 z3yoR5r0L9GeA==
Date: Wed, 10 Sep 2025 18:54:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Durai.ManickamKR@microchip.com
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Balamanikandan.Gunasundar@microchip.com,
	Nicolas.Ferre@microchip.com
Subject: Re: [PATCH 0/4] Add Microchip I3C controller
Message-ID: <20250910-magician-retold-a6835179f71d@spud>
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
 <20250909-pointy-tanning-8e7b4320979d@spud>
 <d3daaab9-71f5-49e6-b3de-b05339fa7adf@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bU1/wKBcuNijAj8P"
Content-Disposition: inline
In-Reply-To: <d3daaab9-71f5-49e6-b3de-b05339fa7adf@microchip.com>


--bU1/wKBcuNijAj8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 06:14:21AM +0000, Durai.ManickamKR@microchip.com wr=
ote:
> On 10/09/25 01:16, Conor Dooley wrote:
> > On Tue, Sep 09, 2025 at 04:43:29PM +0530, Durai Manickam KR wrote:
> >> Add support for microchip SAMA7D65 I3C HCI master only IP. This
> >> hardware is an instance of the MIPI I3C HCI Controller implementing
> >> version 1.0 specification. This driver adds platform-specific
> >> support for SAMA7D65 SoC.
> >>
> >> I3C in master mode supports up to 12.5MHz, SDR mode data transfer in
> >> mixed bus mode (I2C and I3C target devices on same i3c bus). It also
> >> supports IBI mechanism.
> >>     =20
> >> Features tested and supported :
> >> 	Standard CCC commands.
> >>         	I3C SDR mode private transfers in PIO mode.
> >>         	I2C transfers in PIO mode.
> >>         	Pure bus mode and mixed bus mode.
> >>
> >> Testing done:
> >> With this patch we are able to fully configure the lsm6dso I3C slave
> >> device. Unlike I2C, I hope there is no linux utility to check the
> >> various transactions supported in the host controller. These features
> >> will be added later on this driver after testing (probably with I3C
> >> analyser KIT).
> >>
> >> Durai Manickam KR (4):
> >>    clk: at91: sama7d65: add peripheral clock for I3C
> >>    i3c: master: add Microchip SAMA7D65 I3C HCI master driver
> >>    ARM: configs: at91: sama7: Add SAMA7D65 I3C HCI master
> >>    ARM: dts: microchip: add I3C controller
> >>
> >>   arch/arm/boot/dts/microchip/sama7d65.dtsi    |   12 +
> >>   arch/arm/configs/sama7_defconfig             |    2 +
> >>   drivers/clk/at91/sama7d65.c                  |    5 +-
> >>   drivers/i3c/master/Kconfig                   |   14 +
> >>   drivers/i3c/master/Makefile                  |    1 +
> >>   drivers/i3c/master/sama7d65-i3c-hci-master.c | 2705 ++++++++++++++++=
++
> >>   6 files changed, 2737 insertions(+), 2 deletions(-)
> >>   create mode 100644 drivers/i3c/master/sama7d65-i3c-hci-master.c
>=20
> Hi Conor,
>=20
> Was planning to sent along with the review comments received for the i3c=
=20
> driver. Will add this and send in patch v2 series.
>=20
> > Where is your dt-binding?

Weird quoting going on here. Why didn't you just send it with the v1,
like is normally done? There's no explanation provided about why you've
omitted it.

--bU1/wKBcuNijAj8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMG7cgAKCRB4tDGHoIJi
0s05AQCP7G23S1NipJsfJOd8wie6aelbD8Sa6UynTd7Ochn8+gD+K5Xc1U9x1a/Y
M4nWFL3C49jxzVXqTIRFRPhMFJxZIww=
=Iava
-----END PGP SIGNATURE-----

--bU1/wKBcuNijAj8P--

