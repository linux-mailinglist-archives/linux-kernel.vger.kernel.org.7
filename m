Return-Path: <linux-kernel+bounces-740012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505BEB0CE96
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C0F1AA52BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DDC1853;
	Tue, 22 Jul 2025 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZ1r3Zlo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659DA139D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142861; cv=none; b=i3Va2+a7L6MqLFTVhvgOVLMz5K9tQzaEVGgN7AvVYycNYU8KpBe851X4/x/qFRh9nk8pwALzP4ZultL6abbhP5C+pUY4Wq6NrPmtAQm/eCJIgnAdk3d0q7AtNAnjLmHeybgHQGtwywEJ3BgdzsbiNOdrD6fT8hdzsN8cTikqBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142861; c=relaxed/simple;
	bh=6Wgm20X6bLSHSSJRuj/iLzXcql7q1mqAyxGSA2B3GSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI4VBsjdaCgp70KHyLly9a15yoE85Z+DUlAWIE2i6emRvQPhtIoDwtpVaYB3dQ4p0FRM/1RdHjVUI+mpLKhMDisDQ958GhJcgHTJN7/APpwiVFafEZ3tGXtnzRegwrewX+QIcBfdbyoVxRgIw8gQr1o1WORhOHPQ/QK/4SAvVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZ1r3Zlo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753142860; x=1784678860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Wgm20X6bLSHSSJRuj/iLzXcql7q1mqAyxGSA2B3GSI=;
  b=EZ1r3ZloLzNgKe189OqSzAunQqBOUGSsmIt0oqAKSPtHAEiLAXJ/7US/
   X1j4zsPgZKYY5ToaRt9uqVe5J+1ODjOZ2vuR7lEAcjDpOP84mVOH5QoaU
   58ZbRurcGv6VKkqdRka9GtaMqRjnDbvcJr3YchQfLD8dqfhbmrI7m+/dA
   Wtziyi/naGIAjRaWqcXXpGBB9sta4ywlNH3u8QEmYyGyaRlWz8Jm5P0Wr
   wVACFGrj0QaRfJIh8UDIJthVVs7yHn7DWCmwfARpfmtAQd2psncUO6Tly
   hGILQSfrzc3QpIBXq1AoOLtXnvoLt3xHDH1fFIyMbcD/piz/4nS3zwFXZ
   w==;
X-CSE-ConnectionGUID: PFjSSPqLTc6LwT3L/hGzyQ==
X-CSE-MsgGUID: DjQL5B6qR8uFFe8nBRyBSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66721021"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="66721021"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 17:07:40 -0700
X-CSE-ConnectionGUID: OhHBJctLQieyKNZ2bmpKlA==
X-CSE-MsgGUID: 2Tg6ofyzQGGibCJEYS6F4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159026288"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jul 2025 17:07:37 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ue0Xe-000HGj-34;
	Tue, 22 Jul 2025 00:07:34 +0000
Date: Tue, 22 Jul 2025 08:07:25 +0800
From: kernel test robot <lkp@intel.com>
To: Yuri Andriaccio <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [PATCH] sched/deadline: Remove fair-servers from real-time
 task's bandwidth accounting
Message-ID: <202507220727.BmA1Osdg-lkp@intel.com>
References: <20250721111131.309388-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721111131.309388-1-yurand2000@gmail.com>

Hi Yuri,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/master peterz-queue/sched/core next-20250721]
[cannot apply to tip/auto-latest linus/master v6.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuri-Andriaccio/sched-deadline-Remove-fair-servers-from-real-time-task-s-bandwidth-accounting/20250721-191333
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250721111131.309388-1-yurand2000%40gmail.com
patch subject: [PATCH] sched/deadline: Remove fair-servers from real-time task's bandwidth accounting
config: i386-buildonly-randconfig-001-20250722 (https://download.01.org/0day-ci/archive/20250722/202507220727.BmA1Osdg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250722/202507220727.BmA1Osdg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507220727.BmA1Osdg-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/sched/build_policy.o: in function `dl_server_apply_params':
>> kernel/sched/deadline.c:1693: undefined reference to `__udivdi3'


vim +1693 kernel/sched/deadline.c

  1677	
  1678	int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
  1679	{
  1680		u64 max_bw, new_bw = to_ratio(period, runtime);
  1681		struct rq *rq = dl_se->rq;
  1682		int cpu = cpu_of(rq);
  1683		struct dl_bw *dl_b;
  1684		unsigned long cap;
  1685		int retval = 0;
  1686		int cpus;
  1687	
  1688		dl_b = dl_bw_of(cpu);
  1689		guard(raw_spinlock)(&dl_b->lock);
  1690	
  1691		cpus = dl_bw_cpus(cpu);
  1692		cap = dl_bw_capacity(cpu);
> 1693		max_bw = cap_scale(BW_UNIT - dl_b->bw, cap) / cpus;
  1694	
  1695		if (new_bw > max_bw)
  1696			return -EBUSY;
  1697	
  1698		if (init) {
  1699			__add_rq_bw(new_bw, &rq->dl);
  1700		} else {
  1701			dl_rq_change_utilization(rq, dl_se, new_bw);
  1702		}
  1703	
  1704		dl_se->dl_runtime = runtime;
  1705		dl_se->dl_deadline = period;
  1706		dl_se->dl_period = period;
  1707	
  1708		dl_se->runtime = 0;
  1709		dl_se->deadline = 0;
  1710	
  1711		dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
  1712		dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
  1713	
  1714		return retval;
  1715	}
  1716	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

