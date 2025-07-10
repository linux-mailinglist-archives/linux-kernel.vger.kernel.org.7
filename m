Return-Path: <linux-kernel+bounces-726558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7432B00EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1238F587826
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75729A311;
	Thu, 10 Jul 2025 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swKlbdv9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10F2356D2;
	Thu, 10 Jul 2025 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186334; cv=none; b=C9P/82/cnTBUHsuwHP6FAFGIcHjHLX0rcn++teWRlH2okRlbWHtkkkdinbPKzPfp08gGjxRPU/p52EYqzad/iNLbhOrCqvTWOCgTYI5sYi/pdD8q6Q11XfKSoHAFXPnLk2Xr0Oxw81AYyTFtM8rMvRJxL8aDvWY1HUsfCj3IeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186334; c=relaxed/simple;
	bh=Hr1PsSZpPnvJkfBE+S1YATXV95Q4Fi7cxOlliarndms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DznZnS6cdK29So3jFXYD9zzLgqEmvGHJap3h7QdNZOHUOFS/z/yHI9X686KKejzdH25P4Nk1xuc5wSD8pi4AzPhy1o//vAZm63bRaMG+hXSJATmmM7eyxcnbToPRBEk4eSvgrOvl2e5XPAgLVGBA3e9lX2gcWHPR29E+8V2KgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swKlbdv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DE4C4CEE3;
	Thu, 10 Jul 2025 22:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752186333;
	bh=Hr1PsSZpPnvJkfBE+S1YATXV95Q4Fi7cxOlliarndms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swKlbdv92NEPM4YCMOMscz+KSZut7oBWINT5QVkUh6EDB9LXodMhxiPLRALYWMbca
	 6Tn78YHH2I8zkh4mlFhpmctnMVM3FfCVIMPa9CvBN/vnK9wnwnu8PnzVQ9M2uM9Yk5
	 iO0FYXoo0pDf04oT+zlaJGu7kL1K2LhadRHp2De+TUQ5zYHPlKdekCpfSJIoQKrptj
	 4WZ63vpSFJlUQNe5rHVQ3GX/7jDO3NVLKtJUWqH3pTvJQCxG1E3d+lGQSy/CM+2n/k
	 0Kkc3TzGYxqE0HvtP6yLJZpsySCclAJP89kQlDydPPQbf81hzWFMuYV78tpGGqt2nI
	 gBhh9TkW+Ak6g==
Date: Thu, 10 Jul 2025 17:25:27 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Parant <c.parant@phytec.fr>
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	upstream@lists.phytec.de
Subject: Re: [PATCH v2 03/11] dt-bindings: arm: stm32: Modify STM32MP15x
 Phytec board items types
Message-ID: <20250710222527.GA4171977-robh@kernel.org>
References: <20250709151011.366537-1-c.parant@phytec.fr>
 <20250709151011.366537-4-c.parant@phytec.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709151011.366537-4-c.parant@phytec.fr>

On Wed, Jul 09, 2025 at 05:10:03PM +0200, Christophe Parant wrote:
> As Phytec manages different SoM configurations with different STM32MP15
> SoC versions, modify the phyBOARD and SoM compatible items to "enum"
> instead of "const".
> The description concerns PHYTEC SoM equipped with STM32MP157
> ("st,stm32mp157" is "const").
> Also add comments in front of the enum items to be able to identify the
> compatible string with the phyBOARD/phyCORE names.

I don't understand the point of this patch.

> Signed-off-by: Christophe Parant <c.parant@phytec.fr>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index 408532504a24..fbd3d364c1f7 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -182,10 +182,12 @@ properties:
>            - const: seeed,stm32mp157c-odyssey-som
>            - const: st,stm32mp157
>  
> -      - description: Phytec STM32MP1 SoM based Boards
> +      - description: Phytec STM32MP157 SoM based Boards
>          items:
> -          - const: phytec,phycore-stm32mp1-3
> -          - const: phytec,phycore-stm32mp157c-som
> +          - enum:
> +              - phytec,phycore-stm32mp1-3 # phyBOARD-Sargas with phyCORE-STM32MP157C SoM
> +          - enum:
> +              - phytec,phycore-stm32mp157c-som # phyCORE-STM32MP157C SoM

Are you going to add more entries to the enums? Wouldn't those be a 
different SoC and a whole other 'items' list because it wouldn't be the 
157 SoC?

>            - const: st,stm32mp157
>  
>        - description: Ultratronik STM32MP1 SBC based Boards
> -- 
> 2.34.1
> 

