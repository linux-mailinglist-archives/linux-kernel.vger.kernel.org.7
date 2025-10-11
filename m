Return-Path: <linux-kernel+bounces-849116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB266BCF3CD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 201EF4E5407
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DC625BEE5;
	Sat, 11 Oct 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAkuW5KQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73C1B6D08;
	Sat, 11 Oct 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760179782; cv=none; b=O2VWT5lf+cm1z8t4o+MZmp6Ap+cwudt9Bnkoq+iFpsfnYiQNHRhaWqU34OULSwJDnJvbQsCzrNgeozQoxWD71jW6CKvdmGByw82C8am5TMxeKJFefJs4mHC1ejnO9iWXKPtTXhwdzylPyZ711khjzHplFwGa6TdiZuwh6GbrXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760179782; c=relaxed/simple;
	bh=clj669DSVsUllqw7beU+53IgaJCZ+NwZv3AmURs+91g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfFXpwQGIjP2YCH4tC3PWR7p0WZyqwQGhXPdRy1YeF8xaQljClCmXNfbM/tVHCWY9mv7oNTSkimKQ09PGi6ONr1IAe0YmX/T1n8dtqny/g7+cv4gj109B39wQGIPwMvuWsHby9u8d+URU4c1qbnMyFcUnsvvl9zwzu43DSGIeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAkuW5KQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A58DC4CEF4;
	Sat, 11 Oct 2025 10:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760179782;
	bh=clj669DSVsUllqw7beU+53IgaJCZ+NwZv3AmURs+91g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAkuW5KQn5PVho5sQ+Stf6kmErrTwDuUz+8VXGnmzI3/HuKtXVCjB77QlsirW40hO
	 F7i+5CfVQtHfmfbtYLk62QaVfCsopzu1y70pjPfDsbzB9vPYkg9I6fWUoseAFe9Hen
	 1J3XfRxn36mA5jgf3qT+sjp028QuwwJxHUxg90C9OkfXNZcCzQrtZhaYB9P/AuC+uq
	 3HUB0MjPC9couGaxGBxvnlG6FkDcHV7aZmhgN1lLEUa6ndEUkqabL/i+mC2AzrXxbt
	 rJVPuF5tH/iKcB8smoL6H2N65+N4OLMHWLvXvNfDMZPjfjjWx63Nwr1uPYZKHLOQRx
	 HBal38WQJMXdQ==
Date: Sat, 11 Oct 2025 11:49:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org
Subject: Re: [PATCH 6.17 00/26] 6.17.2-rc1 review
Message-ID: <aOo2Q8SMCbnTAU9Y@finisterre.sirena.org.uk>
References: <20251010131331.204964167@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qONbR8myCT8qVBol"
Content-Disposition: inline
In-Reply-To: <20251010131331.204964167@linuxfoundation.org>
X-Cookie: If in doubt, mumble.


--qONbR8myCT8qVBol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 10, 2025 at 03:15:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.2 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--qONbR8myCT8qVBol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjqNj8ACgkQJNaLcl1U
h9DxkAf/Qho7qUSATETHDZFad6rCcvfV7cD5zFTjxMOFPC/nPzYyPN9xZ+vy7m1n
he2gvXDnPiAejRrXqO+W7INeorUwG6gC4YEb8VjzW6RQW59XwyZsb8pP/Kpn+lsz
2aG7T6bVQS20aKJ/HJ3bhSeDkCDoJ9GFTCDq+xPu2tKJL7ETh1MbcU24yGJc+fjl
84mnYTgxZWOj9O/Ho0i3jDMQuZwYKkpnTWtUpWFRxTRPT5IVbMXscHdK5/W54TRm
2psC9IIWmcLFeyRsan/dtlXKhwEdrn0rtyQKm6h3jYWcfqdFbsDLSSY3NohiWMnL
09m8w6pSiT1o1AwwkkTMGx3nP4wnjQ==
=xHxa
-----END PGP SIGNATURE-----

--qONbR8myCT8qVBol--

