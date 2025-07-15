Return-Path: <linux-kernel+bounces-732638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4378B069E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B2F16C341
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D423E320;
	Tue, 15 Jul 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djrFmAT8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715D2D3738
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622197; cv=none; b=KPbaCNpuKZZn0vTZmIyDqdTszQINP/+5Qi+xVTLKJaRKGMxtNgBhYZ1ONbyaBQQPzki1RC1J7I85rkXRdWqAjH7EaTpIrYS2BW3rFkzV4F4nik4f63Nxf/hu9vhW2y5aJ94Qb2JUFmTT857aa8/2hkvtg5PHi2i/pYeRZZutn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622197; c=relaxed/simple;
	bh=WF6bfUxp5mzXUlANjLVW9CB9l9Zbo4W0VbxjuCwHMNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdzc9o7r9XF5w/lAXXePWh/Ma+nhdQjXYUocuoAMYNMuUdHg7XY4DNKXDU+nr2gJ/uK0ezvrq/2N0u7OR8PTTLEdr+kmwidngizUJAsJE6f+4Wqs+szmTNdfF74+n+Bnpxtom7/5nIOSxY4+jlXAxYF7R+2YIIgm2xMZzLrIqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djrFmAT8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752622196; x=1784158196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WF6bfUxp5mzXUlANjLVW9CB9l9Zbo4W0VbxjuCwHMNI=;
  b=djrFmAT8zqA1jozPIYjALnQM48dD01F3C3Dhc0TYpxvN1Wk2qqSW5bzC
   O2XDMnIrwdUrB8z7w65ziNA+38tz2dr+OXAxs2egKWMWCRYkvzJdUDmtM
   a5/H/4Bk/K7OlANxyxkYTsdUTfM32IqJF9aNh9a0czAq6EaNplLSOCbp9
   OAoPf80rC0FZAZaMG8RSC6XDWWrfFCMop9XA0VPwjCCBKOMAIL4THT+L7
   XkQ/UExAEQpkS4zOBM/8yMCU9nw3kbtiZPbrZIL9wM02v0GPrWxjaa3DD
   /dJjCXBRlXmIwaXNIncH+E/cvzCgkj+i6sPYrs9XtOluPFBxrTH5cRhqT
   A==;
X-CSE-ConnectionGUID: PQCIQRdrSDuY27bMtcnZ6A==
X-CSE-MsgGUID: uJDTMkmtQYuRDkYCQyvTBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="77390490"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="77390490"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 16:29:56 -0700
X-CSE-ConnectionGUID: TyLvBkv8RS+hZD/PXNQh6Q==
X-CSE-MsgGUID: 88xeL54PT/CpqFitAZAzDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="181035286"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jul 2025 16:29:51 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubp5o-000BfH-0z;
	Tue, 15 Jul 2025 23:29:48 +0000
Date: Wed, 16 Jul 2025 07:29:37 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Lu <ziqianlu@bytedance.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <202507160730.0cXkgs0S-lkp@intel.com>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071658.267-4-ziqianlu@bytedance.com>

Hi Aaron,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on next-20250715]
[cannot apply to linus/master v6.16-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250715-152307
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250715071658.267-4-ziqianlu%40bytedance.com
patch subject: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
config: i386-buildonly-randconfig-006-20250716 (https://download.01.org/0day-ci/archive/20250716/202507160730.0cXkgs0S-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160730.0cXkgs0S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160730.0cXkgs0S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sched/fair.c:5456:33: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
    5456 |                         cfs_rq->pelt_clock_throttled = 1;
         |                                                      ^ ~
   kernel/sched/fair.c:5971:32: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
    5971 |                 cfs_rq->pelt_clock_throttled = 1;
         |                                              ^ ~
   kernel/sched/fair.c:6014:20: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
    6014 |         cfs_rq->throttled = 1;
         |                           ^ ~
   3 warnings generated.


vim +/int +5456 kernel/sched/fair.c

  5372	
  5373	static bool
  5374	dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  5375	{
  5376		bool sleep = flags & DEQUEUE_SLEEP;
  5377		int action = UPDATE_TG;
  5378	
  5379		update_curr(cfs_rq);
  5380		clear_buddies(cfs_rq, se);
  5381	
  5382		if (flags & DEQUEUE_DELAYED) {
  5383			WARN_ON_ONCE(!se->sched_delayed);
  5384		} else {
  5385			bool delay = sleep;
  5386			/*
  5387			 * DELAY_DEQUEUE relies on spurious wakeups, special task
  5388			 * states must not suffer spurious wakeups, excempt them.
  5389			 */
  5390			if (flags & DEQUEUE_SPECIAL)
  5391				delay = false;
  5392	
  5393			WARN_ON_ONCE(delay && se->sched_delayed);
  5394	
  5395			if (sched_feat(DELAY_DEQUEUE) && delay &&
  5396			    !entity_eligible(cfs_rq, se)) {
  5397				update_load_avg(cfs_rq, se, 0);
  5398				set_delayed(se);
  5399				return false;
  5400			}
  5401		}
  5402	
  5403		if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
  5404			action |= DO_DETACH;
  5405	
  5406		/*
  5407		 * When dequeuing a sched_entity, we must:
  5408		 *   - Update loads to have both entity and cfs_rq synced with now.
  5409		 *   - For group_entity, update its runnable_weight to reflect the new
  5410		 *     h_nr_runnable of its group cfs_rq.
  5411		 *   - Subtract its previous weight from cfs_rq->load.weight.
  5412		 *   - For group entity, update its weight to reflect the new share
  5413		 *     of its group cfs_rq.
  5414		 */
  5415		update_load_avg(cfs_rq, se, action);
  5416		se_update_runnable(se);
  5417	
  5418		update_stats_dequeue_fair(cfs_rq, se, flags);
  5419	
  5420		update_entity_lag(cfs_rq, se);
  5421		if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
  5422			se->deadline -= se->vruntime;
  5423			se->rel_deadline = 1;
  5424		}
  5425	
  5426		if (se != cfs_rq->curr)
  5427			__dequeue_entity(cfs_rq, se);
  5428		se->on_rq = 0;
  5429		account_entity_dequeue(cfs_rq, se);
  5430	
  5431		/* return excess runtime on last dequeue */
  5432		return_cfs_rq_runtime(cfs_rq);
  5433	
  5434		update_cfs_group(se);
  5435	
  5436		/*
  5437		 * Now advance min_vruntime if @se was the entity holding it back,
  5438		 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
  5439		 * put back on, and if we advance min_vruntime, we'll be placed back
  5440		 * further than we started -- i.e. we'll be penalized.
  5441		 */
  5442		if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
  5443			update_min_vruntime(cfs_rq);
  5444	
  5445		if (flags & DEQUEUE_DELAYED)
  5446			finish_delayed_dequeue_entity(se);
  5447	
  5448		if (cfs_rq->nr_queued == 0) {
  5449			update_idle_cfs_rq_clock_pelt(cfs_rq);
  5450	#ifdef CONFIG_CFS_BANDWIDTH
  5451			if (throttled_hierarchy(cfs_rq)) {
  5452				struct rq *rq = rq_of(cfs_rq);
  5453	
  5454				list_del_leaf_cfs_rq(cfs_rq);
  5455				cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> 5456				cfs_rq->pelt_clock_throttled = 1;
  5457			}
  5458	#endif
  5459		}
  5460	
  5461		return true;
  5462	}
  5463	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

