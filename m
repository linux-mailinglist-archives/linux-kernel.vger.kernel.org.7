Return-Path: <linux-kernel+bounces-801069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1730BB43F62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA13B605C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188930ACEA;
	Thu,  4 Sep 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ3kdWTZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB862309DCE;
	Thu,  4 Sep 2025 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996984; cv=none; b=K+fuZ3YUYjmoCTDehng5HC5QnWA+sDf+VAVagPBF62rzZ3ZDtQvydd3egIcI6x4kWoRVCFwBy/ox4RSu6i+TI1/yXnXn9L/lJ2NGtuhw+GJCNQglZZhUz20wko0qV3nZ4FV0a9poIpM6yKwFmBx4IWUPUpGKGesfx+KhyQBBwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996984; c=relaxed/simple;
	bh=4JzuD583znvuRSHRzwMTlJaBr54Js9RfVIMcsJb0B1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agnwcEUEgnMrdQq5j8CBD+ijd0HXZSCKQuO+vKLajtr6RDukUUxtMqUPRI4CWAtEJ4vfr6s8xyMepXaZ2ET8UB7s0Km+J6U1Au6OgegYN6JYH2x2xvuPUGyBGbRI3RELyexgkK5wQ83L71OXoWkmKoyIgHBa/3QRbRCCNnM65HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ3kdWTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F27EC4CEF0;
	Thu,  4 Sep 2025 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996983;
	bh=4JzuD583znvuRSHRzwMTlJaBr54Js9RfVIMcsJb0B1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJ3kdWTZLOf2UOVtmxpR4cJRkgLizeTntd8yuk/pAdYThbfyuodenYPxy6MP/ngD/
	 Ll6fXfaym2Qg26h6NJaOhE1xCzUQKv903u9nf+fCmvVEWj8tx6FFlDGvZ4/aaxE4U5
	 cmD2X2OmxT28Lol1sP3PvoVP5pSrjt8rmznyac1l7A8LMrmUdvTjCetrbxb2jKspKC
	 ebWfwIbVwsPYf4HVT0SStdd68hjBkx1WNDRBjoHM3hbsgpmzlm26Y9B/4wQk+qwdQi
	 eQQyk5V82zuhFopRxCgrLLgeqMGY6eLbJ4WM7SxMyExXyQ8u/WSoXLEupwTBfrE2SE
	 jlQp7wIURgYlQ==
Date: Thu, 4 Sep 2025 15:42:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Woody Douglass <wdouglass@carnegierobotics.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] regulator: pf530x: NXP PF530x regulator driver
Message-ID: <462637d8-ce9d-4ba8-a6cf-a5e59e7ffd26@sirena.org.uk>
References: <20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com>
 <3c45fe88-c9f4-4606-87bc-726f262998cc@carnegierobotics.com>
 <9050a07a-e94e-4d34-b4aa-bd2e6f91f792@kernel.org>
 <26fe4872-dc16-4db1-ac0a-e325222d0864@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n5tJdPi1YdOgbKI/"
Content-Disposition: inline
In-Reply-To: <26fe4872-dc16-4db1-ac0a-e325222d0864@carnegierobotics.com>
X-Cookie: No lifeguard on duty.


--n5tJdPi1YdOgbKI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 04, 2025 at 02:20:05PM +0000, Woody Douglass wrote:

> I will configure the web relay for future patches, thank you! Should I resubmit patch v5, or is the
> fact that it's on the lkml archive good enough? it's at
> https://lore.kernel.org/lkml/20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com/

It came through fine here so I don't need a resend.

--n5tJdPi1YdOgbKI/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi5pXIACgkQJNaLcl1U
h9Ap/Af/bSmYGEl+zcnIBArvme1fyiF5ppZe4ZbWBml+qGNr7ff5Fj/iKAWOcPGT
i+l6o4Xo5Fj2fFNMM6tRW9FzTQVvGoCF8FORbUrCldAlYYzv+kucvV0ytDC0oZtS
qtG1dhpVgOz4B2kIQhM+ooVqLGu1HRP29VwPaQdl9QCmzI3Mf66NDEQmKFsbSGGK
pUR1jd86h238XZZrPCLStEMQXS7rFSOMopmHQ3XJMzn1WSBbC19Q6WQrawTeohmc
0QiPQWdmsVU6FR9N+qVQ8HdEkJnzI+dsWRcztZWYO5wED9efjxP4aTIiNITV5JVk
Ltn3nCyyHTrPDg5PQ0DX6/WIjEVvMQ==
=P7rY
-----END PGP SIGNATURE-----

--n5tJdPi1YdOgbKI/--

