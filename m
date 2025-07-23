Return-Path: <linux-kernel+bounces-743186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5322B0FBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C693162504
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937B24418D;
	Wed, 23 Jul 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="KkLrpboH"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E62417F9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302928; cv=none; b=luiN5My0X1G6+JenLoviZ+LfOJnIy+SmipaID//zOzesg2VX/eq96hFK2BHyOGvvcJ0ETH2R4LaM0uA3RH7ryXdkz3KvYxrw9h1Dwt67R9gQsXhBGs6A6phJKOLk50qpvGJSL5ANSJ+vKbMjL43GZcHgzQ1X8pIqtwsOaoQquIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302928; c=relaxed/simple;
	bh=rrvMIO2zrmXnt+ojTSfIsLrAA1uxUFjfKOqObAVDKmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLN962iUePEz9TO233uJuIuiRUPmlld2+PgLScZhcrvmLAPi08y+tNsUv5osJHMe7hBoUhDMaWSfJgIWhXAD00oW0FpZa2OSwqeFdclI0sUF6gHEn9AIdKcYCQpggvWSvDVGGKQKSgMTlWo2h+xQi/8cVXp8aEFVH3vk2EUXIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=KkLrpboH; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A9B861C00C8; Wed, 23 Jul 2025 22:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753302916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bqAX/XJvhXJey+CSz0yx8RBFq6gMYRPzhOP76wbvV+8=;
	b=KkLrpboHChJua7fsRTcS6qX2ZoZDd+UCdl6QjTkpY4/1kAWgfzXUTPTKSR4BKwzWyeIuXx
	Rn8zUsEluadkbD60YT9TDjUENSE28Ykk6VDnyv/qpZSL8WtKg4lLUePvoP7ZJTOAE6D7rU
	owQUDghST5K5jimJ2mJaJAbMS+MFcMo=
Date: Wed, 23 Jul 2025 22:35:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Hansen <dave.hansen@intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com
Subject: Re: 6.16-rcX: crashing way too often on thinkpad X220
Message-ID: <aIFHgit57Uc4BDiy@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz>
 <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <c99e3b89-0b46-4803-997c-e6634268bcd8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cAmyQyXIWUruWwfh"
Content-Disposition: inline
In-Reply-To: <c99e3b89-0b46-4803-997c-e6634268bcd8@intel.com>


--cAmyQyXIWUruWwfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> I have had 4th or so crash with 6.16. That's not usual.
> > Two more crashes today. Last one was with 6.16-rc7+.
> >=20
> > Ideas welcome,
>=20
> Still nothing in the logs?
>=20
> The age old idea of getting console and trying to capture an oops always
> applies.
>=20
> I've got an x230 sitting here that I have an ExpressCard serial port
> for. There's also netconsole and xhci debug cables.

I was kind of wornering if I'm only one seeing problems. I've now
built 6.15, and I plan to switch to it on next crash to see if it is
maybe hardware being flakey or what.

Oh, and I got _something_, see the thread. But that did not kill the
machine, so...

I'm currently traveling, and wifi reception is bad (and not really
chance to do heavy debugging).

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--cAmyQyXIWUruWwfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIFHggAKCRAw5/Bqldv6
8vHGAJwKWQkuShnRIv0E+1Co2fcoA6h4LwCePdE+WpqRqadGg3ESBvFtBPT4Zh0=
=HAsn
-----END PGP SIGNATURE-----

--cAmyQyXIWUruWwfh--

