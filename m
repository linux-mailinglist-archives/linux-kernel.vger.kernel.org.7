Return-Path: <linux-kernel+bounces-721179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91946AFC5D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405563A9233
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881722BE7A6;
	Tue,  8 Jul 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RccMEPDR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F72BE053;
	Tue,  8 Jul 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963729; cv=none; b=ZwwImkRnS2MK/YDRBpZq16cIiJP8g6pj9HNOW0ZpQ5glnEaODn1AdKB7a9hWtel3rkaWZi7gaC+utjRUlK9X5FsGxnqXDj3s2yhbbgYALlJDvrSg55DdZA8h2iZyZXH/if4bLvHfuW4kCnuJSnA6plVwFMsCLHG3nWrNPQOBTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963729; c=relaxed/simple;
	bh=zaiKQlWEdrcffQVeIreYh3y190tWcHJleeTNcRNgNAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dsx2WUUIsfCwmBYgkWJ8h2pXPyRNtXbqfCP6m2t2DdFvtC1tNHdKvyHjgnvownBj54SbSdgIcOigG/+43Pz6ozVy3H5E85EpK0j/hsVjOlqPIREDEnh6Avg+IOPyunOmjuKz/xe4AcQ+vD9rltDX1rq89S2bEuiZTn7Mmva0w10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RccMEPDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C8EC4CEF0;
	Tue,  8 Jul 2025 08:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751963728;
	bh=zaiKQlWEdrcffQVeIreYh3y190tWcHJleeTNcRNgNAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RccMEPDRS7gbem7CDc3prPbkm1sAP+E+zjNzqp+9hWDqxnu3P/4/TeFD9DuTyprbr
	 skhoMNVUzPx18ofPCZZDuxOSzam6iFFm7aQsg7uhE5ixrOJxvlz/zCO3474lHXp+vG
	 Qd/ndwCqbNcuztl5CwnMdxozs+GfC44WYQlx3Ui7EEYhylX6Ro8RlzURtoiLGdQTSa
	 r6inRgKx5iYt7peQnYrMM+p/cIR9rBBF1moNSUfEW4sDyEsNo0I+Oqit4iz1+mTDrl
	 PLw6X+fihSY+W3W0gsJn6ToxjS9TO/RhJ90zmI4/mu00m3UKRQrVNYIfqfPpmp2mOt
	 ffa1m12pj+prA==
Date: Tue, 8 Jul 2025 10:35:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Taishi Shimizu <s.taishi14142@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 1/2] dt-bindings: arm: bcm: Add support for Buffalo
 WXR-1750DHP
Message-ID: <20250708-tall-roadrunner-of-tact-e6fb11@krzk-bin>
References: <20250625154315.114139-1-s.taishi14142@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625154315.114139-1-s.taishi14142@gmail.com>

On Thu, Jun 26, 2025 at 12:43:14AM +0900, Taishi Shimizu wrote:
> Add Buffalo WXR-1750DHP under BCM4708 based boards.
> 
> Signed-off-by: Taishi Shimizu <s.taishi14142@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof


