Return-Path: <linux-kernel+bounces-742046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B690EB0EC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082B01C2575F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCD8277C9F;
	Wed, 23 Jul 2025 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCsnbH7t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2D272E61;
	Wed, 23 Jul 2025 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257049; cv=none; b=CFJFs2w3oPJII/hE8BYMhYBRaF0kn4eWzAT3V9zKdIGsH4UTZhyt/n0h1oBhu4FkfdI8mOSr6ReGetJZuOEd+6uha5PcTNd+b7e5YWdxCjhx5+yHGMN+3fXwXcq9DIX5Lzfoc884D7+VNPJIPJE9eEIq6K7AUW5yLASI8yZxN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257049; c=relaxed/simple;
	bh=lzWaQkjxmsu7IqOdyc0IoMA9UA/T4fQw0xa0uVHdN5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYT6w+ULOIvt5EGOxAxtZD63aM09CVmpWxDAHTF23GN8cfw9BdYRphmY7QjCEt3OyvfHMzTKPbPRpdGr+NmaHvUXC2KM2F5+Tu6YulfQ3PUWMXTsIhJmdZHBc86w4L0aBVdzRGqqE0dbiYPsyoi1s5pdgHzwsq277ovBrlh01g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCsnbH7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4CFC4CEE7;
	Wed, 23 Jul 2025 07:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753257049;
	bh=lzWaQkjxmsu7IqOdyc0IoMA9UA/T4fQw0xa0uVHdN5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCsnbH7tkJ3fA55vcvIrc1x/s0cVkuZZziTsdAMGCMYQ5Sk9lsagAMWksGc5Q9Tch
	 dP1HwLwUoJ8PAJdxrnjzENeuYBIsVVtZagzBlgI2nTH7T3iES288jE0/dxHS/IKJN1
	 +mkCy+bF5zINWe1hL6Yh43/0NlQIoAxjhkJRun3/Ym3z/3qx2mzQDfzuI8IdPKumP0
	 qmCEGS1JGZbqiDjQYVmj5LmeYdZ4JHMXC90e+ybhn/9xCGcjNR6thy8any23F19YU2
	 SgP/HzoDKENFLbVQbb9UktkaZf9iNwJVBcyowZl/X/N1VdgT7T+qams/05fjiIiFHP
	 5WkKqTgMmRFFg==
Date: Wed, 23 Jul 2025 09:50:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] dt-bindings: display: sprd: adapt for UMS9230
 support
Message-ID: <20250723-eager-shark-of-fruition-e3237e@kuoka>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
 <20250722-ums9230-drm-v2-1-054276ec213d@abscue.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250722-ums9230-drm-v2-1-054276ec213d@abscue.de>

On Tue, Jul 22, 2025 at 04:41:03PM +0200, Otto Pfl=C3=BCger wrote:
> Add the compatible strings for the display controller found in the
> UMS9230 SoC and introduce more descriptive names for the clocks.
>=20
> Signed-off-by: Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
> ---
>  .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    | 24 +++++++++++++++-=
------
>  .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 15 ++++++++++----
>  2 files changed, 28 insertions(+), 11 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-=
dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.=
yaml
> index 8c52fa0ea5f8ee2149ebf1d4b0d5b052832e3d97..7f34652080b22e7b7072a709f=
d390a72375110ef 100644
> --- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
> @@ -16,7 +16,12 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: sprd,sharkl3-dpu
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sprd,ums9230-dpu
> +          - const: sprd,sharkl3-dpu
> +      - const: sprd,sharkl3-dpu
> =20
>    reg:
>      maxItems: 1
> @@ -28,9 +33,14 @@ properties:
>      maxItems: 2
> =20
>    clock-names:
> -    items:
> -      - const: clk_src_128m
> -      - const: clk_src_384m
> +    oneOf:
> +      - deprecated: true
> +        items:
> +          - const: clk_src_128m
> +          - const: clk_src_384m
> +      - items:
> +          - const: core
> +          - const: dpi

This should be rather a separate change with its own explanation. You
are affecting/changing existing binding and new device bringup should
usually not affect it. Same with second file.

Changes are fine, just split to clearly see the impact on existing
binding.

Best regards,
Krzysztof


