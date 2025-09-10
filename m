Return-Path: <linux-kernel+bounces-810338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD6B518FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483AB5E8122
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F385322A0E;
	Wed, 10 Sep 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QivxaOUE"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA762320A23;
	Wed, 10 Sep 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513265; cv=none; b=ShMbi/rBkM5my5hdUePw9h1C/tw8QZzt6EQ2tJjbOisBYe+4PAaOMVnGpmbzoc58+9wMyfTCmhItXYYq9bbwKSkKKGFde057mOCr1YKqTXZundbmRSUgueN6+onaTI04V8YwiItTwpycNDxj8L78pChBLHjqwnYIpDjxzgjfd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513265; c=relaxed/simple;
	bh=0r7z0wJULO08JV08ZcWuSvwNGGlmZuoA/gYjWmIuPb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bjwUcdTZkwkXt8rCw9brfcjIdq4Fbnx1UX3+Oed1E730ADiG7kj9f3tcEe9dvnYrGbTcxVZqGWzVe8i1PA++BP3IpSP9sCUcxq50P1WNxBkLupBZTkLOejnGtZEi/X3ykY1ElutbleYfkC4H4K27v1LNC4ueAvtpVqy5r/SKJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QivxaOUE; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58AE7W12151567;
	Wed, 10 Sep 2025 09:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757513252;
	bh=hdZlHFK/6K/TmCYzSQpqjrtYzY6SgIuXxYFGBmHGVpk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QivxaOUEpObFrdT1mYUud+D90j10dYpkVQ1yXqqUCKcS6g9p5FPDv2E+Bw4yDOG3U
	 qk1lq8YOOhGUGXTEIPXwgE+GBPTixoKLZkYPZq0dE+9kNhve+HK7KeVqKUGysaED7X
	 JDGKPzob2vVjLEPzA3zponvWsIB9bz4PMEHcJKxw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58AE7Wum420570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 09:07:32 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 09:07:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 09:07:32 -0500
Received: from [128.247.81.0] (ula0226330.dhcp.ti.com [128.247.81.0])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58AE7WLp288106;
	Wed, 10 Sep 2025 09:07:32 -0500
Message-ID: <4c9750c3-ba75-46ec-8398-0691d385d0d2@ti.com>
Date: Wed, 10 Sep 2025 09:07:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/34] Revert "arm64: dts: ti: k3-j721e-sk: Fix
 reversed C6x carveout locations"
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>, <d-gole@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250908142826.1828676-1-b-padhi@ti.com>
 <20250908142826.1828676-22-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250908142826.1828676-22-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/8/25 9:28 AM, Beleswar Padhi wrote:
> This reverts commit 9f3814a7c06b7c7296cf8c1622078ad71820454b.
> 
> The C6x carveouts are reversed intentionally. This is due to the
> requirement to keep the DMA memory region as non-cached, however the
> minimum granular cache region for C6x is 16MB. So, C66x_0 marks the
> entire C66x_1 16MB memory carveouts as non-cached, and uses the DMA
> memory region of C66x_1 as its own, and vice-versa.
> 
> This was also called out in the original commit which introduced these
> reversed carveouts:
> 	"The minimum granularity on the Cache settings on C66x DSP cores
> 	is 16MB, so the DMA memory regions are chosen such that they are
> 	in separate 16MB regions for each DSP, while reserving a total
> 	of 16 MB for each DSP and not changing the overall DSP
> 	remoteproc carveouts."
> 
> Fixes: 9f3814a7c06b ("arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations")
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---

Still feels like something we should have fixed on the firmware side,
but since the firmware is out there already we can live with it.

Acked-by: Andrew Davis <afd@ti.com>

> v4: Changelog:
> 1. Updated carveout node names to generic 'memory@addr'
> 
> Link to v3:
> https://lore.kernel.org/all/20250905051846.1189612-21-b-padhi@ti.com/
> 
> v3: Changelog:
> 1. None
> 
> Link to v2:
> https://lore.kernel.org/all/20250823160901.2177841-21-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 03/33] to [PATCH v2 20/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-4-b-padhi@ti.com/
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 0f05e65f7bf7..37bc33f2cc26 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -120,7 +120,8 @@ main_r5fss1_core1_memory_region: memory@a5100000 {
>   			no-map;
>   		};
>   
> -		c66_0_dma_memory_region: memory@a6000000 {
> +		/* Carveout locations are flipped due to caching */
> +		c66_1_dma_memory_region: memory@a6000000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0xa6000000 0x00 0x100000>;
>   			no-map;
> @@ -132,7 +133,8 @@ c66_0_memory_region: memory@a6100000 {
>   			no-map;
>   		};
>   
> -		c66_1_dma_memory_region: memory@a7000000 {
> +		/* Carveout locations are flipped due to caching */
> +		c66_0_dma_memory_region: memory@a7000000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0xa7000000 0x00 0x100000>;
>   			no-map;


