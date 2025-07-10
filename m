Return-Path: <linux-kernel+bounces-725402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84094AFFE91
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52FF5A240A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D052D542E;
	Thu, 10 Jul 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtfYXZKl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221EE2D4B79;
	Thu, 10 Jul 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141439; cv=none; b=ilHZguzAU5GqCCp+kPWTVUk6v1IIiI+WLn05fffOYlA2VRe44xEzo7pUVIaJCeTL4fLLvqu7OcEP3cZcllstK7YVr/D+LWvROOO374gHi5OSp5YRU2u1wPeOo4BWlFMdVN49WwhGXKRNG7rcPSiBrc3JHr9zTSqDOF+OWKccPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141439; c=relaxed/simple;
	bh=9rh3mqspQCTsXhgwbiE5vJ7eGHXCNC61azHoKSXtp14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkXzYnHQrlCEPP31l6YPjZudL9Vk/j24tj/aYJ0Yv0PcT7ReBmLsKxqcYbg6ihu9ZhLF/L28Hs615cZ9d2vDFWAk3jnb3HwyVz/ez1ILweyieUuLb4z5/NUegHfZPEDZ1LlLGckwQ2eWX+c8n1pWhVqvKAPPD6d22rQN3atKM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtfYXZKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D235C4CEE3;
	Thu, 10 Jul 2025 09:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141438;
	bh=9rh3mqspQCTsXhgwbiE5vJ7eGHXCNC61azHoKSXtp14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtfYXZKl0VxbWk6w2YruIrmkPSGk7JkSk9/yJKZxBvo2TKSiLl7v6RMqj8YSqJHTq
	 6KcMglmXZKYtXeiETovgoMQWBW4ahLWBHO3GBFC14rnAl2171vRm5mRG5gGRqMuivL
	 xibpg3g5fvZaNFwy7VvyxAb/taNBdMDdMgSlv1Ojx1TBm4L0dCvrnfKSrvjNJI2KOu
	 buy6+04t4Hu9G7F86+fWLbRx6t/Ox4z7wE0jDyV2QWMM5Xuo+7ohrEf5CyMHN+MsPD
	 rtOk3ZCIOk6fCoqIn/yv1v2W+j8z5UOK5oD3f+XrZ6vjVWPSgTEB2Fsty6zLw2It80
	 rOUGnEUryBP0g==
Date: Thu, 10 Jul 2025 11:57:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: jiebing chen <jiebing.chen@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, jian.xu@amlogic.com, 
	shuai.li@amlogic.com, zhe.wang@amlogic.com
Subject: Re: [PATCH v5 3/6] dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
Message-ID: <20250710-fancy-righteous-elephant-aee5a6@krzk-bin>
References: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
 <20250710-audio_drvier-v5-3-d4155f1e7464@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710-audio_drvier-v5-3-d4155f1e7464@amlogic.com>

On Thu, Jul 10, 2025 at 11:35:39AM +0800, jiebing chen wrote:
> Add S4 SoC tocodec compatibility support.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Jiebing Chen <jiebing.chen@amlogic.com>
> ---
>  Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
> index 23f82bb89750898d20c866015bc2e1a4b0554846..ea669f4359bc81b0f45bc2105c832fc2b11d8441 100644
> --- a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
> +++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
> @@ -26,6 +26,7 @@ properties:
>        - items:
>            - enum:
>                - amlogic,sm1-toacodec
> +              - amlogic,s4-toacodec

Keep the list sorted.

>            - const: amlogic,g12a-toacodec
>  
>    reg:
> 
> -- 
> 2.43.0
> 

