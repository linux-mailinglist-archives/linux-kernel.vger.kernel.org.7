Return-Path: <linux-kernel+bounces-806092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D179B491B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DD244380D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447052FF652;
	Mon,  8 Sep 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcFxI/a1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F21E1A17;
	Mon,  8 Sep 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342046; cv=none; b=fgx8b4VfslJDmBKUXGrF16AjDUrOQ7h075YiQqLcSASPoJSAQEFtyYJ0Ye10VQQ4KNV7jIUedv0IKuMfSxijuzTc/pYLpY8NxFpbVoyd4kn71sNGE2PIZ4O9UkXOXkuI1TRaYpHVz/kWJrnPNQ4X47prkUXwSNuDcXRP4BrmfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342046; c=relaxed/simple;
	bh=jmLh3PuSVlUt+g2PX4Ay2Hb0ur+5MEG8C0HwO0GRTe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CosKvWgFUNOSn2wjlEWs2bwEfWcqwNlGPG/7ZDiZXFlnOW12DLRkZ2eClaxlap6sD5VqJkzXT3b06YAR9cft4iAHxtf16tj924wct1HAJ03trq672qyUZoF6RXw3KMMhABN7GRx258vDHf4/0isGJS6kJ6GBxGz/Lg19GB6vp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcFxI/a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40984C4CEF7;
	Mon,  8 Sep 2025 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757342046;
	bh=jmLh3PuSVlUt+g2PX4Ay2Hb0ur+5MEG8C0HwO0GRTe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HcFxI/a131+8oDxawx1vgEO2l2fI8fhcgz372G5G5qWIrT4kEPDpQAfrvhcTrL70T
	 A5LBVSpJyb1F3Uq8C9ZRjO9+azCb12DfJiwC30UYnSCsU7sTNabI3iQHeJKHqi6Yob
	 B6saoMyHoeKyFs7FMuemIGzuWC4BHJDKLMIdObhMWGPGEWEQbwvVGgDzw/RU6aZW95
	 iGAt2MZUDSGJodtPbk6NuvBX4oHCb7eKR9/P9o3tN0+EKnmqZxuRg6x8q+ycwkOamR
	 WDSIBjNrWUA1QvyPubTjP5yyadNE4flz9Mylz/G2Mf8Vh1wCqjRhkOmMowmXK4c2QA
	 iyyePEmruZgVQ==
Date: Mon, 8 Sep 2025 15:34:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andreas Kemnade <akemnade@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH 1/4] dt-bindings: mfd: sy7636a: Add missing gpio pins and
 supply
Message-ID: <c879f3e1-f64c-4cbd-97ec-646d06488d8e@sirena.org.uk>
References: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
 <20250906-sy7636-rsrc-v1-1-e2886a9763a7@kernel.org>
 <288f0cf1-1ee4-4eba-b059-641120bb93f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1dMKtcdKROWDAugT"
Content-Disposition: inline
In-Reply-To: <288f0cf1-1ee4-4eba-b059-641120bb93f3@kernel.org>
X-Cookie: Air is water with holes in it.


--1dMKtcdKROWDAugT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 06, 2025 at 02:01:25PM +0200, Krzysztof Kozlowski wrote:
> On 06/09/2025 11:09, Andreas Kemnade wrote:

> > +  en-gpios:

> enable-gpios, unless it is something else, but then please explain in
> the description.

> > +    description:
> > +      If EN pin is not hardwired, specify it here to have it set up.
> > +    maxItems: 1

It seems reasonable to name the property after the pin on the device?

--1dMKtcdKROWDAugT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi+6VcACgkQJNaLcl1U
h9CLxwf7BQyHW20zqZG878E+egZPMLHOqAvNnwHpAnZh2j/C2o8dZP1Sutt2+VUa
ClPzdsXzKZarDW9CCEktgoCyIrLV8k8pAE8sQuldBmxD6Mu3daLTB0wQVr2RpcBt
K3p65WmmnAJERwUAxATQDdjJs+sRWWBgghOcdy6pIPIZmvdr5DUhyzBh5UfYFyCM
C/JUDDPJtrnCmmVAsYP6p68+4fNHyWdnjnf5MM4xIbE/03ZmPVtZuOGLpyE9BqY2
jM6WSKGu1NSf1BAd9+AjmGrjGLAwpNrerssP8ADjesrvhQkYR6ib71JScEjS0TaF
z2sqtPhxcCdpn70FwcGyveIf6mwZBg==
=ahy3
-----END PGP SIGNATURE-----

--1dMKtcdKROWDAugT--

