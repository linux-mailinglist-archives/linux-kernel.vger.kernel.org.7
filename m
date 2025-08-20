Return-Path: <linux-kernel+bounces-777128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEFCB2D5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0F37AAEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6B42D7818;
	Wed, 20 Aug 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOfMF2XK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB2286D55;
	Wed, 20 Aug 2025 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677365; cv=none; b=kpgvveU43kMwCBHGpCP548m8wTabsPIuOIV2HAnd5bt+KjH1ZX2i0tGK8bVKkMD9SxvyFaKoXdpmCgUOtmYN4FSSX3nyoB41EPbat2KjWOHdeTRFcLhkr4a9eJMVO3lU3RI/9sn0ib+0JIQAIOLQPen3fGskMrGmxM+HSotWTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677365; c=relaxed/simple;
	bh=VAzAJjUiSUbgkKmTprNwXqi/ADJs5TrO9JHx5kVkx+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IibvpphiXoLBRZctfF1vKUG74oi4vS6OJtGX6yade1/j3kex3J4Xd1qdqxbWkMl4EWJAVZ1sFdX9apQrdW9Yz1SB1wXb9EcLzPE4C05MbCxJO0QWmM/DMzN+5hgD88VbBSExTSyOPmyOrN6iFiqsM6SUgOcD5PxggiXDxcr/uD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOfMF2XK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A65C4CEEB;
	Wed, 20 Aug 2025 08:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677365;
	bh=VAzAJjUiSUbgkKmTprNwXqi/ADJs5TrO9JHx5kVkx+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOfMF2XKuFZ9r6EL8l2uZd7HA9goBHFWsgTRwXYqi/9aD1JkjH1+9nYdJhcNdF81F
	 /x21Oi3ERxVy8/ymXXrlZ+lLjoOPtlFcHPiE/Ku5CZnylZSt8bfD6nRSJab0HteLVJ
	 4vC7fWx0cZLX0oft0A+tZuQs7qCAeihz5+617N6dV52As+d/j6asfxC5H1gfEmdpDT
	 fZ0pCdW7aj1LfQkblAQ0R97PWE1rqasPnoXXidgELe0exyfLt2pFJLDQvHgMYDy0NY
	 097C3qB18uWPqp2dAhmO9b98jnyIoLl07bZZDNaUjPFvJQKzfzNl2mEvBV0BB9uW8z
	 MegMfa+DzfofQ==
Date: Wed, 20 Aug 2025 10:09:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] dt-bindings: soc: amlogic: Unify the compatible
 property for clk-measure
Message-ID: <20250820-shapeless-devout-pig-defdd7@kuoka>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
 <20250815-add-more-socs-to-support-clk_measure-v1-5-59f04ba67457@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-5-59f04ba67457@amlogic.com>

On Fri, Aug 15, 2025 at 04:37:31PM +0800, Chuan Liu wrote:
> The clk-measure IPs across Amlogic SoCs have minimal differences, so
> they can be managed with a unified compatible property.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  .../bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
> index 1c9d37eef5f0..a7927acde2fe 100644
> --- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
> @@ -15,15 +15,7 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - amlogic,meson-gx-clk-measure
> -      - amlogic,meson8-clk-measure
> -      - amlogic,meson8b-clk-measure
> -      - amlogic,meson-axg-clk-measure
> -      - amlogic,meson-g12a-clk-measure
> -      - amlogic,meson-sm1-clk-measure
> -      - amlogic,c3-clk-measure
> -      - amlogic,s4-clk-measure
> +    const: amlogic,clk-measure

Obviously NAK, cannot stress more how wrong your approach is. It defies
all rules for writing bindings.

Best regards,
Krzysztof


