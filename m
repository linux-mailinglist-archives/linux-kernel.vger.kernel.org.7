Return-Path: <linux-kernel+bounces-752820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D684AB17B45
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D331AA70CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18E1EA65;
	Fri,  1 Aug 2025 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4d4cB3j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EF1F5EA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754016132; cv=none; b=JwS9eJPRQP2lZY5VNBc4glogyrqDrQmgvzBGgK3WvDQ0OFmJGEUNCn8fm6fWZzmH8cRMQn+cFGBul6jWLhOMXnSiXDgigTLmOz7w6vS+QtuV5PIK8EKQTyzJCHcG2nrOmxdFdLfFWWn1zO4e5yd5sZQSItnom2loobw0DUSU9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754016132; c=relaxed/simple;
	bh=LYXq4DasOMn9bVE/1iFYCJjSyUGOkTeSL3iyfCseTAg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fPzq9dlRzn+jL+CGYldlTLiYN6dLL2MGylb9BP2Y//aeHfd7J3ZNIzW49YWzQcxLyR4ww3eU+I2V0u9h5NCsstc/CIfoLORmJXuXg4ZuPURBMY39WrEDlPFtz4wqIDwpb6DkMbfgw+jOvaKbcJbFPY6e79GqStLKXAJWEhZva08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4d4cB3j; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754016131; x=1785552131;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LYXq4DasOMn9bVE/1iFYCJjSyUGOkTeSL3iyfCseTAg=;
  b=c4d4cB3j+AKYKRFN9J8m0toVootVHeZdbBRMUXtNTqCJSU4URg6FlR/B
   /SF00424M9uFboi8/mj7/ArtdQ6FtJgUHykAIeKeTklfUBPR48qbsHXMB
   vBp2hiQNaJQZt3kWCGFjsNZFNqvQIyxfzYXEmvQP8IJQ7zF32bNVnm8J2
   L1s9ZVI5I8bNg32tXqP4dLnc6R5srkEeKe1CMDsqAEdaaIgNLv6yjaqHV
   PpoDA01R8JJy9gZJ9wFbqeE4ERmKQui5i/zKGTN4cFiosGEoxEJQEOz6E
   r/CI8n0eKRULK9+ZEIl9klbfF4XhZF2OFWiZxm0yylplXWrR3FZWaE1/l
   Q==;
X-CSE-ConnectionGUID: 78e8jav3T+G8SyMmMZq1rQ==
X-CSE-MsgGUID: 9kaHw2p3Q22l+r2S/yZPiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56054185"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56054185"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 19:42:10 -0700
X-CSE-ConnectionGUID: 1uONOu97S8OQBaxLiqHWlA==
X-CSE-MsgGUID: nDElMjbyRGOL/0xJqA/T2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163776184"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 31 Jul 2025 19:42:07 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhfiZ-0004J2-2H;
	Fri, 01 Aug 2025 02:41:59 +0000
Date: Fri, 1 Aug 2025 10:41:09 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/kstack_erase.c:34:56: sparse: sparse: incorrect type in
 argument 3 (different address spaces)
Message-ID: <202508011029.WGeVHkWa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Kees,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a68cec16b647791d448102376a7eec2820e874f
commit: 32e42ab9fc88a884435c27527a433f61c4d2b61b sched/task_stack: Add missing const qualifier to end_of_stack()
date:   5 days ago
config: loongarch-randconfig-r112-20250801 (https://download.01.org/0day-ci/archive/20250801/202508011029.WGeVHkWa-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 8f09b03aebb71c154f3bbe725c29e3f47d37c26e)
reproduce: (https://download.01.org/0day-ci/archive/20250801/202508011029.WGeVHkWa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508011029.WGeVHkWa-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/kstack_erase.c:34:56: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void * @@     got void [noderef] __user *buffer @@
   kernel/kstack_erase.c:34:56: sparse:     expected void *
   kernel/kstack_erase.c:34:56: sparse:     got void [noderef] __user *buffer
>> kernel/kstack_erase.c:54:35: sparse: sparse: incorrect type in initializer (incompatible argument 3 (different address spaces)) @@     expected int ( [usertype] *proc_handler )( ... ) @@     got int ( * )( ... ) @@
   kernel/kstack_erase.c:54:35: sparse:     expected int ( [usertype] *proc_handler )( ... )
   kernel/kstack_erase.c:54:35: sparse:     got int ( * )( ... )

vim +34 kernel/kstack_erase.c

964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  23  
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  24  #ifdef CONFIG_SYSCTL
78eb4ea25cd5fd kernel/stackleak.c Joel Granados    2024-07-24  25  static int stack_erasing_sysctl(const struct ctl_table *table, int write,
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  26  			void __user *buffer, size_t *lenp, loff_t *ppos)
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  27  {
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  28  	int ret = 0;
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  29  	int state = !static_branch_unlikely(&stack_erasing_bypass);
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  30  	int prev_state = state;
0e148d3cca0dc1 kernel/stackleak.c Thomas Weiﬂschuh 2024-05-03  31  	struct ctl_table table_copy = *table;
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  32  
0e148d3cca0dc1 kernel/stackleak.c Thomas Weiﬂschuh 2024-05-03  33  	table_copy.data = &state;
0e148d3cca0dc1 kernel/stackleak.c Thomas Weiﬂschuh 2024-05-03 @34  	ret = proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  35  	state = !!state;
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  36  	if (ret || !write || state == prev_state)
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  37  		return ret;
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  38  
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  39  	if (state)
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  40  		static_branch_disable(&stack_erasing_bypass);
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  41  	else
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  42  		static_branch_enable(&stack_erasing_bypass);
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  43  
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  44  	pr_warn("stackleak: kernel stack erasing is %s\n",
62e9c1e8ecee87 kernel/stackleak.c Thorsten Blum    2024-12-22  45  					str_enabled_disabled(state));
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  46  	return ret;
964c9dff009189 kernel/stackleak.c Alexander Popov  2018-08-17  47  }
1751f872cc97f9 kernel/stackleak.c Joel Granados    2025-01-28  48  static const struct ctl_table stackleak_sysctls[] = {
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  49  	{
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  50  		.procname	= "stack_erasing",
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  51  		.data		= NULL,
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  52  		.maxlen		= sizeof(int),
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  53  		.mode		= 0600,
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21 @54  		.proc_handler	= stack_erasing_sysctl,
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  55  		.extra1		= SYSCTL_ZERO,
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  56  		.extra2		= SYSCTL_ONE,
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  57  	},
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  58  };
0df8bdd5e3b3e5 kernel/stackleak.c Xiaoming Ni      2022-01-21  59  

:::::: The code at line 34 was first introduced by commit
:::::: 0e148d3cca0dc1a7c6063939f6cb9ba4866c39a7 stackleak: Use a copy of the ctl_table argument

:::::: TO: Thomas Weiﬂschuh <linux@weissschuh.net>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

