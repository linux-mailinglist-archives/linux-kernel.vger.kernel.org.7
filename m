Return-Path: <linux-kernel+bounces-878277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52004C202B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F43AF28A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE916306B0D;
	Thu, 30 Oct 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stsLZFnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF402E9EA0;
	Thu, 30 Oct 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829586; cv=none; b=XPkTsJuVpRdpoejDHGDDb95OWAl/FJyrObIfFQfjJO59+p+vL/TYUJI2G5w5wKX+m7176cEnVSoCJX3zi7TUf9691C/K4FN0ncbxWHSWhl/P80ynleDATbaLlFL2qyTZZpSF8luBBnGTY/XoktEWf7tkXRtPs2iA6bW2bo4UZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829586; c=relaxed/simple;
	bh=Km12nL8qt3xEm3JrEGnnnbq5x4pUk4viwfLeDAB8Rpk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JayRLGxeXvRaTvX2VidOXnIJkiPsY1S1plAKMpoX4LdyF/9Phd24mFyD72UTJPkqHXtQBLMDC4JPx5HJmZsqBWQF7oZzL8FuNb3TrSC2AdLvwaants57R6rF00nZnN0yF+ya5IuIcNQYrS/Ec8ysEvoP28wB4/XQWEdgyvMh4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stsLZFnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AA5C4CEF1;
	Thu, 30 Oct 2025 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761829585;
	bh=Km12nL8qt3xEm3JrEGnnnbq5x4pUk4viwfLeDAB8Rpk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=stsLZFnS7+Fs54+KeR3medcbYbhv5FbyAjpvYu/4fnsjhtVXcEVBT2YtoTeXCRNKj
	 kBG4Ll5J8HVtN8S0AtuNWnL2GLLvpDfAE5e+ZvHCwsB05645s5Bce8XGnRjFVL8uhk
	 YWWsHaXisQ8vhca6EAPWa2xQGOop+CI4yhHXAD3UCGTsnchVRZEkqrjBVMrhGp69n2
	 /UCZTcp6D5x2A/Jl73xnKoCmngjdNG+qR6Bjm5Jlh505ZzqcpaF1lp1dMtB5Q15nVS
	 dcL8sKd0jXm5/L0Bsl3Ev8D7URROt3OE/4P8zbkJxlubA4ARYk4fQP89OhdLhYbgcz
	 Rj0WYxzuINB4g==
Date: Thu, 30 Oct 2025 08:06:20 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
 david.hunter.linux@gmail.com, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-sound@vger.kernel.org, 
 khalid@kernel.org, skhan@linuxfoundation.org
To: Ranganath V N <vnranganath.20@gmail.com>
In-Reply-To: <20251030-dtbs-v4-1-3fff32221119@gmail.com>
References: <20251030-dtbs-v4-1-3fff32221119@gmail.com>
Message-Id: <176182958078.3695318.10308804635048034182.robh@kernel.org>
Subject: Re: [PATCH v4] Asoc: dt_bindings: ti,pcm186x: convert to dtschema


On Thu, 30 Oct 2025 12:24:30 +0530, Ranganath V N wrote:
> convert the Texas Instruments PCM186x Universal audio ADC bindings
> to DT schema.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
> Convert the Texas Instruments PCM186x audio ADC bindings to DT schema.
> ---
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,pcm1862.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/sound/ti,pcm186x.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,pcm1862.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251030-dtbs-v4-1-3fff32221119@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


