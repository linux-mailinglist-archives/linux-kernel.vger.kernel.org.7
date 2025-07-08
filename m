Return-Path: <linux-kernel+bounces-720915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E2AFC20D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BD44A61A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8B217659;
	Tue,  8 Jul 2025 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0ALjSVn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58002215766
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751952862; cv=none; b=NbjXcWQOAy82FMBeYaJAP3EDGVP00vyQPGKKTRwaWI6Kodj+P7zCD4t2bfZHENexlKRfyyIO6EeSAEE3pbF0G2a1n5pmwN1zc7ZCQTwpwC6V+2RhiVfN6QmOgE+7FfkwVR7RYEXyq1tA2c8zt/V1VOJ0TMVr2lzN5saTZ+19NHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751952862; c=relaxed/simple;
	bh=WOddxJzRLHemyfY4Lpdy70am+ukh+IWjHC2gqZQK4BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMaoS1PucCVSUYpwtI5kpBBVZqdY3s+y4N5aTzhxOlRGJk+0c574o/vbNawI38PjkmSUYV4urjMC69b5dbsccEo7rlOWXrN36CVqrwXLMMKynpoEynliXxU1wceNdmcZaKGXFSRsYUDRjm+Zd/ABQgt+IPG9YFrKV6EKehq7h/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0ALjSVn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751952859; x=1783488859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WOddxJzRLHemyfY4Lpdy70am+ukh+IWjHC2gqZQK4BM=;
  b=W0ALjSVnuivIP1p7+TYVJXiaZsQc0WGwqs9ugzHl5YnuaV3QkXDONbkO
   YHB15J4UPBWf2tdOymd2GeFtNUFrQ1mf4MHi+KzReNtijQwtBzuVPa5t9
   n9skZqtAnVDEf2P0lU902An3AD/bF8KbpC1SgqrXWZTfuBfI/y4wIpPk1
   O43tyGCJ27wqpR4TNf7Q5FK9iNXZPnmu0S4KBFilmI5KG8N1/ciQ+eHbg
   ucOFDmTuXSl+jy/nW3LLTyk9dV6vOwR6ERV3uIl0o3orHi0zGIsD6omqG
   3BYsOW5B2yjTbnNJ01pkTUvG9ywK/Wn4dPAM224KlOTfeddH+IAvZfunl
   A==;
X-CSE-ConnectionGUID: X5zs1vnaRkiTVLyO+zYz9g==
X-CSE-MsgGUID: H5WnG+M0QX6pS0ThXdAw8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79612393"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="79612393"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 22:34:18 -0700
X-CSE-ConnectionGUID: +F2wyMA0TdSTjyV2pxz9DQ==
X-CSE-MsgGUID: OxZalE9kSe2PQUFEJ1yXdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="159672264"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Jul 2025 22:34:16 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZ0y6-00011n-12;
	Tue, 08 Jul 2025 05:34:14 +0000
Date: Tue, 8 Jul 2025 13:33:38 +0800
From: kernel test robot <lkp@intel.com>
To: Pan Deng <pan.deng@intel.com>, peterz@infradead.org, mingo@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	tianyou.li@intel.com, tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com, pan.deng@intel.com
Subject: Re: [PATCH 3/4] sched/rt: Split root_domain->rto_count to
 per-NUMA-node counters
Message-ID: <202507081317.4IdE2euZ-lkp@intel.com>
References: <2c1e1dbacaddd881f3cca340ece1f9268029b620.1751852370.git.pan.deng@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c1e1dbacaddd881f3cca340ece1f9268029b620.1751852370.git.pan.deng@intel.com>

