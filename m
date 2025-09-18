Return-Path: <linux-kernel+bounces-768141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CBB25D87
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BD99E7464
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3836626C3A6;
	Thu, 14 Aug 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twxsBirt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CB2690F9;
	Thu, 14 Aug 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156547; cv=none; b=e2X1ru7xuRjAOznt5E//L7CCJtMmHVDQanQwuoAGVt7htmNCnq0WOvrNFwGiTtsDnML1wqGCX0diDY85MYKX+6Rqqe4GIQ7K11ol9cYEIy5+xTC2OjslG95uLyA0UyKfB3G1T9YwQyQP0JzOXL6kKUZTgM2HKHYqHKcWPGW8/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156547; c=relaxed/simple;
	bh=yFHZE0Fem6LY03lyJJsU+PZNFRS6Y/kss8PySXhjW9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4EoZ0AnXOMUt5BWcpw/r+JK2FlJQGBWoqWzjeKQ7N4uDdYS0otRhSxmuf1bzY4nuGp8BQFQKM8CK1bHZn2zvQgJRprOxa2Rah96pUxhcugY56glZ0wE0LlAurSQS+0GEW23NAt3gpv3LdFpvXsTahmlXijsrMcoOCLknoV5dQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twxsBirt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69186C4CEEF;
	Thu, 14 Aug 2025 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156547;
	bh=yFHZE0Fem6LY03lyJJsU+PZNFRS6Y/kss8PySXhjW9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twxsBirtdf1/fqUMGnjnp4W+W2EyaHiytp95UB5RLLzIBSMCZ+bU0ph8qSJcjOZk5
	 6+OZ1TC0mrpErUesb+58RtFxWpnrAsHEtLksdYn+oLVkjEe4q3I0koe+Lz2D2npIPU
	 ATtrdMR0/b/ljxnABqi/xE/mLsdVbWvJ1ASvsSHZQWlDJXopOo3PToPl1DMtXk09UE
	 tqBq2VoLmbv2HkAMM/XTgpmV1Ygiabsyn3hehtyTqpzFctcFFPbVrseZ/nF9XjzjaH
	 LavCdWPcnC3OpNneRPS5rAMFRL0TAm0TTHecn+aNZpwnbpSw8wlsKgPBlisvXTM+MB
	 qtSlCSmlMpWeQ==
Date: Thu, 14 Aug 2025 09:29:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] dt-bindings: iio: adc: ad7476: Add ROHM bd79105
Message-ID: <20250814-hilarious-nonchalant-bat-b205cf@kuoka>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
 <3f70f68665225be3091f8a0412e74037b6a2a88e.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f70f68665225be3091f8a0412e74037b6a2a88e.1754901948.git.mazziesaccount@gmail.com>

On Mon, Aug 11, 2025 at 11:52:04AM +0300, Matti Vaittinen wrote:
> The ROHM BD79105 is a simple, 16-bit, 1-channel ADC with a 'CONVSTART'
> pin used to start the ADC conversion. Other than the 'CONVSTART', there
> are 3 supply pins (one used as a reference), analog inputs, ground and
> communication pins. It's worth noting that the pin somewhat confusingly
> labeled as 'DIN', is a pin which should be used as a chip-select. The IC
> does not have any writable registers.
> 
> The device is designed so that the output pin can, in addition to
> outputting the data, be used as a 'data-ready'-IRQ. There are cases
> where the IRQ can't be used (because it is delivered via SPI data-line).
> Hence, some systems may use a GPIO for polling the data readiness.
> 
> Add a compatible for the bd79105 and add the data-ready GPIO to the
> binding.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


