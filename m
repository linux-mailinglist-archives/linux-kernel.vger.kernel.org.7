Return-Path: <linux-kernel+bounces-823115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3AB858B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430BA16A66C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED7430C36A;
	Thu, 18 Sep 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaajM5Zp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B89D216E23
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208822; cv=none; b=Jy/abk9uO5l4PbfOH9xT34bTYjsN7tGWmJCzkdSFEIzMVEaGXLf7+KbqtCm84SwKOWbWTkwFLvQB+/fnrS9QBgdX8wZG0vjWhDS6v8uiTmRX6HHp9XqvZ6NraqmeBjX4HWCiMNo6ZwVApRL2sdb/FibrTLiDAH/bmSoQCuwrFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208822; c=relaxed/simple;
	bh=rlH9iXynbHXDPOL83UpGLs9Hz8fO31/3RqNRTJVgV+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiIrZgMVB2pXUSW0AfJWt7HxzTwu7rMvD2F5Y7MJEzi6hy0a9YaQSCgdNNWbThCyMiAMv+PvjCQaj71HCi44oxn+LRl7hkrQa9xvLn+vNd94mm3JG+hxha+shQkcUl2k8CWSYMNwtFSzRbhStHCSCANPqAtkmrq5Dsb9ySj+y6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaajM5Zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2133FC4CEEB;
	Thu, 18 Sep 2025 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208822;
	bh=rlH9iXynbHXDPOL83UpGLs9Hz8fO31/3RqNRTJVgV+I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WaajM5Zp3sCMVZylM4pJ+u/RxGSwwb3QPpti0vJwYlHfP+5bGo+d7ECKXZsX54bXP
	 LoA2v5oH9rbt15Mhhu8YwrIyKlwKDdJj2hS7cjeQ7+dyBABLeonEboWUmNIUAymlQf
	 lf4a1Lj1wJTl0j2pFWZ6vQ1CP2K960vcWkWxPY/wSP/zvWRZDqfLCT2IvGxwpyuPVK
	 CUoCAfCpSp/KJPhhQvqqP98oZPlUqtb+PWdTuEBHliaiPJ7hFLfSSJyweUVREC2h3h
	 EDQUpYHwXigpiiFSXZOgUw7FaMS48GyuUMLElRb/B/OMwsViILhHiI433zEtBsu7BB
	 1Hb+lgeTk5ZVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7BD84CE10F4; Thu, 18 Sep 2025 08:20:21 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:20:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: Wang Liang <wangliang74@huawei.com>, dave@stgolabs.net,
	josh@joshtriplett.org, frederic@kernel.org, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locktorture: Fix memory leak in param_set_cpumask()
Message-ID: <9e0595a2-cbba-4635-b57c-a220f2d86fe2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250912015737.1209143-1-wangliang74@huawei.com>
 <6b433670-c79e-4439-9b9a-f10c548a727f@huawei.com>
 <9d51ece8-cb07-450b-a91a-095abcb8472a@huawei.com>
 <679d81f3-2610-44b9-bc9a-30ef0f70fa36@paulmck-laptop>
 <5eccd340-a4bb-4b46-897e-a673f9a5cb86@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eccd340-a4bb-4b46-897e-a673f9a5cb86@huawei.com>

