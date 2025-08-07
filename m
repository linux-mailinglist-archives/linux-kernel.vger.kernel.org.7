Return-Path: <linux-kernel+bounces-759217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86802B1DA6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765847A51EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FEC25DCE5;
	Thu,  7 Aug 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldRXKL9Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE6204F93
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578541; cv=none; b=Iqib6HcEDzbAXhAvoavEBYqTZ1aoqxjj5Ky3cdNbsEQ3juOX1ckvg/Ke5UgF4RZtgQfJ6KrZXcgIYnay0NzsgWKsBv1j4sz8U1xvJh9V+XuKd+tHuuiUDuW/HL63fEWLAlz7MlDtSY0C6X+2A2CUHW5fPr3bFWy5bN/K8g5AHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578541; c=relaxed/simple;
	bh=LhNV4rNwlM1GjQoibhPSPw5h4vdR15BXotmQnSEIl4A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q/hNlwGO44Wcjk/0d5uyLPxG4LQU90KWihsML0nV8B3B9yvybaw+i+xunw+E/eCxGBL74oh+3c0mpJTaNA6/Sd8X0brCB6nqYyXrwsqzqZ8LICNwZAgp5h/Z0FT7uiu3ZYLdvLtPqnLOxJHYwDUgoCSL7uTyST1xmpvMQOW/i7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldRXKL9Y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754578540; x=1786114540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LhNV4rNwlM1GjQoibhPSPw5h4vdR15BXotmQnSEIl4A=;
  b=ldRXKL9YrhXw5a101HDcPhls7eH7fd/JLrKPMZlBmSeLFEYJkcHKJQIW
   sRf9/ErNuGT+Gs7GBm/g1wu2EXzSuDAc5DkL9a9sGJjI7wgBvrCuVHHEx
   pT3POWSPZAkXR3Cd1EPnCyCDtBKYCWLLT5eFb93d7vRBMLr0FIX0Fvuba
   VRHNGSeBizzDuGHsprW9sVz0NU2QjuW+dByBBUWDzHcogT+qlNwL3k4gC
   5Za5IFwIKT4KSAIHd5/5nJwScL3F8LpwQK2p8+Qv7+guauOTxZFQ8gg49
   UCVojBzbQdaY9ZOmgowBYw+DUucjGsXMRDb3eRPUDPzK5O9RvUmTSUq8o
   Q==;
X-CSE-ConnectionGUID: z0i4vunqS/CFX6d3spQYZA==
X-CSE-MsgGUID: rBA6Lq1YSSOErUbkyTHoZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68290568"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="68290568"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 07:55:39 -0700
X-CSE-ConnectionGUID: ZA7AK/5SS2mLreS1dvtjVA==
X-CSE-MsgGUID: E5QBsy51Qu+/IRazcBTbZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164330131"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 07 Aug 2025 07:55:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uk21n-0002u8-1E;
	Thu, 07 Aug 2025 14:55:35 +0000
Date: Thu, 7 Aug 2025 22:54:51 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stafford Horne <shorne@gmail.com>, Rong Xu <xur@google.com>
Subject: (.head.text+0x900): relocation truncated to fit: R_OR1K_INSN_REL_26
 against `no symbol'
Message-ID: <202508072204.buxqzhL3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6e64f4580381e32c06ee146ca807c555b8f73e24
commit: a412f04070e52e6d6b5f6f964b9d9644de16bb81 openrisc: place exception table at the head of vmlinux
date:   8 months ago
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20250807/202508072204.buxqzhL3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508072204.buxqzhL3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508072204.buxqzhL3-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/openrisc/kernel/head.o: in function `_dispatch_do_ipage_fault':
>> (.head.text+0x900): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   (.head.text+0xa00): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   arch/openrisc/kernel/head.o: in function `exit_with_no_dtranslation':
>> (.init.text+0x21bc): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   arch/openrisc/kernel/head.o: in function `exit_with_no_itranslation':
   (.init.text+0x2264): relocation truncated to fit: R_OR1K_INSN_REL_26 against `no symbol'
   init/main.o: in function `trace_event_raw_event_initcall_level':
   main.c:(.text+0x28c): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `strlen' defined in .text section in lib/string.o
   init/main.o: in function `initcall_blacklisted':
   main.c:(.text+0x70c): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `strcmp' defined in .text section in lib/string.o
   init/main.o: in function `trace_initcall_finish_cb':
   main.c:(.text+0x830): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/15.1.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x854): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/15.1.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x894): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/15.1.0/libgcc.a(_muldi3.o)
   main.c:(.text+0x8c0): relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `__muldi3' defined in .text section in ../lib/gcc/or1k-linux/15.1.0/libgcc.a(_muldi3.o)
   init/main.o: in function `do_one_initcall':
   main.c:(.text+0xf54): additional relocation overflows omitted from the output

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

