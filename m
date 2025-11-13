Return-Path: <linux-kernel+bounces-899553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9741FC583AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 431D14EBC65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DA62FB0A9;
	Thu, 13 Nov 2025 15:02:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967DC2F6592
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046171; cv=none; b=bJxDT0MetouAd5GIoyvIjqThPnSh8Prlfie4dttfnuEsz1SviPG4nr6iq4EVuaUI+zb5599n0k+8DBtfFa+rzHxO9IbE619/nOmdvNZCIDAQ1rZtmDDHNXkYz/PXn3E8Z5fZBJZZeQWJkl6DC9LQYz6h5w80JqZI0m24Z+dMNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046171; c=relaxed/simple;
	bh=ofqEaqcDcRxADyvyfw9NAbvPUoDTknNZKyghgKMGzyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQnQ6aCpQEVYSn5qkw99SpeMYohmk9PNc6mCEmbndSQa6Vo8JgWXvji9Kw9DvTgV5VWPRitaa2XRWA9FnmWmYIySYGVwMjZOO3gjC3gDuyZJfzRvyIrJNpvcZ/jEbJYLWz15YqB//chzOhA2ZfaaN1agqrqMRF1mAVD5JGp/Ab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17A7B1477;
	Thu, 13 Nov 2025 07:02:41 -0800 (PST)
Received: from [10.1.27.38] (Suzukis-MBP.cambridge.arm.com [10.1.27.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 140C63F66E;
	Thu, 13 Nov 2025 07:02:46 -0800 (PST)
Message-ID: <15868ecb-c1e7-4273-a2e2-5c10f2701c0b@arm.com>
Date: Thu, 13 Nov 2025 15:02:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] coresight: tmc: refactor the tmc-etr mode setting
 to avoid race conditions
Content-Language: en-GB
To: Junhao He <hejunhao3@h-partners.com>, james.clark@linaro.org,
 anshuman.khandual@arm.com, yeoreum.yun@arm.com, mike.leach@linaro.org,
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com
References: <20251111122149.1981162-1-hejunhao3@h-partners.com>
 <20251111122149.1981162-3-hejunhao3@h-partners.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251111122149.1981162-3-hejunhao3@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junhao,

While your patch fixes the problem it introduces imbalance in the
way perf vs sysfs modes are handled.

On 11/11/2025 12:21, Junhao He wrote:
> From: Junhao He <hejunhao3@huawei.com>
> 
> When trying to run perf and sysfs mode simultaneously, the WARN_ON()
> in tmc_etr_enable_hw() is triggered sometimes:
> 
>   WARNING: CPU: 42 PID: 3911571 at drivers/hwtracing/coresight/coresight-tmc-etr.c:1060 tmc_etr_enable_hw+0xc0/0xd8 [coresight_tmc]
>   [..snip..]
>   Call trace:
>    tmc_etr_enable_hw+0xc0/0xd8 [coresight_tmc] (P)
>    tmc_enable_etr_sink+0x11c/0x250 [coresight_tmc] (L)
>    tmc_enable_etr_sink+0x11c/0x250 [coresight_tmc]
>    coresight_enable_path+0x1c8/0x218 [coresight]
>    coresight_enable_sysfs+0xa4/0x228 [coresight]
>    enable_source_store+0x58/0xa8 [coresight]
>    dev_attr_store+0x20/0x40
>    sysfs_kf_write+0x4c/0x68
>    kernfs_fop_write_iter+0x120/0x1b8
>    vfs_write+0x2c8/0x388
>    ksys_write+0x74/0x108
>    __arm64_sys_write+0x24/0x38
>    el0_svc_common.constprop.0+0x64/0x148
>    do_el0_svc+0x24/0x38
>    el0_svc+0x3c/0x130
>    el0t_64_sync_handler+0xc8/0xd0
>    el0t_64_sync+0x1ac/0x1b0
>   ---[ end trace 0000000000000000 ]---
> 
> Since the sysfs buffer allocation and the hardware enablement is not
> in the same critical region, it's possible to race with the perf
> 
> mode:
>    [sysfs mode]                   [perf mode]
>    tmc_etr_get_sysfs_buffer()
>      spin_lock(&drvdata->spinlock)
>      [sysfs buffer allocation]
>      spin_unlock(&drvdata->spinlock)
>                                   spin_lock(&drvdata->spinlock)
>                                   tmc_etr_enable_hw()
>                                     drvdata->etr_buf = etr_perf->etr_buf
>                                   spin_unlock(&drvdata->spinlock)
>   spin_lock(&drvdata->spinlock)

^^ Could we not double check the mode here and break out ?

Something like this :


diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c 
b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e0d83ee01b77..2097c57d19d0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1314,6 +1314,9 @@ static int tmc_enable_etr_sink_sysfs(struct 
coresight_device *csdev)
         if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
                 csdev->refcnt++;
                 goto out;
+       } else if (coresight_get_mode(csdev) != CS_MODE_DISABLED) {
+               ret = -EBUSY;
+               goto out;
         }

         ret = tmc_etr_enable_hw(drvdata, sysfs_buf);


Suzuki


