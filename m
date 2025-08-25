Return-Path: <linux-kernel+bounces-784017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91FB3355B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D371B2349E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4696F28003A;
	Mon, 25 Aug 2025 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zNfKKnm6"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8D265637;
	Mon, 25 Aug 2025 04:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096802; cv=none; b=TuLyu1FZ7zM897G/IYCQjL4uB018rPvtTLEVCJ+jd5c41xYL6XsMKzMrJNT278GrcF+gx4YGT2XR1l8MxR5p63H54iuti7Zt1+q/Rtw83+9EjRe6Kw/JEJY3hxjU9vsr30lWqaH0/CECy/EOeyUsWYPeKui4FGiQ7/y6IaZ9vwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096802; c=relaxed/simple;
	bh=2bS2WCOiM9KnUbU7WqB/GMBmRW+z+aKD0eB9g9X0apM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qOCNWELkULeDMgNKLwTnr/EqyD1ZzB4QiZ7vga0y61V4h8yhmxbxEk8M8C7Pk8hoNWvS/xKqTa+WSEePkyYyqRUkvyrMg9YRciUmsm73WrRc482VsBWCyevrii/tNTp36/xws8aP8VG+v7PvHMFK6zjuFPF+qpNRGrWMy/qgldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zNfKKnm6; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57P4dQKX1195045;
	Sun, 24 Aug 2025 23:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756096766;
	bh=JyUP00cWbb14rAirUBQRIORCjenMTRA6DeX7+PzevOE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=zNfKKnm6hktqPhTyiEO8kv550jEw4hSHeQggowdjiX8sRLfYkdwXokFiB0VDq9WQI
	 WKuGaA87pYkkJjFl314qmptUkXxyg+XweHlWH9bwuqGCZnsseh62rTzGld45pH1ZNa
	 Z4735O329PTJJkmmWGNeJSe6UKacFoeQHJ+zoO2Y=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57P4dQbn609297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 24 Aug 2025 23:39:26 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 24
 Aug 2025 23:39:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 24 Aug 2025 23:39:25 -0500
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57P4dKiC3303762;
	Sun, 24 Aug 2025 23:39:21 -0500
Message-ID: <c56a779f-d4dc-49ce-874a-30ef96a0a1f0@ti.com>
Date: Mon, 25 Aug 2025 10:09:20 +0530
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
 <ecff956d-1019-41d0-9bfc-b0bdc30e87ba@ti.com>
 <aKnvrh2TSksb_39i@livingston.pivistrello.it>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <aKnvrh2TSksb_39i@livingston.pivistrello.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 23/08/25 22:13, Francesco Dolcini wrote:
> On Fri, Aug 22, 2025 at 10:09:48PM +0530, Beleswar Prasad Padhi wrote:
>> On 8/21/2025 11:36 AM, Francesco Dolcini wrote:
>>> On Fri, Aug 15, 2025 at 04:08:22AM +0530, Beleswar Padhi wrote:
>>>> The wkup_r5fss0_core0_memory_region is used to store the text/data
>>>> sections of the Device Manager (DM) firmware itself and is necessary for
>>>> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
>>>> for allocating the Virtio buffers needed for IPC with the DM core which
>>>> could be optional. The labels were incorrectly used in the
>>>> k3-am62p-verdin.dtsi file. Correct the firmware memory region label.
>>>>
>>>> Currently, only mailbox node is enabled with FIFO assignment. However,
>>>> there are no users of the enabled mailboxes. Add the missing carveouts
>>>> for WKUP and MCU R5F remote processors, and enable those by associating
>>>> to the above carveout and mailboxes. This config aligns with other AM62P
>>>> boards and can be refactored out later.
>>>>
>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>> ---
>>>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>> Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>>>> Cc: Parth Pancholi <parth.pancholi@toradex.com>
>>>> Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
>>>> Requesting for a review/test.
>>>>
>>>>   arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi | 42 ++++++++++++++++++++-
>>>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
>>>> index 6a04b370d149..0687debf3bbb 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
>>>> @@ -162,7 +162,25 @@ secure_ddr: optee@9e800000 {
>>>>   			no-map;
>>>>   		};
>>>> -		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
>>>> +		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
>>>> +			compatible = "shared-dma-pool";
>>>> +			reg = <0x00 0x9b800000 0x00 0x100000>;
>>>> +			no-map;
>>>> +		};
>>>> +
>>>> +		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
>>> Node name should be generic, `memory@9b900000` ?
>>
>> Humm, that memory is reserved and has the 'no-map' property. So it
>> technically is only used by the node which references it (a particular
>> rproc in this case), and never used by Linux for any allocations. So it
>> is not generic memory per say...
>>
>> So I was inclined for putting the specific node name which uses the
>> carveout in the label. What do you think?
> My understanding is that the node name must be generic, as required by
> the DT specification. What matters is that this is memory, not what is used
> for.


Sorry, I misinterpreted node name with label. I will fix this in v3
Will wait for any other comments on v2:
https://lore.kernel.org/all/20250823160901.2177841-1-b-padhi@ti.com/

Thanks,
Beleswar

>
>
> So it should be something like
>
>
> mcu_r5fss0_core0_dma_memory: memory@9c900000 {
> 	compatible = "shared-dma-pool";
> 	reg = <0x00 0x9b800000 0x00 0x100000>;
> 	no-map;
> };
>
>
> Francesco
>

