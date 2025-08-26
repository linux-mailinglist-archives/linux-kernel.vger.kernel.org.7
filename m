Return-Path: <linux-kernel+bounces-787400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B41B375C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12F52A5D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83033090F7;
	Tue, 26 Aug 2025 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCIUI9V5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7323AC22;
	Tue, 26 Aug 2025 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252521; cv=none; b=JZtRpzNFBIE66PliyUIWbnNf+MJMW/bMCzZC/o+ET2liyuqWuzf3JzTxaURl5qzzVqPXu+lnVwoOgoiJsXFS68GfEveVE8WxPx3wDiW+PnFdEEkYVcernwB7gAXfUOfil2qiIuUxJVnsgWtl7uhmK6EcOPblikp9R1T0t28orwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252521; c=relaxed/simple;
	bh=/kSptgDuhHweTBDHwLjSq1ZSf/lmwbeobjE4KADBZKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOVb1UKMNPXMarWZgxnjeeGv2CweH00gOIkyWhgMYq7lAdFrWJbAX5/K+dT+8zxVrcIn3geIIBc364C33A2rUN0IoHkxUuzyc824ICxRNkd7mPodODSzX+h/UUZzd1Ua6YHR8zY96eNWJFWdy1aL4YTTb3UCCcB1zdrJ9im4KkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCIUI9V5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C51C4CEF1;
	Tue, 26 Aug 2025 23:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756252520;
	bh=/kSptgDuhHweTBDHwLjSq1ZSf/lmwbeobjE4KADBZKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCIUI9V5TKNLZZFR1UaVCKa14Z7ZYCTNZtxHc/Qn7kDl/l8lfRsm3UXUTqZ4OMjaX
	 B9B0HuDSv1DLSFVsKCCWk89l7nrmO+yzjF7W4U4CaOpqJrJdL0mqVidmrAPWiT/T33
	 MTwyWxHWMNcZ+4rMw/EKKnV9beHqngPvkO2FANZyitggib4k880G8t94QwLhBp1NIk
	 EvrIJxu2/TfW4HeOp8msyvg7qDmh4AxWGmb2wQ1EHnCOZhndqcFhssDqzIHr2pkWXp
	 FQGkTcVCUMVYgleoBEybSb//I0jEwZd7rle5UHqpJmlNouPJku60yrZfprxClhPKkc
	 kLOGiu3UsI/Fg==
Date: Tue, 26 Aug 2025 18:55:19 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] docs: dt: writing-bindings: Add exception for
 clock-names
Message-ID: <20250826235519.GA766501-robh@kernel.org>
References: <20250826151650.9396-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826151650.9396-1-Frank.Li@nxp.com>

On Tue, Aug 26, 2025 at 11:16:49AM -0400, Frank Li wrote:
> Allow pattern like "pclk" and "hclk" as clock-names.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> https://lore.kernel.org/linux-i3c/20250625200451.GA2117971-robh@kernel.org/
> ---
>  Documentation/devicetree/bindings/writing-bindings.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/writing-bindings.rst b/Documentation/devicetree/bindings/writing-bindings.rst
> index 667816dd7d504..81f76ca57a394 100644
> --- a/Documentation/devicetree/bindings/writing-bindings.rst
> +++ b/Documentation/devicetree/bindings/writing-bindings.rst
> @@ -97,7 +97,8 @@ Typical cases and caveats
>    constraints (e.g. list of items).
>  
>  - For names used in {clock,dma,interrupt,reset}-names, do not add any suffix,
> -  e.g.: "tx" instead of "txirq" (for interrupt).
> +  e.g.: "tx" instead of "txirq" (for interrupt). Except when only single letter
> +  remains after removing the suffix, e.g., 'pclk', 'hclk'.

It's more that the examples are the hardware names for the clocks than 
a single letter is too terse.

Rob

