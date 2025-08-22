Return-Path: <linux-kernel+bounces-782451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55690B3208A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B495C1729
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA332877C2;
	Fri, 22 Aug 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qnISp+mN"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9712874F2;
	Fri, 22 Aug 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880035; cv=none; b=T/ACQABHcvzDAW3hC44lPT6IHyBoqpESokp6Mj+ATyKG9r8blAJFZ9OzvuynWsKo/3t1NQvPbV050B3ADo0qPcteUgp65UQYpcRf+905Eyn5St809Gtfk/l0hpML74o1/MRkjkqiHb6/fyZn7W0tZDHmoEaZ5yJqE3LxRliFK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880035; c=relaxed/simple;
	bh=T52iIRNe81x/04FUljG/GL6llSB/XKYQ77ttCo4+nTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lJiT+5/6NTIFSe9B45LLwFgDdSKO7T529NnTxx1M7WXSISco33OotliL6dRxiZDmdsTqCpQ0zbvAI3+yV8wfoKTvWMWgpebaTrvxzrvHcuEYaOOT/N1/BCP/D4Cf8emP4jB+5UkCBNcJm9lgw04Z8xYR8md97+zKRou8Bw0MAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qnISp+mN; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MGR5l7764581;
	Fri, 22 Aug 2025 11:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755880025;
	bh=loBEMD9a9DHR9fjC5udJ3RD/pZ2cFnbZvvVrDjat8sY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qnISp+mN+K4EtoDlAHRVcOI56nVevnTjrGhfdh6hbvkje3kY73fPy3EJklAw1AHj5
	 W//YA2/TNWBwQybx6fQuT4JZ5/aFEV5EpIWE8xgUdEBARxhovNfBiQw+OMMYTNSWOT
	 Jw1FkluP3AJYjFrrqs0ZcT8XcY4XlcwdUTB7FUno=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MGR5QZ3728849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 11:27:05 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 11:27:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 11:27:04 -0500
Received: from [10.249.139.51] ([10.249.139.51])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MGQssi3814649;
	Fri, 22 Aug 2025 11:26:57 -0500
Message-ID: <30fa0812-c197-408d-8e45-58cc75fba880@ti.com>
Date: Fri, 22 Aug 2025 21:56:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed
 C6x carveout locations"
To: "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <afd@ti.com>, <hnagalla@ti.com>, <jm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-4-b-padhi@ti.com>
 <92e57929-a978-4d5f-97d4-b7779736d0db@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <92e57929-a978-4d5f-97d4-b7779736d0db@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Udit,

On 8/15/2025 8:05 AM, Kumar, Udit wrote:
>
> On 8/15/2025 4:08 AM, Beleswar Padhi wrote:
>> This reverts commit 9f3814a7c06b7c7296cf8c1622078ad71820454b.
>>
>> The C6x carveouts are reversed intentionally. This is due to the
>> requirement to keep the DMA memory region as non-cached, however the
>> minimum granular cache region for C6x is 16MB. So, C66x_0 marks the
>> entire C66x_1 16MB memory carveouts as non-cached, and uses the DMA
>> memory region of C66x_1 as its own, and vice-versa.
>
> Sorry , but i failed to understand how this swap helps in making 
> region non-cached.


This swap does not make region non-cached. This ensures the correct
carveouts are registered for each remote processor (rproc), which is
necessary to ensure VRING buffers are allocated from correct address
space for IPC.

Without this patch, the VRINGs would be allocated from rproc's own
DMA carveout, which would be *cached* from rproc's view.

Refer to the line in the commit message:
"and uses the DMA memory region of C66x_1 as its own, and vice-versa."

Marking a region as non-cached from a rproc's view is done by its
firmware itself via a linker script.

Thanks,
Beleswar

>
> 16MB logic is understood.
>
>>
>> This was also called out in the original commit which introduced these
>> reversed carveouts:
>>     "The minimum granularity on the Cache settings on C66x DSP cores
>>     is 16MB, so the DMA memory regions are chosen such that they are
>>     in separate 16MB regions for each DSP, while reserving a total
>>     of 16 MB for each DSP and not changing the overall DSP
>>     remoteproc carveouts."
>>
>> Fixes: 9f3814a7c06b ("arm64: dts: ti: k3-j721e-sk: Fix reversed C6x 
>> carveout locations")
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts 
>> b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>> index ffef3d1cfd55..9882bb1e8097 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>> @@ -120,7 +120,8 @@ main_r5fss1_core1_memory_region: 
>> r5f-memory@a5100000 {
>>               no-map;
>>           };
>>   -        c66_0_dma_memory_region: c66-dma-memory@a6000000 {
>> +        /* Carveout locations are flipped due to caching */
>> +        c66_1_dma_memory_region: c66-dma-memory@a6000000 {
>>               compatible = "shared-dma-pool";
>>               reg = <0x00 0xa6000000 0x00 0x100000>;
>>               no-map;
>> @@ -132,7 +133,8 @@ c66_0_memory_region: c66-memory@a6100000 {
>>               no-map;
>>           };
>>   -        c66_1_dma_memory_region: c66-dma-memory@a7000000 {
>> +        /* Carveout locations are flipped due to caching */
>> +        c66_0_dma_memory_region: c66-dma-memory@a7000000 {
>>               compatible = "shared-dma-pool";
>>               reg = <0x00 0xa7000000 0x00 0x100000>;
>>               no-map;

