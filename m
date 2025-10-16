Return-Path: <linux-kernel+bounces-856133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B853BE3309
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5570484710
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28CE31CA47;
	Thu, 16 Oct 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyiIvCCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451AE1DF748
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615594; cv=none; b=DXX6+QKMoOMqr9+euok9Y2rHqtuVfI4Bh/Is0Ql6mtTM/Yttn0XeSfHl3ToLlyGDfOd4vOZlHpgO+nHRg9/mIfy6w8CzhW0D81laIonLLrQxIr+Je4/XQ/bT3MqkIXRbJFdLouZD9+YuBncUNUrjoxtWEzmiQgx5ySUPjPOX5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615594; c=relaxed/simple;
	bh=6iDt6DTf6aiMQbd92+3uBoN59K8Yj4qPHHJmrx3HI0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhmFjjegRxw5wyuQRjaHlB+nVHuTgKBQ9tI/8gsjVgHu1zzJHWSzcpk6p+HBblj+ZG+taG60I/1mAzCYk2McnQnbbt6QBvWmW3AcekQKulc68xo4vhJgoYRQcA6bLCkyvhthPsNdSS8oiHKSodV6MjgDP8mVlqyD/V0RhKEWjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyiIvCCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D485AC4CEF1;
	Thu, 16 Oct 2025 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760615593;
	bh=6iDt6DTf6aiMQbd92+3uBoN59K8Yj4qPHHJmrx3HI0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZyiIvCCL/UCTsEU4cl0GmXJKuOG3DpmrQeFOlpYnOlY6174DltFQtRwHFJQCu+haM
	 Jqu9OGjY2J+l/PKt7BUuxMfz4nG+TVMDzAFJuBJGwNl0Clh1gmKn+6MykE0hntgT0M
	 /FAHkCf05JJqw+tgnPOgvejEysTTuNSUu06v1CHqBzPEX6c7aDSw9wDyhtMYfirnbg
	 AG7RK1GT3Ar+zl0VkGx0sbrZd1cRqYGt61bOkloI6VTlRATtlIFkRy+HgQsgLLR8Cc
	 2uwPN6P98r+rndlXTNWV2UxfKdGUwGWAd/y5CmQPx8iYWlV+l0B039V8knisEBwN/i
	 vkMWyFpDaKvkA==
Date: Thu, 16 Oct 2025 12:53:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regmap: add cache validity to REGCACHE_FLAT
Message-ID: <ca528e3e-39f1-41cc-9f46-ad787af48a77@sirena.org.uk>
References: <20250109180256.6269-1-sander@svanheule.net>
 <a2f7e2c3-f072-40f7-a865-5693b82b636e@sirena.org.uk>
 <0b2fa71f1ccd49d66ca02b6c44ba8fe2135e9b6f.camel@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvmeewfwp6SyJyFI"
Content-Disposition: inline
In-Reply-To: <0b2fa71f1ccd49d66ca02b6c44ba8fe2135e9b6f.camel@svanheule.net>
X-Cookie: Whoever dies with the most toys wins.


--xvmeewfwp6SyJyFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2025 at 10:46:33AM +0200, Sander Vanheule wrote:

> Would you be open to providing a new type of flat cache with sparse
> initalisation (e.g. REGCACHE_FLAT_SPARSE) to provide the behavior provided by
> this patches? Most of the code could be shared with REGCACHE_FLAT.

Taking a step back for a minute, what's the actual problem you're trying
to solve here?  Why use a flat cache rather than a maple tree cache for
your application?

--xvmeewfwp6SyJyFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjw3KUACgkQJNaLcl1U
h9AmyQf6A8z9rklI8RH+5s8ElZY0fy0jlMGzs+Ff6zF2GhY5k+bVzZQGEghN3KGV
JGZcV10LiB+M8TjyldmLU2EXvLK0ec8fPzBYVYlj9epndPPuAPw7jbqZocMCSCWw
EkXUenE6Lrfza8oXvXMOA8UpGfRB7wc4GsSZP3gCZZu3tuVV47jk5YY9iWCquPS2
OSU6p0pcOj30TFHXkiHmc8ydVJryB620IawchlxtXOfUCJbsbw9KCCMkVnJMM95K
JRxHcrB0Kp4/+2wxcGnH74NR/3KzPql4IZkuuSVcOedIBc/r60ZYcFjY/aoyEVig
7Lyw9Uu4e6Fzd4sjA2fJgwAHSODOkA==
=xW2r
-----END PGP SIGNATURE-----

--xvmeewfwp6SyJyFI--

