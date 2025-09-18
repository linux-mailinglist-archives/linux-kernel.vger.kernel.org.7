Return-Path: <linux-kernel+bounces-822613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E653B84515
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E517E1C03776
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45D2D59E3;
	Thu, 18 Sep 2025 11:17:54 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69F34BA40
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194274; cv=none; b=JMxRumcGyOC0l6yNEkI4HESK6AsxWogHFt0UN1i8h0zhhlZoHG8GEwYBgzlt19KTX3mliGKA6KA3Pz2OtDnscTFH3tYAwtBqlIpOP5BGZo6x+A7rF3bXzv1RRfmPhxn4IccQ73qoyVNNjnOnkdckNWLZHvkiPtSJx59eqQrQjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194274; c=relaxed/simple;
	bh=HR223lTGxZbzO2t/uqV2T8rUThTDsiJuXlnMeX3oZik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pQAS3Hk7C+oFsA3o2v7twXUh8zENZEj7hwdLA7uezd171e0P2qcR+1QOpHqHWa5X/ivqmba56D3rn3G77X7UoSOwPsCJKIdN+XIjflOP/qeUX6aV4m3zLxoN8QvLsC+UWtFzJuNyuXDSCQoRgeH4HFTta3c/RqYTrd5GPHIHmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cSCh85lBbz2VRr7;
	Thu, 18 Sep 2025 19:14:16 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 1822F1A0188;
	Thu, 18 Sep 2025 19:17:43 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 19:17:42 +0800
Message-ID: <2cc0b052-c464-44e2-9341-5eaf9858b24f@huawei.com>
Date: Thu, 18 Sep 2025 19:17:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locktorture: Fix memory leak in param_set_cpumask()
To: <paulmck@kernel.org>
CC: Zhang Changzhong <zhangchangzhong@huawei.com>, <dave@stgolabs.net>,
	<josh@joshtriplett.org>, <frederic@kernel.org>, <yuehaibing@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20250912015737.1209143-1-wangliang74@huawei.com>
 <6b433670-c79e-4439-9b9a-f10c548a727f@huawei.com>
 <9d51ece8-cb07-450b-a91a-095abcb8472a@huawei.com>
 <679d81f3-2610-44b9-bc9a-30ef0f70fa36@paulmck-laptop>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <679d81f3-2610-44b9-bc9a-30ef0f70fa36@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/9/18 17:03, Paul E. McKenney 写道:
> On Mon, Sep 15, 2025 at 10:13:33AM +0800, Wang Liang wrote:
>> 在 2025/9/12 10:16, Zhang Changzhong 写道:
>>> 在 2025/9/12 9:57, Wang Liang 写道:
>>>> When setting the locktorture module parameter 'bind_writers', the variable
>>>> 'cpumask_var_t bind_writers' is allocated in param_set_cpumask(). But it
>>>> is not freed, when removing module or setting the parameter again.
>>>>
>>>> Below kmemleak trace is seen for this issue:
>>>>
>>>> unreferenced object 0xffff888100aabff8 (size 8):
>>>>     comm "bash", pid 323, jiffies 4295059233
>>>>     hex dump (first 8 bytes):
>>>>       07 00 00 00 00 00 00 00                          ........
>>>>     backtrace (crc ac50919):
>>>>       __kmalloc_node_noprof+0x2e5/0x420
>>>>       alloc_cpumask_var_node+0x1f/0x30
>>>>       param_set_cpumask+0x26/0xb0 [locktorture]
>>>>       param_attr_store+0x93/0x100
>>>>       module_attr_store+0x1b/0x30
>>>>       kernfs_fop_write_iter+0x114/0x1b0
>>>>       vfs_write+0x300/0x410
>>>>       ksys_write+0x60/0xd0
>>>>       do_syscall_64+0xa4/0x260
>>>>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>
>>>> This issue can be reproduced by:
>>>>     insmod locktorture.ko
>>>>     echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>>>>     rmmod locktorture
>>>>
>>>> or:
>>>>     insmod locktorture.ko
>>>>     echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>>>>     echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>>>>
>>>> The parameter 'bind_readers' also has the same problem. Free the memory
>>>> when removing module or setting the parameter.
>>>>
>>>> Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
>>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>>>> ---
>>>>    kernel/locking/locktorture.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>>>> index ce0362f0a871..cad80c050502 100644
>>>> --- a/kernel/locking/locktorture.c
>>>> +++ b/kernel/locking/locktorture.c
>>>> @@ -70,6 +70,9 @@ static int param_set_cpumask(const char *val, const struct kernel_param *kp)
>>>>    	int ret;
>>>>    	char *s;
>>>> +	free_cpumask_var(*cm_bind);
>>>> +	*cm_bind = NULL;
>>> 这个NULL没必要吧
> Assuming this translates to "This NULL is unnecessary", I have to
> agree with Zhang Changzhong.  I would go further and argue that the
> free_cpumask_var() is also unnecessary here.


Thanks for your replies!

The free_cpumask_var() in param_set_cpumask() may be necessary(). If user
set the parameter for two times, the pointer will point to a new memory,
and no one hold the old memory, which trigger a memory leak.

>> Setting global pointer to NULL after free may be more safe. ^-^
> In lock_torture_cleanup(), you mean?  I would agree with that.
>
>>>> +
>>>>    	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
>>>>    		s = "Out of memory";
>>>>    		ret = -ENOMEM;
>>>> @@ -1211,6 +1214,12 @@ static void lock_torture_cleanup(void)
>>>>    			cxt.cur_ops->exit();
>>>>    		cxt.init_called = false;
>>>>    	}
>>>> +
>>>> +	free_cpumask_var(bind_readers);
>>>> +	free_cpumask_var(bind_writers);
>>>> +	bind_readers = NULL;
>>>> +	bind_writers = NULL;
>>> 同上
> But here I agree with Wang Liang, as it helps people running debuggers
> on the kernel.  Instead of a dangling pointer, they see a NULL pointer.
>
> Except...  Is this NULLing really the right thing to do for
> CONFIG_CPUMASK_OFFSTACK=n kernels?
>
> 							Thanx, Paul


For CONFIG_CPUMASK_OFFSTACK=n, the NULLing may be not appropriate. I 
will remove it.

>>>> +
>>>>    	torture_cleanup_end();
>>>>    }

