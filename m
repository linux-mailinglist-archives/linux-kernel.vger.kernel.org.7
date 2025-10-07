Return-Path: <linux-kernel+bounces-844245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2AEBC15E1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C0B3E06C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B9D2DEA6E;
	Tue,  7 Oct 2025 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRdHhZUd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9768255E27;
	Tue,  7 Oct 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840259; cv=none; b=mEzf04l2dBxHVeUTUH3uVPvW2Z5NfH2270gTYgzyiJ9AyXebNLRqI8ReiWFuKuvdQ1AUVA1lFQi+R8+uhmIejSvwWyQmBNqZbwf6/3Zl3BKDWM+O/ZI/r2dMwhM/uyVavIiZU21JaPmni3IbgprcLK3+X3/1vcwL8B79Tc2y2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840259; c=relaxed/simple;
	bh=RbLhlvKA5Ngibkwp7hM9KX5IK2NMt/q3BkT8M5uf7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia2sS66fFWaOGmRVr/CxPBBPCvvBCwttWMlj6I3UGOODcVtvHqEtnYlUi0k0AkYOdA7VeOvvbiXdq3Z47Oydstk+Y7G0wmlXEV5wVwcLaUOtDNxC1RRG5Uz/e+NaQt8fNAwTnXOmYpsIlmPq5Dr80v5zW6z8bSOWs2wkJ7BN5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRdHhZUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BD5C4CEF1;
	Tue,  7 Oct 2025 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759840259;
	bh=RbLhlvKA5Ngibkwp7hM9KX5IK2NMt/q3BkT8M5uf7H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRdHhZUdKpwlgssrdBBdpnoHIpl4W+lDP2f9V/6l3utftT0Zr3tPdbZwjvyg4o+/4
	 fz3RteghVI4Xf018zNu2icR6+0mgfhd9h/g7r/iLtlwhpyrscUENuhYyw0UYRNwCcu
	 BREKQPd7aWds4zxZwLgGu026ceE8uDTlJUCS3W0Wdr3Rb++c/oJooY3g8GcbDc9Z+W
	 yf79Qhiklp2jLlljtDUK3tOa93Iy05ysH1PcvjVT84McwVH2QcvroaJ+uaUHkfEExq
	 fkegq9LOeZcQY6vTQC/AIxCI/Pkcuw87zj4na/kqUmZzvJ6EnysWUHB6NAdd/mt6RV
	 Y4wpVuqOfN5Gw==
Date: Tue, 7 Oct 2025 13:30:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Sune Brian <briansune@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
Message-ID: <a8d1438d-02b7-4e08-ad4c-17467562a753@sirena.org.uk>
References: <20251003091304.3686-1-briansune@gmail.com>
 <aOTrsYllMst3oR03@opensource.cirrus.com>
 <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com>
 <aOUDbF/i4+9PXc1j@opensource.cirrus.com>
 <e507ace6-90af-4763-a1e9-08e02f9e63f1@sirena.org.uk>
 <aOUHDJW5aJzD7Ku7@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YNyh4LC9Ic9WDXSJ"
Content-Disposition: inline
In-Reply-To: <aOUHDJW5aJzD7Ku7@opensource.cirrus.com>
X-Cookie: Teachers have class.


--YNyh4LC9Ic9WDXSJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2025 at 01:26:52PM +0100, Charles Keepax wrote:

> I don't see any current users for the manual divider configuration
> at least in mainline, so we could probably just drop the manual
> stuff. I don't think I have a strong opinion between that
> and blocking the automatic configuration if it was previously
> set manually, but we should do one of them to keep things clear.

Yes, definitely.

--YNyh4LC9Ic9WDXSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjlB/4ACgkQJNaLcl1U
h9Af/Qf+LLyF+jFb/8iXF00memqPJ0+GNu2bGzKG6MOHi97D37OrUomgJnJE5rOz
AEA/AkTQy2TSW4KcrGeY9NXQx5F2r6Y1rbTRj+3VmgePANiFHQa4i3I3Dofg8STQ
3BsMOtl7k32ufWadFZxscOGbDcIYIXzKCjY2GnY8J3+/IM2k1xj0q0ZPSPPxIBYr
H/VwCQd0U1zgbroockFkO9PvuS/SwnftN25/+bebhV31ELo/P7Du87OvHMx1vHE+
zxPPd6INUdPLQfB7O4io6aKf35B24OTz8b5lpABYcvCnQ/W0Y+TQEZLhTpVSQr1o
3LGzN6q2ihLck9FhIinCYVd25mLwAQ==
=Dauy
-----END PGP SIGNATURE-----

--YNyh4LC9Ic9WDXSJ--

