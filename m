Return-Path: <linux-kernel+bounces-766965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304ABB24D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52177BA73E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3401FDA89;
	Wed, 13 Aug 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WGZ4Cklv"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066C1FDE19;
	Wed, 13 Aug 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098253; cv=none; b=iaFlQGZfvb1pLBHYx2sXKg3+iyCMw31re+vR8ArTRC2W0N9KX8j3/sX6oh9th5u+mbRvRlzlXumA6oMB42z+EVKjRZ3dw5XLdmznfCwMLjyrf5aPdwEIWyejOkdbuIZpMl2EsyiDwAirPtx3aWWkPZP1WyRx8gQmhYGWTScGs6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098253; c=relaxed/simple;
	bh=X55BNW/lvLuP0M1N8mH4Vvk/thi99V61e54O86PhtzQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfwIRgusSGttC1KAs7txkiqODmIqX3i5Bkru2USLJuVBmApqqlypWUclVBf+36lWphrPcw0Yenq2paiWWCwMV97WbhzoUaXn0O0ilQbsiivQWpaz28eEesx24pWxq6Ln2ckWRS731qAJ7NAczl3h+N4cN3MYlyAW+I2+i4SF59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WGZ4Cklv; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DFHMuB2101625;
	Wed, 13 Aug 2025 10:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755098242;
	bh=mcAdqGklcRo+qLa2crMGRiBhEAbVfeREEGf0sW1Z/G0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WGZ4CklvI+zkUPaV54K6b5MBk2b0LdxHQn6wRWSdTpCWUbISrFyXxONBmoFMl4Wis
	 LKnMpVp9w+xfMK6VkCyY1vftwgJP0HIaxJAyW2aLpviANW9WekVM84gqHmGWQ29zT+
	 Rw/SrjmDADK1TiRRiT3S3PNmOKZf2/LHFy7QYYhE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DFHMVc479317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 10:17:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 10:17:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 10:17:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DFHLeO2494680;
	Wed, 13 Aug 2025 10:17:21 -0500
Date: Wed, 13 Aug 2025 10:17:21 -0500
From: Nishanth Menon <nm@ti.com>
To: <rs@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>, <matt.coster@imgtec.com>,
        Michael Walle
	<mwalle@kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62p-j722s: enable the bxs-4-64
Message-ID: <20250813151721.nc5fr3qmro5grlda@steam>
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-2-rs@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250808232522.1296240-2-rs@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 18:25-20250808, rs@ti.com wrote:
> From: Randolph Sapp <rs@ti.com>
> 
> Add the relevant device tree node for Imagination's BXS-4-64 GPU.
> 
> These devices specifically do not set the dma-coherent bit because they
> do not use the same MSMC configuration as other BXS-4-64 enabled TI
> platforms.
> 
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi     | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> index 2e5e25a8ca86..a51db8f9dff8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> @@ -690,6 +690,19 @@ ospi0: spi@fc40000 {
>  		};
>  	};
>  
> +	gpu: gpu@fd80000 {
> +		compatible = "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rogue";

Note the discussion in https://lore.kernel.org/linux-arm-kernel/DBE4UO2RGAYX.17V1DAF8MQYJM@kernel.org/

> +		reg = <0x00 0x0fd80000 0x00 0x80000>;
> +		clocks = <&k3_clks 237 1>;
> +		clock-names = "core";
> +		assigned-clocks = <&k3_clks 237 1>;
> +		assigned-clock-rates = <800000000>;
> +		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
> +		power-domain-names = "a", "b";
> +	};
> +
>  	cpsw3g: ethernet@8000000 {
>  		compatible = "ti,am642-cpsw-nuss";
>  		#address-cells = <2>;
> -- 
> 2.50.1
> 

Is the issue that Michael reported
https://lore.kernel.org/linux-arm-kernel/20250716134717.4085567-3-mwalle@kernel.org/
resolved?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

