Return-Path: <linux-kernel+bounces-857205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8612BE62EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA34E1834
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E3247DE1;
	Fri, 17 Oct 2025 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJ60iesj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1B23EAA7
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760670610; cv=none; b=rY4HdPJK/f3SyaiXAx2Y5OH1dk/uRkzLyFrg4k7NVyB61npH1u7RMQaKKiVaPXYWnV5Q5/T9swvmCfDmJXJO7hdxrygwBoKdKXDMcmlFPDIMuAShrhjJr2RRsgzCkMwMDjnSjzAMhPf8o9B1ImIzZlI7FFlSwiug/oy9erUQRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760670610; c=relaxed/simple;
	bh=cqy6kQsSj2WOatKiv0jlGCg0R5teHCD+rRCXXx9ERA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgpDiL12kMMudcTAeFsI2mHO+vVAlqwdm/7vsc925YXNs2svdxH7vQMIdwUfDMQyr4J0xadpGzVaYlUNznRwx713mjncpo6fSWa1TADjgue/zblEG0Xa+kGRe1t8wJsu1qTmMIjiLm0h6hUr3jybw/IdnFkMxgYKuwbesySZY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJ60iesj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760670608; x=1792206608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cqy6kQsSj2WOatKiv0jlGCg0R5teHCD+rRCXXx9ERA4=;
  b=BJ60iesjO0XCsilswrmkXa+HB7cWUgGvjn6o8SnEc6+LTppWPmY12DVQ
   bjPYaDQbqwypbGed6xbWjdJy8vrtvXgdHq/QfHIEg3nX9aX6p2/vx3ZyR
   c+hDe4msm5C95Zr2kzWzAY9ToXk6P/g3CC7T8OQG/mar/RuMQ1/56/PIL
   t8haXnSdKvQXADxTCGhmSBIl9UdqnHKU5iOrY2Sk78dWExYP2VhZdhm+W
   IgVzRuO7HEYLgEPe5Wc1wka3ObC+0a7OafuMhm5ycvdTwGh748qjqjf8s
   rcLmjN4qUc+4750JpO6f0GnKKktlJhuE+M0Ydcbg6CmszdvkGz+XOTolX
   g==;
X-CSE-ConnectionGUID: JozvR5ThQhehOIXQ0g3bCQ==
X-CSE-MsgGUID: 2lRO3UBZQtSQkog2EKYZAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62922594"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62922594"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 20:10:07 -0700
X-CSE-ConnectionGUID: pbN8xQMiSpmrLMnDQoxCtA==
X-CSE-MsgGUID: 99uAW1LqRZG3Jb2OF0xxrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="213203922"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 16 Oct 2025 20:10:04 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9aqv-0005Tx-2q;
	Fri, 17 Oct 2025 03:10:01 +0000
Date: Fri, 17 Oct 2025 11:09:28 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Pingfan Liu <piliu@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <202510171039.kkg2ItuG-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on tip/sched/core tip/master linus/master v6.18-rc1 next-20251016]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/sched-deadline-Walk-up-cpuset-hierarchy-to-decide-root-domain-when-hot-unplug/20251016-200452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20251016120041.17990-1-piliu%40redhat.com
patch subject: [PATCHv2] sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20251017/202510171039.kkg2ItuG-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171039.kkg2ItuG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171039.kkg2ItuG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:18,
                    from init/main.c:18:
   include/linux/cpuset.h: In function 'cpuset_task_rd_effective_cpus':
>> include/linux/cpumask.h:125:28: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     125 | #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
         |                           ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cpuset.h:282:16: note: in expansion of macro 'cpu_active_mask'
     282 |         return cpu_active_mask;
         |                ^~~~~~~~~~~~~~~


vim +/const +125 include/linux/cpumask.h

