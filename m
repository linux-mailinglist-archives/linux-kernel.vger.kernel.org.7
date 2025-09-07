Return-Path: <linux-kernel+bounces-804770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7DB47CCE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD8F1899279
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B027AC5C;
	Sun,  7 Sep 2025 18:21:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423251E231E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757269306; cv=none; b=F1SiGJs6zrPDDBV53D9bxYoTJQJEqvkIM1ti8gOfWQpQdFnA8vIuQBjC6JZuxGjH6EJuuSW5C2BLlagdAKG3lLfOCoW9VIWQHGwIOvNhX7tTp1u34LRMhA9J3nJZGrQXxUGmSPbmx9eR6StD7+svrVVMZb6sib00YWMcQpuMheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757269306; c=relaxed/simple;
	bh=fR7cRxOqIZlMaRwTRmqGqDvlJHzzUWtyLUhOORvZI5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AMJXuv/CixxOe4JQBXKDR8WO2sAp2iAM+3OY8uzrpANa6bL6GBUfqTi8ZHxHRl+ZbH7BU4XQNUONVtixEJWxhIGjOieePPLv70LviapqhPD8WW4XDo6XsA4HLwKqEHQl4mMu5MCmzBHRQd8H8D+t7SNrpQvbcAl7uJKHvgFkqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0824912FC;
	Sun,  7 Sep 2025 11:21:34 -0700 (PDT)
Received: from [10.57.91.39] (unknown [10.57.91.39])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D19F3F66E;
	Sun,  7 Sep 2025 11:21:41 -0700 (PDT)
Message-ID: <e5277634-1d06-456c-bb57-2c0a9e245b4a@arm.com>
Date: Sun, 7 Sep 2025 19:21:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle
 balance fails
Content-Language: en-GB
To: Chris Mason <clm@fb.com>, peterz@infradead.org,
 vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
 Aishwarya Rambhadran <Aishwarya.Rambhadran@arm.com>
