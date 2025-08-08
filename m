Return-Path: <linux-kernel+bounces-759801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3832FB1E2E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E75F56397B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0FA22126C;
	Fri,  8 Aug 2025 07:11:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3717AE11
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637094; cv=none; b=CioVP3hdEYLHa23f1UMRIrmoOEwEjGSwiEe5M0JHPQbnJQxoISwCiXmTTWXVlv/GcxntAaLst9rIVMSlXkGalxO94X+xZso85LL7wuA/OwjiPyozsG+xZXhs2FMOqYJTfskheDqdRupxHg/7oWagQvavHK9dwQ8OZWGXEMZ3Wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637094; c=relaxed/simple;
	bh=CxRQnAuyXSN1eSdLz0m/StZkiNWcHhpdR3QGSj/frfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGsVAudIKsAZJovrVvUa/eS8SAR+24HKCvUa5SrMBDSLNn9PhYzbLB741Gx7Bxbj2KxF6Kzo+a3N9q4XrfZtf9tx62YofJ1qmhuHbT5F34OPqnSR7PlDhiTiSdceZs4RoAHRE0FTQF2pPFkQqkrufMg2pQ3by3fQ031TluertuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAA5022EA;
	Fri,  8 Aug 2025 00:11:24 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8408D3F673;
	Fri,  8 Aug 2025 00:11:27 -0700 (PDT)
Message-ID: <02e4504c-dcee-46b7-b71c-8c7dac2db85b@arm.com>
Date: Fri, 8 Aug 2025 08:11:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/36] arm_mpam: Register and enable IRQs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-26-james.morse@arm.com>
 <20250722160618.0000598f@huawei.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250722160618.0000598f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 22/07/2025 16:06, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 18:36:37 +0000
> James Morse <james.morse@arm.com> wrote:
>> Register and enable error IRQs. All the MPAM error interrupts indicate a
>> software bug, e.g. out of range partid. If the error interrupt is ever
>> signalled, attempt to disable MPAM.
>>
>> Only the irq handler accesses the ESR register, so no locking is needed.
>> The work to disable MPAM after an error needs to happen at process
>> context, use a threaded interrupt.
>>
>> There is no support for percpu threaded interrupts, for now schedule
>> the work to be done from the irq handler.
>>
>> Enabling the IRQs in the MSC may involve cross calling to a CPU that
>> can access the MSC.

> Sparse gives an imbalance warning in mpam_register_irqs()

>> +static int mpam_register_irqs(void)
>> +{
>> +	int err, irq, idx;
>> +	struct mpam_msc *msc;
>> +
>> +	lockdep_assert_cpus_held();
>> +
>> +	idx = srcu_read_lock(&mpam_srcu);
>> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
>> +		irq = platform_get_irq_byname_optional(msc->pdev, "error");
>> +		if (irq <= 0)
>> +			continue;
>> +
>> +		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
>> +		/* We anticipate sharing the interrupt with other MSCs */
>> +		if (irq_is_percpu(irq)) {
>> +			err = request_percpu_irq(irq, &mpam_ppi_handler,
>> +						 "mpam:msc:error",
>> +						 msc->error_dev_id);
>> +			if (err)
>> +				return err;

> Looks like the srcu_read_lock is still held.

Oops,


> There is a DEFINE_LOCK_GUARD_1() in srcu.h so you can do
> 
> 	guard(srcu)(&mpam_srcu, idx);
> 
> I think and not worry about releasing it in errors or the good path.

Sure ... but having the compiler chose when to release locks makes me nervous!


Thanks,

James

