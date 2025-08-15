Return-Path: <linux-kernel+bounces-770038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9702EB2762A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F241CC7D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EC526FA70;
	Fri, 15 Aug 2025 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QxK7eNqy"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07012586CE;
	Fri, 15 Aug 2025 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225334; cv=none; b=mWspf7sqipXQQurdw8XmGGnabwudiC0K+prnSPncbVsRdoLkuEJeu1ILRce8t1xgX/hdp64PAETHl6zvqyryskbdRzdDCQFxcl0aU9hD+QpHQ31aeP6ZqumeKch4JRzeFc3YMDeaLqJ1EskFvMJ+BEahy4V8rHGOuMpMilu22/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225334; c=relaxed/simple;
	bh=ijE02Tcfqe5ihAJ1WW++yG514OgZv4UkpM5sNGyhsP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f1T8wtpggvoL4lC1GTtY+G22sXj+m1f/PDkE6W9QFEIBbbiQx1fi9SGjp5Ax11O8akA69n4bQl2tTMrLdbgGnPzx0vhQrVuoFneUkDss+HMcqtoRj5eYuHHT0OAvIrle9UjJaemHp+b8/vLIj2+0TK7IALTHHSQoXIwWLoTEWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QxK7eNqy; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57F2ZRHi2435437;
	Thu, 14 Aug 2025 21:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755225327;
	bh=D85PRfMAhEWkK4I3NT1Wt26m3JxDAXB+XgzS4gRVg7c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QxK7eNqyuItCpXM4sEB7Zec/282Gx+sxzSkYkCBZqr+2DfGO3t1JC3OrNsXdMZpGL
	 KaceHsWRf8h+Fu0OjBY0S2fJPwG76zoiDsopNKmMpa903K5NhovCoq1OJ1NFz5ACjB
	 6DfGyZNSGmanqIK5zjpUOPP/kAysrkf+Epvk7zeE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57F2ZRu81288354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 21:35:27 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 21:35:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 21:35:26 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57F2ZLDK659070;
	Thu, 14 Aug 2025 21:35:22 -0500
Message-ID: <92e57929-a978-4d5f-97d4-b7779736d0db@ti.com>
Date: Fri, 15 Aug 2025 08:05:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed
 C6x carveout locations"
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <afd@ti.com>, <hnagalla@ti.com>, <jm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <u-kumar1@ti.com>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-4-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250814223839.3256046-4-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 8/15/2025 4:08 AM, Beleswar Padhi wrote:
> This reverts commit 9f3814a7c06b7c7296cf8c1622078ad71820454b.
>
> The C6x carveouts are reversed intentionally. This is due to the
> requirement to keep the DMA memory region as non-cached, however the
> minimum granular cache region for C6x is 16MB. So, C66x_0 marks the
> entire C66x_1 16MB memory carveouts as non-cached, and uses the DMA
> memory region of C66x_1 as its own, and vice-versa.

Sorry , but i failed to understand how this swap helps in making region 
non-cached.

16MB logic is understood.

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
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index ffef3d1cfd55..9882bb1e8097 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -120,7 +120,8 @@ main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
>   			no-map;
>   		};
>   
> -		c66_0_dma_memory_region: c66-dma-memory@a6000000 {
> +		/* Carveout locations are flipped due to caching */
> +		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0xa6000000 0x00 0x100000>;
>   			no-map;
> @@ -132,7 +133,8 @@ c66_0_memory_region: c66-memory@a6100000 {
>   			no-map;
>   		};
>   
> -		c66_1_dma_memory_region: c66-dma-memory@a7000000 {
> +		/* Carveout locations are flipped due to caching */
> +		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0xa7000000 0x00 0x100000>;
>   			no-map;

