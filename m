Return-Path: <linux-kernel+bounces-832861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974ABA0970
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF79387C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330A53081A9;
	Thu, 25 Sep 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzB8tu75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B21E3074AA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817464; cv=none; b=GAWkQkg2OjgdDc1hYfYBxIhJ9EKcstfEGXusCFeIYERaTg2mrBapRIX7+vmBLVtL73831R7Q+jXEEAXxjnoxIx6Ti+Urt+mej6T0l7K5/p6mhpAPzaVFgFv9IjUFv73HolbkSItLsUjXKJHbYrp0vVf/QN/Ioqazfuw3K6TpPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817464; c=relaxed/simple;
	bh=Gh/8rt9vSh0v3+GZjUuGSf+eed4TP1aLXS33wH/rCJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWm0CspKf8DFf8Y5VqTOVjC5XM2mXTF9lwWvizFzOWzxe+C5NnHVDYYQCcmKzVzbJ48ZBElnm0cJe/equN4rKBpvL1/PGzyYt4uDu2a4aBto2UscSahw2zuToqHK9Znu7yzQubEm9dwxD/FRXbTrN6Mh5UlbYrTPpXx4/JlFwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzB8tu75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02384C4CEF5;
	Thu, 25 Sep 2025 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758817464;
	bh=Gh/8rt9vSh0v3+GZjUuGSf+eed4TP1aLXS33wH/rCJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzB8tu75v9kJi7ykLvvDjB0pa7W42nhJvr/tRvM2Jd0kaQIs+Vr7D6k14mo1QW+B/
	 DS4NCKGUtkPLzN267kyIgP6TkECfynbNNshzBCUKH4OwIKvKxC9FTOklgwwc5A/5Ks
	 XvMwRRib6PAqyCZnOocrveX498muXbHu+42nVSEbDV68Nw+LTFy9ppRuHwo0q/0SL8
	 FSmCR2uCyEp+/cjzfJBBCPh6eldrrWMal1i19JqKFtWb5CaIhqWC5ivfBaeWU4TIuR
	 h2uE4+GjQbhlfD2Z73v9aNfvQ/Fx7mc0zfFG9UePdlXwNu52LTLW1+KdhFrzuErj2b
	 AjH+clKGnHw2Q==
Date: Thu, 25 Sep 2025 17:24:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
	Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-dev@igalia.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tools/nolibc: Add stdbool.h to nolibc includes
Message-ID: <d0f4c018-bc74-4099-82b7-ade42db26c41@sirena.org.uk>
References: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk>
 <20250925141423.504427-1-andrealmeid@igalia.com>
 <7e8b9f3d-3888-491f-95ad-954fcf48dd00@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d8e7eJmLp7y4hFHv"
Content-Disposition: inline
In-Reply-To: <7e8b9f3d-3888-491f-95ad-954fcf48dd00@t-8ch.de>
X-Cookie: Shipping not included.


--d8e7eJmLp7y4hFHv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 06:15:07PM +0200, Thomas Wei=DFschuh wrote:

> As mentioned in the other subthread I'm fine with this.
> How urgent is this fix? Can it wait until my regular PR for -rc1?
> If not, who is going to send it to Linus?

It's pretty urgent, this is a build break for at least the arm64
selftests in -next due to the commit I mentioned with a fixes tag which
is in the tip tree.

--d8e7eJmLp7y4hFHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVbLIACgkQJNaLcl1U
h9AVhAf+IkVOczchsHcIQE95cZoEwZN8JZvBUAD5ob4znshdETGHHfpdZ/f74HGc
H/WvsT3mLAtxo8c85AgbFlvjELbX/Uv61Xd9XG9JfE1zae75ycFkA9pO2FQio8Fq
6pBnp0ugCp82yJ4ct2mI8rBVFxqCF0XwyshC/erCGPmKyvLpepLHlurFO+4vwKng
AyC+Ggq8QPAwAkSB4XHmyOhgGU5Fa+CgU+xisFtRdeU64RXhbH4D7yyfI/5WxzLm
rDYpUbLI5zwd5k6I8Pc4J3/H5We1v7ilescZtO8f27uxkb9GV3NT0KsyZXUxw+eG
UQozyrPG0DIcIZCnS1knB1EzGN5j5g==
=efV+
-----END PGP SIGNATURE-----

--d8e7eJmLp7y4hFHv--

