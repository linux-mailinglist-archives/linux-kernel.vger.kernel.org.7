Return-Path: <linux-kernel+bounces-889842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3ADC3EA8F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1AA3A7614
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC993043BE;
	Fri,  7 Nov 2025 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSslV2mQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0DF304BA0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498491; cv=none; b=FQQEuxz4Se5IPt2imKluen3nG4UQ75HISkAFk39m2OzqG/qceKn9OBDizC6mbiBUupbbz8DQFUYEBEQCrnU2Vnh5Rdurlr21OW+zJgmte0A47jV1Adk02op5hbiok73xbb9E1Mg99pSQ28EnsrZhhEj9gqUIkdxDTax7G4lvmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498491; c=relaxed/simple;
	bh=sXyhTXDs909Z1OaZ582MkGIoqUjb2geKPygIS8L9w5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqBsHdxkzZflLuZ3cyk8d9h6lf+KXJZaa5KUYO61FNf3/B8fpElS1kLMWfjxIuKpaHszfXJdJvjxkgi4xXkcCv4S5ahFDer7+vwnxGiGtXgdP93k+vk27BQVvd3oyi80p5rpCChQh6tfbiqUQY0Tj1mhsSdSBTC+TbnZMOZZN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSslV2mQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762498489; x=1794034489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sXyhTXDs909Z1OaZ582MkGIoqUjb2geKPygIS8L9w5M=;
  b=ZSslV2mQ5gofeJgXviDTVq/W3eggB7xCGftam2TVGPQCJISc6G0TJGL3
   oWsbuNAyY/A6AoGhBJeApLi0A425E65ou+cy7+mSJWGS7YFzZkel4XMjc
   KiBwX94xL9uqxsLzdZ5x1kriPElQB0VHKkS4xfVurpk/6YUexL5vFpVn2
   dPNQjfYdsm4PWLTGoe44mL/5x6AWs/CAAYTBRLK54CyZyIcAYaMkQUP2j
   il6nU1Be9Ka0u6drtvXAxGEufjuNuBZb/KCaPUbZqJgguk1kkNN2RwiZI
   wXMgR8peKONxNg9UdWyBx8LkgTeFF8oEp4jqXZd5CnGBOp5K3TloWJSl0
   g==;
X-CSE-ConnectionGUID: g9nB78X2Qva8JuNw7m9PbQ==
X-CSE-MsgGUID: dq1jWOp5RAKldO5u6t4ifQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64562453"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="64562453"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 22:54:47 -0800
X-CSE-ConnectionGUID: qCXu+G4TTie8yGYCXuV+sQ==
X-CSE-MsgGUID: zmMYzrAYRzKAHZveSobs/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="188132550"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Nov 2025 22:54:44 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHGMr-000Uoe-1G;
	Fri, 07 Nov 2025 06:54:41 +0000
Date: Fri, 7 Nov 2025 14:54:22 +0800
From: kernel test robot <lkp@intel.com>
To: Fernand Sieber <sieberf@amazon.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	dwmw@amazon.co.uk, jschoenh@amazon.de, liuyuxua@amazon.com
Subject: Re: [PATCH] sched: Proxy yields to donor tasks
Message-ID: <202511071431.9PLsHNo5-lkp@intel.com>
References: <20251106104022.195157-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106104022.195157-1-sieberf@amazon.com>

