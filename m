Return-Path: <linux-kernel+bounces-813059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51578B54043
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C71A585A81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953C19F12D;
	Fri, 12 Sep 2025 02:17:00 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967FD74420
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643420; cv=none; b=XIpnV2qpYwo+WIRUgtz08aybie08gXIPk205Wu4vAA6UmB2JiwClryWf9ZMqzaBlI7jislh0rmi8cOuTWFPZYMQ98+vCUzvhBbBpzrk6g69mKeAvuVBwmpdVH+LXrw/IJfIV/wXWNBMGYFglrvsyNQOeYVVL9iCh0dm1r9PBdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643420; c=relaxed/simple;
	bh=eglsahEpLNmA2NoiGIZSRVaOEPO0KsZk+bUJ2g1rVaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YI42teP2/Y6qfpb433GNaJHVDwGJFHAp9PtMtZXg578pILChOPqQCosUglO/9rUF8s2bFc0f935cOXF2aztDyiIW/7ypJqt/syJkeYLdchfk9rdaUT8ELzEf+CFQmr+H11B40V+K7rv5GMMMok9tFPxstfabwfuUY+JUFqPvf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cNJ4C5W16z3tZXQ;
	Fri, 12 Sep 2025 10:18:03 +0800 (CST)
Received: from kwepemp100011.china.huawei.com (unknown [7.202.195.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 58E19180042;
	Fri, 12 Sep 2025 10:16:54 +0800 (CST)
Received: from [10.174.178.240] (10.174.178.240) by
 kwepemp100011.china.huawei.com (7.202.195.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Sep 2025 10:16:53 +0800
Message-ID: <6b433670-c79e-4439-9b9a-f10c548a727f@huawei.com>
Date: Fri, 12 Sep 2025 10:16:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locktorture: Fix memory leak in param_set_cpumask()
To: Wang Liang <wangliang74@huawei.com>, <dave@stgolabs.net>,
	<paulmck@kernel.org>, <josh@joshtriplett.org>, <frederic@kernel.org>
CC: <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20250912015737.1209143-1-wangliang74@huawei.com>
From: Zhang Changzhong <zhangchangzhong@huawei.com>
In-Reply-To: <20250912015737.1209143-1-wangliang74@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemp100011.china.huawei.com (7.202.195.41)



在 2025/9/12 9:57, Wang Liang 写道:
> When setting the locktorture module parameter 'bind_writers', the variable
> 'cpumask_var_t bind_writers' is allocated in param_set_cpumask(). But it
> is not freed, when removing module or setting the parameter again.
> 
> Below kmemleak trace is seen for this issue:
> 
> unreferenced object 0xffff888100aabff8 (size 8):
>   comm "bash", pid 323, jiffies 4295059233
>   hex dump (first 8 bytes):
>     07 00 00 00 00 00 00 00                          ........
>   backtrace (crc ac50919):
>     __kmalloc_node_noprof+0x2e5/0x420
>     alloc_cpumask_var_node+0x1f/0x30
>     param_set_cpumask+0x26/0xb0 [locktorture]
>     param_attr_store+0x93/0x100
>     module_attr_store+0x1b/0x30
>     kernfs_fop_write_iter+0x114/0x1b0
>     vfs_write+0x300/0x410
>     ksys_write+0x60/0xd0
>     do_syscall_64+0xa4/0x260
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This issue can be reproduced by:
>   insmod locktorture.ko
>   echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>   rmmod locktorture
> 
> or:
>   insmod locktorture.ko
>   echo 0-2 > /sys/module/locktorture/parameters/bind_writers
>   echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> 
> The parameter 'bind_readers' also has the same problem. Free the memory
> when removing module or setting the parameter.
> 
> Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  kernel/locking/locktorture.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index ce0362f0a871..cad80c050502 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -70,6 +70,9 @@ static int param_set_cpumask(const char *val, const struct kernel_param *kp)
>  	int ret;
>  	char *s;
>  
> +	free_cpumask_var(*cm_bind);
> +	*cm_bind = NULL;

这个NULL没必要吧

> +
>  	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
>  		s = "Out of memory";
>  		ret = -ENOMEM;
> @@ -1211,6 +1214,12 @@ static void lock_torture_cleanup(void)
>  			cxt.cur_ops->exit();
>  		cxt.init_called = false;
>  	}
> +
> +	free_cpumask_var(bind_readers);
> +	free_cpumask_var(bind_writers);
> +	bind_readers = NULL;
> +	bind_writers = NULL;

同上

> +
>  	torture_cleanup_end();
>  }
>  


