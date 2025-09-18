Return-Path: <linux-kernel+bounces-822639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A86B845EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCA34A32EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F5730499B;
	Thu, 18 Sep 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfJgonj9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E12EF660;
	Thu, 18 Sep 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195245; cv=none; b=USmL6Ue3TKZK4TSGSo+P3BvJ4pry5lZ+0QIZO8U8LKbXTAqRg9AT54WV7V8I9pjzNxEXyk7HV9tsztcIOS9fMoaehYwZRD3gmzWBRkz/QGeyHayqd2rxRy1nYjjsI8HAvnDuBjMlAtkBHKnze3XcS4EnZzY9GhjKjS0kJHjO4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195245; c=relaxed/simple;
	bh=DdjlEKFZ9NzMsLgN2AE+HdIRkMtuy3rMl1mEXsaBBR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjbPln3TrKh/hryTR8Ynk6ZDLd709kC1vA8dOXSTl5bY7UzdY/vvFX4FT8pJq9LZ/0mK2gvTD+r/VmN0RzvTZDkIoxXqboQ0oOHckpY2Te7Ik5f5fAgWewmFxU1tNUT9dumrEMfsHHaADhbmCaGScFiF6zFinWoVvdVOPkDOlZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfJgonj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98794C4CEF7;
	Thu, 18 Sep 2025 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758195244;
	bh=DdjlEKFZ9NzMsLgN2AE+HdIRkMtuy3rMl1mEXsaBBR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfJgonj9G78trjkdbZthUXy3M9CxmQXxteeJxfwCo4sh2OSpKsvib0CTJl0x7DC6A
	 4UvQXTtDqkfp9TV9Ize8+X0zCMyVSXqX7mInHNC3VFcDEtTxyVSF+PQERu4Kx2/qY6
	 gbTPSWKP1V/1P7bSGnEb2cDU4Ajy6t5OUENB/sKH1+mXH8nYH8U8qRrfxFEhJQFFxT
	 wvKq4GPeDFn7586iQzlWlCjLZOKCOX0Jms1SIdx5o6TZi3J9VGQSWG4kKrZfLPlZj0
	 lW9YTNLuXOdKsVVCI+9wZPWQt2iMTcj+ey26lu4GHCv75zxpXMUQGtqtjY5MuqIXaw
	 48W+1JH1OwRmA==
Date: Thu, 18 Sep 2025 12:33:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: pxa: Return -EOPNOTSUPP instead of -EINVAL
Message-ID: <81926717-0884-4df5-aaf2-a938c58ce892@sirena.org.uk>
References: <20250918112102.64314-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ut2fU8JBkxiT4pjD"
Content-Disposition: inline
In-Reply-To: <20250918112102.64314-1-thorsten.blum@linux.dev>
X-Cookie: Victory uber allies!


--ut2fU8JBkxiT4pjD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 01:21:02PM +0200, Thorsten Blum wrote:

> Return -EOPNOTSUPP from mmp_sspa_set_dai_sysclk() instead of -EINVAL for
> unsupported clock ids, and remove the obsolete comment.

Why?

--ut2fU8JBkxiT4pjD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjL7iYACgkQJNaLcl1U
h9AfpAf+PClvXVRNKry9PjFfChYkB5BWOoBVFPmgVT0lUGZ3XggLvtJefzT/qRU2
rBNBg9rpCWQooNz2RhX/Q7HxETpUrJPMmQf+J6pU2343ygF1AGoQEjd6vUEYGQ0r
ckwCMlN9H9eJLgKZiQc9fglni9sz5t02N94BiapFRwUZtZeVa1EE6X5S1umD0FTA
gSaX5+jgfUa0F+ZO9ITpJcJcUdvMtOmWvIbRNicPsD2JulzQ/9d9XVKZxRignyQW
qWNREApxKmepz++1TRstt6atFxVKaow1qcrrp3LkHekGssm7JTj0ELBk67Mf3OAD
htz3PE/X0drg9KCFXC8WBT4oXPn6vA==
=a/MZ
-----END PGP SIGNATURE-----

--ut2fU8JBkxiT4pjD--

