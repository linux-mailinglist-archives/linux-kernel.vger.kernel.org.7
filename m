Return-Path: <linux-kernel+bounces-864405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B461BFAB72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7D024E943B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3F2FE072;
	Wed, 22 Oct 2025 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEgsIC0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917D2F28F2;
	Wed, 22 Oct 2025 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119861; cv=none; b=F7cB0StrLCRppiJbbV1xvKAwvw0mH853K5ggZSZD9TREXHwpCvKoui2IcuQa1f3w7amYl9ZJ828zglxU64OdeNgMTKYcZ7N3Ndj6pmG+Em54tIdq725OPSEUgHFCNbOP47EVEWp8yySw9wjsN4wT2bcjio1O+LvX9VOgoYsThEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119861; c=relaxed/simple;
	bh=3ZD+uLg3U4eTWS54cwa/z6qXW4MaPy/85wVoaONKWEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXIF6+lh9N0+TQWgj2gOcDxFJorytwjXjvbfr2dNTVMzv5UGqoBLe+uKwAXDmP+dbVSY5S/gjpW2h5X4lyTfjrQ8ONCvP4mkcQdp/2KNPnDRDexChCrPZYyEUzSQYE/qBLJle/zOivv7pdsSiVYx8Zh1l76BlxxylltmmA7fwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEgsIC0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56978C4CEE7;
	Wed, 22 Oct 2025 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761119860;
	bh=3ZD+uLg3U4eTWS54cwa/z6qXW4MaPy/85wVoaONKWEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEgsIC0s1wDquXSSpNOwkpClJsI3ofRyAXf9+owslEz1qwKDYU5oSeUtncaC+8GHa
	 V9fSI3d+3plqzhyTPFow0TSs47UloPIQEyY4tFw9Cz1J25ehWkhtYuE19HR1Pf/5KI
	 AMWBevMA4G+lua7x67kr3dgyVvaikRjGP05xG/cVp9Fp4d7Vufw5uSmCxG834k+Di0
	 HnoX6hE4W+AU6cO7SuWndJ5odRifqth41IyG9KhU5RDO793fjfVKbnkkwD/BraGYwp
	 htWDQP38NGgyhsh+Si7VTdb+6KQCJm3GdxULTSyoys7eZuAKmOjqhRBSmdgbYomsmc
	 8F8D79QHGoNDQ==
Date: Wed, 22 Oct 2025 09:57:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Nikita Shubin <nikita.shubin@maquefel.me>, 
	Axel Lin <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: cirrus,cs4271: Document mclk clock
Message-ID: <20251022-aquatic-pigeon-of-masquerade-4c4369@kuoka>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
 <20251016130340.1442090-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016130340.1442090-3-herve.codina@bootlin.com>

On Thu, Oct 16, 2025 at 03:03:38PM +0200, Herve Codina wrote:
> The Cirrus CS4271 codec can use an external clock as an input Master
> Clock. When no crystal is used, the CS4271 component considers its MCLK
> pin as an input pin and expects the external clock connected to provide
> the Master Clock.
> 
> This clock is not documented in the binding.
> 
> Add the missing clock.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../devicetree/bindings/sound/cirrus,cs4271.yaml       | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


