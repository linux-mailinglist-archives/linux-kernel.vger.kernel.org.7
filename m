Return-Path: <linux-kernel+bounces-810339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E97B518E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D911680AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376E322DDE;
	Wed, 10 Sep 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cWvtoQaU"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B9322A1A;
	Wed, 10 Sep 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513269; cv=none; b=N0hlY4L7ZqlPDiWKdJbtPd4OVRCXowJsMKNQaaeufMwmSdLzDLvDNnwlu/IvPclF3ZjFN87yi1RtHc0Lo5v541hEBTK96A+LhNELB6NDBpU1Pa5AGIfhM9qOFSIXAo6eA9pafEaMh/NwCvkRvmVVqxDjUrVg/TjWan4QPxAX/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513269; c=relaxed/simple;
	bh=VdEP6t3SemHMUJlYsSqjBtzgVrYIlWfupXETQivpZJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tqDKgCBqaD22t/w6I4BaY97iCSqdFC+prRKqgGNzPptLytj+6srksmtVoCMmlktnW6Eoophz23et38WoEfiSA1QoYln2kql3AD/jflgdYGDNpMXX2s1g4uQYgPqsD6WJKNDYfjLG/mFSRG6lGvs/rGUQl8uqUe0K9ttyHC5tb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cWvtoQaU; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58AE7feI151583;
	Wed, 10 Sep 2025 09:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757513261;
	bh=LnOHOg3H5ggOveS2dbAQDsJSfchqVaj8yOAiLKEOXpY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cWvtoQaU85ZKAlxE6OEHVGJYYDFnSeC8jsQUQnrq+4gQXJ6hD5OmIhZ0zV7QgkvW9
	 h1peqVKa2hhrJzyRtLO5ZbxD4SUbc+OGn7IPqMm9hG7qaFSd7fWOgTLBTBzHEg3PU8
	 oijAy87FG6J63zzqFaH0UunkEqcQb/c2JiSF9V24=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58AE7fT83970441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 09:07:41 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 09:07:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 09:07:41 -0500
Received: from [128.247.81.0] (ula0226330.dhcp.ti.com [128.247.81.0])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58AE7fmn587629;
	Wed, 10 Sep 2025 09:07:41 -0500
Message-ID: <f8844710-39a3-4d48-96b7-678894af0c76@ti.com>
Date: Wed, 10 Sep 2025 09:07:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/34] Revert "arm64: dts: ti: k3-j721e-beagleboneai64:
 Fix reversed C6x carveout locations"
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>, <d-gole@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250908142826.1828676-1-b-padhi@ti.com>
 <20250908142826.1828676-23-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250908142826.1828676-23-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/8/25 9:28 AM, Beleswar Padhi wrote:
> This reverts commit 1a314099b7559690fe23cdf3300dfff6e830ecb1.
> 
> The C6x carveouts are reversed intentionally. This is due to the
> requirement to keep the DMA memory region as non-cached, however the
> minimum granular cache region for C6x is 16MB. So, C66x_0 marks the
> entire C66x_1 16MB memory carveouts as non-cached, and uses the DMA
> memory region of C66x_1 as its own, and vice-versa.
> 
> This was also called out in the original commit which introduced these
> reversed carveouts:
> 	"The minimum granularity on the Cache settings on C66x DSP
> 	cores is 16MB, so the DMA memory regions are chosen such that
> 	they are in separate 16MB regions for each DSP, while reserving
> 	a total of 16 MB for each DSP and not changing the overall DSP
>          remoteproc carveouts."
> 
> Fixes: 1a314099b755 ("arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout locations")
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---

Acked-by: Andrew Davis <afd@ti.com>

> v4: Changelog:
> 1. Updaed node names to 'memory@addr'
> 
> Link to v3:
> https://lore.kernel.org/all/20250905051846.1189612-22-b-padhi@ti.com/
> 
> v3: Changelog:
> 1. None
> 
> Link to v2:
> https://lore.kernel.org/all/20250823160901.2177841-22-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 04/33] to [PATCH v2 21/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-5-b-padhi@ti.com/
> 
>   arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> index 66c4614f9e42..92f5e4a14a49 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> @@ -123,7 +123,8 @@ main_r5fss1_core1_memory_region: memory@a5100000 {
>   			no-map;
>   		};
>   
> -		c66_0_dma_memory_region: memory@a6000000 {
> +		/* Carveout locations are flipped due to caching */
> +		c66_1_dma_memory_region: memory@a6000000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0xa6000000 0x00 0x100000>;
>   			no-map;
> @@ -135,7 +136,8 @@ c66_0_memory_region: memory@a6100000 {
>   			no-map;
>   		};
>   
> -		c66_1_dma_memory_region: memory@a7000000 {
> +		/* Carveout locations are flipped due to caching */
> +		c66_0_dma_memory_region: memory@a7000000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0xa7000000 0x00 0x100000>;
>   			no-map;


