Return-Path: <linux-kernel+bounces-824403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029CB8918F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF871C8243C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA2C3081AC;
	Fri, 19 Sep 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNv+tFra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E92FE062
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278463; cv=none; b=I29Phc9mjz2OGPPUdPv/77xQV413J4/i1yzSZ41gBiJyAKUqR1pzl9kvG87FTJlxvKYL8DHjbCBFw4hRYh+YwYz6niGO7S3V4rUz+tmqTA3jCVtPoBLFpM0eXUGu1iMKo9htyrv4SUAs4G5b3QG7B5u2oiILiG/+19SyZGRnqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278463; c=relaxed/simple;
	bh=aIcRT3OtXrC+4TxS/I0CRStRPGYgrPTf68d1CIgCYBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB2bL6RtiEPiJwDDpFepBYWxBVv3xBIrSAnVcSokGbymffhc6f3AiN/zvpNr775CaRW3zzmnmLsmzgu810LoHRFA6RIUTS5c1ij4BeQPgaN8oeijoCNzhrsxG06LGn1nVn4jPnewg/ZPD3LfUpcq+j8JbapNszyMp0phWlxgAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNv+tFra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D901BC4CEF0;
	Fri, 19 Sep 2025 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758278462;
	bh=aIcRT3OtXrC+4TxS/I0CRStRPGYgrPTf68d1CIgCYBU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uNv+tFramn8OH682bGSmcobLDm0fQ05mF55DDp/DgMPTSj1ZQ3KSsT3VAe7RNp6m9
	 JherOjuL/E1WeZzs/GaSLqfyp+Z9moE2FHP80I/+dG7rBtaeL38gSo7j//43Di+xEk
	 XjF+vdzZ0eVs0os7iUF7YkZMnzPM14gL3Kyo/Wq720eQaNxU8IQt+uMy90uF88IJjQ
	 fCso+0/7rXkABlZOZR/TFyYkClhSMEZKHGKFgcwKrCuLWoJ3GbwYa7yUC7dM0n4fts
	 0c4KbddPoiMgAViPImcdrbUURkQGHIsfzyyb6pXL8fZs9vCdRU48NzHgl763YHFnek
	 CtikT/+f1iUaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3803FCE0EFF; Fri, 19 Sep 2025 03:41:02 -0700 (PDT)
Date: Fri, 19 Sep 2025 03:41:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: Wang Liang <wangliang74@huawei.com>, dave@stgolabs.net,
	josh@joshtriplett.org, frederic@kernel.org, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locktorture: Fix memory leak in param_set_cpumask()
Message-ID: <06f32215-ec2c-4d8f-8ccd-bc8dc250ec77@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250912015737.1209143-1-wangliang74@huawei.com>
 <6b433670-c79e-4439-9b9a-f10c548a727f@huawei.com>
 <9d51ece8-cb07-450b-a91a-095abcb8472a@huawei.com>
 <679d81f3-2610-44b9-bc9a-30ef0f70fa36@paulmck-laptop>
 <5eccd340-a4bb-4b46-897e-a673f9a5cb86@huawei.com>
 <9e0595a2-cbba-4635-b57c-a220f2d86fe2@paulmck-laptop>
 <d07dd312-295e-4703-895b-8ce438acea3c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d07dd312-295e-4703-895b-8ce438acea3c@huawei.com>

