Return-Path: <linux-kernel+bounces-681409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B08AD5251
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 12:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D375B1723CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0C2741BD;
	Wed, 11 Jun 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IS+18loR"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FF271A94
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638612; cv=none; b=pv5WVSIL4NawH93Fj5RoB+G4z1I6Av2TDLlvgjJa7DWL19XY+RGTjG/x4sn2vepRyAKN3nzcDLE0UGKUpozrH4WHhRbszJAUDXIdG1wDhsZJrJ6/nViM9E3dJNu0JDCzdXCIE7DsUbm+AnbFk03OZ2ptR/Z/SggPChd7BagodGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638612; c=relaxed/simple;
	bh=1j0qO7quKJeSdf0fSqWJ03x2PaGixP9SJmUMNFi7onw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBQGgJqzFE3hpRwZeriHwcxD4IQTY1OGeEpYdQ6G0GGEYv6wLSyeOUNrDSNMENf4INhWQYQWngh9Qvh5O3x6Poft57ra7l05bdeoQivwIyIr+SYXcGa6fK/JSSGChzOInSvI1sUiSCaxwZIfDckdhkIZYHgiS3ZGBD4PvXF6HDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IS+18loR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1j0q
	O7quKJeSdf0fSqWJ03x2PaGixP9SJmUMNFi7onw=; b=IS+18loRpi6efVOgYzUL
	eav0kGJ9FjJL/8rjJBYZ2CIkojlt84+AVw44gqL4Fvnj4cOQNtnPOp8R3TaH5o55
	bMMRJ1menaEmgbJiVihQ/cvmiSAUR+fSWT9yGL5ynTFb+y2yEbYGnAfXO7GTpy8M
	DvFgcPrWdQoLUHBE2xw8BFtV3YqiASNcMPlYwdHUYlS/nvd2RXhd9LDb66VInCyX
	gymHRxXNN7Qlh9ICQ0vLEu/qe4kdI4D0ME1OyHMzR6Xgy7vQQx2opLt6zCgpaZB4
	Ui5oxIdycL+YVzH84kc0rmVvoZeHgtVZc+kw1zugNk8IqlEgkEQasiRBDkgpT2hY
	yw==
Received: (qmail 3208064 invoked from network); 11 Jun 2025 12:43:26 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Jun 2025 12:43:26 +0200
X-UD-Smtp-Session: l3s3148p1@p0Kje0k31qkujnuC
Date: Wed, 11 Jun 2025 12:43:26 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/5] pinctrl: rzg2l: use new GPIO line value setter
 callbacks
Message-ID: <aEldzvfidSldYoqv@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250611-gpiochip-set-rv-pinctrl-renesas-v1-0-ad169a794ef0@linaro.org>
 <20250611-gpiochip-set-rv-pinctrl-renesas-v1-2-ad169a794ef0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HtnO6qnMNjE5y1Tu"
Content-Disposition: inline
In-Reply-To: <20250611-gpiochip-set-rv-pinctrl-renesas-v1-2-ad169a794ef0@linaro.org>


--HtnO6qnMNjE5y1Tu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 09:27:53AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--HtnO6qnMNjE5y1Tu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmhJXc4ACgkQFA3kzBSg
KbacSRAAk1i4MILV3aXSYsKQ4rMw2C63czTEpussbOIH6GUO7gndle6xWwmO75Wg
BXh1Apjx3RQQBC8880G9kSWviWlFyvMiTC8/vC3dfQt0mMqm7ANhuH5FKnbB66bI
JIMuKr53iRnRUpufEeun2v9lEo5xTxS6cUTF1DP4q+a96GL+nQrRXlvtk+0XHEfb
sH2CKPaTV0v9yCOZHdI+r8YLB1ZiGZ/HaeZBSPStf9/RRNwORmDYjML38Te0I9R5
R3+SYBhhGSZmxrNLrYmnzMCX5elEMnu8ppSUjGtglueZ/HJ2kr7dxFhRX5PxRu+z
2L/UTskbu2qZPm1Ros+4InTH1lS8Kn59AU9bRo6ueb7Rt7yMoKf+GAqRXBE6yVUH
RVwoiGW+Kc8EfcokWaYuE0o0fcL7GWQ4iCpjOpLy7WPECNfy73gu34dv6ZqmcFTN
9sNzcErfsCRghm7sCxtXWClXtrO42x7+oWjmne38yQPHHEeEzZcyWnU2axCnBjpX
cyNcWfo+NSlFmgADOpuZGUcCmcr/+13aBkJsoqMgH8a61gt10/e6hdFS5EnYYj3O
e05guEvBYWpjOqvsUquADsyqvD05PxpH1YU0YBz1vB92G9GSEInvpbSib8Gu9aTn
G1WgaCCragMLwDg1JGzfD/McaP7IXEU6zzRF2pa+cwfmEfrj+bM=
=tix+
-----END PGP SIGNATURE-----

--HtnO6qnMNjE5y1Tu--

