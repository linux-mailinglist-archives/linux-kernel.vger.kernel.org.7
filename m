Return-Path: <linux-kernel+bounces-822601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0541B84404
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CEF7B23C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C592FFFB2;
	Thu, 18 Sep 2025 10:59:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4442FFDE9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193171; cv=none; b=U5QdnNtyxJNFKUvI+uMH3+Ulei4mSSvErBRjuK5sVO0Slymq9SHrzDtWve5ouhRpaTa41A/dq8O6FMPUI10l4fS1EATQ94pY1yZcQswy+RQnU1cdG1GbWhe5nftFek3Ki6ujX3nTP7aJZyB62/N4j9CjnAylS6SF1kArNhFsJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193171; c=relaxed/simple;
	bh=uQ0qyw5c8o/+colPeKujxDOwIHdwYhxWGqbj0nq87f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owpJuymupHOkQGEkEvdqlVcE8ciguW/yLdPkcrWdQStjBWB7Hw3EHhcuan4nLTQZ3KrFGvstGX1XN+rSz5BPtU+iFI0cOvChlVEIF36jobR0t/jDiudWh1fUYb+4NAp4aIjTvmJNRMT8Ko6Vyqy2cE6yJHTWF4TgG06D7z2Wg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzCLp-0003qI-WA; Thu, 18 Sep 2025 12:58:58 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzCLo-001vOk-1I;
	Thu, 18 Sep 2025 12:58:56 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0A18D473F21;
	Thu, 18 Sep 2025 10:58:56 +0000 (UTC)
Date: Thu, 18 Sep 2025 12:58:54 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, mani@kernel.org, thomas.kopp@microchip.com, 
	mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
Message-ID: <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
 <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ngvdfwkgcmvnjorf"
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ngvdfwkgcmvnjorf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
MIME-Version: 1.0

On 18.09.2025 05:46:44, Bartosz Golaszewski wrote:
> > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/n=
et/can/spi/mcp251xfd/mcp251xfd-core.c
> > index ea41f04ae1a6..8c253091f498 100644
> > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/device.h>
> > +#include <linux/gpio/driver.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/pm_runtime.h>
> > @@ -1797,6 +1798,178 @@ static int mcp251xfd_register_check_rx_int(stru=
ct mcp251xfd_priv *priv)
> >  	return 0;
> >  }
> >
> > +#ifdef CONFIG_GPIOLIB
>=20
> Any reason why you don't just depend on GPIOLIB in Kconfig? There's no
> reason to make it optional if the device always has the GPIO pins.

I don't mind having the ifdef. But it's up to you.

[...]

> > +static void mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int of=
fset,
> > +			       int value)
>=20
> You must be rebased on pre v6.17 code, this will not compile with current
> mainline.

You mean "post" v6.17? Best rebase to latest net-next/main, which
already contains the new signatures for the GPIO callbacks.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ngvdfwkgcmvnjorf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjL5esACgkQDHRl3/mQ
kZxWLAf9H29wR6UqS6bdRKZ4KlZYkl/42mdy3IWhfZlWgaDGqn3LdFB+d+Qo3N3d
+Nq7YwbrAlnoFmWKeGDyORPEBHK6gswUuVo2MKrkm4zMqMAUa6df5SauSk2t4Vxd
ooKnMVKZGpe5QvAvS44Uafb3CblPAkOs/l5zVaVUV2YmB+TL/GDmLHImdUgpuJte
/PoK5bAuzMY/O5pFgC/bX2PLpZehnqMQcBULmn9vSWroleMiSgiOCWCgd4jyC6HH
QBUN0Pn+KbCK+xoVcsInanEMZNX9Ygzv5BiEeFiSzXO4rahpb3m7Kvf23NkTnVJA
Das1wTaBuKioOE1vXP46xAzFbfaatA==
=U1R1
-----END PGP SIGNATURE-----

--ngvdfwkgcmvnjorf--

