Return-Path: <linux-kernel+bounces-803634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE49B4633A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6670176E80
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095AA1DE89A;
	Fri,  5 Sep 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XKKCdNi2"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174EC315D22;
	Fri,  5 Sep 2025 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099373; cv=none; b=TI9F0Laz1D/qZly+dyYgnEeYuSYx65yRVuTr8oGZZLjtXrySlSUHlRfveEvz2fzHA7UpdouvC7OJXQwP0MZZdv8WkTrN3TSoqJ6nl2xW9oiArRdpU33c4Fy8GQw5NpACK/ChTF8EOpSSP8ICfq9TBKF28Bwdvdc8QfZ7I/iUfvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099373; c=relaxed/simple;
	bh=FOvYnQSiNl8pemFCHlVa0ESbQyOKLecA7twxglo8mQ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXKmkVNcYYCXKb6SZ/2/bwOpZz/gYFwjV9QZuZpv9iG52ZiwKIXCih+9qe8/daKlObmXR5xJlUanV9wHiHIB1D1ldwU4+DJWJLeBZbtxFrSeziEgw5mdfv01KlSLStjgrrRftg07iPaMbMws/it6DFS6LPxrx4iH1XH7GggBoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XKKCdNi2; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585J9PCM3318147;
	Fri, 5 Sep 2025 14:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757099365;
	bh=2ozhSc9fWCXpoZo6y9/TJu376fK1mD4abGnuKuDNvF0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XKKCdNi2IUzEX3vMRNXUQnhm+b2vkVFZHG3UvPsKREzHJCAMJsOseVYbMEfD5m8wc
	 ioNEia+GKDmnAIzo/t+RmOZQ46AWekaYqBGXTZfRf8qKfzgb2Fcu738jUyP/XnnhKj
	 r49Bcn+fCgdsCqeezxy7qV+4kJx0xB0oVftGgCO4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585J9PlF1117620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 14:09:25 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 14:09:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 14:09:24 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585J9Nkc1190511;
	Fri, 5 Sep 2025 14:09:24 -0500
Date: Sat, 6 Sep 2025 00:39:23 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afd@ti.com>,
        <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 05/33] arm64: dts: ti: k3-am62p-j722s: Enable remote
 processors at board level
Message-ID: <20250905190923.c6uxxurvt6kkxxo4@lcpd911>
References: <20250905051846.1189612-1-b-padhi@ti.com>
 <20250905051846.1189612-6-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905051846.1189612-6-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 05, 2025 at 10:48:18 +0530, Beleswar Padhi wrote:
> Remote Processors defined in top-level AM62P-J722S common SoC dtsi
> files are incomplete without the memory carveouts and mailbox
> assignments which are only known at board integration level.
> 
> Therefore, disable the remote processors at SoC level and enable them at
> board level where above information is available.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> Acked-by: Andrew Davis <afd@ti.com>
> Tested-by: Judith Mendez <jm@ti.com>
> ---
> v3: Changelog:
> 1. Carried A/B and T/B tags.
> 
> Link to v2:
> https://lore.kernel.org/all/20250823160901.2177841-6-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 13/33] to [PATCH v2 05/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-14-b-padhi@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi    | 1 +
>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi | 1 +
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                  | 2 ++
>  arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts           | 3 +++
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts                  | 3 +++
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                | 1 +
>  6 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> index bd6a00d13aea..5288c959f3c1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> @@ -205,6 +205,7 @@ mcu_r5fss0_core0: r5f@79000000 {
>  			ti,atcm-enable = <0>;
>  			ti,btcm-enable = <1>;
>  			ti,loczrama = <0>;
> +			status = "disabled";
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> index 6757b37a9de3..8612b45e665c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> @@ -136,6 +136,7 @@ wkup_r5fss0_core0: r5f@78000000 {
>  			ti,atcm-enable = <1>;
>  			ti,btcm-enable = <1>;
>  			ti,loczrama = <1>;
> +			status = "disabled";
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> index 899da7896563..2755598fd1f5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -725,6 +725,7 @@ &wkup_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
>  	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
>  			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
>  
>  &mcu_r5fss0 {
> @@ -735,6 +736,7 @@ &mcu_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
>  	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
>  			<&mcu_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
>  
>  &main_uart0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> index bf9b23df1da2..b329e4cb0c37 100644
> --- a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> @@ -515,6 +515,7 @@ &wkup_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster0 &mbox_wkup_r5_0>;
>  	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
>  			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
>  
>  &mcu_r5fss0 {
> @@ -525,6 +526,7 @@ &mcu_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
>  	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
>  			<&mcu_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
>  
>  &main_r5fss0 {
> @@ -535,6 +537,7 @@ &main_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster3 &mbox_main_r5_0>;
>  	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>  			<&main_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
>  
>  &c7x_0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index 9d8abfa9afd2..2b9e007432a9 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -850,6 +850,7 @@ &wkup_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster0 &mbox_wkup_r5_0>;
>  	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
>  			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
>  
>  &mcu_r5fss0 {
> @@ -860,6 +861,7 @@ &mcu_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
>  	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
>  			<&mcu_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
>  
>  &main_r5fss0 {
> @@ -870,6 +872,7 @@ &main_r5fss0_core0 {
>  	mboxes = <&mailbox0_cluster3 &mbox_main_r5_0>;
>  	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>  			<&main_r5fss0_core0_memory_region>;
> +	status = "okay";
>  };
>  
>  &c7x_0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 993828872dfb..d57fdd38bdce 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -368,6 +368,7 @@ main_r5fss0_core0: r5f@78400000 {
>  			ti,atcm-enable = <1>;
>  			ti,btcm-enable = <1>;
>  			ti,loczrama = <1>;
> +			status = "disabled";
>  		};
>  	};

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

