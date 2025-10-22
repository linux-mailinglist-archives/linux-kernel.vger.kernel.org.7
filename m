Return-Path: <linux-kernel+bounces-865779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69637BFDFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CC13A7FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B691734FF4C;
	Wed, 22 Oct 2025 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUZieSO0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07E3491CE;
	Wed, 22 Oct 2025 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160490; cv=none; b=REhZnn9MWcBGSuDowATZeEfGnU9/wUF4eNK9NXXlGYANJExn+0nKk/Mr/vhF2Odfeo3vNRZ8xAH+dOH/F+6zvD9Rg7UkmEaXxvKxi9PVMROa5HbnECtIxQpYloyhY6fWuyktfCiwC7DOdMTRu9qdb/vN3ZWJpDslV/dub1nnZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160490; c=relaxed/simple;
	bh=hURW5DcSkdr2tfeJqYEYZTWHctPkRCz4Sn3A1K9EHEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q65uT+fMsPUuZsqiwugf/VdrAlYEP36G2d6w4xzcEYi2HfpX2wXY7ZcICYirV0tLq1eJcvBd6TQkN5J1D1eLefDaA4rQH8rjFAxwxmua1wcq0Kqzg6n+srJNS8wCTN6GyacGOK714Xt2x3HcoI9DlLT1BH52R0d/WVnyvbg44Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUZieSO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A741C4CEFD;
	Wed, 22 Oct 2025 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160489;
	bh=hURW5DcSkdr2tfeJqYEYZTWHctPkRCz4Sn3A1K9EHEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUZieSO0ecVzDev6rdkh2UznFVWUlXsergR+pN+iXaI8JQ2TWOOLBPet4fBzWl2CW
	 7LXRKSTaLgXjB7BrbC6CME9uB6xlLOjbCA2FDEVcszSwkyzwB+ESI12lus0oPLLOCs
	 AUcpy8MxnLKfO3Snk0otx6DdvX0cpMfvVXSUwA+K5igQhpF5nPJoEA07KKIqsrGbsA
	 OuOr+fgwfesPvrr36DSOXPS3dQET4AEZV4Vrfz+nT8vQ9L1g29Cu+/WsP91F4dd9lr
	 q1hKcHwTPkpxmH7VKbx72aqllfq238AozA4EEvRC5TCqEfMXeIG0pDTTCn91w3Qen2
	 NYiXAuXzzjClg==
Date: Wed, 22 Oct 2025 20:14:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 00/11] ALSA: cs35l56: Add support for factory
 calibration
Message-ID: <c45840e4-af1e-4658-9e13-bd6b9f66598f@sirena.org.uk>
References: <20251021105022.1013685-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UdjxIjMgDuuXbRJk"
Content-Disposition: inline
In-Reply-To: <20251021105022.1013685-1-rf@opensource.cirrus.com>
X-Cookie: Remember the... the... uhh.....


--UdjxIjMgDuuXbRJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 11:50:11AM +0100, Richard Fitzgerald wrote:

> NOTE: unfortunately this is yet another series that is mainly ASoC but
> also needs some changes to the HDA driver, and they have build dependencies
> on the ASoC code. I suggest taking this all through Mark's tree and we'll
> avoid sending any other commits to the HDA driver until it has all landed
> in Takashi's tree.

That seems like a reasonable plan to me, Takashi?

--UdjxIjMgDuuXbRJk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj5LSQACgkQJNaLcl1U
h9AH9wf/WNwNqR1tEwxDCrFilaDQPFuZyFlv+hKP4pTf2xddtrWoUlHkhTYZ3Qkz
fknrzfOyRI7hIbT370nEPimYHRq7BYEUwYu5ovE+3fY1Nrdn/Cyob7gk+PZb8kKe
oXeTBoIeD8GSDoStSnf+/OcRTul5sijjZVyZyaX+Yhno/UNZXLoVBcpAhZupx/O+
qMzQxxoN5BtGzouy+Nb972LIuOiRZaD74zBC9FlgbxiLsCAnQBmg5UczVJjqF8Mv
EgGLNUGiXDzXkYMAj0vXp1rZvhGakSad9RNPo2nBkTY+Ev9qZzI6wW5Sb2Y25u58
QT4Lm0ixR73e/o0Eq4JsDzIK2a/aug==
=70Le
-----END PGP SIGNATURE-----

--UdjxIjMgDuuXbRJk--

