Return-Path: <linux-kernel+bounces-889919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB97C3ED5B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC121188A943
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E232C30F535;
	Fri,  7 Nov 2025 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIgbO3bu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C6130E85E;
	Fri,  7 Nov 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502266; cv=none; b=nP//YSgjVM7BjMURPjYicaJxbhgrUjXUVCBoStl7wy0nYTfvrZW0BFbfwD2n+UStoInF1aWMi0lHxJVz5oUgoVNt8mfL/BArDH7g3CzrUNZfbyOuZbcus3K6/oaE9UCqBgI0poean73p03KibLRBNiYlIPHmI8Yn3DFOO7J9Sdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502266; c=relaxed/simple;
	bh=xM6b+hhLff+TvwOs6RF++4PTmGDEuvRO5iMSfFtRhTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ighLEjQzUAXXg1GTdqBVXxOELjeEF22az9AOdSlKs1MQzFYPsfke9JEN7k1mIT4W5Wc6YvWnXrD+YMeAR4UvJxVbyCATYd4+AmQidUtt0lEQrU1NQj82sZxeeyqOMxI6Z1GNaQnLgpH9ySkYrce6Eqm2Z6WvZDj8IxD8WZZoIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIgbO3bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F47C4CEF8;
	Fri,  7 Nov 2025 07:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762502265;
	bh=xM6b+hhLff+TvwOs6RF++4PTmGDEuvRO5iMSfFtRhTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIgbO3bu1JxVbD8WoPHAv7Hp9H/BLfgVlz9TcoFrefdlJwNMfVEla+LywVc2LpKsu
	 MvoGpOAvR5+L+MVLH7LkmGGUYzEtvjjZ/py29ZREf9NDhlCU9CGIB/UYRiYbLWQ1/8
	 Yiwi0ZehhnMaWuwlN/J1td0rHL51c1xlmdKkERBkeIoaZYWKIyC1sori0ZgJYgzQwJ
	 SBwWc8F1kBMJYvhy48+UvxYWXJp8jxFP3xEG5TlKZOJmivSRxsgNYrXVe35YsM6C/f
	 tyduoIqijZ9QRzMNhFnbfVnMtYCMs4mqMXmzFh94Ptp9bgTeSegwUNxn7rKpyGWVqf
	 TqBSizwwDZ2wQ==
Date: Fri, 7 Nov 2025 08:57:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swamil Jain <s-jain1@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, louis.chauvet@bootlin.com, 
	aradhya.bhatia@linux.dev, devarsht@ti.com, praneeth@ti.com, h-shenoy@ti.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 3/5] arm64: dts: ti: k3-am62-main: Add tidss
 clk-ctrl property
Message-ID: <20251107-honored-moth-of-opportunity-eecef9@kuoka>
References: <20251106141227.899054-1-s-jain1@ti.com>
 <20251106141227.899054-4-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106141227.899054-4-s-jain1@ti.com>

On Thu, Nov 06, 2025 at 07:42:25PM +0530, Swamil Jain wrote:
> From: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> For am62 processors, we need to use the newly created clk-ctrl property to
> properly handle data edge sampling configuration. Add them in the main
> device tree.
> 
> Fixes: ad2ac9dc9426 ("drm/tidss: Add support for AM625 DSS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index a290a674767b..2b6c033ae393 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -77,6 +77,11 @@ audio_refclk1: clock-controller@82e4 {
>  			#clock-cells = <0>;
>  		};
>  
> +		dss_clk_ctrl: dss-clk-ctrl@8300 {
> +			compatible = "ti,am625-dss-clk-ctrl", "syscon";
> +			reg = <0x8300 0x4>;

Same problem as last time. Nothing improved.

NAK

Best regards,
Krzysztof


