Return-Path: <linux-kernel+bounces-745988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A17CB12154
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9990C567593
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF562EE97E;
	Fri, 25 Jul 2025 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXRYf+uR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D94239E9D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458764; cv=none; b=WqTL8nBKyTqGCETvGX9HsNVUbtLdkPlzitwBUBiOrJidhPy2MGVcyDCoJBvIbXVrpAF6za9q/zhcX6R9YbcRL3VON46cM9Ei3ToG8Obx1luThQsiVT9iyF31MeUJ61uLUROIAbwGz+GMw90HcgNo4Ai8eZHfZ516nEk+6oHLKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458764; c=relaxed/simple;
	bh=+RYDrNRJQhICCBGGY5xRS0kRj9tUcIqZkGO8CwL+DV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTaAPoqSRRf91tB+dA4uX1orED6fmCq25rFMoYm7zrXHbBUnMuOAVovN6YAUE0CRMlPg/q6YbDvos4aVMs0I7Sl5kES9NtlFnSQwwvbpfIgdEOmGqSck0/XXyVdeeYFqh/Ma7ulXC9cDd9WE7DV/O/JD+QdLBhLA77oluaJP9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXRYf+uR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753458763; x=1784994763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+RYDrNRJQhICCBGGY5xRS0kRj9tUcIqZkGO8CwL+DV0=;
  b=nXRYf+uRpTbcGSEr4ChEF3v7iFl09CUQukvyDR3u4CiQ6wR3Py+2+9dq
   YO0MPM/dYInFE4FoiWQg4VjvqPoI0oRaYsN8GiDcHjOAfAlGsAuOUzoyB
   Zii1JZvZe+CtEz6YpY2XhF9bUurkgqdicTpIOCRPATN3Irmnu/NGfbPlu
   uJneJK48B0Fn/DdqLp+h8/R+DUNB7bSE2/DUlP034qcZlcqU+5xUc8dmS
   p0e9lwQ0XfMyK9HuG2MqM1S6RAf6s4/4s3ZqcOt10vBp85Tyfv5lvg2iE
   KJwOzknVNMpKCOSpRYU7LrTMCNy+yVgrf0122cm/jjuA6X8dTe1TK54BZ
   g==;
X-CSE-ConnectionGUID: KwmHUH1+SvqnzMQhpfvYIA==
X-CSE-MsgGUID: uAgY1kqPSL+0PTlUYdcMAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="81235362"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="81235362"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 08:52:42 -0700
X-CSE-ConnectionGUID: uwiA7YkkQVCKfCgGGur02A==
X-CSE-MsgGUID: 7G9mFMbeT4qj63Njqj2yHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166466297"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Jul 2025 08:52:40 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufKir-000LOZ-2U;
	Fri, 25 Jul 2025 15:52:37 +0000
Date: Fri, 25 Jul 2025 23:52:35 +0800
From: kernel test robot <lkp@intel.com>
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, peterz@infradead.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
	vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: Re: [PATCH V7 11/11] sched: Add kernel parameter to enable delaying
 RT threads
Message-ID: <202507252357.llkbFyOC-lkp@intel.com>
References: <20250724161625.2360309-12-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724161625.2360309-12-prakash.sangappa@oracle.com>

Hi Prakash,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on linus/master v6.16-rc7]
[cannot apply to tip/sched/core tip/core/entry next-20250725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prakash-Sangappa/sched-Scheduler-time-slice-extension/20250725-002052
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250724161625.2360309-12-prakash.sangappa%40oracle.com
patch subject: [PATCH V7 11/11] sched: Add kernel parameter to enable delaying RT threads
config: riscv-randconfig-001-20250725 (https://download.01.org/0day-ci/archive/20250725/202507252357.llkbFyOC-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250725/202507252357.llkbFyOC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507252357.llkbFyOC-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/entry/common.c: In function 'rseq_delay_resched':
>> kernel/entry/common.c:96:11: error: 'sysctl_sched_delay_rt' undeclared (first use in this function)
      96 |  tiflag = sysctl_sched_delay_rt ? _TIF_NEED_RESCHED|_TIF_NEED_RESCHED_LAZY :
         |           ^~~~~~~~~~~~~~~~~~~~~
   kernel/entry/common.c:96:11: note: each undeclared identifier is reported only once for each function it appears in


vim +/sysctl_sched_delay_rt +96 kernel/entry/common.c

    85	
    86	static inline bool rseq_delay_resched(unsigned long ti_work)
    87	{
    88		unsigned long tiflag;
    89	
    90		if (!IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
    91			return false;
    92	
    93		if (unlikely(current->rseq_delay_resched != RSEQ_RESCHED_DELAY_PROBE))
    94			return false;
    95	
  > 96		tiflag = sysctl_sched_delay_rt ? _TIF_NEED_RESCHED|_TIF_NEED_RESCHED_LAZY :
    97			 _TIF_NEED_RESCHED_LAZY;
    98	
    99		if (!(ti_work & tiflag))
   100			return false;
   101	
   102		if (__rseq_delay_resched()) {
   103			clear_tsk_need_resched(current);
   104			trace_sched_delay_resched(current, ti_work);
   105			return true;
   106		}
   107		return false;
   108	}
   109	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

