Return-Path: <linux-kernel+bounces-789609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09404B3982B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1FF7C6123
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504792DF6EA;
	Thu, 28 Aug 2025 09:24:40 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707B20B22
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373079; cv=none; b=M03M3BNKKlNvZNaL7DojXLkFGrBQpSih1Mhl9YDqBQ8kz8oPjcfzFl05gTJw7e2/eorumzeF9+4Fa81q5IpJvAeoLqJ5htRe0mziN42l8nE3sPmR9MH57tn/oWM0DSw8FG8TE1I0hJ8xKy8zmtzpELxMm7xqTF1SmXCNvkzlySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373079; c=relaxed/simple;
	bh=cAMBpNEnqZBUMOZijFi0Wg0qpCRAYmjnSgUaC98oFLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OSGCy9ucLc/CgVk89jOOAPrSK2QflZmFOit3JEY//5IPMKO8e0i14WauFq1wsXVVfRv5FzzEWXqAcrCHGaT2Uak+MBGRnit1lTtRu9Mep8QRZJ5f3kAbf7Llt0VC8r8HAJR4LmkQhvtkAPmEGtHgRptUXrV9cAxbKUXgjQeBCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cCG823FhNz2CgB1;
	Thu, 28 Aug 2025 17:20:02 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id C425A1A016C;
	Thu, 28 Aug 2025 17:24:28 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 17:24:27 +0800
Message-ID: <a390e024-6115-442f-a1f6-6ebe379ade9f@huawei.com>
Date: Thu, 28 Aug 2025 17:24:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: fix warning in pps_register_cdev when register
 device fail
To: Calvin Owens <calvin@wbinvd.org>
CC: <giometti@enneenne.com>, <mschmidt@redhat.com>,
	<gregkh@linuxfoundation.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20250827065010.3208525-1-wangliang74@huawei.com>
 <aK8lIakmj_5eoPZN@mozart.vkv.me>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <aK8lIakmj_5eoPZN@mozart.vkv.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/8/27 23:32, Calvin Owens 写道:
> On Wednesday 08/27 at 14:50 +0800, Wang Liang wrote:
>> Similar to previous commit 2a934fdb01db ("media: v4l2-dev: fix error
>> handling in __video_register_device()"), the release hook should be set
>> before device_register(). Otherwise, when device_register() return error
>> and put_device() try to callback the release function, the below warning
>> may happen.
>>
>>    ------------[ cut here ]------------
>>    WARNING: CPU: 1 PID: 4760 at drivers/base/core.c:2567 device_release+0x1bd/0x240 drivers/base/core.c:2567
>>    Modules linked in:
>>    CPU: 1 UID: 0 PID: 4760 Comm: syz.4.914 Not tainted 6.17.0-rc3+ #1 NONE
>>    RIP: 0010:device_release+0x1bd/0x240 drivers/base/core.c:2567
>>    Call Trace:
>>     <TASK>
>>     kobject_cleanup+0x136/0x410 lib/kobject.c:689
>>     kobject_release lib/kobject.c:720 [inline]
>>     kref_put include/linux/kref.h:65 [inline]
>>     kobject_put+0xe9/0x130 lib/kobject.c:737
>>     put_device+0x24/0x30 drivers/base/core.c:3797
>>     pps_register_cdev+0x2da/0x370 drivers/pps/pps.c:402
>>     pps_register_source+0x2f6/0x480 drivers/pps/kapi.c:108
>>     pps_tty_open+0x190/0x310 drivers/pps/clients/pps-ldisc.c:57
>>     tty_ldisc_open+0xa7/0x120 drivers/tty/tty_ldisc.c:432
>>     tty_set_ldisc+0x333/0x780 drivers/tty/tty_ldisc.c:563
>>     tiocsetd drivers/tty/tty_io.c:2429 [inline]
>>     tty_ioctl+0x5d1/0x1700 drivers/tty/tty_io.c:2728
>>     vfs_ioctl fs/ioctl.c:51 [inline]
>>     __do_sys_ioctl fs/ioctl.c:598 [inline]
>>     __se_sys_ioctl fs/ioctl.c:584 [inline]
>>     __x64_sys_ioctl+0x194/0x210 fs/ioctl.c:584
>>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>     do_syscall_64+0x5f/0x2a0 arch/x86/entry/syscall_64.c:94
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>     </TASK>
>>
>> Before commit c79a39dc8d06 ("pps: Fix a use-after-free"),
>> pps_register_cdev() call device_create() to create pps->dev, which will
>> init dev->release to device_create_release(). Now the comment is outdated,
>> just remove it.
> Hi Wang,
>
> I'm curious why pps_register_cdev() is failing, is there possibly a
> second issue to investigate there? Or was it fault injection?


I find this issue from my local syzkaller project.

Function pps_register_cdev() call the universal interface 'device_register',
which can return error when kzalloc fail, or sysfs error, etc.

Hope the above information is helpful.

------
Best regards
Wang Liang

>
> Otherwise, makes perfect sense to me. I'm new to this code, so grain of
> salt, but since I exposed it:
>
> Reviewed-by: Calvin Owens <calvin@wbinvd.org>
>
> Thanks,
> Calvin
>
>> Fixes: c79a39dc8d06 ("pps: Fix a use-after-free")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   drivers/pps/pps.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>> index 9463232af8d2..0d2d57250575 100644
>> --- a/drivers/pps/pps.c
>> +++ b/drivers/pps/pps.c
>> @@ -383,13 +383,11 @@ int pps_register_cdev(struct pps_device *pps)
>>   	pps->dev.devt = MKDEV(pps_major, pps->id);
>>   	dev_set_drvdata(&pps->dev, pps);
>>   	dev_set_name(&pps->dev, "pps%d", pps->id);
>> +	pps->dev.release = pps_device_destruct;
>>   	err = device_register(&pps->dev);
>>   	if (err)
>>   		goto free_idr;
>>   
>> -	/* Override the release function with our own */
>> -	pps->dev.release = pps_device_destruct;
>> -
>>   	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
>>   		 pps->id);
>>   
>> -- 
>> 2.33.0
>>

