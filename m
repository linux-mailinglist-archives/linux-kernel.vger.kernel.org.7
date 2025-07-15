Return-Path: <linux-kernel+bounces-731427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ECFB05416
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E511C21A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BEF2741B7;
	Tue, 15 Jul 2025 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlfCgMPl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349A27381A;
	Tue, 15 Jul 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566783; cv=none; b=P9/vCTKPdQFZDr5DOtqz2WcQTyM0jPXLbkjIFO12FSzmPas7hhy0bDwt051uMgFQXcKUqT2FFpl9MbeUoPcsuAigaealUy5tpR183SPgeVpIn6uk/cTTj2GXlki7O8tykovB6QWEWbjVzubvdCHGSgQz5nJ9pNjzPH+/MSVdnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566783; c=relaxed/simple;
	bh=IdD1fLvIqtuuHLiO8uhclVEZklj1JJ7FrDLnTE9qxs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUopwI5LguJ2pxLzoLRiukWK2zuGMSylQ714zErz5ajGe78fTHUyJ9U0KQc4KvnOAtegmsyjsJUUKpaNKF7yJmUIA5xfgZeXiQN7mKPuQIKulpbwZ/ig3wkRHarIjHr/47u/7gDECcK0WzCvds9uWvYGzfvvTvDKVHi+xT0mF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlfCgMPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47F5C4CEE3;
	Tue, 15 Jul 2025 08:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752566783;
	bh=IdD1fLvIqtuuHLiO8uhclVEZklj1JJ7FrDLnTE9qxs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlfCgMPlbkLuG4W/GWe3TWZK2HD1gZCh35btsGlcMdQjvsRLuUp+S+O0gKanp+sMW
	 MY0M1CW4FAQa8gvnFXfS/WGoE12srQ2rPtA+R9U+dnGskfxNskqD52yXnj5d3AfWuo
	 U9aJVOhn6Oy4YVi3V5acXTzdUdL8pVA0Q7N271BZm+Yhl43mheqYT5fjeKHfHUF/dY
	 WI1zNqRrUSPM0lDrMCXuXfKhE4w77jMLrr/9jPhIwMzh5aXXRx0/Wa4UhQ6+0tyjt6
	 aoE5S4sAk7EFzq5eJWmgGQmYGwdWAsu8dYPqvbDW6BxoVF+D3hOQIAD4oR1w1K95Bk
	 HgZtxQuulfHHw==
Date: Tue, 15 Jul 2025 10:06:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Yao <richard@scandent.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Akshay Athalye <akshay@scandent.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: ilitek-ili9881c: Add Tianxianwei
 TWX700100S0 support
Message-ID: <20250715-daft-armadillo-of-luxury-4f5d6d@krzk-bin>
References: <20250714221804.25691-1-richard@scandent.com>
 <20250714221804.25691-3-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714221804.25691-3-richard@scandent.com>

On Mon, Jul 14, 2025 at 06:18:00PM -0400, Richard Yao wrote:
> Document the compatible value for Tianxianwei TWX700100S0 panel.
> 
> Signed-off-by: Richard Yao <richard@scandent.com>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
>  1 file changed, 1 insertion(+)
>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