References: <20250626144017.1510594-2-clm@fb.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250626144017.1510594-2-clm@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2025 15:39, Chris Mason wrote:
> schbench (https://github.com/masoncl/schbench.git) is showing a
> regression from previous production kernels that bisected down to:
> 
> sched/fair: Remove sysctl_sched_migration_cost condition (c5b0a7eefc)
> 
> The schbench command line was:
> 
> schbench -L -m 4 -M auto -t 256 -n 0 -r 0 -s 0
> 
> This creates 4 message threads pinned to CPUs 0-3, and 256x4 worker
> threads spread across the rest of the CPUs.  Neither the worker threads
> or the message threads do any work, they just wake each other up and go
> back to sleep as soon as possible.
> 
> The end result is the first 4 CPUs are pegged waking up those 1024
> workers, and the rest of the CPUs are constantly banging in and out of
> idle.  If I take a v6.9 Linus kernel and revert that one commit,
> performance goes from 3.4M RPS to 5.4M RPS.
> 
> schedstat shows there are ~100x  more new idle balance operations, and
> profiling shows the worker threads are spending ~20% of their CPU time
> on new idle balance.  schedstats also shows that almost all of these new
> idle balance attemps are failing to find busy groups.
> 
> The fix used here is to crank up the cost of the newidle balance whenever it
> fails.  Since we don't want sd->max_newidle_lb_cost to grow out of
> control, this also changes update_newidle_cost() to use
> sysctl_sched_migration_cost as the upper limit on max_newidle_lb_cost.
> 
> Signed-off-by: Chris Mason <clm@fb.com>

Hi,

I'm seeing a ~25% regression in requests per second for an nginx workload in 
6.17-rc4 compared with 6.16, when the number of simulated clients (threads) is 
high (1000). Bisection led me to this patch. The workload is running on an 
AmpereOne (arm64) system with 192 CPUs. FWIW, I don't see the regression on an 
AWS Graviton3 system.

I'm also seeing a 10% regression on the same system for a MySQL workload; but I 
haven't yet bisected that one - I'll report back if that turns out to be due to 
this too.

I saw that there was a regression raised against this patch by kernel test robot 
for unixbench.throughput back in July, but it didn't look like it got resolved.

I can repro this easily so happy to try out any candidate fixes.


Here is the bisect log:

# good: [038d61fd642278bab63ee8ef722c50d10ab01e8f] Linux 6.16
git bisect good 038d61fd642278bab63ee8ef722c50d10ab01e8f
# status: waiting for bad commit, 1 good commit known
# bad: [8f5ae30d69d7543eee0d70083daf4de8fe15d585] Linux 6.17-rc1
git bisect bad 8f5ae30d69d7543eee0d70083daf4de8fe15d585
# bad: [8be4d31cb8aaeea27bde4b7ddb26e28a89062ebf] Merge tag 'net-next-6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad 8be4d31cb8aaeea27bde4b7ddb26e28a89062ebf
# good: [115e74a29b530d121891238e9551c4bcdf7b04b5] Merge tag 'soc-dt-6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 115e74a29b530d121891238e9551c4bcdf7b04b5
# good: [49f02e6877d1bec848048dc6366859c30bbc0a04] Octeontx2-af: Debugfs support for firmware data
git bisect good 49f02e6877d1bec848048dc6366859c30bbc0a04
# good: [14bed9bc81bae64db98349319f367bfc7dab0afd] Merge tag 'x86_sev_for_v6.17_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 14bed9bc81bae64db98349319f367bfc7dab0afd
# good: [c6dc26df6b4883de63cb237b4070feba92b01a87] Merge tag 'nf-next-25-07-25' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
git bisect good c6dc26df6b4883de63cb237b4070feba92b01a87
# bad: [3bb38c52719baa7f9cdbf200016ed481b4498290] Merge tag 'm68k-for-v6.17-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
git bisect bad 3bb38c52719baa7f9cdbf200016ed481b4498290
# bad: [bcb48dd3b344592cc33732de640b99264c073df1] Merge tag 'perf-core-2025-07-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad bcb48dd3b344592cc33732de640b99264c073df1
# good: [d403a3689af5c3a3e3ac6e282958d0eaa69ca47f] sched/fair: Move max_cfs_quota_period decl and default_cfs_period() def from fair.c to sched.h
git bisect good d403a3689af5c3a3e3ac6e282958d0eaa69ca47f
# bad: [9fdb12c88e9ba75e2d831fb397dd27f03a534968] tools/sched: Add root_domains_dump.py which dumps root domains info
git bisect bad 9fdb12c88e9ba75e2d831fb397dd27f03a534968
# bad: [570c8efd5eb79c3725ba439ce105ed1bedc5acd9] sched/psi: Optimize psi_group_change() cpu_clock() usage
git bisect bad 570c8efd5eb79c3725ba439ce105ed1bedc5acd9
# good: [11867144ff81ab98f4b11c99716c3e8b714b8755] rust: sync: Mark PollCondVar::drop() inline
git bisect good 11867144ff81ab98f4b11c99716c3e8b714b8755
# good: [7e611710acf966df1e14bcf4e067385e38e549a1] rust: task: Add Rust version of might_sleep()
git bisect good 7e611710acf966df1e14bcf4e067385e38e549a1
# bad: [155213a2aed42c85361bf4f5c817f5cb68951c3b] sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails
git bisect bad 155213a2aed42c85361bf4f5c817f5cb68951c3b
# good: [d398a68e8bcf430e231cccfbaa27cb25a7a6f224] Merge tag 'rust-sched.2025.06.24' of git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux into sched/core
git bisect good d398a68e8bcf430e231cccfbaa27cb25a7a6f224
# first bad commit: [155213a2aed42c85361bf4f5c817f5cb68951c3b] sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails


Thanks,
Ryan



> ---
>  kernel/sched/fair.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a14da5396fb2..042ab0863ccc0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12174,8 +12174,14 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
>  		/*
>  		 * Track max cost of a domain to make sure to not delay the
>  		 * next wakeup on the CPU.
> +		 *
> +		 * sched_balance_newidle() bumps the cost whenever newidle
> +		 * balance fails, and we don't want things to grow out of
> +		 * control.  Use the sysctl_sched_migration_cost as the upper
> +		 * limit, plus a litle extra to avoid off by ones.
>  		 */
> -		sd->max_newidle_lb_cost = cost;
> +		sd->max_newidle_lb_cost =
> +			min(cost, sysctl_sched_migration_cost + 200);
>  		sd->last_decay_max_lb_cost = jiffies;
>  	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
>  		/*
> @@ -12867,10 +12873,17 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>  
>  			t1 = sched_clock_cpu(this_cpu);
>  			domain_cost = t1 - t0;
> -			update_newidle_cost(sd, domain_cost);
> -
>  			curr_cost += domain_cost;
>  			t0 = t1;
> +
> +			/*
> +			 * Failing newidle means it is not effective;
> +			 * bump the cost so we end up doing less of it.
> +			 */
> +			if (!pulled_task)
> +				domain_cost = (3 * sd->max_newidle_lb_cost) / 2;
> +
> +			update_newidle_cost(sd, domain_cost);
>  		}
>  
>  		/*


