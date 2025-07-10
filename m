Return-Path: <linux-kernel+bounces-724900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68C9AFF84B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1934E82E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0333C21FF42;
	Thu, 10 Jul 2025 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By2y6vF6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67D21CC71
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123796; cv=none; b=CwYmy4xTjOEihldys8jhvx1ZpLEnTROfbVUeBUl4Y2xK8XLoiu0K6/WcrCy+DB5CTMIye1wt2JBwynPKcr4SEzZaBPKMzLMHVT/yVy+ngtksVLPtBmuhU6rkbL8RluKIsgbZ5EZvTspvF72aHtqQmBefaWQRjF379ICur/vNQPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123796; c=relaxed/simple;
	bh=Ceu1vyvqX6TYeOkJEwk23yxxRDONyxh9J+9TUBafHoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YZBMKXnrr2bSCg8ry1mJdMRIRMZbJwKUZzm12+pkVjFm1FjQmr4qHY1prClKv30L+7cVHFF5otHd+R3ijPNqeYd48LV4NvHPcbRMOfQf1uPCt0mPHA3CaLrPwg+PJ5nUwVEfTFBsW4pZQMyDmAJlyDEzYGlDRZmTSLnXfKUcePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By2y6vF6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752123794; x=1783659794;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ceu1vyvqX6TYeOkJEwk23yxxRDONyxh9J+9TUBafHoU=;
  b=By2y6vF6a8uUlHZlGK0ClK2bcpXGUsJVWh8epCZT0EYPJrMkDrRvXvN2
   AB/ExbyAkzJ1Rj5IOUZx8uuHblqu2foPwtjz3Wrr5HNPawzMtQzV0Xyzx
   3Ng1ejtD3kSMU0RoLDLMnfZT+Nzwqo4hhswXBkbjwgb8z96GtjfdxJNRI
   rcWyzNpID2zfxUwwJ2pMcfTVMCDZfHx58ZUixYJvPUlLhH/bAq9W4Zk1Y
   uSeyaBjj0yjCrqufEVd1pJ0H1FP7jPB/1lICkCx9bc1uhZyZ/ydHHrnq9
   RRSdJd4CWCteUAc8J2zUYvmAYG6oNORWa/emzZT9FVzlN8+mkkdtD52Jr
   w==;
X-CSE-ConnectionGUID: O8CyrG61QZyEj4hn05vNRA==
X-CSE-MsgGUID: n7xyr2QbRyWI2C64XocW3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71977974"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="71977974"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 22:03:14 -0700
X-CSE-ConnectionGUID: fR1eTBIWSDmFpWh27Ok4Kw==
X-CSE-MsgGUID: crU3mnTXSU6ZxBpS49yptA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="155380034"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Jul 2025 22:03:12 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZjR7-0004V3-2s;
	Thu, 10 Jul 2025 05:03:09 +0000
Date: Thu, 10 Jul 2025 13:02:39 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: arch/arm64/kernel/signal.c:1042: undefined reference to
 `restore_gcs_context'
Message-ID: <202507101225.jSw3nM7e-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Robin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2
commit: f00b53f1614f7be554fd28b9594ef4e63e2686c5 arm64: cpufeature: Add GCS to cpucap_is_possible()
date:   7 months ago
config: arm64-randconfig-003-20250710 (https://download.01.org/0day-ci/archive/20250710/202507101225.jSw3nM7e-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250710/202507101225.jSw3nM7e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507101225.jSw3nM7e-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: arch/arm64/kernel/signal.o: in function `restore_sigframe':
>> arch/arm64/kernel/signal.c:1042: undefined reference to `restore_gcs_context'
   aarch64-linux-ld: arch/arm64/kernel/signal.o: in function `setup_sigframe':
