Return-Path: <linux-kernel+bounces-895498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F766C4E1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0563F4E492A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEBE33ADA4;
	Tue, 11 Nov 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htConICG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE132C938
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867660; cv=none; b=Vu5WkAAXCW96+mOGBW4G70reR6asZ/QiQt1qixk2VqMYh/u2E4NEQYcTPS/8iyqqPDhsKgdyd5bRPIuFgmoHCabOZ237twghlayx9qu2W/SMnJodYNIoh9qv+tGnj6JWXXp6RuEGC0+KEI+3AG/hQEmv71mVDfWYwhWGwuUi0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867660; c=relaxed/simple;
	bh=Ht/Y+Soaw1mchZVRGdUu4N+yatiVD3fzeKp6v9AIAuM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LoOUMfgo4+YN/0qW42Iym1T4QtX37XDeEdCI1r6VqPkY3j8PgyDJPJglpc2eyz0BRTAaDoPARqIyM+7iv78ZT415+TDO96RMtXeIACsgW3fYp7pVD8gLOzXBhzPoOvn0+HL4qt5V9GezhSRvWiWqK8MQO4iZ9Lhu0LYUl+MHD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htConICG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762867660; x=1794403660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ht/Y+Soaw1mchZVRGdUu4N+yatiVD3fzeKp6v9AIAuM=;
  b=htConICG+UbSJz5RyN1KfA3YmOwoAUnB4BlhNxZFBQgQFKzk1hiBMAA/
   UV24ChLi0Rx/rTc/i+84s6kE0QPiWEci7BN4A8SlvwLH3j3WEfsT3roZi
   +Pf1mEmU4kyAKW5caONgwS6VzIwddv6FER/M2dYj9sSBC5M1f7/VpjWAd
   k0yzNx/V3d/FsEkS19X/e8oflfcdtNjrVqNHUqNPlye4aQP8P0PULndSW
   4s9X+IUwz+zYyrW/ipEvUapU6FvLbv9M/FluWEycZLiHmUMxcMMPLJsvD
   mObyxyPkCKeHHxG7maT3+invbnnvQy6JlrJ7dTWciRvwu1Fmrz5IMeg/Y
   A==;
X-CSE-ConnectionGUID: 1nUQ+GttQnm/uzrP5h5pfw==
X-CSE-MsgGUID: GyjX+fvXQGC73fzFGvRYmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64845530"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64845530"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 05:27:38 -0800
X-CSE-ConnectionGUID: Qg+HXBESSNakccD5spfX4Q==
X-CSE-MsgGUID: cfFipR7DQ9m4F1Mn7Xpj7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="219613805"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Nov 2025 05:27:36 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIoPF-0003Az-1k;
	Tue, 11 Nov 2025 13:27:33 +0000
Date: Tue, 11 Nov 2025 21:27:12 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [tip:sched/core 8/10] kernel/sched/deadline.c:1441:16: error: use of
 undeclared identifier 'd_se'; did you mean 'dl_se'?
Message-ID: <202511112120.vStICnyl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   46f61fb2e7678daae743d601efac3b957041ed56
commit: b75a19b9d73e0deb5f761884228b8b15694e2858 [8/10] sched/deadline: Document dl_server
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20251111/202511112120.vStICnyl-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 996639d6ebb86ff15a8c99b67f1c2e2117636ae7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511112120.vStICnyl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511112120.vStICnyl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:58:
>> kernel/sched/deadline.c:1441:16: error: use of undeclared identifier 'd_se'; did you mean 'dl_se'?
    1441 |         if (dl_server(d_se) && dl_se->dl_throttled && !dl_se->dl_defer)
         |                       ^~~~
         |                       dl_se
   kernel/sched/deadline.c:1430:70: note: 'dl_se' declared here
    1430 | static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
         |                                                                      ^
   1 error generated.


