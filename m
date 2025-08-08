Return-Path: <linux-kernel+bounces-759803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF5B1E2E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDE13B3530
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9F722172C;
	Fri,  8 Aug 2025 07:12:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85902219E8D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637147; cv=none; b=BV094/gIgTZwuD5eK5hpd4UB6LyXEhVcp70byOOA2uA0hROxK/X2a77iaX3SG1VRDwfQfxhTwmeJic5iwoKSG7aSh+5s/O0m4mskiZ7KgnnLgLQDpEtHtnWOftj8b+IhIi/6z8JfH/YZibfxPyRw74bCETH6Sh3kbpUtTOqj9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637147; c=relaxed/simple;
	bh=WlhBPLHkCaYgr93+Mpcjz/yhJYCNVcwJJJ8NEazcIE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biuergyTbpCxwFiIQRvrpslykD8oqn17Yj0ohU8Pq0K/VNaEcEzK/7NYnrI4L2jBx1CwZJatHKiu3WA7Y+jJJ3zTMSJLEX/Ourv6W4Z026YguPwSTrVCpiQnQVkJbUpP8zRxkQyEj7Y1TV6SmdSi+3thQbNn/MWB1MwqAHutf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF13A22EA;
	Fri,  8 Aug 2025 00:12:17 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42AB93F673;
	Fri,  8 Aug 2025 00:12:20 -0700 (PDT)
Message-ID: <76da7333-6e37-44ad-ab46-8fb4b1c529b4@arm.com>
Date: Fri, 8 Aug 2025 08:12:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/36] arm_mpam: Register and enable IRQs
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
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
 <7b909125-103d-41d3-a2ad-5c96a15df672@nvidia.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <7b909125-103d-41d3-a2ad-5c96a15df672@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fenghua,

On 04/08/2025 17:53, Fenghua Yu wrote:
> On 7/11/25 11:36, James Morse wrote:
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

>> +static int mpam_register_irqs(void)
>> +{
>> +    int err, irq, idx;
>> +    struct mpam_msc *msc;
>> +
>> +    lockdep_assert_cpus_held();
>> +
>> +    idx = srcu_read_lock(&mpam_srcu);
>> +    list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list,
>> srcu_read_lock_held(&mpam_srcu)) {
>> +        irq = platform_get_irq_byname_optional(msc->pdev, "error");
>> +        if (irq <= 0)
>> +            continue;
>> +
>> +        /* The MPAM spec says the interrupt can be SPI, PPI or LPI */
>> +        /* We anticipate sharing the interrupt with other MSCs */
>> +        if (irq_is_percpu(irq)) {
>> +            err = request_percpu_irq(irq, &mpam_ppi_handler,
>> +                         "mpam:msc:error",
>> +                         msc->error_dev_id);
>> +            if (err)
>> +                return err;
> But right now mpam_srcu is still being locked. Need to unlock it before return.

Yup, Jonathan's srcu guard runes solve that in a future proof way.


Thanks,

James

