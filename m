Return-Path: <linux-kernel+bounces-782461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472C8B320AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5F6AA5884
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A2305E04;
	Fri, 22 Aug 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CT+fJdAi"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096203043B2;
	Fri, 22 Aug 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880814; cv=none; b=HckNNPh0OCfCmaFBMmDuv9mzmpdnfuVtj4sB8XrkEfRQkg+mZlUww1lgrzaPTY3eeVSDKp5o+8u1Gn4Dy0burxoKBtqkT0whFt01t1CHkLbrLxAcuspEc5i9XbrbiVSQoNBh1sbZwg8bprTHQaL3iO5NPtRwhTtwdgvtPSTrYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880814; c=relaxed/simple;
	bh=XhTpkxvx4Bh/Fu9SxN3bEQdCgA5hUs4DjYlGrXbVmpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r74YSh5CZO4Ay0zST9Ez6tpAsNqW8tRArE0sUa8lbF7FCbUOQj++V+B7t3pVpiEywG3ILb3f/4jYpWLlxfy4EjT4H/ABVkpqId620vlECcg6Qyymz4Bs92CUO4Dws3ipLV0UazW0NazRSXelV7qnX1vFUz3lsJFUXGnqtQuNDK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CT+fJdAi; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MGduNv291327;
	Fri, 22 Aug 2025 11:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755880796;
	bh=/RPSsH3f3z2Vqavjrk93revEmME+1uytS0pwCHeGwAQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CT+fJdAiV2ghPTF/zj9h11E/n3/x1ouiAYNoCz2tNiTuAe5TyskzJaPVae0gQWJVv
	 9BSeetRWCRfFIzZWikZlD7fn6+EGpAolqrFk/2q/BaHIDGR9WqwW1WgrmTO2ZZ1mLC
	 0ttzdyI/an2R5QihtrMhm7fyBlcpzfrxpwS4arSY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MGduAJ3039382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 11:39:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 11:39:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 11:39:56 -0500
Received: from [10.249.139.51] ([10.249.139.51])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MGdn3B3828477;
	Fri, 22 Aug 2025 11:39:50 -0500
Message-ID: <ecff956d-1019-41d0-9bfc-b0bdc30e87ba@ti.com>
Date: Fri, 22 Aug 2025 22:09:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/33] arm64: dts: ti: k3-am62p-verdin: Add missing cfg
 for TI IPC Firmware
To: Francesco Dolcini <francesco@dolcini.it>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afd@ti.com>,
        <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Emanuele Ghidoli
	<emanuele.ghidoli@toradex.com>,
        Parth Pancholi <parth.pancholi@toradex.com>,
        Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-17-b-padhi@ti.com>
 <20250821060629.GB7503@francesco-nb>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20250821060629.GB7503@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 8/21/2025 11:36 AM, Francesco Dolcini wrote:
> On Fri, Aug 15, 2025 at 04:08:22AM +0530, Beleswar Padhi wrote:
>> The wkup_r5fss0_core0_memory_region is used to store the text/data
>> sections of the Device Manager (DM) firmware itself and is necessary for
>> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
>> for allocating the Virtio buffers needed for IPC with the DM core which
>> could be optional. The labels were incorrectly used in the
>> k3-am62p-verdin.dtsi file. Correct the firmware memory region label.
>>
>> Currently, only mailbox node is enabled with FIFO assignment. However,
>> there are no users of the enabled mailboxes. Add the missing carveouts
>> for WKUP and MCU R5F remote processors, and enable those by associating
>> to the above carveout and mailboxes. This config aligns with other AM62P
>> boards and can be refactored out later.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
>> Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>> Cc: Parth Pancholi <parth.pancholi@toradex.com>
>> Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
>> Requesting for a review/test.
>>
>>   arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi | 42 ++++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
>> index 6a04b370d149..0687debf3bbb 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
>> @@ -162,7 +162,25 @@ secure_ddr: optee@9e800000 {
>>   			no-map;
>>   		};
>>   
>> -		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
>> +		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0x9b800000 0x00 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
> Node name should be generic, `memory@9b900000` ?


Humm, that memory is reserved and has the 'no-map' property. So it
technically is only used by the node which references it (a particular
rproc in this case), and never used by Linux for any allocations. So it
is not generic memory per say...

So I was inclined for putting the specific node name which uses the
carveout in the label. What do you think?

>
> this applies in multiple patches in this series
>
>
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0x9b900000 0x00 0xf00000>;
>> +			no-map;
>> +		};
>> +
>> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0x9c800000 0x00 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
>>   			compatible = "shared-dma-pool";
>>   			reg = <0x00 0x9c900000 0x00 0x01e00000>;
>>   			no-map;
>> @@ -848,6 +866,28 @@ mbox_mcu_r5_0: mbox-mcu-r5-0 {
>>   	};
>>   };
>>   
>> +&wkup_r5fss0 {
>> +	status = "okay";
>> +};
>> +
>> +&wkup_r5fss0_core0 {
>> +	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
>> +	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
>> +			<&wkup_r5fss0_core0_memory_region>;
>> +	status = "okay";
>> +};
>> +
>> +&mcu_r5fss0 {
>> +	status = "okay";
>> +};
>> +
>> +&mcu_r5fss0_core0 {
>> +	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
>> +	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
>> +			<&mcu_r5fss0_core0_memory_region>;
>> +	status = "okay";
>> +};
>> +
>>   &main0_alert {
>>   	temperature = <95000>;
>>   };
>> -- 
>> 2.34.1
>>

