Return-Path: <linux-kernel+bounces-800142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9560AB433F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA5D3A8A29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3E29BD81;
	Thu,  4 Sep 2025 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRT50ZUh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118CA29ACC2;
	Thu,  4 Sep 2025 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970854; cv=none; b=diEyN/+PA2AGSzH/Nn7lrdSFtelUbAvu+k9cBPfAjFJHSLd3jTp8MbpgTM/7KpNPA5q65WwVgluY5WV9f8+rq8WY+XY9gCrRXDrh/0dNrNfKaj+fs8T1n30owL/kZa4uq2sUfbkfPP5DqVJRfF1sinSuS1U8IEdIK99uCzT7p/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970854; c=relaxed/simple;
	bh=Z8XSQTvtPUkxAQ9BXix6/Yhokfu8nsR+89vawyheIsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWqODVMN+4oR6uzSjlHqkeZPQc285k4KH+HULURJqneJz9/2RiRx58oj2HyEFoZcTjjHAn87d9j5jkNLR+E9tMHRhN7XeZSMZJWIRHiIbHRdwjQIN+tOApn0bYp2FYJzYd80KyY46QeIyopdnO0ILWRqYVVfK1QigEdJK3zMlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRT50ZUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4589AC4CEF0;
	Thu,  4 Sep 2025 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756970853;
	bh=Z8XSQTvtPUkxAQ9BXix6/Yhokfu8nsR+89vawyheIsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRT50ZUhGaiA9XuQgRPkzuI+B/6okbH+qUPwIurIe99vYFu8u3r7UVXtK1fXYfue3
	 Tct/kxZsTf047c3Q4Xw5jRmOGoEwB2CQYuadcmL4NKKRsuhK0krkwqDd7CKrRZdZyA
	 Jl7w7prXAnR/VYEi4qarJDsN5UgokGCtLY3SwZicKhnp/Bn/M3w26Yzkpo9zyP+xZc
	 yY0p+KiSnrKQ/v0H+Hc6Z3+meX1Hy8obFSgfJWvt41GUkH5hbjr2aKJrQoWuRSIfeC
	 VVn8p9MnyRgrJ6kd16q039oE8lvlHbuZYl1zouYM7MqI3j2qRdKokXcOILRYQGmxKp
	 WhXOd9rsF1oXA==
Date: Thu, 4 Sep 2025 09:27:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb
 child node
Message-ID: <20250904-misty-mini-buzzard-af2aec@kuoka>
References: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
 <20250903123332.2569241-7-laurentiu.palcu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903123332.2569241-7-laurentiu.palcu@oss.nxp.com>

On Wed, Sep 03, 2025 at 03:33:24PM +0300, Laurentiu Palcu wrote:
> Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> LVDS Display Bridge controllers, add 'ldb' child node to handle
> these use cases.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/clock/nxp,imx95-blk-ctl.yaml     | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Nothing in the changelog explains this patch.

What happened with entire previous review?

> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index 27403b4c52d62..f83d96701bb04 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> @@ -39,6 +39,28 @@ properties:
>        ID in its "clocks" phandle cell. See
>        include/dt-bindings/clock/nxp,imx95-clock.h
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: nxp,imx94-lvds-csr
> +then:
> +  properties:
> +    "#address-cells":
> +      const: 1
> +
> +    "#size-cells":
> +      const: 1
> +
> +  patternProperties:
> +    "^ldb@[0-9a-f]+$":

No, don't define nodes in if:then:. Where did you get this syntax from?

> +      type: object
> +      $ref: /schemas/display/bridge/fsl,ldb.yaml#
> +
> +  required:
> +    - '#address-cells'
> +    - '#size-cells'
> +
>  required:
>    - compatible
>    - reg
> @@ -46,7 +68,7 @@ required:
>    - power-domains
>    - clocks
>  
> -additionalProperties: false
> +unevaluatedProperties: false

NAK, so schema warned you above syntax is wrong and you decided to
silence the warning with this hack, right?

Best regards,
Krzysztof