Hi Pan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.16-rc5]
[also build test WARNING on linus/master]
[cannot apply to tip/sched/core peterz-queue/sched/core tip/master tip/auto-latest next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pan-Deng/sched-rt-Optimize-cpupri_vec-layout-to-mitigate-cache-line-contention/20250707-131831
base:   v6.16-rc5
patch link:    https://lore.kernel.org/r/2c1e1dbacaddd881f3cca340ece1f9268029b620.1751852370.git.pan.deng%40intel.com
patch subject: [PATCH 3/4] sched/rt: Split root_domain->rto_count to per-NUMA-node counters
config: loongarch-randconfig-r112-20250708 (https://download.01.org/0day-ci/archive/20250708/202507081317.4IdE2euZ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250708/202507081317.4IdE2euZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507081317.4IdE2euZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/rt.c:1679:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/rt.c:1679:45: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1679:45: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/rt.c:1722:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/rt.c:1722:39: sparse:     expected struct task_struct *donor
   kernel/sched/rt.c:1722:39: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/rt.c:1742:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1742:64: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:1742:64: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2084:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2084:40: sparse:     expected struct task_struct *task
   kernel/sched/rt.c:2084:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2107:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2107:13: sparse:    struct task_struct *
   kernel/sched/rt.c:2107:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2453:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2453:54: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:2453:54: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2455:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/rt.c:2455:40: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2455:40: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/rt.c:2455:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/rt.c:2455:62: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2455:62: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/deadline.c:2717:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:2717:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2717:23: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:2727:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2727:13: sparse:    struct task_struct *
   kernel/sched/deadline.c:2727:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2833:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2833:25: sparse:    struct task_struct *
   kernel/sched/deadline.c:2833:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2357:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2357:42: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2357:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:2368:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2368:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2368:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1262:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1262:39: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1262:39: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1262:85: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1262:85: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:1262:85: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1362:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:1362:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1362:23: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:1671:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1671:31: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1671:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1671:70: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1671:70: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:1671:70: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1760:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:1760:39: sparse:     expected struct task_struct *donor
   kernel/sched/deadline.c:1760:39: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:2578:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/deadline.c:2578:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/deadline.c:2578:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/deadline.c:2242:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/deadline.c:2242:14: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:2242:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2243:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/deadline.c:2243:15: sparse:     expected struct task_struct *donor
   kernel/sched/deadline.c:2243:15: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2318:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:2318:43: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2318:43: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:2878:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2878:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2878:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2880:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:2880:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2880:23: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:2882:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2882:44: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2882:44: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:3071:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:3071:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:3071:23: sparse:    struct task_struct *
   kernel/sched/deadline.c:3120:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:206:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:2413:45: sparse: sparse: dereference of noderef expression
   kernel/sched/build_policy.c: note: in included file:
>> kernel/sched/sched.h:2627:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:2456:32: sparse: sparse: dereference of noderef expression
   kernel/sched/rt.c:2457:32: sparse: sparse: dereference of noderef expression
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2476:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2476:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2476:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2476:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2476:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2476:9: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:1296:6: sparse: sparse: context imbalance in 'sched_getaffinity' - different lock contexts for basic block
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:1767:15: sparse: sparse: dereference of noderef expression

vim +2627 kernel/sched/sched.h

04746ed80bcf31 Ingo Molnar               2024-04-07  2624  
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2625  static inline struct task_struct *get_push_task(struct rq *rq)
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2626  {
af0c8b2bf67b25 Peter Zijlstra            2024-10-09 @2627  	struct task_struct *p = rq->donor;
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2628  
5cb9eaa3d274f7 Peter Zijlstra            2020-11-17  2629  	lockdep_assert_rq_held(rq);
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2630  
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2631  	if (rq->push_busy)
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2632  		return NULL;
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2633  
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2634  	if (p->nr_cpus_allowed == 1)
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2635  		return NULL;
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2636  
e681dcbaa4b284 Sebastian Andrzej Siewior 2021-08-26  2637  	if (p->migration_disabled)
e681dcbaa4b284 Sebastian Andrzej Siewior 2021-08-26  2638  		return NULL;
e681dcbaa4b284 Sebastian Andrzej Siewior 2021-08-26  2639  
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2640  	rq->push_busy = true;
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2641  	return get_task_struct(p);
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2642  }
a7c81556ec4d34 Peter Zijlstra            2020-09-28  2643  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

