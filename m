Return-Path: <linux-kernel+bounces-769893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21CBB274D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 251AB7B20A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468828750F;
	Fri, 15 Aug 2025 01:43:39 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36C25A65B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222219; cv=none; b=lPqW1w238WysnwPSjG6Ga45ii1JE56u0KKUyrTh3sm7XfJueWtOWqC99m/2Lhsqhlqhadl/hHMDS2QcltFbakHlWK7X6mhiL8MpWie/UNf7jtd2fvRPN1k5/aUBH+Eabczd3rsItSQRf0q3cLcU9jp4swL0REXXfu1+V6313r50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222219; c=relaxed/simple;
	bh=akrllYiBfjKFRA3cOKuKnOKZu1mv73/0kWQEKs0Up5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tklmbQRbN8fDXXybrppxthNs1XBYngl6Zc0yHYqVWOF9PZX7WK9zPUijFKVWfieg7sEnB2bn73ZZWrwggI/V1uQ7eU3dLLKG6OZnCqkioBRaetshjPWybK4ajaZsS5FUK4FywxIClcBJjdSKqK/QpOk9a4bxdJxtlMtWObSCIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c34Z86TFFz2TTCN;
	Fri, 15 Aug 2025 09:40:48 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D304140123;
	Fri, 15 Aug 2025 09:43:31 +0800 (CST)
Received: from kwepemq200012.china.huawei.com (7.202.194.183) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 09:43:31 +0800
Received: from [10.174.178.57] (10.174.178.57) by
 kwepemq200012.china.huawei.com (7.202.194.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 09:43:30 +0800
Message-ID: <625d7464-cc31-4cac-bd50-7bed75212143@huawei.com>
Date: Fri, 15 Aug 2025 09:43:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: Fix concurrent problem of
 deferred_probe_extend_timeout()
To: Greg KH <gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <dakr@kernel.org>, <robh@kernel.org>,
	<broonie@kernel.org>, <saravanak@google.com>, <linux-kernel@vger.kernel.org>,
	<chenjun102@huawei.com>
References: <20250814122949.9024-1-wangwensheng4@huawei.com>
 <2025081451-police-playlist-3f9b@gregkh>
From: "wangwensheng (C)" <wangwensheng4@huawei.com>
In-Reply-To: <2025081451-police-playlist-3f9b@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200012.china.huawei.com (7.202.194.183)



在 2025/8/14 22:19, Greg KH 写道:
> On Thu, Aug 14, 2025 at 08:29:49PM +0800, Wang Wensheng wrote:
>> The deferred_probe_timeout_work may be canceled forever unexpected when
>> deferred_probe_extend_timeout() executes concurrently. Start with
>> deferred_probe_timeout_work pending, and the problem would
>> occur after the following sequence.
>>
>>           CPU0                                 CPU1
>> deferred_probe_extend_timeout
>>    -> cancel_delayed_work => true
>>                                       deferred_probe_extend_timeout
>>                                         -> cancel_delayed_wrok
>>                                           -> __cancel_work
>>                                             -> try_grab_pending
>>    -> schedule_delayed_work
>>     -> queue_delayed_work_on
>> since pending bit is grabbed,
>> just return without doing anything
>>                                          -> set_work_pool_and_clear_pending
>>                                       this __cancel_work return false and
>>                                       the work would never be queued again
>>
>> The root cause is that the PENDING_BIT of the work_struct would be set
>> temporaily in __cancel_work and this bit could prevent the work_struct
>> to be queued in another CPU.
>>
>> Use deferred_probe_mutex to protect the cancel and queue operations for
>> the deferred_probe_timeout_work to fix this problem.
>>
>> Fixes: 2b28a1a84a0e ("driver core: Extend deferred probe timeout on driver registration")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>> ---
>>   drivers/base/dd.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 13ab98e033ea..00419d2ee910 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -323,6 +323,7 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
>>   
>>   void deferred_probe_extend_timeout(void)
>>   {
>> +	guard(mutex)(&deferred_probe_mutex);
> 
> But if you grab the lock here, in the probe timeout function, the lock
> will be grabbed again, causing a deadlock, right?  If not, why not?

It's not a sync version of cancel_work, so the execuation of the work 
function doesn't block us here, nor does the schedule_delayed_work does.

Indead, deferred_probe_mutex is used to protect the 
deferred_probe_*_list, it looks better to use a new lock here. Right?

> 
> Have you run this patch with lockdep enabled?
> 
> This feels broken to me, what am I missing?
> 
> thanks,
> 
> greg k-h
> 


