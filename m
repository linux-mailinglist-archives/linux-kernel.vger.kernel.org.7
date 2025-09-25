Return-Path: <linux-kernel+bounces-832669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9523BA00E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26F53A6FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508A2E0B5D;
	Thu, 25 Sep 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdswUq2x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12422E0937
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811518; cv=none; b=QEQOujzVySf+Hx+yhydU9BZzaxZtmj7a/7kI0h60ZfL/xTn0wRo1xtD2u2uNJgPtBfpBsquXhPANtWBm7uoMlNuFfZy+I34S00pUHlKD21YS5yompxKvuIrG6vP83ldCZjfJtoweEhkKBcXm1pUyJxOcpRXNkAYezFIxvLvHG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811518; c=relaxed/simple;
	bh=cfy2xw/Vei74/goO/uwv4Qw3ocrahmR5eKfUGcMSb9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmSA5lO9nUZH8PpIaFkogAIx/7kr+bd1p6diJUf71phnevW4dyhAWUxUJ2rQLahaihjhSmtFebpgsy4KtSBqUevQrRkAXWC4Fe7+zQ6LFwGMLuZq1be5DQ8raZLERsR7PiweVCC7+eyodGq4/0jaNWHQWcZ0eiQTurF+l7/OiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdswUq2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD29C4CEF0;
	Thu, 25 Sep 2025 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758811517;
	bh=cfy2xw/Vei74/goO/uwv4Qw3ocrahmR5eKfUGcMSb9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdswUq2xiJksJORoS0pvC5ZSgkr3sRPAg4ZlY7cFALPhrTqO6HhPM00n6Fcq9gROi
	 mtS61JnwfWrEwStd6/Y8mkrZVVsmc/8dipEHWunWQrRF2NhnJGDNxR8SGY/7L2UOJd
	 /sAaS9dbgHjT7uWjzHPW/UZNPxK27xVxVsflMt95T6mUNPKFLrjs8uOTz3Cvguanw9
	 t3PWM+7ZBTVNq3I89Zrr7/LSoqa0/7IW7OT7yQHKbZ1Lv9rWAj7KwpUWldrSOYar7q
	 gcm76Ex1lZ1WM9+Xoo6PNKihEh7LBzcAxuXGDTxT0rxHp7PKVmS+r/YroVoP9BXvz9
	 u7xOdXjqmkOHQ==
Date: Thu, 25 Sep 2025 15:45:11 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: 'Thomas =?iso-8859-1?Q?Wei=DFschuh'?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-dev@igalia.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tools/nolibc: Add stdbool.h to nolibc includes
Message-ID: <5e85074a-16c0-46da-952f-6218b687e5a2@sirena.org.uk>
References: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk>
 <20250925141423.504427-1-andrealmeid@igalia.com>
 <64c56cf3-90ad-428a-9a14-64928771f9fc@sirena.org.uk>
 <440c9205-187e-45c1-8cc9-8083b64dadfc@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qIsKMXYfRGaILvSd"
Content-Disposition: inline
In-Reply-To: <440c9205-187e-45c1-8cc9-8083b64dadfc@igalia.com>
X-Cookie: Shipping not included.


--qIsKMXYfRGaILvSd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:37:39AM -0300, Andr=E9 Almeida wrote:
> Em 25/09/2025 11:24, Mark Brown escreveu:

> > It's not 100% clear to me that we should add this to the nolibc
> > includes given that nolibc itself does not rely on or offer stdbool -
> > I was going to send something out adjusting kselftest.h to unguard the
> > include there.
>=20
> If we don't include stdbool.h here, it looks like
> tools/include/nolibc/stdbool.h cannot be used by any test, and unguarding
> <stdbool.h> would defeat the purpose of using -nolibc?

Huh, I'd not seen that - generally stdbool.h comes from the compiler
rather than libc so it didn't occur to me that nolibc would provide one.
Looking at the compilers I have installed they all seem to be doing
essentially the same thing (with some C++ handling).

> I'm also not 100% sure as well, lets see if Thomas or Willy can shine a
> light here.

Yeah, if we've got the nolibc one I guess we should use it in which case
your patch is I guess what's expected.  I'll send out my version once my
tests finish just in case.

--qIsKMXYfRGaILvSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVVXYACgkQJNaLcl1U
h9DCcQf/aihlpIMkQ4jsyp9N+sdm7LmUuGIQenC22fK0U0tjvw/4+7thZ2YJGTEL
nYaYicvvD0LsN55kB2SQdFTffV1AgqgXlVKqGHwBTu5Cytb7NMd+p+ICniHA61Zn
VClAehF9i/ehCsZD67EG2Moir8pVbmyGcFJyl0lx/6KOR9jNX2GdD1udqSTdB9qw
8Ac3qo5Hntae4cXtIrftZEQVDRqBInsdy7M59TVLzU+jatcY51wfuo3ZxjRhrNmf
RsHehHm2bU2Sx5165huzDB6c/uvVSBv8Ga4Rk5QSIJq9NPqWHUXZVHtmNJQJbbuS
ccA6MnyOwhg6oVVH60HIw8yeIy6tKA==
=3i0m
-----END PGP SIGNATURE-----

--qIsKMXYfRGaILvSd--

