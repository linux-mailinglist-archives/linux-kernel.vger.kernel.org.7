Return-Path: <linux-kernel+bounces-670184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC1ACAA50
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 10:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E066717718F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 08:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E941C5499;
	Mon,  2 Jun 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n49JKo/3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6C54763;
	Mon,  2 Jun 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748851243; cv=none; b=DNFWr9ehSuCtkKVoFTSHx2gpqX220a/O8fdIS5W1r2LIlFinWEKkG1WlXtyvnFzy6JCj0LwrAK46Nfzhg7VJzhNf8wEAeUEBonDchRZMQGaZUeV9aqKH4eep9UHYah4WBmhpHtuNiZJDWyfFJGcQmwrjNoiqDMyfaGyXJpNAOBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748851243; c=relaxed/simple;
	bh=37ye/eSIVajhgIxL7yVeCYHQXe4eGw/GyWJRdlDwrbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQU5oe2BSQUG0Hhra5hPfVU6XyOkxdkPESxsIUm0Rf6xXENRNuggtaPPO16T2WewOSpdLuDH+SPzBgum4QlSq1SkFhFS2OCWL+CELjPaSMcF8yjKRmeuinsBEp8xN0FSt53ilxohIW63bYX3uimWDMY5PCqISTRFX4AfVVt51+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n49JKo/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686C4C4CEEB;
	Mon,  2 Jun 2025 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748851243;
	bh=37ye/eSIVajhgIxL7yVeCYHQXe4eGw/GyWJRdlDwrbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n49JKo/3sLrucLQwr2GfSd1RZFVrBqEyhxjft52ouIAH1y/yU2ziEu67mQ7qeWPH3
	 hP9QPmpdZl1dreknxp7xgimzfTcaP+nT3YIo6rU+Z/doHcKvjlvyzFBCTRxrO9YDQ9
	 RqaOYxXLS7jtaLRKwejl2o5fQWikWUljy2aDEY4wTz4cvjBU5DwWRraYTIOTqGItMk
	 DHhGIB6tQKbB8jVK1Njuu8SAJ83hk1O0meStJ6CPYhQPDSK2azUXziHptNYAd8X/hI
	 MiVGRqsHBcfUJY1Lw2rWavpu3xIBLljrOcbwTAi+EKGv/e52teOeSQvgsiD2703DMI
	 +lP0i39yPxAsA==
Date: Mon, 2 Jun 2025 10:00:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: adi,axi-pwmgen: fix clocks
Message-ID: <20250602-glorious-horned-beluga-f396da@kuoka>
References: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>
 <20250529-pwm-axi-pwmgen-add-external-clock-v3-2-5d8809a7da91@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529-pwm-axi-pwmgen-add-external-clock-v3-2-5d8809a7da91@baylibre.com>

On Thu, May 29, 2025 at 11:53:19AM GMT, David Lechner wrote:
> Fix a shortcoming in the bindings that doesn't allow for a separate
> external clock.
> 
> The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
> the use of an external clock for the PWM output separate from the AXI
> clock that runs the peripheral.
> 
> This was missed in the original bindings and so users were writing dts
> files where the one and only clock specified would be the external
> clock, if there was one, incorrectly missing the separate AXI clock.
> 
> The correct bindings are that the AXI clock is always required and the
> external clock is optional (must be given only when HDL compile option
> ASYNC_CLK_EN=1).
> 
> Cc: stable@vger.kernel.org
> Fixes: 1edf2c2a2841 ("dt-bindings: pwm: Add AXI PWM generator")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


