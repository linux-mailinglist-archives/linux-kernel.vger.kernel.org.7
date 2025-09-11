Return-Path: <linux-kernel+bounces-811519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D40B52A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D95FF7B75F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C4274669;
	Thu, 11 Sep 2025 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdFoh5fa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513B2749F1;
	Thu, 11 Sep 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576311; cv=none; b=DjU20eZLkcNFcsSWogOBASK1CUmZZl27n1WrXuDG+2BTM4JXlPBS+1W0/rHb0EJF14TxbTCPp0ez//0Jc+njT/f9Pj8OuF2C3mxV+nEMtH4Xcrb6s9vYuKM3moBEpKPnJXUdwTKdQ1GyLh7lT8t+N4XW4kNB5uysULB29lF/KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576311; c=relaxed/simple;
	bh=mSxMMdqTf8YS4+vsh6ryR3ge1CJqW+qi0gYEJZlf6JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPfc5NisjwUXkaCFiZfG++CTGXxgJHMrn4OcTMONWEsQinQmipMe8R68SdR6pCAHMH30lSNb3oITq8bC/5eryrgILw+ICut2CQz6YUkpNoHEz4NkKwHu5E9qBVSHvNhe78/AtxYrzXXV9AvlEs8KyZyy3wX0p1OtVr/6HQavC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdFoh5fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808EBC4CEF9;
	Thu, 11 Sep 2025 07:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757576311;
	bh=mSxMMdqTf8YS4+vsh6ryR3ge1CJqW+qi0gYEJZlf6JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdFoh5faaFsq4HFYDUKQh3sNE0HpbDS/Plp2/xCYr4NS5ksIPSrzKQ3GR2vvJBQwU
	 qFaWIaW9c4eslG+cvZJHxg1jBZOkZ6M3FG2HVLAYwS2bSigmmLkGgztg36O7PYYcq8
	 8KxKyDBkbhoD2NwljnmYAM2lzpDPpC/Ki+JfGblufzi3pe/TnX6IFxgkSyfCPUMmu8
	 1Fp5AeC7/ycn1rBKD4vN5rFoTkPH+Kc+h7V+Mhwe3sTyBA92LBF5Ste/lwsK/pjfHT
	 8yso801+zoBdYfuIZmRSbihIIzf72vq5dtevE6RhBIqMy9+CInKzmVkbtRXuO6hMib
	 QX9nEHq6o3WFQ==
Date: Thu, 11 Sep 2025 09:38:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: ti,pcm1754: add binding
 documentation
Message-ID: <20250911-whimsical-speedy-pigeon-b85014@kuoka>
References: <20250910-v6-12-topic-pcm1754-v2-0-0917dbe73c65@pengutronix.de>
 <20250910-v6-12-topic-pcm1754-v2-1-0917dbe73c65@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910-v6-12-topic-pcm1754-v2-1-0917dbe73c65@pengutronix.de>

On Wed, Sep 10, 2025 at 11:34:05AM +0200, Stefan Kerkmann wrote:
> +  vcc-supply: true
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  format-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO used to select the PCM format
> +
> +  mute-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO used to mute all outputs
> +
> +required:
> +  - compatible
> +  - '#sound-dai-cells'
> +  - vcc-supply

If there is going to be a new version then:

Keep same order as in properties, so supply before cells.

> +
> +additionalProperties: false

and this should be probably unevaluatedProperties: false.

Regardless,

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


