Return-Path: <linux-kernel+bounces-731436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4134B05430
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FD94E706F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE132741D6;
	Tue, 15 Jul 2025 08:09:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3226E70B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566982; cv=none; b=EUZoKJmIGqVRk8R4iZcQJOAjAyQiFbXCsR4hyMjoyg9cA5IJ0yRD0hjWAoxVB7ACkh9FxBorFUhomy4oXZuIfyul5toLslXPk42wP4U6LVSesXQnM1YZLc/pBmqHTQj0VbnfmYoV0F181lEHiblo6nYy4yG8UOndrmy2h/OI4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566982; c=relaxed/simple;
	bh=hr3zerOe4nfZwj8DmzCaceuW1bdpwtZPNJ8A84pZ13E=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hF+4M/dk0ezvri+p7bz7RUeEAWIgsJeTO04QG2tIH2tJvSb5D36/8wQQz2qzCx8lun04mPImp13/BfcowLdOTt5FvRt0AyZ5YtwcRp+Ls4+qYcmd/nFbIbn1FnpvkOKOzE70Dv+GV0CQSSJL/5mC+K8PuZ1QFUxpzmUB5SjCfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bhBbs1Cf1z13MqH;
	Tue, 15 Jul 2025 16:06:49 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id AE36D1401F4;
	Tue, 15 Jul 2025 16:09:35 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 16:09:35 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 16:09:34 +0800
CC: <yangyicong@hisilicon.com>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<hejunhao3@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <wangyushan12@huawei.com>
Subject: Re: [RESEND PATCH v3 7/8] drivers/perf: hisi: Add support for
 HiSilicon NoC PMU
To: Will Deacon <will@kernel.org>
References: <20250619125557.57372-1-yangyicong@huawei.com>
 <20250619125557.57372-8-yangyicong@huawei.com>
 <aHUeJ1ovziG1rTyW@willie-the-truck>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <501e61fb-2dc5-c207-4bfd-1d3f23cd2c28@huawei.com>
Date: Tue, 15 Jul 2025 16:09:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aHUeJ1ovziG1rTyW@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/7/14 23:11, Will Deacon wrote:
> On Thu, Jun 19, 2025 at 08:55:56PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Adds the support for HiSilicon NoC (Network on Chip) PMU which
>> will be used to monitor the events on the system bus. The PMU
>> device will be named after the SCL ID (either Super CPU cluster
>> or Super IO cluster) and the index ID, just similar to other
>> HiSilicon Uncore PMUs. Below PMU formats are provided besides
>> the event:
>>
>> - ch: the transaction channel (data, request, response, etc) which
>>   can be used to filter the counting.
>> - tt_en: tracetag filtering enable. Just as other HiSilicon Uncore
>>   PMUs the NoC PMU supports only counting the transactions with
>>   tracetag.
>>
>> The NoC PMU doesn't have an interrupt to indicate the overflow.
>> However we have a 64 bit counter which is large enough and it's
>> nearly impossible to overflow.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  Documentation/admin-guide/perf/hisi-pmu.rst  |  11 +
>>  drivers/perf/hisilicon/Makefile              |   3 +-
>>  drivers/perf/hisilicon/hisi_uncore_noc_pmu.c | 392 +++++++++++++++++++
>>  3 files changed, 405 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c
> 
> [...]
> 
>> +static int hisi_noc_pmu_dev_init(struct platform_device *pdev, struct hisi_pmu *noc_pmu)
>> +{
>> +	hisi_uncore_pmu_init_topology(noc_pmu, &pdev->dev);
>> +
>> +	if (noc_pmu->topo.scl_id < 0)
>> +		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get scl-id\n");
>> +
>> +	if (noc_pmu->topo.index_id < 0)
>> +		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get idx-id\n");
>> +
>> +	if (noc_pmu->topo.sub_id < 0)
>> +		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get sub-id\n");
>> +
>> +	noc_pmu->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(noc_pmu->base))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(noc_pmu->base),
>> +				     "fail to remap io memory\n");
>> +
>> +	noc_pmu->on_cpu = -1;
>> +	noc_pmu->dev = &pdev->dev;
>> +	noc_pmu->ops = &hisi_uncore_noc_ops;
>> +	noc_pmu->pmu_events.attr_groups = hisi_noc_pmu_attr_groups;
>> +	noc_pmu->num_counters = NOC_PMU_NR_COUNTERS;
>> +	noc_pmu->counter_bits = NOC_PMU_COUNTER_BITS;
>> +	noc_pmu->check_event = NOC_PMU_EVENT_CTRL_TYPE;
>> +	noc_pmu->identifier = readl(noc_pmu->base + NOC_PMU_VERSION);
> 
> Would it be worth going straight to an ACPI-based lookup for this lot?
> The earlier patches in the series rework the existing drivers to go in
> that direction as it's easier to extend, so it seems a little odd for
> new driver code to revert back to e.g. reeading the version number.
> 
> Same for the misc node driver in the next patch.
> 

ok. was planned to change to that when new version comes with new capabilities and
hardware interface, but it's easy to change to that. will update.

Thanks.

