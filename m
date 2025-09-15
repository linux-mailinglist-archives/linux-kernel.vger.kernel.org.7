Return-Path: <linux-kernel+bounces-816014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F605B56E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2A9179A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368732165EA;
	Mon, 15 Sep 2025 02:13:41 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72321C16E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902420; cv=none; b=dq+CCBqYxwcDHhh35te0oIjDdIdATV4/rBSgaXJOaz4h5QNDipMR/fo/JdntsqmPQSq138HzgmjsitDt+4kg0bSR9NbJAVdHsALp+Ui6XqZPywcdNhZ1tQtnh1Tc4wxoMLFvjreh6cbVDuqHU0Q55dImLcUK+58F1H09Yjoj3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902420; c=relaxed/simple;
	bh=M1zr4g+YL0dCSc0J7WncCIFH2o5Pwo1l+lnSTGU2HA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SH7WSZBKDSWIaIccj55EQYX0of26NK9D57pHA1PiNRIKah6scFPbb1PjkWqV/uF3pmoX0ZhqoHTcajjf1Kx5aTGNHtzip0IBZO3+KcXAE+BMhx25ZBYx4QvHMu6kWG/Kr2E9xCXV3OCwuyXGR7YPrFQ6LHgqPsoavNLypOaVacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cQ7kP0BqCz2CgSs;
	Mon, 15 Sep 2025 10:09:01 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B247140148;
	Mon, 15 Sep 2025 10:13:35 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Sep 2025 10:13:34 +0800
Message-ID: <9d51ece8-cb07-450b-a91a-095abcb8472a@huawei.com>
Date: Mon, 15 Sep 2025 10:13:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locktorture: Fix memory leak in param_set_cpumask()
To: Zhang Changzhong <zhangchangzhong@huawei.com>, <dave@stgolabs.net>,
	<paulmck@kernel.org>, <josh@joshtriplett.org>, <frederic@kernel.org>
CC: <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20250912015737.1209143-1-wangliang74@huawei.com>
 <6b433670-c79e-4439-9b9a-f10c548a727f@huawei.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <6b433670-c79e-4439-9b9a-f10c548a727f@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/9/12 10:16, Zhang Changzhong 写道:
>
> 在 2025/9/12 9:57, Wang Liang 写道:
>> When setting the locktorture module parameter 'bind_writers', the variable
>> 'cpumask_var_t bind_writers' is allocated in param_set_cpumask(). But it
>> is not freed, when removing module or setting the parameter again.
>>
>> Below kmemleak trace is seen for this issue:
>>
>> unreferenced object 0xffff888100aabff8 (size 8):
>>    comm "bash", pid 323, jiffies 4295059233
>>    hex dump (first 8 bytes):
>>      07 00 00 00 00 00 00 00                          ........
>>    backtrace (crc ac50919):
>>      __kmalloc_node_noprof+0x2e5/0x420
>>      alloc_cpumask_var_node+0x1f/0x30
>>      param_set_cpumask+0x26/0xb0 [locktorture]
>>      param_attr_store+0x93/0x100
>>      module_attr_store+0x1b/0x30
>>      kernfs_fop_write_iter+0x114/0x1b0
>>      vfs_write+0x300/0x410
>>      ksys_write+0x60/0xd0
>>      do_syscall_64+0xa4/0x260
>>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> This issue can be reproduced by:
>>    insmod locktorture.ko
>>    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>>    rmmod locktorture
>>
>> or:
>>    insmod locktorture.ko
>>    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>>    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>>
>> The parameter 'bind_readers' also has the same problem. Free the memory
>> when removing module or setting the parameter.
>>
>> Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   kernel/locking/locktorture.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>> index ce0362f0a871..cad80c050502 100644
>> --- a/kernel/locking/locktorture.c
>> +++ b/kernel/locking/locktorture.c
>> @@ -70,6 +70,9 @@ static int param_set_cpumask(const char *val, const struct kernel_param *kp)
>>   	int ret;
>>   	char *s;
>>   
>> +	free_cpumask_var(*cm_bind);
>> +	*cm_bind = NULL;
> 这个NULL没必要吧


Setting global pointer to NULL after free may be more safe. ^-^

>> +
>>   	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
>>   		s = "Out of memory";
>>   		ret = -ENOMEM;
>> @@ -1211,6 +1214,12 @@ static void lock_torture_cleanup(void)
>>   			cxt.cur_ops->exit();
>>   		cxt.init_called = false;
>>   	}
>> +
>> +	free_cpumask_var(bind_readers);
>> +	free_cpumask_var(bind_writers);
>> +	bind_readers = NULL;
>> +	bind_writers = NULL;
> 同上
>
>> +
>>   	torture_cleanup_end();
>>   }
>>   

