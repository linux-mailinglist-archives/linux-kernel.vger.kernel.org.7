Return-Path: <linux-kernel+bounces-758776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793FAB1D3BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F0E18C15CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7080242D8C;
	Thu,  7 Aug 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKwdCxeC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400B233D88;
	Thu,  7 Aug 2025 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553292; cv=none; b=Kqx3cZa9EKvCoJwLs1T5JbTWqDRxXtiLFOiid68pEd+N1iaX1IbSYLQrK+99uUMUzhTfKtL9+pAaNiUXZRzey4mMMo0ja3ogh2uV/WDW3I+dfvPZ8V6Y8e71tK2kq/Vhuttt4cBbVFAZBhWcF86QiPsuOdW+I7A9bYFW15pPs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553292; c=relaxed/simple;
	bh=UDjX5P2i0+5VBmpt0BakLkDuU7c4ejIdGwCkBnB5Kws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8dSfQiLtKziQgUtpRTUHzJaTEN3YXavrFjdICseQ9ieBh4PkSir9kOsa94PVTZQVQtbzPsIAX2xr9cHvQwI6eNH+TTeiF7uXAhSgIW2r7LXbHQWiwhztHOVNWTpuspRW7M7Q8w5V3emK7aHZLhGHrcLF6JqpIBJzYUv4yJ6ZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKwdCxeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063BFC4CEEB;
	Thu,  7 Aug 2025 07:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754553291;
	bh=UDjX5P2i0+5VBmpt0BakLkDuU7c4ejIdGwCkBnB5Kws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKwdCxeCGn1c/t/KwbfMscwvKAczuiqx86CJW35IduP32RJ60oYcXJw5+suSgG44s
	 KL5mCu0dvGt6du3sKfJJEn9sv7nAZWydO3Ie5av2X5c+1kCuS9+5FX4aPQC6W46f/9
	 XXmUaGgedp9kmAVeKad31hZyrrpNsntiloefusMmmjUFQSaaxILGZbjE5Bym7RBXsC
	 ROfZAERid55SRLI7wuisiQkYXQK/+JcUQ+TDyrk9RQSq6HHjUZrHo52XzwkA3N8l8s
	 mT/ppOHao3mwLxZ82pX661j/DDNUX4fEvbF1HHIGS4yEAVW6ft/rAo/6v43MagP/vQ
	 pQI+z7Z6fTjAA==
Date: Thu, 7 Aug 2025 09:54:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, 
	alberto.dassatti@heig-vd.ch, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: rockchip,pcie3-phy: add
 rockchip,phy-ref-use-pad
Message-ID: <20250807-inquisitive-speedy-rooster-0a8488@kuoka>
References: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
 <20250806133824.525871-4-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806133824.525871-4-rick.wertenbroek@gmail.com>

On Wed, Aug 06, 2025 at 03:38:23PM +0200, Rick Wertenbroek wrote:
> >From the RK3588 Technical Reference Manual, Part1,
> section 6.19 PCIe3PHY_GRF Register Description: "ref_use_pad"
> 
> "Select reference clock connected to ref_pad_clk_p/ref_pad_clk_m.
> Selects the external ref_pad_clk_p and ref_pad_clk_m inputs as the
> reference clock source when asserted. When de-asserted, ref_alt_clk_p
> and ref_alt_clk_m are the sources of the reference clock."
> 
> The hardware reset value for this field is 0x1 (enabled).
> Note that this register field is only available on RK3588, not on RK3568.

Then you miss restricting it (:false) in one of if:then: blocks.

Also, binding cannot be after the user. You need to reorder patches.

...

>  
> +  rockchip,phy-ref-use-pad:
> +    description: which PHY should use the external pad as PCIe reference clock.
> +      1 means use pad (default), 0 means use internal clock (PLL_PPLL).

Can't you deduce it from the presence of clock inputs? IOW, if the
clocks are physically connected, is it even reasonable or possible to
use internal clock?

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      minimum: 0
> +      maximum: 1

More precise:

items:
  - description: PHY0 reference clock config
  - description: PHY1 reference clock config
  enum: [ 0, 1 ]
default: [ 1, 1 ]

Anyway, default 1, 1 is pretty non-obvious, so this should be just
non-unique-string-array (and property should be like
rockchip,phy-ref-clk-source/sel).


Best regards,
Krzysztof


