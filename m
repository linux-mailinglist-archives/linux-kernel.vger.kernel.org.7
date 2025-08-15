Return-Path: <linux-kernel+bounces-769957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E7B2755B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BF11CE54C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56529C33A;
	Fri, 15 Aug 2025 01:56:37 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E4295529
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222997; cv=none; b=BkglbLgDtPQpqa+dTXijORbJsi0Qz4TJe4jZ8rHMZm0N8z1bF9HBCZVnAhEFeM4tw3gO1+DAU2FyOHavPidwcakY5W2Y0ecj44LXjRtFtYx+oQp9qUA6BlXNM3tEu52pCDf4EsCinmOCLGWskqaERE4qG6Jb9XUdC5sOfMhI9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222997; c=relaxed/simple;
	bh=TUQNN1Kv+1X10EcPeWMf4uHXW/ASsJWKag7OpbHP7No=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fUW0QAS3mkIsnKCTlZRAYXZCEA3LiFlU+LOt+oMPe8XpnWmIdKaUMr5WbpbcQ+9qws28arqoU2b23AzjQJCy6e8vQ+ztNbrSrOEyX6/1H03HaVw6wr2z/pOMDHt98IfKrf+Xd4QmdK/olOkh40367LczaINJecgHAd/9fsejHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c34s007t4z2gL48;
	Fri, 15 Aug 2025 09:53:40 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id B9A72140123;
	Fri, 15 Aug 2025 09:56:30 +0800 (CST)
Received: from kwepemq200012.china.huawei.com (7.202.194.183) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 09:56:30 +0800
Received: from [10.174.178.57] (10.174.178.57) by
 kwepemq200012.china.huawei.com (7.202.194.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 09:56:29 +0800
Message-ID: <40fa16cf-950b-4ca7-9935-dbce75e46eb9@huawei.com>
Date: Fri, 15 Aug 2025 09:56:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: Fix concurrent problem of
 deferred_probe_extend_timeout()
To: Saravana Kannan <saravanak@google.com>, Greg KH
	<gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <dakr@kernel.org>, <robh@kernel.org>,
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>, <chenjun102@huawei.com>
References: <20250814122949.9024-1-wangwensheng4@huawei.com>
 <2025081451-police-playlist-3f9b@gregkh>
 <CAGETcx_-otRyDknVs4SFVWzf5-Zi07TiKUEpetDJJ3r0BTVqmw@mail.gmail.com>
From: "wangwensheng (C)" <wangwensheng4@huawei.com>
In-Reply-To: <CAGETcx_-otRyDknVs4SFVWzf5-Zi07TiKUEpetDJJ3r0BTVqmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200012.china.huawei.com (7.202.194.183)



在 2025/8/15 2:16, Saravana Kannan 写道:
> On Thu, Aug 14, 2025 at 7:20 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Aug 14, 2025 at 08:29:49PM +0800, Wang Wensheng wrote:
>>> The deferred_probe_timeout_work may be canceled forever unexpected when
>>> deferred_probe_extend_timeout() executes concurrently. Start with
>>> deferred_probe_timeout_work pending, and the problem would
>>> occur after the following sequence.
>>>
>>>           CPU0                                 CPU1
>>> deferred_probe_extend_timeout
>>>    -> cancel_delayed_work => true
>>>                                       deferred_probe_extend_timeout
>>>                                         -> cancel_delayed_wrok
>>>                                           -> __cancel_work
>>>                                             -> try_grab_pending
>>>    -> schedule_delayed_work
>>>     -> queue_delayed_work_on
>>> since pending bit is grabbed,
>>> just return without doing anything
>>>                                          -> set_work_pool_and_clear_pending
>>>                                       this __cancel_work return false and
>>>                                       the work would never be queued again
>>>
>>> The root cause is that the PENDING_BIT of the work_struct would be set
>>> temporaily in __cancel_work and this bit could prevent the work_struct
>>> to be queued in another CPU.
> 
> This feels more like a workqueue API issue (this isn't too obvious
> from the documentation) or me misusing the workqueue API.
> 
> Is this issue still there if you use cancel_delayed_work_sync()
> instead of cancel_delayed_work()? If so, just switch to that and add
> proper comment on why it needs to by "sync".
> 
> -Saravana
> 
cancel_delayed_work_sync() cannot solve the issue. Becasue this issue is 
to do with the interaction between cancel and queue operations for a 
work. The synchronization of the single cancel operation doesn't matter.

>>>
>>> Use deferred_probe_mutex to protect the cancel and queue operations for
>>> the deferred_probe_timeout_work to fix this problem.
>>>
>>> Fixes: 2b28a1a84a0e ("driver core: Extend deferred probe timeout on driver registration")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>>> ---
>>>   drivers/base/dd.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>> index 13ab98e033ea..00419d2ee910 100644
>>> --- a/drivers/base/dd.c
>>> +++ b/drivers/base/dd.c
>>> @@ -323,6 +323,7 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
>>>
>>>   void deferred_probe_extend_timeout(void)
>>>   {
>>> +     guard(mutex)(&deferred_probe_mutex);
>>
>> But if you grab the lock here, in the probe timeout function, the lock
>> will be grabbed again, causing a deadlock, right?  If not, why not?
>>
>> Have you run this patch with lockdep enabled?
>>
>> This feels broken to me, what am I missing?
>>
>> thanks,
>>
>> greg k-h
> 


