Return-Path: <linux-kernel+bounces-759806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4AB1E2E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D703ADA0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6E223DF1;
	Fri,  8 Aug 2025 07:14:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185417AE11
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637282; cv=none; b=o0U6Lb1tdCdkg6sB4aRnfOreEwNjEXYUBfCbf3coAcLiZ3qib+G4SVgmPACTO6R5HWOlenBRh7zbWtR/GX86ZPd+fWNg6NnhThGSOac4z4gmMSAy7tlxs8AEtRaNAvLHj9e7WqE6WFo+IaXqZfSXZGv/xPhsCgq14CFL9O6v3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637282; c=relaxed/simple;
	bh=kK4hdX3kAj1XF9gKXJxpP81ZZn+xsFn/STd36UOX6xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUR2rL7bC3fbcS4lFHJXMVGhh3Q+3wKNhntlGw51fu0AyasLp4uzbSpxG/5gqvoCd9Z6litFMXk3nerMONrSVE96dB0Zd5ZiqIIT8lR8gVn20UxMIJW2ULvgR8/ACYPjD6ULUXGEgkfIRjiOdqXJSokizqv9brfuw+AD3EEUZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65A4116F8;
	Fri,  8 Aug 2025 00:14:32 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53CF43F673;
	Fri,  8 Aug 2025 00:14:35 -0700 (PDT)
Message-ID: <1f77ae63-0495-4af7-a3e7-8968f98ba6d5@arm.com>
Date: Fri, 8 Aug 2025 08:14:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/36] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
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
 <20250711183648.30766-28-james.morse@arm.com>
 <7ab40c09-3922-4e0c-85dd-00ff05be4ce6@arm.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <7ab40c09-3922-4e0c-85dd-00ff05be4ce6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/07/2025 12:59, Ben Horgan wrote:
> On 7/11/25 19:36, James Morse wrote:
>> When CPUs come online the original configuration should be restored.
>> Once the maximum partid is known, allocate an configuration array for
>> each component, and reprogram each RIS configuration from this.
>>
>> The MPAM spec describes how multiple controls can interact. To prevent
>> this happening by accident, always reset controls that don't have a
>> valid configuration. This allows the same helper to be used for
>> configuration and reset.
>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/
>> mpam_devices.c
>> index bb3695eb84e9..f3ecfda265d2 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
>>   @@ -1000,10 +1041,38 @@ static void mpam_reset_msc(struct mpam_msc *msc, bool online)
>>            */
>>           ris->in_reset_state = online;
>>       }
>> -    srcu_read_unlock(&mpam_srcu, idx);
>>       mpam_mon_sel_outer_unlock(msc);
>>   }
>>   +static void mpam_reprogram_msc(struct mpam_msc *msc)
>> +{
>> +    int idx;
>> +    u16 partid;
>> +    bool reset;
>> +    struct mpam_config *cfg;
>> +    struct mpam_msc_ris *ris;
>> +
>> +    idx = srcu_read_lock(&mpam_srcu);
>> +    list_for_each_entry_rcu(ris, &msc->ris, msc_list) {
>> +        if (!mpam_is_enabled() && !ris->in_reset_state) {
>> +            mpam_touch_msc(msc, &mpam_reset_ris, ris);
>> +            ris->in_reset_state = true;
>> +            continue;
>> +        }
>> +
>> +        reset = true;
>> +        for (partid = 0; partid <= mpam_partid_max; partid++) {
> Do we need to consider 'partid_max_lock' here?

The lock is only needed while those parameters can change, due to a race with mpam_register_requestor(). Once mpam_enabled()
has been called, the values can't change, so the lock is redundant.

In this case, its relying on mpam_cpu_online() only ever being the cpuhp callback once partid_max_published has been set.

I'll add a comment.


>> +            cfg = &ris->vmsc->comp->cfg[partid];
>> +            if (cfg->features)
>> +                reset = false;
>> +
>> +            mpam_reprogram_ris_partid(ris, partid, cfg);
>> +        }
>> +        ris->in_reset_state = reset;
>> +    }
>> +    srcu_read_unlock(&mpam_srcu, idx);
>> +}
>> +
>>   static void _enable_percpu_irq(void *_irq)
>>   {
>>       int *irq = _irq;
>   @@ -1806,6 +1875,43 @@ static void mpam_unregister_irqs(void)
>>       cpus_read_unlock();
>>   }
>>   +static void __destroy_component_cfg(struct mpam_component *comp)
>> +{
>> +    add_to_garbage(comp->cfg);
>> +}
>> +
>> +static int __allocate_component_cfg(struct mpam_component *comp)
>> +{
>> +    if (comp->cfg)
>> +        return 0;
>> +
>> +    comp->cfg = kcalloc(mpam_partid_max + 1, sizeof(*comp->cfg), GFP_KERNEL);
> And here?

Aha, that is a good one - the configuration should be allocated after the partid values are fixed. Currently its done by
the same function, but not in the right order.


>> +    if (!comp->cfg)
>> +        return -ENOMEM;
>> +    init_garbage(comp->cfg);
>> +
>> +    return 0;
>> +}
>> +
>> +static int mpam_allocate_config(void)
>> +{
>> +    int err = 0;
>> +    struct mpam_class *class;
>> +    struct mpam_component *comp;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>> +    list_for_each_entry(class, &mpam_classes, classes_list) {
>> +        list_for_each_entry(comp, &class->components, class_list) {
>> +            err = __allocate_component_cfg(comp);
>> +            if (err)
>> +                return err;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static void mpam_enable_once(void)
>>   {
>>       int err;
>> @@ -1817,12 +1923,21 @@ static void mpam_enable_once(void)
>>        */
>>       cpus_read_lock();
>>       mutex_lock(&mpam_list_lock);
>> -    mpam_enable_merge_features(&mpam_classes);
>> +    do {
>> +        mpam_enable_merge_features(&mpam_classes);
>>   -    err = mpam_register_irqs();
>> -    if (err)
>> -        pr_warn("Failed to register irqs: %d\n", err);
>> +        err = mpam_allocate_config();
>> +        if (err) {
>> +            pr_err("Failed to allocate configuration arrays.\n");
>> +            break;
>> +        }
>>   +        err = mpam_register_irqs();
>> +        if (err) {
>> +            pr_warn("Failed to register irqs: %d\n", err);
>> +            break;
>> +        }
>> +    } while (0);
>>       mutex_unlock(&mpam_list_lock);
>>       cpus_read_unlock();
>>   @@ -1861,6 +1976,8 @@ static void mpam_reset_component_locked(struct mpam_component
>> *comp)
>>       might_sleep();
>>       lockdep_assert_cpus_held();
>>   +    memset(comp->cfg, 0, (mpam_partid_max * sizeof(*comp->cfg)));
> And here?

Same story, and the same bug - the disable path can be called and reach this before the partid size has been fixed. The
code that enables interrupts should pull that earlier in mpam_enable_once, which would simplify all of these.



Thanks,

James