^1da177e4c3f415 Linus Torvalds   2005-04-16   77  
^1da177e4c3f415 Linus Torvalds   2005-04-16   78  /*
^1da177e4c3f415 Linus Torvalds   2005-04-16   79   * The following particular system cpumasks and operations manage
b3199c025d1646e Rusty Russell    2008-12-30   80   * possible, present, active and online cpus.
^1da177e4c3f415 Linus Torvalds   2005-04-16   81   *
b3199c025d1646e Rusty Russell    2008-12-30   82   *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
b3199c025d1646e Rusty Russell    2008-12-30   83   *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
4e1a7df4548003f James Morse      2024-05-29   84   *     cpu_enabled_mask - has bit 'cpu' set iff cpu can be brought online
b3199c025d1646e Rusty Russell    2008-12-30   85   *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
b3199c025d1646e Rusty Russell    2008-12-30   86   *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
^1da177e4c3f415 Linus Torvalds   2005-04-16   87   *
b3199c025d1646e Rusty Russell    2008-12-30   88   *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
^1da177e4c3f415 Linus Torvalds   2005-04-16   89   *
57f728d59f005df Randy Dunlap     2023-07-31   90   *  The cpu_possible_mask is fixed at boot time, as the set of CPU IDs
b3199c025d1646e Rusty Russell    2008-12-30   91   *  that it is possible might ever be plugged in at anytime during the
b3199c025d1646e Rusty Russell    2008-12-30   92   *  life of that system boot.  The cpu_present_mask is dynamic(*),
b3199c025d1646e Rusty Russell    2008-12-30   93   *  representing which CPUs are currently plugged in.  And
b3199c025d1646e Rusty Russell    2008-12-30   94   *  cpu_online_mask is the dynamic subset of cpu_present_mask,
b3199c025d1646e Rusty Russell    2008-12-30   95   *  indicating those CPUs available for scheduling.
b3199c025d1646e Rusty Russell    2008-12-30   96   *
b3199c025d1646e Rusty Russell    2008-12-30   97   *  If HOTPLUG is enabled, then cpu_present_mask varies dynamically,
^1da177e4c3f415 Linus Torvalds   2005-04-16   98   *  depending on what ACPI reports as currently plugged in, otherwise
b3199c025d1646e Rusty Russell    2008-12-30   99   *  cpu_present_mask is just a copy of cpu_possible_mask.
^1da177e4c3f415 Linus Torvalds   2005-04-16  100   *
b3199c025d1646e Rusty Russell    2008-12-30  101   *  (*) Well, cpu_present_mask is dynamic in the hotplug case.  If not
b3199c025d1646e Rusty Russell    2008-12-30  102   *      hotplug, it's a copy of cpu_possible_mask, hence fixed at boot.
^1da177e4c3f415 Linus Torvalds   2005-04-16  103   *
^1da177e4c3f415 Linus Torvalds   2005-04-16  104   * Subtleties:
57f728d59f005df Randy Dunlap     2023-07-31  105   * 1) UP ARCHes (NR_CPUS == 1, CONFIG_SMP not defined) hardcode
^1da177e4c3f415 Linus Torvalds   2005-04-16  106   *    assumption that their single CPU is online.  The UP
b3199c025d1646e Rusty Russell    2008-12-30  107   *    cpu_{online,possible,present}_masks are placebos.  Changing them
^1da177e4c3f415 Linus Torvalds   2005-04-16  108   *    will have no useful affect on the following num_*_cpus()
^1da177e4c3f415 Linus Torvalds   2005-04-16  109   *    and cpu_*() macros in the UP case.  This ugliness is a UP
^1da177e4c3f415 Linus Torvalds   2005-04-16  110   *    optimization - don't waste any instructions or memory references
^1da177e4c3f415 Linus Torvalds   2005-04-16  111   *    asking if you're online or how many CPUs there are if there is
^1da177e4c3f415 Linus Torvalds   2005-04-16  112   *    only one CPU.
^1da177e4c3f415 Linus Torvalds   2005-04-16  113   */
^1da177e4c3f415 Linus Torvalds   2005-04-16  114  
4b804c85dc37db6 Rasmus Villemoes 2016-01-20  115  extern struct cpumask __cpu_possible_mask;
4b804c85dc37db6 Rasmus Villemoes 2016-01-20  116  extern struct cpumask __cpu_online_mask;
4e1a7df4548003f James Morse      2024-05-29  117  extern struct cpumask __cpu_enabled_mask;
4b804c85dc37db6 Rasmus Villemoes 2016-01-20  118  extern struct cpumask __cpu_present_mask;
4b804c85dc37db6 Rasmus Villemoes 2016-01-20  119  extern struct cpumask __cpu_active_mask;
e40f74c535b8a0e Peter Zijlstra   2021-01-19  120  extern struct cpumask __cpu_dying_mask;
5aec01b834fd6f8 Rasmus Villemoes 2016-01-20  121  #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
5aec01b834fd6f8 Rasmus Villemoes 2016-01-20  122  #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
4e1a7df4548003f James Morse      2024-05-29  123  #define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
5aec01b834fd6f8 Rasmus Villemoes 2016-01-20  124  #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
5aec01b834fd6f8 Rasmus Villemoes 2016-01-20 @125  #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
e40f74c535b8a0e Peter Zijlstra   2021-01-19  126  #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
b3199c025d1646e Rusty Russell    2008-12-30  127  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

