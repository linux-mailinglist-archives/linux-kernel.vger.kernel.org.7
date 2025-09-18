Return-Path: <linux-kernel+bounces-822454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8100B83EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA4A3BA193
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172182D593D;
	Thu, 18 Sep 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC56xiLP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEAC274B37
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189168; cv=none; b=V9nCA3nhWUhmxVkQYSWDH6pFhVCPVuOqsHvcb6iNRg7Za6KiqlMr8JEfQtBXk8EIASff13kg/Yv/jH4rIjSuMiWrfQ6lyTMXeSDaOe0zCe/SGx7VAtyJ1QSFfQJuu5oPzMxS4DZnDkTOfNWRoI9gLY6+dCSiFVUUYg7b1ZCfhSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189168; c=relaxed/simple;
	bh=uggpLqEklF7aPa8WtKvaaRdHITJ4XoDIFxYFt+0xgEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/Bc297OOFm5OaMYDkqqudG0IvCWUsqq3r64w5L+Yq7byCZMThbpxgXw6xmf9vG2xXTsh5SNe0ULTFjNIw4DgAgNkH2ePJgI/He4FrJ+hlUdrmesISYanC2t2KJmFAW0wdUOdhWMyilFA5UOnAlzJ4o1ldGER8fQd07JI2WUaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC56xiLP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758189166; x=1789725166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uggpLqEklF7aPa8WtKvaaRdHITJ4XoDIFxYFt+0xgEo=;
  b=CC56xiLPQPajRt+fWhVzjxQV1VB/yJAeHlMg9M1J/mHj1HgMwRLjsaMD
   9aBEYSu9Je+m6KPSVH0hZngg9V/yJr8IdJ1Xpa7ntXpKoHJ0DyCOu5bto
   Q5GkCcqbPbYk1YzrlQwIauYYSEAGtAjJiT233Hr0zmU+jHIKkwxTeFqN4
   zTgprDJNy5ODDG6ofafzv1Itk40mMLAWwh2aukeHR896/DiJTqVcvINrQ
   dk1odsQ7q2kiNnOSziH6JaHc2XjhO19H6/gKbfKmc2HXYLea2Pd5vyTzP
   D91gqiEeSuZsVF67jf0wm+dauTc1RNzwoavQqx3FR2O+PuIBVhBpG2xZC
   Q==;
X-CSE-ConnectionGUID: m6WJXZZIQ7m42z3ciS7RHg==
X-CSE-MsgGUID: kxwScaMfSX+apm5SCyh3uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="64142181"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="64142181"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:52:45 -0700
X-CSE-ConnectionGUID: KNknfnMdQRS+XyskpsLUDQ==
X-CSE-MsgGUID: CO4XNbPHQluhoPfDS4klTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175422987"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2025 02:52:41 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzBJf-00034t-2e;
	Thu, 18 Sep 2025 09:52:39 +0000
Date: Thu, 18 Sep 2025 17:52:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, oleg@redhat.com, tglx@linutronix.de,
	peterz@infradead.org, luto@kernel.org, kees@kernel.org,
	wad@chromium.org, charlie@rivosinc.com, macro@orcam.me.uk,
	deller@gmx.de, akpm@linux-foundation.org, ldv@strace.io,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ruanjinjie@huawei.com
Subject: Re: [PATCH -next v6 10/10] arm64: entry: Convert to generic entry
Message-ID: <202509181742.AlhRJJjD-lkp@intel.com>
References: <20250916082611.2972008-11-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916082611.2972008-11-ruanjinjie@huawei.com>

Hi Jinjie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250915]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/arm64-ptrace-Split-report_syscall-into-report_syscall_enter-exit/20250916-163202
base:   next-20250915
patch link:    https://lore.kernel.org/r/20250916082611.2972008-11-ruanjinjie%40huawei.com
patch subject: [PATCH -next v6 10/10] arm64: entry: Convert to generic entry
config: arm64-randconfig-001-20250918 (https://download.01.org/0day-ci/archive/20250918/202509181742.AlhRJJjD-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250918/202509181742.AlhRJJjD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509181742.AlhRJJjD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/entry/syscall-common.c:30:8: warning: attribute declaration must precede definition [-Wignored-attributes]
      30 | static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs);
         |        ^
   include/linux/compiler_attributes.h:55:63: note: expanded from macro '__always_inline'
      55 | #define __always_inline                 inline __attribute__((__always_inline__))
         |                                                               ^
   arch/arm64/include/asm/entry-common.h:62:19: note: previous definition is here
      62 | static inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs)
         |                   ^
   kernel/entry/syscall-common.c:115:8: warning: attribute declaration must precede definition [-Wignored-attributes]
     115 | static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
         |        ^
   include/linux/compiler_attributes.h:55:63: note: expanded from macro '__always_inline'
      55 | #define __always_inline                 inline __attribute__((__always_inline__))
         |                                                               ^
   arch/arm64/include/asm/entry-common.h:98:20: note: previous definition is here
      98 | static inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
         |                    ^
   2 warnings generated.


vim +30 kernel/entry/syscall-common.c

a70e9f647f501e3 Jinjie Ruan 2025-06-24  19  
204f38f88c6f9db Jinjie Ruan 2025-09-16  20  /**
204f38f88c6f9db Jinjie Ruan 2025-09-16  21   * arch_ptrace_report_syscall_entry - Architecture specific
204f38f88c6f9db Jinjie Ruan 2025-09-16  22   *				      ptrace_report_syscall_entry().
204f38f88c6f9db Jinjie Ruan 2025-09-16  23   *
204f38f88c6f9db Jinjie Ruan 2025-09-16  24   * Invoked from syscall_trace_enter() to wrap ptrace_report_syscall_entry().
204f38f88c6f9db Jinjie Ruan 2025-09-16  25   * Defaults to ptrace_report_syscall_entry.
204f38f88c6f9db Jinjie Ruan 2025-09-16  26   *
204f38f88c6f9db Jinjie Ruan 2025-09-16  27   * The main purpose is to support arch-specific ptrace_report_syscall_entry()
204f38f88c6f9db Jinjie Ruan 2025-09-16  28   * implementation.
204f38f88c6f9db Jinjie Ruan 2025-09-16  29   */
204f38f88c6f9db Jinjie Ruan 2025-09-16 @30  static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs);
204f38f88c6f9db Jinjie Ruan 2025-09-16  31  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

