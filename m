Return-Path: <linux-kernel+bounces-827482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4EB91E15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEDE2A11D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326F2DFF04;
	Mon, 22 Sep 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTbQGOej"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3403B265620
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554402; cv=none; b=E5qQt9YzIka1DSSWsjwIuqEzzu+7WaEbJjmev+tVd85ed1dO1WhwsHa4U85UdpgJHjDluAtjVViOgc8lwHGhEAXTrMfcigfGfrVmjTdWZUaOgmpADhiEaQuIjxJCSGQBCciu6zSTlFZDx6YuE2+fCojGhjmb/KoEIhKTXl9Kfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554402; c=relaxed/simple;
	bh=x6bCrgcuX+yzuVokwFZKm27374szsnasuZhO/lwgS0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPQG7CFLnFmXEMGSEmTWtCYnFXY2+QDfxNL7TwHAV4qF72if3bQaCHkutcVCRmKWlpuVFErO4jAcguSTmyzKrtiUAK6oDh2ESQMIndP8rwX6N+8924rjK8yRkUPQDYgXugfbM4S/zNwrRj3sza/5AA7JEVXM2fMs6yCUU19rFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTbQGOej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B99C4CEF0;
	Mon, 22 Sep 2025 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758554401;
	bh=x6bCrgcuX+yzuVokwFZKm27374szsnasuZhO/lwgS0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTbQGOej4Nc5D7CpTVLKxOhuukNYPUYqF4gF2mRJgT/bwBN6lVxoXCR7fkLym8BWt
	 mvZhofE5poYJ8BksD+zHHL9eZWZFr2vx9Gvynp4DGZ/kR4Tq+n5nh/gvT0nk+BNMNt
	 ms3n4+aiBoxK3X8pS8pJKg3rSlu+gE/MhapM6ZJyFZt2RPTrx551NqNcwZkeEkNvgL
	 xKu4Tc4AZN96oh5SwzIy4CWzj4XzbXGdCc3FjjwoPGIPADoi7kKtEJAEM09qOXRmeH
	 PZzgrnMFYydK6xyHAiN2tZLdH+ogaoVI9R1yfwfI9CsvXkISriwNn+VxtGwU3fpt6L
	 uu3fL5dKYHXGQ==
Date: Mon, 22 Sep 2025 17:19:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 19/33] sched/isolation: Remove HK_TYPE_TICK test from
 cpu_is_isolated()
Message-ID: <aNFpHgRnf-mV-4d8@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-20-frederic@kernel.org>
 <dc75acab-36c1-4340-9cf2-35a35361c32b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc75acab-36c1-4340-9cf2-35a35361c32b@redhat.com>

Le Tue, Sep 02, 2025 at 10:28:58AM -0400, Waiman Long a écrit :
> 
> On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
> > It doesn't make sense to use nohz_full without also isolating the
> > related CPUs from the domain topology, either through the use of
> > isolcpus= or cpuset isolated partitions.
> > 
> > And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
> > 
> > This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
> > alias) is always a superset of HK_TYPE_DOMAIN.
> 
> That may not be true. Users can still set "isolcpus=" and "nohz_full=" with
> disjoint set of CPUs whether cpuset is used for additional isolated CPUs or
> not.

There can be domain isolated CPU that are not nohz_full indeed. But OTOH nohz_full
CPUs that are not domain isolated don't make much sense. I know such settings
exist but it's usually a half working misconfiguration. I wish I had
forbidden that since the early days but this was from times when we didn't know
about all the potential usages.

Thanks.



> 
> Cheers,
> Longman
> 
> > 
> > Therefore if a CPU is not HK_TYPE_KERNEL_NOISE, it can't be
> > HK_TYPE_DOMAIN either. Testing the latter is then enough.
> > 
> > Simplify cpu_is_isolated() accordingly.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   include/linux/sched/isolation.h | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index c02923ed4cbe..8d6d26d3fdf5 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -82,8 +82,7 @@ static inline void housekeeping_init(void) { }
> >   static inline bool cpu_is_isolated(int cpu)
> >   {
> > -	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> > -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
> > +	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
> >   }
> >   #endif /* _LINUX_SCHED_ISOLATION_H */
> 

-- 
Frederic Weisbecker
SUSE Labs

