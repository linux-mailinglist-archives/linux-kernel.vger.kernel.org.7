Return-Path: <linux-kernel+bounces-806913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE57B49D78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DC04E43C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88B2FC894;
	Mon,  8 Sep 2025 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UoddI0GY"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118B22422A;
	Mon,  8 Sep 2025 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757373960; cv=none; b=FgFbYNoXQ2WUd8qhjU72eg62/9ohdbUIALSMF5f6u90bcRC0iduX+ixnIMsm8z6IhnN0Fv9VFHKN9Elcm54jfEAMiJGiyxYeEE7/U7PtVlg+uXbRxHGYfmFqGfRX/BE0KC6EalWoH/pJJFrYFKPrSKE+x0OHCNK1m8c4MRiH+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757373960; c=relaxed/simple;
	bh=0IXl2l3D+T2nhXGi4tQibdU53zosZMhElMuvaFdM3Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Di0H36clKqoHFbfq309oMjaEmfHGv954VrXbfQAo+TUQlHkjEpr+zK/G1gKJg3BHVPZaTlfcCL5jo0lzbsNltfsJhaMdBe6Hp0IweC58zt3W2djYw/CWd5lYdfbUGJ7eWE76ejgaAs6v01cdTOcCBzZJwIP2EArmSQOCE3TFJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UoddI0GY; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588NPpHu3892219;
	Mon, 8 Sep 2025 18:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757373951;
	bh=1JTskB/UCChEzoe+7IbsfNIUYnxNVPm3fPK+F6ahfQc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UoddI0GYQB+zGqKKbu3v8TmBLU93NKVHzqxnPThLX+Q6NHiRI+6jz985GqMjUB+M8
	 US7nT49t11ITmspasIhoQy4dfhjRApD7E4ql+ptXI9SkljRDlyeCZn9xcYts5JOGMN
	 VvjNbU0megVyekf3ZkPNrLebttChTI6KGKA4QVy8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588NPpbC2731831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 18:25:51 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 18:25:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 18:25:51 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588NPphW1651879;
	Mon, 8 Sep 2025 18:25:51 -0500
Message-ID: <f6c8abba-75f6-4a68-846a-780d37bb94fe@ti.com>
Date: Mon, 8 Sep 2025 18:25:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am62p/j722s: Remove HS400
 support from common
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250908173831.269039-1-jm@ti.com>
 <20250908173831.269039-2-jm@ti.com>
 <363878df-528b-4959-945f-3b531f156679@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <363878df-528b-4959-945f-3b531f156679@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

On 9/8/25 3:44 PM, Andrew Davis wrote:
> On 9/8/25 12:38 PM, Judith Mendez wrote:
>> Since eMMC HS400 has been descoped for J722s due to errata i2478 [0]
>> and is supported for AM62Px device, remove eMMC HS400 support from
>> common-main.dtsi and include only in am62p-main.dtsi.
>>
>> [0] https://www.ti.com/lit/pdf/sprz575
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ---
>>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi              | 6 ++++++
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/ 
>> arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> index 4427b12058a6..0c05bcf1d776 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> @@ -576,15 +576,12 @@ sdhci0: mmc@fa10000 {
>>           bus-width = <8>;
>>           mmc-ddr-1_8v;
>>           mmc-hs200-1_8v;
>> -        mmc-hs400-1_8v;
>>           ti,clkbuf-sel = <0x7>;
>> -        ti,strobe-sel = <0x77>;
>>           ti,trm-icp = <0x8>;
>>           ti,otap-del-sel-legacy = <0x1>;
>>           ti,otap-del-sel-mmc-hs = <0x1>;
>>           ti,otap-del-sel-ddr52 = <0x6>;
>>           ti,otap-del-sel-hs200 = <0x8>;
>> -        ti,otap-del-sel-hs400 = <0x5>;
>>           ti,itap-del-sel-legacy = <0x10>;
>>           ti,itap-del-sel-mmc-hs = <0xa>;
>>           ti,itap-del-sel-ddr52 = <0x3>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/ 
>> boot/dts/ti/k3-am62p-main.dtsi
>> index 6aea9d3f134e..90afe21e972b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> @@ -31,6 +31,12 @@ usb1: usb@31100000 {
>>               snps,usb2-lpm-disable;
>>           };
>>       };
>> +
>> +    sdhci0: mmc@fa10000 {
> 
> The node already has a label where it is defined, so you could just use:
> 
> &sdhci0 {
>     ...
> 
> here at the base level, and not have it inside cbass_main.
> 

Oops, missed that detail, thanks Andrew. Will fix for v3.

~ Judith


