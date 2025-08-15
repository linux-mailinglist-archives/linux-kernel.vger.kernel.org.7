Return-Path: <linux-kernel+bounces-770051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17595B27642
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8821CC6E35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DD2292B53;
	Fri, 15 Aug 2025 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RxjyzX1G"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8B25B1F4;
	Fri, 15 Aug 2025 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225733; cv=none; b=c9iZ/Bsf5lX6l47jXaOlwiIhB9wUZ2OK0byZD1HiOqJYLUZ7zN/NtTkTa5nCSuxwh73brw06Qevt6tySbB8PZE8yodCgPFFAG+iGVXbBiJI5V4pzklnGo7Vy/qK97rqNNdF+3+AounsXaG7bGo+1Lu2wPaLvZkDo8VW0OUaD7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225733; c=relaxed/simple;
	bh=8Jnwog2oz4VwDiCj8F3rlocE1pPuSsttCobur+qqLvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g/id2Ttukf0XnyyvQs7S7LZb5dyCQakSogTx1PAg92CyW6alzvoeYOy2Lj7gEiSUrvPvv9/MbIvoKC7ab4KOcRP2FGaYvVyRMYOLIVlK8PsCTSy9oo7hjqGqa4VWD+PEARXRha2BeKX8AuU7mu8UaubC+zNOSeSwYLylvuodHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RxjyzX1G; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57F2g5SR2436546;
	Thu, 14 Aug 2025 21:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755225725;
	bh=wUO/5xkUeyV8DJVK1z5fhVBOB3vtOs7Z91loZr+p2WE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RxjyzX1GBZYGYFGlpvl9RDJrEnOgEmnDtuElW+1H5grwk9I0peQVpgi+fRRHOGx5r
	 vgRCEnVSw/G5Ner1+Sm1nADbBxmq5D3T3S4axIUu5yqVGpsWWeMbQsZ7EnBoHdRR58
	 6gbmQqooLwbJeLUXu2CGi5kwvU6Rlr6PuuzQsYuE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57F2g5aH2279690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 21:42:05 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 21:42:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 21:42:04 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57F2fxG9357354;
	Thu, 14 Aug 2025 21:42:00 -0500
Message-ID: <f49bf01b-6704-4a03-9b3d-7f7495e544e0@ti.com>
Date: Fri, 15 Aug 2025 08:11:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] arm64: dts: ti: k3-j7*-ti-ipc-firmware: Switch MCU
 R5F cluster to Split-mode
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <afd@ti.com>, <hnagalla@ti.com>, <jm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-34-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250814223839.3256046-34-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 8/15/2025 4:08 AM, Beleswar Padhi wrote:
> Several TI K3 SoCs like J7200, J721E, J721S2, J784S4 and J742S2 have a
> R5F cluster in the MCU domain which is configured for LockStep mode at
> the moment. The necessary support to use MCU R5F cluster in split mode
> was added in the bootloader. And the TI IPC firmware for the split
> processors is already available public.

It will be better to mention sha id of bootloader with links, may be 
below tear-line


> Therefore, Switch this R5F cluster to Split mode by default in all the
> boards using TI IPC Firmware config (k3-j7*-ti-ipc-firmware). This
> gives out an extra general purpose R5F core free to run any applications
> as required. Lockstep mode remains default in the SoC level dtsi, so
> downstream board dts which do not use TI IPC Firmware config should not
> be impacted by this switch.
>
> Users who prefer to use the fault-tolerant lockstep mode with TI IPC
> firmware config, can do that by setting `ti,cluster-mode` property to 1.

IMO,  you need to change boot-loader as well for this,


>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi             | 1 +
>   arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi             | 1 +
>   arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi            | 1 +
>   .../boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi     | 1 +
>   4 files changed, 4 insertions(+)
> [..]


