Return-Path: <linux-kernel+bounces-799809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85724B43083
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429D7566EE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1828640C;
	Thu,  4 Sep 2025 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FbxQFnI7"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14E4437A;
	Thu,  4 Sep 2025 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756957123; cv=none; b=QeiVVI490V8hsXbGM2g1gPqXZOT4oCj/XamhJupHMzngc8Ss2pIq6HNyrWRDfmFBDH/29s74s0T7eWZagD3y43c1xiRbg3H5SK5ux+jZghj07/a6C0zYHrFBA4WuIrTuQG+HyASh55A2bKzNltwPqWY0ybq7OPs+SnIE7i+YV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756957123; c=relaxed/simple;
	bh=yp4h80D+lfP9yLXutl3SXKGCKWjXsjW0pVN3LZiv7rM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeZVZfkbjIOhf0Yc2Z7nS2GtT+SrKepVq1nCE6httYCtUE0eJ+aFat+ePu79uHQtPx88StCZPceA/KLmYP3vAUzjfnL1O0oH6ASyP9yHKa1rM/O67poV3R9sqzd6HyniL8+pPCmCsC5OPaXxcLg2Kr0CXKZWhUYtn9vRYulpXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FbxQFnI7; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5843cZ1h2984143;
	Wed, 3 Sep 2025 22:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756957115;
	bh=miUAPPRPjN8qAJAGGG1aIrOjILdNp+0GSmr4IvkmH+Y=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FbxQFnI70M3jWOUAjhXGGA7oCRs4fNij7f9JIE97nZ3KDt5Kcoez3Q+ucm2l7xWkD
	 XBsUJBqctdkEKKtLTQTu/kpGlt/qyuWXTJ3aKaY1MSUfi6RxiJCmcZMxla+PPpcBZw
	 n1sdI97nUfqN97NQe2o5bMFq+eT1mxdjsV372mL4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5843cZ1K4014145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 22:38:35 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 22:38:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 22:38:34 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5843cYxw2326292;
	Wed, 3 Sep 2025 22:38:34 -0500
Date: Wed, 3 Sep 2025 22:38:34 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62p/j722s: Move sdhci0 from
 common
Message-ID: <20250904033834.cmn5i7satksnpr6o@revolver>
References: <20250904004723.2856005-1-jm@ti.com>
 <20250904004723.2856005-2-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904004723.2856005-2-jm@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 19:47-20250903, Judith Mendez wrote:
> Since eMMC HS400 has been descoped for j722s due to errata i2478 [0]
> and is supported for am62p SR1.2 device, remove sdhci0 node from
> common-main.dtsi and include instead in each device's main.dtsi
> appropriately.
> 
> [0] https://www.ti.com/lit/pdf/sprz575
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 25 -------------------
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 25 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 22 ++++++++++++++++
>  3 files changed, 47 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> index 4427b12058a6..84083f5125df 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> @@ -566,31 +566,6 @@ main_gpio1: gpio@601000 {
>  		clock-names = "gpio";
>  	};
>  
> -	sdhci0: mmc@fa10000 {
> -		compatible = "ti,am64-sdhci-8bit";
> -		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
> -		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> -		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
> -		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
> -		clock-names = "clk_ahb", "clk_xin";
> -		bus-width = <8>;
> -		mmc-ddr-1_8v;
> -		mmc-hs200-1_8v;
> -		mmc-hs400-1_8v;
> -		ti,clkbuf-sel = <0x7>;
> -		ti,strobe-sel = <0x77>;
> -		ti,trm-icp = <0x8>;
> -		ti,otap-del-sel-legacy = <0x1>;
> -		ti,otap-del-sel-mmc-hs = <0x1>;
> -		ti,otap-del-sel-ddr52 = <0x6>;
> -		ti,otap-del-sel-hs200 = <0x8>;
> -		ti,otap-del-sel-hs400 = <0x5>;

would'nt it be sufficient to provide this in am62p and keep the common
stuff here?

Additionally handling of SR1.2 should be documented in am62p

> -		ti,itap-del-sel-legacy = <0x10>;
> -		ti,itap-del-sel-mmc-hs = <0xa>;
> -		ti,itap-del-sel-ddr52 = <0x3>;
> -		status = "disabled";
> -	};
> -
>  	sdhci1: mmc@fa00000 {
>  		compatible = "ti,am62-sdhci";
>  		reg = <0x00 0x0fa00000 0x00 0x1000>, <0x00 0x0fa08000 0x00 0x400>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 6aea9d3f134e..fb8473ce403a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -31,6 +31,31 @@ usb1: usb@31100000 {
>  			snps,usb2-lpm-disable;
>  		};
>  	};
> +
> +	sdhci0: mmc@fa10000 {
> +		compatible = "ti,am64-sdhci-8bit";
> +		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
> +		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <8>;
> +		mmc-ddr-1_8v;
> +		mmc-hs200-1_8v;
> +		mmc-hs400-1_8v;
> +		ti,clkbuf-sel = <0x7>;
> +		ti,strobe-sel = <0x77>;
> +		ti,trm-icp = <0x8>;
> +		ti,otap-del-sel-legacy = <0x1>;
> +		ti,otap-del-sel-mmc-hs = <0x1>;
> +		ti,otap-del-sel-ddr52 = <0x6>;
> +		ti,otap-del-sel-hs200 = <0x8>;
> +		ti,otap-del-sel-hs400 = <0x5>;
> +		ti,itap-del-sel-legacy = <0x10>;
> +		ti,itap-del-sel-mmc-hs = <0xa>;
> +		ti,itap-del-sel-ddr52 = <0x3>;
> +		status = "disabled";
> +	};
>  };
>  
>  &oc_sram {
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 993828872dfb..2978fe1a151e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -404,6 +404,28 @@ e5010: jpeg-encoder@fd20000 {
>  		power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
>  		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +	sdhci0: mmc@fa10000 {
> +		compatible = "ti,am64-sdhci-8bit";
> +		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
> +		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <8>;
> +		mmc-ddr-1_8v;
> +		mmc-hs200-1_8v;
> +		ti,clkbuf-sel = <0x7>;
> +		ti,trm-icp = <0x8>;
> +		ti,otap-del-sel-legacy = <0x1>;
> +		ti,otap-del-sel-mmc-hs = <0x1>;
> +		ti,otap-del-sel-ddr52 = <0x6>;
> +		ti,otap-del-sel-hs200 = <0x8>;
> +		ti,itap-del-sel-legacy = <0x10>;
> +		ti,itap-del-sel-mmc-hs = <0xa>;
> +		ti,itap-del-sel-ddr52 = <0x3>;
> +		status = "disabled";
> +	};
>  };
>  
>  &main_bcdma_csi {
> -- 
> 2.51.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

