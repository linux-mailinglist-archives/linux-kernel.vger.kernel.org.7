Return-Path: <linux-kernel+bounces-873673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E5C1466E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCC504E0F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C464308F18;
	Tue, 28 Oct 2025 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkPmcgnA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B752494FF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651533; cv=none; b=AfBpdscNhJEk804ReyEKrPPwQD2mRKKxVdLymhWdxVm8IPa9s3JlZMXx6T+kQ/OCGwHSsrXNcpW8VqR9wHHWvNL2TlBP2RuIiHcI/5oIx/enNcg8fHsesb/+hFytYE4oxc08npGhldgT+zRTZzBo/ccFuwZVwVyN5Yv5gWJtKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651533; c=relaxed/simple;
	bh=xTkhIWMi5k2lLbphrt5bYa7YoqJsZ1xIc5C/9Ghk46Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dil+g7LOC9vl0FpNHqkV1tX8XmwxFnfLEktEjm7GQuirmj9Ky9F4x6wt4uMQwYVbxMPfi8d5bhGkuuyJNDBpIUtwlcA6CggPtjYXSZQygnbisgUmg6E5jrIbP0JBTETImIg8vy023W8uY31PjE9tjgS5kIBGB7wp+LAfllSpVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkPmcgnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C80C4CEE7;
	Tue, 28 Oct 2025 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761651533;
	bh=xTkhIWMi5k2lLbphrt5bYa7YoqJsZ1xIc5C/9Ghk46Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkPmcgnARRF+DkGBItb1j6l1X0Mo0SyndTNwckrQAaQ+R37G8p47mE2YesFYyQ1DO
	 jPqGeWn5cPI/WtTRbgPEfEaF7osQBPJyAD1A2J7jYo2f7vmVluCwKPKl9dx5NLNpCL
	 8IrZnDMQC2Lt/wgYLtiKAjXAcxFWkCUM1e+c55jWVv6V9oZgsP7VYOYKUF7GndTZxS
	 KD0QnmhtZWuca0NnzVSIVoML3sCNpIUzKMzNmTKkv8eUlHAUY2RV2t5orq6ejqKY2l
	 mBXMRXTVu8rvkGbpeG+ABXtjltdWkHlBchGV39LRjy4BC1vaIob45Ln7wjAYR2fhbd
	 tp/mic8Jjs7Xg==
Date: Tue, 28 Oct 2025 11:38:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Sander Vanheule <sander@svanheule.net>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v5 1/2] regmap: add flat cache with sparse validity
Message-ID: <86d8d275-2552-49f1-b6b1-3fdb543d70f3@sirena.org.uk>
References: <20251023135032.229511-1-sander@svanheule.net>
 <20251023135032.229511-2-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ic+EjRZ8vBHq9YQ2"
Content-Disposition: inline
In-Reply-To: <20251023135032.229511-2-sander@svanheule.net>
X-Cookie: Another megabytes the dust.


--Ic+EjRZ8vBHq9YQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 23, 2025 at 03:50:31PM +0200, Sander Vanheule wrote:

> -	map->cache = kcalloc(regcache_flat_get_index(map, map->max_register)
> -			     + 1, sizeof(unsigned int), map->alloc_flags);

> +	cache = kmalloc(cache_data_size, map->alloc_flags);

kcalloc() does a zero initialisation so should be replace by kzalloc()
rather than kmalloc(), otherwise we break existing users who rely on the
zero initialisation.

--Ic+EjRZ8vBHq9YQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkAq0gACgkQJNaLcl1U
h9BiAwf/VFkJFY998dU+PxDZHcdbG6S9cqNj1Nq8QJ2iaW2CXma7QAxRYPKf03Hb
3Mzk8PdGwGoZxwYeeSiAtmOAYOm+wFoYlFUwu7bN8uWKVeVd+nafb2xytARPdDig
ZgNUUVL/m9rj8eDg6bxwZPiy8u4nNsL5uEmI5nvSHX0FEwn8ZisSuVWf+EncnM9A
aq36Hz8x8PAJIoQuYRc3wF62oTIz6xRCWOgbHK34vMfuMB4hvgIz2ZPZCakn3olE
ulObL/SwSnqbjadYXO7fOWzQlzMJI7ApqEITEDKdgqDlzv4Lp8jUsQ1Bw5tb8hxa
+zaD0iC2XjyY5ORZJ1MWTOv5CA5dHg==
=/r00
-----END PGP SIGNATURE-----

--Ic+EjRZ8vBHq9YQ2--

