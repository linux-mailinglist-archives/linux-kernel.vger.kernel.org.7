Return-Path: <linux-kernel+bounces-764639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53DCB22578
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4863AEB41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C292ECE8F;
	Tue, 12 Aug 2025 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiyeWvOA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E032ED17E;
	Tue, 12 Aug 2025 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996761; cv=none; b=dCxOjYEaj75iY/HZpOEBFwNys3xVvkWtxtpBYa4KxihEL8AxrmqgBZteReamCNq1CLJGmrKv0Tf1m/JPAFldBYxMK0ZNwLziiIzK5BFeLdqVZJLYFB8nDL4bTfRriSigo5TBhfyVHe7MD50Slo2baYv5gBCA8ZnpcQO84R6YSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996761; c=relaxed/simple;
	bh=74BupngDWQLejbbZR2PPJ12Cq6JlKuvD8OSBnZRBk/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYwd6aYUkwW/tC3yAOhxteiSscT/K/Nf7amI59IlUzGeo+OKOsJZBRYqyIMZ1qG+IH6JSHQsu6ta6gjx2xKC6jZxuPG+ll5Wk0sxCmhmgI1gxTz6+B8t0YL195lKDX2VcBmLrHvZoMJJBA6/MNg6clwP8uMWIDP96AfGcpySKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiyeWvOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDE9C4CEF0;
	Tue, 12 Aug 2025 11:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996761;
	bh=74BupngDWQLejbbZR2PPJ12Cq6JlKuvD8OSBnZRBk/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RiyeWvOAGrPuxfs8iJhMhcxW/aJucShR1Dr3vOdq/fUYCXA8Gbr0ncZu4l9deyJjg
	 gyOBJgbBQtgDiH4A3Ld8BUopW+1XQq12SWYRADvQTX9oJNTcNTD/CiIeHy4QQLgHsu
	 kjLAtqjMM0Mn/s54yoP4/IGkQGKSyp/5eIBJq7lP3X6lWw3L6vKYz/4LHL0jgO6JkZ
	 qLQbjGZhAcG6ZDz4n6wC1Js+BGrhDD9eqkV6iTSInKCzAeiGfjcbGdYX93qecRsNXY
	 rpu+x0WfKLqjrxhmyQn4jE8+dTqgY3aLpSa+wTWc+9KamdeJYu2rroBulBEya6qgz1
	 nRxpUfMqBjLdw==
Date: Tue, 12 Aug 2025 12:05:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, linux-sound@vger.kernel.org,
	lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, drake@endlessm.com, katsuhiro@katsuster.net,
	matteomartelli3@gmail.com, zhoubinbin@loongson.cn,
	KCHSU0@nuvoton.com, patches@opensource.cirrus.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: everest,es8316: Document routing
 strings
Message-ID: <c280310a-d9cf-4bc5-989c-0fb8093f714d@sirena.org.uk>
References: <20250809151853.47562-1-jihed.chaibi.dev@gmail.com>
 <20250809151853.47562-2-jihed.chaibi.dev@gmail.com>
 <d5d0133f-1b42-4ad0-a3e0-2a2bdeb67484@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X4bi1Ovr8PtqIvqm"
Content-Disposition: inline
In-Reply-To: <d5d0133f-1b42-4ad0-a3e0-2a2bdeb67484@kernel.org>
X-Cookie: For internal use only.


--X4bi1Ovr8PtqIvqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 12, 2025 at 09:40:20AM +0200, Krzysztof Kozlowski wrote:
> On 09/08/2025 17:18, Jihed Chaibi wrote:
> > The es8316 driver defines several DAPM widget names that are used for
> > audio routing in the device tree. However, these strings are not
> > documented in the binding file.

> > This forces developers to read the C source to discover the valid
> > names, which can be inefficient and error-prone.

> Reading free form text is as inefficient and error-prone as reading the
> driver.

On the one hand, yes.  On the other hand this is better than what we had
before so seems useful.  Ideally at some point someone will add a
binding for this but that's a much bigger piece of work.

--X4bi1Ovr8PtqIvqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmibIBIACgkQJNaLcl1U
h9Dpcwf/TAm9jNFh7L5PYSlOgQTOiC0gOvymWsxQ52x9R8B7zD/mlOlBVSa7MutM
bQIEYIOy8F6B71BA0kbbxMSkz0M1eKGw1EYAlwBAV9S3srqpAwRnBGlnnmucDDIf
U90abTbSx83vPK3hUctTbsD9qu0nXcEZlmjb+pHPQ+RodDDFvSEH70ZyKffvHNYi
6AsRfYgyRO+gCi9wQFh4dUs++FUts/I8yUtqvH2thR1fdrZBrHGKnHb2PXcKj17a
t5MwZ4IcbVR0LUunCkcdr7awy0vxPjudFOs1qAcoF91mhwHE+NxXZRm1jXO2Ab0G
undQieJhdo564ImmFRDdHgzBGGBR0Q==
=06Ol
-----END PGP SIGNATURE-----

--X4bi1Ovr8PtqIvqm--

