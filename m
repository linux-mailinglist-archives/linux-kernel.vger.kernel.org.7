Return-Path: <linux-kernel+bounces-782455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D6B32092
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3AB1D24C17
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67EE3093A0;
	Fri, 22 Aug 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MQ4XfgrR"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4000307AEF;
	Fri, 22 Aug 2025 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880378; cv=none; b=JofBWm69bSiU7Yb3PMgoPPwnMAhZprks1bF+Y5LmSLwZ1W7dFnKfTLYJIxnD+a8MQN2/4EXTCn5xlGZxlbjbnWY1wETN4ShUuRvuVmUklImvKfDEpwOtaUdvDZ0exWHeIJP4y5jgnIwCLPbuMkBeXQ4tse2oIdrfF3/nQSxnWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880378; c=relaxed/simple;
	bh=v8ugcgTu7bbLe8dolOnMLhzuaOv9SbsTPs8vI8fWV4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QYAtAkKMP+WAxSw7EU0sU4kAvK/uWKzDUA/penvV25rTuDXKqk+VrMzH9D/6ennUR13PfRcchrGTwXceuB/cTjJ6//6FXrRkKlazBr/plv/fZEAtn1xF7PJDnFi0GyOsiTDxOi94iki9YoJSGcrNis3FMdMtgmTbl9oPBolAXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MQ4XfgrR; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MGWngF287782;
	Fri, 22 Aug 2025 11:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755880369;
	bh=NTnjIUy88MysrGcFmO7KCg/wbiZ4kQxZ42DLi+ANSIg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MQ4XfgrRIfp3DZoJlaa9zoJqSLZSWrtgmhkgWqI5oyM6R24LkFFXrTrHn61b7AlMt
	 1XK3bRBrwQ36O8plpKH5MbZau4gR0BvvSD/w7br3zMG6jhIjHKAHU+mPhe3s7qKru4
	 CWnZneP8rx6mTlotIeRdGdg5o1+rElCPZFOvB1uY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MGWnRw3403910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 11:32:49 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 11:32:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 11:32:49 -0500
Received: from [10.249.139.51] ([10.249.139.51])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MGWd6e3822193;
	Fri, 22 Aug 2025 11:32:40 -0500
Message-ID: <c3e31030-4f4f-4235-84c7-93a62265bce5@ti.com>
Date: Fri, 22 Aug 2025 22:02:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] arm64: dts: ti: k3-j7200: Enable remote processors
 at board level
To: "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <afd@ti.com>, <hnagalla@ti.com>, <jm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-2-b-padhi@ti.com>
 <b257999d-df16-405c-830b-5397da37c6ed@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <b257999d-df16-405c-830b-5397da37c6ed@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Udit,

On 8/15/2025 8:00 AM, Kumar, Udit wrote:
> Hello Beleswar,
>
> On 8/15/2025 4:08 AM, Beleswar Padhi wrote:
>> Remote Processors defined in top-level J7200 SoC dtsi files are
>> incomplete without the memory carveouts and mailbox assignments which
>> are only known at board integration level.
>>
>> Therefore, disable the remote processors at SoC level and enable them at
>> board level where above information is available.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 3 +++
>>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 3 +++
>>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi     | 9 +++++++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> index 5ce5f0a3d6f5..628ff89dd72f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> @@ -1516,6 +1516,7 @@ main_r5fss0: r5fss@5c00000 {
>>           ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
>>                <0x5d00000 0x00 0x5d00000 0x20000>;
>>           power-domains = <&k3_pds 243 TI_SCI_PD_EXCLUSIVE>;
>> +        status = "disabled";
>>             main_r5fss0_core0: r5f@5c00000 {
>>               compatible = "ti,j7200-r5f";
>> @@ -1530,6 +1531,7 @@ main_r5fss0_core0: r5f@5c00000 {
>>               ti,atcm-enable = <1>;
>>               ti,btcm-enable = <1>;
>>               ti,loczrama = <1>;
>> +            status = "disabled";
>>           };
>>             main_r5fss0_core1: r5f@5d00000 {
>> @@ -1545,6 +1547,7 @@ main_r5fss0_core1: r5f@5d00000 {
>>               ti,atcm-enable = <1>;
>>               ti,btcm-enable = <1>;
>>               ti,loczrama = <1>;
>> +            status = "disabled";
>>           };
>>       };
>>   diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> index 56ab144fea07..692c4745040e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> @@ -612,6 +612,7 @@ mcu_r5fss0: r5fss@41000000 {
>>           ranges = <0x41000000 0x00 0x41000000 0x20000>,
>>                <0x41400000 0x00 0x41400000 0x20000>;
>>           power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
>> +        status = "disabled";
>
> Please leave boot critical fw as is.


The nodes that are disabled here, are enabled back in the
board level files. So, it has no effective change on the boards.

>
> Here are my suggestions
>
>  create one boot-critical-fw-dtsi for mcu_r5fss0 , include this fw 
> files in all boards.


That is the plan for a future series :)

Thanks,
Beleswar

>
> other IPC optional firmware can reside in one dtsi or dtso,
>
>
>> [..]