vim +1441 kernel/sched/deadline.c

  1429	
  1430	static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
  1431	{
  1432		bool idle = rq->curr == rq->idle;
  1433		s64 scaled_delta_exec;
  1434	
  1435		if (unlikely(delta_exec <= 0)) {
  1436			if (unlikely(dl_se->dl_yielded))
  1437				goto throttle;
  1438			return;
  1439		}
  1440	
> 1441		if (dl_server(d_se) && dl_se->dl_throttled && !dl_se->dl_defer)
  1442			return;
  1443	
  1444		if (dl_entity_is_special(dl_se))
  1445			return;
  1446	
  1447		scaled_delta_exec = delta_exec;
  1448		if (!dl_server(dl_se))
  1449			scaled_delta_exec = dl_scaled_delta_exec(rq, dl_se, delta_exec);
  1450	
  1451		dl_se->runtime -= scaled_delta_exec;
  1452	
  1453		if (dl_se->dl_defer_idle && !idle)
  1454			dl_se->dl_defer_idle = 0;
  1455	
  1456		/*
  1457		 * The fair server can consume its runtime while throttled (not queued/
  1458		 * running as regular CFS).
  1459		 *
  1460		 * If the server consumes its entire runtime in this state. The server
  1461		 * is not required for the current period. Thus, reset the server by
  1462		 * starting a new period, pushing the activation.
  1463		 */
  1464		if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
  1465			/*
  1466			 * Non-servers would never get time accounted while throttled.
  1467			 */
  1468			WARN_ON_ONCE(!dl_server(dl_se));
  1469	
  1470			/*
  1471			 * While the server is marked idle, do not push out the
  1472			 * activation further, instead wait for the period timer
  1473			 * to lapse and stop the server.
  1474			 */
  1475			if (dl_se->dl_defer_idle && idle) {
  1476				/*
  1477				 * The timer is at the zero-laxity point, this means
  1478				 * dl_server_stop() / dl_server_start() can happen
  1479				 * while now < deadline. This means update_dl_entity()
  1480				 * will not replenish. Additionally start_dl_timer()
  1481				 * will be set for 'deadline - runtime'. Negative
  1482				 * runtime will not do.
  1483				 */
  1484				dl_se->runtime = 0;
  1485				return;
  1486			}
  1487	
  1488			/*
  1489			 * If the server was previously activated - the starving condition
  1490			 * took place, it this point it went away because the fair scheduler
  1491			 * was able to get runtime in background. So return to the initial
  1492			 * state.
  1493			 */
  1494			dl_se->dl_defer_running = 0;
  1495	
  1496			hrtimer_try_to_cancel(&dl_se->dl_timer);
  1497	
  1498			replenish_dl_new_period(dl_se, dl_se->rq);
  1499	
  1500			if (idle)
  1501				dl_se->dl_defer_idle = 1;
  1502	
  1503			/*
  1504			 * Not being able to start the timer seems problematic. If it could not
  1505			 * be started for whatever reason, we need to "unthrottle" the DL server
  1506			 * and queue right away. Otherwise nothing might queue it. That's similar
  1507			 * to what enqueue_dl_entity() does on start_dl_timer==0. For now, just warn.
  1508			 */
  1509			WARN_ON_ONCE(!start_dl_timer(dl_se));
  1510	
  1511			return;
  1512		}
  1513	
  1514	throttle:
  1515		if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
  1516			dl_se->dl_throttled = 1;
  1517	
  1518			/* If requested, inform the user about runtime overruns. */
  1519			if (dl_runtime_exceeded(dl_se) &&
  1520			    (dl_se->flags & SCHED_FLAG_DL_OVERRUN))
  1521				dl_se->dl_overrun = 1;
  1522	
  1523			dequeue_dl_entity(dl_se, 0);
  1524			if (!dl_server(dl_se)) {
  1525				update_stats_dequeue_dl(&rq->dl, dl_se, 0);
  1526				dequeue_pushable_dl_task(rq, dl_task_of(dl_se));
  1527			}
  1528	
  1529			if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se))) {
  1530				if (dl_server(dl_se)) {
  1531					replenish_dl_new_period(dl_se, rq);
  1532					start_dl_timer(dl_se);
  1533				} else {
  1534					enqueue_task_dl(rq, dl_task_of(dl_se), ENQUEUE_REPLENISH);
  1535				}
  1536			}
  1537	
  1538			if (!is_leftmost(dl_se, &rq->dl))
  1539				resched_curr(rq);
  1540		}
  1541	
  1542		/*
  1543		 * The fair server (sole dl_server) does not account for real-time
  1544		 * workload because it is running fair work.
  1545		 */
  1546		if (dl_se == &rq->fair_server)
  1547			return;
  1548	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

