Return-Path: <linux-kernel+bounces-869382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D48C07BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBE23B0C31
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801E2D878C;
	Fri, 24 Oct 2025 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR4orNYW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2EC21D3F3;
	Fri, 24 Oct 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330257; cv=none; b=rMH2veWxsrzEIN6f3bMZ8pZ3+AaOyEDppz5JmTOSTJGebZqo3Ig5zFumpRqObX/dlD1BKZ9m7YMG7HDEavKjLe1yRLMNGgSoE0c2PrVWnSJJg8KTJ7vV9PMD8eYVAEFzES6HgSoDCIWd/QaglGmV56oCeIeFcAngts7S1fTuUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330257; c=relaxed/simple;
	bh=LLx1LVGvdg/wvApXo8RtVwU0hoW7NYqi+oZmkFIZ39k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab//iTrI7PiLN87vWqGlMh250d5DrBJ/CPXllmRGuUhg7UMUpKckTIv1C0qxPy3ZGNfYAbD/JPzsZnShrg9FCcmct3I5vx12Nvv0yD9TVPMZQbwxuFhaTsMeTJDDqMWwmD9wuWmGBtYVQVDlQnlNX0KnBC3qtCRjofw40BcfLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR4orNYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D359EC4CEF1;
	Fri, 24 Oct 2025 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761330255;
	bh=LLx1LVGvdg/wvApXo8RtVwU0hoW7NYqi+oZmkFIZ39k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RR4orNYW7AprZEQyowFwqSLx1h0W6e1b7RiGBXsQQ9v/H7tVIS30aIBWb3m3zdJaE
	 aoYkPIjApdAfTe7+hUhTXABVdSUNzlJs965OvqMcXaF9lobYnmQfTpFc2fEQT9vsf/
	 +1/vr5/rT90UjC2/65DoRc4WNVje4+hfys20G3o/X8FH1dYHcBU6l0VH3/SeQ7tFkt
	 TJRlL/JkX3sMVvHK3NriiCGqb12PcY7ooP4wh//9ukX6u6yFTbowh3Dkgnde1S2oQB
	 kzW456X/g2/If31EsjjE25Ex3zR+DSkYh4xf/v98Phlpyc2GfdvLx/OZZaRjmkTPd4
	 NZXK60Fsg2HEQ==
Date: Fri, 24 Oct 2025 19:24:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v10 1/9] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
Message-ID: <aPvETBr5aebElQUS@finisterre.sirena.org.uk>
References: <20251024083221.25758-1-angelogioacchino.delregno@collabora.com>
 <20251024083221.25758-2-angelogioacchino.delregno@collabora.com>
 <20251024-think-handwoven-504634ca620d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JmMTACgssj5QFShR"
Content-Disposition: inline
In-Reply-To: <20251024-think-handwoven-504634ca620d@spud>
X-Cookie: If in doubt, mumble.


--JmMTACgssj5QFShR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2025 at 05:29:31PM +0100, Conor Dooley wrote:
> On Fri, Oct 24, 2025 at 10:32:13AM +0200, AngeloGioacchino Del Regno wrote:

> > +      regulator-allowed-modes:
> > +        description: |
> > +          Allowed Buck regulator operating modes allowed. Valid values below.

> > +        minItems: 1
> > +        maxItems: 3
> > +        items:
> > +          enum: [ 0, 1, 2 ]

> This property has no default, and the property is not required. Is one
> of these modes the default, or is there another mode beyond what's here
> that is used if the property is absent? Or are all modes allowed with no
> property?

The general approach the regulator API takes with everything is that if
there is no explict configuration then it will simply not touch the
hardware.  If nothing is configured then the hardware will be left in
whatever state we found it in which could be anything as far as we know,
it might vary depending on what was running before and what it was doing.

--JmMTACgssj5QFShR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj7xEYACgkQJNaLcl1U
h9C1HAf+KdL5D9OqnVx5rWOG0pLbQ5ra9sSXVXvx8aWFAW6Ba+V62qfedjY3AHnH
O++SR1ZapWXCWQDrH+bjeld94sYUImJ326N3uPtVvatNAYYbJPHU8s3kMuF9A+sf
y02rLo1vq+geNnKKwK5lyCGYskIT1rFlyXCn5ePGVtfH0zu87HGs8az0UGmdbhOA
en8RJs0eFPgqgXM7MYIvObJeoPcy7HypsI3oJXB7jdnpBzj3iLPDZOiCbFHvqd3m
GlZJzucyyKNGBWcgvrwb4afHilnDj+xEiCi77r4J5nEGHoAt4tgwdF4eGwnRlueE
8aAINtB/zLdXFGft3PIUrRVkH9kkmA==
=OCOj
-----END PGP SIGNATURE-----

--JmMTACgssj5QFShR--

