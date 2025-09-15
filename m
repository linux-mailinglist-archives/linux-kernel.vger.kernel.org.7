Return-Path: <linux-kernel+bounces-816136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85861B57005
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEA3172558
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5896D38DE1;
	Mon, 15 Sep 2025 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="voKqXK/A"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04BE2652A4;
	Mon, 15 Sep 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916171; cv=none; b=jn1zE+0gwZ2mI8LNgbA1oU53+jxPWNzOSoHHD/rsbRHIF8TRxwVgmOur7/Nh68Iw4SJaa5iMWaYbaJCvN+fwNtsgf6Cg/YSB0FAZZTDh7CrgWQu82wdPYkVWnmzwsYULHwqktET+vk7WyS8TIIqg/IGx/pgd+XGhuCwxEoDY1jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916171; c=relaxed/simple;
	bh=R/v39Zvvp2nJDWSy8hWa1ht4SitGUbvx92jwmRxjejk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xw+VgwPUu6jQoYGCUbWtWdDpX1RoIKvo6CYVDjUqndpnvBMPCa/fvw7HeEZqinqFzPwRwCQwJ/eMw2lubneSqrdRyGH3VDVmfDjSlVYzIla5rfsHMK6bkFhYPWGU53sA8JPNhJP5ctILRM7WCijfzZ8HvyeQE0sqQnNsebbj9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=voKqXK/A; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58F625Zj1429273;
	Mon, 15 Sep 2025 01:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757916125;
	bh=n0u4PxfyY4PoKcxJ30zJrCWPuw9liRt9K8tJCU5A/vc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=voKqXK/A+wMyudxPFxyJd/wGyiswo0uMUOQj9Sf27kEBrVrKCO8k7RreRXF8IE2mM
	 g3k0WF/MwZcDg9WdtLODVrkKqFluJPjKr08miXXgoG4qvxcoaR2PvhzGRDUinNfgrb
	 EdTIeL0iUU5p9FaL26x61RzhQenHRfyjtxneEZKE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58F624dX3181974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 15 Sep 2025 01:02:04 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 01:02:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 01:02:03 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.233.62])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58F61vdW3240035;
	Mon, 15 Sep 2025 01:01:58 -0500
Message-ID: <c34213a8-adc2-4cbb-a255-85486e7042d2@ti.com>
Date: Mon, 15 Sep 2025 11:31:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62: Add support for AM625 OLDI
 IO Control
To: Swamil Jain <s-jain1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jyri.sarha@iki.fi>,
        <tomi.valkeinen@ideasonboard.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <aradhya.bhatia@linux.dev>
CC: <h-shenoy@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250913064205.4152249-1-s-jain1@ti.com>
 <20250913064205.4152249-2-s-jain1@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20250913064205.4152249-2-s-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 13/09/25 12:12, Swamil Jain wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> Add TI DSS OLDI-IO control registers for AM625 DSS. This is a region of
> 12 32bit registers found in the TI AM625 CTRL_MMR0 register space[0].
> They are used to control the characteristics of the OLDI DATA/CLK IO as
> needed by the DSS display controller node.
> 
> [0]: https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 029380dc1a35..dcc71db8afd4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -76,6 +76,11 @@ audio_refclk1: clock-controller@82e4 {
>   			assigned-clock-parents = <&k3_clks 157 18>;
>   			#clock-cells = <0>;
>   		};
> +
> +		dss_oldi_io_ctrl: oldi-io-controller@8600 {
> +			compatible = "ti,am625-dss-oldi-io-ctrl", "syscon";
> +			reg = <0x8600 0x200>;
> +		};
>   	};
>   
>   	dmss: bus@48000000 {


