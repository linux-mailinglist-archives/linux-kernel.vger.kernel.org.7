Return-Path: <linux-kernel+bounces-824411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561AB891F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6495623DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C72BEC59;
	Fri, 19 Sep 2025 10:45:34 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD32F6194
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278733; cv=none; b=i8wJVAIRyGXnYiacFPLcpZVMezZ2K5agQl+0NRoqdA1cz27q1KX9yufA5p9nqJE3RRNbLKCXuCwAzyigVSgbdYM2FTKB0cD0sp2JDaqiLACesNuOdRROGjHALyYQXQto8a/rjtSyjaTU03N588yFTvFE8e+ERc7n4FQKF2MkzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278733; c=relaxed/simple;
	bh=ubGKIt0enE7sw1EwLrdaqV70DRoK5ndS63wLNYPSKVs=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AkovfGL9gquPAVqrofzSBrCiTpvsOIU+ykw4oHuxhbChvr30rO+mhZajD+U5tzmPX+6R1A07QVhwY40CvvT/sQIhb057G4kfDYwW+jbEiAQHJsJrTtDXEnuQ9MFXdavtFt8UYZE03jY6MiQsQ1h/b/ceiO+dm6uRdBlVDyyHi/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cSpwr00MDz1R93b;
	Fri, 19 Sep 2025 18:42:19 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 91E7C1400F4;
	Fri, 19 Sep 2025 18:45:26 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Sep 2025 18:45:26 +0800
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Sep 2025 18:45:25 +0800
Subject: Re: [PATCH v3 2/3] coresight: tmc: refactor the tmc-etr mode setting
 to avoid race conditions
To: Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20250818080600.418425-1-hejunhao3@huawei.com>
 <20250818080600.418425-3-hejunhao3@huawei.com>
 <b68d0460-0af0-6824-b215-5b6af1e69260@huawei.com>
 <7eeb2adc-4936-4af2-a24b-b3a3ae09176f@arm.com>
CC: Yicong Yang <yangyicong@huawei.com>, Junhao He <hejunhao3@huawei.com>,
	<james.clark@arm.com>, <anshuman.khandual@arm.com>, <leo.yan@arm.com>,
	<yangyicong@hisilicon.com>, <coresight@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>
From: hejunhao <hejunhao3@h-partners.com>
Message-ID: <d7ee5f4b-80a5-be77-d064-fb05159ed503@h-partners.com>
Date: Fri, 19 Sep 2025 18:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7eeb2adc-4936-4af2-a24b-b3a3ae09176f@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn500004.china.huawei.com (7.202.194.145)

Hi Suzuki

thanks for the review


