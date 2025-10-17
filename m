Return-Path: <linux-kernel+bounces-857177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75FBE617F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D031A6456F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763B23EA93;
	Fri, 17 Oct 2025 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Za+xliLT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773CE2036E9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667480; cv=none; b=Vo3v6dVl1fTUJPQRREfLXInsZ1j3i39bx8RpgH1yFyzlBstgJFGKgeyl6FWLnSmzrWc/eHw5LV5jDdi7s0jZ906MPhHgax39fDCpRLrg4gKNn7TRLyoDLMY4mZlz/ZzcXuVwdRw07j38jVlEoeayLhUlJs82cc4y1nr6OHkCICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667480; c=relaxed/simple;
	bh=8PzPXACkbtO7c8cK21V9ojH9y1teqhhQdQlEzC9/NG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2XPcCleAhDoPiQLYLFEfoGI1/UkX290b+P+4U/QxI5eGY7Z2OEyDvrhnoRlxdFaGbv4HDY8LL/Lk9SMRcdpNCfZacl9v6Lad3vKzyG0OgEeX4Ni1+EoCCeq4TwujbKhYoBJMhip2/dvS7K1YbtRPQWGZyYGpnqKc6JM8QHpsEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Za+xliLT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760667478; x=1792203478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8PzPXACkbtO7c8cK21V9ojH9y1teqhhQdQlEzC9/NG4=;
  b=Za+xliLT6EsdGYS+eLLXIRpRPV0d937GmBb3lpIiLZ5fkQupWuPBpzuW
   AwNiN/qh+OQZELqRG7+NDG5DYr/Fs4J7ZnWTJZzdCZArryNyNdvqE3grZ
   EZZmiRquV/UfPqQqs9Vu+rUouMUc9lhBrVpFSybtt+2dahG2Ux62zIWCt
   /cKqMKXPO0LwCPQUDkYUhYhD9o74FgOfUb0nKcjJg5NBlr9+ZEvRyFrZp
   NvwzPM63x/eTUDANieeCZx4Om02NBO4r7QW0+Y6n6fwBqneZdO5HjEPgt
   8kIxADKFMbkNrh+pQwo/0ITkHKlyAp44u9o4FcfHGoNPPgC6rxutHOV9v
   A==;
X-CSE-ConnectionGUID: 2PyM1x41RJywmQfM67fgHw==
X-CSE-MsgGUID: piv67BWcQrWWF/mmJHMAtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="63020188"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="63020188"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:17:56 -0700
X-CSE-ConnectionGUID: 0mtAfkURTLOoqn3irNz/mw==
X-CSE-MsgGUID: S0WVeFLBSICVKSaDZr9oVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182549462"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 16 Oct 2025 19:17:53 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9a2Q-0005Ry-2u;
	Fri, 17 Oct 2025 02:17:50 +0000
Date: Fri, 17 Oct 2025 10:17:36 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pingfan Liu <piliu@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <202510170932.nTEduJGM-lkp@intel.com>
References: <20251016120041.17990-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016120041.17990-1-piliu@redhat.com>

Hi Pingfan,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on tip/sched/core tip/master linus/master v6.18-rc1 next-20251016]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/sched-deadline-Walk-up-cpuset-hierarchy-to-decide-root-domain-when-hot-unplug/20251016-200452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20251016120041.17990-1-piliu%40redhat.com
patch subject: [PATCHv2] sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20251017/202510170932.nTEduJGM-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510170932.nTEduJGM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510170932.nTEduJGM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from init/main.c:53:
>> include/linux/cpuset.h:282:9: error: returning 'const struct cpumask *' from a function with result type 'struct cpumask *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     282 |         return cpu_active_mask;
         |                ^~~~~~~~~~~~~~~
   include/linux/cpumask.h:125:27: note: expanded from macro 'cpu_active_mask'
     125 | #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +282 include/linux/cpuset.h

   279	
   280	static inline struct cpumask *cpuset_task_rd_effective_cpus(struct task_struct *p)
   281	{
 > 282		return cpu_active_mask;
   283	}
   284	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

