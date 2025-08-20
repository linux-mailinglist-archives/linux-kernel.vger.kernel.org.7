Return-Path: <linux-kernel+bounces-777127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA3B2D5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67951B6325F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DB62D8370;
	Wed, 20 Aug 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l75ryk7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB541286D55;
	Wed, 20 Aug 2025 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677333; cv=none; b=XaZQOU+glMJETS0SvPhC2la/IOPKtNyHegyiRg4c9AMF7hJtIbQEQLwpBmJT9fGqoqd/OxR/HVf6SIn1rJNBGn9yQX8CxWYKatZwpF7sAy4x19a6yni37IWbLihf4IgUKf1N7wafFJoqhGKtyqFCQ2j10gmwNiuJWLGOekWhWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677333; c=relaxed/simple;
	bh=czkdxE5TB5R/9a6En1K+Wcou33QtXIlLqEcTWW6eYhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI8hygCY42F3AoTyBj+vdGn9SzpoGuQf8Hwb9xSAAE3yrmgbPnE1T6v4Y7EstSYaeieXMmwGRoG24rfL4TkWXX9FWER8FWNqf/feAWvXDwjbDoUrDHEO7lnlVZ5mv30AVOXMrou2OcwL4TA7Nw1HbVTDtqxVElanY1NpgKEDtPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l75ryk7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE166C113D0;
	Wed, 20 Aug 2025 08:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677333;
	bh=czkdxE5TB5R/9a6En1K+Wcou33QtXIlLqEcTWW6eYhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l75ryk7FJcY8fynfRbmLJ0xqNdDiqe1NKSK3eyPIx3uh04Y+WiWqvnUaH+RCPQe/K
	 KrmHnYKB6GYJyaAQdz/XmwhbT9PyfYVwMqvt9J5kyTnoHn1EUcrY1DWE4TalHL2VRc
	 GLN2VdVwy93bf2IAQNJCexlrTUQIpCMXA8iFJK8NeeuzOn8VSxNejZIt/6LoOMhopk
	 dNj+Ork5Y2pVAn1RSnW7vFdVJkhZQLBF1LSCrd8Hje4F4SUaj3K9rZ6H8/RIyiCfQk
	 5IBxCNUNKqCdciHp8VC+cAVAhNY+TgUHoZ9VoeUQqh4GzyULVYUSEGjgx6ySt9k3SP
	 A9y6GW7r5Q3dg==
Date: Wed, 20 Aug 2025 10:08:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] dt-bindings: soc: amlogic: Add clk-measure related
 properties
Message-ID: <20250820-robust-didactic-panda-d374be@kuoka>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
 <20250815-add-more-socs-to-support-clk_measure-v1-1-59f04ba67457@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-1-59f04ba67457@amlogic.com>

On Fri, Aug 15, 2025 at 04:37:27PM +0800, Chuan Liu wrote:
> Add three properties to clk-measure: 'clkmsr-indices', 'clkmsr-names',
> and 'clkmsr-reg-v2' for describing measurable channels and register
> offsets in DT.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  .../soc/amlogic/amlogic,meson-gx-clk-measure.yaml  | 54 +++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
> index 39d4637c2d08..1c9d37eef5f0 100644
> --- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
> @@ -6,7 +6,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Amlogic Internal Clock Measurer
>  
> -description:
> +description: |

Why?

>    The Amlogic SoCs contains an IP to measure the internal clocks.
>    The precision is multiple of MHz, useful to debug the clock states.
>  
> @@ -28,15 +28,67 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clkmsr-indices:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |

Why | ?

> +      Supported channel IDs for clk-measure.
> +    minItems: 1
> +    maxItems: 256

Nothing - neither this nor commit msg - explains why you need it and
what this is.

> +
> +  clkmsr-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: |
> +      The channel ID names supported by clk-measure correspond one-to-one with
> +      the IDs specified in 'clkmsr-indices'.
> +
> +      Therefore, the defined 'clkmsr-indices' and 'clkmsr-names' must have
> +      matching counts and maintain strict correspondence.
> +    minItems: 1
> +    maxItems: 256
> +
> +  clkmsr-reg-v2:
> +    type: boolean
> +    description: |
> +      Specify whether the register address offset for clk-measure corresponds
> +      to version V2.

No, compatible defines this.

> +
>  required:
>    - compatible
>    - reg
> +  - clkmsr-indices
> +  - clkmsr-names

That's ABI break. Again, nothing explains it.

Best regards,
Krzysztof


