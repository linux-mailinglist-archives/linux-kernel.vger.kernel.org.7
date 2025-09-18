Return-Path: <linux-kernel+bounces-822378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2DB83ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625B91C06FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE1A2FB995;
	Thu, 18 Sep 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7/h0Cyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3C2F9D82
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186216; cv=none; b=i1vl1zUJ/zpRerjJVAmZvn3WovKSyz+2SP2Atu9SCqfJPm5gksU/83a3x+VsHWIxRrxoayjIvCKEl/E6whEi/ATbGoOWCB+BhkPGQ6THg0s04wZUqI0RIKU5AvVBC1moRRHY79E9uS6jFyf1kb2STCmVxA24TKvziyW6DFirvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186216; c=relaxed/simple;
	bh=dH794V60EHBMXjQIvpn2qHpklmIbvedci1K/cTrITJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggT0IYj5X/zxZxPPBZWmKbWNfBZYvQCyIxI+qR3M/U6qG7oUrKsZoF807uSEaSmzxiMxtIIQanibTypQR47E5f2OJl4Q4LPGYMfbgL7pVNLmK48kBFftO1c8HJOcOxKfLuLxa6LY//egXDGOE6DMCD/Uofel89al9nwVmJEHybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7/h0Cyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECACC4CEE7;
	Thu, 18 Sep 2025 09:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758186215;
	bh=dH794V60EHBMXjQIvpn2qHpklmIbvedci1K/cTrITJs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=a7/h0CyyPGpSdFmzbxAjSRFRLIilR3pglyTtsAnTxAiklHS0pOFSNdeNKCO3Jtl79
	 vxBQjkRE1hzOlzDc9UbntgmEb78CdBCMYDKwjNssXnMmacowByEapQC7jB7TVy1zGj
	 G8QLX3CObeN2mfs+93vQnl9OvToRB9P2ZPgyyxHJ1qCEQ/z2ufSpDUCe7572z0uAT/
	 jS9WDH+WWQlyzNY6FVdZfcetppqtzcTh3WflbhfpTFr8oLAJV8nYm7V6lGMa82iCGU
	 GhoX4n+QcdjtYX/0ZusNPHyxi2i9YYKXcX9F6+u5d/UZKZ8I4gF/ihZB1AC07GeyJb
	 Ka6lfhTLnpTaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 454ACCE0B1E; Thu, 18 Sep 2025 02:03:35 -0700 (PDT)
Date: Thu, 18 Sep 2025 02:03:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: Zhang Changzhong <zhangchangzhong@huawei.com>, dave@stgolabs.net,
	josh@joshtriplett.org, frederic@kernel.org, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locktorture: Fix memory leak in param_set_cpumask()
Message-ID: <679d81f3-2610-44b9-bc9a-30ef0f70fa36@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250912015737.1209143-1-wangliang74@huawei.com>
 <6b433670-c79e-4439-9b9a-f10c548a727f@huawei.com>
 <9d51ece8-cb07-450b-a91a-095abcb8472a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d51ece8-cb07-450b-a91a-095abcb8472a@huawei.com>

On Mon, Sep 15, 2025 at 10:13:33AM +0800, Wang Liang wrote:
> 
> 在 2025/9/12 10:16, Zhang Changzhong 写道:
> > 
> > 在 2025/9/12 9:57, Wang Liang 写道:
> > > When setting the locktorture module parameter 'bind_writers', the variable
> > > 'cpumask_var_t bind_writers' is allocated in param_set_cpumask(). But it
> > > is not freed, when removing module or setting the parameter again.
> > > 
> > > Below kmemleak trace is seen for this issue:
> > > 
> > > unreferenced object 0xffff888100aabff8 (size 8):
> > >    comm "bash", pid 323, jiffies 4295059233
> > >    hex dump (first 8 bytes):
> > >      07 00 00 00 00 00 00 00                          ........
> > >    backtrace (crc ac50919):
> > >      __kmalloc_node_noprof+0x2e5/0x420
> > >      alloc_cpumask_var_node+0x1f/0x30
> > >      param_set_cpumask+0x26/0xb0 [locktorture]
> > >      param_attr_store+0x93/0x100
> > >      module_attr_store+0x1b/0x30
> > >      kernfs_fop_write_iter+0x114/0x1b0
> > >      vfs_write+0x300/0x410
> > >      ksys_write+0x60/0xd0
> > >      do_syscall_64+0xa4/0x260
> > >      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > This issue can be reproduced by:
> > >    insmod locktorture.ko
> > >    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> > >    rmmod locktorture
> > > 
> > > or:
> > >    insmod locktorture.ko
> > >    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> > >    echo 0-2 > /sys/module/locktorture/parameters/bind_writers
> > > 
> > > The parameter 'bind_readers' also has the same problem. Free the memory
> > > when removing module or setting the parameter.
> > > 
> > > Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
> > > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > > ---
> > >   kernel/locking/locktorture.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > > index ce0362f0a871..cad80c050502 100644
> > > --- a/kernel/locking/locktorture.c
> > > +++ b/kernel/locking/locktorture.c
> > > @@ -70,6 +70,9 @@ static int param_set_cpumask(const char *val, const struct kernel_param *kp)
> > >   	int ret;
> > >   	char *s;
> > > +	free_cpumask_var(*cm_bind);
> > > +	*cm_bind = NULL;
> > 这个NULL没必要吧

Assuming this translates to "This NULL is unnecessary", I have to
agree with Zhang Changzhong.  I would go further and argue that the
free_cpumask_var() is also unnecessary here.

> Setting global pointer to NULL after free may be more safe. ^-^

In lock_torture_cleanup(), you mean?  I would agree with that.

> > > +
> > >   	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
> > >   		s = "Out of memory";
> > >   		ret = -ENOMEM;
> > > @@ -1211,6 +1214,12 @@ static void lock_torture_cleanup(void)
> > >   			cxt.cur_ops->exit();
> > >   		cxt.init_called = false;
> > >   	}
> > > +
> > > +	free_cpumask_var(bind_readers);
> > > +	free_cpumask_var(bind_writers);
> > > +	bind_readers = NULL;
> > > +	bind_writers = NULL;
> > 同上

But here I agree with Wang Liang, as it helps people running debuggers
on the kernel.  Instead of a dangling pointer, they see a NULL pointer.

Except...  Is this NULLing really the right thing to do for
CONFIG_CPUMASK_OFFSTACK=n kernels?

							Thanx, Paul

> > > +
> > >   	torture_cleanup_end();
> > >   }

