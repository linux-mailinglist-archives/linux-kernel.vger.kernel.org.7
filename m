Return-Path: <linux-kernel+bounces-791498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04155B3B790
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC89B3BB460
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3C3043CA;
	Fri, 29 Aug 2025 09:33:13 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3B2F3600
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459992; cv=none; b=oFKPyX+OZg8MJaOieT8w/rsDfwkxD1qSdBSlOzI9eUjtyuxqSCiQ8SLMdJaEL29hFwq0b3dNqjqCsJcP4EV8yN9qnja4fpPnvphbeBYgvM5ncH7ShVZqFag1vYPGUYj53YwVAvENool0fzajVurnPTF5wRDrxEZjTE3wJwCmvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459992; c=relaxed/simple;
	bh=h/ZmDmhtToanLQILvP6T8a7P0EF4qUhOJF9lIAzqtLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H4AGAiPABuPRrBgzPeqqdn9I1zwhvxyoXuTzHokgE3ZELYTEXVCHRwmdOAmC3ApaeeeX2F2j4DCs/hsaCG0ko2P8dchDFAR9pTn7MnM9LnhWogyNbTJwEcI7XSvmGixdeUwopKTnkA0Auji40UeCfVKupiWEwlvUwRe747yY3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cCtHL0Hp5zPnT8;
	Fri, 29 Aug 2025 17:28:30 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B18014011A;
	Fri, 29 Aug 2025 17:33:06 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 17:33:05 +0800
Message-ID: <97ff43e3-874c-4b39-87b4-1bc30ebc27eb@huawei.com>
Date: Fri, 29 Aug 2025 17:33:04 +0800
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
 <aK8lIakmj_5eoPZN@mozart.vkv.me> <aLBYh7Fkrgg1IReX@mozart.vkv.me>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <aLBYh7Fkrgg1IReX@mozart.vkv.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/8/28 21:24, Calvin Owens 写道:
