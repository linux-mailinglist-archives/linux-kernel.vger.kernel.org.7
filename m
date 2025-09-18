Return-Path: <linux-kernel+bounces-822644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0BB84623
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8723B9C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC85303A01;
	Thu, 18 Sep 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5uwumjL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFEA2582
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195617; cv=none; b=CdimfmxtFaQy9/xr9oCr2KP4fZ6Ew2VQAStMY3+b4+tsa8kKm+tzO4HFKc553kmxFPHcVF6jkFzoI69X67/zjgZunFxtePIdL/O0J17NyJcJn72ZSfgivix5vrfSWJO/y89RY3jHg2HDkXzpzeFIE0+T1R4Dyd/mwwNbwP+9WG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195617; c=relaxed/simple;
	bh=dQtfU+0WY2OOQFd+daG8wlVyguap+S9ukLR8d2rPA9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwnsKsVEs8bWvKaXTvPpTcWorjzAuW+zea9BQ8aHlbOyrmgLPWA944KAXqHvJLpjLDK1V/MIje13bZld5UVzFIlppT5ZdnI/Y2fvt6etvWQ2kjeuxR1UQBRqaqZszbZQKHXqLEI8P4AMyI5+WLUO5yQykdhBRS0Oh25Ek5ZfbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5uwumjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24D5C4CEE7;
	Thu, 18 Sep 2025 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758195616;
	bh=dQtfU+0WY2OOQFd+daG8wlVyguap+S9ukLR8d2rPA9c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=X5uwumjLoZi/9cRZf5qxtNG/cDxmIveicAdVj/wy/8arkY61vLt1wiVeiVHtB0i1t
	 AOo911TD8JxsyP4Ge5Oj5Kpt+N9diRTLkSd0HMv01TWpS5DI58Ki6wUFdvlwonebGN
	 +kQZhlbfOMcIGYnODGi4G+Kfr3DeSwJHV1WgM+NHHFUQW/jOmtPTcwVd0Be3lt5pVU
	 JUaMstblLJUmfUDobzhXBdpHEdI8f18DkmHDXg73M2wldkfohZHSxVCQbQnUxWAvFu
	 mDpPpS7GFfr3wVSUbKaSStP3EOsfYtqtiq/SyEgI2txZjajwsXGkEL/IX6eU1FjKy0
	 K+Md7a2o3FaTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38BDFCE0B32; Thu, 18 Sep 2025 04:40:16 -0700 (PDT)
Date: Thu, 18 Sep 2025 04:40:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: Zhang Changzhong <zhangchangzhong@huawei.com>, dave@stgolabs.net,
	josh@joshtriplett.org, frederic@kernel.org, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locktorture: Fix memory leak in param_set_cpumask()
Message-ID: <33613004-3bad-4847-ae7b-2b85cb01b502@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250912015737.1209143-1-wangliang74@huawei.com>
 <6b433670-c79e-4439-9b9a-f10c548a727f@huawei.com>
 <9d51ece8-cb07-450b-a91a-095abcb8472a@huawei.com>
 <679d81f3-2610-44b9-bc9a-30ef0f70fa36@paulmck-laptop>
 <2cc0b052-c464-44e2-9341-5eaf9858b24f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cc0b052-c464-44e2-9341-5eaf9858b24f@huawei.com>

