Return-Path: <linux-kernel+bounces-760704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074DDB1EF15
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79BD3BFBDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42353288C0E;
	Fri,  8 Aug 2025 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHsU9K4k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6811A2872
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683086; cv=none; b=FJr9wnNTRYXDoYrmahNlabr4H5narvYWfar7/90gqcmVw8Ty2oUJVRdPJOuq+yj5BgbZS92uxDqOF7IA1nj/wVwSlcf2H1PhnEpzrbzQOvE882jxH/JpmHgpB1kj/3m2+kwhFlJNfVW2zoM8c79vpWeC1hXau7X4LIxqdlJTHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683086; c=relaxed/simple;
	bh=gd1V3Bog12d4SHv2HJE8iLAMYyEHSd4z4qVqxlM5ogs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SuZ2fqDPdDVee8bimW9LrEqQq193LcyQBRYkBfroiBX7oAd9Yw5mOT1Aa1CMDEMhSu/RMq6fDmOUQwM52p3tLo895ent3DuWu8IqYsVUXRpWjtaqfLlRp54301X3MkD2v7pvqyIBRgUrWz/AAhxIxmVwkFEHdzUeh/7oTRnqlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHsU9K4k; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754683085; x=1786219085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gd1V3Bog12d4SHv2HJE8iLAMYyEHSd4z4qVqxlM5ogs=;
  b=iHsU9K4kRorvug0lzz9o7TlUwe4Xxf5UaoZ3xCSaKtgQ8P4qm5AXq82m
   iiu3tIqwNOPhRARUuLvONDuOQvgwlL96QvjggRGcBbAYeePhs8Z6wHiRJ
   SISAuAgAA8Q0A4VHwyUzrRpdWKVB8XMzs69xuJ3pb6FKiO5QTlXzDVkY+
   Ovz5XlC6v4cjkL8d2oGJx9PONUF42XU2KEprAz+DaPVOXwjT4fHk+jj+H
   nfTqdj8kRPRUfs84NUdJm5tDkkz2Y6SFtyP8mHivT+7O9RvHQrY4w2TW8
   mpoeTE0WG0EipHZXxoLRrwDO0NnQF8VgY/WEZLK6YCoTCiV1vvBW4lT+7
   Q==;
X-CSE-ConnectionGUID: 0/nqrP2STdyi71iVAflFcA==
X-CSE-MsgGUID: Hh8+Y2U+RZKA2pMp1KHXtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="44628795"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="44628795"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 12:58:04 -0700
X-CSE-ConnectionGUID: McklBkykTRSTgeKHXUO1zw==
X-CSE-MsgGUID: 9m+LhC33R22Wa0Jkv9WS5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="164635959"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 08 Aug 2025 12:58:03 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukTE0-0004G8-2y;
	Fri, 08 Aug 2025 19:58:00 +0000
Date: Sat, 9 Aug 2025 03:57:38 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: kernel/sched/core.c:9284:38: error: no member named 'scx_weight' in
 'struct task_group'
Message-ID: <202508090359.TkVIk759-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tejun,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   37816488247ddddbc3de113c78c83572274b1e2e
commit: 6e6558a6bc418f1478c5dc8609d03805364e0cb9 sched_ext, sched/core: Factor out struct scx_task_group
date:   7 weeks ago
config: arm64-randconfig-004-20250809 (https://download.01.org/0day-ci/archive/20250809/202508090359.TkVIk759-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250809/202508090359.TkVIk759-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508090359.TkVIk759-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/core.c:9284:38: error: no member named 'scx_weight' in 'struct task_group'
    9284 |         return sched_weight_from_cgroup(tg->scx_weight);
         |                                         ~~  ^
   1 error generated.


vim +9284 kernel/sched/core.c

2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  9277  
e179e80c5d4fef kernel/sched/core.c Tejun Heo       2024-09-04  9278  #ifdef CONFIG_GROUP_SCHED_WEIGHT
41082c1d1d2bf6 kernel/sched/core.c Tejun Heo       2024-09-04  9279  static unsigned long tg_weight(struct task_group *tg)
41082c1d1d2bf6 kernel/sched/core.c Tejun Heo       2024-09-04  9280  {
052f1dc7eb0230 kernel/sched.c      Peter Zijlstra  2008-02-13  9281  #ifdef CONFIG_FAIR_GROUP_SCHED
41082c1d1d2bf6 kernel/sched/core.c Tejun Heo       2024-09-04  9282  	return scale_load_down(tg->shares);
8195136669661f kernel/sched/core.c Tejun Heo       2024-09-04  9283  #else
8195136669661f kernel/sched/core.c Tejun Heo       2024-09-04 @9284  	return sched_weight_from_cgroup(tg->scx_weight);
8195136669661f kernel/sched/core.c Tejun Heo       2024-09-04  9285  #endif
41082c1d1d2bf6 kernel/sched/core.c Tejun Heo       2024-09-04  9286  }
41082c1d1d2bf6 kernel/sched/core.c Tejun Heo       2024-09-04  9287  

:::::: The code at line 9284 was first introduced by commit
:::::: 8195136669661fdfe54e9a8923c33b31c92fc1da sched_ext: Add cgroup support

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

