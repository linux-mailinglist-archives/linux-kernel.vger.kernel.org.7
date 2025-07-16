Return-Path: <linux-kernel+bounces-733839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8FB079C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0238D1892DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DBF2F5334;
	Wed, 16 Jul 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6XAzpA2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1112F0E55
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679311; cv=none; b=aCD9z1obWTVVp/vziMkcsO8canNyJNd13NMhuwKJQlQrllOZWdqFAye9n8ykXd/iEfBIjwGawOA5sdxSmmRCS7pCvK4wNbE6D40VP2MPXi093CCSHAsnFtFHQyqdUY4rAR24HqB+1F+drmByDLgLbz47+Sf959JYNnNRfrrIAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679311; c=relaxed/simple;
	bh=20qaSuyOgTlBhKSi0cnC/40gJbOni0NUAYdhj6JNxhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCPhvIEtvPd2HiFqZX3mEX1EnW3xqQn0XDtm2/SEFfaCndQQkJeVb13Yog2y5+n5rXDnQ+GzQnPNT+XkmlfZ4LXjB077WirMd6fX2zp3tMtXPe9+0cod3sRljVYDOvK/PmHQYRzlcI37OGHZhfMwMzzUJAPM6tM7Q9DFdZ5YdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6XAzpA2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752679308; x=1784215308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=20qaSuyOgTlBhKSi0cnC/40gJbOni0NUAYdhj6JNxhk=;
  b=l6XAzpA2f9agjnauN3gDQcUshWx46D2wbPQ0gsrgIHxle+H+ZLHvtq7c
   ostiQ9B6za5z86KXMBhmbwP+uTLPUE087X9yA+itrriouQggzE7y5PbR/
   Vb5s+mEHInFRL6FjrGVHuFPiSQfzVU0Xg3e/ThlaYsYsp6BW4ApsB/E75
   0qandhCfkjJP+Z0DB0EuK7cdRFGIuTZ3pHbq0YinAHCiZCAeJ6fzO7a4r
   HE9fpcLIYG7DbhNQ8x6apDsuazGJIywI0VN1ZILb3cCdD7AkBVfPjW8Gl
   uJtx4KcH7EpE0okc5ZT5s+2Xbt6ZB3i7CeSPbFT9AxlxLtnkauzGYWX8J
   A==;
X-CSE-ConnectionGUID: 8b2lwVGjTjKu1P+bFL1LPQ==
X-CSE-MsgGUID: giojhbbYS9WY9NtRYuJvDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65191927"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="65191927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 08:21:47 -0700
X-CSE-ConnectionGUID: 5/Ik6+u7TH+Jfk01xDfmWQ==
X-CSE-MsgGUID: ZS1Z7weSRUOYoDCERTJVCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="156936058"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Jul 2025 08:21:43 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc3wy-000CXT-0u;
	Wed, 16 Jul 2025 15:21:40 +0000
Date: Wed, 16 Jul 2025 23:20:55 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <202507162238.qiw7kyu0-lkp@intel.com>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071658.267-4-ziqianlu@bytedance.com>

Hi Aaron,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on next-20250716]
[cannot apply to linus/master v6.16-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250715-152307
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250715071658.267-4-ziqianlu%40bytedance.com
patch subject: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
config: xtensa-randconfig-r121-20250716 (https://download.01.org/0day-ci/archive/20250716/202507162238.qiw7kyu0-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250716/202507162238.qiw7kyu0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507162238.qiw7kyu0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/core.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/thread_info.h, ...):
   arch/xtensa/include/asm/processor.h:105:2: sparse: sparse: Unsupported xtensa ABI
   arch/xtensa/include/asm/processor.h:135:2: sparse: sparse: Unsupported Xtensa ABI
   kernel/sched/core.c: note: in included file:
>> kernel/sched/sched.h:741:44: sparse: sparse: dubious one-bit signed bitfield
   kernel/sched/sched.h:742:55: sparse: sparse: dubious one-bit signed bitfield
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2429:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2429:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2429:9: sparse:    struct task_struct *
   kernel/sched/core.c:2131:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:2131:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:2131:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2452:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2452:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2452:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2452:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2452:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2452:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2429:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2429:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2429:9: sparse:    struct task_struct *
--
   kernel/sched/fair.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, ...):
   arch/xtensa/include/asm/processor.h:105:2: sparse: sparse: Unsupported xtensa ABI
   arch/xtensa/include/asm/processor.h:135:2: sparse: sparse: Unsupported Xtensa ABI
   kernel/sched/fair.c: note: in included file:
>> kernel/sched/sched.h:741:44: sparse: sparse: dubious one-bit signed bitfield
   kernel/sched/sched.h:742:55: sparse: sparse: dubious one-bit signed bitfield
   kernel/sched/fair.c:6073:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6073:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:6073:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10625:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:10625:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:10625:22: sparse:    struct task_struct *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2452:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2452:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2452:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
--
   kernel/sched/build_policy.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, ...):
   arch/xtensa/include/asm/processor.h:105:2: sparse: sparse: Unsupported xtensa ABI
   arch/xtensa/include/asm/processor.h:135:2: sparse: sparse: Unsupported Xtensa ABI
   kernel/sched/build_policy.c: note: in included file:
