Return-Path: <linux-kernel+bounces-751412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FBFB1694C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66305431F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BAA236A9F;
	Wed, 30 Jul 2025 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL3DwcDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2C22F740;
	Wed, 30 Jul 2025 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918582; cv=none; b=YsK6tiBY+7UTA0hc4W5IjuiHwkmMA1kj6SSfrVOD7VV23RCrGy2meFQ1JA2wGKNUmcqT0t0IgpnTMylSVtV5g6Yoijm4dbWGeiPySIW9rBsLxqRjkrLW1QkWEgmWXAQUCt/LNBifKns2W1zJRBOz9604CJaAGEX83xx6ZNqA8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918582; c=relaxed/simple;
	bh=6YQIU/lmQnqs+hO7FAUhkrDi3ln14Ox3mYp8GHVqDHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+nRfxw2UtaQ36BMrJ2cWQ2ay0ZGMCra6h39pvnLQ5lfId7KrDxlYuooRyCsUp6v16ryiB+Duvfc1fbHzDg8UQIOkoPrs0VuWdE9DOpzgQaAwjqaalbjhvLMsJkr21Kgg5889RzYTI+XzQoDoCM3ZYUG4Ym44E4I70MWqGBrPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL3DwcDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F41AC4CEE3;
	Wed, 30 Jul 2025 23:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753918579;
	bh=6YQIU/lmQnqs+hO7FAUhkrDi3ln14Ox3mYp8GHVqDHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iL3DwcDUUFW9OTHcE8FPXycCBZHI+d2dR2+M2ANRoUZXq3Ip308NKOHom/duduZN8
	 4FtWIPUqNSa4KWriyNtN0blfhw4InCY5FpLK5f2er3Mb3tE/FjSY/wpRtQMN/lnMSq
	 lWwmzomwVVJxz10H1IYQ2xps9dk5URcMmbdOtyVKeBYLw6VsH78C3Sye6r5YIQ4Sny
	 lWCSzG98udoYirG3sqkmEncZpheGVuzAFhmlNtWCzGHCvP+mVtQnnf0VYnzsh/mdk3
	 K8qR0q8z8OnNkxezaALPehdxq4C18QYl1mH8Jn77qwNtwLm1Ml47uGvnxx9eMG8UkG
	 Z0ahH5NToDlkA==
Date: Wed, 30 Jul 2025 18:36:18 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, S32@nxp.com, linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 19/20] dt: bindings: fsl,vf610-pit: Add compatible for
 s32g2 and s32g3
Message-ID: <20250730233547.GA1887794-robh@kernel.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-20-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730082725.183133-20-daniel.lezcano@linaro.org>

On Wed, Jul 30, 2025 at 10:27:21AM +0200, Daniel Lezcano wrote:
> The Vybrid Family is a NXP (formerly Freescale) platform having a
> Programmable Interrupt Timer (PIT). This timer is an IP found also on
> the NXP Automotive platform S32G2 and S32G3.
> 
> Add the compatible for those platforms to describe the timer.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../devicetree/bindings/timer/fsl,vf610-pit.yaml          | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
> index bee2c35bd0e2..2aac63a58bfd 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
> @@ -15,8 +15,12 @@ description:
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,vf610-pit
> +    oneOf:
> +      - const: fsl,vf610-pit
> +      - const: nxp,s32g2-pit

These 2 can be a single enum. Otherwise,

Acked-by: Rob Herring (Arm) <robh@kernel.org>

> +      - items:
> +          - const: nxp,s32g3-pit
> +          - const: nxp,s32g2-pit
>  
>    reg:
>      maxItems: 1
> -- 
> 2.43.0
> 

