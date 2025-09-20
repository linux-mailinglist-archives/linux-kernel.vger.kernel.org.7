Return-Path: <linux-kernel+bounces-825457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5BB8BD80
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D47E71AD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902551F7569;
	Sat, 20 Sep 2025 02:36:59 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71F1A9F84;
	Sat, 20 Sep 2025 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758335819; cv=none; b=VdHDCGpXcLejeTM9D6dMgb589JeX2CJ3iP9KeR2iXcEqiH2MW7Q/eLpKDxN3IlkA+dW8huO+d3xX6DMlJOg6CXXEIGWsGxYBHzfPlGYiwLP1Is62OcODN1sLA8hfHhp3oBdDVwjeud2DS5CD+H3doSSDMHGX1J8yZ4veWHzOmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758335819; c=relaxed/simple;
	bh=h0mrKr44BcKhfgTv2Y9PCdAzOCi938Y0M8UD6peXyBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4ppZDpieB8yGxnJV09sSVqDFIbFGCpO/crrgdl9PYQeUAXOHonmrGk2LTi8nFE+J3AwJok782pZHFKDpJ+76UTrVuo4002vWo01+v+8IJwy/ITVZh8z0J9Y3CarKg/uSWQ43MroLTKDcUWoTvsuy8qaqEYpp5+dXCzSmMNZdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uznT2-000000006vy-29eO;
	Sat, 20 Sep 2025 02:36:52 +0000
Date: Sat, 20 Sep 2025 03:36:49 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: bryan@bryanhinton.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com, conor+dt@kernel.org,
	krzk+dt@kernel.org, matthias.bgg@gmail.com, robh@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt7981b: OpenWrt One: set
 console UART to 115200
Message-ID: <aM4TQc32cNYY-wLA@pidgin.makrotopia.org>
References: <20250920000619.2643457-1-bryan@bryanhinton.com>
 <20250920000619.2643457-3-bryan@bryanhinton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920000619.2643457-3-bryan@bryanhinton.com>

On Fri, Sep 19, 2025 at 07:06:12PM -0500, bryan@bryanhinton.com wrote:
> Use the new uart0 label for the console and make the speed explicit by
> adding current-speed = <115200>. This keeps the DTS OS-agnostic: no
> bootargs or distribution-specific properties are added.
> 
> Verification: Boot-tested with mainline Image+DTB via U-Boot on OpenWrt
> One (MT7981B). Serial console active at 115200 baud, and DTB decompile
> confirms serial0 alias and stdout-path set correctly.
> 
> Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

See comment below
> ---
>  .../arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> index 4f6cbb491287..1d2c3a21019c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
> @@ -8,8 +8,21 @@ / {
>  	compatible = "openwrt,one", "mediatek,mt7981b";
>  	model = "OpenWrt One";
>  
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>  	memory@40000000 {
>  		reg = <0 0x40000000 0 0x40000000>;
>  		device_type = "memory";
>  	};
>  };
> +
> +&uart0 {
> +	status = "okay";
> +	current-speed = <115200>; /* 0x1c200 */

The comment with the hex value should be removed. There is no need for it.

> +};
> -- 
> 2.51.0
> 
> 