Hi Fernand,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.18-rc4 next-20251107]
[cannot apply to peterz-queue/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fernand-Sieber/sched-Proxy-yields-to-donor-tasks/20251106-184337
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20251106104022.195157-1-sieberf%40amazon.com
patch subject: [PATCH] sched: Proxy yields to donor tasks
config: arm64-randconfig-r131-20251107 (https://download.01.org/0day-ci/archive/20251107/202511071431.9PLsHNo5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511071431.9PLsHNo5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511071431.9PLsHNo5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/fair.c:1167:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *running @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:1167:49: sparse:     expected struct task_struct *running
   kernel/sched/fair.c:1167:49: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:1201:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_entity *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:1201:33: sparse:     expected struct sched_entity *se
   kernel/sched/fair.c:1201:33: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:1259:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity const *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:1259:34: sparse:     expected struct sched_entity const *se
   kernel/sched/fair.c:1259:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:12848:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:12848:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:12848:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7012:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7012:58: sparse:     expected struct task_struct *p
   kernel/sched/fair.c:7012:58: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:6072:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:6072:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:6072:22: sparse:    struct task_struct *
   kernel/sched/fair.c:8397:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:8397:20: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:8397:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:8601:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:8601:9: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:8601:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:8734:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/fair.c:8734:39: sparse:     expected struct task_struct *donor
   kernel/sched/fair.c:8734:39: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/fair.c:8766:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:8766:37: sparse:     expected struct task_struct *tsk
   kernel/sched/fair.c:8766:37: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/fair.c:8983:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/fair.c:8983:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:8983:38: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/fair.c:10020:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:10020:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair.c:10020:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:10648:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:10648:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:10648:22: sparse:    struct task_struct *
   kernel/sched/fair.c:12093:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:12093:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:12093:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:11743:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:11743:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair.c:11743:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:12208:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:12208:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:12208:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2292:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2625:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2625:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2625:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2292:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2281:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2292:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2292:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2292:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct *
--
   kernel/sched/rt.c:976:39: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/rt.c:1493:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/rt.c:1493:31: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1493:31: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/rt.c:1809:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/rt.c:1809:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/rt.c:1809:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/rt.c:1512:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/rt.c:1512:14: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:1512:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:1513:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/rt.c:1513:15: sparse:     expected struct task_struct *donor
   kernel/sched/rt.c:1513:15: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:1574:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/rt.c:1574:45: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1574:45: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/rt.c:1616:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/rt.c:1616:39: sparse:     expected struct task_struct *donor
   kernel/sched/rt.c:1616:39: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/rt.c:1635:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1635:64: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:1635:64: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1976:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1976:40: sparse:     expected struct task_struct *task
   kernel/sched/rt.c:1976:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1999:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:1999:13: sparse:    struct task_struct *
   kernel/sched/rt.c:1999:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2345:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2345:54: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:2345:54: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2347:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/rt.c:2347:40: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2347:40: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/rt.c:2347:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/rt.c:2347:62: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2347:62: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/deadline.c:2677:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:2677:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2677:23: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:2687:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2687:13: sparse:    struct task_struct *
   kernel/sched/deadline.c:2687:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2793:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2793:25: sparse:    struct task_struct *
   kernel/sched/deadline.c:2793:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2295:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2295:42: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2295:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:2305:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2305:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2305:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1194:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1194:39: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1194:39: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1194:85: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1194:85: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:1194:85: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1292:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:1292:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1292:23: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:1590:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1590:31: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1590:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1590:70: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1590:70: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:1590:70: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1703:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:1703:39: sparse:     expected struct task_struct *donor
   kernel/sched/deadline.c:1703:39: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:2513:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/deadline.c:2513:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/deadline.c:2513:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/deadline.c:2181:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/deadline.c:2181:14: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:2181:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2182:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/deadline.c:2182:15: sparse:     expected struct task_struct *donor
   kernel/sched/deadline.c:2182:15: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2257:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:2257:43: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2257:43: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:2838:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2838:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2838:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2840:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/deadline.c:2840:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2840:23: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/deadline.c:2842:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2842:44: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2842:44: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:3036:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:3036:23: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:3036:23: sparse:    struct task_struct *
   kernel/sched/deadline.c:3083:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:185:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/syscalls.c:185:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/syscalls.c:185:22: sparse:    struct task_struct *
>> kernel/sched/syscalls.c:1397:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/syscalls.c:1397:22: sparse:     expected struct task_struct *curr
   kernel/sched/syscalls.c:1397:22: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2281:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2281:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2292:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2281:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2292:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2281:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2281:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2281:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2292:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2292:26: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:1257:6: sparse: sparse: context imbalance in 'sched_getaffinity' - wrong count at exit
   kernel/sched/syscalls.c:1322:11: sparse: sparse: dereference of noderef expression
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:1659:15: sparse: sparse: dereference of noderef expression

vim +8983 kernel/sched/fair.c

  8977	
  8978	/*
  8979	 * sched_yield() is very simple
  8980	 */
  8981	static void yield_task_fair(struct rq *rq)
  8982	{
> 8983		struct task_struct *curr = rq->donor;
  8984		struct cfs_rq *cfs_rq = task_cfs_rq(curr);
  8985		struct sched_entity *se = &curr->se;
  8986	
  8987		/*
  8988		 * Are we the only task in the tree?
  8989		 */
  8990		if (unlikely(rq->nr_running == 1))
  8991			return;
  8992	
  8993		clear_buddies(cfs_rq, se);
  8994	
  8995		update_rq_clock(rq);
  8996		/*
  8997		 * Update run-time statistics of the 'current'.
  8998		 */
  8999		update_curr(cfs_rq);
  9000		/*
  9001		 * Tell update_rq_clock() that we've just updated,
  9002		 * so we don't do microscopic update in schedule()
  9003		 * and double the fastpath cost.
  9004		 */
  9005		rq_clock_skip_update(rq);
  9006	
  9007		/*
  9008		 * Forfeit the remaining vruntime, only if the entity is eligible. This
  9009		 * condition is necessary because in core scheduling we prefer to run
  9010		 * ineligible tasks rather than force idling. If this happens we may
  9011		 * end up in a loop where the core scheduler picks the yielding task,
  9012		 * which yields immediately again; without the condition the vruntime
  9013		 * ends up quickly running away.
  9014		 */
  9015		if (entity_eligible(cfs_rq, se)) {
  9016			se->vruntime = se->deadline;
  9017			se->deadline += calc_delta_fair(se->slice, se);
  9018			update_min_vruntime(cfs_rq);
  9019		}
  9020	}
  9021	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

