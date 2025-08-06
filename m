Return-Path: <linux-kernel+bounces-758310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF6B1CD75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE61B564AED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3014421C9EA;
	Wed,  6 Aug 2025 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgYaIffo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B210E4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512160; cv=none; b=HjEhTTgJxFy5q/qazC+zQh9EWEDZ0eE4IGgvCSMiH506AGUXAWqMgUSboDjSlDqE5S7p8Uhw5W8mZR0KyszJ32Sjz2AgwtR4zH7M9DLjJyF1PCh5KWcbprBG2BITIDiyeTaLCc5u2AdhL5CTLAnp38nFo3XRmYgBaE0Kdctn0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512160; c=relaxed/simple;
	bh=LUUYjmMtw+FyXq16C/NjmvalMIiu6tu25CS1fCfwgRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8ftpflM0dasyPru/leHm8HoTAbq5+3Lxfp+BsSdYGibqxCbhvmtAyyS7Wx4AJ23rFBVRqutmXr0Z/zFPgwWebAC+Q+Td6Gu7BjzoaIdffxh8V13wd4RezJ3XhWkWNcZ8CzBTKbrzSrbDAsHGAaDu5Q1Z+804d8lPvZpAxOLA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgYaIffo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512159; x=1786048159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LUUYjmMtw+FyXq16C/NjmvalMIiu6tu25CS1fCfwgRw=;
  b=kgYaIffojHKoFLAh9Fot5bEWdnvezumquE5X/E5xgyrNBry3Lc7LziUJ
   ubpf5MKkGXQpEnUQ2AsTGROyLmAgF0bgxRmNT1Sn9zo3MIdFOtxjpl+fL
   4CBu6NgmZbVp+4n8QD83pmea2HT1B8RWpP4bOLjDskRCH6gPtN/we9p5i
   9m53TLBjrr4MOWGsLi3ij8pckc84889/VmvOjXonm1Dx3HuzbS5cfUKRF
   QibCS1oGH/+W08jlu2CYEQwLA5nKJsCmEsaXcBbD1/aNnpdPAAOjF1mnL
   oqH7f09cRZBKjbWO0/gVK9WqgBCI3rAOzPwhDhCA4Heey1YvuobXjOS3c
   A==;
X-CSE-ConnectionGUID: 72r43QjzSzicZKL7bIbDGA==
X-CSE-MsgGUID: JGO4s6FcR8qQa8xKqMdfPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56975221"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56975221"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:29:19 -0700
X-CSE-ConnectionGUID: qCiSHFCEQRKu989NXrFLcQ==
X-CSE-MsgGUID: I8vzutjXQBiXQB8rHJvZnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165205710"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Aug 2025 13:29:16 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujkkz-000244-0z;
	Wed, 06 Aug 2025 20:29:08 +0000
Date: Thu, 7 Aug 2025 04:28:28 +0800
From: kernel test robot <lkp@intel.com>
To: Wake Liu <wakel@google.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	wakel@google.com
Subject: Re: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
Message-ID: <202508070443.SWaWZTdB-lkp@intel.com>
References: <20250805162153.952693-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805162153.952693-1-wakel@google.com>

Hi Wake,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/timers/vdso]
[also build test WARNING on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wake-Liu/vdso-Define-NSEC_PER_SEC-as-64-bit-to-prevent-overflow/20250806-125650
base:   tip/timers/vdso
patch link:    https://lore.kernel.org/r/20250805162153.952693-1-wakel%40google.com
patch subject: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
config: powerpc-randconfig-002-20250807 (https://download.01.org/0day-ci/archive/20250807/202508070443.SWaWZTdB-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070443.SWaWZTdB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070443.SWaWZTdB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/xmon/xmon.c: In function 'show_uptime':
>> arch/powerpc/xmon/xmon.c:1008:27: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'long long int' [-Wformat=]
    1008 |   printf("Uptime: %lu.%.2lu seconds\n", (unsigned long)uptime.tv_sec,
         |                       ~~~~^
         |                           |
         |                           long unsigned int
         |                       %.2llu
    1009 |    ((unsigned long)uptime.tv_nsec / (NSEC_PER_SEC/100)));
         |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   long long int


vim +1008 arch/powerpc/xmon/xmon.c

^1da177e4c3f41 arch/ppc64/xmon/xmon.c   Linus Torvalds       2005-04-16   996  
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18   997  /* Based on uptime_proc_show(). */
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18   998  static void
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18   999  show_uptime(void)
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1000  {
f6bd74fa084eb9 arch/powerpc/xmon/xmon.c Arnd Bergmann        2018-06-18  1001  	struct timespec64 uptime;
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1002  
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1003  	if (setjmp(bus_error_jmp) == 0) {
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1004  		catch_memory_errors = 1;
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1005  		sync();
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1006  
f6bd74fa084eb9 arch/powerpc/xmon/xmon.c Arnd Bergmann        2018-06-18  1007  		ktime_get_coarse_boottime_ts64(&uptime);
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18 @1008  		printf("Uptime: %lu.%.2lu seconds\n", (unsigned long)uptime.tv_sec,
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1009  			((unsigned long)uptime.tv_nsec / (NSEC_PER_SEC/100)));
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1010  
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1011  		sync();
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1012  		__delay(200);						\
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1013  	}
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1014  	catch_memory_errors = 0;
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1015  }
59d3391e8cf274 arch/powerpc/xmon/xmon.c Guilherme G. Piccoli 2017-09-18  1016  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

