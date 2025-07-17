Return-Path: <linux-kernel+bounces-735555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8216B090E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FD717F284
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099572F9486;
	Thu, 17 Jul 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRMNtUkx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654D2E49B1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767410; cv=none; b=Lpm45pMXzqC/CzctUR9R+LqRY3GIl/LUUQ03wy32baPMIKpQAwEAJLV/tOFS/ZoYrBmNXZIbV0oGVmOmO3RJDI/57p7OifT812ftRnTamReHpgMFsBx5G1Hw+AUm11gk/y78fHLKbtEkZZnOy8wCuG4hWhAqdlhc1Y2vwdbkVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767410; c=relaxed/simple;
	bh=mFN+qt90NTLPVkK0n72bietqKRMIRyf13Q6LEEcHiSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vBWoKqcpnU2XykZybesrO+NgPFlFIoIWqlPtNr42W8YIfvlfl9WJNVFf0Xc9dEknypmw5V6smt7e2yJA9EgcII+HGSWjGDuaB32gVExrENuwKwwcZCVYGxq6+M2N/HmlkcGBO1LSfHquXVWqJ4yHo1RWCqKi//wNSI7FuGgVYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRMNtUkx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752767409; x=1784303409;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mFN+qt90NTLPVkK0n72bietqKRMIRyf13Q6LEEcHiSw=;
  b=SRMNtUkxthiICg+jGqA/Mf82eyU/9GdL+fxJJs5dEPIuMUa8Rxuwz4x2
   /HO+Ty96e+Mp+Yp2Qm4OchwdcBojFnSkMiz9ggixUkVsQ50+ZngE1FX30
   ZQywfnOqqYZz8Ss6z0N1ap2azO0yfXfT10gGIp4zu/GTWz/h+TSDx4sNK
   im6K6thoXwopj0Mm26x9YZgOOXWPSSu0hEUwr4JupSASApYpjWHaP0ABi
   w6JbM8UQFqQYhclKEOtpDd/mgrq1iKpEMdTff8GLDoRWaiYIPkpYXo74F
   jBfzVSOze4eDemSsk8mAS5lS1YtNe6cqz27m5eCYg0xfeGd4Nb/IFpKaf
   w==;
X-CSE-ConnectionGUID: kAtkD4KvTN6JzNIBn24VoQ==
X-CSE-MsgGUID: pgG7/pQQShKHze6sk/HbXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54923565"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54923565"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 08:50:01 -0700
X-CSE-ConnectionGUID: 0ZUu+b8nSHmVCRjcLwhShQ==
X-CSE-MsgGUID: OPvAtDTARsqxX4AcXeekKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157932194"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jul 2025 08:49:59 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucQrs-000DmR-2j;
	Thu, 17 Jul 2025 15:49:56 +0000
Date: Thu, 17 Jul 2025 23:49:27 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [tip:locking/futex 2/6] kernel/futex/core.c:1748:2-8: WARNING: NULL
 check before some freeing functions is not needed.
Message-ID: <202507172340.xrO8KXQq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/futex
head:   7497e947bc1d3f761b46c2105c8ae37af98add54
commit: 56180dd20c19e5b0fa34822997a9ac66b517e7b3 [2/6] futex: Use RCU-based per-CPU reference counting instead of rcuref_t
config: microblaze-randconfig-r052-20250717 (https://download.01.org/0day-ci/archive/20250717/202507172340.xrO8KXQq-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507172340.xrO8KXQq-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> kernel/futex/core.c:1748:2-8: WARNING: NULL check before some freeing functions is not needed.

vim +1748 kernel/futex/core.c

56180dd20c19e5 Peter Zijlstra            2025-07-10  1739  
80367ad01d93ac Sebastian Andrzej Siewior 2025-04-16  1740  void futex_hash_free(struct mm_struct *mm)
80367ad01d93ac Sebastian Andrzej Siewior 2025-04-16  1741  {
bd54df5ea7cada Sebastian Andrzej Siewior 2025-04-16  1742  	struct futex_private_hash *fph;
bd54df5ea7cada Sebastian Andrzej Siewior 2025-04-16  1743  
56180dd20c19e5 Peter Zijlstra            2025-07-10  1744  	free_percpu(mm->futex_ref);
bd54df5ea7cada Sebastian Andrzej Siewior 2025-04-16  1745  	kvfree(mm->futex_phash_new);
bd54df5ea7cada Sebastian Andrzej Siewior 2025-04-16  1746  	fph = rcu_dereference_raw(mm->futex_phash);
56180dd20c19e5 Peter Zijlstra            2025-07-10  1747  	if (fph)
bd54df5ea7cada Sebastian Andrzej Siewior 2025-04-16 @1748  		kvfree(fph);
bd54df5ea7cada Sebastian Andrzej Siewior 2025-04-16  1749  }
bd54df5ea7cada Sebastian Andrzej Siewior 2025-04-16  1750  

:::::: The code at line 1748 was first introduced by commit
:::::: bd54df5ea7cadac520e346d5f0fe5d58e635b6ba futex: Allow to resize the private local hash

:::::: TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

