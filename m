Return-Path: <linux-kernel+bounces-746282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64753B124DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789981CC7214
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DE24A063;
	Fri, 25 Jul 2025 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIIqiaIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA41E766F;
	Fri, 25 Jul 2025 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472840; cv=none; b=Iq7g7NHZPFqSq4ii25fhhJ5TyW37nQdrqfv7ByoA6mqDakUaxwNBZDedud8PSP32beo777+px0u1wiU4psLiWlPtV3BHfw6fiJWS/Yq0N0I10hZX4PmpqYpBITVizG64e8YCans1O6wrN3dIknXh54UioTSBsgrFmkwCEE3GK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472840; c=relaxed/simple;
	bh=mEjzP9TaXNL8JMZBOaOKVilLLRlX5WpZm35D+dYFv7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7tfe8Jk3K5muQ4qdJwSoWPXMQ5AoCujcVH0VOrV2/oiCISXMdIKCz/D8fKQmR/vIiWugtf1Wrl8NlDyjZmLxsljGIrZg66jJ6bL17Av8xFNKPXMTj8VlocHxz8OGpQ37gBAUE3xXEbEwYkiuwxS+VpwIbVVriGJzAI7HXUvyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIIqiaIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B26C4CEE7;
	Fri, 25 Jul 2025 19:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472839;
	bh=mEjzP9TaXNL8JMZBOaOKVilLLRlX5WpZm35D+dYFv7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIIqiaIOHmnOPsekUorf5BEBcRj+fEFfAZDMVt9C8ukV0wZbtK5MHMjSySX0M5YL1
	 CKq170D/xgNjf1sSMPlJvD+ueVR1l99gaxpUEzhZZuRwM5fG7sV1/aIc3ySWRY9YAz
	 PeLTRMVf3ehqQzneaddt/2l4JBJXP1PY/C8JBJIWIHDUph5Kf66sO9Ft2YpwA3gYRn
	 mXPreQF4hIkv5GG87zPIDgRkH88e01KnB0KpYIf0S9vU58cn4UJE6ib2D9I5pZkVZs
	 mo9vodS9M0ZQHeDN9Z8BCfqY/NxGLtFmsJ/C80+U/Xw4Zjn3J914HpEuFbNj4O43Ss
	 8AWHBIN13FPYA==
Date: Fri, 25 Jul 2025 14:47:18 -0500
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: fsl: fsl,rcpm: reference
 power-domains.yaml
Message-ID: <20250725194718.GA1727841-robh@kernel.org>
References: <20250725055835.260930-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725055835.260930-1-alexander.stein@ew.tq-group.com>

On Fri, Jul 25, 2025 at 07:58:34AM +0200, Alexander Stein wrote:
> dtbs_check for ls1021.dtsi warns about unsupported property:
>  power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 
> But if removed the check warns about missing property:
>  power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' is a required property
> 
> Given commit 8bcf67b8d893b ("ARM: dts: ls1021a: add #power-domain-cells
> for power-controller node") explicitly added that property, add a
> reference to the common bindings to fix the warning.
> 
> Fixes: ad21e3840a88 ("dt-bindings: soc: fsl: Convert rcpm to yaml format")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
> index 03d71ab930d79..5b7c0a1905545 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
> @@ -13,6 +13,9 @@ description:
>  maintainers:
>    - Frank Li <Frank.Li@nxp.com>
>  
> +allOf:
> +  - $ref: /schemas/power/power-domain.yaml#

This is not correct. The fix for the above warning is to add 
'#power-domain-cells' to the properties list here. You can't just 
reference the schema because you have to define the value of 
'#power-domain-cells' for this provider.

Generally, we only add a $ref to providers if they have child nodes 
(e.g. are a bus).

> +
>  properties:
>    compatible:
>      oneOf:
> @@ -75,7 +78,7 @@ properties:
>        RCPM register block is Little Endian. Without it RCPM
>        will be Big Endian (default case).
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> -- 
> 2.43.0
> 

