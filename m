Return-Path: <linux-kernel+bounces-886526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CBDC35D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C053F3AC66D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974131E0FB;
	Wed,  5 Nov 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzSR3kru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F7314A83;
	Wed,  5 Nov 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349247; cv=none; b=sv7ZPRtrr5B4j2Jvg3AE77IaJ9Xk6XmrPZyaF1uIYWngIfpC9g8LQQRHz8KXx2xxaVkCxSVD42qzCluL28k4nQsCpA+J6PDg9QdZsFkxNlZKebYuTuEWuvg03iyn8+3sA0HzjOR4BXNVxh4OwT8FQ52FtuiJrz6O3SO5ufeniwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349247; c=relaxed/simple;
	bh=SEerTwdJP63criKnFsZCVMg0qELu+YO6zkrLEpE2uFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaUJNZ8eyMJkAYHf2qOjMvsF4WaGuo2GZfP8AsCmna8csiOHuLsdNfw3HygvcK/9i+Ongxrc91oaw9Ht1rNCW9mh7mN+RhhOiNLuM7uH1Xqbyis6fSD6IIm/lmBvZhWDr0W9ADI8oem44SsJBAmQGcFkRb7Rm06YHqu/KiC4NUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzSR3kru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9F0C4CEF8;
	Wed,  5 Nov 2025 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762349246;
	bh=SEerTwdJP63criKnFsZCVMg0qELu+YO6zkrLEpE2uFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzSR3krulwQOln2J5vD0V6EGeuPWYi+NlYw3iQpeIeB4GA2ymk2WMHmbkQJcWyNuH
	 G58AgHaQpiclu/dkiR1TmtYuTVxNtZ6f7T6L735V/7+McMF8yb9VtgXKUxREtDHeDI
	 HI0RTN1RCNVONZKjzZHIOBdUrbew1rtEMHDadthLTqfNOzOjJPh8ABTXnVYNm4+/XJ
	 iNAxsCqKH3dYdHtK0za2xF5pJD7dsFZFbpnztNz2sdwxXrXTfcxTXzJ1JPDCsdQo8s
	 bEReqvz0yJTfaWavdLjCWrOZ9drnEevugrmLvUzfoyG8TDKz2YdnVDok2KEZ7FYSq7
	 BlS0MSBeqMVLg==
Date: Wed, 5 Nov 2025 13:27:23 +0000
From: Mark Brown <broonie@kernel.org>
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	srinivas.kandagatla@oss.qualcomm.com, arnd@arndb.de,
	cy_huang@richtek.com, nick.li@foursemi.com, shenghao-ding@ti.com,
	alexey.klimov@linaro.org, niranjan.hy@ti.com, linux@treblig.org,
	zhangyi@everest-semi.com, thorsten.blum@linux.dev,
	kuninori.morimoto.gx@renesas.com, yesanishhere@gmail.com,
	marco.crivellari@suse.com, ebiggers@google.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	yijiangtao@awinic.com
Subject: Re: [PATCH V3 6/7] ASoC: codecs: Rework the aw88261 driver
Message-ID: <aQtQu56kG1Jb47l6@finisterre.sirena.org.uk>
References: <20251028123357.46161-1-wangweidong.a@awinic.com>
 <20251028123357.46161-7-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xyq+H7U65wHTIEh0"
Content-Disposition: inline
In-Reply-To: <20251028123357.46161-7-wangweidong.a@awinic.com>
X-Cookie: He who laughs last didn't get the joke.


--xyq+H7U65wHTIEh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 08:33:56PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
>=20
> Modify the interface for calling the aw88261 driver
> to adapt it for aw-common-device.c and aw-common-firmware.c

This doesn't apply against current code, please check and resend.

--xyq+H7U65wHTIEh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkLULoACgkQJNaLcl1U
h9A2Jwf/TOX9qFA7zSF+mpNxNV3ad2VwR1XVlaqgd8B4DTG5OUM7EKmnoUKnZ+ex
wvv8WNXz81vpl+Zv9VpLElMugs86vgM2a8ywRQPXIAr7Dvmpy18plgV3jBJFXkT+
Pw1LfETBbWL2QGqvizwokmdckH7avbWJkmKOMFh0lFjLf/gUsxwlcmcFvYWylqbF
TnkqbocrI/NthOR4j5zaU5eNeEt/mg8+AKjKcoUjsA1XmcYHiYBJOl/urMaIuLBO
DAezGIsg4Tlz5YFO7+KAtgQDZhQbJAoMPjAI90qipGWKVRUHoVb2tY8zalyR4kU9
Ihd7S3CPWoxMUAvPL84LR+ZPQwuSYQ==
=bRBG
-----END PGP SIGNATURE-----

--xyq+H7U65wHTIEh0--

