Return-Path: <linux-kernel+bounces-740749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173F6B0D899
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B06C02FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B94F2E425E;
	Tue, 22 Jul 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FESul+EF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D102E1753;
	Tue, 22 Jul 2025 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185253; cv=none; b=iLTQfsz93eTgEQ+hYY4JwIqesoJcenzOPU6xDbwvK+pahxILcdr9naEejdnbRcOiqjkPEg8ruTKsTv52GOVo/Lu6vUJB6rMoRAAO5ZPVBqCouhvOrtqTbQ4ZUHJWDpt3g7RLnKq6JbEn9dRX3877kNgFJggEZg7/3CoQSZ9grg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185253; c=relaxed/simple;
	bh=B9E98Eh1WXnC39xyxUMFUauO9zpXBqS/fOh6mlUvJSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7A/z8njpG3qr5Ukn4UVM5dKGB/sXVp3LaFtyEYc3zfiUDSi9tZjxXRGR2TW4SfEmqZHYj3FmfI3vvOfWO3No59ru1oZxTc+wRj0W0wof2YArT4zcTE0S7SaoaNx/gP0xZnSummaOOYxB173fQTmP4N8fcGMt7mhpY0xp5Cyp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FESul+EF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E8CC4CEEB;
	Tue, 22 Jul 2025 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753185253;
	bh=B9E98Eh1WXnC39xyxUMFUauO9zpXBqS/fOh6mlUvJSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FESul+EFfx0IOy9epSM4NK9vIs+nEBxJxGSaNo3a9L6cgXUnKDUzjoFb0Jb/dEf4t
	 cHaQTmP92G1VeYeBrL0LyBIAjAHEKJ8KaqjYIpFOgi1RGtgY2VSKMf2129Zgu357lD
	 pgzohjSwYO5J9f4UMiCvwJJQd6VNnVfGfh6jlLZrYf3R8n4Vr/br3cbpRuJa3YGWhu
	 NDEyeq6rInYgYcfxr6+T1+0+cNdMQcrUGJBC9ljeG7djKP+aRwkvUev+PME262TyX2
	 SoThCJoZ850e/IlaXn++XmCPqiDzCALuEmAW5RR+aQaSyW+EfzDbehP4Q+KvlUUSDy
	 JoYV5XT+gWq4A==
Date: Tue, 22 Jul 2025 12:54:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jeff_chang@richtek.com, lgirdwood@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: regulator: Add Richtek RTR5133
 Support
Message-ID: <50908790-f4a3-41ee-a270-83be3e74c1a1@sirena.org.uk>
References: <20250722083543.2730796-1-jeff_chang@richtek.com>
 <f4505b19-3496-4fab-ad74-d190d847eb17@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ESxqwv6SVKxL8cxQ"
Content-Disposition: inline
In-Reply-To: <f4505b19-3496-4fab-ad74-d190d847eb17@kernel.org>
X-Cookie: Don't Worry, Be Happy.


--ESxqwv6SVKxL8cxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 22, 2025 at 11:04:51AM +0200, Krzysztof Kozlowski wrote:
> On 22/07/2025 10:34, jeff_chang@richtek.com wrote:

> > +      base:
> > +        type: object
> > +        $ref: regulator.yaml#
> > +        unevaluatedProperties: false
> > +        description:
> > +          Properties for base regulator which control force-off base circuit.
> > +          Base circuit is the power source for LDO1~LDO6. Disabling it will
> > +          reduce IQ for Chip.

> I don't understand what this regulator is for. Your example is also
> incomplete - missing min/max constraints like voltage.

> Explain, what is this output pin? I already asked for explanations. I
> have diagram in front of me, so explain precisely instead of sending THE
> SAME again - which pin is it?

It's the top level supply for the chip, it's likely not externally
visible and sounds like it's just an on/off switch rather than
regulating voltages.  This seems fairly clear with domain knowledge.

--ESxqwv6SVKxL8cxQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh/e94ACgkQJNaLcl1U
h9AgaAf/XwVPnaOAi8nc84FMjLYM0D6FojULEW9XQuYYHe6oyjnJin0+iChgWHB+
TnEMFZvXRF52mT7kpLAdl1cZbxoaZlx0Io/TmjGoPuu01PM1dAidyyHUSqXD6YFm
9+ww8QVAGYlnfSigDDmzxFSeczgko5uy/+KrAY+B2EnMo3Cbwnjh9kYFzj9abwil
UMHAiRX8X6Ab9X525Xu/H4IgHw9836Rmtm/gn1iMPVh9RCwtg4oLK+ocDbsMyK3L
HsSUcMNyPEaE/KDI53H28y6TSKWRVBaG9V26cFp4xFGSmQjdJgnLnmo3kJEAZp4Y
LZpF/JtFy5NgPVMR9g1btq0xOavp1g==
=Em+H
-----END PGP SIGNATURE-----

--ESxqwv6SVKxL8cxQ--