>> kernel/sched/sched.h:741:44: sparse: sparse: dubious one-bit signed bitfield
   kernel/sched/sched.h:742:55: sparse: sparse: dubious one-bit signed bitfield
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:2289:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2289:25: sparse:    struct task_struct *
   kernel/sched/rt.c:2289:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:1994:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:1994:13: sparse:    struct task_struct *
   kernel/sched/rt.c:1994:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/deadline.c:2675:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2675:13: sparse:    struct task_struct *
   kernel/sched/deadline.c:2675:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2781:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2781:25: sparse:    struct task_struct *
   kernel/sched/deadline.c:2781:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:3024:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:3024:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:3024:23: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:206:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2241:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2241:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2241:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2241:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2241:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2429:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2429:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2429:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2252:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2252:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2429:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2429:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2429:9: sparse:    struct task_struct *
--
   kernel/sched/build_utility.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h, ...):
   arch/xtensa/include/asm/processor.h:105:2: sparse: sparse: Unsupported xtensa ABI
   arch/xtensa/include/asm/processor.h:135:2: sparse: sparse: Unsupported Xtensa ABI
   kernel/sched/build_utility.c: note: in included file:
>> kernel/sched/sched.h:741:44: sparse: sparse: dubious one-bit signed bitfield
   kernel/sched/sched.h:742:55: sparse: sparse: dubious one-bit signed bitfield
   kernel/sched/sched.h:2241:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2241:25: sparse:    struct task_struct *

vim +741 kernel/sched/sched.h

   709	
   710	#ifdef CONFIG_FAIR_GROUP_SCHED
   711		struct rq		*rq;	/* CPU runqueue to which this cfs_rq is attached */
   712	
   713		/*
   714		 * leaf cfs_rqs are those that hold tasks (lowest schedulable entity in
   715		 * a hierarchy). Non-leaf lrqs hold other higher schedulable entities
   716		 * (like users, containers etc.)
   717		 *
   718		 * leaf_cfs_rq_list ties together list of leaf cfs_rq's in a CPU.
   719		 * This list is used during load balance.
   720		 */
   721		int			on_list;
   722		struct list_head	leaf_cfs_rq_list;
   723		struct task_group	*tg;	/* group that "owns" this runqueue */
   724	
   725		/* Locally cached copy of our task_group's idle value */
   726		int			idle;
   727	
   728	#ifdef CONFIG_CFS_BANDWIDTH
   729		int			runtime_enabled;
   730		s64			runtime_remaining;
   731	
   732		u64			throttled_pelt_idle;
   733	#ifndef CONFIG_64BIT
   734		u64                     throttled_pelt_idle_copy;
   735	#endif
   736		u64			throttled_clock;
   737		u64			throttled_clock_pelt;
   738		u64			throttled_clock_pelt_time;
   739		u64			throttled_clock_self;
   740		u64			throttled_clock_self_time;
 > 741		int			throttled:1;
   742		int			pelt_clock_throttled:1;
   743		int			throttle_count;
   744		struct list_head	throttled_list;
   745		struct list_head	throttled_csd_list;
   746		struct list_head        throttled_limbo_list;
   747	#endif /* CONFIG_CFS_BANDWIDTH */
   748	#endif /* CONFIG_FAIR_GROUP_SCHED */
   749	};
   750	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

