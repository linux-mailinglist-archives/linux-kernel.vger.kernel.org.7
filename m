Return-Path: <linux-kernel+bounces-880209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A684AC251D3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA0514F6E53
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BF0348472;
	Fri, 31 Oct 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHfCZb1E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127C1E834B;
	Fri, 31 Oct 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915139; cv=none; b=cjuEyqXdYRRinjo0fnixjC/0VZ4f8mWijReYbRs86Vt9amGjrXLHYP5YMiJC993g9G4DhJqW0x1CvqDr/v3xTFc3V7me4MwvEVLzDJ2zs7Zkjh6KtTlHxZ38GP8i47micMc5C6YYJiYfTyncTgnARINkLldRViXRm1r+DFalKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915139; c=relaxed/simple;
	bh=UhgY56L2Y48rGqsa8FjhgUlMRK793nBioVqcnGX0uUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoOsUNtUhAR6UvuiCdJJdOs+aHDuD1b213PmSO650E4pdxXjjROlAWT3z0lDZk44toRD64LAA5sQzsIeWmlWKSbnp9I6goUROjJAeR1spHY1FquHNrD9lJx9e64ABHdk6d3AW9nRjNjYnXnmpocMyHlrYm5dBDPjpo5w1LQjemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHfCZb1E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761915138; x=1793451138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UhgY56L2Y48rGqsa8FjhgUlMRK793nBioVqcnGX0uUc=;
  b=BHfCZb1EZ3tBoITxYE9VKlPoD8OBGdWJtjX9dgDc8F6vnOotR0p9qiSj
   R+gjWUG4NGU0QqNeX4GUGP+QxeqLNUoEKI8MuNF3IARKNLapFLbQ678aP
   JGuoGEO9tTfHOaa+x7Nc+xtIJsL6SX/X7QaLh3IheBuYJR1rREt+3M5PQ
   5RV+Js4PGNEl15BNpxOuq9YmFVJ1y7LSJgsG/urpJhM2PB9Xwf+N+fDXb
   GjPBHNBYFcW2xFpx7UcVwsvftiYkxSiWlPKPHNaLTH194URwy1vd/ngDs
   QJz3X8F+K40FzG9HE8+U4JpdvM+SedAkq3EO+JDiYUBlIjR9kT9bLePKx
   w==;
X-CSE-ConnectionGUID: X6ldc/rLT66o6nfWyM20DA==
X-CSE-MsgGUID: pY4+gmZQT1OVaxxcu8ot1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="66688128"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="66688128"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:52:17 -0700
X-CSE-ConnectionGUID: fotXEm+rSS+AXCY654oD1A==
X-CSE-MsgGUID: UZoZcDi8SNi3Kv7d80kCHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="209793862"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 31 Oct 2025 05:52:15 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEobv-000N7U-1K;
	Fri, 31 Oct 2025 12:52:08 +0000
Date: Fri, 31 Oct 2025 20:51:26 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-alpha@vger.kernel.org,
	Chen Gang <gang.chen@asianux.com>, Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] alpha: Use pointers from memcpy() calls for assignments
 in two functions
Message-ID: <202510312008.rLcaBIfL-lkp@intel.com>
References: <1605dd43-5e95-46eb-a0c6-78ff8b4d51b3@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605dd43-5e95-46eb-a0c6-78ff8b4d51b3@web.de>

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on mattst88-alpha/for-linus v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/alpha-Use-pointers-from-memcpy-calls-for-assignments-in-two-functions/20251031-003938
base:   linus/master
patch link:    https://lore.kernel.org/r/1605dd43-5e95-46eb-a0c6-78ff8b4d51b3%40web.de
patch subject: [PATCH] alpha: Use pointers from memcpy() calls for assignments in two functions
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251031/202510312008.rLcaBIfL-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510312008.rLcaBIfL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510312008.rLcaBIfL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/alpha/kernel/smp.c: In function 'send_secondary_console_msg':
>> arch/alpha/kernel/smp.c:201:24: warning: variable 'cp1' set but not used [-Wunused-but-set-variable]
     201 |         register char *cp1, *cp2;
         |                        ^~~
   arch/alpha/kernel/smp.c: In function 'recv_secondary_console_msg':
   arch/alpha/kernel/smp.c:237:13: warning: variable 'mycpu' set but not used [-Wunused-but-set-variable]
     237 |         int mycpu, i, cnt;
         |             ^~~~~


