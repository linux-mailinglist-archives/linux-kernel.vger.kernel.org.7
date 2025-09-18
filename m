Return-Path: <linux-kernel+bounces-823575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4398B86E10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161DB582D28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6131C57A;
	Thu, 18 Sep 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1TtGk9a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BA2FBDF8;
	Thu, 18 Sep 2025 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226790; cv=none; b=BOLnAlskEXCB64RuOsWTcTu3goxn+Oedx0WCuCF9au/qzbgDPiWbpcu6YJV/TXzR3ojxpiQT/Lvz2pGpdo2sZNNC6BYKO1yCg5IYQ1XKKbvA0lwRaIoo5/ZPVhKyHZDNUykf9j/zG4caenvc5Br2ADhkTDB2GVA16nW7GVv+/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226790; c=relaxed/simple;
	bh=5v643+f4mhCNNCitIuEUQGOWs/3qK3dOdQaqXP7H++4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8DRhdfvr3/NHAfIBrbN8clf21WoCyk3WwtS9uvQ8zZQvyd0tGGMZsdbukOHcDFXz11gg/HD1HZDVAR0ELYnv2sGw47h+DFjOthAZjJ3U+yyvYrs8U1eeBHU+RZ+PUV4M1WG6PjRqfnrUC2qGgWnjVOUmu3d4XolQhMu60OVKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1TtGk9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BB3C4CEE7;
	Thu, 18 Sep 2025 20:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758226790;
	bh=5v643+f4mhCNNCitIuEUQGOWs/3qK3dOdQaqXP7H++4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1TtGk9acaMHlhl0KnNwMmIZrnQ53Ie/77CghdF9h5mKWNNTrynrlDVej9cl6SlbK
	 rKUGUQrMokaXsmp5tBp5dRYtlunEd1tzcwHZlhwBRdmjvmyGETbHRsJPANiXi9N5Vt
	 5TJgn0hLF/ICqJ4d2uixvrAOp7R4K+nRoFQeISZ5JaCPp9dS9PTpxknVeb8Vjj1Sm4
	 BuNCZTPhVTVLnCQ6sDpE01BlgX8WnBMVmQNPQa3HzRHOGkqIcn62VYnZcS6sWTj8tN
	 Su1qCm7a1pAsKvJrq4wGAy1uwdyNskLZcYn/QvcZ25WDw8M/njUbzjbLNRKbJCzQPC
	 B2SIqSKLAv7xw==
Date: Thu, 18 Sep 2025 21:19:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/4] ASoC: fsl: fsl_qmc_audio: Reduce amount of
 interrupts
Message-ID: <d735d395-d56f-448e-8bfc-4fdc9bcffd9d@sirena.org.uk>
References: <cover.1758209158.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OG03h1ZJQmsi4o6W"
Content-Disposition: inline
In-Reply-To: <cover.1758209158.git.christophe.leroy@csgroup.eu>
X-Cookie: Victory uber allies!


--OG03h1ZJQmsi4o6W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 05:34:07PM +0200, Christophe Leroy wrote:
> This is a RESEND of v3 sent one month ago, see:
> https://lore.kernel.org/all/cover.1754993232.git.christophe.leroy@csgroup.eu/

That's a link to v2 which had substantial review comments and build
issues...  I did actually go searching for v3 and didn't see similar
there though.

--OG03h1ZJQmsi4o6W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjMaV8ACgkQJNaLcl1U
h9CZvgf8CPU7RnocQ9l6sM8liGp/RotKn2IBpogMBPMA+/oJ0/jeIohYua1IvRlB
LYkPh0mbBziixdS5LLfoaIUwuOA1yaXmQp1VNwQWY9ECun37kSxQI64up7mVJV4H
5YMl9DNWJzDAEYBeVbKPIfZ7dykLyMd/d/63kRyz4LBaQE6s7eLArLZBcKdtuitu
4oX7hZm6NoxmftnYwv3vcrtpcR72IulbhSEAWSCBazblbL3iay2O/Y8oyM2B274L
1ndxpotDDaK+ghauhqvnJeSousc0gEmQ7GNa5085nl9zKj0aigIBKZa9zc9/JvLf
6zbu7eCxY4m0Xv4b6uBM7Nz4QDAC+g==
=xY/X
-----END PGP SIGNATURE-----

--OG03h1ZJQmsi4o6W--

