Return-Path: <linux-kernel+bounces-742047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7BB0EC60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F50564C36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F867277C9A;
	Wed, 23 Jul 2025 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVEtdzHa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1686ADD;
	Wed, 23 Jul 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257070; cv=none; b=cQKWwh4ReobgyWv4RzOa1vTm4D+0YRN40VjN9qBo0fte3USqd8FcgcGOEI+pVaj6PgeBUiJRaX4HsT+gYlDx9z1C45hoIzWiMPLdKY8czfxufwdxbmQuGjEgAruz3qCTt+FGd9yNhog2ulQ3nIRPbaUkEtFEYTBpa3kp66Tw+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257070; c=relaxed/simple;
	bh=Q+DZzLQeXq9JXIC7GX8o7Zi0O1QtJSxeVxGbny17CiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfG6flPG0fHLe0Kc9Gd56SbKBEepYhXFzWS3szPyo4Op+ZbdbT4RBh+j1oxLToUR6LjkPLszjHHnYIUQRyksEQmA3bvyaNg/iRAKWUjglU3zZXQ8nfaEuTWQfDrDhZ8y1JAJpJdAu1xuHQrjBidihzETbdOjfUqWdhmAFS6qaGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVEtdzHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35FEC4CEE7;
	Wed, 23 Jul 2025 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753257070;
	bh=Q+DZzLQeXq9JXIC7GX8o7Zi0O1QtJSxeVxGbny17CiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVEtdzHa6vNWTBGZKer3PPPXvD5VZup9OSpAd1JD4c5bW5wCj6qCb5a07jVH4D5qP
	 YGGGpIoMsMSYFdjlvxpRwQ/ZCELSMWfp3C8EIgcaT280VjSosK5dz9omkNyXjAmIsf
	 aEQUJ3V0trc9yuderfBi25edGI3ZdWx+Ln4upGifkcH1na2JLIT4M1dV1Rbt9vXU9U
	 tg2LboijtSOvV1f3jeLjj+o0oBnDRZYDCdfoR2Fb/mE/osa5bMOG9DcpN2psqDKreu
	 x7OALIIPwT7j+QRtX+07PsRLa+SKLgcghZcnwCp8yAWHgqZAn08Nty2oVIP5qXcUEO
	 RkUkso6RYs9Rw==
Date: Wed, 23 Jul 2025 09:51:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] dt-bindings: display: sprd: add memory-region
 property
Message-ID: <20250723-resilient-prophetic-termite-be9f2e@kuoka>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
 <20250722-ums9230-drm-v2-2-054276ec213d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250722-ums9230-drm-v2-2-054276ec213d@abscue.de>

On Tue, Jul 22, 2025 at 04:41:04PM +0200, Otto Pfl=C3=BCger wrote:
> Explain that the DPU node supports a memory-region property that can be
> used to describe an initial framebuffer set up by the bootloader,
> usually in order to create a passthrough mapping for this framebuffer
> when the IOMMU is used.
>=20
> Signed-off-by: Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
> ---
>  .../devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml        | 8 ++=
++++++
>  1 file changed, 8 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


