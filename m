Return-Path: <linux-kernel+bounces-802365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9302CB4518D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6528B5A66A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D80731813F;
	Fri,  5 Sep 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyF9DvME"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984F3090CA;
	Fri,  5 Sep 2025 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060976; cv=none; b=B5V2uSVQm8g/RfTSWyMb8HCbSII5nyTwBkXvO7UAhvpL/fKZY81Z8jfLsI0nQqmcZMC/AlqsGN1FPsxoqtq9yYq84WcqNXfHyLqdp6820CduNJqveU0BRYaaKrIC+Vj2XtQa4fKxJXgb7cqJ8oJYh7pLRn/YtVFEZW/MeiLDJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060976; c=relaxed/simple;
	bh=qTwRtRE61zsPY4Oik1TKuwEr2YgkQWcTIA6AodbDFbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuvGiOzCunlaHrVYzVLbagz0GEpj2PMXlQ4Z0l1Yg9JwGYWXhr8HGZiPvPjx+TxxiEweN9+H8ByvF1nx4WV+u+J1d6Vuix1ZK91yAbS+CnNfsvdGGaLqVqVMY7Gdlo56s8VNwmn9xFiBmX2E7goDj4BtD+h66TznKcDIgnU1e1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyF9DvME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B22C4CEF1;
	Fri,  5 Sep 2025 08:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757060976;
	bh=qTwRtRE61zsPY4Oik1TKuwEr2YgkQWcTIA6AodbDFbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyF9DvMEwnV5F2vH9gRUZIMZfim4cZhMh63nrQaXMvNQjJl/4Ri8WSywsq2l81CU9
	 ccDxiyhVMJNjeSSdDp0qu2qFf/RJvGTgK22FQda7UjES7SSAb4uF+fd/4EVK7OmLEh
	 NsG8WxdAtiT+Abc6fZiVs9P4bhB8WLQQSGSggExIGBWwkbXQcHZecPUkMH3AWRnLkh
	 KgL0azlZq3Ar0vx0wjx97yMYMrB+yhBCpua3HoliUHxTh/ewRTOLNwpF214mpgJIDs
	 /lVKkpWfDljD8d7co/3/N+CY+gRt6LjgnPjXWAfKY1JQTaJ2FzuJay1Ky9xPSoDxis
	 wx9GOZfGOaxEw==
Date: Fri, 5 Sep 2025 10:29:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904154402.300032-14-vladimir.oltean@nxp.com>

On Thu, Sep 04, 2025 at 06:44:01PM +0300, Vladimir Oltean wrote:
> Going by the generic "fsl,lynx-28g" compatible string and expecting all
> SerDes instantiations on all SoCs to use it was a mistake.
> 
> They all share the same register map, sure, but the number of protocol
> converters and lanes which are instantiated differs in a way that isn't
> detectable by software. So distinguish them by compatible strings.
> At the same time, keep "fsl,lynx-28g" as backup.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../devicetree/bindings/phy/fsl,lynx-28g.yaml     | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> index ff9f9ca0f19c..55d773c8d0e4 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> @@ -11,8 +11,17 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,lynx-28g
> +    oneOf:
> +      - items:
> +          - const: fsl,lynx-28g

Don't change that part. Previous enum was correct. You want oneOf and
enum.

> +      - items:
> +          - enum:
> +              - fsl,lx2160a-serdes1
> +              - fsl,lx2160a-serdes2
> +              - fsl,lx2160a-serdes3

What are the differences? number of lanes? For this you can take
num-lanes property.

> +              - fsl,lx2162a-serdes1
> +              - fsl,lx2162a-serdes2
> +          - const: fsl,lynx-28g

Best regards,
Krzysztof


