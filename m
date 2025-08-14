Return-Path: <linux-kernel+bounces-768382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2B8B2604F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3444B7BB682
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB22ED17A;
	Thu, 14 Aug 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLuUBGtd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF92EBDC7;
	Thu, 14 Aug 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162584; cv=none; b=CmVe97kSHJ3xn4tovJMW5JafHYIz2cgXGOrm+rHQW/M4os1GbV52TDf2/pv3rDG8Xppxh7z8MysBQF3WvPsVhs/KlAS+ukVUEyF5WtfGcCBCiCPP44MHqFl3GyRyS4N/WMwEmPyXqxk59mMWMGjzTK4bgWtLG80mGmspNds+dto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162584; c=relaxed/simple;
	bh=4haXZhUQhwWTQfAUzZvN0UDYTjKDPWIQ5LTd46KE9Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6UF2pIPWBOMpuxe4fe6+xlna+hgPF7Co4WrN5DqiOvtV+IHW/d1mmTsblmlSYj5h3AIBYDnNxeJZrgWoOc11SZPqvkdyJWbYOX/iDWDQgB3YMgghUnfAYCLiw/jShkWWvKIwcrZtiTyOhoU6SvG7aUYjeepUmNeqmt753ZF1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLuUBGtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887F0C4CEEF;
	Thu, 14 Aug 2025 09:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162583;
	bh=4haXZhUQhwWTQfAUzZvN0UDYTjKDPWIQ5LTd46KE9Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLuUBGtdppkgsKgis3nVC/Avqik7RnCYzK9KO7reriPcUJPTO57YUPt85/HgWATYX
	 v9Xpj+vF0aZsc18rDuptx7cW4VFNjpbBXuNKNF/BdANIEzLtY2wqZNZ7MAAWQMDBK/
	 IWS+cH7eNxDp8JNHuyoSSiJQXAgvWF3CDzn0gZFUCptj/TB3sQ5f+WPhrzRnCOuIbk
	 JwiFm7oLFMdZfFut8BL+1nbFQ3pzVMsXxnVW5fgtoDEPzWfSIFLmm187pl+w1OmZHW
	 26Enk7S0sOkxJuXinXiwvqCjBvF6QqFEZ+mGMqIuZQ+iY/PBBNMU+lgeMhR2MoVCxl
	 MQSCILYYJFxRQ==
Date: Thu, 14 Aug 2025 11:09:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] dt-bindings: display: st: add new compatible to
 LVDS device
Message-ID: <20250814-dancing-nautilus-of-camouflage-ebb441@kuoka>
References: <20250812-drm-misc-next-v2-0-132fd84463d7@foss.st.com>
 <20250812-drm-misc-next-v2-3-132fd84463d7@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250812-drm-misc-next-v2-3-132fd84463d7@foss.st.com>

On Tue, Aug 12, 2025 at 03:49:00PM +0200, Raphael Gallais-Pou wrote:
> Update the compatible to accept both "st,stm32mp255-lvds" and
> st,stm32mp25-lvds" respectively.  Default will fall back to
> "st,stm32mp25-lvds".
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> index 6736f93256b5cebb558cda5250369ec4b1b3033c..b777c55626e4b322d77ef411ad9e4a3afb6c9131 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> @@ -31,7 +31,13 @@ description: |
>  
>  properties:
>    compatible:
> -    const: st,stm32mp25-lvds
> +    oneOf:
> +      - items:
> +          - enum:
> +              - st,stm32mp255-lvds
> +          - const: st,stm32mp25-lvds
> +      - items:

Drop. This should be just enum or const, no need for items.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


