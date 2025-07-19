Return-Path: <linux-kernel+bounces-737693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ACFB0AF76
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D837B340A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B9221F01;
	Sat, 19 Jul 2025 11:06:44 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09A186A
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923204; cv=none; b=S2/0R81emPkk9uCQ3JIv+oCw2pLsy+OCQCrN53BvCQISwEsP4LciKKIoVxPkDb5LaPGbVCo2cNovl2wwesHLYiz+Udy9ON08/kw153Oi+850ocwECcw40mm2bthJ5gZD3V812knmG7AfRiRsjRuoLPvyIUNAlTAG43Xogq1Xerc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923204; c=relaxed/simple;
	bh=Jqhyf5esafdVrs77vQ9Ygodm/F+YvqsIVtp1zk1cwPA=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dse8jRCHjGtLOmaqGMTqaVjYtW4gjbvBStEZDUDYgh1Zbb9I3vWLHSPIpM4B/9JyYM1XwoVpDl0jT6kHcInPY2BGvBpSihYpkzRa+F9r39eKcgsHY1t5zjPqKtbokgCaFsX//D7t91K6b3Yr1122Hz0Y//mhbOV05ggde+chpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bkkKK2DQYz2gKdp;
	Sat, 19 Jul 2025 19:03:01 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BE5A1A0188;
	Sat, 19 Jul 2025 19:05:40 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 19:05:39 +0800
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 19:05:39 +0800
Subject: Re: [PATCH v2 1/3] coresight: tmc: Add missing doc of
 tmc_drvdata::reading
To: Leo Yan <leo.yan@arm.com>
References: <20250620075412.952934-1-hejunhao3@huawei.com>
 <20250620075412.952934-2-hejunhao3@huawei.com>
 <20250702152720.GA794930@e132581.arm.com>
CC: <anshuman.khandual@arm.com>, <coresight@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<yangyicong@huawei.com>, <prime.zeng@hisilicon.com>
From: hejunhao <hejunhao3@huawei.com>
Message-ID: <41ddbd02-f2a5-f287-5096-90a420aee441@huawei.com>
Date: Sat, 19 Jul 2025 19:05:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250702152720.GA794930@e132581.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn500004.china.huawei.com (7.202.194.145)


On 2025/7/2 23:27, Leo Yan wrote:
> On Fri, Jun 20, 2025 at 03:54:10PM +0800, Junhao He wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> tmc_drvdata::reading is used to indicate whether a reading process
>> is performed through /dev/xyz.tmc. Document it.
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 6541a27a018e..3ca0d40c580d 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -220,6 +220,7 @@ struct tmc_resrv_buf {
>>    * @pid:	Process ID of the process that owns the session that is using
>>    *		this component. For example this would be the pid of the Perf
>>    *		process.
>> + * @reading:	buffer's in the reading through "/dev/xyz.tmc" entry
> Are you working on the latest code base? For example, the mainline
> kernel or coresight next branch.
> The latest code already has comment for reading, and I saw a duplicated
> "reading" field in tmc_drvdata.

This patch is based on mainline kernel v6.16-rc1, and adds a comment to 
struct tmc_drvdata::reading.
Perhaps, this git log could easily be misunderstood as adding comments 
to tmc_resrv_buf::reading.

> The tmc_resrv_buf structure does not have the fields "pid",
> "stop_on_flush", "buf", etc. They have been moved into the tmc_drvdata
> structure.
>
> Thanks,
> Leo
>
>>    * @stop_on_flush: Stop on flush trigger user configuration.
>>    * @buf:	Snapshot of the trace data for ETF/ETB.
>>    * @etr_buf:	details of buffer used in TMC-ETR
>> -- 
>> 2.33.0
>>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
> .
>


