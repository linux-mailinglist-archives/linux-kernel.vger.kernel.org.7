Return-Path: <linux-kernel+bounces-776705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151FB2D0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615853B1C16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68B41509AB;
	Wed, 20 Aug 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyNgBDS8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263241459F6;
	Wed, 20 Aug 2025 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649772; cv=none; b=AV3dwsdVtEu7SAGxO/LkNfJJ4vmOZ+VN2tv8mGzPvqnbO74C6XPDg2Gu2skAuszmtWbnKcPIoTYckxzn93g20F6Pk4LKVDDHLBYTv/QlAeDaaZimaR6FN4njvw2WxnXvykJqf498wOZwQMwRY4IwUwGjftk9lHcVUqm+RVgxQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649772; c=relaxed/simple;
	bh=PLtDGYFtJnx5Sq1lETlSSnL/9eJgGx2YJdLrku0PhFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIp+3sR776F3K9TgkZYf6uTGAD2NBeUFfrWb+wXhQxWJae5xk2vbLz2UaS3gBZZgupfguhmJ6POvtCxXWWUTB9yUKPb+5j7Vxd7vKX8s8F7pbUUC1ZTomu3wateL4K8dIEH0vLwYkOXMqkYL+eAqHmEsjOARZN4O0Gb7GY4ekRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyNgBDS8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755649771; x=1787185771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PLtDGYFtJnx5Sq1lETlSSnL/9eJgGx2YJdLrku0PhFg=;
  b=OyNgBDS8P0ijaZibi3c3miiIQwXX+d6fI3NFP9hridGYKlSSDFIVEzbk
   YULsLDNTrt87Nlx3KUlS74wKr7/m6kgzaP2w5hEcBeep1Apsba8gIVPXi
   hJbmNq93rhsPBeaQ5xn8vrcthPAjcAkGfuex9wDvwgQ9M7Q/PiGlGeKEP
   vZIFJfdxzkV2aOjnDAgrpD3zplN60Q0mi6kkUzQlhqeODgLVi2Kkyf7lS
   k05asGiIJM99XCG1efMddOhYTnqEuLlV6UHCShc04MnO436tjH1EbmU/D
   tbq1a4At5vzvXeHMWFKdtwjVfy5G3Zvx8JC+CKjIr4AhSRprQqEi4W9ep
   g==;
X-CSE-ConnectionGUID: 49xhGLeYRHGS5nUs31haxg==
X-CSE-MsgGUID: QKQWCqCASE+QnqP7vW7jsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57975170"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57975170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 17:29:30 -0700
X-CSE-ConnectionGUID: cxQhXokRQ2Kf9pJpVMgDBA==
X-CSE-MsgGUID: 21ncgDAYTVO77CuQcDC6Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167944569"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 19 Aug 2025 17:29:23 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoWhT-000HsJ-1h;
	Wed, 20 Aug 2025 00:29:15 +0000
Date: Wed, 20 Aug 2025 08:27:33 +0800
From: kernel test robot <lkp@intel.com>
To: Tio Zhang <tiozhang@didiglobal.com>, akpm@linux-foundation.org,
	wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, corbet@lwn.net,
	bsingharora@gmail.com, yang.yang29@zte.com.cn
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yong12@zte.com.cn,
	tiozhang@didiglobal.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net
Subject: Re: [PATCH] delayacct/sched: add SOFTIRQ delay
Message-ID: <202508200857.4KUgmreB-lkp@intel.com>
References: <20250819092739.GA31177@didi-ThinkCentre-M930t-N000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819092739.GA31177@didi-ThinkCentre-M930t-N000>

