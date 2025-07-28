Return-Path: <linux-kernel+bounces-748554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15748B14294
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EF3189F6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE1B218585;
	Mon, 28 Jul 2025 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1ddsK0T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AC13AF2;
	Mon, 28 Jul 2025 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731968; cv=none; b=S/u0d6zaBOi90k5JOY/O2BNgI6hfwkjc624wOvFDOHX9COZvCmdDotbXGa5rRrhKVuRXaGpQYwDWjHW2SZNXglcmH0P6kHNeoduXbepDmTMRmPJA6zKBr/XZtTD3H0QrG+yZ6dhTlw/HZdP3uzHUij8aMkBBF6b4wwSmvR6xuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731968; c=relaxed/simple;
	bh=vkFmvW0ralitXVuSrvM0Wv8KMqEcIIlZY0sV1TH3CwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSsoIVPhDHBIw5teAyfZXq7UhPvDBSPmW88JnYyVRIb/J10PRFNpa78HJWLza0znAUdh1JICzZobXSNy5cnG54fu4dluhU399y4D52wIy7FDRpFe/z8kpqbhimkbG0qAsT9i2w0tFPCuhcZ1mEliLlzBlERcEwgMrQpzG4nMXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1ddsK0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0CCC4CEE7;
	Mon, 28 Jul 2025 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753731968;
	bh=vkFmvW0ralitXVuSrvM0Wv8KMqEcIIlZY0sV1TH3CwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1ddsK0TBt+NFGoz/OiNF+Maev8B9OZDT9kPtvcij9T0zCfw7oiMvw3xZiYPQrpRn
	 Wi853MbFXUHTMTuzzYJp0BwrAT/GK7yUGha2yh8Hy0v618DNVDqsIDUG/HjnaZHunF
	 EGdbfEm/AlZW20/jTPzyRK0QpAkzhPV1h/cS6UBJLrys8rW77vG0Yp83Q0B9JIeR4M
	 0jWJGSMyc9+Ox47hl/nYIRMpSKdNlw48k1EcFpl+nHimbciMHk9xW+ms22ygI49Iqp
	 7LZiiTaJMrkI6VBt5en5w5+rakQ10oog9zPw5D3LaE0UODOh3mE75S+QcSYDnsyGcF
	 qeO3xkwNLEb9g==
Date: Mon, 28 Jul 2025 20:46:02 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	William Qiu <william.qiu@starfivetech.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: drop no-sdio
 property from mmc1
Message-ID: <20250728-brought-substance-d7ad9377e4bd@spud>
References: <20250724075600.239522-1-e@freeshell.de>
 <20250724-equal-limb-2922f240961e@spud>
 <43c5908c-c478-4e00-b1e5-955296e4ec24@freeshell.de>
 <20250725-disorder-graceless-23c95454244d@spud>
 <8841923c-cbb6-4cce-97f4-a851783b6102@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4qpDYMW6E/gOYVfF"
Content-Disposition: inline
In-Reply-To: <8841923c-cbb6-4cce-97f4-a851783b6102@freeshell.de>


--4qpDYMW6E/gOYVfF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 08:52:50PM -0700, E Shattow wrote:
>=20
> Hal and/or Minda (from StarFive) any comment about this? I would ask
> William but they are not involved anymore. Can we drop some of these
> suspicious mmc properties, what are the reasons for these?

Additionally, William is mentioned in several maintainers entries, could
you StarFive folks either replace/remove him please?

--4qpDYMW6E/gOYVfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaIfTagAKCRB4tDGHoIJi
0lS1AP4/OL97jNH95DHx8/E0CKPdGzjeTOrojLRX58lketIMZwD9GTGwavZOZA+r
K7Qjbg9nBY5nCMJoRF+P6BRFViEzFwU=
=BWbl
-----END PGP SIGNATURE-----

--4qpDYMW6E/gOYVfF--

