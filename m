Return-Path: <linux-kernel+bounces-824572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE45B89916
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BC01C8510B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE08223DF1;
	Fri, 19 Sep 2025 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isxUgjz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329A14A60C;
	Fri, 19 Sep 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286946; cv=none; b=KalyWiNE9PmRtIv2gzm9+yBY0pbnkQjNoPAX9c7ixg4Bb1lmKZIdl5gemTFtgj/bgt0A0c/Eh8QIMBury1alYgBkJm07UX4F7+49Q6/ITl+FF7ExhlL54ihmelA58ua9a+zW0muRDDoJP2QqTJqA+5/v28HJbiVHzzLkppX6oTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286946; c=relaxed/simple;
	bh=JmYWc1I4g7/c/BVgQeuJjZRITvmaXXfhyjJQ2b5IC0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVrAcIGHQm6bnj9KFJEIH3FIVYVHzrPVGv9E/Oqmf679tbdgbNLvRZKbd+m8P7LpeMVuP0E/oYCzt+xRw5WU4j9qFyBwtrUm1WGx5muNh9AR1WrrZQ/xbdXiGyNXm/ggvHGm12Y3rNeUj7oOJgADtoMwIACBukeTpELphbCGvCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isxUgjz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02027C4CEF0;
	Fri, 19 Sep 2025 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758286946;
	bh=JmYWc1I4g7/c/BVgQeuJjZRITvmaXXfhyjJQ2b5IC0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isxUgjz3W/iiTQXV6suviEyO13BMaBiHl8/ACv+fHbiau5X2krjzzMubpU5J7c46z
	 1nA2uFjk5roqG3bC9dWMV+20Y2WdEiw/s0ssLnEW8hzmYgB0IPfF5pHqqqhdUdtHE7
	 Wjz/IJ+SK5PtouebFkGM5MS37N4qkr9cIiG5DNUkQ4tvnQr22hZgbf+LW7M20ZYtNu
	 nXTe2I8QyK0HBMcGVKLHLLHfnxPWSWWGS2zdaykctHiqU4loqRVbCyLke/ZZa1qiiC
	 X+ZpcfEcaT3aJQsr46ks0brFqDp07aQkN85TDTWx0S363x2nuR+0vxakSxBvqLa5dH
	 eNOo3vwEkA+AA==
Date: Fri, 19 Sep 2025 14:02:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [RFC PATCH 4/5] mfd: axp20x: Support tri-phase setup
Message-ID: <1c12bcf9-f9cd-4876-b589-e65e0605ef38@sirena.org.uk>
References: <20250919000020.16969-1-andre.przywara@arm.com>
 <20250919000020.16969-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bibf402iCqQCoieV"
Content-Disposition: inline
In-Reply-To: <20250919000020.16969-5-andre.przywara@arm.com>
X-Cookie: Don't read everything you believe.


--Bibf402iCqQCoieV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2025 at 01:00:19AM +0100, Andre Przywara wrote:
> Of the PMICs that support multi-phased regulators, all but one just
> support a dual-phase setup, with exactly two regulators tied together.
> This allows for a simple data model, since just two is somewhat of a
> special case.

Acked-by: Mark Brown <broonie@kernel.org>

--Bibf402iCqQCoieV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjNVFsACgkQJNaLcl1U
h9CDbwf8C3Z88WScvhWLa/erMfENML0aMwtvD8ri1qnnWlaFEQPD7mRzR4uA0wML
giyGHIUr1UEiWRpm5WGs6eKUUk6pO5K9h8z33zR5FwseUv/kYVjLfb/z/6Gt6TZz
IqS2f4/MId5TX5iSh0AcEHyJp3NiI9QxyZbhfeFSHVTxPELvU1N/Rk2j+/1SeZ4Z
3034bu4p3nAsnBkbppypGO+5WGdkibHH6yyaZ8hW+MmNKcX7x7k3crO3ZZnToVn+
GMsE/VFw6ZoUcHN8Vksc1ndKPRMzpy3XCVoXzLvOQTxM/GEtNYo1wHk4OKr5DhyR
lLmV7agd/Oeo9SSGA1ezwxQLtY9fsQ==
=G1tq
-----END PGP SIGNATURE-----

--Bibf402iCqQCoieV--