> On Wednesday 08/27 at 08:32 -0700, Calvin Owens wrote:
>> On Wednesday 08/27 at 14:50 +0800, Wang Liang wrote:
>>> Similar to previous commit 2a934fdb01db ("media: v4l2-dev: fix error
>>> handling in __video_register_device()"), the release hook should be set
>>> before device_register(). Otherwise, when device_register() return error
>>> and put_device() try to callback the release function, the below warning
>>> may happen.
>>>
>>>    ------------[ cut here ]------------
>>>    WARNING: CPU: 1 PID: 4760 at drivers/base/core.c:2567 device_release+0x1bd/0x240 drivers/base/core.c:2567
>>>    Modules linked in:
>>>    CPU: 1 UID: 0 PID: 4760 Comm: syz.4.914 Not tainted 6.17.0-rc3+ #1 NONE
>>>    RIP: 0010:device_release+0x1bd/0x240 drivers/base/core.c:2567
>>>    Call Trace:
>>>     <TASK>
>>>     kobject_cleanup+0x136/0x410 lib/kobject.c:689
>>>     kobject_release lib/kobject.c:720 [inline]
>>>     kref_put include/linux/kref.h:65 [inline]
>>>     kobject_put+0xe9/0x130 lib/kobject.c:737
>>>     put_device+0x24/0x30 drivers/base/core.c:3797
>>>     pps_register_cdev+0x2da/0x370 drivers/pps/pps.c:402
>>>     pps_register_source+0x2f6/0x480 drivers/pps/kapi.c:108
>>>     pps_tty_open+0x190/0x310 drivers/pps/clients/pps-ldisc.c:57
>>>     tty_ldisc_open+0xa7/0x120 drivers/tty/tty_ldisc.c:432
>>>     tty_set_ldisc+0x333/0x780 drivers/tty/tty_ldisc.c:563
>>>     tiocsetd drivers/tty/tty_io.c:2429 [inline]
>>>     tty_ioctl+0x5d1/0x1700 drivers/tty/tty_io.c:2728
>>>     vfs_ioctl fs/ioctl.c:51 [inline]
>>>     __do_sys_ioctl fs/ioctl.c:598 [inline]
>>>     __se_sys_ioctl fs/ioctl.c:584 [inline]
>>>     __x64_sys_ioctl+0x194/0x210 fs/ioctl.c:584
>>>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>     do_syscall_64+0x5f/0x2a0 arch/x86/entry/syscall_64.c:94
>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>     </TASK>
>>>
>>> Before commit c79a39dc8d06 ("pps: Fix a use-after-free"),
>>> pps_register_cdev() call device_create() to create pps->dev, which will
>>> init dev->release to device_create_release(). Now the comment is outdated,
>>> just remove it.
>> Hi Wang,
>>
>> I'm curious why pps_register_cdev() is failing, is there possibly a
>> second issue to investigate there? Or was it fault injection?
>>
>> Otherwise, makes perfect sense to me. I'm new to this code, so grain of
>> salt, but since I exposed it:
>>
>> Reviewed-by: Calvin Owens <calvin@wbinvd.org>
> I apologize Wang, I missed something when I looked at this yesterday:
>
> I think your patch introduces a double-free, because the pps object is
> already freed by pps_register_source() when pps_register_cdev() returns
> an error. Because put_device() was a nop with the missing release_fn, it
> wasn't actually doing anything. That's very confusing, and my fault.


You are right! Thanks for the reminder. I reproduce the double-free issue:

==================================================================
BUG: KASAN: double-free in pps_register_source+0x2c1/0x3a0
Free of addr ffff8881078fd800 by task insmod/323
Call Trace:
  <TASK>
  dump_stack_lvl+0x55/0x70
  print_report+0xcb/0x610
  kasan_report_invalid_free+0x94/0xc0
  check_slab_allocation+0x105/0x130
  kfree+0xba/0x360
  pps_register_source+0x2c1/0x3a0

It is triggered by kzalloc fail in device_private_init().

> Your patch is clearly an improvement. But I think you additionally need
> to remove the 'kfree_pps' error logic at the bottom of
> pps_register_source() to avoid a double free in the failure case:


Thanks for your suggestions, it is helpful!

I will send a v2 patch later. Thanks!

------
Best regards
Wang Liang

>
> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> index 92d1b62ea239..4d0ba35590a3 100644
> --- a/drivers/pps/kapi.c
> +++ b/drivers/pps/kapi.c
> @@ -116,9 +116,6 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
>   
>   	return pps;
>   
> -kfree_pps:
> -	kfree(pps);
> -
>   pps_register_source_exit:
>   	pr_err("%s: unable to register source\n", info->name);
>   
>
> The only reason I put that kfree() there is because I noticed the memory
> was being leaked in the failure case. Doh. Your patch makes this right.
>
>> Thanks,
>> Calvin
>>
>>> Fixes: c79a39dc8d06 ("pps: Fix a use-after-free")
>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>>> ---
>>>   drivers/pps/pps.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>>> index 9463232af8d2..0d2d57250575 100644
>>> --- a/drivers/pps/pps.c
>>> +++ b/drivers/pps/pps.c
>>> @@ -383,13 +383,11 @@ int pps_register_cdev(struct pps_device *pps)
>>>   	pps->dev.devt = MKDEV(pps_major, pps->id);
>>>   	dev_set_drvdata(&pps->dev, pps);
>>>   	dev_set_name(&pps->dev, "pps%d", pps->id);
>>> +	pps->dev.release = pps_device_destruct;
>>>   	err = device_register(&pps->dev);
>>>   	if (err)
>>>   		goto free_idr;
>>>   
>>> -	/* Override the release function with our own */
>>> -	pps->dev.release = pps_device_destruct;
>>> -
>>>   	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
>>>   		 pps->id);
>>>   
>>> -- 
>>> 2.33.0
>>>

