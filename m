Return-Path: <linux-kernel+bounces-721183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DCAFC5D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A719617B4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666AB2BCF4D;
	Tue,  8 Jul 2025 08:37:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAB219A97
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963848; cv=none; b=DQRw/VDyDFqVHsY8gcYE6vJDaNd0eMfL/lWRZqSvcfUrw8dZ30q4GDOUwchDNrRphF7iNAtuglCDXBvP8QwoTOKY/Ta9yAl7W9ecCcyZjIIum/XegvQYTaUeh3ecLxhoByHtatHyy0YcDp27p6HBKkPmVv4lCw+WNvOqHU2ItWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963848; c=relaxed/simple;
	bh=YVBLRbIVMOEpLw9Hns5hOIjQAkuFkNNYhqbl0OCveH0=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fVQxLJhMYkZn4Nlo4Eil2+ZzDdrRjxikbgDr5c/MMmTpO10OD0glothRUXFAOHXMZmSNf9yom8NhRC3piO/N5BwCaNxFIfx7rZIYrS+XkmtRHEInw0RAXNWiL2vSJna0JGzlp9DQMnxFDkCgW5Mm9olocq0MujyIeNG3LN4e0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bbvWD55WczWfwJ;
	Tue,  8 Jul 2025 16:32:56 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BA30180466;
	Tue,  8 Jul 2025 16:37:22 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 16:37:21 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 16:37:21 +0800
CC: Juri Lelli <juri.lelli@redhat.com>, <yangyicong@hisilicon.com>,
	<mingo@redhat.com>, <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [PATCH] sched/deadline: Don't count nr_running twice for
 dl_server proxy tasks
To: <peterz@infradead.org>
References: <20250627035420.37712-1-yangyicong@huawei.com>
 <aF5QwYFj15DLDbBR@jlelli-thinkpadt14gen4.remote.csb>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <a8037d19-bccc-0567-8e00-8692b3787f7c@huawei.com>
Date: Tue, 8 Jul 2025 16:37:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aF5QwYFj15DLDbBR@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200018.china.huawei.com (7.202.195.108)

Hi Peter,

On 2025/6/27 16:05, Juri Lelli wrote:
> Hello,
> 
> On 27/06/25 11:54, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> On CPU offline the kernel stalled with below call trace:
>>
>>   INFO: task kworker/0:1:11 blocked for more than 120 seconds.
>>         Tainted: G           O        6.15.0-rc4+ #1
>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>   task:kworker/0:1     state:D stack:0     pid:11    tgid:11    ppid:2   task_flags:0x4208060 flags:0x00000008
>>   Workqueue: events vmstat_shepherd
>>   Call trace:
>>    __switch_to+0x118/0x188 (T)
>>    __schedule+0x31c/0x1300
>>    schedule+0x3c/0x120
>>    percpu_rwsem_wait+0x12c/0x1b0
>>    __percpu_down_read+0x78/0x188
>>    cpus_read_lock+0xc4/0xe8
>>    vmstat_shepherd+0x30/0x138
>>    process_one_work+0x154/0x3c8
>>    worker_thread+0x2e8/0x400
>>    kthread+0x154/0x230
>>    ret_from_fork+0x10/0x20
>>   INFO: task kworker/1:1:116 blocked for more than 120 seconds.
>>         Tainted: G           O        6.15.0-rc4+ #1
>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>   task:kworker/1:1     state:D stack:0     pid:116   tgid:116   ppid:2   task_flags:0x4208060 flags:0x00000008
>>   Workqueue: events work_for_cpu_fn
>>   Call trace:
>>    __switch_to+0x118/0x188 (T)
>>    __schedule+0x31c/0x1300
>>    schedule+0x3c/0x120
>>    schedule_timeout+0x10c/0x120
>>    __wait_for_common+0xc4/0x1b8
>>    wait_for_completion+0x28/0x40
>>    cpuhp_kick_ap_work+0x114/0x3c8
>>    _cpu_down+0x130/0x4b8
>>    __cpu_down_maps_locked+0x20/0x38
>>    work_for_cpu_fn+0x24/0x40
>>    process_one_work+0x154/0x3c8
>>    worker_thread+0x2e8/0x400
>>    kthread+0x154/0x230
>>    ret_from_fork+0x10/0x20
>>
>> cpuhp hold the cpu hotplug lock endless and stalled vmstat_shepherd.
>> This is because we count nr_running twice on cpuhp enqueuing and failed
>> the wait condition of cpuhp:
>>
>> enqueue_task_fair() // pick cpuhp from idle, rq->nr_running = 0
>>   dl_server_start()
>>     [...]
>>     add_nr_running() // rq->nr_running = 1
>>   add_nr_running() // rq->nr_running = 2
>> [switch to cpuhp, waiting on balance_hotplug_wait()]
>> rcuwait_wait_event(rq->nr_running == 1 && ...) // failed, rq->nr_running=2
>>   schedule() // wait again
>>
>> This doesn't make sense to count one single task twice on
>> rq->nr_running. So fix this.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  kernel/sched/deadline.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index ad45a8fea245..59fb178762ee 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -1894,7 +1894,9 @@ void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
>>  	u64 deadline = dl_se->deadline;
>>  
>>  	dl_rq->dl_nr_running++;
>> -	add_nr_running(rq_of_dl_rq(dl_rq), 1);
>> +
>> +	if (!dl_server(dl_se))
>> +		add_nr_running(rq_of_dl_rq(dl_rq), 1);
>>  
>>  	inc_dl_deadline(dl_rq, deadline);
>>  }
>> @@ -1904,7 +1906,9 @@ void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
>>  {
>>  	WARN_ON(!dl_rq->dl_nr_running);
>>  	dl_rq->dl_nr_running--;
>> -	sub_nr_running(rq_of_dl_rq(dl_rq), 1);
>> +
>> +	if (!dl_server(dl_se))
>> +		sub_nr_running(rq_of_dl_rq(dl_rq), 1);
>>  
>>  	dec_dl_deadline(dl_rq, dl_se->deadline);
>>  }
> 
> This seems to make sense to me. Thanks for the analysis and the patch.
> 
> Peter, what do you think?
> 

does this also make sense to you? or any other solutions you'd like me to try?

thanks.


