Return-Path: <linux-kernel+bounces-881897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D1C292B6
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A581018841CB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68044264630;
	Sun,  2 Nov 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVbb5ltA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034C1A3154
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101810; cv=none; b=kgpNBzjJKHB9r5c4xkidkqOr9wf8P0ZmccspeaxQLl/3Glm027cgo2JHPDoxhtxaveDmWxnMzjLkEFgqV4NxgsPHWCJ+QGYfuTnhOu5ZT/YN18+boCfdP1AUC1IDaSQ8bzwQK8jbPGNKvIrRGaSvKXgutFLhuI45IWdnxTzysEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101810; c=relaxed/simple;
	bh=eRQr/VRd9ouC+ynzQsRP6GqDWYplFUllMu+6jFjshSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SfsZ/h1GDI/nTe7DOcj+7dF6vVsI8WPb87P7qUtCEL4LfV3SN7JE27so/sght2Zz7nH+0tAXMRDrjWN4EAFjjyyglVtuwmjFskwGvySK6xVPyCJSs8xl2ucf1j73Ui+xLtYOA+jLOlb8Izc//Xo3cwE35uF3QE3DQi08zxV+aDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVbb5ltA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762101809; x=1793637809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eRQr/VRd9ouC+ynzQsRP6GqDWYplFUllMu+6jFjshSg=;
  b=JVbb5ltA5PD+NbyZUec5JUmwsZFk8uPkTeGEw6gm4Ca2nYri6ZN36ynI
   l5Kb4aAnoqfPu6N9hpbBDr9etn1hwMcVl9wTZ+M+bQ9AXk2wA6Ex5p0rw
   LBqBpyCjqL3wup3IYvHydolhdI2xsT0Np5hVYM5wi8NVvIan30njG3+B4
   DfExxtPv50cZUpIsoRtydudHXWP776lYWo6AELr68460wVKeELn3rRAIx
   BeysJOcP/HussPMbShmMpgaRdKasazF6ph30sg5QB4fCQSwcv6ZF8SNTi
   p/goAiWFnXLn2vN+a2HECtVthibVa3zSGMttJoHiH4Nh6Yno10Dnf3PKu
   w==;
X-CSE-ConnectionGUID: PNu7vA1JT8ejsLysxNz/TA==
X-CSE-MsgGUID: 0Kj52DeeRn6x8Gb6pbsKyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64095587"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64095587"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 08:43:29 -0800
X-CSE-ConnectionGUID: wGSyW/03RRm13wYiWHP9oA==
X-CSE-MsgGUID: pFFpYBBUQ0yDzDBEYGrUjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="191789262"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 02 Nov 2025 08:43:27 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFbAq-000PPH-2T;
	Sun, 02 Nov 2025 16:43:24 +0000
Date: Mon, 3 Nov 2025 00:41:13 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [tip:core/rseq 40/42] arch/arm64/kernel/entry-common.c:103:9: error:
 implicit declaration of function 'exit_to_user_mode_prepare'; did you mean
 'arch_exit_to_user_mode_prepare'?
Message-ID: <202511030013.EmYk0XGN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/rseq
head:   69c8e3d1610588d677faaa6035e1bd5de9431d6e
commit: d589306403107aa3ba5f014cb7d17b3d5db3cf94 [40/42] entry: Split up exit_to_user_mode_prepare()
config: arm64-randconfig-003-20251102 (https://download.01.org/0day-ci/archive/20251103/202511030013.EmYk0XGN-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251103/202511030013.EmYk0XGN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511030013.EmYk0XGN-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/entry-common.c: In function 'arm64_exit_to_user_mode':
>> arch/arm64/kernel/entry-common.c:103:9: error: implicit declaration of function 'exit_to_user_mode_prepare'; did you mean 'arch_exit_to_user_mode_prepare'? [-Werror=implicit-function-declaration]
     103 |         exit_to_user_mode_prepare(regs);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         arch_exit_to_user_mode_prepare
   cc1: some warnings being treated as errors


vim +103 arch/arm64/kernel/entry-common.c

bc29b71f53b13c Mark Rutland 2021-08-02   93  
bc29b71f53b13c Mark Rutland 2021-08-02   94  /*
bc29b71f53b13c Mark Rutland 2021-08-02   95   * Handle IRQ/context state management when exiting to user mode.
bc29b71f53b13c Mark Rutland 2021-08-02   96   * After this function returns it is not safe to call regular kernel code,
59598b42eb52c7 Mukesh Ojha  2022-10-29   97   * instrumentable code, or any code which may trigger an exception.
bc29b71f53b13c Mark Rutland 2021-08-02   98   */
997d79eb938e98 Mark Rutland 2024-02-06   99  
b3cf07851b6c4a Jinjie Ruan  2025-08-15  100  static __always_inline void arm64_exit_to_user_mode(struct pt_regs *regs)
4d1c2ee2709fd6 Mark Rutland 2021-08-02  101  {
97d935faacde47 Mark Rutland 2024-02-06  102  	local_irq_disable();
ab1e29acdb33c9 Eric Chan    2023-05-31 @103  	exit_to_user_mode_prepare(regs);
b3cf07851b6c4a Jinjie Ruan  2025-08-15  104  	local_daif_mask();
e130338eed5de0 Mark Rutland 2021-08-02  105  	mte_check_tfsr_exit();
b3cf07851b6c4a Jinjie Ruan  2025-08-15  106  	exit_to_user_mode();
e130338eed5de0 Mark Rutland 2021-08-02  107  }
e130338eed5de0 Mark Rutland 2021-08-02  108  

:::::: The code at line 103 was first introduced by commit
:::::: ab1e29acdb33c971e1af8ed8ec427bd1deff5f32 arm64: lockdep: enable checks for held locks when returning to userspace

:::::: TO: Eric Chan <ericchancf@google.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

