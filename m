Return-Path: <linux-kernel+bounces-811234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550E9B52646
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34EA7A113D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775CB1F8724;
	Thu, 11 Sep 2025 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZI6HIP/s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BCB52F99
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757556242; cv=none; b=ZKsiEonFu8Gv56P7ZJnlgSt93FtfQzSunBrMg5wIOK1DrnjRDqXR4aAW/PHZtpAuXCyvcGQNNVRkWSLkcjnlIlivy41hJxhg/5es3o2zjmeY59sArC9EpSKmQMw3WT/iSezkuBJW9DFrBc8ZuH+vs//WSdas3cfTDP769qoYh5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757556242; c=relaxed/simple;
	bh=Z68IFztTwwT+G/boPAxo1CtTW3sBZB56ExZy97gj378=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgmp9k+5Jfyp7BYsEJIr1KQwMSFQBgJIs8l4mosGA10ufsmilQnhGFF1blbpyvaXwXN1cam6Y6Bqi+xSy1r3aPzOr7/1gXRNHOW07EbmdyvEhravqVYzIOab4bLrHMsbgM3MkXXVFpv+cG4JsUlCZz8zGCXudwQpbeyfcwoN7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZI6HIP/s; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757556241; x=1789092241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z68IFztTwwT+G/boPAxo1CtTW3sBZB56ExZy97gj378=;
  b=ZI6HIP/sjfDaPL+2sFrNtiHpAIdJHMngI56zBkGME4SNfB1/m2QayfDi
   ETDMPWxrAXLTg3wNmCs7pSo9Ux7Rn77behXwtzhzPuEZLLKvhJLrPpaHL
   yFwY9vp84/OL1y0cs4vcSjx3XJAn+hOPIefbOy7jjFemOdtGgFN/m5BfF
   Jsoy0Vp4LiSWFch79BnEvxwXQIiCD9veheG3KzlRsECwqThQJRsS+F2lO
   9Hk5OxqNa9B/AnIidRHkUDueoDAqdpKo60gp78VCNKokBWSauICaG9Uyr
   aqDAp5VK+DS3hysXOQzGN15V9KiAxoCa3CK8k1oplCL9ScwCvvL43d9PS
   g==;
X-CSE-ConnectionGUID: AsDTgwAzTkO/Z+OrRDgxWg==
X-CSE-MsgGUID: bppTMbsjSkKiudghDJszpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59816153"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="59816153"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 19:04:00 -0700
X-CSE-ConnectionGUID: IyFFpqfjSNm7t9qQflySDw==
X-CSE-MsgGUID: 8wwaSvr8R9uyI2WZjp7ClQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="173456112"
Received: from lkp-server01.sh.intel.com (HELO b9b8c76d6e3f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2025 19:03:54 -0700
Received: from kbuild by b9b8c76d6e3f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwWfA-00003j-0e;
	Thu, 11 Sep 2025 02:03:52 +0000
Date: Thu, 11 Sep 2025 10:03:51 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Lu <ziqianlu@bytedance.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4/4] sched/fair: Do not balance task to a throttled cfs_rq
Message-ID: <202509110908.a2P8HZ8A-lkp@intel.com>
References: <20250910095044.278-5-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910095044.278-5-ziqianlu@bytedance.com>

Hi Aaron,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5b726e9bf9544a349090879a513a5e00da486c14]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-Propagate-load-for-throttled-cfs_rq/20250910-175310
base:   5b726e9bf9544a349090879a513a5e00da486c14
patch link:    https://lore.kernel.org/r/20250910095044.278-5-ziqianlu%40bytedance.com
patch subject: [PATCH 4/4] sched/fair: Do not balance task to a throttled cfs_rq
config: i386-randconfig-012-20250911 (https://download.01.org/0day-ci/archive/20250911/202509110908.a2P8HZ8A-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509110908.a2P8HZ8A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509110908.a2P8HZ8A-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/fair.c:9382:41: error: no member named 'cfs_rq' in 'struct task_group'
    9382 |             throttled_hierarchy(task_group(p)->cfs_rq[env->dst_cpu]))
         |                                 ~~~~~~~~~~~~~  ^
   1 error generated.


