Return-Path: <linux-kernel+bounces-758745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D219FB1D35E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1611AA4BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B5A23ABA1;
	Thu,  7 Aug 2025 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coaz+St/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA981A8F97;
	Thu,  7 Aug 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551909; cv=none; b=iAzDtiIuwCn6Lg47w03mAc0XmpFVhG+yxGXBnOgYv3R6iT9sp1JzT4u9a8lEON+102nTIBaOFIyqVnl1FdUheGE01R7vAH4OzIirSvSM5WX3IsDjA/IAV+mV3/7nBcGobo4y10ASHBJ4PYcqFeqKZD/l8wPxk9lXyGVnQtng8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551909; c=relaxed/simple;
	bh=4THJ8Z+Q9mlw0DN/9Ry88kfBt+XVJ3Smmy5qShyVwkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlkT7sJ9lif1//PeHk+c8dEr6ncaklFZqNra7XujH1ZgeMGhL/9XMmKNd7H/4k88vXuUgdDXvAfhHkfCdRnaKipfF2HLM92hF03eu7DmdibR9eyOkvybdY+L5uhrS/qP/98OcfuwZyfr696BvzE55DaIqtbYojaUid5jfKViOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coaz+St/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B22AC4CEEB;
	Thu,  7 Aug 2025 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754551909;
	bh=4THJ8Z+Q9mlw0DN/9Ry88kfBt+XVJ3Smmy5qShyVwkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coaz+St/3IS8hCIwa8TQ+vz4/c+RH9vUh8a046Yo+8zvm0nGdai47maL19XNycBee
	 2Kkf0fVgxnFgmbdv3J2/jU/Nu5mtYcPgAjvC+PLC+zghYSbyXEnzau09n9rUy1f6qJ
	 8FRAX2EWv+mLVwuerfUtKhmZ5YKZuj0YaFzG/ffbAdHFLxA1uS+uvqGTxFo1323dbb
	 TYTGMKdk1bZB2gZCpQ+wfb1ruTwmhPjzvkyxaanHPF9I7n37SRnsohybwfT8rlEf9g
	 3F5yTCl2uyEaDxT4cA4Jiu0fpKd6rAwOTjIabN9l5JPw4k4mQULoCLgKSa9D0AdJJJ
	 Uy2ATNJmGqzjg==
Date: Thu, 7 Aug 2025 09:31:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] arm64: dts: imx943: Add display pipeline nodes
Message-ID: <20250807-illustrious-cuckoo-of-management-dacca0@kuoka>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
 <20250806150521.2174797-8-laurentiu.palcu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806150521.2174797-8-laurentiu.palcu@oss.nxp.com>

On Wed, Aug 06, 2025 at 06:05:14PM +0300, Laurentiu Palcu wrote:
> Add display controller and LDB support in imx943.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx943.dtsi | 55 ++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
> index 657c81b6016f2..70dec03c5608e 100644
> --- a/arch/arm64/boot/dts/freescale/imx943.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
> @@ -148,7 +148,7 @@ l3_cache: l3-cache {
>  		};
>  	};
>  
> -	clock-ldb-pll-div7 {
> +	clock_ldb_pll_div7: clock-ldb-pll-div7 {
>  		compatible = "fixed-factor-clock";
>  		#clock-cells = <0>;
>  		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
> @@ -174,9 +174,62 @@ dispmix_csr: syscon@4b010000 {
>  		lvds_csr: syscon@4b0c0000 {
>  			compatible = "nxp,imx94-lvds-csr", "syscon";
>  			reg = <0x0 0x4b0c0000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
>  			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
>  			#clock-cells = <1>;
>  			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> +
> +			ldb: ldb@4 {
> +				compatible = "fsl,imx94-ldb";
> +				reg = <0x4 0x4>, <0x8 0x4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;

Why? There are no children with addressing. You never tested it because
this would easily be flagged by tools.

> +				reg-names = "ldb", "lvds";

Follow DTS coding style.

Best regards,
Krzysztof