Hi Tio,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.17-rc2 next-20250819]
[cannot apply to tip/sched/core peterz-queue/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tio-Zhang/delayacct-sched-add-SOFTIRQ-delay/20250819-173756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250819092739.GA31177%40didi-ThinkCentre-M930t-N000
patch subject: [PATCH] delayacct/sched: add SOFTIRQ delay
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250820/202508200857.4KUgmreB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250820/202508200857.4KUgmreB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508200857.4KUgmreB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:93:
   kernel/sched/psi.c: In function 'psi_account_irqtime':
>> kernel/sched/psi.c:1024:15: error: too few arguments to function 'irq_time_read'
    1024 |         irq = irq_time_read(cpu);
         |               ^~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:52:
   kernel/sched/sched.h:3159:19: note: declared here
    3159 | static inline u64 irq_time_read(int cpu, u64 *total_soft)
         |                   ^~~~~~~~~~~~~


vim +/irq_time_read +1024 kernel/sched/psi.c

eb414681d5a07d Johannes Weiner    2018-10-26  1004  
52b1364ba0b105 Chengming Zhou     2022-08-26  1005  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
ddae0ca2a8fe12 John Stultz        2024-06-18  1006  void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
52b1364ba0b105 Chengming Zhou     2022-08-26  1007  {
ddae0ca2a8fe12 John Stultz        2024-06-18  1008  	int cpu = task_cpu(curr);
52b1364ba0b105 Chengming Zhou     2022-08-26  1009  	struct psi_group_cpu *groupc;
ddae0ca2a8fe12 John Stultz        2024-06-18  1010  	s64 delta;
3840cbe24cf060 Johannes Weiner    2024-10-03  1011  	u64 irq;
570c8efd5eb79c Peter Zijlstra     2025-05-23  1012  	u64 now;
52b1364ba0b105 Chengming Zhou     2022-08-26  1013  
a6fd16148fdd7e Yafang Shao        2025-01-03  1014  	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
0c2924079f5a83 Haifeng Xu         2023-09-26  1015  		return;
0c2924079f5a83 Haifeng Xu         2023-09-26  1016  
ddae0ca2a8fe12 John Stultz        2024-06-18  1017  	if (!curr->pid)
ddae0ca2a8fe12 John Stultz        2024-06-18  1018  		return;
ddae0ca2a8fe12 John Stultz        2024-06-18  1019  
ddae0ca2a8fe12 John Stultz        2024-06-18  1020  	lockdep_assert_rq_held(rq);
570c8efd5eb79c Peter Zijlstra     2025-05-23  1021  	if (prev && task_psi_group(prev) == task_psi_group(curr))
52b1364ba0b105 Chengming Zhou     2022-08-26  1022  		return;
52b1364ba0b105 Chengming Zhou     2022-08-26  1023  
ddae0ca2a8fe12 John Stultz        2024-06-18 @1024  	irq = irq_time_read(cpu);
ddae0ca2a8fe12 John Stultz        2024-06-18  1025  	delta = (s64)(irq - rq->psi_irq_time);
ddae0ca2a8fe12 John Stultz        2024-06-18  1026  	if (delta < 0)
ddae0ca2a8fe12 John Stultz        2024-06-18  1027  		return;
ddae0ca2a8fe12 John Stultz        2024-06-18  1028  	rq->psi_irq_time = irq;
52b1364ba0b105 Chengming Zhou     2022-08-26  1029  
570c8efd5eb79c Peter Zijlstra     2025-05-23  1030  	psi_write_begin(cpu);
570c8efd5eb79c Peter Zijlstra     2025-05-23  1031  	now = cpu_clock(cpu);
3840cbe24cf060 Johannes Weiner    2024-10-03  1032  
570c8efd5eb79c Peter Zijlstra     2025-05-23  1033  	for_each_group(group, task_psi_group(curr)) {
34f26a15611afb Chengming Zhou     2022-09-07  1034  		if (!group->enabled)
34f26a15611afb Chengming Zhou     2022-09-07  1035  			continue;
34f26a15611afb Chengming Zhou     2022-09-07  1036  
52b1364ba0b105 Chengming Zhou     2022-08-26  1037  		groupc = per_cpu_ptr(group->pcpu, cpu);
52b1364ba0b105 Chengming Zhou     2022-08-26  1038  
52b1364ba0b105 Chengming Zhou     2022-08-26  1039  		record_times(groupc, now);
52b1364ba0b105 Chengming Zhou     2022-08-26  1040  		groupc->times[PSI_IRQ_FULL] += delta;
52b1364ba0b105 Chengming Zhou     2022-08-26  1041  
65457b74aa9437 Domenico Cerasuolo 2023-03-30  1042  		if (group->rtpoll_states & (1 << PSI_IRQ_FULL))
65457b74aa9437 Domenico Cerasuolo 2023-03-30  1043  			psi_schedule_rtpoll_work(group, 1, false);
570c8efd5eb79c Peter Zijlstra     2025-05-23  1044  	}
570c8efd5eb79c Peter Zijlstra     2025-05-23  1045  	psi_write_end(cpu);
52b1364ba0b105 Chengming Zhou     2022-08-26  1046  }
fd3db705f7496c Ingo Molnar        2025-05-28  1047  #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
52b1364ba0b105 Chengming Zhou     2022-08-26  1048  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

