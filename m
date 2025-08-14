Return-Path: <linux-kernel+bounces-768814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B8B265C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F381CC6F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047C2FE064;
	Thu, 14 Aug 2025 12:45:46 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595242F99B5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175545; cv=none; b=BZBBr4bu7xVv7DPJjw1bgo3f0vjkfHe56AFLB0DvtP4Bobmj+ptowfWhbf+MkKxxyceW+BSH/Iyi+ukNUKvyqfoi0hLfpPgsrFUoG3kSSBwbekeRn8lKuMo02LEWTTaBKWfArOnpuUiXl0vNr95tV8oTF+YwI4u6cgzjgjlPLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175545; c=relaxed/simple;
	bh=7hWjOw3PVybmFj2tHxI8p3DC8sedPFBr4PwhWeRUE8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=polfAwnK2PAlMzK9oxQipJtJLWacBqwWEaS/mxOrk23eDS/Ys7vH9Nupltrztpxp98xK8Ummccg0Ox9Zv95WZd84YyZNQE9ckYKb5bDCGzGjOK7TWVtQKJFXlW7Ruw/I2zv/dU2s/bK3NByoCBbyNeA3cDegsrFLWyf9US/K2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c2lGk4P8yzdcNY;
	Thu, 14 Aug 2025 20:41:18 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id F3636180491;
	Thu, 14 Aug 2025 20:45:38 +0800 (CST)
Received: from kwepemq200012.china.huawei.com (7.202.194.183) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 20:45:38 +0800
Received: from [10.174.178.57] (10.174.178.57) by
 kwepemq200012.china.huawei.com (7.202.194.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 20:45:38 +0800
Message-ID: <d81a264c-4b43-4bfd-a4ab-5a8bcdb1f584@huawei.com>
Date: Thu, 14 Aug 2025 20:45:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver core: Fix concurrent problem of
 deferred_probe_extend_timeout()
To: Greg KH <gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <dakr@kernel.org>, <tglx@linutronix.de>,
	<saravanak@google.com>, <robh@kernel.org>, <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenjun102@huawei.com>
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
 <20250814111023.2693-2-wangwensheng4@huawei.com>
 <2025081416-reverb-unaired-1de9@gregkh>
From: "wangwensheng (C)" <wangwensheng4@huawei.com>
In-Reply-To: <2025081416-reverb-unaired-1de9@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200012.china.huawei.com (7.202.194.183)



在 2025/8/14 19:37, Greg KH 写道:
> On Thu, Aug 14, 2025 at 07:10:21PM +0800, Wang Wensheng wrote:
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
>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>> ---
>>   drivers/base/dd.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 13ab98e033ea..1983919917e0 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -323,6 +323,7 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
>>   
>>   void deferred_probe_extend_timeout(void)
>>   {
>> +	mutex_lock(&deferred_probe_mutex);
> 
> Perhaps use a guard() instead?
> 
> thanks,
> 
> greg k-h
> 

Thanks for your suggestion. I have sent a v2 for this signle patch, 
because the other issue is not strongly related to this and need
more discussion.

