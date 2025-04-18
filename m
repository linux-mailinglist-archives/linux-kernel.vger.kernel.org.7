Return-Path: <linux-kernel+bounces-610865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B6A93A29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3066D446482
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F82144D3;
	Fri, 18 Apr 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2b+Sfbz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A572AE66;
	Fri, 18 Apr 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991735; cv=none; b=EvW2nLCxlAV6NC808pVqlCBItyQXFf0SeDJZNyNW+8aKRAOxklB91wzTZm3UGpUCQPQuWakfJjHqA/6kMnXiT3sKcj4DpKR8kRFS29D5ELHSUBPYxPUEs/OSL+bfQPbKzGIFGJdx3/fpaDDftHgIvXr4yJtuvtNv7UDp43JyWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991735; c=relaxed/simple;
	bh=KC8U+EgHKuXEEq/nPLm55QGBSam0ptXIegEJfrfd08U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEmZQFR5wr9ddJ+lMUFXq6fd7drxjVq62Az9zggDOzDu620olEJ1OJwoe6acNjyw6+YLuSB5o95h4N7ap+6wwssmeDfjVFCpt6KbNnADRioVBCMyf5nBKKu2vF2wE/uvL84U90NxsLYiufaHo3NE5W8IpWCioSVXdFAbCDoAZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2b+Sfbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60901C4CEE2;
	Fri, 18 Apr 2025 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744991734;
	bh=KC8U+EgHKuXEEq/nPLm55QGBSam0ptXIegEJfrfd08U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2b+SfbzfUHyxhapE7H0Jp2yvH5s1oL4/7BgHTQ7lJfGhxDejfF4TpQVHYuzY+oIb
	 L7I42SBcF23upQc9XWXsXaIts+Gqxgj4XZUDj9thAYjTok32ee8UEvXuc8wSX8IiPP
	 oYFFDiWBVzpARI7oSTLq0tdsK01LhMkiA9YjT0ctObB5feINEKL5yY3KOXheC/dLvK
	 qiA1CuLX4zbOwjlQbP/NUSM0V56IFX6VTq7EagBGh7d3JTWf6UDtFpWLBO4Q0IGX8E
	 JyEl6r/MdkmWlKOrudLBITuan9QZ5fXosVG1HuO94c4+gt7zdP86HgvjBEaYhWgPzH
	 52zrEOmgM3JTg==
Date: Fri, 18 Apr 2025 16:55:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.14 000/447] 6.14.3-rc2 review
Message-ID: <aAJ188XG4BwiHQcR@finisterre.sirena.org.uk>
References: <20250418110423.925580973@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i4Req4ojKD5TEP2K"
Content-Disposition: inline
In-Reply-To: <20250418110423.925580973@linuxfoundation.org>
X-Cookie: Well begun is half done.


--i4Req4ojKD5TEP2K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 18, 2025 at 01:05:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.3 release.
> There are 447 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--i4Req4ojKD5TEP2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgCdfIACgkQJNaLcl1U
h9Cjwwf/SavWGz1fW5rauh9ndW5ILbK2oBEk5LIAiIPXXRwzCUwBFejV3I6ASpB9
Oym/oViPck2cZruGWmi+7emwmaU7YYIvlQ0deGjeDzW61oh9uDPck+YdGE3CHX6Z
wDX/eD0aSx8vVNEgzOpY8+ys6upq2iC68CCyQSnPCOU55N8Otmwy5FAOEe5qDwuG
iuvO1pXV0D4k7jPLeQqmju3fmjDMTQSJyU5rjiSuepLasijtYTi8/ofi4SbIpNqH
kWJCz9qtEHVHnZLeJvpcVrdlGfH1BA/I9bf5luGvtwqVrSwiVu6rvJTQla3Afipf
Oz5gVxFk3Ensu1TAYIin6xwaiWU+qQ==
=ZLab
-----END PGP SIGNATURE-----

--i4Req4ojKD5TEP2K--

