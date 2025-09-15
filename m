Return-Path: <linux-kernel+bounces-817357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F69B5811D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687D3168955
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517E224893;
	Mon, 15 Sep 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="h/jHeUhD"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB3223DEA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950934; cv=none; b=tMO8m83ZfvDv+OOdwFsM7+9Bk9cF11ppKrF2IHjfdRP0kA3mmcgir7LUYN9baZPBAS2mTaEl24owXXnT/qdMrYtBCqFaK9u85uJ93OqBnoDP0XgYi9e55P+PuUyA1Eh/shobxreOXjdb6hVvDX31+eOXJYjnr3tHRmsX8hUJx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950934; c=relaxed/simple;
	bh=wAegJZA1rBGpf9ihPesOvOwpaJOrAeo03gZV1P9O36E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asm+jBQi9e5Y5U3O12MPe5ES6aRhnRG1yIe0oOI8gti5iUbLT/aqfNjR0SkIvEw9aAveJ6MdktK4De1xjKOKjyQPYyh7U22kaS8YgF1h3wekP9n0iUjwFwotmIqfMmvZ6/J1mBVtBzOSZE21ZrniHx7jiHTQqzVYO8MjJkpOpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=h/jHeUhD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=07Pq
	Lrf5GfoTYTiH2oEdxMcPAcHc5zaos+vXta9V2Pk=; b=h/jHeUhDIzeeUQdtVPP2
	2AcNtgxsc8+loG+w5zVQoM6Lg5iJstwGtaQbf+2uCSKX44NyT+bePsNWLR2zGI2f
	kvLckmOG1vL54EsGEktV7eN8Rmz+Yc0nJ0atL94FRRQ4MCMPMa0YtuFMYbCCggs7
	ZtjviAyp2sgy7CNjI43H1zBWfAeZ+WKHoTeNsVZ81sQ/cQuunEJuWFR6eJ4fczTE
	+YaQvZv897MMr3fBrEqR2UIuKndo8zSlBtfWpHDsaKYoEHSGbY8fbXsov9GTL7dl
	8JKso9YgWOKyZSV9cGLvoeO45ezJr/+xwo6VNamop8bZifuqXokcYoqLSxvSEHa3
	lg==
Received: (qmail 2430033 invoked from network); 15 Sep 2025 17:42:07 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Sep 2025 17:42:07 +0200
X-UD-Smtp-Session: l3s3148p1@m9SK2Ng+JJYujnt7
Date: Mon, 15 Sep 2025 17:42:06 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca@lucaceresoli.net>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] i2c: muxes: Add GPIO-detected hotplug I2C
Message-ID: <aMgzzqhXeOi5cn3f@ninjato>
References: <20250915060141.12540-1-clamor95@gmail.com>
 <aMf6DLr8pTCP8tKn@shikoro>
 <CAPVz0n3m9VOV5unVHhU67XQnk4jckA+zyJdCHXu2fFxCSht4JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y7lnKnCf/CROzhIH"
Content-Disposition: inline
In-Reply-To: <CAPVz0n3m9VOV5unVHhU67XQnk4jckA+zyJdCHXu2fFxCSht4JQ@mail.gmail.com>


--y7lnKnCf/CROzhIH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 02:53:23PM +0300, Svyatoslav Ryhel wrote:
> =D0=BF=D0=BD, 15 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 14:35 Wo=
lfram Sang
> <wsa+renesas@sang-engineering.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, Sep 15, 2025 at 09:01:36AM +0300, Svyatoslav Ryhel wrote:
> > > Implement driver for hot-plugged I2C busses, where some devices on
> > > a bus are hot-pluggable and their presence is indicated by GPIO line.
> > > This feature is used by the ASUS Transformers family, by the  Microso=
ft
> > > Surface RT/2 and maybe more.
> > >
> > > ASUS Transformers expose i2c line via proprietary 40 pin plug and wire
> > > that line through optional dock accessory. Devices in the dock are
> > > connected to this i2c line and docks presence is detected by a dedict=
ed
> > > GPIO.
> > >
> > > Micha=C5=82 Miros=C5=82aw (1):
> > >   i2c: muxes: Add GPIO-detected hotplug I2C
> > >
> > > Svyatoslav Ryhel (1):
> > >   dt-bindings: i2c: Document GPIO detected hot-plugged I2C bus
> > >
> > >  .../bindings/i2c/i2c-hotplug-gpio.yaml        |  65 +++++
> > >  drivers/i2c/muxes/Kconfig                     |  11 +
> > >  drivers/i2c/muxes/Makefile                    |   1 +
> > >  drivers/i2c/muxes/i2c-hotplug-gpio.c          | 263 ++++++++++++++++=
++
> > >  4 files changed, 340 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hotplug=
-gpio.yaml
> > >  create mode 100644 drivers/i2c/muxes/i2c-hotplug-gpio.c
> >
> > Adding Herve and Luca to CC because they want to achieve the same with
> > their I2C bus extensions, no?

Sorry, a misunderstanding: the question was for Herve and Luca. I wanted
to ask for a comment from them if this is the same problem (which I
think it is). The question was not meant for you.


--y7lnKnCf/CROzhIH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjIM8oACgkQFA3kzBSg
KbY7VRAAqIqk146NdOyLM5+7CMwn/ggMNteGKa5xt3tt2QsDfL2XTg3BIFB9iVL6
zvhYiOKNyrGS+tukC6rZgWVLBgiSsU7SvJ26z9+R/zBXHc5RiueyMefG3qS1slYf
jPSkJg25qRSQ4oHjOwfGVh0UIyrpV/hBuJCX2GKjz9YtqTvK41gP7TIxA1ZJ1G62
Itzi4wWnwDm3gyNYAYEmfD1XpvGSQrte1/sUN895MsP8mxQ8X+fs1MdggFuZOLFl
dKkk4KPoAL27lU0OHRbczReXoBzElbNcYFMuSGZVl3HXyRaWWrwOf9pNQV5HqAxF
Rha0xXz9JcVmVEavNVoUzGXBP8FfKGIhcIBaTvAHNcDzTnKrfn81TrDvF+uVIkxW
WcKCHjBB72JK6meyBLpnNZkGTXdqqTZMvd3jdtX/Dc+hLiL5WSAD61SBjkR6jb+D
qgO1Im8vuD8+qM6eZm8Cbr0nkW6OMh0/0yrOklJbjsNU5rwvUJsZMMD6wVsjNg1y
MqvwAQ5cxMmzHLok6ZdyYDDrDUb4mqOspRrU0WOurUPOue3WIPVC7yw3d4EkFAIL
x3JfecCVHlHe8uCf1nfnDEjqH31hnsphYjXCozL4y7iJmrKNozEJ6Usm4KQqNAVz
CMOsFPuAov3+C9g8WVZtrZWDJpi/4VJ3n7NgNU80hFhawvc0a8I=
=oovh
-----END PGP SIGNATURE-----

--y7lnKnCf/CROzhIH--

