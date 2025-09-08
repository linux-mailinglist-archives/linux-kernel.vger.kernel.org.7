Return-Path: <linux-kernel+bounces-806937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 761EAB49DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709D01B27DBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27530F55A;
	Mon,  8 Sep 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vl/TitJ1"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF61CAB3;
	Mon,  8 Sep 2025 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757375652; cv=none; b=ZEz043fonwaMqUrQhFASGM4UctQ1InO5e87tmppMHwTpN9kHUi5uEggQNKD2B0+vrHWJJpyr7gjv4/Jd+72c0/B739Zgjhppb4cMShhvEDuP4+Wj/HR7MfnoAQjaycu88RK6lg0rEYCROh7KzUXt6vAJMvJmk0KHhMJIAi7lYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757375652; c=relaxed/simple;
	bh=ly7CTMr4mIx5AaQeK4649clssh8IeOW+xSDP7sfrrgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mD5zf04vbo9tSO7adZwV0VReiwezr/FOITCbmUmKWCfPBTT33qLU8TZTdkgmKzs8hPp3q8vuvvgM7M3N8rUvufLV+xOYi1iKqF9MpfOo776V7J9KYxzh2OdDjib0H8Gh3q0JRDgJVBqwPdKbGbjtA/2CBNlWR8YZm0ZJK/e0ayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vl/TitJ1; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588Nrwco157409;
	Mon, 8 Sep 2025 18:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757375638;
	bh=FA0eYhlR2xlodyIPW1bPxXyYyCye7Q6E/s6/N3iUc0Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Vl/TitJ1udI6uYa9KYx7mu/72yKTH3zGa6OSpbIxeYyxzm3fDe/X9XwYFObpZ0J2e
	 rGVkOBs31rsCt2Kb/DugcBvGgl0VX147+MjAA/4uAKL36d3y4ENcZO2HAhVQlrgEPY
	 ZzMlltj9CtczQd0UVbz0MAiDtXvWfrvHzL8ryiDw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588Nrw912743428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 18:53:58 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 18:53:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 18:53:57 -0500
Received: from [10.247.30.162] (ula0226330.dhcp.ti.com [10.247.30.162])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588NrvkO1382580;
	Mon, 8 Sep 2025 18:53:57 -0500
Message-ID: <ce6f03fe-8d97-4146-964f-c2ba58a350c7@ti.com>
Date: Mon, 8 Sep 2025 18:53:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-am62p/j722s: Remove HS400
 support from common
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250908235207.473628-1-jm@ti.com>
 <20250908235207.473628-2-jm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250908235207.473628-2-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/8/25 6:52 PM, Judith Mendez wrote:
> Since eMMC HS400 has been descoped for J722s due to errata i2478 [0]
> and is supported for AM62Px device, remove eMMC HS400 support from
> common-main.dtsi and include only in am62p-main.dtsi.
> 
> [0] https://www.ti.com/lit/pdf/sprz575
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

>   arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ---
>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi              | 6 ++++++
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> index 4427b12058a6..0c05bcf1d776 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> @@ -576,15 +576,12 @@ sdhci0: mmc@fa10000 {
>   		bus-width = <8>;
>   		mmc-ddr-1_8v;
>   		mmc-hs200-1_8v;
> -		mmc-hs400-1_8v;
>   		ti,clkbuf-sel = <0x7>;
> -		ti,strobe-sel = <0x77>;
>   		ti,trm-icp = <0x8>;
>   		ti,otap-del-sel-legacy = <0x1>;
>   		ti,otap-del-sel-mmc-hs = <0x1>;
>   		ti,otap-del-sel-ddr52 = <0x6>;
>   		ti,otap-del-sel-hs200 = <0x8>;
> -		ti,otap-del-sel-hs400 = <0x5>;
>   		ti,itap-del-sel-legacy = <0x10>;
>   		ti,itap-del-sel-mmc-hs = <0xa>;
>   		ti,itap-del-sel-ddr52 = <0x3>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 6aea9d3f134e..020bd121a6a3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -74,3 +74,9 @@ &main_gpio1 {
>   	gpio-reserved-ranges = <32 10>;
>   	ti,ngpio = <52>;
>   };
> +
> +&sdhci0 {
> +	mmc-hs400-1_8v;
> +	ti,strobe-sel = <0x77>;
> +	ti,otap-del-sel-hs400 = <0x5>;
> +};


