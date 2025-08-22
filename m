Return-Path: <linux-kernel+bounces-782517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF1FB3217B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C761C27723
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EADF280A29;
	Fri, 22 Aug 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YX9L9seI"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFB1096F;
	Fri, 22 Aug 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883576; cv=none; b=avan3kEGiiUYZA4GEQWsFRgpFPTBzxXkOv0GP/MPVoAjEiIl3TOoxlEZfjnv1IAyn/TbDp8gCsDhOnh+Y24I9FCCIzIN57WCiihsCo7m/fXw9fR9fy6/O+hEGMTqPSIrP2GEHFjMqihxYWK9Jy9F1vvdxtrzsRyhjtRDcHn6+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883576; c=relaxed/simple;
	bh=EnYBmOMUMgHOtWNIvXTWSSwe2cfet+zGjc8f4XAiOtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EJpcfyAAFCCnueT0cGK2UJr/SbAVuAn6Vn2lXvjhqflsFD6YFFUlXWSObS3ah/tc0IFDhuFRXg2stxzTRNs4b5VlQ9UVe925aZfOOckGLingbQGx69KcX+Z7QjOp/zltB8eWHSL5oQ1D6p7tVKbTKI4NUvmLAUOHBGt5xlAixwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YX9L9seI; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MHQ6fb295383;
	Fri, 22 Aug 2025 12:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755883566;
	bh=96MWakcLYUDT4lNqC75SMCSgjUsPFgGv1W6nK3rjsuU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YX9L9seIhewXnb2QsC4bjdEtDoAMoXFkyWAnpsBFkN1PyVaWONu/7f8AeBq+eDf5Q
	 J6erPhEHgUV75IAmHNNLKgpq49I0zcvk9Qe/FJld1e6qI8Rd3HPc9+0ipN+hexI445
	 x3huy9SjjDXX3WwkwciYLeiSBsHHPAT9AfVjHtxM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MHQ6hu3435230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 12:26:06 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 12:26:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 12:26:05 -0500
Received: from [10.249.139.51] ([10.249.139.51])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MHQ1RA4168190;
	Fri, 22 Aug 2025 12:26:01 -0500
Message-ID: <a076e204-aa71-430e-a762-b8111d23d2e6@ti.com>
Date: Fri, 22 Aug 2025 22:56:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] arm64: dts: ti: k3-j7*-ti-ipc-firmware: Switch MCU
 R5F cluster to Split-mode
To: Andrew Davis <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-34-b-padhi@ti.com>
 <9a3f4271-ada2-48aa-b99d-023619ec5e12@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <9a3f4271-ada2-48aa-b99d-023619ec5e12@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew, Nishanth,

On 8/15/2025 9:18 PM, Andrew Davis wrote:
> On 8/14/25 5:38 PM, Beleswar Padhi wrote:
>> Several TI K3 SoCs like J7200, J721E, J721S2, J784S4 and J742S2 have a
>> R5F cluster in the MCU domain which is configured for LockStep mode at
>> the moment. The necessary support to use MCU R5F cluster in split mode
>> was added in the bootloader. And the TI IPC firmware for the split
>> processors is already available public.
>>
>> Therefore, Switch this R5F cluster to Split mode by default in all the
>> boards using TI IPC Firmware config (k3-j7*-ti-ipc-firmware). This
>> gives out an extra general purpose R5F core free to run any applications
>> as required. Lockstep mode remains default in the SoC level dtsi, so
>> downstream board dts which do not use TI IPC Firmware config should not
>> be impacted by this switch.
>>
>> Users who prefer to use the fault-tolerant lockstep mode with TI IPC
>> firmware config, can do that by setting `ti,cluster-mode` property to 1.
>
> What a user prefers and other configuration like that does not belong
> in devicetree, which should only describe the hardware.
>
> Configuration should be done using the normal methods, like kernel
> cmdline, module params, ioctls, etc.. Maybe we can even set the mode
> based on some signal in the firmware itself, like in the resource table.


Agreed with your point.. But that is going to take a long time to implement
+ upstream. I interpreted from [0] that it was okay to enable this split 
mode
once we had refactored the firmware related nodes in an overlay? (Since
people can swap out the dtsi if they don't need the firmware config)

Nishanth/Andrew,
Please advise if this patch is okay or should be dropped in the revision...

[0]: https://lore.kernel.org/all/20250523114822.jrv73frz2wbzdd6d@falsify/

Thanks,
Beleswar

>
> Andrew
>
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi | 1 +
>> arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi | 1 +
>> arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi | 1 +
>> .../boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi | 1 +
>>   4 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
>> index 8eff7bd2e771..ddf3cd899d0e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
>> @@ -94,6 +94,7 @@ &main_timer2 {
>>     &mcu_r5fss0 {
>>       status = "okay";
>> +    ti,cluster-mode = <0>;
>>   };
>>     &mcu_r5fss0_core0 {
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
>> index 5b3fa95aed76..57890a3b38a2 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
>> @@ -211,6 +211,7 @@ &main_timer15 {
>>   };
>>     &mcu_r5fss0 {
>> +    ti,cluster-mode = <0>;
>>       status = "okay";
>>   };
>>   diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
>> index 40c9f2b64e7e..7ee8a8615246 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
>> @@ -179,6 +179,7 @@ &main_timer5 {
>>   };
>>     &mcu_r5fss0 {
>> +    ti,cluster-mode = <0>;
>>       status = "okay";
>>   };
>>   diff --git 
>> a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
>> index b5a4496a05bf..e12fa55a4df0 100644
>> --- 
>> a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
>> +++ 
>> b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
>> @@ -254,6 +254,7 @@ &main_timer9 {
>>   };
>>     &mcu_r5fss0 {
>> +    ti,cluster-mode = <0>;
>>       status = "okay";
>>   };
>

