Return-Path: <linux-kernel+bounces-682377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9116AD5F48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 21:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABDD1BC243D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E01DFF7;
	Wed, 11 Jun 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="NFWAcz8N"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E404235355
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671262; cv=none; b=exF9ilPz/4mtudDqCCHXHbG2pNi+FuoAL5kmbsKWSsjIceU+BJRwq49pPvjimo6wjlQNJc5qnUf4avDBl3rt3X88TdwmsBhQcFWXCgEKI1k3XJnHoIaZqLpmE4eHuR1R+iHcHNijJWqN/WHSr3XrZV3aOgrlHJ8SEzkyYyHHpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671262; c=relaxed/simple;
	bh=Y/m/IgEWTAA9kttf6amVM6YhOy/r6U5vq99jtoMZeeA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nxm/1GWTnPtSP3eVSJ5Oz5pmu6oD2VetUddtzktgVZYXGN7qCQasY1R9ob7XVSOGdbqt3LF+/kzwvj2c9pwtbE+cLWHCcxKxo4oHzwQDUYNU3GGJ/Es3RKb1a3+MxFnr4ZEtUTyuO0WHMuote5uQnJ4qAoTZ4DOdjQW5UPg7X3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=NFWAcz8N; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1749671258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTC3oSbB+ScZdZaL0SzBekBJT8/ZI/K943eS/mhMDVg=;
	b=NFWAcz8N+hnT/MVD8wepFBlBanLkeYc1XzOvVNboKpikwOvp2jSNtb3+SD72EL9ud8kPrx
	OAEaL1Z1HeG94aLL9nvba/i2QDfr5I/tqbGtkJBKPuK7Eo+2kNoJ/So0Z+btxfRmqHEBTX
	JcsR5iSEaXyb9nOKNlESRW5/rNeswcnCsymF8Euz4SejPhGd6lQS/NvF2b12oyck5xF8c6
	YFOQ7WdsM+/B7pVdjxn65QEu/CihD+5OHimwbTz0tkZbB0sHRBAvy2DvSvCGgmdrX57D02
	RS0JIuoKYdhtj0Ri/fD2oyaiphjJuux4HCXjfSeJI674y9/9pozMCgfJ+Tnh6Q==
Content-Type: multipart/signed;
 boundary=36522f84442309e0e08e0989a11672ccff56feee362f4f60085dd1946f6e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 11 Jun 2025 21:47:27 +0200
Message-Id: <DAJYOYMK9UJD.LB0N2L64FFA@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: <linux-crypto@vger.kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>, "Ingo
 Franzki" <ifranzki@linux.ibm.com>
Subject: Re: [PATCH] crypto: testmgr - reinstate kconfig support for fast
 tests only
References: <20250611175525.42516-1-ebiggers@kernel.org>
 <DAJXJHLY2ITB.3IBN23DX0RO4Z@cknow.org>
 <20250611190458.GA4097002@google.com>
In-Reply-To: <20250611190458.GA4097002@google.com>
X-Migadu-Flow: FLOW_OUT

--36522f84442309e0e08e0989a11672ccff56feee362f4f60085dd1946f6e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Jun 11, 2025 at 9:04 PM CEST, Eric Biggers wrote:
> On Wed, Jun 11, 2025 at 08:53:17PM +0200, Diederik de Haas wrote:
>> I was about to respond to your reply, but I guess this may be a better
>> fit for it. The TL;DR: version is this:
>>=20
>> If you think distros shouldn't enable it, as you initially clearly
>> described and it seems to me you still think so, the right thing for
>> distros to do, is to disable those test. Which in turn means the fast
>> tests should not be reinstated (?).
>
> I mean, not enabling the tests in production is how it should be.
>
> But Fedora already enabled CRYPTO_SELFTESTS, apparently because of FIPS
> (https://gitlab.com/cki-project/kernel-ark/-/merge_requests/3886).

That is recent and there's at least 1 person I recognize as having
proper expertise in this matter ;-)

> You're right there doesn't seem to be an up-to-date bug for Debian
> (https://bugs.debian.org/599441 is old), so maybe my conclusion is premat=
ure.
>
> However, besides FIPS I think the problem is that the crypto/ philosophy =
is to

Another problem (IMO) is that a lot (?) of people (like myself) don't
(really) understand crypto and therefor rely on the description in the
Kconfig help text and make a choice based on that.
That's (one of) the reason(s) I was so happy with the clear text :-)

> throw untested and broken hardware drivers over the wall at users.  As lo=
ng as

Only speaking for myself, my *assumption* is that crypto functionality
in hardware is/should be faster and would lessen the load on the CPU
(which with several SBCs seems really worthwhile).
But I don't have the knowledge to determine whether it's broken or not.
Unless there's a(n easy) tool for that (like 'rngtest' [1]).

[1] https://lore.kernel.org/linux-rockchip/6425788.NZdkxuyfQg@bagend/
resulting in f.e.
5afdb98dcc55 ("arm64: dts: rockchip: Describe why is HWRNG disabled in RK35=
6x base dtsi")

> that's the case, the self-tests do actually have some value in protecting=
 users
> from those drivers, even though that's not how it should be.

Thanks for the additional info :-)

Diederik

--36522f84442309e0e08e0989a11672ccff56feee362f4f60085dd1946f6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaEndUgAKCRDXblvOeH7b
bhZvAQC8GDINu2UaLYccIQbsE1Ic63aekMhkgY/fKKna630QlwEAgo9a8jeX7bzO
KdBEBwoXU49l2PRqVKGXMcLAYk0uggU=
=2fnQ
-----END PGP SIGNATURE-----

--36522f84442309e0e08e0989a11672ccff56feee362f4f60085dd1946f6e--