>   tmc_etr_enable_hw()
>     WARN_ON(drvdata->etr_buf) // WARN sicne etr_buf initialized at
>                                  the perf side
>    spin_unlock(&drvdata->spinlock)
> 
> A race condition is introduced here, perf always prioritizes execution, and
> warnings can lead to concerns about potential hidden bugs, such as getting
> out of sync.
> 
> To fix this, configure the tmc-etr mode before invoking enable_etr_perf()
> or enable_etr_sysfs(), explicitly check if the tmc-etr sink is already
> enabled in a different mode, and simplily the setup and checks for "mode".
> To prevent race conditions between mode transitions.
> 
> Fixes: 296b01fd106e ("coresight: Refactor out buffer allocation function for ETR")
> Reported-by: Yicong Yang <yangyicong@hisilicon.com>
> Closes: https://lore.kernel.org/linux-arm-kernel/20241202092419.11777-2-yangyicong@huawei.com/
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Junhao He <hejunhao3@h-partners.com>
> ---
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 106 +++++++++---------
>   1 file changed, 55 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index b07fcdb3fe1a..fe1d5e8a0d2b 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1263,11 +1263,6 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>   		raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>   	}
>   
> -	if (drvdata->reading || coresight_get_mode(csdev) == CS_MODE_PERF) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> -
>   	/*
>   	 * If we don't have a buffer or it doesn't match the requested size,
>   	 * use the buffer allocated above. Otherwise reuse the existing buffer.
> @@ -1278,7 +1273,6 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>   		drvdata->sysfs_buf = new_buf;
>   	}
>   
> -out:
>   	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   
>   	/* Free memory outside the spinlock if need be */
> @@ -1289,7 +1283,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>   
>   static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>   {
> -	int ret = 0;
> +	int ret;
>   	unsigned long flags;
>   	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   	struct etr_buf *sysfs_buf = tmc_etr_get_sysfs_buffer(csdev);
> @@ -1299,23 +1293,10 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>   
>   	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>   
> -	/*
> -	 * In sysFS mode we can have multiple writers per sink.  Since this
> -	 * sink is already enabled no memory is needed and the HW need not be
> -	 * touched, even if the buffer size has changed.
> -	 */
> -	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
> -		csdev->refcnt++;
> -		goto out;
> -	}
> -
>   	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
> -	if (!ret) {
> -		coresight_set_mode(csdev, CS_MODE_SYSFS);
> +	if (!ret)
>   		csdev->refcnt++;
> -	}
>   
> -out:
>   	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   
>   	if (!ret)
> @@ -1729,39 +1710,24 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>   {
>   	int rc = 0;
>   	pid_t pid;
> -	unsigned long flags;
>   	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   	struct perf_output_handle *handle = data;
>   	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
>   
> -	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
> -	 /* Don't use this sink if it is already claimed by sysFS */
> -	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
> -		rc = -EBUSY;
> -		goto unlock_out;
> -	}
> -
> -	if (WARN_ON(!etr_perf || !etr_perf->etr_buf)) {
> -		rc = -EINVAL;
> -		goto unlock_out;
> -	}
> +	if (WARN_ON(!etr_perf || !etr_perf->etr_buf))
> +		return -EINVAL;
>   
>   	/* Get a handle on the pid of the session owner */
>   	pid = etr_perf->pid;
>   
>   	/* Do not proceed if this device is associated with another session */
> -	if (drvdata->pid != -1 && drvdata->pid != pid) {
> -		rc = -EBUSY;
> -		goto unlock_out;
> -	}
> +	if (drvdata->pid != -1 && drvdata->pid != pid)
> +		return -EBUSY;
>   
> -	/*
> -	 * No HW configuration is needed if the sink is already in
> -	 * use for this session.
> -	 */
> +	/* The sink is already in use for this session */
>   	if (drvdata->pid == pid) {
>   		csdev->refcnt++;
> -		goto unlock_out;
> +		return rc;
>   	}
>   
>   	rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
> @@ -1773,22 +1739,60 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>   		csdev->refcnt++;
>   	}
>   
> -unlock_out:
> -	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   	return rc;
>   }
>   
>   static int tmc_enable_etr_sink(struct coresight_device *csdev,
>   			       enum cs_mode mode, void *data)
>   {
> -	switch (mode) {
> -	case CS_MODE_SYSFS:
> -		return tmc_enable_etr_sink_sysfs(csdev);
> -	case CS_MODE_PERF:
> -		return tmc_enable_etr_sink_perf(csdev, data);
> -	default:
> -		return -EINVAL;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	int rc;
> +
> +retry:
> +	scoped_guard(raw_spinlock_irqsave, &drvdata->spinlock) {
> +		if (coresight_get_mode(csdev) != CS_MODE_DISABLED &&
> +		    coresight_get_mode(csdev) != mode)
> +			return -EBUSY;
> +
> +		switch (mode) {
> +		case CS_MODE_SYSFS:
> +			if (drvdata->reading)
> +				return -EBUSY;
> +
> +			if (csdev->refcnt) {
> +				/* The sink is already enabled via sysfs */
> +				csdev->refcnt++;
> +				return 0;
> +			}
> +
> +			/*
> +			 * A sysfs session is currently enabling ETR, preventing
> +			 * a second sysfs process from repeatedly triggering the
> +			 * enable procedure.
> +			 */
> +			if (coresight_get_mode(csdev) == CS_MODE_SYSFS && !csdev->refcnt)
> +				goto retry;
> +
> +			/*
> +			 * Set ETR to sysfs mode before it is fully enabled, to
> +			 * prevent race conditions during mode transitions.
> +			 */
> +			coresight_set_mode(csdev, mode);
> +			break;
> +		case CS_MODE_PERF:
> +			return tmc_enable_etr_sink_perf(csdev, data);
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	rc = tmc_enable_etr_sink_sysfs(csdev);
> +	if (rc) {
> +		guard(raw_spinlock_irqsave)(&drvdata->spinlock);
> +		coresight_set_mode(csdev, CS_MODE_DISABLED);
>   	}
> +
> +	return rc;
>   }
>   
>   static int tmc_disable_etr_sink(struct coresight_device *csdev)


