Return-Path: <linux-kernel+bounces-803639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDBDB46348
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763C31D22086
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6E726F28F;
	Fri,  5 Sep 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IBqyTH7T"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6648169AE6;
	Fri,  5 Sep 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099508; cv=none; b=F8FwO829jg8D3cFpFUzLRUhw/wVRhpy0IpsOBlTykfteA2kiJ/xi2jKzgquORcDEUvsMIGV7IdC7O5I3aCckMAU2/Pes8Bew82gBrjtp81aNDvI0D1pEVdp3q/7aTn2P+BKwT3V5CX2OS6jR+HGRcYxp/g7FhkarJcK3Rm4vvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099508; c=relaxed/simple;
	bh=319/3fgJyC2cN3GrGlXodJCmh5w82d/xXhIMimv3SJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXldpa1miF5Voh4EeTPar/P1bBsJe+CxH6xdK5PZmce5hNHkLRGF3WPXx1XcOjjI83R9Zy11ExVOYyPyHmxVSAvNbxgCr67KitgSC6E+g2LfC6iBodCj4elrwdbvNKQ/PFlpJOO6EDLqJ6oYP4E42pNNzd/k567+3JaBW1qTZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IBqyTH7T; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585JBcuB3818526;
	Fri, 5 Sep 2025 14:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757099498;
	bh=VJVfpgI2zWe2MxErYt5wf9h8pnNlJMF+coJct3xk478=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IBqyTH7Tz9vgy7DtRC8rFtBKvHucWUoobLdqwCpQH9DfJ228KfmTy9eWbmGFdts9n
	 OwQISS8UsoXAGLlUp29kjNRHjVRVSGAqq+46YY4JtkdkL04jyhfKOE2yZEXATtzrBI
	 93uy/lSAPaHWohf+xhY8bupkv4SJpkmpzOmWUztQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585JBcMp1850783
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 14:11:38 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 14:11:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 14:11:37 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585JBaHv899397;
	Fri, 5 Sep 2025 14:11:37 -0500
Date: Sat, 6 Sep 2025 00:41:36 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afd@ti.com>,
        <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH v3 06/33] arm64: dts: ti: k3-am62: Enable remote
 processors at board level
Message-ID: <20250905191136.f4akog3ewnhpggsa@lcpd911>
References: <20250905051846.1189612-1-b-padhi@ti.com>
 <20250905051846.1189612-7-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905051846.1189612-7-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 05, 2025 at 10:48:19 +0530, Beleswar Padhi wrote:
> Remote Processors defined in top-level AM62x SoC dtsi files are
> incomplete without the memory carveouts and mailbox assignments which
> are only known at board integration level.
> 
> Therefore, disable the remote processors at SoC level and enable them at
> board level where above information is available.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> Acked-by: Andrew Davis <afd@ti.com>
> ---
> v3: Changelog:
> 1. Carried A/B, T/B, R/B tags.
> 
> Link to v2:
> https://lore.kernel.org/all/20250823160901.2177841-7-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 21/33] to [PATCH v2 06/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-22-b-padhi@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 1 +
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi      | 1 +
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi  | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> index 10e6b5c08619..dcd22ff487ec 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> @@ -407,4 +407,5 @@ &wkup_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
>  	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
>  			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index 6549b7efa656..75aed3a88284 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -128,6 +128,7 @@ wkup_r5fss0_core0: r5f@78000000 {
>  			ti,sci = <&dmsc>;
>  			ti,sci-dev-id = <121>;
>  			ti,sci-proc-ids = <0x01 0xff>;
> +			status = "disabled";
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 13e1d36123d5..840772060cb1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -506,6 +506,7 @@ &wkup_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
>  	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
>  			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

