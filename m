Return-Path: <linux-kernel+bounces-859929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F31BEEFBA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD143BDB96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49691B983F;
	Mon, 20 Oct 2025 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t/gWA6tZ"
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D41DF74F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760922724; cv=none; b=Sa1mY0+X18wrKpuvUCuTPzpCvVubpoYlCy2eMphNhR8LTbGpLHmKaKOioelKTWPhlj29cgmYaWztjJ5nKdlgLxbrS31BUsKy5redEILQaS3XoUxQAJp7UDR4F0XxKcr5DWUZYAizEzPRvCf5ddLnjNCCI/71Qz32n/yM1GmwCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760922724; c=relaxed/simple;
	bh=T9mTGsKQW+9/1aXDtVfF6YDk5S5wIDz9j+ZYb2rIv5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pwJSRY+6OLtKnlN7Ybje5Q65OeHlGKBZpqYOJGzczK1361xoztuoAxOurvUL5eJAvqhuhjYxWlTi7j8APeP/pnh2r+JIQtEyC8oSbrWvH8XzNAsq5y4J5KvwCoEO+D3l9VG/Oe7j+tgJSkJ3FGgEQO3kRFx/MCyY5+aShuSb0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t/gWA6tZ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NHbWTsDaL9nGOBz998Zyqz/G3T2kDv+gpUlJ0GvjZEQ=;
	b=t/gWA6tZ1cnnZKuBuXwFVLCxt4j+xQcxebmK1R+QwmMXT1dpumO+cKBaHIGPXkTI3YCTnERBr
	s98RQhTvJSJsWu4D8RNGxAg0/qkoIZSycnQL13g96IoXoU7oz6z5i/5bxlJBIp5CTt7lcunugeI
	0VX24LuR8IryMeb8f7+zkI4=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cqcn64x8BzpStg;
	Mon, 20 Oct 2025 09:10:50 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 420D418006C;
	Mon, 20 Oct 2025 09:11:53 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 09:11:52 +0800
Message-ID: <d36f6b47-6f43-4c81-b3d9-df86a2350428@huawei.com>
Date: Mon, 20 Oct 2025 09:11:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locktorture: Fix memory leak in param_set_cpumask()
To: <dave@stgolabs.net>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
	<frederic@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20250926035717.1025444-1-wangliang74@huawei.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250926035717.1025444-1-wangliang74@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/9/26 11:57, Wang Liang 写道:
> With CONFIG_CPUMASK_OFFSTACK=y, the 'bind_writers' buffer is allocated via
> alloc_cpumask_var() in param_set_cpumask(). But it is not freed, when
> setting the module parameter multiple times by sysfs interface or removing
> module.
>
> Below kmemleak trace is seen for this issue:
>
> unreferenced object 0xffff888100aabff8 (size 8):
>    comm "bash", pid 323, jiffies 4295059233
>    hex dump (first 8 bytes):
>      07 00 00 00 00 00 00 00                          ........
>    backtrace (crc ac50919):
>      __kmalloc_node_noprof+0x2e5/0x420
>      alloc_cpumask_var_node+0x1f/0x30
>      param_set_cpumask+0x26/0xb0 [locktorture]
>      param_attr_store+0x93/0x100
>      module_attr_store+0x1b/0x30
>      kernfs_fop_write_iter+0x114/0x1b0
>      vfs_write+0x300/0x410
>      ksys_write+0x60/0xd0
>      do_syscall_64+0xa4/0x260
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> This issue can be reproduced by:
>    insmod locktorture.ko bind_writers=1
>    rmmod locktorture
>
> or:
>    insmod locktorture.ko bind_writers=1
>    echo 2 > /sys/module/locktorture/parameters/bind_writers
>
> Considering that setting the module parameter 'bind_writers' or
> 'bind_readers' by sysfs interface has no real effect, set the parameter
> permissions to 0444. To fix the memory leak when removing module, free
> 'bind_writers' and 'bind_readers' memory in lock_torture_cleanup().
>
> Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
> Suggested-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>   kernel/locking/locktorture.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index ce0362f0a871..6567e5eeacc0 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -103,8 +103,8 @@ static const struct kernel_param_ops lt_bind_ops = {
>   	.get = param_get_cpumask,
>   };
>   
> -module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0644);
> -module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0644);
> +module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0444);
> +module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0444);
>   
>   long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
>   
> @@ -1211,6 +1211,10 @@ static void lock_torture_cleanup(void)
>   			cxt.cur_ops->exit();
>   		cxt.init_called = false;
>   	}
> +
> +	free_cpumask_var(bind_readers);
> +	free_cpumask_var(bind_writers);
> +
>   	torture_cleanup_end();
>   }
>   


ping


