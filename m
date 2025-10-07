Return-Path: <linux-kernel+bounces-844227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E05DBC1576
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05E044E395A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92D2DC764;
	Tue,  7 Oct 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPkIfHNs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBA8BEC;
	Tue,  7 Oct 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839490; cv=none; b=VaLLIFLxTzrL0o3gLILNpFvVbdKmlf4uvixXIjdv7ySt7PpCb0GNQ7Vx+jLDK26/EWNlwJvq9fFSaRYRby7ocgj8+4eGfx9JSnLCIGGBbrxj5Xy/NK3VSEIDs4oCd0G0CgcvtwVx5THcMpETKK2F6fYs6OD1lrSOsZATinDxBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839490; c=relaxed/simple;
	bh=dmsArpgLavHpe67k8GoIdRHh/5TL2Ze9jAn6b2RMQlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LG9xW3z8NOG+peutqN6M4oyk5UHWmLpBcOjP3uqNBov0AlNbk2z9QCHrrUQTVZ3LqqVZB4P9cvpw4jlqWcGxCYfevmRs/9iuw8ZyDEY/mbxvPv8YcYIeYseNbIcMgLMJPIuQme4czXekN496QZNR+JoIUrOn8d8zp6YWiyarTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPkIfHNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF7C4CEF1;
	Tue,  7 Oct 2025 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759839488;
	bh=dmsArpgLavHpe67k8GoIdRHh/5TL2Ze9jAn6b2RMQlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPkIfHNs7vr/4q0BVAG84UCWlf82tGcK10pB/1rX1gxTFSkFeaEvyHNM0tPH9vjZ6
	 TcQvxu7ZnhSqqbobesH2Mhnf2+GXaSB5e7MrWHMOsXPgSS0YF5mu5mVegUR4nqRUuo
	 ogoAeiOUkC5tGWoOkqdV0XEwapBkEPaELrjBNPIBremgoKy+DqG/ca73xUv1szLg5B
	 YN/l8/8gYjW706axcEmG298LI23lXtKRCC9wMBN9ZOkke0gDMja0KPYF791Ra+P9zq
	 rQdp8akaN4xCIZ+huabG6foVnBoMRt+hCCwvK1t9I5Z/yo05yNRsZ6edwKZqsTcqCt
	 tLuvbOq72aguw==
Date: Tue, 7 Oct 2025 13:18:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Sune Brian <briansune@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
Message-ID: <e507ace6-90af-4763-a1e9-08e02f9e63f1@sirena.org.uk>
References: <20251003091304.3686-1-briansune@gmail.com>
 <aOTrsYllMst3oR03@opensource.cirrus.com>
 <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com>
 <aOUDbF/i4+9PXc1j@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zFA+wYNcCkZ3k6cJ"
Content-Disposition: inline
In-Reply-To: <aOUDbF/i4+9PXc1j@opensource.cirrus.com>
X-Cookie: Teachers have class.


--zFA+wYNcCkZ3k6cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2025 at 01:11:24PM +0100, Charles Keepax wrote:

> Its not missing its right there. That said your way is probably
> slightly more standard these days, but we should take care of the
> interaction between the two.

Where we've had users using the manual divider configuration that we
cared about in the past we've suppressed automatic configuration if
manual configuration has ever been done by the machine driver.

--zFA+wYNcCkZ3k6cJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjlBPkACgkQJNaLcl1U
h9DMqQf8CBdjtslsLzLCYzPS3/atB8WAYRlsexPQxVbReO/QFckLrZRPJ+AMYymf
fOCw+PbTgVyvSyA8pXlTLhaA/gIkYnPYWf5sSdx7wXCwNgSnFBCQlBY17rqgWuEV
fDiSUS2uY+SN/5sVxzyGeMITeFSi+7rRvAXGWrvgPHzsGqumgneSDFi7d2XDwQZ3
P8BZ5R/367UvXf5IrLxvr31gNlfhk3fOcE/sX0O1ujzIdSxnB+nTyImUlXitDeDJ
k+gIHJNT0mg9f8AT6rRVW/EQUIh4PLybm97sR3f1GrrxzbVwESIeVeuSWeF7UdRj
0rBOdeU1N38MROq14r4xPvL/3k1ghw==
=NKaS
-----END PGP SIGNATURE-----

--zFA+wYNcCkZ3k6cJ--

