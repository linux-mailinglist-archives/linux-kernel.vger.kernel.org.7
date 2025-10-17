Return-Path: <linux-kernel+bounces-858475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7701FBEAE67
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBADE5A58F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A62DA743;
	Fri, 17 Oct 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkJwLXKD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3D2C1585;
	Fri, 17 Oct 2025 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719452; cv=none; b=HNDO0JX4LJMVYjSBsuu+bqR7COPIXJTsB9FASlee5/WKexly7u5IrB5pZRFc/f9LbdAufHRH6vqaO3jnolxue9kE0FWcdslQozGVMQegKDL75cmTWVy4svau6JNHiZW6cujr6QCpSgIjglZ+pQ0YMcXcpjI+grnUdKg4K8pKqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719452; c=relaxed/simple;
	bh=6V6dlNuYa6UKSKsDtKOl18PenRVNTY38CSm2xH8C35k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEl8/H28I5JEDmKL6ZODK3PGi5vTWXxc65ETrRf3wuZEr64gNZBX6jCXS2dwnxG2yFgPcDQV9QEzqsurgqHrRgj1hEkNn+pzPA2/Gap9EMYtvMyeTo9wT0N/tBFqndkKU4TWQAuOoHw1eIHGD6Yk8uOa/+ODMoTgYG42hw0MbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkJwLXKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A51AC4CEE7;
	Fri, 17 Oct 2025 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760719452;
	bh=6V6dlNuYa6UKSKsDtKOl18PenRVNTY38CSm2xH8C35k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkJwLXKDzLWQ5f2P47+1t+GFFbBMn7gul25BUHBxby4WqN5ubtWhvh2C5fQ5VIK1J
	 HtZY2oizlWHBghEk+N29YAF2GWl3NOmV+FKXOkcmxwVjMkLdtkWM2N/5lE9vPzS0MO
	 vAsDZIuemo6v6J+KIYqHrhsr11yVbqzkLMQw/DFQfqHxUDdUUcs5l6lB4qW9TPD640
	 YxbIzOpZyyJg1wL9nBzwNY4EwCSV8tJzwz3gYBggK7D8o6HUVIGSw96XcCBD/jtipg
	 NJsoJcGthgJa2rASptvDx55Eh3vkW2crYnuFyLnf5+wPDPlfvw56sD/nIqeIvKywLW
	 kN7OQeSih5geQ==
Date: Fri, 17 Oct 2025 17:44:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 09/11] ASoC: cs530x: Correct MCLK reference frequency
 values
Message-ID: <a16503e6-870a-43ce-a705-27c0ea199303@sirena.org.uk>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
 <20251017161543.214235-10-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8/afWNOS0G+oNDiu"
Content-Disposition: inline
In-Reply-To: <20251017161543.214235-10-vitalyr@opensource.cirrus.com>
X-Cookie: Androphobia:


--8/afWNOS0G+oNDiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2025 at 05:15:36PM +0100, Vitaly Rodionov wrote:
> The MCLK frequency must be 49.152 MHz (for 48 kHz-related
> sample rates) or 45.1584 MHz (for 44.1 kHz-related sample rates).

>  	switch (source) {
>  	case CS530X_SYSCLK_SRC_MCLK:
> -		if (freq != 24560000 && freq != 22572000) {
> -			dev_err(component->dev, "Invalid MCLK source rate %d\n",
> -				freq);
> +		switch (freq) {
> +		case CS530X_SYSCLK_REF_45_1MHZ:
> +		case CS530X_SYSCLK_REF_49_1MHZ:
> +			break;
> +		default:
> +			dev_err(component->dev, "Invalid MCLK source rate %d\n", freq);
>  			return -EINVAL;
>  		}
>  		break;

This will break any existing user that sets MCLK won't it?  Hopefully
they were managing to function, even if the clocks were out of spec.

--8/afWNOS0G+oNDiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjyclUACgkQJNaLcl1U
h9Bs2Af9HXQafHMNeZ/hIRo4s5a99ef+5r7m+KoxAscR2xxeTI/WFSYb7o2VqO75
Oenibhyh8Cl8Nb+T8YJpXruiFxsbaZxMzaCBuDyilC7pANbkLyTZ8riuMTMWSLPv
yaqTy09PJ0bpFW1s3eWegiJ8OHmgn6spNiga1rVrp6O4AUu0F0qGc2hsIVI1jwf2
J3MfwJoApZoqxbB3PpPtQu8p1EuvQenO4FnvMS6uReCMtVF/jG+Al0HVLBAtZ0CW
ysIJjzxLFyCercIOmYey2h3Z1ZhTuFqv4xC6G41MioF5LEYTnzO3IpOMvYniDnai
H+WOY9cEUYtiT3eI8yzvyAXyYgIG2A==
=R0S8
-----END PGP SIGNATURE-----

--8/afWNOS0G+oNDiu--

