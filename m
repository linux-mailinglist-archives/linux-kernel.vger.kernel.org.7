Return-Path: <linux-kernel+bounces-766967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE844B24D46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95949881525
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602F61F461A;
	Wed, 13 Aug 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N/bC7Ttx"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED41188A0C;
	Wed, 13 Aug 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098309; cv=none; b=aOkvkAfDUORf0QQdqoubyXKGSwkgTD2bvURpVuB+bxzMROK+t9404SPB9oDaZScNAG4BIbTqCgS2+ikVNyuRO5wF4045tM2xPz8WWE4k00iU0c2kz1b/n9yf2TIxyjFcM4jxuPd391tvwQeuQy0c71O54QrWWHpuBDvrNQc7Z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098309; c=relaxed/simple;
	bh=p7kUeqOY8eu6sbORye2iPrV7HXR5MjZ7/aKeOQGxuBQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma83/zuJkmZmvwmaq93JjH0j+dlk6HbL/wLndy4QsKmQpj90f7bKrZYG1xYv1O6t+yS6eipWhbjcSkaEfQ2GULsc2YSqLqSaLE1TvIpkXp+0K958bAJW89Izqixk/4J7RLF3LWi6xffm6BLr5+wXTeIHCJvyl0vHpyQD4LB+Xmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N/bC7Ttx; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DFIKoi2101708;
	Wed, 13 Aug 2025 10:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755098300;
	bh=hhdtKws0AycCkK53UlJjP9D8XM/fNiJlo7puW4IHx5E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=N/bC7TtxNQJJOzYI0o6kQwioHEBrltAI+Dve+FQ9MVFTM6tAfffdiYiyhzGzzGWx+
	 n4SOIEE2IExuC1TIEMdDAu5Y9/ZIkuD+ogMymeMsPMyHivsDr4ko57xlEWXCsw/IRZ
	 TwsMXTHCIzi5bt9ArUEmDmX6957GL1M1F4iQYwm4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DFIKUM1163159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 10:18:20 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 10:18:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 10:18:19 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DFIJfm2495450;
	Wed, 13 Aug 2025 10:18:19 -0500
Date: Wed, 13 Aug 2025 10:18:19 -0500
From: Nishanth Menon <nm@ti.com>
To: <rs@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>, <matt.coster@imgtec.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2: enable the bxs-4-64
Message-ID: <20250813151819.5rthljjrpryfwezz@skinning>
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-3-rs@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250808232522.1296240-3-rs@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 18:25-20250808, rs@ti.com wrote:
> From: Randolph Sapp <rs@ti.com>
> 
> Add the relevant device tree node for Imagination's BXS-4-64 GPU.
> 
> These devices uses a similar MSMC configuration to the J721S2. As such,
> they also require the use of the dma-coherent attribute.
> 
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> index 7c5b0c69897d..a44ca34dda62 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> @@ -2691,4 +2691,18 @@ bist_main14: bist@33c0000 {
>  		bootph-pre-ram;
>  		ti,sci-dev-id = <234>;
>  	};
> +
> +	gpu: gpu@4e20000000 {
> +		compatible = "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rogue";

Following  https://lore.kernel.org/linux-arm-kernel/DBE4UO2RGAYX.17V1DAF8MQYJM@kernel.org/
Is it worth having ti,j784s4-gpu here? Are there any SoC specific quirks
that driver will need to handle?

> +		reg = <0x4e 0x20000000 0x00 0x80000>;
> +		clocks = <&k3_clks 181 1>;
> +		clock-names = "core";
> +		assigned-clocks = <&k3_clks 181 1>;
> +		assigned-clock-rates = <800000000>;
> +		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 181 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
> +		power-domain-names = "a", "b";
> +		dma-coherent;
> +	};
>  };
> -- 
> 2.50.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

