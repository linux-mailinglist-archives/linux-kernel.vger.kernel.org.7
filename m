Return-Path: <linux-kernel+bounces-735411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E87EB08EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B28C3B5075
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E528935C;
	Thu, 17 Jul 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUot/v+V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94272E3700
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761842; cv=none; b=WGHTcPehIMw7e2O41MgCMRfpGb/3PoUwJXxJdkuMKyYhoYNvdn/N9Sb3/drLxPaWa4DalyjzAmeiJCDwYqlaHOk7HnK4Y/W8DIF5wgHD8hK1YMnhpa44bUKxxp7dSKxdwTx3ZbvAbFGzPvCQSpSY/k7LO59IeutIzUFITPDLRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761842; c=relaxed/simple;
	bh=mH2iTpxCutY0oZ0EnpWIisDDqoklwHEeg7z+DOiUJho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPJDM8cppEknKJWgNuHZ5BYeHwC4vkq5b8G4V/2wpKO9SrqtaiFyDHAnawwCGbJMnI26vxBr0a4DO8+ImK6jwV0pIhJSPpIxPOPLoEhk1x7gTeLwPU45QeZogBX1M2hCPSEan6ttTuZA7lKDOcffUgEPZYsjJ0IB0KazgjRb7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUot/v+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D52C4CEE3;
	Thu, 17 Jul 2025 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752761842;
	bh=mH2iTpxCutY0oZ0EnpWIisDDqoklwHEeg7z+DOiUJho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUot/v+VLwBjfwK3e8KYMzG/CKPmgj6wfM9wHDB3hzUg+ST4pe3mF7Obg8uFnnmTt
	 yOKkKWxHbr3GyMhQZ2qZs5MAmRJusft7aiTILpRJVr9U3xAE6MfGPfIUm0tE4gfR5T
	 OXaUp3Vxc01BhcONo8F989dshm8Azp7aMEfPaLYoPOzZjP9dQ0WYF3AbLdNn237oHA
	 HE+skrP5RdlGEhod1pWjiSROdwzCZK1nBAgbPmlbQ40IiknqmZDRBOX0f82Ajvuf/J
	 u5ND1cTwr8F8zuNPfYJnlkEJK0RRQQGCPzPfFpumSsOo4AwMHHqwW0mWkvHTLwZIfW
	 mwmu1LZJCSbpw==
Date: Thu, 17 Jul 2025 15:17:16 +0100
From: Mark Brown <broonie@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	sj@kernel.org, ziy@nvidia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, brauner@kernel.org,
	gkwang@linx-info.com, jannh@google.com, Liam.Howlett@oracle.com,
	ludovico.zy.wu@gmail.com, p1ucky0923@gmail.com,
	richard.weiyang@gmail.com, ryncsn@gmail.com, shuah@kernel.org,
	vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH 2/2] selftests/mm: guard-regions: Use SKIP() instead of
 ksft_exit_skip()
Message-ID: <24a99f0e-d7c2-4334-ad81-283eebe56ddd@sirena.org.uk>
References: <20250717131857.59909-1-lianux.mm@gmail.com>
 <20250717131857.59909-3-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ifwHIWdj3X+LAYX6"
Content-Disposition: inline
In-Reply-To: <20250717131857.59909-3-lianux.mm@gmail.com>
X-Cookie: May I ask a question?


--ifwHIWdj3X+LAYX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2025 at 09:18:57PM +0800, wang lian wrote:
> To ensure only the current test is skipped on permission failure, instead
> of terminating the entire test binary.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ifwHIWdj3X+LAYX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh5BesACgkQJNaLcl1U
h9ALmQf+I0dcGV8gn4rXy6ehB4X3hij4HI9Qw5PwhrxkqZGMd9Wq8iIRLE2Emde0
GlfNkPQCt91dRgbaAmOdnKGkTdkv2ievueI3obtm611/O+YvXDPrr5VGK76Fhr+i
m2n0L5mWGEZO0uoyto30ZAKbGIbA1b/dZgMDdPTbIbjpy2fhI9Emdzg/s5JICSTG
Ugl5MB3LgEy+eOoOnZAJrQXiVSZ22/B0T8eam/roRzzW8T7LWkwJVTovrU9vY/VG
LA2BPe4q9m5gWBQsuiO6DOi3wBWmX4INRcGmYZKA2+tkxecpo6iw2mHQDlPN3VAx
UsmTBvD1MHnWAiBTYDptdlVrqxohEg==
=8JWd
-----END PGP SIGNATURE-----

--ifwHIWdj3X+LAYX6--

