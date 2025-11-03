Return-Path: <linux-kernel+bounces-883283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F50C2CF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577781888432
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5E313E14;
	Mon,  3 Nov 2025 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iRRS8gfs"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607E280A58
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185147; cv=none; b=Ibfn8qLEKTYaOoVt+tuPiSloOIQ9CTeiSZKU3So/6pQ+oBol9TONanSW8hYEDiH3jGzrWRwjsPcSv23ayZO85V4qh+3V3Ik35IVKaUWTy5rnEzaU1kg5E/ryI1+/t6w+fa7qTWyBLn03e8OMcBsEdCfep7zjT/fuZodW8j0Domc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185147; c=relaxed/simple;
	bh=GFGhaUZJyrvrIgmV4wq856CHbNrM+2+0U0at0vp4zoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sw8j+VqiVK2DV0ERTRJ01skeV2AEARLITSdC+k+SCFTDf6Dzm8a2DvyA50VvawuP4BJIcaV4QOAfGWGjs1xuf0G+7iMK7O/AGMliBukQMy5pR09DCgbHoWFLvKIel9nWJ9cL1SN+OFX/4xeoi+I0R940tfzyaJ0o2oj6TfWT7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iRRS8gfs; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GFGh
	aUZJyrvrIgmV4wq856CHbNrM+2+0U0at0vp4zoc=; b=iRRS8gfsuk1zhhQ4TkBI
	Et3wHq360OboKy+GdJzn+6VDv4TYbMZTi/QAJo+LkGi7pJQmKmvMob6aTQGbdXIm
	jfNm/6Of+rD2io2SPpudrk6c79/2o0+EBt04Si1xT3TzPlm7mz4s29Ui4lIDTkYP
	+GACKkVsm+7evliZrMf1D7R7lm9I/peF0HV2wYbn3IKwPutP0ar6atMCKP6OwK3+
	FDgLzzxU+dlKi1iNAS+oszbcFj7FQhN7dpHE/c1aRiTiWSCylwDrK4EAK/Rp1t9b
	u3XnYElp6pGWCzWv7beVB4UCOmmb5hOCINKUDCi2cwM0iV/FQ6RtrIR6Nv/Ong42
	sw==
Received: (qmail 2278200 invoked from network); 3 Nov 2025 16:52:18 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2025 16:52:18 +0100
X-UD-Smtp-Session: l3s3148p1@vbAys7JCb0VtKPNt
Date: Mon, 3 Nov 2025 16:52:18 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] reset: handle RESET_GPIO better to provide the
 fallback
Message-ID: <aQjPstQanpn5zUnf@shikoro>
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
 <e1fd975c-56ef-442b-8617-d63237bf795a@linaro.org>
 <aQjI1m0yYs2t1hYq@shikoro>
 <ee8db6df-76e2-497d-8718-b0ce5affff05@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3TRfjdltoJ8uicu+"
Content-Disposition: inline
In-Reply-To: <ee8db6df-76e2-497d-8718-b0ce5affff05@linaro.org>


--3TRfjdltoJ8uicu+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > What is the benefit of having reset-gpios handling in the reset core
> > optionally and required as a fallback?
>=20
> Stable ABI rules require that, it is not about "benefits". Please send
> email to Linus and ask him: "can I make a change which breaks users of AB=
I".

I don't get it. If a driver already depends on RESET, then only the
handling code is moved from the driver to the reset core. Where is an
ABI breakage there?

> See four reports from Marek Szyprowski.

I am talking about the original i2c-mux patch here. Not the failed
attempt to get it working.


--3TRfjdltoJ8uicu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmkIz7IACgkQFA3kzBSg
KbaltA/9GKzhL3qkZj0RoT5qugCSKlt1K5EDvF7G8xdImLJJJH6xBRPCzS5stVhn
zbmImtbLmk0+1zp4ZZhWd5OFudWDTj1RKSV++wViyaal9fJVFYtTCfO+ILlhfL87
TzN3qVz4+yOXivMSk8yq1aSPHOQjQveBj4HAtv45K0igH02nHeMSIwARVPjd8LLR
Bk9uKZWVgQ4RaHAsVyweSt0Gz83b5AKOQHsO0KPbrR8px/a2uBpag5N+LNfqq33j
HzNGtWlOextJdJV13EwX9a1VcrDgDLdkKsKztKUPQLba56wzHFQikLUGGUmW20Ex
ZB3Yc3q8YFvrrfA08Nki3OmENjOaf/VTPDE79bliEUVilim4E0hqPs2hVhGw/94D
O7GwnpY3DNF9eN5eJfWMKbQmV5s/zqAfRnEqhRlm3kjGm4kMrhHoJ0EQWRv7cELE
DAysB+hLA14dRB146edA24W2pB5p1dYCYk0ZF6vqHoatJ3tcg7pH1EIFghSnppl6
zzQ9AmEq395INpw351uHXVMQaVAgUmV2Ug8KZomtYeTTpAI46scEkskT251VDddb
YfxXvQFEP8sgdpDXi4C6XsftRkQPk4j92ZmRsW9q/MhN7ftmsqh58/CM/QJuEcv4
+BWG+ZUf/R1U3YoJLt/jfifhsIt9XkNJcQbgskQnCGbFJyEhU2I=
=uNyf
-----END PGP SIGNATURE-----

--3TRfjdltoJ8uicu+--