vim +/cp1 +201 arch/alpha/kernel/smp.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  192  
^1da177e4c3f415 Linus Torvalds 2005-04-16  193  /*
^1da177e4c3f415 Linus Torvalds 2005-04-16  194   * Send a message to a secondary's console.  "START" is one such
^1da177e4c3f415 Linus Torvalds 2005-04-16  195   * interesting message.  ;-)
^1da177e4c3f415 Linus Torvalds 2005-04-16  196   */
ab39c77c3246f84 Paul Gortmaker 2013-06-17  197  static void
^1da177e4c3f415 Linus Torvalds 2005-04-16  198  send_secondary_console_msg(char *str, int cpuid)
^1da177e4c3f415 Linus Torvalds 2005-04-16  199  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  200  	struct percpu_struct *cpu;
^1da177e4c3f415 Linus Torvalds 2005-04-16 @201  	register char *cp1, *cp2;
^1da177e4c3f415 Linus Torvalds 2005-04-16  202  	unsigned long cpumask;
^1da177e4c3f415 Linus Torvalds 2005-04-16  203  	size_t len;
^1da177e4c3f415 Linus Torvalds 2005-04-16  204  
^1da177e4c3f415 Linus Torvalds 2005-04-16  205  	cpu = (struct percpu_struct *)
^1da177e4c3f415 Linus Torvalds 2005-04-16  206  		((char*)hwrpb
^1da177e4c3f415 Linus Torvalds 2005-04-16  207  		 + hwrpb->processor_offset
^1da177e4c3f415 Linus Torvalds 2005-04-16  208  		 + cpuid * hwrpb->processor_size);
^1da177e4c3f415 Linus Torvalds 2005-04-16  209  
^1da177e4c3f415 Linus Torvalds 2005-04-16  210  	cpumask = (1UL << cpuid);
^1da177e4c3f415 Linus Torvalds 2005-04-16  211  	if (wait_for_txrdy(cpumask))
^1da177e4c3f415 Linus Torvalds 2005-04-16  212  		goto timeout;
^1da177e4c3f415 Linus Torvalds 2005-04-16  213  
^1da177e4c3f415 Linus Torvalds 2005-04-16  214  	cp2 = str;
^1da177e4c3f415 Linus Torvalds 2005-04-16  215  	len = strlen(cp2);
^1da177e4c3f415 Linus Torvalds 2005-04-16  216  	*(unsigned int *)&cpu->ipc_buffer[0] = len;
c37a29a96dcfc93 Markus Elfring 2025-10-30  217  	cp1 = memcpy(&cpu->ipc_buffer[1], cp2, len);
^1da177e4c3f415 Linus Torvalds 2005-04-16  218  
^1da177e4c3f415 Linus Torvalds 2005-04-16  219  	/* atomic test and set */
^1da177e4c3f415 Linus Torvalds 2005-04-16  220  	wmb();
^1da177e4c3f415 Linus Torvalds 2005-04-16  221  	set_bit(cpuid, &hwrpb->rxrdy);
^1da177e4c3f415 Linus Torvalds 2005-04-16  222  
^1da177e4c3f415 Linus Torvalds 2005-04-16  223  	if (wait_for_txrdy(cpumask))
^1da177e4c3f415 Linus Torvalds 2005-04-16  224  		goto timeout;
^1da177e4c3f415 Linus Torvalds 2005-04-16  225  	return;
^1da177e4c3f415 Linus Torvalds 2005-04-16  226  
^1da177e4c3f415 Linus Torvalds 2005-04-16  227   timeout:
^1da177e4c3f415 Linus Torvalds 2005-04-16  228  	printk("Processor %x not ready\n", cpuid);
^1da177e4c3f415 Linus Torvalds 2005-04-16  229  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  230  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

