Return-Path: <linux-kernel+bounces-739258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2437B0C3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755AD1886A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E6C2D29D0;
	Mon, 21 Jul 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO1sCtUd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C72BE026;
	Mon, 21 Jul 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100343; cv=none; b=oU/u86ks7GPlc3lIKeaycBEomGvsoBoYFG7j/5gmm/DGu2WnxBBh2KnPk50IcfxvodmNyXEqWKQJryKY+/kZW7ujCdT3CENBzWhdo0S2z5zqb5W8nsvGHH3E0i0p6pHB+nsGQ+05x1Y7NbCPepm6TmrUNNvWdZni5AaFV30eHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100343; c=relaxed/simple;
	bh=PzefWzhOAxLG5yYzeQdnai2xhw/+TsMVHa1W+t2mvPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3QdnMAoQ0mk+fsu+LD7QiEPJywLJ29CVWwR2nVq5tGfxc6Ixev+uySwyxMlaiGF83+bVwO1LYu8DRvPE5JNJU6xa0Q62dRNV+xJBW2tjgilxJDoPy9tvQG15TpHe6Vir56uSFvGi1Hr42Okm9tmQN/HdCGGpNnMxySylZMozEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO1sCtUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EF6C4CEED;
	Mon, 21 Jul 2025 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753100343;
	bh=PzefWzhOAxLG5yYzeQdnai2xhw/+TsMVHa1W+t2mvPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iO1sCtUdeeP/wf1j42cg/xs9mhggTyLEF1zTLyq+5LE+niUKKR+BuWUA5FuYbmKe0
	 ki7aYsez3zkH4yyTCYBNLdi8M299z2Pyupab7+2Cib2uhHu7abjH4enJ1vMG9DltzQ
	 zDCVFf5AbVDfa6EsCsF1Y0rsp/6576sYVxjQMm6cVV7wRPX/0oKJpRxyWjFEd/GHzO
	 /Dn2XnCGAGxrXX5lNGhkJGTSJQrV53Unt5RCUhrUa3d6F2YsEbqfqBhk3Bec6uG18k
	 sgz48TnPg4SwshG6SjUwl/yTg0PVvePhppLJ+rYUrSlD2df8f0FyznqkDxK7PfqPh7
	 jsMg1vKt9hgNQ==
Date: Mon, 21 Jul 2025 13:18:58 +0100
From: Mark Brown <broonie@kernel.org>
To: jeff_chang@richtek.com
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] regulator: rt5133: Add RT5133 PMIC regulator
 Support
Message-ID: <b4b3dde0-18a5-40d3-8cd2-53e4cdbd3e69@sirena.org.uk>
References: <20250721060215.2718217-1-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sB0uYLQbbaM0qI7j"
Content-Disposition: inline
In-Reply-To: <20250721060215.2718217-1-jeff_chang@richtek.com>
X-Cookie: Microwaves frizz your heir.


--sB0uYLQbbaM0qI7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2025 at 02:01:34PM +0800, jeff_chang@richtek.com wrote:

> RT5133 is an intefrated chip. It includes 8 LDOs and 3 GPOs that
> can be used to drive output high/low purpose. The dependency of the
> GPO block is internally LDO1 Voltage. If LDO1 voltage output disabled,
> GPO cannot be used to drive output high. It need to pay more attention
> on the usage.

This looks mostly fine, a couple of very small nits below:

> +static irqreturn_t rt5133_intr_handler(int irq_number, void *data)
> +{
> +	struct rt5133_priv *priv = data;
> +	u32 intr_evts = 0, handle_evts;
> +	int i, ret;
> +
> +	ret = regmap_bulk_read(priv->regmap, RT5133_REG_BASE_EVT, &intr_evts,
> +			       RT5133_INTR_BYTE_NR);
> +	if (ret) {
> +		dev_err(priv->dev, "%s, read event failed\n", __func__);
> +		return IRQ_HANDLED;
> +	}
> +
> +	handle_evts = intr_evts & RT5133_BASE_EVT_MASK;

> +
> +	ret = regmap_bulk_write(priv->regmap, RT5133_REG_BASE_EVT, &intr_evts,
> +				RT5133_INTR_BYTE_NR);
> +	if (ret)
> +		dev_err(priv->dev, "%s, clear event failed\n", __func__);
> +
> +	return IRQ_HANDLED;

If there weren't any events flagged that we handled we should return
IRQ_NONE here, this supports shared interrupts and lets the error
handling in the interrupt core handle errors where the interrupt line
gets stuck.

> +// Due to crc, cache is not necessary
> +static const struct regmap_config rt5133_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RT5133_REG_LDO8_CTRL4,
> +};

Might be worth enabling a cache?

--sB0uYLQbbaM0qI7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh+MDIACgkQJNaLcl1U
h9BtvAf/St3LVHr0CT8nuTDo6Asmm/X/dT520+9VEhQ3PVKTaSvmvkSyPtaZgPKJ
8KbdW9XN/8J2q9qwG0GdAw/jTktpDUQTuBFB5fCUFR2yITpzdJCi0IR8i5e7jJeX
TqBsc1PitLkNcnJd2GeDu2ih8i/Fs7pNH3WgOZ0WnF0Y4UoBncRBrz3Cvr3UYHOu
cSsSb/joaW1F2domqsZZwYw5SRbMaYTAi44/zffEX7ygZSBDxeGu/Dzl5qWiLfOO
9wR0uReqxQYFZW2L5siOjfB17D8IO0g6JcTHFbkcvBI9ne6JyPZhNzaRrwRFYUu2
w89fC3RRAC+aVnutfqT+L5UhR3u9tA==
=Y+E1
-----END PGP SIGNATURE-----

--sB0uYLQbbaM0qI7j--

