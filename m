Return-Path: <linux-kernel+bounces-759799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A5EB1E2DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE6A561565
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05A21CC56;
	Fri,  8 Aug 2025 07:08:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C017AE11
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754636892; cv=none; b=cHd5FpLLXk8IZ5Zu+qxkL3lMSkZ1GHW8TEtIFPdfBHo0/3Hy1XyAFxpVaL6+EkUHneB4sh9E+j/IVCiYgQEDyIUMCtrN4Afn5rtJblDECSleRyPK/ITE+sGRPOwxz4Ysd4NdE657yMvLROeMNOOdt6A1LBoWQLyaxtXgyKZVfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754636892; c=relaxed/simple;
	bh=OP81OygKXNMkOqO5mUfEQrd8h4RaJbDIiWno6wNMkSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+sDzK8AczYpXLe7LgHGV+DW6kp5AZMoouJWwRC9cFdgQ8HIu/ioqOmBDtRT/1cHnIUuJtSFCu9QALW41zomnYxRCRiL7lQQeOZgXAXQIpUKUJQj/vUz8TyAzDyiQrn48/kezhsld2k90AHVYGw2G3Zcl5kXXDG7VOW+DJA6iZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C98716F8;
	Fri,  8 Aug 2025 00:08:02 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71BF83F673;
	Fri,  8 Aug 2025 00:07:59 -0700 (PDT)
Message-ID: <04e25a86-6c24-4e0c-968d-2575cfbd8c83@arm.com>
Date: Fri, 8 Aug 2025 08:07:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/36] arm_mpam: Register and enable IRQs
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-26-james.morse@arm.com>
 <OSZPR01MB87989B1F13F79EE70D2D3B238B51A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB87989B1F13F79EE70D2D3B238B51A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shaoepeng,

On 17/07/2025 02:08, Shaopeng Tan (Fujitsu) wrote:
>> Register and enable error IRQs. All the MPAM error interrupts indicate a
>> software bug, e.g. out of range partid. If the error interrupt is ever signalled,
>> attempt to disable MPAM.
>>
>> Only the irq handler accesses the ESR register, so no locking is needed.
>> The work to disable MPAM after an error needs to happen at process context,
>> use a threaded interrupt.
>>
>> There is no support for percpu threaded interrupts, for now schedule the work
>> to be done from the irq handler.
>>
>> Enabling the IRQs in the MSC may involve cross calling to a CPU that can
>> access the MSC.

>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c
>> b/drivers/platform/arm64/mpam/mpam_devices.c
>> index 145535cd4732..af19cc25d16e 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c

>> +static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc) {
>> +	u64 reg;
>> +	u16 partid;
>> +	u8 errcode, pmg, ris;
>> +
>> +	if (WARN_ON_ONCE(!msc) ||
>> +	    WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
>> +					   &msc->accessibility)))
>> +		return IRQ_NONE;
>> +
>> +	reg = mpam_msc_read_esr(msc);
>> +
>> +	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
>> +	if (!errcode)
>> +		return IRQ_NONE;

> In general, I think there is no problem. 
> However, the initial value of MPAMF_ESR_ERRCODE may not be 0 on some chips. 
> It is better to initialize when loading the MPAM driver

Hmm, the architecture doesn't say - but if this weren't true, you get spurious fatal errors.
More interesting is if the bootloader (unlikey) or pervious kexec kernel (feasible) were using
MPAM and triggered an error. We'd ned up disabling the driver when there was no bug...

I'll add something to the hw_probe() path.


Thanks,

James