>> arch/arm64/kernel/signal.c:1300: undefined reference to `preserve_gcs_context'


vim +1042 arch/arm64/kernel/signal.c

47ccb02868cead Dave Martin      2017-06-15  1002  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1003  static int restore_sigframe(struct pt_regs *regs,
2e8a1acea8597f Kevin Brodsky    2024-10-29  1004  			    struct rt_sigframe __user *sf,
2e8a1acea8597f Kevin Brodsky    2024-10-29  1005  			    struct user_access_state *ua_state)
2c020ed8d148f7 Catalin Marinas  2012-03-05  1006  {
2c020ed8d148f7 Catalin Marinas  2012-03-05  1007  	sigset_t set;
2c020ed8d148f7 Catalin Marinas  2012-03-05  1008  	int i, err;
47ccb02868cead Dave Martin      2017-06-15  1009  	struct user_ctxs user;
2c020ed8d148f7 Catalin Marinas  2012-03-05  1010  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1011  	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
2c020ed8d148f7 Catalin Marinas  2012-03-05  1012  	if (err == 0)
2c020ed8d148f7 Catalin Marinas  2012-03-05  1013  		set_current_blocked(&set);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1014  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1015  	for (i = 0; i < 31; i++)
2c020ed8d148f7 Catalin Marinas  2012-03-05  1016  		__get_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
2c020ed8d148f7 Catalin Marinas  2012-03-05  1017  				 err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1018  	__get_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1019  	__get_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1020  	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1021  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1022  	/*
2c020ed8d148f7 Catalin Marinas  2012-03-05  1023  	 * Avoid sys_rt_sigreturn() restarting.
2c020ed8d148f7 Catalin Marinas  2012-03-05  1024  	 */
17c28958600928 Dave Martin      2017-08-01  1025  	forget_syscall(regs);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1026  
dbd4d7ca563fd0 Mark Rutland     2016-03-01  1027  	err |= !valid_user_regs(&regs->user_regs, current);
47ccb02868cead Dave Martin      2017-06-15  1028  	if (err == 0)
47ccb02868cead Dave Martin      2017-06-15  1029  		err = parse_user_sigframe(&user, sf);
2c020ed8d148f7 Catalin Marinas  2012-03-05  1030  
6d502b6ba1b267 Suzuki K Poulose 2020-01-13  1031  	if (err == 0 && system_supports_fpsimd()) {
8cd969d28fd284 Dave Martin      2017-10-31  1032  		if (!user.fpsimd)
8cd969d28fd284 Dave Martin      2017-10-31  1033  			return -EINVAL;
8cd969d28fd284 Dave Martin      2017-10-31  1034  
df07443f477a7e Mark Brown       2022-06-24  1035  		if (user.sve)
8cd969d28fd284 Dave Martin      2017-10-31  1036  			err = restore_sve_fpsimd_context(&user);
df07443f477a7e Mark Brown       2022-06-24  1037  		else
4e4e93045fe1ad Mark Brown       2023-01-31  1038  			err = restore_fpsimd_context(&user);
8cd969d28fd284 Dave Martin      2017-10-31  1039  	}
2c020ed8d148f7 Catalin Marinas  2012-03-05  1040  
16f47bb9ac8afe Mark Brown       2024-10-01  1041  	if (err == 0 && system_supports_gcs() && user.gcs)
16f47bb9ac8afe Mark Brown       2024-10-01 @1042  		err = restore_gcs_context(&user);
16f47bb9ac8afe Mark Brown       2024-10-01  1043  
e9d14f3f3fb76c Dongxu Sun       2023-03-17  1044  	if (err == 0 && system_supports_tpidr2() && user.tpidr2)
39e54499280f37 Mark Brown       2022-12-27  1045  		err = restore_tpidr2_context(&user);
39e54499280f37 Mark Brown       2022-12-27  1046  
8c46def44409fc Mark Brown       2024-03-06  1047  	if (err == 0 && system_supports_fpmr() && user.fpmr)
8c46def44409fc Mark Brown       2024-03-06  1048  		err = restore_fpmr_context(&user);
8c46def44409fc Mark Brown       2024-03-06  1049  
39782210eb7e87 Mark Brown       2022-04-19  1050  	if (err == 0 && system_supports_sme() && user.za)
39782210eb7e87 Mark Brown       2022-04-19  1051  		err = restore_za_context(&user);
39782210eb7e87 Mark Brown       2022-04-19  1052  
ee072cf708048c Mark Brown       2023-01-16  1053  	if (err == 0 && system_supports_sme2() && user.zt)
ee072cf708048c Mark Brown       2023-01-16  1054  		err = restore_zt_context(&user);
ee072cf708048c Mark Brown       2023-01-16  1055  
9160f7e909e179 Joey Gouly       2024-08-22  1056  	if (err == 0 && system_supports_poe() && user.poe)
2e8a1acea8597f Kevin Brodsky    2024-10-29  1057  		err = restore_poe_context(&user, ua_state);
9160f7e909e179 Joey Gouly       2024-08-22  1058  
2c020ed8d148f7 Catalin Marinas  2012-03-05  1059  	return err;
2c020ed8d148f7 Catalin Marinas  2012-03-05  1060  }
2c020ed8d148f7 Catalin Marinas  2012-03-05  1061  

:::::: The code at line 1042 was first introduced by commit
:::::: 16f47bb9ac8afe09e7ca14cc53748f779b2a12e0 arm64/signal: Expose GCS state in signal frames

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

