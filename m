Return-Path: <linux-kernel+bounces-870483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49766C0AE9C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094BB3B4CB0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ADC253956;
	Sun, 26 Oct 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpizrsNM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB925392A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761499433; cv=none; b=V30G5pKQp4T7MThB5GFbTd9CctlXBEfidi794OO1tGFK0xizxLoGXU/YHlFtWhVJnoT6AJ0abaexJCCu/KZWHvCCFPh2Klnf1m+xLkkXRhzNbIa6bm50UmpGxcL45dLDLCvDxyyCVr9h5YdjxYxhnfXlTcmutn+Fy5hB9BXkq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761499433; c=relaxed/simple;
	bh=bvz8lnfc3noMJCk7Wsp2unB1vfyH6zZDWek12vHY+IA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZUziej0Q/xv48Os9kGspz1/m4e2wghz6sKgHm2oufEID21J8/isWh4GuFa4Axjyint6SZS95UdqJrPESx/JMrCIPtNUsBveuDQ+MzTIFm8jDepsds+qMKBC2o0UmavMlT7HAu/FLvSoeqjKrn64YQUbz9K5mwizdZtX1wqkcL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpizrsNM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761499431; x=1793035431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bvz8lnfc3noMJCk7Wsp2unB1vfyH6zZDWek12vHY+IA=;
  b=cpizrsNMNTMM3bSCsgkUKchWtQSdZjNcZ4mrIHPL+iDJ+54jd5x6cvuP
   HvA5bj6+pot8cbh54+t0ZiNOTEUmw+DyU3cjPnxocHwJyxHs5orsyq78Q
   IhOlDRQSWhPndk4ub9pQx6SqvnpxiSCWaoPON/+o4bRtB/RyCijXg0/uE
   jsdSaMMiaIchvw/GIU7fuUL4wkr4Z10S+1R9eQTOhSEXiHfkE0LktiT7s
   ZVZzybf1gXxWC1mEuBkfX849D22GACgxU5LoPFT1Q205Ja1GUvvuDHy1Q
   diespDnI1258jW8fiBWefLYLScYQk04KAy1WuDUewidl8yYqTv0a3Dhrm
   w==;
X-CSE-ConnectionGUID: iA4zS0ApQh+wydxn7kuRXQ==
X-CSE-MsgGUID: ClXswyq8R3C34XyWSemMvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63499940"
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="63499940"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 10:23:51 -0700
X-CSE-ConnectionGUID: 6xkbmguqSfKyY/vFU2Blhg==
X-CSE-MsgGUID: OMMhGDWwRpWb1idpJCzh4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="184472974"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Oct 2025 10:23:49 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vD4T4-000GG5-2J;
	Sun, 26 Oct 2025 17:23:46 +0000
Date: Mon, 27 Oct 2025 01:23:21 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: kernel/cpu.c:2681:9: error: call to undeclared function
 'cpu_down_maps_locked'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202510270120.21wA1aX1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72761a7e31225971d0b29d9195e0ffa986b77867
