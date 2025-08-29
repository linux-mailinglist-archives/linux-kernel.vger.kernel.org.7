Return-Path: <linux-kernel+bounces-791192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0BB3B33D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5963B791D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A56723ABBD;
	Fri, 29 Aug 2025 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VlAr7cp1"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D699207A20;
	Fri, 29 Aug 2025 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448342; cv=none; b=bllLAzzvLZygy6YSNG8mzD/5a5pYu1EkHhb1BCY8Wc0gl72wCLXHSqcMaDjvzV/YLU5KEIt4qyox9t94eixCaFbNLEKA6KTycIjY5yrG7VKi6KmkLXAi1+Fp0iC61RJ2YaKmFFhN10C89w7fH2hTfVfGxYF9wM7qPFBFLKLcigc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448342; c=relaxed/simple;
	bh=P9Q0SmdKT4+QR+pS62JZey3140CaFSXQyb5AfpmgPrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kMIBOUhLauIr5WA84CaULcEJx971avEC7WuEqDP13mdyiOIU2Zp28t1BQjo6kfX907pElhFByZJ5HAvEYkT65u39amIee8kfeFAhEyDXvbCF5mLZEeoToAq/W6tzw37f7I2Z6Hw+jsK0rp537tYU3qjlApnjGfaaexIAeP1Bl84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VlAr7cp1; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T6IrnH2151732;
	Fri, 29 Aug 2025 01:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756448333;
	bh=3IPwZazoSn4ZeSr5DFrwiRXhN0snIHoAAJIH9eLfr9U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VlAr7cp1b4CRn3SlUE3hf7hIh7IZy/hHvtEir/A8wQug1degH7AhhyKmubIkPa5vl
	 9lfYiNyPXKy4wnhWicf7HGtm5Nhzt5rkxHrpwHVirZBN72EcpOaIC1QZfRBNW0/Szi
	 pYdaqIVn8+Ff7bc2ksiE7BHEllszOJ4pIEEFRTKc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T6IqF43805307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 01:18:53 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 01:18:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 01:18:52 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T6ImNR1891002;
	Fri, 29 Aug 2025 01:18:48 -0500
Message-ID: <c542ad3f-8e6d-405a-92d3-4e45cbcfc2a3@ti.com>
Date: Fri, 29 Aug 2025 11:48:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j742s2-mcu-wakeup: Override
 firmware-name for MCU R5F cores
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <afd@ti.com>, <hnagalla@ti.com>, <jm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <u-kumar1@ti.com>
References: <20250823163111.2237199-1-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250823163111.2237199-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 8/23/2025 10:01 PM, Beleswar Padhi wrote:
> The J742S2 SoC reuses the common k3-j784s4-j742s2-mcu-wakeup-common.dtsi
> for its MCU domain, but it does not override the firmware-name property
> for its R5F cores. This causes the wrong firmware binaries to be
> referenced.
>
> Introduce a new k3-j742s2-mcu-wakeup.dtsi file to override the
> firmware-name property with correct names for J742s2.
>
> Fixes: 38fd90a3e1ac ("arm64: dts: ti: Introduce J742S2 SoC family")
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v2: Changelog:
> 1. Posted this patch as a fix as decided in v1, so added Fixes tag.
>
> Link to v1:
> https://lore.kernel.org/all/20250522073426.329344-2-b-padhi@ti.com/
>
>   .../arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi | 17 +++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j742s2.dtsi           |  1 +
>   2 files changed, 18 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi
> new file mode 100644
> index 000000000000..61db2348d6a4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Device Tree Source for J742S2 SoC Family
> + *
> + * TRM: https://www.ti.com/lit/pdf/spruje3
> + *
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + */
> +
> +&mcu_r5fss0_core0 {
> +	firmware-name = "j742s2-mcu-r5f0_0-fw";
> +};
> +
> +&mcu_r5fss0_core1 {
> +	firmware-name = "j742s2-mcu-r5f0_1-fw";
> +};


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> diff --git a/arch/arm64/boot/dts/ti/k3-j742s2.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
> index 7a72f82f56d6..d265df1abade 100644
> --- a/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
> @@ -96,3 +96,4 @@ cpu3: cpu@3 {
>   };
>   
>   #include "k3-j742s2-main.dtsi"
> +#include "k3-j742s2-mcu-wakeup.dtsi"

