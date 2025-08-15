Return-Path: <linux-kernel+bounces-770941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF0B280B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391851CE281E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77B302775;
	Fri, 15 Aug 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdDc8q3o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7FE3019AD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265081; cv=none; b=E/mRX1Stk9WGwlOdh4Utbbz0n3VU46eKjt/zmd5/ZHvwAlrSw4QIR+V2HCKeQZ869K1wLnJBNvLsZQAPX0myNQ6Kyji/tHs7PP2sMmzh0CzAgLkaArm9O+vkjwyx3705deQdI0qCMcsD9opQSgWQ2TWF0L6IPGDxY/j/BM7N5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265081; c=relaxed/simple;
	bh=m8hv0RZV9Mr6fM2+lzlOFczAMuNvVzSER5/ae08maD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXFBX+2cdq9jQe/EvglX+ofuKaHUI6IiHl/k+lAOyqpLLGIurqyyejGbJP4/1+G10XO9bYVkBrXjJk1GMFSAJlS9I3rrdpp6NPBc5AJC2yZThaQfmZO/nCtniRomxFoacq42RZRCDewd1lEZxhG0i3/EKw6NS8mXBLHX7joRRuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdDc8q3o; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755265080; x=1786801080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m8hv0RZV9Mr6fM2+lzlOFczAMuNvVzSER5/ae08maD0=;
  b=NdDc8q3oy0eDiQMQc+y+ltkU4P47OJNj4fvoTm47t9SVDK+cOvy6w4a7
   cx3Pe/sAUuEs60YYyhpja8JKJiYWCp6OOf11VOdXlAsQQVl4GnDIdteKx
   YO6do5OzD58pmasdzvqnGHoNsvrmNE1+QzXEwwpMrTMG8fRZtNFiHsK+D
   6HA4wnTgxx1J6cqwTmPSYJyUcLzWHYLlzxwksPHok4SIj9kK3cGz+WBPo
   dSFFGTeEp6OZSPFE/D56Wevx1pPx/FRhcIj4uOYdf9Rmq9PNb34kLRGDj
   mZgGeNjICfhzKDi2tAf5vA/m8LbUAtYgOk1ADraXP8JGNLaVdGwkjTaWe
   Q==;
X-CSE-ConnectionGUID: gP+BGY6YT565fZMvwsel3g==
X-CSE-MsgGUID: vekNCIemToGmOFeLpXQjIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57446396"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57446396"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 06:37:56 -0700
X-CSE-ConnectionGUID: IT/YsOgCQruB9ihR5M9s8g==
X-CSE-MsgGUID: nCHOfA5MQUqHXyHV6YakUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="204196499"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 15 Aug 2025 06:37:53 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umuco-000BzQ-2i;
	Fri, 15 Aug 2025 13:37:45 +0000
Date: Fri, 15 Aug 2025 21:37:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org
Cc: oe-kbuild-all@lists.linux.dev, tzungbi@kernel.org, dawidn@google.com,
	chrome-platform@lists.linux.dev, akpm@linux-foundation.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] platform/chrome: Protect cros_ec_device lifecycle
 with ref_proxy
Message-ID: <202508152116.hQq8Sw2Y-lkp@intel.com>
References: <20250814091020.1302888-3-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814091020.1302888-3-tzungbi@kernel.org>

Hi Tzung-Bi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on chrome-platform/for-next]
[also build test WARNING on chrome-platform/for-firmware-next akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tzung-Bi-Shih/lib-Add-ref_proxy-module/20250814-172126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20250814091020.1302888-3-tzungbi%40kernel.org
patch subject: [PATCH 2/3] platform/chrome: Protect cros_ec_device lifecycle with ref_proxy
config: sparc64-randconfig-r113-20250815 (https://download.01.org/0day-ci/archive/20250815/202508152116.hQq8Sw2Y-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce: (https://download.01.org/0day-ci/archive/20250815/202508152116.hQq8Sw2Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508152116.hQq8Sw2Y-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/ref_proxy.c:167:16: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __rcu * @@     got void * @@
   lib/ref_proxy.c:167:16: sparse:     expected void [noderef] __rcu *
   lib/ref_proxy.c:167:16: sparse:     got void *
   lib/ref_proxy.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, ...):
   include/linux/srcu.h:373:9: sparse: sparse: context imbalance in 'ref_proxy_put' - unexpected unlock

vim +167 lib/ref_proxy.c

f2304a9508b177 Tzung-Bi Shih 2025-08-14  152  
f2304a9508b177 Tzung-Bi Shih 2025-08-14  153  /**
f2304a9508b177 Tzung-Bi Shih 2025-08-14  154   * ref_proxy_get() - Get the resource.
f2304a9508b177 Tzung-Bi Shih 2025-08-14  155   * @proxy: The pointer of struct ref_proxy.
f2304a9508b177 Tzung-Bi Shih 2025-08-14  156   *
f2304a9508b177 Tzung-Bi Shih 2025-08-14  157   * This tries to de-reference to the resource and enters a RCU critical
f2304a9508b177 Tzung-Bi Shih 2025-08-14  158   * section.
f2304a9508b177 Tzung-Bi Shih 2025-08-14  159   *
f2304a9508b177 Tzung-Bi Shih 2025-08-14  160   * Return: The pointer to the resource.  NULL if the resource has gone.
f2304a9508b177 Tzung-Bi Shih 2025-08-14  161   */
f2304a9508b177 Tzung-Bi Shih 2025-08-14  162  void __rcu *ref_proxy_get(struct ref_proxy *proxy)
f2304a9508b177 Tzung-Bi Shih 2025-08-14  163  {
f2304a9508b177 Tzung-Bi Shih 2025-08-14  164  	struct ref_proxy_provider *rpp = proxy->rpp;
f2304a9508b177 Tzung-Bi Shih 2025-08-14  165  
f2304a9508b177 Tzung-Bi Shih 2025-08-14  166  	proxy->idx = srcu_read_lock(&rpp->srcu);
f2304a9508b177 Tzung-Bi Shih 2025-08-14 @167  	return rcu_dereference(rpp->ref);
f2304a9508b177 Tzung-Bi Shih 2025-08-14  168  }
f2304a9508b177 Tzung-Bi Shih 2025-08-14  169  EXPORT_SYMBOL(ref_proxy_get);
f2304a9508b177 Tzung-Bi Shih 2025-08-14  170  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

