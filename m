Return-Path: <linux-kernel+bounces-794599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9321B3E3BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DB7171464
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505003314CC;
	Mon,  1 Sep 2025 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpDNO4k7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BC32C336;
	Mon,  1 Sep 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731195; cv=none; b=alpDWpk/0CH8Ctj5Ky9We2/Ygg3/VYNekaEhQQE0oM98bs3CHH9+2cLWQViCcwSA7Ta0snYfJahRA3kaMpR7H8sV3h2Y1hojdTs+GDq2HXT9VUlMcML7DIOCynSFBNzyQFEzLYRj83iqcP2ckxVG6Mpdl43R/WoxJFxIuw7yTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731195; c=relaxed/simple;
	bh=Y0Tx+amHtPH2WjZWA3oqwdIBstwnb99fhTPjWGHbmMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs35B/12/ibI+Vv0b8aId47l8pn5ZlixkJpbTcqptRgvfuR+6tRcePGKT8aTDbllmuS9u26dSDe+k7yNmaC4GPaTcrwqcl/eos0PNgYy1WKvxo2FKrhiG7eWWXRxmZeUoguUo/opWTN7/opZiSG1W2w9zH0E4mZhJoKDykUijvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpDNO4k7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20466C4CEF4;
	Mon,  1 Sep 2025 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756731195;
	bh=Y0Tx+amHtPH2WjZWA3oqwdIBstwnb99fhTPjWGHbmMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpDNO4k7wfGNL6CBrLLd6AK1u4rCmrLqFZc1GNLw4qqNz3RfytWmrVqYdTXZlfPD3
	 A7ziTjYC80V6/9FR9GxPX8ilunB5gmnJi7kvnY/Eirep0RE/LDYWdR2GH9C01tItmu
	 g1zdk87Upw1UfADbhyaQgyK3KrJynSpN0W98ZV5bixjYTGAzM2D3GAXE9sL3WJAQb4
	 a6j7dSsuqHig2XqTppW82zSO+GgQwQHRfaiSIK7TY7B/rzhs9rEPKrY8q4YXUxzjeV
	 5VMn55iYOrd9maPnAEelkMrAbhaxjis+9kmgN/CZtL201/wu5JERBSaVOv4d8rqi91
	 o1vo0rk5SR+FA==
Date: Mon, 1 Sep 2025 14:53:13 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add entry for Sitronix ST7920 driver
Message-ID: <20250901-industrious-rooster-from-mars-85e3cc@houat>
References: <20250806-st7920-v1-0-64ab5a34f9a0@gmail.com>
 <20250806-st7920-v1-3-64ab5a34f9a0@gmail.com>
 <24a5ac33-945b-4861-ac0b-94eaa647e893@kernel.org>
 <CABdCQ=Mysc3a5JNe7te0nRAOzB2n9vQcEz+hZmE3B3vmDYNt2A@mail.gmail.com>
 <083588db-10a5-48ff-80da-55c5b79e843b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="4gs3gotqim3qagfw"
Content-Disposition: inline
In-Reply-To: <083588db-10a5-48ff-80da-55c5b79e843b@kernel.org>


--4gs3gotqim3qagfw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] MAINTAINERS: Add entry for Sitronix ST7920 driver
MIME-Version: 1.0

On Wed, Aug 20, 2025 at 03:10:16PM +0200, Krzysztof Kozlowski wrote:
> On 20/08/2025 14:23, Iker Pedrosa wrote:
> >>>
> >>> +DRM DRIVER FOR SITRONIX ST7920 LCD DISPLAYS
> >>> +M:   Iker Pedrosa <ikerpedrosam@gmail.com>
> >>> +S:   Maintained
> >>> +T:   git https://gitlab.freedesktop.org/drm/misc/kernel.git
> >>
> >>
> >> Drop, unless you have commit rights there. Parent entry already covers
> >> this, doesn't it?
> >>
> >=20
> > I don't have them, but I'm working with Javier and I think he does have
> > permissions. Let me ask him when he gets back.
>=20
> Javier is not mentioned here. You are adding redundant and useless
> information. T: is for subsystem maintainers, not for individual drivers.

Kinda. I mean, you're absolutely right for pretty that it's implicit in
most places in the kernel.

However, it's not here. The drm-misc tree is meant to collect the
patches for all those small drivers, and we don't have a folder to put
these drivers under.

It was pretty confusing to differentiate a driver maintained through its
own tree, and one maintained through drm-misc, so at least explicitly
having the git tree set to drm-misc is how we show that's where the
patches are going to land.

Maxime

--4gs3gotqim3qagfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLWXOAAKCRAnX84Zoj2+
dqXXAYDnY4grqHpYddnisKY0oTfOh4lsJVxKw0d9i5lR+t42rLc8G+t3FPuDwTnu
m1krkWIBf3igFXowkxErMW6p1PT59x/YwatAScUQ3Zv6r8Ylb7edi4nYUnpZsu5+
ZTAAt/ddpQ==
=cCRY
-----END PGP SIGNATURE-----

--4gs3gotqim3qagfw--

