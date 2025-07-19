Return-Path: <linux-kernel+bounces-737694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8BB0AF7C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EE9564425
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD0221F01;
	Sat, 19 Jul 2025 11:09:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B81E3DDE
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923392; cv=none; b=gwld+4qmLARDQrcpiMW/HPvLrUrEPQtOyjUNOBLSZiA3VlyHI4PgJieNQZqTJII99OL6saZ55QObrVWE9fVZW4j7FdhstmvMSBXZ70ISB2rkDBNkd0Ihj6tm3emyZL7JFeVJSmmRrs80dJdbAqsiWyxzy37TZ+k/evk3y4Wd+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923392; c=relaxed/simple;
	bh=33TO7SOBRi1e0VWy4kW4DgxXVCZU4AT0AUB1VKuajy8=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Su7kiwwwePpCYlAe+TGtFxisXNmRBQw38n2709lXMj+Z428KlVV7Xeu0XU2QEhG3PEiyr4uWfNB9rzduk2GwEY7zUCTJKpFdjDiIG0J61Nh5iE2Rbf/HjHp8xoXVuKHpG4+p2xjgxsKr05oz7KyB8CkUxi4iPDpQoRm2elMoSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bkkRm4th1ztSLD;
	Sat, 19 Jul 2025 19:08:36 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 66FB5180468;
	Sat, 19 Jul 2025 19:09:41 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 19:09:41 +0800
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 19:09:40 +0800
Subject: Re: [PATCH v2 2/3] coresight: tmc: refactor the tmc-etr mode setting
 to avoid race conditions
To: Leo Yan <leo.yan@arm.com>
References: <20250620075412.952934-1-hejunhao3@huawei.com>
 <20250620075412.952934-3-hejunhao3@huawei.com>
 <20250702164729.GA1039028@e132581.arm.com>
CC: <suzuki.poulose@arm.com>, <james.clark@arm.com>,
	<anshuman.khandual@arm.com>, <coresight@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<yangyicong@huawei.com>, <prime.zeng@hisilicon.com>
From: hejunhao <hejunhao3@huawei.com>
Message-ID: <8e359805-ac00-8d19-f278-9172d9daef96@huawei.com>
Date: Sat, 19 Jul 2025 19:09:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250702164729.GA1039028@e132581.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn500004.china.huawei.com (7.202.194.145)



On 2025/7/3 0:47, Leo Yan wrote:
> On Fri, Jun 20, 2025 at 03:54:11PM +0800, Junhao He wrote:
>
> [...]
>
>> To fix this, configure the tmc-etr mode before invoking enable_etr_perf()
>> or enable_etr_sysfs(), explicitly check if the tmc-etr sink is already
>> enabled in a different mode, and simplily the setup and checks for "mode".
>> To prevent race conditions between mode transitions.
> I have a similiar fixing for CTI driver, see:
> https://lore.kernel.org/linux-arm-kernel/20250701-arm_cs_pm_fix_v3-v2-0-23ebb864fcc1@arm.com/T/#maccd68b460fb8d74ccdd3504163d8f486f04178b
>
> [...]
>
>> @@ -1781,14 +1756,52 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>>   static int tmc_enable_etr_sink(struct coresight_device *csdev,
>>   			       enum cs_mode mode, void *data)
>>   {
>> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +	enum cs_mode old_mode;
>> +	int rc = -EINVAL;
>> +
>> +	scoped_guard(spinlock_irqsave, &drvdata->spinlock) {
> scoped_guard(raw_spinlock_irqsave, &drvdata->spinlock) {

Ok, will fix it.

> I am concerned that the spinlock is acquired and released for several
> times in a single flow. It is possible to hit some corner case, e.g.,
>
> - CPU0 acquires the lock, set sink as SYSFS mode, and releases the lock;
> - CPU1 acquires the lock, detects the SYSFS mode has been set,
>    directly bail out, then enable ETM.
>
> The problem is the sink has not been enabled yet. This leads to CPU1
> to enable the tracer but prior to sink's enabling.

Yes, you are right. So I added a minor note for that. The impact of this 
corner case may not have been fully considered.

> The key piont is we should ensure the mode is consistent to the
> hardware state. I will take a bit time for if we can have a better idea
> for this.
>
>> +		old_mode = coresight_get_mode(csdev);
>> +		if (old_mode != CS_MODE_DISABLED && old_mode != mode)
>> +			return -EBUSY;
>> +
>> +		if (drvdata->reading)
>> +			return -EBUSY;
>> +
>> +		/* In sysFS mode we can have multiple writers per sink. */
>> +		if (old_mode == CS_MODE_SYSFS) {
>> +			csdev->refcnt++;
> I am just wandering if we can unify the "refcnt" code for both SYSFS
> mode and Perf mode, and as a result, we can consolidate the code cross
> different drivers.
>
> Something like:
>
>                  if (!csdev->refcnt) {
>                          coresight_set_mode(csdev, mode);
>                  } else {
>                          /* The device has been configured with an incompatible mode */
>                          if (coresight_get_mode(csdev) != mode)
>                                  return -EBUSY;
>
>                          csdev->refcnt++;

we need to check the mode, cannot directly increase the reference count 
In performance mode.

>                  }
>
> Then when disable the device:
>
>                  csdev->refcnt--;
>                  if (!csdev->refcnt)
>                          coresight_set_mode(csdev, CS_MODE_DISABLED);
>
> We should not check "drvdata->reading" when enable or disable sink, as
> it is a flag to track if reading the trace buffer, it is irrelevant to
> the sink device's enabling or disabling.

In sysfs mode, it is necessary to check drvdata->reading.

>
> Please verify perf mode (especially for system wide session) to avoid
> anything missed.

I will refactor this code and upload a new version that includes all of 
your suggested solutions.

Thanks,
Junhao

> Thanks,
> Leo
>
>> +			return 0;
>> +		}
>> +
>> +		/*
>> +		 * minor note: In sysFS mode, the task1 get locked first, it setup
>> +		 * etr mode to SYSFS. Then task2 get locked，it will directly return
>> +		 * success even when the tmc-etr is not enabled at this moment.
>> +		 * Ultimately, task1 will still successfully enable tmc-etr.
>> +		 * This is a transient state and does not cause an anomaly.
>> +		 */
>> +		coresight_set_mode(csdev, mode);
>> +	}
>> +
>>   	switch (mode) {
>>   	case CS_MODE_SYSFS:
>> -		return tmc_enable_etr_sink_sysfs(csdev);
>> +		rc = tmc_enable_etr_sink_sysfs(csdev);
>> +		break;
>>   	case CS_MODE_PERF:
>> -		return tmc_enable_etr_sink_perf(csdev, data);
>> +		rc = tmc_enable_etr_sink_perf(csdev, data);
>> +		break;
>>   	default:
>> -		return -EINVAL;
>> +		rc = -EINVAL;
>>   	}
>> +
>> +	if (rc && old_mode != mode) {
>> +		scoped_guard(spinlock_irqsave, &drvdata->spinlock) {
>> +			coresight_set_mode(csdev, old_mode);
>> +		}
>> +	}
>> +
>> +	return rc;
>>   }
>>   
>>   static int tmc_disable_etr_sink(struct coresight_device *csdev)
>> -- 
>> 2.33.0
>>
> .
>


