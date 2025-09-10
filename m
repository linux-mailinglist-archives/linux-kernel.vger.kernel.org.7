Return-Path: <linux-kernel+bounces-810157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D29AB516B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94291C831E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDCF3176EF;
	Wed, 10 Sep 2025 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8ISRPkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1D264638;
	Wed, 10 Sep 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506848; cv=none; b=tYLNvA62vXoZgrauc355MMLkCc1y0MUFQOrRfLf5UICPTbJBpMsim1U56/jwFhSwqQQu5bWy+ulnrSeyOZE+oeJ0NItOcVvypUsxWwsTkQtRSFb8HU1yP9J++c+YoMG+a2m+HDJu9vdYHkysNz/7Kf0E6humgesu/3avE/iUXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506848; c=relaxed/simple;
	bh=9ziSh7+jqZyf3UzqZajs8CYNo1sTpmApE/Ayopvs16o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsBZXBn+1gzRh+kH/UGg3uLLCmN+wS1mVnY8q1HnWVb/kDvRyWY2GUJqNgZkZnVSZZDSIOwSzm3wx5N3wWzY3NXlBNXq87zukoFfpCF2r3GUF8ka117BQamXT8V/MbXia68iCZtl+IJrpBxCRDrj3pcMshsLgRhRKuQpqGpzCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8ISRPkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F05FC4CEF0;
	Wed, 10 Sep 2025 12:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757506847;
	bh=9ziSh7+jqZyf3UzqZajs8CYNo1sTpmApE/Ayopvs16o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8ISRPkm6DSTl3snhoL8y++8BXcZSOq1nbIGJu+WpGPiPuBTWZOcEou6TRZTK0cb0
	 5w9y8+QsLq5fbHFecF+64tInUBFAM+46A5rfaxSWdFHVF6K6PFIpI89BLcSy1qfCcC
	 /Dr37obCYmvSpRkr/GC6/Hu42Tw1rLujmFhOwaPSamrC5SufsJ1S521aJA3tBkS6yP
	 AEErbxprqZFrJ7jKY7Ag23PIwEAIsfRqD29XSRiqhL4di/mZ8nWcbidLW7jF/GEUVH
	 az9sgMXwaJoAGJvb/1ftFjE8GSVFJ2EUdlqBLYM3e5dX+9RN09BNLANGYG8inJjr/8
	 zgIXFAV7948QA==
Date: Wed, 10 Sep 2025 13:20:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Andreas Kemnade <akemnade@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: sy7636a: Add missing gpio pins
 and supply
Message-ID: <9853ad77-555d-4a38-972c-834ff45b9cb7@sirena.org.uk>
References: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
 <20250909-sy7636-rsrc-v2-1-cfd9f44fd259@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="08SCNPHVt+IzhmFS"
Content-Disposition: inline
In-Reply-To: <20250909-sy7636-rsrc-v2-1-cfd9f44fd259@kernel.org>
X-Cookie: I think my career is ruined!


--08SCNPHVt+IzhmFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2025 at 10:33:02PM +0200, Andreas Kemnade wrote:
> To be able to fully describe how the SY7636A is connected to the system,
> add properties for the EN and VCOM_EN pins. To squeeze out every bit
> of unused current, in many devices it is possible to power off the
> complete chip. Add an input regulator to allow that.

Lee, the code for this is in the regulator tree so it probably makes
sense to merge the binding update there too?

--08SCNPHVt+IzhmFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjBbRgACgkQJNaLcl1U
h9DOSwf/T2EB8PZz+auYD+noS9Bw0dg85UYJrG+bYea2qYRMFLDrCUIgvLct2UPp
2ktkLkieGmEy7MFzC3f1YLXHweE2w19JO/kYkacFpW2pz0hjagVHam+Z504lWpyM
wkjicYM58xTdX8RnarCd0f4ICwhQg0690Uz33IFe6iH9/VK+YZA3OCcLbrvzaOVN
4Yah1l+s+R23fLs0EMjVWmxt+zw8XzLQ9OOoSCyYU78tSinLJw7LlYqIG25Vo0eS
9lZB2lktjR+3fpW1gndQM72do0TfOnQLja2F4j4iCDfull8fl+jBGJ+dFzzda/cR
syefzGHG8QR2JW1A3WD9f4i60ZIErg==
=bcPe
-----END PGP SIGNATURE-----

--08SCNPHVt+IzhmFS--

