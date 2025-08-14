Return-Path: <linux-kernel+bounces-769559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294B8B27055
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E603AD9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985C272E42;
	Thu, 14 Aug 2025 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6FBNlZ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F20192D97;
	Thu, 14 Aug 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204415; cv=none; b=dw6zv83PBDErfYMCrF6q6Dpq/ZwldMLAhd86jhCiJz/CnbOaQmJKyLYCNP+L5pQUuDn0FvOhV0CmDwonL2GtoD1OHuBW3+NLDOHgQPS3AmQ++E72ABew5VEtJqhCUbIPFnfmPxCa0hODI4BbwC33M8VUU5P3TMQ1tGacJv42jCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204415; c=relaxed/simple;
	bh=neGWU7vECFARydWtFvZZfMZV4xCQwz1K7pRfXsgrrok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSaMkgLQWigdPKc8WBPfleSBRfXUsSGvrw/OY9dS69E+15YR7O8yf6C4u0wUZs1CdvB4XVV/3hPx2mei0j3UbcX5A8PvnF0LHjBIIiCw5oZS9f0MdAhtERLVma1p1MfUri+mdyzOM6apBGxPlSO5pfULBcDjqPlNMtOQgB7ZQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6FBNlZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ED3C4CEED;
	Thu, 14 Aug 2025 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755204414;
	bh=neGWU7vECFARydWtFvZZfMZV4xCQwz1K7pRfXsgrrok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6FBNlZ81uQctGynrhYmjQLIIqw0Xw+00fZB5IrMaeXhhrSRqBtRle4jgRm+/fV2R
	 0KK7v6WJfox3KHjJdVINsGnXLaxXW7AVpyYEe2LIwsZr/DYIcHChmKS+nBMMTT0ioM
	 L8HAVfNlBjZMsL37ZBMU/GMJ0dd7HUrrqu76LNKcZmocl6SYk4RX2OUuOSkxSJg0yS
	 NuKNrX4A+pQ2oqHv0xysbifcm8zJQYvtD9tTzLZF6RKqe2J2mO5onBsFSnuaZVvc6i
	 GvFYicjNzzignsSI5FdJujy6Ix93ridsjRkwbkUt09QnpTbHtFXNaXHojc5pBd27Rj
	 Fx1GmF/uPxLHw==
Date: Thu, 14 Aug 2025 21:46:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Anshul Dalal <anshuld@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] dt-bindings: arm: ti: Add binding for AM625 SiP
Message-ID: <20250814-cozily-detoxify-2af8ad2f6aa4@spud>
References: <20250814134531.2743874-1-anshuld@ti.com>
 <20250814134531.2743874-3-anshuld@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1u2YrZR9/qfG23tg"
Content-Disposition: inline
In-Reply-To: <20250814134531.2743874-3-anshuld@ti.com>


--1u2YrZR9/qfG23tg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 07:15:28PM +0530, Anshul Dalal wrote:
> The AM6254atl SiP belongs to the K3 Multicore SoC architecture platform,
> providing AM625 SoC with 512MiB of integrated DDR in the package.
>=20
> For further information about the package check:
> https://www.ti.com/lit/ds/symlink/am625sip.pdf
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1u2YrZR9/qfG23tg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJ5LOQAKCRB4tDGHoIJi
0jRTAQDG007EXoqZ3YAvhQMuwDFk0hZscgreLteavw7D5mHFDwEAqG5AXct6syKf
dcR5etysIhVtAL2OcqL4xUXkzpyUrgk=
=LZZv
-----END PGP SIGNATURE-----

--1u2YrZR9/qfG23tg--

