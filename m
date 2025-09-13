Return-Path: <linux-kernel+bounces-815376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2AAB56384
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75182480124
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664922BD016;
	Sat, 13 Sep 2025 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmlapBZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF6283FD3
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757801147; cv=none; b=MfIVRFSrwe0LNO3DhSQADxpxEYqkv5ktDZ3lKQpZsRgTqw4/oRVSmW9SJ2Meizyi9M6xTU9HSg0a1HeQ5yJEXBI6SJ1K+0GOlGFmnAkOs/gy8gToNxWp9WYCkkcdLD7I949A1xv9wOLTZG0flOnTWamW+XoS3pKinSYpLIfbbRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757801147; c=relaxed/simple;
	bh=FfCHvHzysQGnHS4bnbkUBTtqUl8KdzZGH9zK4Iu003c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+/T8gt5W4pNoI0ZubHCAKjPozKS9ETdeE7Ko+Fm34XJOH4JF5WjyyofojcPaVhZP2trOM745nxDzBSujjcKeVK0i48glEeFJ8UhfjNBqAv13LlB87cP8DHRnt+hgj/R547PoVRgcr9K6AD1esETo1zli/szWdVLwQJVImFVAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmlapBZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9B8C4CEEB;
	Sat, 13 Sep 2025 22:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757801147;
	bh=FfCHvHzysQGnHS4bnbkUBTtqUl8KdzZGH9zK4Iu003c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JmlapBZopfYusHwOq/86gKZTHVhRKuf+DYzFbuVocgz6dpgH1DigP+kz6INSLdbUs
	 pSlwF/WMY/Pf0jiFIRmR/TR1kCHrEtMa1TmrpaERoAQWbDQ7jQKkq1y0MQXdm5+eDK
	 kK/MZ43SdE57SyJYnXvNdzn7vH4KtGrea4eRxTRyE9IzuC5+JH6Tgy2h8bRNATyaD6
	 x0ZHvETz8HKeiwdAARdgAzhs0Hlu2aXaowNcIlrSOIdzLuVyD8lyDwzQT3k3WtxS3c
	 +QNZiNGOiSCtBQlBlLwMhE/Qp4TTfuUwxUwJjpdQ1kx8NTxueVwlGHxz25rTkCxXua
	 jDi17A9Tzc41w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 06999CE0DDA; Sat, 13 Sep 2025 15:05:47 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:05:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	pengdonglin <dolinux.peng@gmail.com>, linux-kernel@vger.kernel.org,
	herbert@gondor.apana.org.au
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in
 spin_lock critical sections
Message-ID: <7cdb6f45-de42-4139-a050-b318a69ad86d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
 <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
 <20250912213531.7-YeRBeD@linutronix.de>
 <20250913080018.7032-1-hdanton@sina.com>
 <10adb9b7-ea19-407b-818e-79061a067e13@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10adb9b7-ea19-407b-818e-79061a067e13@redhat.com>

On Sat, Sep 13, 2025 at 01:23:03PM -0400, Waiman Long wrote:
> On 9/13/25 4:00 AM, Hillf Danton wrote:
> > On Fri, 12 Sep 2025 20:33:31 -0400 Waiman Long wrote:
> > > On 9/12/25 5:35 PM, Sebastian Andrzej Siewior wrote:
> > > > On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
> > > > > On 9/12/25 2:50 AM, pengdonglin wrote:
> > > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > > > 
> > > > > > When CONFIG_PREEMPT_RT is disabled, spin_lock*()
> > > > > > operations implicitly
> > > > > > disable preemption, which provides RCU read-side protection. When
> > > > > > CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> > > > > > manage RCU read-side critical sections.
> > > > > I have some doubt about your claim that disabling preemption
> > > > > provides RCU
> > > > > read-side protection. It is true for some flavors but
> > > > > probably not all. I do
> > > > > know that disabling interrupt will provide RCU read-side
> > > > > protection. So for
> > > > > spin_lock_irq*() calls, that is valid. I am not sure about
> > > > > spin_lock_bh(),
> > > > > maybe it applies there too. we need some RCU people to confirm.
> > > > The claim is valid since Paul merged the three flavours we had. Before
> > > > that preempt_disable() (and disabling irqs) would match
> > > > rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() were
> > > > different in terms of grace period and clean up.
> > > > So _now_ we could remove it if it makes things easier.
> > > 
> > > Thanks for the clarification.
> > > 
> > > In this case, I think the patch description should mention the
> > > commit that unify the 3 RCU flavors to make sure that this patch
> > > won't be accidentally backport'ed to an older kernel without the
> > > necessary prerequisite commit(s).
> > 
> > This change also affects the dereference helpers.
> > 
> > #define rcu_dereference_check(p, c) \
> >     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> >                 (c) || rcu_read_lock_held(), __rcu)
> > 
> Right, this macro will need to be updated as well to avoid false positive if
> we decide that preempt_disabled region is a valid rcu_read_lock critical
> section.

I suggest that you instead use the new rcu_dereference_all_check()
that Herbert Xu (added on CC) has put together here:

https://lore.kernel.org/all/aLlflTV_SDwMB7mq@gondor.apana.org.au/

This way, people wanting rcu_read_lock() and nothing else can continue
using rcu_dereference_check() and you can use rcu_dereference_all_check()
that takes rcu_read_lock() along all any other types of RCU readers.

							Thanx, Paul