commit: 76c43eb507bc1162850fdae6cc44790d1c9a83ea MIPS: SMP: Implement parallel CPU bring up for EyeQ
date:   6 months ago
config: mips-randconfig-r122-20251026 (https://download.01.org/0day-ci/archive/20251027/202510270120.21wA1aX1-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project e1ae12640102fd2b05bc567243580f90acb1135f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510270120.21wA1aX1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510270120.21wA1aX1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/cpu.c:2681:9: error: call to undeclared function 'cpu_down_maps_locked'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2681 |                 ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
         |                       ^
   1 error generated.


vim +/cpu_down_maps_locked +2681 kernel/cpu.c

dc8d37ed304eee Arnd Bergmann    2019-12-10  2666  
dc8d37ed304eee Arnd Bergmann    2019-12-10  2667  int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
dc8d37ed304eee Arnd Bergmann    2019-12-10  2668  {
dc8d37ed304eee Arnd Bergmann    2019-12-10  2669  	int cpu, ret = 0;
dc8d37ed304eee Arnd Bergmann    2019-12-10  2670  
dc8d37ed304eee Arnd Bergmann    2019-12-10  2671  	cpu_maps_update_begin();
dc8d37ed304eee Arnd Bergmann    2019-12-10  2672  	for_each_online_cpu(cpu) {
dc8d37ed304eee Arnd Bergmann    2019-12-10  2673  		if (topology_is_primary_thread(cpu))
dc8d37ed304eee Arnd Bergmann    2019-12-10  2674  			continue;
38253464bc821d Michael Ellerman 2023-07-05  2675  		/*
38253464bc821d Michael Ellerman 2023-07-05  2676  		 * Disable can be called with CPU_SMT_ENABLED when changing
38253464bc821d Michael Ellerman 2023-07-05  2677  		 * from a higher to lower number of SMT threads per core.
38253464bc821d Michael Ellerman 2023-07-05  2678  		 */
38253464bc821d Michael Ellerman 2023-07-05  2679  		if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
38253464bc821d Michael Ellerman 2023-07-05  2680  			continue;
dc8d37ed304eee Arnd Bergmann    2019-12-10 @2681  		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
dc8d37ed304eee Arnd Bergmann    2019-12-10  2682  		if (ret)
dc8d37ed304eee Arnd Bergmann    2019-12-10  2683  			break;
dc8d37ed304eee Arnd Bergmann    2019-12-10  2684  		/*
dc8d37ed304eee Arnd Bergmann    2019-12-10  2685  		 * As this needs to hold the cpu maps lock it's impossible
dc8d37ed304eee Arnd Bergmann    2019-12-10  2686  		 * to call device_offline() because that ends up calling
dc8d37ed304eee Arnd Bergmann    2019-12-10  2687  		 * cpu_down() which takes cpu maps lock. cpu maps lock
dc8d37ed304eee Arnd Bergmann    2019-12-10  2688  		 * needs to be held as this might race against in kernel
dc8d37ed304eee Arnd Bergmann    2019-12-10  2689  		 * abusers of the hotplug machinery (thermal management).
dc8d37ed304eee Arnd Bergmann    2019-12-10  2690  		 *
dc8d37ed304eee Arnd Bergmann    2019-12-10  2691  		 * So nothing would update device:offline state. That would
dc8d37ed304eee Arnd Bergmann    2019-12-10  2692  		 * leave the sysfs entry stale and prevent onlining after
dc8d37ed304eee Arnd Bergmann    2019-12-10  2693  		 * smt control has been changed to 'off' again. This is
dc8d37ed304eee Arnd Bergmann    2019-12-10  2694  		 * called under the sysfs hotplug lock, so it is properly
dc8d37ed304eee Arnd Bergmann    2019-12-10  2695  		 * serialized against the regular offline usage.
dc8d37ed304eee Arnd Bergmann    2019-12-10  2696  		 */
dc8d37ed304eee Arnd Bergmann    2019-12-10  2697  		cpuhp_offline_cpu_device(cpu);
dc8d37ed304eee Arnd Bergmann    2019-12-10  2698  	}
dc8d37ed304eee Arnd Bergmann    2019-12-10  2699  	if (!ret)
dc8d37ed304eee Arnd Bergmann    2019-12-10  2700  		cpu_smt_control = ctrlval;
dc8d37ed304eee Arnd Bergmann    2019-12-10  2701  	cpu_maps_update_done();
dc8d37ed304eee Arnd Bergmann    2019-12-10  2702  	return ret;
dc8d37ed304eee Arnd Bergmann    2019-12-10  2703  }
dc8d37ed304eee Arnd Bergmann    2019-12-10  2704  

:::::: The code at line 2681 was first introduced by commit
:::::: dc8d37ed304eeeea47e65fb9edc1c6c8b0093386 cpu/SMT: Fix x86 link error without CONFIG_SYSFS

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

