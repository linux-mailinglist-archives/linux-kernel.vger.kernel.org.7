Return-Path: <linux-kernel+bounces-734667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ABEB0848F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488C93A8685
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A0205AA8;
	Thu, 17 Jul 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJv9PjuQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248B28E7;
	Thu, 17 Jul 2025 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732380; cv=none; b=EraplJTdkJ3PmPJF1Hoo36aqHvOJ7lk9a4ickKhR4QKMYq1VErXdO2t2eB8Kwebmb5pQIU+A3D8wJaGADCWFQdbqNO+yYr/DXPKoUTwRLyL+6hoHuDilUSj2kgOB9rLs0RPtlu1V8A6TTMenjQHHZHenZ8LOC8cU+2avXm8xRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732380; c=relaxed/simple;
	bh=aRmxuhY9GAZYFHxeCY4Tp5sAKwcjqyUUVaNe8cqXdQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/30id6XZvydZFMU2CEac0dALcahbANitSa6KKDWNejBjycbsZFSjb4V4cEzVusALIaylVOCM3hr2P8mV84Lx3XxFfV7vPijW15/xrBFN/8wwPunTxcCuysqRurZL7Ar1k6Eu80sbDkVW1I8gf8yQpo45Kg1QbB6p9WHePpOU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJv9PjuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EC7C4CEE3;
	Thu, 17 Jul 2025 06:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752732378;
	bh=aRmxuhY9GAZYFHxeCY4Tp5sAKwcjqyUUVaNe8cqXdQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJv9PjuQQKhcIFCprZLhdBWaKSP53HtIDzPb8pikdcw64kglRVhnuMOQ7JiHNX6W0
	 rNVfhSLsr0+dVE6SEBPJemnI3KtXbAMRwfmtu/PsL58Q5QRF+Ti+G63PiD4sQZewbU
	 nTrfDrn9d2Oh6PmMy81k/I8IJ3oyaTwiBT5EYZeT4tOvoXouZm/QBGxe3tFraKM6/r
	 xC+V/X2iaJyCjpbr/1dYS5bqNliB9p9svZ5MmjfD1VRpG73i8NHOZ4uBD8SXOv9I+g
	 1qahO3XxUgLLqA4JdrH+ngGQv9f9jV1FMQeQEC/VlSvxfh2GddHSZzy4gBoAMlvVyq
	 zFKbw6KL/7LHQ==
Date: Thu, 17 Jul 2025 08:06:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org, 
	Frank Li <frank.li@nxp.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
Message-ID: <20250717-expert-seahorse-from-neptune-78e5f9@kuoka>
References: <20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com>
 <20250716081519.3400158-4-laurentiu.palcu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716081519.3400158-4-laurentiu.palcu@oss.nxp.com>

On Wed, Jul 16, 2025 at 11:15:07AM +0300, Laurentiu Palcu wrote:
> i.MX94 has a single LVDS port and share similar LDB and LVDS control
> registers as i.MX8MP and i.MX93.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


