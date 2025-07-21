Return-Path: <linux-kernel+bounces-739239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C01B0C3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37F9189F9EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0042D23BA;
	Mon, 21 Jul 2025 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyvt4w/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7212868A6;
	Mon, 21 Jul 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099251; cv=none; b=il7HaQsTdjcWFrJJHMMi4Sy7k4Uo3TCs/d0h5ptqrQLzb4LNeXjitJjlIEVqSkvBE5Lid+CcyJea6RCflyEMDxZDy3rpABCKxR6wQxSBuQ9te7YJfw1CM/sktN8RvqzFMHq8SVfaInPGtLIwW/WFdWE/ClMS4I440M9WNp6yIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099251; c=relaxed/simple;
	bh=eZrqXDRoArSD+He7HcN7c1ckjiiP/g2WQgcUTvBuw0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egeZ8srmDaXZSAfPHRSJZNkSBrxkk4xQGLmUBEW0ioe8Dh/kbKGQ0mc/gmlTLSc49JB5iALoTDe1dji8+VebLQV9njafnG3z3gMkrYKBxwA3WOveIyH0DEhTm35GTkhCEprDuncag34Rio/nHgDKbAKHVVIhnHzMd2mg8vfMcck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyvt4w/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B680C4CEED;
	Mon, 21 Jul 2025 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753099251;
	bh=eZrqXDRoArSD+He7HcN7c1ckjiiP/g2WQgcUTvBuw0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyvt4w/Fg25JiliT3I5h4KIo42BbZIMQAdpRXWNj4NiI4uESUka0Bj08XTLctidX2
	 gkavhwuRHacqXptKHjSseGibMhG8WCGi3s4eKesRvlZ28nsAMJIGTolLHZcP4sAmWb
	 AhLsvOJGEYwIrh35p9twCkKEDtbDUf+Eu1NL7yJmcZrq7eQENWLrzNZ3HSH2zMJP2j
	 qcQ1zRA9QDaGy5avtfxXiTh+AZ9JMVAoBh6F3wWzVanWy5wMWoy229/erMjDa3LnZX
	 dl/40Jp7obz9ISFW7htiRWtlFYKCqyV51QndgeXOV6n2YSwB74Ah+nY7XSIl+E3I4d
	 hHYxvmHTeAA6A==
Date: Mon, 21 Jul 2025 13:00:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Joy Zou <joy.zou@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: add PF0900 regulator yaml
Message-ID: <e0777d1d-8e69-495b-8067-9f4896b2b845@sirena.org.uk>
References: <20250721-b4-pf09-v2-v2-0-e2c568548032@nxp.com>
 <20250721-b4-pf09-v2-v2-1-e2c568548032@nxp.com>
 <e9f38e38-7df7-4d19-b5c0-2f18aeebcc78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UHW08PibDF+bPV5c"
Content-Disposition: inline
In-Reply-To: <e9f38e38-7df7-4d19-b5c0-2f18aeebcc78@kernel.org>
X-Cookie: Microwaves frizz your heir.


--UHW08PibDF+bPV5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2025 at 09:28:59AM +0200, Krzysztof Kozlowski wrote:

> > +  nxp,i2c-crc-enable:
> > +    type: boolean
> > +    description: If the PMIC OTP_I2C_CRC_EN is enable, you need to add this property.

> 1. Why you cannot just read registers to check for this?
> 2. You need anyway proper description what is this about and then wrap
> according to Linux coding style.

Looking at the driver code the CRCs are also done on reads as well.

--UHW08PibDF+bPV5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh+K+0ACgkQJNaLcl1U
h9DzBwf/aBg3HMcKbw20S0T9cViDfv3UCOdAdgy5dEcBir0qtCHEDpVkuOkNBya0
8I4T3pt+M1Aepw5L+918G6UJD8jaD/UzKbu5DwOPCbFabF9ijzAVguwaSiELlv/5
1wezdzlz9De1v0BDAzU4dJSEYfYV+YTbDHLOucluwzDkoqqTzxpaMyPWkWwDUJM2
XkcucMB8RfzNakHqnb1VJDJ2lvp95aWnKdFWpLJt3Cluf4eMSq7BLuKiMwrYZ+Km
/L4we5+2vpexsk4kT5ovz2Yb6oDNHGp1H5W6ya6zP9tFgXrynZ1EoP0dENCuoPF2
Jr80quKyqA/NqNbpUWcpIRfQZl9Yqg==
=aCZh
-----END PGP SIGNATURE-----

--UHW08PibDF+bPV5c--

