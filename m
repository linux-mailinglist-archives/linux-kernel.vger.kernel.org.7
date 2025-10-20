Return-Path: <linux-kernel+bounces-861843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22B7BF3CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F5A427FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64942ED87F;
	Mon, 20 Oct 2025 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5CnPmBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1BD1E51FA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997167; cv=none; b=ciLrnQHGDt3WgbtvzS7zRDYVt/sNQjxrPtPPJYVmPGNjJPXCq3j5DjUHybQHgffnFaMHh7CAG7vL3Yrr1JLzgEL5jv/HiU76unvIKMfPpu5WUP4cdVcbKTtKFFWl7ANFb5vxYzo8zIGHYEB3qbFCFjdf2acvtHxfiKYKth1khCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997167; c=relaxed/simple;
	bh=iyd8pE93WAj6cG+F3VpoDl3DCv3B2b7aMZ+rGzmq+3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkbJlKKCkLWY2Fc9jHv2BV0UIRxF94B5iU49BS4tzaMf/H7L73tRLczntdc7MllVYfHmnC5TkB8NhemrPn6rqNsBK9r2HCmqCWI7xchypcodUAAa1rHrj2nckduyrYrZuEj7Yma5+B9syac8a2JbQBO4z+GwpNFBmA45LeE7LXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5CnPmBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99BEC4CEFB;
	Mon, 20 Oct 2025 21:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760997165;
	bh=iyd8pE93WAj6cG+F3VpoDl3DCv3B2b7aMZ+rGzmq+3E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=i5CnPmBeQ3bwmCGwU+qCPISysGDP+6e4nqbvNIaGzEz6b9qdqsytS0kwIX8MO5vqM
	 YAjWvV+caZ46IM3n7UISxu4DumZVSryv87aoDstlJEtR50Z0Z8Zae7lsuRK06WRXfB
	 sXry7CxK50X9EOQXguyikfdBbtoFETPVswLM1Of3NKjGyK+DESQFfH7mi+ykxDbQg1
	 9Rf7pQnkSloxr/HnSfjUeqtuOVmmbpwsaymQzUYlvDY68k9u58PJwPoS+43hg9xfeK
	 U37gcTm1tef7+i3YahHPugc4+Qq5EvilAdcO+yy5Ibtlz3L09OtDaA+PfCI2IIiGg1
	 j+XoHu4z+6awA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 56873CE0C4A; Mon, 20 Oct 2025 14:52:45 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:52:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locktorture: Fix memory leak in param_set_cpumask()
Message-ID: <6719b1c4-3e7e-4c0f-aa80-a11dde0cf112@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250926035717.1025444-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926035717.1025444-1-wangliang74@huawei.com>

On Fri, Sep 26, 2025 at 11:57:17AM +0800, Wang Liang wrote:
> With CONFIG_CPUMASK_OFFSTACK=y, the 'bind_writers' buffer is allocated via
> alloc_cpumask_var() in param_set_cpumask(). But it is not freed, when
> setting the module parameter multiple times by sysfs interface or removing
> module.
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
>   insmod locktorture.ko bind_writers=1
>   rmmod locktorture
> 
> or:
>   insmod locktorture.ko bind_writers=1
>   echo 2 > /sys/module/locktorture/parameters/bind_writers
> 
> Considering that setting the module parameter 'bind_writers' or
> 'bind_readers' by sysfs interface has no real effect, set the parameter
> permissions to 0444. To fix the memory leak when removing module, free
> 'bind_writers' and 'bind_readers' memory in lock_torture_cleanup().
> 
> Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
> Suggested-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

I have pulled this in for further review and testing, and please accept
my apologies for the delay.

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index ce0362f0a871..6567e5eeacc0 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -103,8 +103,8 @@ static const struct kernel_param_ops lt_bind_ops = {
>  	.get = param_get_cpumask,
>  };
>  
> -module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0644);
> -module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0644);
> +module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0444);
> +module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0444);
>  
>  long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
>  
> @@ -1211,6 +1211,10 @@ static void lock_torture_cleanup(void)
>  			cxt.cur_ops->exit();
>  		cxt.init_called = false;
>  	}
> +
> +	free_cpumask_var(bind_readers);
> +	free_cpumask_var(bind_writers);
> +
>  	torture_cleanup_end();
>  }
>  
> -- 
> 2.34.1
> 

