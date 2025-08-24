Return-Path: <linux-kernel+bounces-783532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2904FB32EB8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052B01B62F2B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201E22D795;
	Sun, 24 Aug 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stF7yeXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC881EB5D6;
	Sun, 24 Aug 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027273; cv=none; b=Wc8hBO9PigmEuOwy+E0WuWZRv3CZjo1u4GeWj6wF6P2M7Mq6UzLOHZ3tB1mgkmQPzwdzNOmIOwykPsYeCqPfEw2kRDn7rSvPIRDrqFkwzoalWL6oErTrc/uykxNaJiMRLDjzLiN9toyJ5pNLp6jLrs9I2TmWTU0DMCbL1djkhN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027273; c=relaxed/simple;
	bh=TePubqI9AcNR0qwMPahOp4rbJX0w3i3fs/cTg7AxDBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw43qh0nuvZrrzOj+1oxoHoBmW/GeDdWoFCMk1iR1AAmqhfr21HEjZ6w5/3ePMbESUQVctCzrmMF/ZW4EiCZg7WIFdm1fT5254VF7xe1t8llAUYgpcbaE0KrjLc7G2C6tIDBf7p7jJcoPkxylWMQpCf7QkUlYc05Rq77ewAp/6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stF7yeXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA99C4CEEB;
	Sun, 24 Aug 2025 09:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756027273;
	bh=TePubqI9AcNR0qwMPahOp4rbJX0w3i3fs/cTg7AxDBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stF7yeXZ5mOGTtkj4CiErJFbaGQkPc6jD4ShIx/+320L7sJ+H9Z3hJUFPA8Sc/TGN
	 bIsal3EESgk6YXHGWDGTU8Jy+zONb2NYcE8exzsll9WFvkJuYB+IKGkly+k08dlIZs
	 7AFKxJ2spcI6mgUuo+TllH6K/847OR/WkpXvv5Rnb3KIZgPZ/HFLiPqiKdlREArlzM
	 NcwjGukxzx8o7mC1hffG+cF9sHwu+97j8lKO+Yum/MqOvjcBeLjgpSY2vJjYEZGDGf
	 5PJrptVmXakzz+3HboG8ntIaKWvWHM0BqrbzleAvHW/iZ9Jnh1A85s+iw+6j7xk9st
	 lRo+aDUnlN/3Q==
Date: Sun, 24 Aug 2025 11:21:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/13] dt-bindings: display: st: add two new
 compatibles to LTDC device
Message-ID: <20250824-stimulating-herring-of-romance-df21ea@kuoka>
References: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
 <20250822-drm-misc-next-v5-1-9c825e28f733@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822-drm-misc-next-v5-1-9c825e28f733@foss.st.com>

On Fri, Aug 22, 2025 at 04:34:10PM +0200, Raphael Gallais-Pou wrote:
> The new STMicroelectronics SoC features a display controller similar to
> the one used in previous SoCs.  Because there is additional registers,
> and different mandatory clocks it is incompatible with existing IPs.  On
> STM32MP251, the device only needs two clocks while on STM32MP255 it
> needs four.
> 
> Add the new names to the list of compatible string and handle each
> quirks accordingly.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  .../devicetree/bindings/display/st,stm32-ltdc.yaml | 52 +++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


