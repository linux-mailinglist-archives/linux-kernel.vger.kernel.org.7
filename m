Return-Path: <linux-kernel+bounces-723345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DDAFE603
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30D25856DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43D728DB66;
	Wed,  9 Jul 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eENXxyfq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159A258CC9;
	Wed,  9 Jul 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057636; cv=none; b=tGQPkmkZp5KSoLwSsU/ILRKB7o/Is+em0vRpFZGLPPSRESP/DkLg9nuBNsMmCDXjFNsu6DJFPsMpg4XcYwTfaJO96ZB+mgUNK8wIabbWo/QMvIqUW4f6B98TonKKhqm87RliZ2XJRHcel6D7JNOTvzBcJdR8+CqOpBgbPu/h9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057636; c=relaxed/simple;
	bh=5BXnFhOaIajj0YD05OOXe4uI6r5QquIlIbMJFoR86RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmqlVAlOKKbTrcV80EX/OoBBaKctIyKHXFcau1j6T5fyc+WNv3lz97eroy3zlTt+OnhZ86kxgUuW11Kdi9iF/iuUmEztsZ2Ym5KZImqr1bWUSvKsazqpsZeXu/O8UGEgS8brDJZXMYbKcXSH9y9//qpLFd/3X4aRD+HdmDHscf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eENXxyfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F95C4CEF6;
	Wed,  9 Jul 2025 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057636;
	bh=5BXnFhOaIajj0YD05OOXe4uI6r5QquIlIbMJFoR86RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eENXxyfqWG1t5TdEGUqbMerZAeSV9TIzGJozZBdIWWne0ST58kJDEoNYf/T0KpD57
	 RlMpjgCvMy2FPVwftG9KkRReV3QD0gCbAnC2duYDMqXamR59shzy3ufCJa32j9SgNJ
	 RPaUEgfUPXR9Wfukqz/SArshMUr03Jd2am4rQys35wxnifhHH669qgqkEMQle0lPMU
	 1G6Fxy8UrExSWQ5+jCYlMCTRriqdrhcqmchqq0lE1+Z1UjmQr7ccPjXw8cXEZN0+jh
	 uMVs0MArWFf6dHDuO2t4Wu4I7+V68az2Qazib2iHtwSSC23SUJ8ZHf9y+gPaztr3Ue
	 /Lqa5pPfWjJpw==
Date: Wed, 9 Jul 2025 12:40:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Li <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com, like.xy@foxmail.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: Add schema for FS2104/5S audio
 amplifiers
Message-ID: <20250709-invisible-frigatebird-of-felicity-7e87c4@krzk-bin>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-3-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708112901.25228-3-nick.li@foursemi.com>

On Tue, Jul 08, 2025 at 07:28:59PM +0800, Nick Li wrote:
> +description:
> +  The FS2104 is a 15W Inductor-Less, Stereo, Closed-Loop,
> +  Digital Input Class-D Power Amplifier with Enhanced Signal Processing.
> +  The FS2105S is a 30W Inductor-Less, Stereo, Closed-Loop,
> +  Digital Input Class-D Power Amplifier with Enhanced Signal Processing.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - foursemi,fs2104
> +          - const: foursemi,fs2105s
> +      - enum:
> +          - foursemi,fs2105s
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      I2C address of the device. Refer to datasheet for possible values

Now the description is entirely redundant, brings no value. Drop.

> +
> +  clocks:
> +    description: The clock of I2S BCLK

This was different... Previous code was correct, this is not correct.
And nothing in changelog explains this. Do not make random changes after
review.

> +
> +  clock-names:
> +    items:
> +      - const: bclk
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  pvdd-supply:
> +    description:
> +      Regulator for power supply(PVDD in datasheet).
> +
> +  dvdd-supply:
> +    description:
> +      Regulator for digital supply(DVDD in datasheet).
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      It's the SDZ pin in datasheet, the pin is active low,
> +      it will power down and reset the chip to shut down state.
> +
> +  firmware-name:
> +    maxItems: 1
> +    description: |
> +      The firmware(*.bin) contains:
> +      a. Register initialization settings
> +      b. DSP effect parameters
> +      c. Multi-scene sound effect configurations(optional)
> +      It's gernerated by FourSemi's tuning tool.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - firmware-name
> +  - '#sound-dai-cells'

Keep the same order as in list of properties. OTOH, missing supplies.

> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +unevaluatedProperties: false

Best regards,
Krzysztof