On Thu, Sep 18, 2025 at 07:17:41PM +0800, Wang Liang wrote:
> 
> 在 2025/9/18 17:03, Paul E. McKenney 写道:
> > On Mon, Sep 15, 2025 at 10:13:33AM +0800, Wang Liang wrote:
> > > 在 2025/9/12 10:16, Zhang Changzhong 写道:
> > > > 在 2025/9/12 9:57, Wang Liang 写道:
> > > > > When setting the locktorture module parameter 'bind_writers', the variable
> > > > > 'cpumask_var_t bind_writers' is allocated in param_set_cpumask(). But it
> > > > > is not freed, when removing module or setting the parameter again.
> > > > > 
> > > > > Below kmemleak trace is seen for this issue:
> > > > > 
> > > > > unreferenced object 0xffff888100aabff8 (size 8):
> > > > >     comm "bash", pid 323, jiffies 4295059233
> > > > >     hex dump (first 8 bytes):
> > > > >       07 00 00 00 00 00 00 00                          ........
> > > > >     backtrace (crc ac50919):
> > > > >       __kmalloc_node_noprof+0x2e5/0x420
> > > > >       alloc_cpumask_var_node+0x1f/0x30
> > > > >       param_set_cpumask+0x26/0xb0 [locktorture]
> > > > >       param_attr_store+0x93/0x100
> > > > >       module_attr_store+0x1b/0x30
> > > > >       kernfs_fop_write_iter+0x114/0x1b0
> > > > >       vfs_write+0x300/0x410
> > > > >       ksys_write+0x60/0xd0
> > > > >       do_syscall_64+0xa4/0x260
> > > > >       entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > 
> > > > > This issue can be reproduced by:
> > > > >     insmod locktorture.ko
> > > > >     echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> > > > >     rmmod locktorture
> > > > > 
> > > > > or:
> > > > >     insmod locktorture.ko
> > > > >     echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> > > > >     echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> > > > > 
> > > > > The parameter 'bind_readers' also has the same problem. Free the memory
> > > > > when removing module or setting the parameter.
> > > > > 
> > > > > Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
> > > > > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > > > > ---
> > > > >    kernel/locking/locktorture.c | 9 +++++++++
> > > > >    1 file changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > > > > index ce0362f0a871..cad80c050502 100644
> > > > > --- a/kernel/locking/locktorture.c
> > > > > +++ b/kernel/locking/locktorture.c
> > > > > @@ -70,6 +70,9 @@ static int param_set_cpumask(const char *val, const struct kernel_param *kp)
> > > > >    	int ret;
> > > > >    	char *s;
> > > > > +	free_cpumask_var(*cm_bind);
> > > > > +	*cm_bind = NULL;
> > > > 这个NULL没必要吧
> > Assuming this translates to "This NULL is unnecessary", I have to
> > agree with Zhang Changzhong.  I would go further and argue that the
> > free_cpumask_var() is also unnecessary here.
> 
> Thanks for your replies!
> 
> The free_cpumask_var() in param_set_cpumask() may be necessary(). If user
> set the parameter for two times, the pointer will point to a new memory,
> and no one hold the old memory, which trigger a memory leak.

Why wouldn't the free_cpumask_var() you are adding to
lock_torture_cleanup() cover that case?

> > > Setting global pointer to NULL after free may be more safe. ^-^
> > In lock_torture_cleanup(), you mean?  I would agree with that.
> > 
> > > > > +
> > > > >    	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
> > > > >    		s = "Out of memory";
> > > > >    		ret = -ENOMEM;
> > > > > @@ -1211,6 +1214,12 @@ static void lock_torture_cleanup(void)
> > > > >    			cxt.cur_ops->exit();
> > > > >    		cxt.init_called = false;
> > > > >    	}
> > > > > +
> > > > > +	free_cpumask_var(bind_readers);
> > > > > +	free_cpumask_var(bind_writers);
> > > > > +	bind_readers = NULL;
> > > > > +	bind_writers = NULL;
> > > > 同上
> > But here I agree with Wang Liang, as it helps people running debuggers
> > on the kernel.  Instead of a dangling pointer, they see a NULL pointer.
> > 
> > Except...  Is this NULLing really the right thing to do for
> > CONFIG_CPUMASK_OFFSTACK=n kernels?
> 
> For CONFIG_CPUMASK_OFFSTACK=n, the NULLing may be not appropriate. I will
> remove it.

But if you remove the NULLing entirely, mightn't that inconvenience
people debugging?

							Thanx, Paul

> > > > > +
> > > > >    	torture_cleanup_end();
> > > > >    }

