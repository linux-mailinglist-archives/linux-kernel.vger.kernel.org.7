Return-Path: <linux-kernel+bounces-866978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B232C013EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5597B1A049B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F52882AF;
	Thu, 23 Oct 2025 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmNJAumI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763632F85B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224429; cv=none; b=APNL4p9cuANZnhMhdXMUc2DV7L2Ii3yQ0OsP4FfLU14nrR0k0O0hgg9Ymkq5eCk4lROZ3QS+JwdLOZ2d7f/9V2dJEosHhayn+ZRYf3ujaTvqyYwPRyIMCQuBicvzSpNZGa+J+9obbGWJAIaFqDXb23G3eb7RGY9eE8ASdY+fH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224429; c=relaxed/simple;
	bh=/+sAP/NU9A7H3RzzOB6c0hobI+4KTVYjbIk+ZDRU3JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR5fuSBDwlIWrnc55ZwgmGqMIZuEG0mLZcRdlcGd+Ful978vg7aNuvpqqlY3XYEfQRrhvyAHUcb6q5sbg44a9MYpYC92V3IUSwqwwIlZbstBwlgdoggA6IV49KiW64b8UQ0HBfhwHHtLUn+3i5gu5VQHJeO5O1emHpqFT+9yNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmNJAumI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82288C4CEE7;
	Thu, 23 Oct 2025 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761224429;
	bh=/+sAP/NU9A7H3RzzOB6c0hobI+4KTVYjbIk+ZDRU3JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmNJAumIJauxxiCQKnmdvoRgOhKd7fRmQ+UihXMxgcunvlHiTCy8R8PPn6DzPkyWJ
	 aCYXlPBe9nZ0c8ifx6CFlWroix4pIq9oNDJrsapXTBPl2hiHQs7pgRQ5dzXaiR0feh
	 OiEL+hjpv3OH8EyUQIgBC8zINbmN2Nun7vgTr+wcWmLSRpZGb/OL6nxT29yqCQFCWC
	 XNrTU0q1JhuqDk7KDUTy0IrQqd6kdJnZxKTQjCXvg0dCz5fTSSSgWv0LnWfl2Ju18q
	 7tQfLeBm0ki8rDhHzN9Lyv9HGEcP1c2tNHmAoP1ku7bPf5DF87j755OQVGymJrJSAA
	 FVF38nm1A/BiQ==
Date: Thu, 23 Oct 2025 14:00:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v4 2/2] regmap: warn users about uninitialized flat cache
Message-ID: <9b5eaedd-f068-4209-af4a-215716e279a7@sirena.org.uk>
References: <20251022200408.63027-1-sander@svanheule.net>
 <20251022200408.63027-3-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e5rYhY5TLCW7Cy+2"
Content-Disposition: inline
In-Reply-To: <20251022200408.63027-3-sander@svanheule.net>
X-Cookie: I've got a bad feeling about this.


--e5rYhY5TLCW7Cy+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2025 at 10:04:08PM +0200, Sander Vanheule wrote:

> +	if (unlikely(!__test_and_set_bit(index, cache->valid)))
> +		dev_warn(map->dev,
> +			 "using zero-initialized flat cache, "
> +			 "this may cause unexpected behavior");

Please update this to have the error message on one line, it's better to
break the line length limit and have people easily able to grep for the
log message.

--e5rYhY5TLCW7Cy+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj6JucACgkQJNaLcl1U
h9BQZgf/YLg1aU9u7kYge+bpRRTRt3kgcouiSZxopQ5kKrqliRzD/37Bd2mIJaGT
JVDpSss+O23B2LZpUD7mVEaZZlbeBHzKeQNRLo1B/RnZfX7W2cbL/n9NlM9Xu2cR
EKgQ13OXQvCZ6bW1Cu9V8NbzRQeGu//wzTPKjtaxKeijAc8lnPidMgOxzceFg0a8
7qDVcpG4kK5T6DD4mnbLDTXmb2mQV30zqQmyMFGsaEjlgUcPh41mrNKDpuAOGr8Z
jYt/91YVpfxJe001HyC3j6vXvYJwWeXIcnrZbFT4e6gZl4XxgzTi+f00WRCWD1tw
cn1XmTJDseU4IndcAdd8w4TrK1W7+Q==
=obUe
-----END PGP SIGNATURE-----

--e5rYhY5TLCW7Cy+2--

