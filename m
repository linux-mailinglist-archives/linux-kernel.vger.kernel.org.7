Return-Path: <linux-kernel+bounces-788174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77043B380B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170013ADD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955DD34DCFE;
	Wed, 27 Aug 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR7qHT1C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD334DCD0;
	Wed, 27 Aug 2025 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293474; cv=none; b=HeaQqa2Q8cs67JzzaGIX8QO43U0qokvGOf8+63LjjG4MSUKCTy3JwwIdbaB9Q176vY7Wct1VOdJuDv15jiQ8cN6+Xt9eTquiCr8FkeH5/r2pYLpac8ywgd/qIwDW30kzGDOPcjJZK5AmaDRWxfKmuJCmTFacpT5No5GwanRonZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293474; c=relaxed/simple;
	bh=TAC9zyUXZCy1eJlLIDtMZklj6c80nPFW3ZW1Tnvf9VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARdYJzsHVOg0D+JExwAVedGJPYfj0RELRH37H9ByBqk21PycnG3jpd6tTHh5ZCe4IJ57Wb1CGrmnwen2+nB0y4jfqwsuofl4B3QdSShUOi5hmXR17zagIiw3aYUGJl2T6znLbPFIUW2PuhG7Sc0oYnTDaR1FxRtfahhJe3X3um4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR7qHT1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD890C113D0;
	Wed, 27 Aug 2025 11:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756293473;
	bh=TAC9zyUXZCy1eJlLIDtMZklj6c80nPFW3ZW1Tnvf9VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rR7qHT1CRpRmLYm4t4r5Kklp1Ekqynm6L2TJu411jVtIbzRyucAaT9qUN3DwZ1iAN
	 dhb8m/IDjfextRXPi3kca6kQxaaN8K6hPIFbWwFQiQurGOpxXBbrwnYERN3zV0hDZT
	 DWZReaiyzqHsx7jX0W8NlVkPsHV18mvjbuQWrOr82J6NYfiGPUkmUAVxuEknN3yRpY
	 zJrYXh9ZYC6b/Utk5fyeqrH4s9KMVJ/TuvWnC6ISvaWgmVLIM9n/bW8KHG3M85lvWI
	 dh/UK4j20Wh04lsezNd01U8lXVA7X9ZQ+KWxjL/vx87b5qQaAtz+9buMk1yymZIOWQ
	 us9KslTVh6UDA==
Date: Wed, 27 Aug 2025 12:17:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, achill@achill.org
Subject: Re: [PATCH 6.6 000/587] 6.6.103-rc1 review
Message-ID: <f2127985-d526-40f3-93f4-bd3ecc2ede67@sirena.org.uk>
References: <20250826110952.942403671@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EjB9jiTyljpRQR4B"
Content-Disposition: inline
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
X-Cookie: Most people prefer certainty to truth.


--EjB9jiTyljpRQR4B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2025 at 01:02:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.103 release.
> There are 587 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--EjB9jiTyljpRQR4B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiu6VoACgkQJNaLcl1U
h9BvMAf+NIHCy3tHVmzEn5Xik3uqdk58g0EbmU8qfCjSAYkUj8q4qKC2bLx+o1Cb
sLbW2i6v8iz1V7vPgFa4Rlh9K9giEX1N2+wHHFsx+egN26F1wzHt5xn3k8cPSAea
veEMjMeyQAiXuHfyBXAxkmDrW+vc2BuEomTNy+JXHktWQswhCkrOsl2SZmMX4Lc8
tlhCo/PiM9h7uRPcx8NCszcAHwwyyKz5VqzW+205K4L3c6oL/bdG79ZnQCLd4qjX
3DMLWwtWx5RXjgd8kQQL9mcAz6ZANswDZh2SxefIen2YnEvX+IFV3NbK88vd/A9R
PQVbTj7CDoqkh6H3TGQKvVkFSPCEqQ==
=sezK
-----END PGP SIGNATURE-----

--EjB9jiTyljpRQR4B--

