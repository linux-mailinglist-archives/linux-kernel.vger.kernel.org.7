Return-Path: <linux-kernel+bounces-771118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3E9B28311
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE4A1D032AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2B9305E17;
	Fri, 15 Aug 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B7OQpQ3n"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C130499F;
	Fri, 15 Aug 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272323; cv=none; b=MNj323fpZgeF63l5ujZlckby9k+LKQVzf5d/aT8jpQpr+2eCLZjUX5HlQ3xumVdklGmU76E+HryEffmQ8oYIMQfbvNkL/fUXPJ6dwy8wbPXhWWLWIILZRJmu7lUU9LT9TNFwa9KO6L3kuHtwLPkU90ZK50mN4ml/OsuiTXUQZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272323; c=relaxed/simple;
	bh=Y7xbTipwgCmhi8GcDK1KNdkaHH4yQkh57YCqIXK+5ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ab1O/HuK92JKfm3t7fhhyFpIFaua3o9PoKKSmSnpuXocu0wID4gjxwOwx3K24OJdYrBEGauxYllIPvuDYdYNS7rLi4ZuurymFJZMWTx5csnTGhIm8bkPny9xK9xa9aFl83q/c0gjWB7psJWbbeREwyQZTntg3nff+Ekk/qiJLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B7OQpQ3n; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57FFcZ072553249;
	Fri, 15 Aug 2025 10:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755272315;
	bh=wjDT0cuqOqz1KGiBfuvRft2frGHo6r0c62HTNnpyaXg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=B7OQpQ3nyKnmOuEbFUxq3lPgRRvToDpjEXBIYj1JTfCMW3YW1yUQO9SzsRkz5t7jD
	 6Gt/3hklCgloLDQYbB/2FiLFgG8Cr+dX/3Qd6w8SuAPI55mwNm+ZcO68jiwZ7DnlXk
	 ++DT56BTxKURf3wb+l6GP+bSZj5AtnKRnZSSJbT8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57FFcZLU2683971
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 15 Aug 2025 10:38:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 15
 Aug 2025 10:38:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 15 Aug 2025 10:38:34 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57FFcYPf1490856;
	Fri, 15 Aug 2025 10:38:34 -0500
Message-ID: <c32e3cab-9074-488d-8909-4435f5194c48@ti.com>
Date: Fri, 15 Aug 2025 10:38:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] arm64: dts: ti: k3-j7200: Enable remote processors
 at board level
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-2-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250814223839.3256046-2-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/14/25 5:38 PM, Beleswar Padhi wrote:
> Remote Processors defined in top-level J7200 SoC dtsi files are
> incomplete without the memory carveouts and mailbox assignments which
> are only known at board integration level.
> 
> Therefore, disable the remote processors at SoC level and enable them at
> board level where above information is available.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---

Looks good to me. Could you move all these "Enable rproc at board level" patches
to the start of the series? They should be the most straightforward patches and
so could all go in even if the .dtsi refactor doesn't and needs some work.

Andrew

>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 3 +++
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 3 +++
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi     | 9 +++++++++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 5ce5f0a3d6f5..628ff89dd72f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -1516,6 +1516,7 @@ main_r5fss0: r5fss@5c00000 {
>   		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
>   			 <0x5d00000 0x00 0x5d00000 0x20000>;
>   		power-domains = <&k3_pds 243 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>   
>   		main_r5fss0_core0: r5f@5c00000 {
>   			compatible = "ti,j7200-r5f";
> @@ -1530,6 +1531,7 @@ main_r5fss0_core0: r5f@5c00000 {
>   			ti,atcm-enable = <1>;
>   			ti,btcm-enable = <1>;
>   			ti,loczrama = <1>;
> +			status = "disabled";
>   		};
>   
>   		main_r5fss0_core1: r5f@5d00000 {
> @@ -1545,6 +1547,7 @@ main_r5fss0_core1: r5f@5d00000 {
>   			ti,atcm-enable = <1>;
>   			ti,btcm-enable = <1>;
>   			ti,loczrama = <1>;
> +			status = "disabled";
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 56ab144fea07..692c4745040e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -612,6 +612,7 @@ mcu_r5fss0: r5fss@41000000 {
>   		ranges = <0x41000000 0x00 0x41000000 0x20000>,
>   			 <0x41400000 0x00 0x41400000 0x20000>;
>   		power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>   
>   		mcu_r5fss0_core0: r5f@41000000 {
>   			compatible = "ti,j7200-r5f";
> @@ -626,6 +627,7 @@ mcu_r5fss0_core0: r5f@41000000 {
>   			ti,atcm-enable = <1>;
>   			ti,btcm-enable = <1>;
>   			ti,loczrama = <1>;
> +			status = "disabled";
>   		};
>   
>   		mcu_r5fss0_core1: r5f@41400000 {
> @@ -641,6 +643,7 @@ mcu_r5fss0_core1: r5f@41400000 {
>   			ti,atcm-enable = <1>;
>   			ti,btcm-enable = <1>;
>   			ti,loczrama = <1>;
> +			status = "disabled";
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index 291ab9bb414d..90befcdc8d08 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -254,20 +254,27 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
>   	};
>   };
>   
> +&mcu_r5fss0 {
> +	status = "okay";
> +};
> +
>   &mcu_r5fss0_core0 {
>   	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
>   	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
>   			<&mcu_r5fss0_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &mcu_r5fss0_core1 {
>   	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
>   	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
>   			<&mcu_r5fss0_core1_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss0 {
>   	ti,cluster-mode = <0>;
> +	status = "okay";
>   };
>   
>   /* Timers are used by Remoteproc firmware */
> @@ -287,12 +294,14 @@ &main_r5fss0_core0 {
>   	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
>   	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>   			<&main_r5fss0_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_r5fss0_core1 {
>   	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
>   	memory-region = <&main_r5fss0_core1_dma_memory_region>,
>   			<&main_r5fss0_core1_memory_region>;
> +	status = "okay";
>   };
>   
>   &main_i2c0 {


