Return-Path: <linux-kernel+bounces-771131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C59B2833A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 877F34E10F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425842FD7AB;
	Fri, 15 Aug 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gpfYK/3t"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100C305E1A;
	Fri, 15 Aug 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272924; cv=none; b=fpUidlg51PZfPabWUsUsKsrpW07BjMj5u9MdFQHQD96JfGhycrubWKGoIwTDSVulLSEYCfs4ZvYhRClZ1hO+x+MQkL4oCXXN/PLGNBsnRY9Y68Usq6svcKuxvUwsmg/KVxo+KuKrF3sPJodA2zLCOKYZSJEh2EZlXB4kbJ8GuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272924; c=relaxed/simple;
	bh=W19Q0xBTJj2Y3o+tujlMVXEuQd9/STAMjjntI9ShhOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MDOf1B85cVExaTLijIsaoBnfU/3yJo+G+goibjOkIP102k+OPmjhxnp1smNHtBA2GtXMMjk06RmHGOzMSUM0T9bfjTEESTFUELfmys7Ekbxr70JLJyyNXyTw5krHJesvnPAPBqWdYajen1wnj0SOuKxmdniSHnUtZZG6GJhYi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gpfYK/3t; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57FFmaN02635242;
	Fri, 15 Aug 2025 10:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755272916;
	bh=g3R0ShOKrYC/TrDizkBvGx4oi8w9wLjh05UMIqlG41U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gpfYK/3tjHiVHDN+66MlpfI4wqkkq64ZmhqiYZHgk0E63n2OQFPM63xDEPgIAcZ/x
	 ElEFBrA9zQcsjJOTPTZPzRZ52Tg8v6vApFm0i3uQ9OHDzhh2HMHejwDV/rpsPa8N29
	 OaKWIkbKRyz2mZ0UGO8UrEpj8FiQ7xQpj0vymN0o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57FFmaNM1999922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 15 Aug 2025 10:48:36 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 15
 Aug 2025 10:48:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 15 Aug 2025 10:48:36 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57FFmZpr1197117;
	Fri, 15 Aug 2025 10:48:35 -0500
Message-ID: <9a3f4271-ada2-48aa-b99d-023619ec5e12@ti.com>
Date: Fri, 15 Aug 2025 10:48:35 -0500
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
CC: <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-34-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250814223839.3256046-34-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/14/25 5:38 PM, Beleswar Padhi wrote:
> Several TI K3 SoCs like J7200, J721E, J721S2, J784S4 and J742S2 have a
> R5F cluster in the MCU domain which is configured for LockStep mode at
> the moment. The necessary support to use MCU R5F cluster in split mode
> was added in the bootloader. And the TI IPC firmware for the split
> processors is already available public.
> 
> Therefore, Switch this R5F cluster to Split mode by default in all the
> boards using TI IPC Firmware config (k3-j7*-ti-ipc-firmware). This
> gives out an extra general purpose R5F core free to run any applications
> as required. Lockstep mode remains default in the SoC level dtsi, so
> downstream board dts which do not use TI IPC Firmware config should not
> be impacted by this switch.
> 
> Users who prefer to use the fault-tolerant lockstep mode with TI IPC
> firmware config, can do that by setting `ti,cluster-mode` property to 1.

What a user prefers and other configuration like that does not belong
in devicetree, which should only describe the hardware.

Configuration should be done using the normal methods, like kernel
cmdline, module params, ioctls, etc.. Maybe we can even set the mode
based on some signal in the firmware itself, like in the resource table.

Andrew

> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi             | 1 +
>   arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi             | 1 +
>   arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi            | 1 +
>   .../boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi     | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
> index 8eff7bd2e771..ddf3cd899d0e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
> @@ -94,6 +94,7 @@ &main_timer2 {
>   
>   &mcu_r5fss0 {
>   	status = "okay";
> +	ti,cluster-mode = <0>;
>   };
>   
>   &mcu_r5fss0_core0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
> index 5b3fa95aed76..57890a3b38a2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
> @@ -211,6 +211,7 @@ &main_timer15 {
>   };
>   
>   &mcu_r5fss0 {
> +	ti,cluster-mode = <0>;
>   	status = "okay";
>   };
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
> index 40c9f2b64e7e..7ee8a8615246 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
> @@ -179,6 +179,7 @@ &main_timer5 {
>   };
>   
>   &mcu_r5fss0 {
> +	ti,cluster-mode = <0>;
>   	status = "okay";
>   };
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
> index b5a4496a05bf..e12fa55a4df0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
> @@ -254,6 +254,7 @@ &main_timer9 {
>   };
>   
>   &mcu_r5fss0 {
> +	ti,cluster-mode = <0>;
>   	status = "okay";
>   };
>   


