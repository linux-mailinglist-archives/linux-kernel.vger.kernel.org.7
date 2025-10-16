Return-Path: <linux-kernel+bounces-856838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1759BE5361
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04A1D4E6E58
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3FD2D94A0;
	Thu, 16 Oct 2025 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLIraJF2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF441D54FA;
	Thu, 16 Oct 2025 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642228; cv=none; b=qgHOWunihOW+nvPy3Hxmo9wDXlamorNykpZtHxCbdHv90Eqhw4VTPwvfDkFwEmsgSyRva/mKTRneFDUK8qULQU+Ktp+NxYpbS49suNHTGI8wGkbb3bn0I2MqmiTyU+dXLpRuT8uc8AAeYyobu1LrGPheFDhD1xE9rMI4uZ754FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642228; c=relaxed/simple;
	bh=w19f7WrGtSupk4RyCUCd6ipSwCf7jze1IHIj4cHocTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYjaCehutZRebwcpbvarySIuPlX5XcDTTGXKEUARHy1O752tS1hxQCQHKFzhHcMNYNxnYWxJBQWiNJO0OiNOydetv7YbPz1d58qZF62BnHLizsAY9Yx3oQydOO2IZTGRyqTTszCLBrtnE3bxQXxwlGQdjnav7nlQLL8gtEDERsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLIraJF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2407CC4CEF1;
	Thu, 16 Oct 2025 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760642226;
	bh=w19f7WrGtSupk4RyCUCd6ipSwCf7jze1IHIj4cHocTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WLIraJF2m9clJJsebRQB8MlhmPILVdYwpcw8m0tU+49TMc1UuHJg7govO3Zo/Rquo
	 Z0mjuctGZsk4/y6dxbuT/gJmd2o10LlW1vZGrsoHFg3tz/fKXilyZOy7ViMfMQV/EJ
	 0rtath9ExbLKZUFwKeG8JhHqj+qgXrW3NQ2hhZkjYTfpINMSdaAIRD1Pm1TO7KVDXu
	 CugmodXiMh2atf781kC2h78QiIRJNK2vPOTZxWsuim+WcFpA0fMc4mK3a0A/pgOwDA
	 iTi4k+oSXQHnnO6ZlXSnBdnwezfUC/I/YQ8YL5rK19I4h7sAA4qIsTaQdYsKZKzpI9
	 19hwKFq30pmEQ==
Date: Thu, 16 Oct 2025 20:17:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Axel Lin <axel.lin@ingics.com>,
	Brian Austin <brian.austin@cirrus.com>, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ASoC: cs4271: Add support for the external mclk
Message-ID: <ced16027-2148-4482-bb94-6c4c2f3bf019@sirena.org.uk>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
 <20251016130340.1442090-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+JG1qBuPFVqnQtNF"
Content-Disposition: inline
In-Reply-To: <20251016130340.1442090-4-herve.codina@bootlin.com>
X-Cookie: Whoever dies with the most toys wins.


--+JG1qBuPFVqnQtNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2025 at 03:03:39PM +0200, Herve Codina wrote:

> +	ret = clk_prepare_enable(cs4271->clk);
> +	if (ret) {
> +		dev_err(component->dev, "Failed to enable clk: %d\n", ret);
> +		goto err_disable_regulators;
> +	}
> +
> +	/*
> +	 * Be sure to have the clock and power-supplies stable before releasing
> +	 * the reset.
> +	 */
> +	fsleep(1000);

The regulator and clock drivers should be doing that.  Any sleep here
should come from the device's own requirements for waiting after they
become available.

--+JG1qBuPFVqnQtNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjxRKsACgkQJNaLcl1U
h9C+PAf/eXHvK9X9ATWYm6kWwq6bqvTxZpJ2LcCRnMSPpUcRYLDeCmQRFyUG5o1J
ErQdfkWQEJLrLKidmg/bGcy7CkPTGOFpj0O+IvxJw6cwgY0SVBTKhqLuERLI1NBx
e2G30tElvL6MS7Tp3iSL+L/jfRUdmnMBJ/waEdwX8t+cUgA3g1A/IYM+/8KDWnGl
jIPnmIjQdL3B1qkSwntQr9pTm0p19lGhnrlnc33f7cLsUOpnske5ysWoVSeJNOVL
W/RbnErJqRJd+d9Vn+bAoNkoi1AkTIUF1Qu+Ete+2aLyFEXEf9yJwKBpLhVCx39h
DDE0YWfSs4MAugaNPQHJAcKCJvavBQ==
=0DoD
-----END PGP SIGNATURE-----

--+JG1qBuPFVqnQtNF--