On 2025/9/18 21:29, Suzuki K Poulose wrote:
> On 18/09/2025 10:15, Yicong Yang wrote:
>> On 2025/8/18 16:05, Junhao He wrote:
>>> When trying to run perf and sysfs mode simultaneously, the WARN_ON()
>>> in tmc_etr_enable_hw() is triggered sometimes:
>>>
>>>   WARNING: CPU: 42 PID: 3911571 at 
>>> drivers/hwtracing/coresight/coresight-tmc-etr.c:1060 
>>> tmc_etr_enable_hw+0xc0/0xd8 [coresight_tmc]
>>>   [..snip..]
>>>   Call trace:
>>>    tmc_etr_enable_hw+0xc0/0xd8 [coresight_tmc] (P)
>>>    tmc_enable_etr_sink+0x11c/0x250 [coresight_tmc] (L)
>>>    tmc_enable_etr_sink+0x11c/0x250 [coresight_tmc]
>>>    coresight_enable_path+0x1c8/0x218 [coresight]
>>>    coresight_enable_sysfs+0xa4/0x228 [coresight]
>>>    enable_source_store+0x58/0xa8 [coresight]
>>>    dev_attr_store+0x20/0x40
>>>    sysfs_kf_write+0x4c/0x68
>>>    kernfs_fop_write_iter+0x120/0x1b8
>>>    vfs_write+0x2c8/0x388
>>>    ksys_write+0x74/0x108
>>>    __arm64_sys_write+0x24/0x38
>>>    el0_svc_common.constprop.0+0x64/0x148
>>>    do_el0_svc+0x24/0x38
>>>    el0_svc+0x3c/0x130
>>>    el0t_64_sync_handler+0xc8/0xd0
>>>    el0t_64_sync+0x1ac/0x1b0
>>>   ---[ end trace 0000000000000000 ]---
>>>
>>> Since the sysfs buffer allocation and the hardware enablement is not
>>> in the same critical region, it's possible to race with the perf
>>>
>>> mode:
>>>    [sysfs mode]                   [perf mode]
>>>    tmc_etr_get_sysfs_buffer()
>>>      spin_lock(&drvdata->spinlock)
>>>      [sysfs buffer allocation]
>>>      spin_unlock(&drvdata->spinlock)
>>> spin_lock(&drvdata->spinlock)
>>>                                   tmc_etr_enable_hw()
>>>                                     drvdata->etr_buf = 
>>> etr_perf->etr_buf
>>> spin_unlock(&drvdata->spinlock)
>>>   spin_lock(&drvdata->spinlock)
>>>   tmc_etr_enable_hw()
>>>     WARN_ON(drvdata->etr_buf) // WARN sicne etr_buf initialized at
>>>                                  the perf side
>>>    spin_unlock(&drvdata->spinlock)
>>>
>>> A race condition is introduced here, perf always prioritizes 
>>> execution, and
>>> warnings can lead to concerns about potential hidden bugs, such as 
>>> getting
>>> out of sync.
>>>
>>> To fix this, configure the tmc-etr mode before invoking 
>>> enable_etr_perf()
>>> or enable_etr_sysfs(), explicitly check if the tmc-etr sink is already
>>> enabled in a different mode, and simplily the setup and checks for 
>>> "mode".
>>> To prevent race conditions between mode transitions.
>>>
>>> Fixes: 296b01fd106e ("coresight: Refactor out buffer allocation 
>>> function for ETR")
>>> Reported-by: Yicong Yang <yangyicong@hisilicon.com>
>>> Closes: 
>>> https://lore.kernel.org/linux-arm-kernel/20241202092419.11777-2-yangyicong@huawei.com/
>>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>>
>> Tested by running perf and sysfs mode simultaneously, no warning 
>> reproduced.
>>
>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>>
>>> ---
>>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 80 
>>> ++++++++++---------
>>>   1 file changed, 42 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c 
>>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> index b07fcdb3fe1a..06c74717be19 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> @@ -1263,7 +1263,7 @@ static struct etr_buf 
>>> *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>>>           raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>>>       }
>>>   -    if (drvdata->reading || coresight_get_mode(csdev) == 
>>> CS_MODE_PERF) {
>>> +    if (drvdata->reading) {
>>>           ret = -EBUSY;
>>>           goto out;
>>>       }
>>> @@ -1300,20 +1300,18 @@ static int tmc_enable_etr_sink_sysfs(struct 
>>> coresight_device *csdev)
>>>       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>>>         /*
>>> -     * In sysFS mode we can have multiple writers per sink. Since this
>>> -     * sink is already enabled no memory is needed and the HW need 
>>> not be
>>> -     * touched, even if the buffer size has changed.
>>> +     * When two sysfs sessions race to acquire an idle sink, both 
>>> may enter
>>> +     * this function. We need to recheck if the sink is already in 
>>> use to
>>> +     * prevent duplicate hardware configuration.
>>>        */
>>> -    if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
>>> +    if (csdev->refcnt) {
>>>           csdev->refcnt++;
>>>           goto out;
>>>       }
>>>         ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
>>> -    if (!ret) {
>>> -        coresight_set_mode(csdev, CS_MODE_SYSFS);
>>> +    if (!ret)
>>>           csdev->refcnt++;
>>> -    }
>>>     out:
>>>       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>> @@ -1729,39 +1727,24 @@ static int tmc_enable_etr_sink_perf(struct 
>>> coresight_device *csdev, void *data)
>>>   {
>>>       int rc = 0;
>>>       pid_t pid;
>>> -    unsigned long flags;
>>>       struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>       struct perf_output_handle *handle = data;
>>>       struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
>>>   -    raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>>> -     /* Don't use this sink if it is already claimed by sysFS */
>>> -    if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
>>> -        rc = -EBUSY;
>>> -        goto unlock_out;
>>> -    }
>>> -
>>> -    if (WARN_ON(!etr_perf || !etr_perf->etr_buf)) {
>>> -        rc = -EINVAL;
>>> -        goto unlock_out;
>>> -    }
>>> +    if (WARN_ON(!etr_perf || !etr_perf->etr_buf))
>>> +        return -EINVAL;
>>>         /* Get a handle on the pid of the session owner */
>>>       pid = etr_perf->pid;
>>>         /* Do not proceed if this device is associated with another 
>>> session */
>>> -    if (drvdata->pid != -1 && drvdata->pid != pid) {
>>> -        rc = -EBUSY;
>>> -        goto unlock_out;
>>> -    }
>>> +    if (drvdata->pid != -1 && drvdata->pid != pid)
>>> +        return -EBUSY;
>>>   -    /*
>>> -     * No HW configuration is needed if the sink is already in
>>> -     * use for this session.
>>> -     */
>>> +    /* The sink is already in use for this session */
>>>       if (drvdata->pid == pid) {
>>>           csdev->refcnt++;
>>> -        goto unlock_out;
>>> +        return rc;
>>>       }
>>>         rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
>>> @@ -1773,22 +1756,43 @@ static int tmc_enable_etr_sink_perf(struct 
>>> coresight_device *csdev, void *data)
>>>           csdev->refcnt++;
>>>       }
>>>   -unlock_out:
>>> -    raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>>       return rc;
>>>   }
>>>     static int tmc_enable_etr_sink(struct coresight_device *csdev,
>>>                      enum cs_mode mode, void *data)
>>>   {
>>> -    switch (mode) {
>>> -    case CS_MODE_SYSFS:
>>> -        return tmc_enable_etr_sink_sysfs(csdev);
>>> -    case CS_MODE_PERF:
>>> -        return tmc_enable_etr_sink_perf(csdev, data);
>>> -    default:
>>> -        return -EINVAL;
>>> +    struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +    int rc;
>>> +
>>> +    scoped_guard(raw_spinlock_irqsave, &drvdata->spinlock) {
>>> +        if (coresight_get_mode(csdev) != CS_MODE_DISABLED &&
>>> +            coresight_get_mode(csdev) != mode)
>>> +            return -EBUSY;
>>> +
>>> +        switch (mode) {
>>> +        case CS_MODE_SYSFS:
>>> +            if (csdev->refcnt) {
>>> +                /* The sink is already enabled */
>>> +                csdev->refcnt++;
>>> +                return 0;
>>> +            }
>>> +            coresight_set_mode(csdev, mode);
>
> Why are we spilling bits here in the common code for sysfs ? More on 
> this, see below.

This is to ensure that all operations on the mode are placed within a 
spinlock critical section.
If the above mode setting operation is removed, when the sysfs session 
and the perf session
enable the sink simultaneously, the sysfs session will release the 
spinlock multiple times during
the process of enabling the sink. The perf session can acquire the lock 
at multiple points in time
when the spinlock is released by sysfs and complete the entire sink 
enabling process.
Therefore, the sysfs session needs to check whether the sink is occupied 
by perf each time
before reacquiring the lock.

>
>>> +            break;
>>> +        case CS_MODE_PERF:
>>> +            return tmc_enable_etr_sink_perf(csdev, data);
>>> +        default:
>>> +            return -EINVAL;
>>> +        }
>>> +    }
>>> +
>>> +    rc = tmc_enable_etr_sink_sysfs(csdev);
> We now call the above function without the spinlock and the refcnt is
> managed with and without the spinlock by the users. This is problematic,
> with refcnt being a non-atomic type.
>
> Please fix. I don't see why we can't set the mode in
> tmc_enable_etr_sink_sysfs() with the locks held and
> reset the mode if we failed enable it properly.
>
> Suzuki

The internal of the `tmc_enable_etr_sink_sysfs()` function will acquire 
a spinlock.
It manages the `refcnt` within the spinlock context, ensuring that the 
operation is safe.

And tmc_enable_etr_sink_sysfs() will call tmc_etr_get_sysfs_buffer(), 
the function
`tmc_etr_get_sysfs_buffer()` will release the spinlock when allocating 
the buffer, so
it is not possible to move `tmc_enable_etr_sink_sysfs()` into the 
context of the spinlock.

Or is there another way to do it?

Best regards,
Junhao.

>
>
>>> +    if (rc) {
>>> +        scoped_guard(raw_spinlock_irqsave, &drvdata->spinlock)
>>> +        coresight_set_mode(csdev, CS_MODE_DISABLED);
>>>       }
>>> +
>>> +    return rc;
>>>   }
>>>     static int tmc_disable_etr_sink(struct coresight_device *csdev)
>>>
>
>
>
> .
>


