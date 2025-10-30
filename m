Return-Path: <linux-kernel+bounces-878129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085CAC1FD99
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41F7188A27B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51C33A02B;
	Thu, 30 Oct 2025 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+jggJLq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7F33509D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824192; cv=none; b=VHZ3YjlKoYBFcuXG25ik+FBo1xfSHFRG2B7brrKGv2Ifozyfwn9lpz0DFCoqevEfLl5vkwLXuO/FRNocPTNJaDJwt/TPOcX7lET27zT4mFM4kvdWZaJr1bOtd9GqdwOqWiD2rH1yMeQPu/upRIVcxglP2ElhuLxAkXcByDK/mgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824192; c=relaxed/simple;
	bh=kGJsMqY6jwmXVuvCqeHnPicIh5I7M/4ABWD9iqi/WJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1EOUyaIFO53lMjcegCRkOH91h02KV+gNAUwjHIn23a4WWsRYHGYgGoJckfDrIsztiY8H1KkA2HoRcro6eHhoYoI8+EwXB4en2VZ/9X0b8otczw+pjow6QtPfO/e+XIPjxGlmolWNr7MV6LV7MxcUVtKURgLM5FdTDNqIuhTelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+jggJLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F59C4CEF1;
	Thu, 30 Oct 2025 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761824191;
	bh=kGJsMqY6jwmXVuvCqeHnPicIh5I7M/4ABWD9iqi/WJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+jggJLqF96e1cKK1AaFp72YoJQbusuY9xn44ByUptCY9V6z0Q8DrWwLz/y9teK13
	 3RkICPjFEq8X09t4DM7BEIl4RLY3PBwel35ptFESXmP0Q7DzOvstZm8H6day1t2BIH
	 4tu/DElEUxtkdbhf5W08VQ8JWQjP5D3h1d9jZu0lwt4sTvJekY598O2p/tF2uGXm6a
	 269hAss+OWJEjGred2DZ5J4B+S/2XDTLghUJsathJ0zf+aHVDN5q5dDj8R6OahFVLY
	 +PBfppfqz1o9klNImeM+ISOMYnDsXLwEZQmlOqZ+M788bQJzAsYmLwUzN/HvXHzsdC
	 1rwwMpZq/4Xtw==
Date: Thu, 30 Oct 2025 11:36:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v1 0/4] regcache: Split out ->populate()
Message-ID: <c33c5930-ad6e-4ff0-9a6f-4dfd15fcd352@sirena.org.uk>
References: <20251029073131.3004660-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e1bQXAt395XhYLwE"
Content-Disposition: inline
In-Reply-To: <20251029073131.3004660-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Is there life before breakfast?


--e1bQXAt395XhYLwE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2025 at 08:28:57AM +0100, Andy Shevchenko wrote:
> This is a refactoring series to decouple cache initialisation and population.
> On its own it has no functional impact but will be used in the further
> development. Besides that I found this split useful on its own (from the design
> perspective). That's why I decided to send it out as is separately from a bigger
> (and ongoing) work.

This looks fine but needs a rebase onto the latest code.

--e1bQXAt395XhYLwE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkDTboACgkQJNaLcl1U
h9DQcAf/ZT5h318rjzlqarLcSaEPRM1H6WBn5/8EBFMgTaFW1d+YQ0zrg0xmlrLR
1GXljn+uAkBigAxqmBkovvinhZm7zCjOK6B8hsObyENlHIOXaLOuXATXZnjnb3bH
EZALFdCTx13sA7dtyozoFcVrDnApAYxB6dYQy1P3DrpZK1EyWPupehJNUm9WGyYQ
eaPCn5ydKn7ruwIModBum5qoelft0iVdkqhFMJyjhNRIKOc0/X7N8Kca8VAaEMBa
lmC90e60/i0M0uNElDyiNnZvf2BbDt1G13RMopjjbBGb51ru+kyYkxkpbemQCV3M
zBUNzi3JEnWF2xMPu/ayn7KoERBAjw==
=sS5X
-----END PGP SIGNATURE-----

--e1bQXAt395XhYLwE--

