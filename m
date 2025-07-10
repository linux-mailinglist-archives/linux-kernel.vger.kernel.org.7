Return-Path: <linux-kernel+bounces-725370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B958AFFE22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D6B1C456AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2317329ACED;
	Thu, 10 Jul 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8niUqxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA8292B4E;
	Thu, 10 Jul 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139784; cv=none; b=b6JVv48sc/450aYTNf4lLj1bxH68fadEVoTtRe4qgh1pgBxTclRJbd1Ka/GiZOA4DJdbguo4IiaHMHF5QJEc0TO+C5g3ocOJTLpTwc/MjQgTxRhfZXEeCDsJIJ97vVOdlTswcBAi1l135REXRBT4YlV+2rprSlBaopvyw5iRgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139784; c=relaxed/simple;
	bh=b7coBjKHXlBo1gRKTkQSuUICRQqoXBqojlzbdY8ZYok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtHGusGG+2/YrgKDJgK3fMM+DcKO1/G8C+ayT1hPxqTQSiHGNoQL4OKZx1aZ0m2dCWJF8FtPf0ocYDvY5Fx1ydPNE8tTkLj2BrxHWf/iBbOkPAK9Z/wK1BPkghWgZl3GcPSsmnWUZalKK0jNrya5ml3JpKam2aWBb+WZS2B268w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8niUqxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48526C4CEE3;
	Thu, 10 Jul 2025 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752139783;
	bh=b7coBjKHXlBo1gRKTkQSuUICRQqoXBqojlzbdY8ZYok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8niUqxkhkse07uWcriW2vMAJ55Q1uUGsPgOsxdiliGT+Bl/BA0Xoba0o8Hed71hK
	 XmJyT3e4rAjo52BwnTWJVpBZ1+GKWNIxw034iCXsu4OWW4B+CmtBHUHMMeXwJ2t3g0
	 wTWFvxGbO1/qSO4xnEr6mpNKZNYKjKXlbCSjEsEgwbyNXC6Ib20OA3/74Kn0ccbmpw
	 FvtQ7Su50C2qJYjbPQOg7aUUYQKhhTtM6Ke/VZLEPltUt0LvrdvaOHFwtKfjAP6JUF
	 R6ghUXL2xYkNASNU768sib7yyWAdXGI8VHUkVX4/+3TMmih+Vp57qfDxH7XWE9kj/J
	 8K1lDwrIlgshQ==
Date: Thu, 10 Jul 2025 10:29:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Nick Li <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com,
	like.xy@foxmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio
 amplifier driver
Message-ID: <aG-IBT5tjMS7RiXe@finisterre.sirena.org.uk>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-5-nick.li@foursemi.com>
 <aG5Smt_DErSq5WjE@finisterre.sirena.org.uk>
 <61B23934F28A9F2C+aG-AXznikkHb2_jR@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8XwfVoiK14qFQFUv"
Content-Disposition: inline
In-Reply-To: <61B23934F28A9F2C+aG-AXznikkHb2_jR@foursemi.com>
X-Cookie: Do not cut switchbacks.


--8XwfVoiK14qFQFUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2025 at 04:57:03PM +0800, Nick Li wrote:
> On Wed, Jul 09, 2025 at 12:29:30PM +0100, Mark Brown wrote:

> > The mixer-test test will spot this for you.

> BTW, what's the mixer-test? We tested it by using alsamixer and amixer.

tools/testing/selftests/alsa/mixer-test.c

--8XwfVoiK14qFQFUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhviAIACgkQJNaLcl1U
h9BlqQgAheK3u5Y8L+HQ21Fs/chPR36vlv9ZGV/1K+38He9hzrEHrC67Hn0N+aQI
pCgknrhX0137zmvmydG75Efq7GLkGBVEWE7E8h61BZyr07JVYarzNfiMQ7aPsPGp
zIOnopDIe4XvSP4We7pHKZuWp2eX6iGRIslPTCPglPw6FArqH5sBNvmcbPCsp3b1
jjbhCF1PoVv36jzOs2mQPRQlyqH+PRdQI3stv3Hs/fB3qhyWrT+qHLH1pWplNGEK
zdLEWMjCcfEF1/AFEYjauPQagoX8aouSMEI+gvvkqCkHjkV8O6EfGzHp6GslRKAZ
rRwgXQ55kWuCgDlUYkVZNSRAwt5HbA==
=GtFY
-----END PGP SIGNATURE-----

--8XwfVoiK14qFQFUv--

