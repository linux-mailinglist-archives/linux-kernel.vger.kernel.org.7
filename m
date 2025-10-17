Return-Path: <linux-kernel+bounces-857379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91814BE6A31
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946F94FFDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6212D97AF;
	Fri, 17 Oct 2025 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fO+cB6MN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6F223DD1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682114; cv=none; b=iY+PkYxid92RW00RS0uZ2uPqB0cz7TacjEmjK79lRs10RTx4W7zh8VSzaGSepeBgpjWFILNk6NlxNn9bRD1SoGS6Rpzp7PspkGKiKnGwS0S/MXFYzT5TZg+n3pLm4xkB+A2lF5i4uXKQOX12Bud02+Clnmboma8xoVs/eg1t8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682114; c=relaxed/simple;
	bh=Crh6PSnzKrPdIlWltmFVXOY8Z9b0XtaxQ56lpajh7ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOn1kZ4TpeH+V6FIgsisU6zSrbcbm1OKcp+FDey3UvAUfxS+fgbjnjLy6dU8/lZAohkovXKzUJWmBtz99LaNzF/OwyHrGPqP+K14xCOqX7fPAqj+gfF6xp2Uf0SaJ3BpCW7AzL6WgnwJUpmmEbrCTEtKMY0HNjfOlO94SEaDlG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fO+cB6MN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760682112; x=1792218112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Crh6PSnzKrPdIlWltmFVXOY8Z9b0XtaxQ56lpajh7ck=;
  b=fO+cB6MNyqPwgkvmMtO4boBrWYrV6y31eQwb0UNqnJWS2W0gJzBuyGGy
   RZafoNYGyh1b00KI2/f3d1xW8pNHZqZTwwpd41sNZFzi3ySiuYmj9OKqs
   z5TMJA9fSm8kk9wGZVmV0ALbNQcQZIEuSDl9/75ZbLN7SHjkMHIkvfnYp
   OwfMPyGTnHJU8sO3OVVXk0xBiQ4XuuEnMJKkPO95g7Ke8R7OPTtST6lpd
   DEekiEswfiAu1MWSi1V/L0aoDhQNe4Ik6Qa6cXJeJ4jtHbaYWFBQ9mBEC
   aoHQF5nhAKpfqzxjym8r4qRAG2C16uG0evZggQU4aumsbvOCxceXRgG41
   A==;
X-CSE-ConnectionGUID: TEeu7QJSToaDEWBptwoXXQ==
X-CSE-MsgGUID: HAZf1ss5QoKFuboLp1YVuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66532932"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66532932"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:21:52 -0700
X-CSE-ConnectionGUID: /l1ULNEYSm+pyaZoXUfjMA==
X-CSE-MsgGUID: PKREFLeeSNum1Tl5noJqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="186909673"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 16 Oct 2025 23:21:50 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9dpk-0005bj-38;
	Fri, 17 Oct 2025 06:21:25 +0000
Date: Fri, 17 Oct 2025 14:19:20 +0800
From: kernel test robot <lkp@intel.com>
To: Xin Zhao <jackzxcui1989@163.com>, tj@kernel.org, jiangshanlai@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: Re: [PATCH] workqueue: Support RT workqueue
Message-ID: <202510171328.eE4qdf84-lkp@intel.com>
References: <20251016102345.2200815-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016102345.2200815-1-jackzxcui1989@163.com>