On Fri, Sep 19, 2025 at 06:22:40PM +0800, Zhang Changzhong wrote:
> 在 2025/9/18 23:20, Paul E. McKenney 写道:
> > On Thu, Sep 18, 2025 at 11:06:45PM +0800, Zhang Changzhong wrote:
> >> 在 2025/9/18 17:03, Paul E. McKenney 写道:
> >>> On Mon, Sep 15, 2025 at 10:13:33AM +0800, Wang Liang wrote:
> >>>> 在 2025/9/12 10:16, Zhang Changzhong 写道:
> >>>>> 在 2025/9/12 9:57, Wang Liang 写道:
> >>>>>> When setting the locktorture module parameter 'bind_writers', the variable
> >>>>>> 'cpumask_var_t bind_writers' is allocated in param_set_cpumask(). But it
> >>>>>> is not freed, when removing module or setting the parameter again.
> >>>>>>
> >>>>>> Below kmemleak trace is seen for this issue:
> >>>>>>
> >>>>>> unreferenced object 0xffff888100aabff8 (size 8):
> >>>>>>    comm "bash", pid 323, jiffies 4295059233
> >>>>>>    hex dump (first 8 bytes):
> >>>>>>      07 00 00 00 00 00 00 00                          ........
> >>>>>>    backtrace (crc ac50919):
> >>>>>>      __kmalloc_node_noprof+0x2e5/0x420
> >>>>>>      alloc_cpumask_var_node+0x1f/0x30
> >>>>>>      param_set_cpumask+0x26/0xb0 [locktorture]
> >>>>>>      param_attr_store+0x93/0x100
> >>>>>>      module_attr_store+0x1b/0x30
> >>>>>>      kernfs_fop_write_iter+0x114/0x1b0
> >>>>>>      vfs_write+0x300/0x410
> >>>>>>      ksys_write+0x60/0xd0
> >>>>>>      do_syscall_64+0xa4/0x260
> >>>>>>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>>>>
> >>>>>> This issue can be reproduced by:
> >>>>>>    insmod locktorture.ko
> >>>>>>    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> >>>>>>    rmmod locktorture
> >>>>>>
> >>>>>> or:
> >>>>>>    insmod locktorture.ko
> >>>>>>    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> >>>>>>    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> >>>>>>
> >>>>>> The parameter 'bind_readers' also has the same problem. Free the memory
> >>>>>> when removing module or setting the parameter.
> >>>>>>
> >>>>>> Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
> >>>>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> >>>>>> ---
> >>>>>>   kernel/locking/locktorture.c | 9 +++++++++
> >>>>>>   1 file changed, 9 insertions(+)
> >>>>>>
> >>>>>> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> >>>>>> index ce0362f0a871..cad80c050502 100644
> >>>>>> --- a/kernel/locking/locktorture.c
> >>>>>> +++ b/kernel/locking/locktorture.c
> >>>>>> @@ -70,6 +70,9 @@ static int param_set_cpumask(const char *val, const struct kernel_param *kp)
> >>>>>>   	int ret;
> >>>>>>   	char *s;
> >>>>>> +	free_cpumask_var(*cm_bind);
> >>>>>> +	*cm_bind = NULL;
> >>>>> 这个NULL没必要吧
> >>>
> >>> Assuming this translates to "This NULL is unnecessary", I have to
> >>> agree with Zhang Changzhong.  I would go further and argue that the
> >>> free_cpumask_var() is also unnecessary here.
> >>
> >> Sorry, I used Chinese by mistake—I didn't notice this was a public thread.
> > 
> > Not a problem!  There is always translation software, not that I ever
> > will completely trust it.  ;-)
> > 
> >> With CONFIG_CPUMASK_OFFSTACK=y, the free_cpumask_var() here seems necessary,
> >> when param_set_cpumask() called multiple times, 'cm_bind' gets overwritten,
> >> and the free_cpumask_var() in lock_torture_cleanup() cannot free the old memory.
> > 
> > So the situation you are worried about is when the user mistakenly puts
> > multiple copies of one of the locktorture.bind_{readers,writers} module
> > parameters on the kernel boot command line or as a modprobe parameter?
> > 
> 
> I didn't consider this situation. What I noticed is that bind_{readers,writers}
> are writable interface, and fuzz testing tools like syzkaller can easily write
> to /sys/module/locktorture/parameters/bind_{readers,writers} and trigger memory
> leak.
> 
> In this case, the patch fixes the memory leak issue, but the old parameters
> remain in effect instead of the newly written ones. Considering that writing
> to this interface after modprobe has no real effect, how about set the
> permissions to 0444?

That sounds like a most excellent approach.

> > If so, what do we really want to happen in that case?  Do we want the
> > last (say) locktorture.bind_readers value to win?  Or do we want to OR
> > together all such values?
> 
> In the case you mentioned, it seems more reasonable that the last
> locktorture.bind_readers wins, which is also the current behavior.

In which case, what has to happen to handle something like this?

	modprobe locktorture bind_readers=8
	rmmod locktorture
	modprobe locktorture bind_readers=5

Doesn't this require careful handling of the bind_readers variable in
lock_torture_cleanup(), for both possible settings of the CPUMASK_OFFSTACK
Kconfig option?

 							Thanx, Paul

> >>>> Setting global pointer to NULL after free may be more safe. ^-^
> >>>
> >>> In lock_torture_cleanup(), you mean?  I would agree with that.
> >>>
> >>>>>> +
> >>>>>>   	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
> >>>>>>   		s = "Out of memory";
> >>>>>>   		ret = -ENOMEM;
> >>>>>> @@ -1211,6 +1214,12 @@ static void lock_torture_cleanup(void)
> >>>>>>   			cxt.cur_ops->exit();
> >>>>>>   		cxt.init_called = false;
> >>>>>>   	}
> >>>>>> +
> >>>>>> +	free_cpumask_var(bind_readers);
> >>>>>> +	free_cpumask_var(bind_writers);
> >>>>>> +	bind_readers = NULL;
> >>>>>> +	bind_writers = NULL;
> >>>>> 同上
> >>>
> >>> But here I agree with Wang Liang, as it helps people running debuggers
> >>> on the kernel.  Instead of a dangling pointer, they see a NULL pointer.
> >>>
> >>> Except...  Is this NULLing really the right thing to do for
> >>> CONFIG_CPUMASK_OFFSTACK=n kernels?
> >>>
> >>> 							Thanx, Paul
> >>>
> >>>>>> +
> >>>>>>   	torture_cleanup_end();
> >>>>>>   }
> >>>
> >>
> > 
> 

