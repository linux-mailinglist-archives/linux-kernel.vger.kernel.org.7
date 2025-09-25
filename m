Return-Path: <linux-kernel+bounces-831700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5AB9D597
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7201BC3574
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC112E6CD0;
	Thu, 25 Sep 2025 03:59:39 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C462AE8D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772779; cv=none; b=CIPCPoGQMsYFkIg0B8m4D+5KenIEeIrL8Z3Uf9tCCsua5xEngNCIikgoxOS5WS8sqcsruCLztxiphQLxP1+lwHW/BPnedWb4gSU1M6ZTKFaMvdTOdToZWI6HQC9lkgcfuP+JGDlDtEJKcz+de4O3QX6JoEd5M3miIhHAURIN0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772779; c=relaxed/simple;
	bh=ZvycIe7iQyudQPLew3ZrbuK7yGLjCoMYseSe6y2CgT8=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k6JCrSVBSm9uYnXjIBfXWs9v5r8QdrwB/qMXhp47Wbgns2F9btt8tDXO+v2IDossWFiM/F1Ox1tEB0oqsBdME9WOYVwMPXNPnWTwOvNFKFDmoYKKrRi5EMW6wJrvQeKw29LPCZBLMTXT4jZGZAAEgbrENKUzcTubP8dfU/mSQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cXKdh531Sz1R9MK;
	Thu, 25 Sep 2025 11:56:24 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id EA4EC140135;
	Thu, 25 Sep 2025 11:59:33 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 11:59:33 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 11:59:32 +0800
CC: <yangyicong@hisilicon.com>, Yushan Wang <wangyushan12@huawei.com>,
	<Jonathan.Cameron@huawei.com>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <liuyonglong@huawei.com>, <wanghuiqiang@huawei.com>,
	<prime.zeng@hisilicon.com>, <hejunhao3@h-partners.com>,
	<linuxarm@huawei.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v3 5/9] drivers/perf: hisi: Extend the field of tt_core
To: Will Deacon <will@kernel.org>
References: <20250829101427.2557899-1-wangyushan12@huawei.com>
 <20250829101427.2557899-6-wangyushan12@huawei.com>
 <aNFMUdPJeJo9XU1e@willie-the-truck>
 <3cc3fcdf-436a-9e73-a377-ed896d07a825@huawei.com>
 <aNPTwxnlXGbazFLR@willie-the-truck>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <d1731acc-81a7-df59-b6ac-650f30e0e780@huawei.com>
Date: Thu, 25 Sep 2025 11:59:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aNPTwxnlXGbazFLR@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/9/24 19:19, Will Deacon wrote:
> On Tue, Sep 23, 2025 at 03:31:15PM +0800, Yicong Yang wrote:
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>> index bbd81a43047d..a52d98f1ed34 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>> @@ -57,6 +57,11 @@
>>  #define L3C_V2_NR_EVENTS	0xFF
>>
>>  HISI_PMU_EVENT_ATTR_EXTRACTOR(ext, config, 17, 16);
>> +/*
>> + * Remain the config1:0-7 for backward compatibility if some existing users
>> + * hardcode the config1:0-7 directly without parsing the sysfs attribute.
>> + */
>> +HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_core_deprecated, config1, 7, 0);
>>  HISI_PMU_EVENT_ATTR_EXTRACTOR(tt_req, config1, 10, 8);
>>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_cfg, config1, 15, 11);
>>  HISI_PMU_EVENT_ATTR_EXTRACTOR(datasrc_skt, config1, 16, 16);
>> @@ -95,6 +100,21 @@ static bool support_ext(struct hisi_l3c_pmu *pmu)
>>  	return l3c_pmu_ext->support_ext;
>>  }
>>
>> +/*
>> + * tt_core was extended to cover all the CPUs sharing the L3 and was moved from
>> + * config1:0-7 to config2:0-*. Try it first and fallback to tt_core_deprecated
>> + * if user's still using the deprecated one.
>> + */
>> +static u32 hisi_l3c_pmu_get_tt_core(struct perf_event *event)
>> +{
>> +	u32 core = hisi_get_tt_core(event);
>> +
>> +	if (core)
>> +		return core;
>> +
>> +	return hisi_get_tt_core_deprecated(event);
>> +}
> 
> Perhaps we should be stricter about this and fail validation for events
> that specify both a non-zero tt_core and a non-zero tt_core_deprecated?
> 

added in hisi_uncore_l3c_ops->check_filter() that hisi_uncore_pmu_event_init() will
call check_filter() to ask uncore pmu to validate the filter configuration.

https://lore.kernel.org/linux-arm-kernel/20250925033123.5836-1-yangyicong@huawei.com/

thanks.

