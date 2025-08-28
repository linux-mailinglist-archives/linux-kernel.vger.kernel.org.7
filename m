Return-Path: <linux-kernel+bounces-789594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38499B397CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AE33B3CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971A226F281;
	Thu, 28 Aug 2025 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsmQzwib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85DE3FC7;
	Thu, 28 Aug 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371866; cv=none; b=Q01zEm8X7oEAJc/7nKjdFjGodk93ESjXCWM6yRprTaex2LjK0iy2VTO8UQ+XGYOiUR2F1H7ag9dP/dhiThtX2ot1ttuK4L7o4sgS1Bb5SezEzq6QVXpqGvhjdSNt2ptZoMli2eZPoA0msuqpwJ1TdyyZdDHwwZ68W4+VJLNrOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371866; c=relaxed/simple;
	bh=TPlwEAqUUfxSYMur9BAnbzqR8t4bI14b85yX+aPJjns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HblnwaM11vJg2kU69Sv5Xc9aw9BjRrRXd65cadAAvwwhQrZsTMDrGbi2dHXuB0Kb2SgXN9eRVkI4ugtreOc1QiXSjNOjP8mz3F6122MNzCgyS4NDBa+G5YzAJZywMZheW/YOZH/WvUlCET44fwQrq6cLfhw4IBTeulYqqdlilOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsmQzwib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE05BC4CEEB;
	Thu, 28 Aug 2025 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756371865;
	bh=TPlwEAqUUfxSYMur9BAnbzqR8t4bI14b85yX+aPJjns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsmQzwibKQi9UDmQWzJ8eBbp2x0AJfyN+C2oWEp5wiHDYVhExt0dTHMLhdATQAAzu
	 juWMJc6wqmWUZYFzR274O8Cz9y3q8kr4+X8FpRhuOIZ9hnVzlSSyBMjgAjKNwHHxdp
	 5XDH9DHXJgj5bGUvf8LJUh+ksw4U4edtUfvnMkpuAr9k1yFvhsXm0P1L8BRRSruFKA
	 gIhUX8nCSEpRjpMCs22Pa//3v+Ez03Sv9tyGoGKHeJpqkBirTMQir2DNOEiZihl8W/
	 WUAhsV8d0365iS8oRZGTDJolo1quix0mQtRc8OU87aa7Me4CSQqZhZrXjIdhQ6H87x
	 Vmt/6d2YY1GLA==
Date: Thu, 28 Aug 2025 11:04:19 +0200
From: Mark Brown <broonie@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH v2 2/2] ASoC: spacemit: add i2s support for K1 SoC
Message-ID: <aLAbk_0emidBCJBn@finisterre.sirena.org.uk>
References: <20250828-k1-i2s-v2-0-09e7b40f002c@linux.spacemit.com>
 <20250828-k1-i2s-v2-2-09e7b40f002c@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IrVDbH9LoaPONBFP"
Content-Disposition: inline
In-Reply-To: <20250828-k1-i2s-v2-2-09e7b40f002c@linux.spacemit.com>
X-Cookie: Filmed before a live audience.


--IrVDbH9LoaPONBFP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2025 at 11:37:33AM +0800, Troy Mitchell wrote:

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_DSP_A:
> +	case SND_SOC_DAIFMT_DSP_B:
> +		cpu_dai->driver->playback.channels_min = 1;
> +		cpu_dai->driver->playback.channels_max = 1;

> +	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_DSP_A)
> +		sspsp_val |= SSPSP_FSRT;

It's weird and confusing that this isn't part of the above switch case.

> +static void spacemit_i2s_remove(struct platform_device *pdev)
> +{
> +	/* resources auto-freed by devm_ */
> +}

If this can be empty remove it.

--IrVDbH9LoaPONBFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiwG5IACgkQJNaLcl1U
h9DEBwf8CjgP9iYOM59KBwLN1PBvfkTbqxuShgQ2esRqY3g9E+E0u4gOerkNFSIf
iplSbs8EnqnWhR0vLEu5R21t7bGFDO+kduLEd0RUAMteul7WigeidWdcYDUw7nw1
CsTv7yQi2IohE/ZX+ONm4Ym7X/78WJ1VsOQH6w6VHQjLKkSBHsrEgOPsjbIjfXUM
tDicL8Jqpi+fhWKxLtcUxnY3XTlcBqKVFXp/aJ4knGZfziOm8Lsw4vx3sayqy+Zf
qW6eGt67WEmVwjubXse+QXmS+qLJva9q4ryigYX6FG3g1F/H15oprXtRvBkSA+SZ
4Zp2HphxLUx8ofFWI1+JaROSETbkUw==
=UqWf
-----END PGP SIGNATURE-----

--IrVDbH9LoaPONBFP--