vim +9382 kernel/sched/fair.c

  9356	
  9357	/*
  9358	 * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
  9359	 */
  9360	static
  9361	int can_migrate_task(struct task_struct *p, struct lb_env *env)
  9362	{
  9363		long degrades, hot;
  9364	
  9365		lockdep_assert_rq_held(env->src_rq);
  9366		if (p->sched_task_hot)
  9367			p->sched_task_hot = 0;
  9368	
  9369		/*
  9370		 * We do not migrate tasks that are:
  9371		 * 1) delayed dequeued unless we migrate load, or
  9372		 * 2) target cfs_rq is in throttled hierarchy, or
  9373		 * 3) cannot be migrated to this CPU due to cpus_ptr, or
  9374		 * 4) running (obviously), or
  9375		 * 5) are cache-hot on their current CPU, or
  9376		 * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
  9377		 */
  9378		if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
  9379			return 0;
  9380	
  9381		if (task_group(p) &&
> 9382		    throttled_hierarchy(task_group(p)->cfs_rq[env->dst_cpu]))
  9383			return 0;
  9384	
  9385		/*
  9386		 * We want to prioritize the migration of eligible tasks.
  9387		 * For ineligible tasks we soft-limit them and only allow
  9388		 * them to migrate when nr_balance_failed is non-zero to
  9389		 * avoid load-balancing trying very hard to balance the load.
  9390		 */
  9391		if (!env->sd->nr_balance_failed &&
  9392		    task_is_ineligible_on_dst_cpu(p, env->dst_cpu))
  9393			return 0;
  9394	
  9395		/* Disregard percpu kthreads; they are where they need to be. */
  9396		if (kthread_is_per_cpu(p))
  9397			return 0;
  9398	
  9399		if (task_is_blocked(p))
  9400			return 0;
  9401	
  9402		if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
  9403			int cpu;
  9404	
  9405			schedstat_inc(p->stats.nr_failed_migrations_affine);
  9406	
  9407			env->flags |= LBF_SOME_PINNED;
  9408	
  9409			/*
  9410			 * Remember if this task can be migrated to any other CPU in
  9411			 * our sched_group. We may want to revisit it if we couldn't
  9412			 * meet load balance goals by pulling other tasks on src_cpu.
  9413			 *
  9414			 * Avoid computing new_dst_cpu
  9415			 * - for NEWLY_IDLE
  9416			 * - if we have already computed one in current iteration
  9417			 * - if it's an active balance
  9418			 */
  9419			if (env->idle == CPU_NEWLY_IDLE ||
  9420			    env->flags & (LBF_DST_PINNED | LBF_ACTIVE_LB))
  9421				return 0;
  9422	
  9423			/* Prevent to re-select dst_cpu via env's CPUs: */
  9424			cpu = cpumask_first_and_and(env->dst_grpmask, env->cpus, p->cpus_ptr);
  9425	
  9426			if (cpu < nr_cpu_ids) {
  9427				env->flags |= LBF_DST_PINNED;
  9428				env->new_dst_cpu = cpu;
  9429			}
  9430	
  9431			return 0;
  9432		}
  9433	
  9434		/* Record that we found at least one task that could run on dst_cpu */
  9435		env->flags &= ~LBF_ALL_PINNED;
  9436	
  9437		if (task_on_cpu(env->src_rq, p) ||
  9438		    task_current_donor(env->src_rq, p)) {
  9439			schedstat_inc(p->stats.nr_failed_migrations_running);
  9440			return 0;
  9441		}
  9442	
  9443		/*
  9444		 * Aggressive migration if:
  9445		 * 1) active balance
  9446		 * 2) destination numa is preferred
  9447		 * 3) task is cache cold, or
  9448		 * 4) too many balance attempts have failed.
  9449		 */
  9450		if (env->flags & LBF_ACTIVE_LB)
  9451			return 1;
  9452	
  9453		degrades = migrate_degrades_locality(p, env);
  9454		if (!degrades)
  9455			hot = task_hot(p, env);
  9456		else
  9457			hot = degrades > 0;
  9458	
  9459		if (!hot || env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
  9460			if (hot)
  9461				p->sched_task_hot = 1;
  9462			return 1;
  9463		}
  9464	
  9465		schedstat_inc(p->stats.nr_failed_migrations_hot);
  9466		return 0;
  9467	}
  9468	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

