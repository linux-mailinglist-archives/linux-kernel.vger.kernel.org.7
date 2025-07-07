Return-Path: <linux-kernel+bounces-720073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 790C9AFB6A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78C51AA5D09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC072E172B;
	Mon,  7 Jul 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz8N5h1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55602E173F;
	Mon,  7 Jul 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900404; cv=none; b=Vex4j6SaPHS3OOThwvVQXyts67nDqJrecRXRTi6VU824gjiGi0hs+ecBN5TgbQsSTbh+BaKWwdSjZxl6Cv/D1gLNExQGlPSbGx4cV4wEP+8Zxlay8puD0hCGJ6JsivkiMq7JV0JTo1bJwOAOWQ8Wq6vzy2DOH5f+FG090NBlbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900404; c=relaxed/simple;
	bh=a61wjwCvyCkL+SPb7ydw2gbWfERUML0F7z4wu5a08h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYQAXB4T/ORJn73Ee9ag08ztfqkb04jarOCFM47pKJVmY5e5DOKpfewt1a7bJ14DEPrla8nIzVq+cuHQ5rn3KgPBJ0UKfUwSQIWbn9tJvHLDfCRCf4Mf1TaMqePkY9LiIjOn5lV3CIbIab5joYF7RpWSbCDvdj+2g+fmW2yuQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz8N5h1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01237C4CEE3;
	Mon,  7 Jul 2025 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751900404;
	bh=a61wjwCvyCkL+SPb7ydw2gbWfERUML0F7z4wu5a08h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cz8N5h1q5C1uPWuziWjMULwR9UgtNH6GVg5k3iA9UQtHpflmpVJrId/ktcEdO4wzM
	 m1LS8aug3fgpUlqdBezRs/q4fgEVd71Ftawd952MPsJcomuJOjGi0LiYLu2qi3D1rF
	 NTmcaOGjEfpIzjoJQCiYYebJ5EhVGX1a/Mi2TI38i53RANdjbmQ0EzpLO83Ix60THy
	 CbiH/f4AmQQp0MSP1SC5gl6Rre6q/i+mQh0xHvcgdGw0qcPHhr3tLp8J9xWwecvj3o
	 4HZrDKC9rAWqfKSivCFAE7iY3xA5ZFSi+wwzpqJIhw5iMLPDW1PHExqt34MefOfXaj
	 LZdheZy2s94zA==
Date: Mon, 7 Jul 2025 16:00:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] docs: dt: writing-bindings: Rephrase typical
 fallback (superset) usage
Message-ID: <20250707-camper-postwar-2ea9e6faa8dc@spud>
References: <20250707095019.66792-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7XEWL/prBd02PKZT"
Content-Disposition: inline
In-Reply-To: <20250707095019.66792-4-krzysztof.kozlowski@linaro.org>


--7XEWL/prBd02PKZT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 11:50:20AM +0200, Krzysztof Kozlowski wrote:
> When speaking about compatibles for new devices comparing to "prior
> implementations", usually we expect new device to come with more
> features, thus logically it is a superset, not subset, of "prior
> implementations".
>=20
> Suggested-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--7XEWL/prBd02PKZT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaGvg8AAKCRB4tDGHoIJi
0rvhAQCHZmmyiYP5myd6p3eaRKmEcmTy1wRnBkXhxsLoYSHXMQEAnb5o8Sf/nxlO
QuW+vQ+9SSjnOZZFFdQTFuf4zAfXCAs=
=VaPA
-----END PGP SIGNATURE-----

--7XEWL/prBd02PKZT--

