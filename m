Return-Path: <linux-kernel+bounces-771122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E83B28323
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696653A3AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112EC30749F;
	Fri, 15 Aug 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bvwo0tTO"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCE306D5F;
	Fri, 15 Aug 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272559; cv=none; b=sA5QSEes9sI9qGXryA/FHkQW191GCiu0CMpXLpgtQC5eiUSwJUm/RJ3P733+lCgaH1CFlCxv4Htzc6QaKUo/Vd7BVRzk/bRcg5lXj6QWdwl9lad47p2xFituUAcNsLaFDqfi7k5HPINhBj5QzBpuJDnSaX1VEFLr7wiOheodyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272559; c=relaxed/simple;
	bh=pUJyfyQsR5qpgXX5MynBEbAM1FcsyAA6BT1Ydh1cCP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UW01ZmKakd3gHygZKw6axJeWTk3mJg/aabztJUh8isuB8vphaY/1D8DiXMzdkgM5y1S+txDYI9FHnQBqdoXasycAGwiOdGKd9tJ2d3rdjnlS48yUIS01sf+kybNfysN78xbJQKeyVcXwAo3fha6IXhlH0efridtbyOUvpPCOBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bvwo0tTO; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57FFgVYR2129853;
	Fri, 15 Aug 2025 10:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755272551;
	bh=oE0Ngv5v73PruF5NZiPf5GQoobAQbNTYWmvt9cBM8fA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bvwo0tTOVEiPRGprBceXEZFts9AQTJ9eu96+4j6eKbWM1bsd0xEzM2R9/RV5OqRVt
	 rRTd3f4bvS/KCAe8yR501/V/Pg6DHbXoJ0MJpG+b1dRGRI8rCy7HMO9lyiZBh9A1K9
	 5ZJjAEd73vy0vUuxSyfN6xnYL2ObeqesC53HQzI4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57FFgVlf2535646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 15 Aug 2025 10:42:31 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 15
 Aug 2025 10:42:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 15 Aug 2025 10:42:30 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57FFgTDu1191765;
	Fri, 15 Aug 2025 10:42:29 -0500
Message-ID: <cb663648-768d-49ad-bd33-c7e58ff58213@ti.com>
Date: Fri, 15 Aug 2025 10:42:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] arm64: dts: ti: k3-j721e-beagleboneai64: Add
 missing cfg for TI IPC FW
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson
	<robertcnelson@gmail.com>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-7-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250814223839.3256046-7-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/14/25 5:38 PM, Beleswar Padhi wrote:
> The TI IPC Firmwares running on J721E SoCs use certain MAIN domain
> timers as tick. Reserve those at board level DT to avoid remote
> processor crashes.
> 

All these "missing cfg" patches should then go together next in this series.

> While at it, switch the MAIN domain R5F cluster into split mode to
> maximize the number of R5F processors. The TI IPC firmware for the split
> processors is already available public. This config aligns with other
> J721E boards and can be refactored out later.
> 

This is an unrelated change and not as trivial as it looks. Factor this part
out and put it later in the series so we can discuss it separately.

Andrew

> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Requesting for review/test of this patch.
> 
>   .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> index fdfd46b5b30a..c7ac2b66ee0d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> @@ -937,6 +937,35 @@ mbox_c71_0: mbox-c71-0 {
>   	};
>   };
>   
> +/* Timers are used by Remoteproc firmware */
> +&main_timer0 {
> +	status = "reserved";
> +};
> +
> +&main_timer1 {
> +	status = "reserved";
> +};
> +
> +&main_timer2 {
> +	status = "reserved";
> +};
> +
> +&main_timer12 {
> +	status = "reserved";
> +};
> +
> +&main_timer13 {
> +	status = "reserved";
> +};
> +
> +&main_timer14 {
> +	status = "reserved";
> +};
> +
> +&main_timer15 {
> +	status = "reserved";
> +};
> +
>   &mcu_r5fss0 {
>   	status = "okay";
>   };
> @@ -956,6 +985,7 @@ &mcu_r5fss0_core1 {
>   };
>   
>   &main_r5fss0 {
> +	ti,cluster-mode = <0>;
>   	status = "okay";
>   };
>   
> @@ -974,6 +1004,7 @@ &main_r5fss0_core1 {
>   };
>   
>   &main_r5fss1 {
> +	ti,cluster-mode = <0>;
>   	status = "okay";
>   };
>   


