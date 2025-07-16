Return-Path: <linux-kernel+bounces-733446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4C0B074C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FB31C25F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD872F2C70;
	Wed, 16 Jul 2025 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fa4gKJ2h"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309B2F4331;
	Wed, 16 Jul 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665141; cv=none; b=uxub0/uE6/hbnZGMO8dZ0nNgufUtjWRLu623PlHuhc4JwN88HaXmtwERtYkoq9WR9ErzrPNRSt8W26GONBNmguKthxpJbtp+XPZkJWU9aFhXyaJKgscrg43clWJHFID8O3w7XZG6sS9LvC7URyd6JH3zgGqjiSyuYAB31vxPN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665141; c=relaxed/simple;
	bh=EYFfKSlO9xERXs/iTfLLgx0rGMidUjSz1xXZscwEqA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZHfx/DqI41miiGSrqEev225wIJT9x26hYKPLvT+aCJNkCUmdWLbi4w6yZLxXsT5/xFTC0dJ2ILTfA/VHaBZtRhhOk4l6vPU1Cj+/8UV2G0I/BSxk8sfveTBPKzGym814y5PaM/kcXzxPRh6ENLQ21SMr+iyjb/F3lv6A8Ar4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fa4gKJ2h; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gkZqUKwDbsV/2dL8YJLKH5dlMnuryzNCRhd3vysEFm4=; b=fa4gKJ2hF5gpoA01tjLnk2eIHt
	RCL6bj/GuUx/+nYFbbLaPZycyPZ8G8kCeblqfgeMGlfW+beH51C+GLZNQFROLHgy0jr6XnG8CZJdZ
	zZ2n++m9thcaLObnDTqNLl88/PJY7vkrEGeDrJYApnrpapbHH12EKZUwlKaSYlOEYQQhPA1N1o2jt
	24v3tLUYeZ4jOLSNCZTryT61CM/8VsmKV07STQ4T+ZPQHFKLB0oL9c2edZ6zMkwxthSaIFxT5RQQT
	Ee3NL9MUylQhHrE5dIZmoxjKvXwYmTvSnxWMJZgZvJIdvke0S2p8Ilk3h0K59FIxBlR/FysuVPV2y
	uR03+9Dw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc0GU-0000000A5iS-2lKi;
	Wed, 16 Jul 2025 11:25:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5CA3C300186; Wed, 16 Jul 2025 13:25:33 +0200 (CEST)
Date: Wed, 16 Jul 2025 13:25:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>, Chris Mason <clm@fb.com>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	aubrey.li@linux.intel.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle
 balance fails
Message-ID: <20250716112533.GS1613200@noisy.programming.kicks-ass.net>
References: <202507150846.538fc133-lkp@intel.com>
 <10abe013-98d6-4080-ac43-0f1e02aa41f9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10abe013-98d6-4080-ac43-0f1e02aa41f9@intel.com>

On Tue, Jul 15, 2025 at 06:08:43PM +0800, Chen, Yu C wrote:
> On 7/15/2025 3:08 PM, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 22.9% regression of unixbench.throughput on:
> > 
> > 
> > commit: ac34cb39e8aea9915ec2f4e08c979eb2ed1d7561 ("[PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")
> > url: https://github.com/intel-lab-lkp/linux/commits/Chris-Mason/sched-fair-bump-sd-max_newidle_lb_cost-when-newidle-balance-fails/20250626-224805
> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 5bc34be478d09c4d16009e665e020ad0fcd0deea
> > patch link: https://lore.kernel.org/all/20250626144017.1510594-2-clm@fb.com/
> > patch subject: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails
> > 
> > testcase: unixbench
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > parameters:
> > 
> > 	runtime: 300s
> > 	nr_task: 100%
> > 	test: shell1
> > 	cpufreq_governor: performance
> > 
> > 
> ...
> 
> > 
> > commit:
> >    5bc34be478 ("sched/core: Reorganize cgroup bandwidth control interface file writes")
> >    ac34cb39e8 ("sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")
> > 
> > 5bc34be478d09c4d ac34cb39e8aea9915ec2f4e08c9
> > ---------------- ---------------------------
> >           %stddev     %change         %stddev
> >               \          |                \
> ...
> 
> >       40.37           +16.9       57.24        mpstat.cpu.all.idle%
> 
> This commit inhibits the newidle balance. 

When not successful. So when newidle balance is not succeeding to pull
tasks, it is backing off and doing less of it.

> It seems that some workloads
> do not like newlyidle balance, like schbench, which is short duration
> task. While other workloads want the newidle balance to pull at its best
> effort, like unixbench shell test case.
> Just wonder if we can check the sched domain's average utilization to
> decide how hard we should trigger the newly idle balance, or can we check
> the overutilized flag to decide whether we should launch the
> new idle balance, something I was thinking of:

Looking at the actual util signal might be interesting, but as Chris
already noted, overutilized isn't the right thing to look at. Simply
taking rq->cfs.avg.util_avg might be more useful. Very high util and
failure to pull might indicate new-idle just isn't very important /
effective. While low util and failure might mean we should try harder.

Other things to look at:

 - if the sysctl_sched_migration_cost limit isn't artificially limiting
   actual scanning costs. Eg. very large domains might perhaps have
   costs that are genuinely larger than that somewhat random number.

 - if despite the apparent failure to pull, we do already have something
   to run (eg. wakeups).

 - if the 3/2 backoff is perhaps too aggressive vs the 1% per second
   decay.