Hi Xin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.17]
[cannot apply to tj-wq/for-next v6.18-rc1 linus/master next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Zhao/workqueue-Support-RT-workqueue/20251016-182514
base:   v6.17
patch link:    https://lore.kernel.org/r/20251016102345.2200815-1-jackzxcui1989%40163.com
patch subject: [PATCH] workqueue: Support RT workqueue
config: csky-randconfig-002-20251017 (https://download.01.org/0day-ci/archive/20251017/202510171328.eE4qdf84-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171328.eE4qdf84-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171328.eE4qdf84-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/workqueue.c: In function 'workqueue_init_early':
>> kernel/workqueue.c:7791:4: warning: iteration 2 invokes undefined behavior [-Waggressive-loop-optimizations]
    7791 |    init_irq_work(bh_pool_irq_work(pool), irq_work_fns[i]);
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/workqueue.c:552:2: note: within this loop
     552 |  for ((pool) = &per_cpu(bh_worker_pools, cpu)[0];  \
         |  ^~~
   kernel/workqueue.c:7788:3: note: in expansion of macro 'for_each_bh_worker_pool'
    7788 |   for_each_bh_worker_pool(pool, cpu) {
         |   ^~~~~~~~~~~~~~~~~~~~~~~


vim +7791 kernel/workqueue.c

2fcdb1b44491e08 Tejun Heo           2024-02-04  7722  
3347fa0928210d9 Tejun Heo           2016-09-16  7723  /**
3347fa0928210d9 Tejun Heo           2016-09-16  7724   * workqueue_init_early - early init for workqueue subsystem
3347fa0928210d9 Tejun Heo           2016-09-16  7725   *
2930155b2e27232 Tejun Heo           2023-08-07  7726   * This is the first step of three-staged workqueue subsystem initialization and
2930155b2e27232 Tejun Heo           2023-08-07  7727   * invoked as soon as the bare basics - memory allocation, cpumasks and idr are
2930155b2e27232 Tejun Heo           2023-08-07  7728   * up. It sets up all the data structures and system workqueues and allows early
2930155b2e27232 Tejun Heo           2023-08-07  7729   * boot code to create workqueues and queue/cancel work items. Actual work item
2930155b2e27232 Tejun Heo           2023-08-07  7730   * execution starts only after kthreads can be created and scheduled right
2930155b2e27232 Tejun Heo           2023-08-07  7731   * before early initcalls.
3347fa0928210d9 Tejun Heo           2016-09-16  7732   */
2333e829952fb43 Yu Chen             2020-02-23  7733  void __init workqueue_init_early(void)
^1da177e4c3f415 Linus Torvalds      2005-04-16  7734  {
84193c07105c62d Tejun Heo           2023-08-07  7735  	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
7456d72db76b9c5 Xin Zhao            2025-10-16  7736  	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL, RTPRI_LEVEL };
2f34d7337d98f3e Tejun Heo           2024-02-14  7737  	void (*irq_work_fns[2])(struct irq_work *) = { bh_pool_kick_normal,
2f34d7337d98f3e Tejun Heo           2024-02-14  7738  						       bh_pool_kick_highpri };
7a4e344c5675eef Tejun Heo           2013-03-12  7739  	int i, cpu;
c34056a3fdde777 Tejun Heo           2010-06-29  7740  
10cdb15759540f0 Lai Jiangshan       2020-06-01  7741  	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
e904e6c2668bba7 Tejun Heo           2013-03-12  7742  
8d84baf76045f5b Lai Jiangshan       2024-07-11  7743  	BUG_ON(!alloc_cpumask_var(&wq_online_cpumask, GFP_KERNEL));
b05a79280b346eb Frederic Weisbecker 2015-04-27  7744  	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
fe28f631fa941fb Waiman Long         2023-10-25  7745  	BUG_ON(!alloc_cpumask_var(&wq_requested_unbound_cpumask, GFP_KERNEL));
fe28f631fa941fb Waiman Long         2023-10-25  7746  	BUG_ON(!zalloc_cpumask_var(&wq_isolated_cpumask, GFP_KERNEL));
b05a79280b346eb Frederic Weisbecker 2015-04-27  7747  
8d84baf76045f5b Lai Jiangshan       2024-07-11  7748  	cpumask_copy(wq_online_cpumask, cpu_online_mask);
4a6c5607d4502cc Tejun Heo           2023-11-21  7749  	cpumask_copy(wq_unbound_cpumask, cpu_possible_mask);
4a6c5607d4502cc Tejun Heo           2023-11-21  7750  	restrict_unbound_cpumask("HK_TYPE_WQ", housekeeping_cpumask(HK_TYPE_WQ));
4a6c5607d4502cc Tejun Heo           2023-11-21  7751  	restrict_unbound_cpumask("HK_TYPE_DOMAIN", housekeeping_cpumask(HK_TYPE_DOMAIN));
ace3c5499e61ef7 tiozhang            2023-06-29  7752  	if (!cpumask_empty(&wq_cmdline_cpumask))
4a6c5607d4502cc Tejun Heo           2023-11-21  7753  		restrict_unbound_cpumask("workqueue.unbound_cpus", &wq_cmdline_cpumask);
ace3c5499e61ef7 tiozhang            2023-06-29  7754  
fe28f631fa941fb Waiman Long         2023-10-25  7755  	cpumask_copy(wq_requested_unbound_cpumask, wq_unbound_cpumask);
261dce3d64021e7 Chuyi Zhou          2025-06-17  7756  	cpumask_andnot(wq_isolated_cpumask, cpu_possible_mask,
261dce3d64021e7 Chuyi Zhou          2025-06-17  7757  						housekeeping_cpumask(HK_TYPE_DOMAIN));
e904e6c2668bba7 Tejun Heo           2013-03-12  7758  	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
e904e6c2668bba7 Tejun Heo           2013-03-12  7759  
b2b1f9338400de0 Lai Jiangshan       2024-07-11  7760  	unbound_wq_update_pwq_attrs_buf = alloc_workqueue_attrs();
b2b1f9338400de0 Lai Jiangshan       2024-07-11  7761  	BUG_ON(!unbound_wq_update_pwq_attrs_buf);
2930155b2e27232 Tejun Heo           2023-08-07  7762  
7bd20b6b87183db Marcelo Tosatti     2024-01-19  7763  	/*
7bd20b6b87183db Marcelo Tosatti     2024-01-19  7764  	 * If nohz_full is enabled, set power efficient workqueue as unbound.
7bd20b6b87183db Marcelo Tosatti     2024-01-19  7765  	 * This allows workqueue items to be moved to HK CPUs.
7bd20b6b87183db Marcelo Tosatti     2024-01-19  7766  	 */
7bd20b6b87183db Marcelo Tosatti     2024-01-19  7767  	if (housekeeping_enabled(HK_TYPE_TICK))
7bd20b6b87183db Marcelo Tosatti     2024-01-19  7768  		wq_power_efficient = true;
7bd20b6b87183db Marcelo Tosatti     2024-01-19  7769  
84193c07105c62d Tejun Heo           2023-08-07  7770  	/* initialize WQ_AFFN_SYSTEM pods */
84193c07105c62d Tejun Heo           2023-08-07  7771  	pt->pod_cpus = kcalloc(1, sizeof(pt->pod_cpus[0]), GFP_KERNEL);
84193c07105c62d Tejun Heo           2023-08-07  7772  	pt->pod_node = kcalloc(1, sizeof(pt->pod_node[0]), GFP_KERNEL);
84193c07105c62d Tejun Heo           2023-08-07  7773  	pt->cpu_pod = kcalloc(nr_cpu_ids, sizeof(pt->cpu_pod[0]), GFP_KERNEL);
84193c07105c62d Tejun Heo           2023-08-07  7774  	BUG_ON(!pt->pod_cpus || !pt->pod_node || !pt->cpu_pod);
84193c07105c62d Tejun Heo           2023-08-07  7775  
84193c07105c62d Tejun Heo           2023-08-07  7776  	BUG_ON(!zalloc_cpumask_var_node(&pt->pod_cpus[0], GFP_KERNEL, NUMA_NO_NODE));
84193c07105c62d Tejun Heo           2023-08-07  7777  
84193c07105c62d Tejun Heo           2023-08-07  7778  	pt->nr_pods = 1;
84193c07105c62d Tejun Heo           2023-08-07  7779  	cpumask_copy(pt->pod_cpus[0], cpu_possible_mask);
84193c07105c62d Tejun Heo           2023-08-07  7780  	pt->pod_node[0] = NUMA_NO_NODE;
84193c07105c62d Tejun Heo           2023-08-07  7781  	pt->cpu_pod[0] = 0;
84193c07105c62d Tejun Heo           2023-08-07  7782  
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7783  	/* initialize BH and CPU pools */
29c91e9912bed70 Tejun Heo           2013-03-12  7784  	for_each_possible_cpu(cpu) {
4ce62e9e30cacc2 Tejun Heo           2012-07-13  7785  		struct worker_pool *pool;
8b03ae3cde59af9 Tejun Heo           2010-06-29  7786  
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7787  		i = 0;
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7788  		for_each_bh_worker_pool(pool, cpu) {
2f34d7337d98f3e Tejun Heo           2024-02-14  7789  			init_cpu_worker_pool(pool, cpu, std_nice[i]);
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7790  			pool->flags |= POOL_BH;
2f34d7337d98f3e Tejun Heo           2024-02-14 @7791  			init_irq_work(bh_pool_irq_work(pool), irq_work_fns[i]);
2f34d7337d98f3e Tejun Heo           2024-02-14  7792  			i++;
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7793  		}
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7794  
7a4e344c5675eef Tejun Heo           2013-03-12  7795  		i = 0;
2fcdb1b44491e08 Tejun Heo           2024-02-04  7796  		for_each_cpu_worker_pool(pool, cpu)
2fcdb1b44491e08 Tejun Heo           2024-02-04  7797  			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
8b03ae3cde59af9 Tejun Heo           2010-06-29  7798  	}
8b03ae3cde59af9 Tejun Heo           2010-06-29  7799  
8a2b75384444488 Tejun Heo           2013-09-05  7800  	/* create default unbound and ordered wq attrs */
29c91e9912bed70 Tejun Heo           2013-03-12  7801  	for (i = 0; i < NR_STD_WORKER_POOLS; i++) {
29c91e9912bed70 Tejun Heo           2013-03-12  7802  		struct workqueue_attrs *attrs;
29c91e9912bed70 Tejun Heo           2013-03-12  7803  
be69d00d9769575 Thomas Gleixner     2019-06-26  7804  		BUG_ON(!(attrs = alloc_workqueue_attrs()));
29c91e9912bed70 Tejun Heo           2013-03-12  7805  		attrs->nice = std_nice[i];
29c91e9912bed70 Tejun Heo           2013-03-12  7806  		unbound_std_wq_attrs[i] = attrs;
8a2b75384444488 Tejun Heo           2013-09-05  7807  
8a2b75384444488 Tejun Heo           2013-09-05  7808  		/*
8a2b75384444488 Tejun Heo           2013-09-05  7809  		 * An ordered wq should have only one pwq as ordering is
8a2b75384444488 Tejun Heo           2013-09-05  7810  		 * guaranteed by max_active which is enforced by pwqs.
8a2b75384444488 Tejun Heo           2013-09-05  7811  		 */
be69d00d9769575 Thomas Gleixner     2019-06-26  7812  		BUG_ON(!(attrs = alloc_workqueue_attrs()));
8a2b75384444488 Tejun Heo           2013-09-05  7813  		attrs->nice = std_nice[i];
af73f5c9febe509 Tejun Heo           2023-08-07  7814  		attrs->ordered = true;
8a2b75384444488 Tejun Heo           2013-09-05  7815  		ordered_wq_attrs[i] = attrs;
29c91e9912bed70 Tejun Heo           2013-03-12  7816  	}
29c91e9912bed70 Tejun Heo           2013-03-12  7817  
d320c03830b17af Tejun Heo           2010-06-29  7818  	system_wq = alloc_workqueue("events", 0, 0);
128ea9f6ccfb696 Marco Crivellari    2025-06-14  7819  	system_percpu_wq = alloc_workqueue("events", 0, 0);
1aabe902ca3638d Joonsoo Kim         2012-08-15  7820  	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
7456d72db76b9c5 Xin Zhao            2025-10-16  7821  	system_rt_wq = alloc_workqueue("events_rt", WQ_RT, 0);
d320c03830b17af Tejun Heo           2010-06-29  7822  	system_long_wq = alloc_workqueue("events_long", 0, 0);
128ea9f6ccfb696 Marco Crivellari    2025-06-14  7823  	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
128ea9f6ccfb696 Marco Crivellari    2025-06-14  7824  	system_dfl_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
24d51add7438f96 Tejun Heo           2011-02-21  7825  	system_freezable_wq = alloc_workqueue("events_freezable",
24d51add7438f96 Tejun Heo           2011-02-21  7826  					      WQ_FREEZABLE, 0);
0668106ca3865ba Viresh Kumar        2013-04-24  7827  	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
0668106ca3865ba Viresh Kumar        2013-04-24  7828  					      WQ_POWER_EFFICIENT, 0);
8318d6a6362f590 Audra Mitchell      2024-01-25  7829  	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
0668106ca3865ba Viresh Kumar        2013-04-24  7830  					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
0668106ca3865ba Viresh Kumar        2013-04-24  7831  					      0);
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7832  	system_bh_wq = alloc_workqueue("events_bh", WQ_BH, 0);
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7833  	system_bh_highpri_wq = alloc_workqueue("events_bh_highpri",
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7834  					       WQ_BH | WQ_HIGHPRI, 0);
7456d72db76b9c5 Xin Zhao            2025-10-16  7835  	BUG_ON(!system_wq || !system_percpu_wq || !system_highpri_wq || !system_rt_wq ||
7456d72db76b9c5 Xin Zhao            2025-10-16  7836  	       !system_long_wq || !system_unbound_wq || !system_freezable_wq || !system_dfl_wq ||
0668106ca3865ba Viresh Kumar        2013-04-24  7837  	       !system_power_efficient_wq ||
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7838  	       !system_freezable_power_efficient_wq ||
4cb1ef64609f9b0 Tejun Heo           2024-02-04  7839  	       !system_bh_wq || !system_bh_highpri_wq);
3347fa0928210d9 Tejun Heo           2016-09-16  7840  }
3347fa0928210d9 Tejun Heo           2016-09-16  7841  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

