Return-Path: <linux-kernel+bounces-813324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECE1B5438E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28313B6982
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8742BD012;
	Fri, 12 Sep 2025 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPfvSSjs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAA29C327;
	Fri, 12 Sep 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661057; cv=none; b=F0IQKxyhO1gR7/JQwAdfF9BKjK3bvxLh0qWf77pe8zaXwS4Q+Ra6TS1iG0kTEXIfvIHWn+8iY9r/A4RXVcZsPZoXwWwHsyl940Sawti06nHxRmTlxsgbdJ017CqauxsJHLH0pWvmxXyc+XwL9bfEbI8y9E6Md7lrs8HcVpfeac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661057; c=relaxed/simple;
	bh=kH1ZM5L4t7BfvEeteK0MeurL3A2A3KfYQStVeT0e7fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLZjY4QhdVSUOwSVdr+Wl3YE3eEXASZekCVn+m+FdATVwkZZc3FCc6sfYIR/bChXwQ7pAFNgdsXFNUV72Z5C63GTPrErTkLUQSQ9elLrOqkTSJoiKBkChnl3WGbLT76bi/pcSeJrtUyYigoYyYWle71tAZxDyKA4vLTyumsaKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPfvSSjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06063C4CEF4;
	Fri, 12 Sep 2025 07:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757661056;
	bh=kH1ZM5L4t7BfvEeteK0MeurL3A2A3KfYQStVeT0e7fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPfvSSjsZrLz0w+4+qKCW/w0uxxDtpAr5FGV9S+UJferb4XSoBgysLuh9LNPiHll8
	 aKeTJNbroC7g6vje85A/9un+W1ka6y66ClNuJUALbjCO2JqFVTZ2r2N1C3mh60dgu9
	 tJNxl/dNFJiDhVEzn4Xe+gIQRDPiJsZKiHqiag0WQ1VQ829A+xagoCahWf6t6+T/v3
	 H3ppT2q2MElm6rKl9VEogHoDIb7HB2dbvuHFXsQNVZ5Y2d/1MvvkN4YnnOSrYPJLWv
	 c9FK9clfLleg6DSR0/uRoOES+6hM7iz1yiPjPbZMx/MipFc/P/AvMV/xibbLACvYuS
	 /42U14aQ1xWnA==
Date: Fri, 12 Sep 2025 09:10:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb
 child node
Message-ID: <20250912-flawless-ruddy-mushroom-83bd39@kuoka>
References: <20250911-dcif-upstreaming-v5-0-a1e8dab8ae40@oss.nxp.com>
 <20250911-dcif-upstreaming-v5-6-a1e8dab8ae40@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911-dcif-upstreaming-v5-6-a1e8dab8ae40@oss.nxp.com>

On Thu, Sep 11, 2025 at 02:37:06PM +0300, Laurentiu Palcu wrote:
> Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> LVDS Display Bridge controllers, add 'ldb' child node to handle
> these use cases.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index 27403b4c52d6219d31649d75539af93edae0f17d..d4a20d17fc5758453e9c59c94893380ccb34f3de 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> @@ -26,6 +26,12 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
>    power-domains:
>      maxItems: 1
>  
> @@ -39,6 +45,26 @@ properties:
>        ID in its "clocks" phandle cell. See
>        include/dt-bindings/clock/nxp,imx95-clock.h
>  
> +patternProperties:
> +  "^ldb@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> +
> +allOf:

Please put allOf: after required: block.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


