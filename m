Return-Path: <linux-kernel+bounces-893128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E6C46968
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB92B3BFEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079BF30AD1F;
	Mon, 10 Nov 2025 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXBvDD/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555CD2EBB8C;
	Mon, 10 Nov 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777502; cv=none; b=bWdQSV1ln6t/ZTY48WYaUXMqZVFy9xI8Wp3likOnLlBEHPBxfCoXqk8iWnRisUchbuSj7pdv/mKd0cjoH3V/7SNriyjE70x6zlHXA5km4zPx81CAWgcISCzf+mGQl0fkSIHNGTucUAEXUOn0rUKrB+oj5WFXD0t4dHAplqfBuPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777502; c=relaxed/simple;
	bh=NpY2AUK7VY2YVw/7RA2XeEy8IORez96b9m5ykP2PP/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyDP+mfqPAQRgt/7iHLtWntGyrKsvtKGkwgPnrmV2O7Lbqcm/lG/xpwWWiPqd4BMVGpHHGRdH/fzDg+VLFBw9E2/xcn9DFHUn2qzGtVL/QX+rjSTFJacK46smjQHiWgfm7Ojt8pglkjVY0kiBB3BksuMeC/uv4hUX90DXJ5HK44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXBvDD/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE2C19421;
	Mon, 10 Nov 2025 12:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762777502;
	bh=NpY2AUK7VY2YVw/7RA2XeEy8IORez96b9m5ykP2PP/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXBvDD/aZVkfwuX9K2/DMLirATxDvc4HlIZV1o0NPBYcxFeAJfG81bWW0Fwa7ce9K
	 inDbHKJ1tVDlE+Iq/VSTnnxUijQMHHRirHLWUurbWj5o59lZMJAzF7QRTvXf9DhUoV
	 YCwSZZDwdVUZaZ4vIPwXEOHsZuacJZzX1V3y8xKBcS7luFvC7Un1hgmablEeDaJWM0
	 PdhhJwElTPtCbSKTX2aiK8NAU/3YbZaKyNY6oWWYoIAzrjBiFYhEFmhrIvfTzQg7Bn
	 ncIszN6i1X4fztPA99vc5rnRadadGOLPqfZlq6rbws2vt7+Y68oBblyk1jzRcVjalx
	 z7dph5F8Esh9w==
Date: Mon, 10 Nov 2025 12:24:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Xu, Baojun" <baojun.xu@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Yi, Ken" <k-yi@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
	"Chen, Robin" <robinchen@ti.com>, "Wang, Will" <will-wang@ti.com>,
	"jim.shil@goertek.com" <jim.shil@goertek.com>,
	"toastcheng@google.com" <toastcheng@google.com>,
	"chinkaiting@google.com" <chinkaiting@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add
 TAS2568/5806M/5806MD/5830 support
Message-ID: <aRHZmMDW3UIydHZ-@finisterre.sirena.org.uk>
References: <20251108110759.2409-1-baojun.xu@ti.com>
 <20251108110759.2409-2-baojun.xu@ti.com>
 <20251109-heavenly-observant-quetzal-b1bead@kuoka>
 <ecc69a98a23d406ea1eada62144415fc@ti.com>
 <035d6c35-c27a-4f5c-8603-ea5857d78e63@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NyXJEyfyRbw6LOaj"
Content-Disposition: inline
In-Reply-To: <035d6c35-c27a-4f5c-8603-ea5857d78e63@kernel.org>
X-Cookie: You dialed 5483.


--NyXJEyfyRbw6LOaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2025 at 08:11:20AM +0100, Krzysztof Kozlowski wrote:
> On 10/11/2025 06:29, Xu, Baojun wrote:

> >> See also: https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst*L46__;Iw!!G3vK!SQ5aH9VZhZ2QzKdtYIs5BX7OarVmt1XzwB9XxqFgAGN0ONvsEoAjHsuoZWrrmetzH_xlxeSfWA$

> What's with this link?

Some e-mail systems rewrite incoming links to ensure that if anyone
clicks on them they get pushed through some checks for them being
malicious at the time they're being viewed, narrowing the window where
something nasty could be provided.

--NyXJEyfyRbw6LOaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkR2Y0ACgkQJNaLcl1U
h9DqpQf/S9mDPJpZUTDC7qPQhSAN8/2l8sGvL4j7tIMAbtdzThq6EQXA8C9rmBOM
mB4PtBgyh5jJO82gnV+dL3nqhircuP1ItiWkEMkzRZBHSlLPj5hTl29W7aNxH6Go
EQu/MvYJpvFzT8aNFVJG/eESSv6YHQGcs1JcO0mre0lonI1mVH745uKGpL83DtEU
nQ+o8n3ASEqW/sZlUGtyXIkm8K8FcptCVn2ZpMYnpWgG2WX5w8jMDM4aGfV+G6sv
MUABYoUYk6HvdTKo+xANHDmeFWQ+gDioxeCB2OHrQ7iDBP1r3oqYl77X2+/Zk6ba
ptBLzgHjTbYT8l0qmURI1a/eTLeQjw==
=y+xq
-----END PGP SIGNATURE-----

--NyXJEyfyRbw6LOaj--

