Return-Path: <linux-kernel+bounces-881867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BCBC291A7
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B565188BB58
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B783237A4F;
	Sun,  2 Nov 2025 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPaKt7qn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFC2264B1;
	Sun,  2 Nov 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099849; cv=none; b=d4hWXK4VkjR09c8lbmRaJ4X54XVUhu0GU6u2Ts2aUDHovt8DQrcQXmR1zWZIXxNvOO8ATJQGt0ncdyHP4sQAM6cYAjd7A7ozxmJdRrK2Mw46qFJt8lFf7KoEUqzaqAicc7rRtldN68feGoCEuRamFgw2ohA37/26nGQUcsyrifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099849; c=relaxed/simple;
	bh=Q5uOiGFBwk3XBId4Bp1DGvFrVgc4MnXX7kH5ZwqXv+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfrQUqVY+xHNoZyFCPfESQqFsWVosS7ZOxjxLNBWC/YyQGAw7CdKmk9KtDoYoR+EMuMkcSiLmQNp1tL10W42xHT456jnVxIWuFaB4w/DAkSfOCapeq0v+PbP5FCb40eAKS/R/WKLFqovNLtt0vdhSHp4p/V6FDyNHeamQLcWVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPaKt7qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B31C4CEF7;
	Sun,  2 Nov 2025 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762099848;
	bh=Q5uOiGFBwk3XBId4Bp1DGvFrVgc4MnXX7kH5ZwqXv+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPaKt7qnrYnsaHZcxynYNEe3HCOyTAQGBLtGbqBns06XLrHlq/dKPv3K63Vkkrhmb
	 PfXI6sE5vUV1aJCAbfKSk9bPnjn6O78TISepIUtEaBorNA2D2uO/dciE5t3xZGGPWd
	 PCftg5SQJBdDOV6NjSoo2VL7gZ6cZrM0spWar9vx7wjIX1sbAFv4iIDpQteNaOneU5
	 HHnPDht36dChRkbmz6XRR5B7/nqXd3+HzFNIUJ+ri8MFiCBv++qSzAUmLVzqu7hz53
	 ziqbJKGooFCIyR9+LcjljoC5MYZH9OhSzgBN7MDCSNM9UojOrsOT4QqVrVriyJsC+w
	 VX2A29fZMsIXQ==
Date: Sun, 2 Nov 2025 17:10:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v5] Asoc: dt_bindings: ti,pcm186x: convert to dtschema
Message-ID: <20251102-persimmon-earwig-of-sympathy-11dfee@kuoka>
References: <20251031-dtbs-v5-1-ee1dc0b2fa40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031-dtbs-v5-1-ee1dc0b2fa40@gmail.com>

On Fri, Oct 31, 2025 at 12:29:02PM +0530, Ranganath V N wrote:
> convert the Texas Instruments PCM186x Universal audio ADC bindings
> to DT schema.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Conor asked you to fix subject. You still did not implement the entire
fix. Please read the feedback with care.

It is never "dt_bindings".

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> ---
> Convert the Texas Instruments PCM186x audio ADC bindings to DT schema.
> ---
> Changes in v5:
> - Resolved previous patch warnings/errors
> - dtschema/dtc warnings/errors:
> - /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,pcm1862.yaml: 
> - $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
> - 	 $id: http://devicetree.org/schemas/sound/ti,pcm186x.yaml
> - 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,pcm1862.yaml
> - Link to v4: https://lore.kernel.org/r/20251030-dtbs-v4-1-3fff32221119@gmail.com
> 
> Changes in v4:
> - Corrected subject dt_bindings:sound to Asoc: dt_bindings:
> - Corrected the filename to match one of the compitables in the file 
> - ti,pcm186x.yaml to ti,pcm1862.yaml
> - Link to v3: https://lore.kernel.org/r/20251029-dtbs-v3-1-3cc162221c22@gmail.com
> 
> Changes in v3:
> - Unicode FEFF character was present in the begining of the file,
> - Removed unicode character.
> - Link to v2: https://lore.kernel.org/r/20251026-dtbs-v2-1-cd3b713a288e@gmail.com
> 
> Changes in v2:
> - Fixes as per the reviews suggested for the v1.
> - Link to v1: https://lore.kernel.org/r/20251021-dtbs-v1-1-493c1aa253bc@gmail.com
> ---
>  .../devicetree/bindings/sound/pcm186x.txt          | 42 ---------------
>  .../devicetree/bindings/sound/ti,pcm1862.yaml      | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 42 deletions(-)
> 

...

> +
> +maintainers:
> +  - Ranganath V N <vnranganath.20@gmail.com>

This means you actually care about this particular binding and hardware
and has some sort of access to datasheet or hardware. If this is true,
then it is fine.

> +
> +description:
> +  The Texas Instruments PCM186x family are multi-channel audio ADCs
> +  that support both I2C and SPI control interfaces, selected by
> +  pin strapping. These devices include on-chip programmable gain
> +  amplifiers and support differential or single-ended analog inputs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,pcm1862
> +      - ti,pcm1863
> +      - ti,pcm1864
> +      - ti,pcm1865
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply: true
> +
> +  dvdd-supply: true
> +
> +  iovdd-supply: true
> +
> +  '#sound-dai-cells':

This wasn't in the old binding and nothing in commit msg explains the
changes. You MUST document in commit msg ALL the changes you made during
conversion from the original binding. Otherwise you just add some sort
of properties and why would we accept such a change?

If this is DAI, then you miss ref to dai-common and use
unevaluatedProperties. See all other DAI bindings.

> +    const: 0

Best regards,
Krzysztof


