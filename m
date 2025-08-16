Return-Path: <linux-kernel+bounces-772295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA066B290F4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 01:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92794AC399A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 23:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6DC244675;
	Sat, 16 Aug 2025 23:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JN/m3C16"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFF288DA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755386467; cv=none; b=kFNIoy/Gt3a5yN7RUPKffis+PSsYn2BJVLQaL3n0RGxvhgCyIfw0wGgZbtqVqzY7ooL0KsxI8YbwXdveW6VfhnvRXB+UBhhLvG3MtfEqsxDkCK330zVWE2PPnGdvPct4RocgUl/lnc90kMhtsRBLowGhns/Kmv2MVtqwW2JJuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755386467; c=relaxed/simple;
	bh=DU2j/wqwniXJo+tFk1WY/PI+bO2fLqK+tuOtYEl8Bd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGuCMkeQgty5MubIOYcKCef4cCr63tX5FkBc3PMZNchNISLfTsLdXmlQ4hVaMsbjiZCVUQampFjGFQPhTO3B8h1Mig+aFHg0nMByNoBkWA+vNBtIuvnfdWVjR6L4/oS6a/8YxAAyOz27Ob2qsk3U7HPYcjCSkK5S6KgEE7FoH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JN/m3C16; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755386465; x=1786922465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DU2j/wqwniXJo+tFk1WY/PI+bO2fLqK+tuOtYEl8Bd8=;
  b=JN/m3C16BvU73yxMNgBMGFrzztnCiXzsNOeSfoAJP+4XXJDJMy8CF6T7
   XDBCAvQS0J8JMm4tETF74cIUyT+2+7SXf2iud8iqd3L7/2X/VsllngVqC
   lsEjHvSr0QcpqSIXWaBmAoOfhx8dIT8aoXDH0j+IrRztiyGyIl+lSytSI
   0ZEHIc/1EJLLI1oR59XRvV7FLxzf16e3fh9ffhVwuEO30+Zm5j5Y2VG65
   u7j85lPrxpH40asQOWtMQKqmVk9+Yu0sPCgjESRetjPMiDxR1vUMTtSl6
   E/dl/kGx3huyGJBLHh+ZjZo5IuctFCdTVpvRwh/dgSxfoAz+2TzHe8VxP
   g==;
X-CSE-ConnectionGUID: zq1QE+P9QOSq79pSH+yjAA==
X-CSE-MsgGUID: atfQ4FFXQo6XTFI3Wn/TTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="80239198"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="80239198"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 16:21:05 -0700
X-CSE-ConnectionGUID: bK+l1/lpQNCtgImcYn8wTw==
X-CSE-MsgGUID: ALcV1ipHTfKX9J0E+jAdbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="172491159"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 16 Aug 2025 16:21:03 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unQCh-000DGH-1x;
	Sat, 16 Aug 2025 23:20:55 +0000
Date: Sun, 17 Aug 2025 07:19:47 +0800
From: kernel test robot <lkp@intel.com>
To: Clint George <clintbgeorge@gmail.com>, skhan@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Clint George <clintbgeorge@gmail.com>
Subject: Re: [PATCH] Fixed Spelling in cpufreq module in kselftests. Earlier
 it used to be "loops", now i made it "loop(s)"
Message-ID: <202508170740.9el3nJS7-lkp@intel.com>
References: <20250816124036.5786-1-clintbgeorge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816124036.5786-1-clintbgeorge@gmail.com>

Hi Clint,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Clint-George/Fixed-Spelling-in-cpufreq-module-in-kselftests-Earlier-it-used-to-be-loops-now-i-made-it-loop-s/20250816-204247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250816124036.5786-1-clintbgeorge%40gmail.com
patch subject: [PATCH] Fixed Spelling in cpufreq module in kselftests. Earlier it used to be "loops", now i made it "loop(s)"
config: arm-randconfig-002-20250817 (https://download.01.org/0day-ci/archive/20250817/202508170740.9el3nJS7-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250817/202508170740.9el3nJS7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508170740.9el3nJS7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> tools/testing/selftests/cpufreq/cpufreq_selftest.txt: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

