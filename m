Return-Path: <linux-kernel+bounces-784922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD0B343A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FF11692C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8392FAC06;
	Mon, 25 Aug 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ghY6Ai+e"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4592FD7A5;
	Mon, 25 Aug 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131552; cv=none; b=bFY2x3oiRNeFsrGHrV9cYUOBz1ewJDxaKjVywgHw6L/30g+5xGmdA+VUSBKSzjuTRIDoyz6fCI/QI7oPY68EF2PMGNOPInQSlZFgKipK3DFtryWjMWHzonRYThMHDWsU+jlN1cMPo/HC3R0KJYR/iZzNM63IEZBAHgZvU3xvgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131552; c=relaxed/simple;
	bh=C5zZWTWYlh+QNTmHH9Ic/O5Vu74p1ZquZ/RNbhEemyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c0JAVCNwCSLDgzzGXTxp5nkFHf2iR/ZNw5CNbsblGTl8SHUDxnRjpA71Klp7IWzxPnspcCelpeKm45BNno3v0QReXRp2a3sh7dN2PXvezBKUb4Cb3B/Z/WkewsLlfJfU9rFX4zhhm/CQSvk8EQLXfmstEgqbV4MlatH0B+XV3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ghY6Ai+e; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57PEIoTx825779;
	Mon, 25 Aug 2025 09:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756131530;
	bh=cKW1+DgNKTcSFWZr2yMsUcLdmMBtGqV9lYdiIEUEmS8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ghY6Ai+egyXOxyJgqOh1EKEqMeEsvgGv4pdLj++9k4XPJpLC5tf/SIM1FXk8yvB0u
	 +oNd1haUzQb5TQVWtrrx9zf9Un3ClBMOoAXs1fliZ5cfYNsffhC7LMZb5v3Y3PPyS2
	 o+k8LBIwZlFtoI1mZcoEKWW0Ni+MiXfV14j12LPY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57PEIoLM935796
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 25 Aug 2025 09:18:50 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 25
 Aug 2025 09:18:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 25 Aug 2025 09:18:49 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57PEInL93738293;
	Mon, 25 Aug 2025 09:18:49 -0500
Message-ID: <edbdcd7c-8c96-4cbd-9740-1e1044fba3b0@ti.com>
Date: Mon, 25 Aug 2025 09:18:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/33] arm64: dts: ti: k3-j7200: Enable remote
 processors at board level
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250823160901.2177841-1-b-padhi@ti.com>
 <20250823160901.2177841-2-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250823160901.2177841-2-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/23/25 11:08 AM, Beleswar Padhi wrote:
> Remote Processors defined in top-level J7200 SoC dtsi files are
> incomplete without the memory carveouts and mailbox assignments which
> are only known at board integration level.
> 
> Therefore, disable the remote processors at SoC level and enable them at
> board level where above information is available.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---

Small comment on the $subject, these all seem to be specific to the R5F
cores, the other remote processors are already enabled at the board level.
Suggest: "Enable R5F remote processors at board level"

Otherwise this looks good to me, same for patches 2-12 in this series
so feel free to add my ACK to those 12 patches when you spin v3,

Acked-by: Andrew Davis <afd@ti.com>

> v2: Changelog:
> 1. None
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-2-b-padhi@ti.com/
> 
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


