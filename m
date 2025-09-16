Return-Path: <linux-kernel+bounces-819412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B9B5A053
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1E51898110
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A0A2C11F0;
	Tue, 16 Sep 2025 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjWb4HC7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F928D8D0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046421; cv=none; b=sw0ALbRmWZQsFPc9DmeyROgNsG5ep6xGvfWEnruVMa9dmy8WnxLXr5iK8EzbH4OvxXusbqvq9iL8N2ODxQEBKzWj1m3FXT52oABlbUGfrEWWHP9p+zEjerx6YhUcHUHr1Y2u9vUCwk6rot1FQb4gnENKM4gkRsnOeP+rlWQ6mGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046421; c=relaxed/simple;
	bh=YKkpKyvpEa/AxRl/kFWiXSPQpTZJZwcyVPHCfjK9zd8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IvEFvfXzZ7dxZp4Li6SJkPRfmfJwa8jgoSbJdG3kOVJcdnXM/IoWwo0f9/CwI/IgNxFeMLRU//pbjiSIydbwHbDoyuInNiXAH6NWHn5y4IdeDWWa7xij9KAfOCXdWKUfsHk7Y89CDwsPJ0KLC4RfC/Vl2d6zrTJRALlbT6oMP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjWb4HC7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758046420; x=1789582420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YKkpKyvpEa/AxRl/kFWiXSPQpTZJZwcyVPHCfjK9zd8=;
  b=hjWb4HC7nkOve5gxpOFhR/aeAEGRWd2fnbJn3UVDOnMgvCPPGBtX/WnD
   KmVN8+LuRAzaeZKPahzYDBQs+OgH5MOLai8sA5XpLlKJvIQ5Rk2U/t0n4
   q5SX3vzeY/cIO7uDSPGxuq7y7V4297JH8E5HIKOQEVWus7TfV2ovsd5Ks
   IOw63S1P/rqFdoQylw0i2aLnaomUW858K4GuepU9iKTXugFbp+DU3g8oI
   y28nj7j8BX8s5YNQbvjEzGo4zR3JEUZdUqvA4wA+jPeGDtqIBw0D+Rsj6
   inTG2yO9df374+4pi71UXEAW89FBmqjfs8k+eJgqSHwanLMpSXyTPwi1y
   Q==;
X-CSE-ConnectionGUID: i21M9j5VQ46XT5Up5K9Bfw==
X-CSE-MsgGUID: jW3T3BZ8SceQ/KbcUxAcrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60206512"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60206512"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 11:13:39 -0700
X-CSE-ConnectionGUID: KUZOBBKSTvOuVsC72GtX4w==
X-CSE-MsgGUID: fHekWALdTGyd4TCdrG9gMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="205801058"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Sep 2025 11:13:39 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyaBL-0000dp-2L;
	Tue, 16 Sep 2025 18:13:35 +0000
Date: Wed, 17 Sep 2025 02:12:41 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: kernel/sched/core.c:9284:38: error: no member named 'scx_weight' in
 'struct task_group'
Message-ID: <202509170230.MwZsJSWa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tejun,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
commit: 6e6558a6bc418f1478c5dc8609d03805364e0cb9 sched_ext, sched/core: Factor out struct scx_task_group
date:   3 months ago
config: x86_64-buildonly-randconfig-004-20250917 (https://download.01.org/0day-ci/archive/20250917/202509170230.MwZsJSWa-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250917/202509170230.MwZsJSWa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509170230.MwZsJSWa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/core.c:9284:38: error: no member named 'scx_weight' in 'struct task_group'
    9284 |         return sched_weight_from_cgroup(tg->scx_weight);
         |                                         ~~  ^
   1 error generated.


vim +9284 kernel/sched/core.c

2480c093130f64a kernel/sched/core.c Patrick Bellasi 2019-08-22  9277  
e179e80c5d4fef4 kernel/sched/core.c Tejun Heo       2024-09-04  9278  #ifdef CONFIG_GROUP_SCHED_WEIGHT
41082c1d1d2bf6c kernel/sched/core.c Tejun Heo       2024-09-04  9279  static unsigned long tg_weight(struct task_group *tg)
41082c1d1d2bf6c kernel/sched/core.c Tejun Heo       2024-09-04  9280  {
052f1dc7eb02300 kernel/sched.c      Peter Zijlstra  2008-02-13  9281  #ifdef CONFIG_FAIR_GROUP_SCHED
41082c1d1d2bf6c kernel/sched/core.c Tejun Heo       2024-09-04  9282  	return scale_load_down(tg->shares);
8195136669661fd kernel/sched/core.c Tejun Heo       2024-09-04  9283  #else
8195136669661fd kernel/sched/core.c Tejun Heo       2024-09-04 @9284  	return sched_weight_from_cgroup(tg->scx_weight);
8195136669661fd kernel/sched/core.c Tejun Heo       2024-09-04  9285  #endif
41082c1d1d2bf6c kernel/sched/core.c Tejun Heo       2024-09-04  9286  }
41082c1d1d2bf6c kernel/sched/core.c Tejun Heo       2024-09-04  9287  

:::::: The code at line 9284 was first introduced by commit
:::::: 8195136669661fdfe54e9a8923c33b31c92fc1da sched_ext: Add cgroup support

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

