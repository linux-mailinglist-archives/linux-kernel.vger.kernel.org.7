Return-Path: <linux-kernel+bounces-807038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E1BB49F2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD6B1BC57E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2F82472A2;
	Tue,  9 Sep 2025 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hZaGVsCc"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1F2236F0;
	Tue,  9 Sep 2025 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384659; cv=none; b=H9P/6lryC42eFRxBWErxx3l02Zg0UdTVZQqUpMeTUvAlFIPE/EjzREWXZDC41NJCLknATb7MrL9xE8Kpcp4FSDq1oUe1I8h82GdddsAOQRUJsGTuOt+byNtyef88A+88xIxhfLVW9JTUl5gXYcZXjZCh507gUqvePtD80zwN2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384659; c=relaxed/simple;
	bh=3f884xCri4OCK90kiIIvM+z4asmXOsZ1RSRgK/oHszY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DpxW8baEchDkUT9vKc5zv6jNxG+zl9bJNSAQQEzwIPsvFE+8kZP7IT4Ec9C/HnchGByTVTKSOWTQKbjYW06qq/EuqF18wj+m7DiTs1OJ3+VnCcCJfsQDWSmhGGK6D+iivnwW7Ava1dfxCW3XJAcbKxl1OPIkIq129mc8j4eDA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hZaGVsCc; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5892O885186010;
	Mon, 8 Sep 2025 21:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757384648;
	bh=IEgr5tNDDBISJ6Mfe2ROy7COOynN6nLSGh/JDvk/TmU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hZaGVsCcBUdNYjAfCJY2HfHwxN0MGJbSIwXko2+HNbmYKMtBt1C+ZDFEc716/1Yby
	 M852lgbmzT6/ixQTeTT/JJp3f6qnWfRAKvtKQ4RaUBXUv/XveShvNkzr+bt9/TL/w9
	 bLgvGiym55dvTqNVzkMnZ0b6bAt6aOMz62B7WGRc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5892O8sE3387810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 21:24:08 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 21:24:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 21:24:07 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5892O2uw1857858;
	Mon, 8 Sep 2025 21:24:03 -0500
Message-ID: <62f0c51c-3c04-4735-93c6-84766cf0e2a5@ti.com>
Date: Tue, 9 Sep 2025 07:54:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] arm64: dts: ti: k3-am62p5-sk: Remove the unused
 cfg in USB1_DRVVBUS
To: Kendall Willis <k-willis@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <d-gole@ti.com>, <u-kumar1@ti.com>,
        <sebin.francis@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
References: <20250905051448.2836237-1-a-kaur@ti.com>
 <20250905051448.2836237-2-a-kaur@ti.com>
 <5f5d78e2-5aec-4412-b900-3281c391a444@ti.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <5f5d78e2-5aec-4412-b900-3281c391a444@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Kendall,

On 09/09/25 02:51, Kendall Willis wrote:
> On 9/5/25 00:14, Akashdeep Kaur wrote:
>> After the SoC has entered the DeepSleep low power mode, USB1 can be used
>> to wakeup the SoC based on USB events triggered by USB devices. This
>> requires that the pin corresponding to the Type-A connector remains 
>> pulled
>> up even after the SoC has entered the DeepSleep low power mode.
>> For that, either DeepSleep pullup configuration can be selected or the 
>> pin
>> can have the same configuration that it had when SoC was in active mode.
>> But, in order for DeepSleep configuration to take effect, the DeepSleep
>> control bit has to be enabled.
> 
> The last sentence wording is confusing because it sounds like a 
> DeepSleep control bit still needs to be enabled which is not seen in the 
> patch. If possible, drop this sentence and do the same for the other 
> similar patch in this series.

Sounds good! Removed.

Regards,
Akashdeep Kaur
> 
>> Remove the unnecessary DeepSleep state configuration from USB1_DRVBUS 
>> pin,
>> as the DeepSleep control bit is not set and the active configuration is
>> sufficient to keep the pin pulled up. This simplifies the setup and 
>> removes
>> redundant configuration.
>>
>> This reverts commit 115290c112952db27009668aa7ae2f29920704f0.
>>
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> 
> Verified USB disconnect, USB connect, and USB remote wakeup on AM62P SKEVM.
> 
> Tested-by: Kendall Willis <k-willis@ti.com>
> 
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/ 
>> boot/dts/ti/k3-am62p5-sk.dts
>> index 899da7896563..e8f0ac2c55e2 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> @@ -360,7 +360,7 @@ AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) 
>> MCASP0_ACLKR.UART1_TXD */
>>       main_usb1_pins_default: main-usb1-default-pins {
>>           pinctrl-single,pins = <
>> -            AM62PX_IOPAD(0x0258, PIN_INPUT | PIN_DS_PULLUD_ENABLE | 
>> PIN_DS_PULL_UP, 0) /* (G21) USB1_DRVVBUS */
>> +            AM62PX_IOPAD(0x0258, PIN_INPUT, 0) /* (G21) USB1_DRVVBUS */
>>           >;
>>       };
> 


