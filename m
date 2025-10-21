Return-Path: <linux-kernel+bounces-863122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DADBF711A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98B818C647C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512BC339703;
	Tue, 21 Oct 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onRyjXM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F252737F2;
	Tue, 21 Oct 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056856; cv=none; b=gMxJbSq20Mg5pWdSHskynd8fws46yEPiR7QfsV8qpVKL6jcpnrnssXQK6mj/zPmZOSO55RP9mbLOKdxqfuPSz6eOX+VIq16FnJfetGSGSHLchcmB5a8gEcDy8Cy1LfbG18Z+u/a2C4Y5u+5RHzXCzJpTXk748Cok8kTc2Ei+kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056856; c=relaxed/simple;
	bh=SbzpYEkEq0KUyFKWrU5aV6V9FzQpBlefBJA3idPdzbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS3yX222ii3XcX2edKghik+7btwc5froN6kEVvXWF8H/x64cFL29wu90YYs5ENkBAiq9KX9OgUZv3uPyVyFWaNkQvc2Cl8uaTWSoKCo+qB3NUENsJnX96tRLVVl5Y3MJaCECFxiYtka8bRudVbpLb+6znhf9+cSp8AQ/AYl4L+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onRyjXM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A6BC4CEF1;
	Tue, 21 Oct 2025 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761056856;
	bh=SbzpYEkEq0KUyFKWrU5aV6V9FzQpBlefBJA3idPdzbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onRyjXM5HX2vOGnM5SXu0rERJw0tMBtRN02+o0bdexN9r/JqEAcTgdGR5wqqELBNe
	 bScejQb96G/84saaCHzMIoqJDjkup+puK387OHXs1wERe74O00o5phw/wOGGAybF0F
	 ae6mNX7qce0NoHav9ayDo5jdSJDrj1TS2oWqYDPBwkm9coi8dwsa3azxY28ipkTJxS
	 As3bz1p9uzg9GoYs4N9oBxInW0Z2EcZWUE5fevcGkvRim9Mjlz4VQs/nH0fZp8Hi0X
	 YxBF4TXIb1xmaYFVMtDSnOzlpw4hQX1b4zCZluA8NQ3Sf6dq1zWTnUztuLGrqP4Qm0
	 nZR8QpimMMBXg==
Date: Tue, 21 Oct 2025 15:27:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: axp20x: add support for the AXP318W
Message-ID: <23ab5c21-b271-4643-9354-bb569b6705d2@sirena.org.uk>
References: <20251021112013.2710903-1-andre.przywara@arm.com>
 <20251021112013.2710903-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2+RDuzE0ZwLnRRWl"
Content-Disposition: inline
In-Reply-To: <20251021112013.2710903-4-andre.przywara@arm.com>
X-Cookie: Accordion, n.:


--2+RDuzE0ZwLnRRWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 12:20:12PM +0100, Andre Przywara wrote:
> The X-Powers AXP318W is a typical PMIC from X-Powers, featuring nine
> DC/DC converters and 28 LDOs, on the regulator side.

Reviewed-by: Mark Brown <broonie@kernel.org>

--2+RDuzE0ZwLnRRWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj3mFEACgkQJNaLcl1U
h9CyEgf9Fuh/J431gn6IPm6b07ITYlegldxj78Ya8V9mrnH2OaAaNxPKuOP5n6Ke
DIKk6YbW2fQVcT7cL8jBC6cN4IjNAHkockdv9mWezbfHaLwImQd3v5Dj/Zb5Wnti
lqY0b7opZb+7o4vuQQ1Yfxd5k789gB1YOu/7ANJ6HSXwbwLmtgZMZO8gnibNVli4
iPnd3MkHz+6HfGVvXPoBnAZ6lS5PbhVaBCITd4vS5bSI23lDZhePOsAju8tGSK7X
lJnzBsobW2zvNUdt7diadum6EMyippsPZOdsV/NLpW40WOBjgcg6xV/VmUUQK9Jh
+WtRfHg3WJ0PvikzF4yFc9koAt4zcA==
=sr0s
-----END PGP SIGNATURE-----

--2+RDuzE0ZwLnRRWl--