On Thu, Sep 18, 2025 at 11:06:45PM +0800, Zhang Changzhong wrote:
> 在 2025/9/18 17:03, Paul E. McKenney 写道:
> > On Mon, Sep 15, 2025 at 10:13:33AM +0800, Wang Liang wrote:
> >> 在 2025/9/12 10:16, Zhang Changzhong 写道:
> >>> 在 2025/9/12 9:57, Wang Liang 写道:
> >>>> When setting the locktorture module parameter 'bind_writers', the variable
> >>>> 'cpumask_var_t bind_writers' is allocated in param_set_cpumask(). But it
> >>>> is not freed, when removing module or setting the parameter again.
> >>>>
> >>>> Below kmemleak trace is seen for this issue:
> >>>>
> >>>> unreferenced object 0xffff888100aabff8 (size 8):
> >>>>    comm "bash", pid 323, jiffies 4295059233
> >>>>    hex dump (first 8 bytes):
> >>>>      07 00 00 00 00 00 00 00                          ........
> >>>>    backtrace (crc ac50919):
> >>>>      __kmalloc_node_noprof+0x2e5/0x420
> >>>>      alloc_cpumask_var_node+0x1f/0x30
> >>>>      param_set_cpumask+0x26/0xb0 [locktorture]
> >>>>      param_attr_store+0x93/0x100
> >>>>      module_attr_store+0x1b/0x30
> >>>>      kernfs_fop_write_iter+0x114/0x1b0
> >>>>      vfs_write+0x300/0x410
> >>>>      ksys_write+0x60/0xd0
> >>>>      do_syscall_64+0xa4/0x260
> >>>>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>>
> >>>> This issue can be reproduced by:
> >>>>    insmod locktorture.ko
> >>>>    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> >>>>    rmmod locktorture
> >>>>
> >>>> or:
> >>>>    insmod locktorture.ko
> >>>>    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> >>>>    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> >>>>
> >>>> The parameter 'bind_readers' also has the same problem. Free the memory
> >>>> when removing module or setting the parameter.
> >>>>
> >>>> Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
> >>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> >>>> ---
> >>>>   kernel/locking/locktorture.c | 9 +++++++++
> >>>>   1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> >>>> index ce0362f0a871..cad80c050502 100644
> >>>> --- a/kernel/locking/locktorture.c
> >>>> +++ b/kernel/locking/locktorture.c
> >>>> @@ -70,6 +70,9 @@ static int param_set_cpumask(const char *val, const struct kernel_param *kp)
> >>>>   	int ret;
> >>>>   	char *s;
> >>>> +	free_cpumask_var(*cm_bind);
> >>>> +	*cm_bind = NULL;
> >>> 这个NULL没必要吧
> > 
> > Assuming this translates to "This NULL is unnecessary", I have to
> > agree with Zhang Changzhong.  I would go further and argue that the
> > free_cpumask_var() is also unnecessary here.
> 
> Sorry, I used Chinese by mistake—I didn't notice this was a public thread.

Not a problem!  There is always translation software, not that I ever
will completely trust it.  ;-)

> With CONFIG_CPUMASK_OFFSTACK=y, the free_cpumask_var() here seems necessary,
> when param_set_cpumask() called multiple times, 'cm_bind' gets overwritten,
> and the free_cpumask_var() in lock_torture_cleanup() cannot free the old memory.

So the situation you are worried about is when the user mistakenly puts
multiple copies of one of the locktorture.bind_{readers,writers} module
parameters on the kernel boot command line or as a modprobe parameter?

If so, what do we really want to happen in that case?  Do we want the
last (say) locktorture.bind_readers value to win?  Or do we want to OR
together all such values?

							Thanx, Paul

> >> Setting global pointer to NULL after free may be more safe. ^-^
> > 
> > In lock_torture_cleanup(), you mean?  I would agree with that.
> > 
> >>>> +
> >>>>   	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
> >>>>   		s = "Out of memory";
> >>>>   		ret = -ENOMEM;
> >>>> @@ -1211,6 +1214,12 @@ static void lock_torture_cleanup(void)
> >>>>   			cxt.cur_ops->exit();
> >>>>   		cxt.init_called = false;
> >>>>   	}
> >>>> +
> >>>> +	free_cpumask_var(bind_readers);
> >>>> +	free_cpumask_var(bind_writers);
> >>>> +	bind_readers = NULL;
> >>>> +	bind_writers = NULL;
> >>> 同上
> > 
> > But here I agree with Wang Liang, as it helps people running debuggers
> > on the kernel.  Instead of a dangling pointer, they see a NULL pointer.
> > 
> > Except...  Is this NULLing really the right thing to do for
> > CONFIG_CPUMASK_OFFSTACK=n kernels?
> > 
> > 							Thanx, Paul
> > 
> >>>> +
> >>>>   	torture_cleanup_end();
> >>>>   }
> > 
> 

