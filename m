Return-Path: <linux-kernel+bounces-807140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA69B4A099
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B169E7AAFCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD822EAB60;
	Tue,  9 Sep 2025 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAi56F4I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471082DECBD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391711; cv=none; b=O1yKdcQaLcYeZMbTOws5qd/gLqy97SuDMbuPMBIDMw9tFQH5neTpdomD9J8UMlAZD6uRqwQhjBV4y/BFtSXkdSprMRx04Eick9eWNFm6WcA9n4AaOULLyPp+h/uDrXFUpfXU68eX6vpTuOZFjrPHeEQryZvjfz2xa1TdQejREuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391711; c=relaxed/simple;
	bh=83IHr3RYi4jPlofVspBny8MARB097YRqh9G1yRx5eX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ae8/2rPOq2FyLdYSE7sQY3ljwON3+lpDkObX2iWQVYDLcA0TWl8fVb8JGXbjXwn4sAjtP1lVE+kkwB+Z0U+o5s8naUKRuY0uzc1dHxZHVKAbcBuITZFyp2EogBCLoW+BnPbFqm+I3YRfclWLFMuId0hWcyjxZfDGXo9jGZ1QcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAi56F4I; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757391710; x=1788927710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83IHr3RYi4jPlofVspBny8MARB097YRqh9G1yRx5eX4=;
  b=nAi56F4I4Patf/Jfe14NIg8pNZzN+DwslvqvhW2WHOmkq+2/hP26IYku
   P5FnMk1Jw7iu48ACuohgrKxGLvdmMCcM2nvHJKKr+6Quxt1YovSBXEe8a
   7eX89BA9wAeMh/8nnc3sFmsdPxLfk4ZF8f5Dm3YxSK6RXut8yyc9muXlm
   H/rjGkZHfE0xJERBbR2q4+D/TDxZsPf7ELlXn8u7+AYefNAa2olUoToPY
   t7psQGI/7BeIG5OO99iTxedcUZMhrlDECdffRvXvwE11/DL5km64a57Qr
   J1+NzXTrMgIHnW+RG5C3hrXXhT44IDyzCpAiDj/wRuUPd+oQ0ipwg/pM7
   A==;
X-CSE-ConnectionGUID: Sfosq+CKRqqJSPQi0aXohA==
X-CSE-MsgGUID: h78H/5SSQ7+EZcuSEHoH0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77121688"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="77121688"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 21:21:50 -0700
X-CSE-ConnectionGUID: Uq5mxd13TXORJYj/8nHSMg==
X-CSE-MsgGUID: 5oENLADEQTCYVfwD75VJLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="172240800"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Sep 2025 21:21:44 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvprR-0004Qd-1X;
	Tue, 09 Sep 2025 04:21:41 +0000
Date: Tue, 9 Sep 2025 12:20:47 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Lu <ziqianlu@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Propagate load for throttled cfs_rq
Message-ID: <202509091233.f6nP3BVh-lkp@intel.com>
References: <20250908110548.GA35@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908110548.GA35@bytedance>

Hi Aaron,

kernel test robot noticed the following build errors:



url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20250908-190724/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250829-161501
base:   the 3th patch of https://lore.kernel.org/r/20250829081120.806-4-ziqianlu%40bytedance.com
patch link:    https://lore.kernel.org/r/20250908110548.GA35%40bytedance
patch subject: [PATCH] sched/fair: Propagate load for throttled cfs_rq
config: i386-buildonly-randconfig-001-20250909 (https://download.01.org/0day-ci/archive/20250909/202509091233.f6nP3BVh-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509091233.f6nP3BVh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509091233.f6nP3BVh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/fair.c:6747:1: error: expected identifier or '(' before '+' token
    6747 | +static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
         | ^


vim +6747 kernel/sched/fair.c

  6746	
> 6747	+static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
  6748	{
  6749		return false;
  6750	}
  6751	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

