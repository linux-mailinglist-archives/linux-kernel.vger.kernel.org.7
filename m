Return-Path: <linux-kernel+bounces-658816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8833DAC07B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 10:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06DB7A9A44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CE123507D;
	Thu, 22 May 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NBzWLp5R"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357222333D
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903834; cv=none; b=jraSK6xu0Z7dHl/ndaND2HvYGjLivAreAY4QrkClsl6Q3w+ovJ58RO/8p8R+lmcipkxHpPnY+9s88D3pCRzs3QCP5cRNsxlActNFXMQbN/JWyYj6rOGjl7fPXbOHAoP+1MIxkQAVmCU92EqfiFaGZOsQqkA+x2P2KSNg7un9N9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903834; c=relaxed/simple;
	bh=EtxZat09Duwzr/erZWJUT3v6HVDaUnav3wiWadh0jXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW5ZUhbwtINj1Zan6F5xRO39FJGsBYT0WmqmoV38K7rnKW4of6LMvlATF7wPoORi7o/qFMW68igMY5FlwR0cn8Q8E+U9eL2uLAWJmks2ubJ4eBlmXOAYttA5nt20yC0oxuYQ6u6gvoPCNuSlJIoRulNlsgCUo4yls2ZF4O1nsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NBzWLp5R; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=fsWp
	FVyDIvdFelNHSyQhjkc8g9/TrCFYMl4nEph/irw=; b=NBzWLp5R6EnuQxbZYJ2c
	xP7uJBdarPhz/WpHeEuSf6ldN1xp3TNNz3pdFJHeU+0b/c3MAmBUKcpe/Y4eusJ6
	e7CiAKf1nFBsGQxjvD9WtrEmvsKZuxY+8+guhLAYskxQ8pX9ZfW9cr4fFRi4RoXp
	PV6NgP2uTHtue9XwN8sLMEarcMoR7kY4aHfsddA52NBKweUvd/KV045dMef+QFhB
	7fLHkCwfX/B7h99WYvXxvULahdQLzMipUZATsEwXQaNiY6/kFi5sAbBPfKg40NAq
	dzNQd4+nnO4toe/jjtgFPPLpCFkmwd2+HtdsEk34q+FHiiEWGMqHpBvHOeJ0IjaO
	Fw==
Received: (qmail 3580289 invoked from network); 22 May 2025 10:50:24 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 May 2025 10:50:24 +0200
X-UD-Smtp-Session: l3s3148p1@UL6MkrU1uOsgAwDPXwj7ADHm2wGe7qss
Date: Thu, 22 May 2025 10:50:24 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v5 7/9] i2c: atr: add flags parameter to i2c_atr_new()
Message-ID: <aC7lUE4kj8fnVVgM@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
References: <20250507121917.2364416-1-demonsingur@gmail.com>
 <20250507121917.2364416-8-demonsingur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GUaFME06mW/cC1Mp"
Content-Disposition: inline
In-Reply-To: <20250507121917.2364416-8-demonsingur@gmail.com>


--GUaFME06mW/cC1Mp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 03:19:13PM +0300, Cosmin Tanislav wrote:
> In preparation for adding multiple flags that change the behavior,
> add a flags parameter to i2c_atr_new() and an i2c_atr_flags enum.
>=20
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

How did you guys get it to build?

  CC      drivers/i2c/i2c-atr.o
In file included from drivers/i2c/i2c-atr.c:12:
=2E/include/linux/i2c-atr.h:25:1: error: empty enum is invalid
   25 | };
      | ^
make[4]: *** [scripts/Makefile.build:203: drivers/i2c/i2c-atr.o] Error 1

I'll squash patches 7+8 to avoid it.


--GUaFME06mW/cC1Mp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmgu5UwACgkQFA3kzBSg
KbZdBQ/9HqvniooWptw/34BzQrDFNQGRllH8iZBxq4TMELMTy3CQ1fy2PedWrek3
IADHl/aUWYODbqdrjv5K+Vci4K5IwV0O9N1C35ibwdMwJQSxzLqf4iM+Wx3S4B3d
64zGmbsE2+eri0QjG9ioy+Awdl3282xwtOIe4/i7luSPgytJrs0vl/XUZ7wtX2pK
vUl73dd8pQ5+Vo2fs70yg64b/Lg05P/fltERi98iWiD6u6pD5mFF0srRtfB/tL36
xh2RNcdSiloyv6hCA8dNb6cpWWSiVcW8BDx95XwtiPdzthTAbhi7zjhpMHppBaXE
vT/2zQtcyLJ7pI0AMEYGN+SuGYY/SFNKbLsGMTRbj4q7sXIGkwD8kYDDqTW8F3of
fOCUD33+JqezEHKi6IzdLqMSNUUHabUFShU6lpo/XDOJuSk9WCzZyGqxlgTMPQne
vPOdnyUb+WibqM9BHZlFZpc7od/Ia4LjTbYqOwRzWv5ZY/rYOwJEgXyiHImt6LwA
hGq5BTs1Nk3eNwHHU5JRyQIZXUZIEHkmK74NVJDvm4yrSXb8pkbF5IMKt8M4KnFB
6a69so8NzWc64zww1MCbYHyeyy29M5hGBbbkbvtnDIojtMySEMaFsHTGuWCfa0/E
Majscltz9XTzHv0SO0NDrCkCHevzPedffqKboih8JjGaLhg90SM=
=6GB0
-----END PGP SIGNATURE-----

--GUaFME06mW/cC1Mp--

