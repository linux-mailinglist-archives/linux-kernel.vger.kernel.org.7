Return-Path: <linux-kernel+bounces-750142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AEFB157D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CF018A69D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3061ACEDE;
	Wed, 30 Jul 2025 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBAjWJQC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D5218DF89
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846645; cv=none; b=P+hiLlAATCvqNZkLVnZWYFbquY1heDf0qx0pB4VNhvoN4AKCkt8yPsXm4PYETTfdV+D+KoUuZ2tSr50dLdEw5nKmkfhc+ey1oW1EqBxgCmGcxwMYgFdHr8SGiW/BRFZl3NYNkw4o+P5swSynDZw+BzsUfoMInAG+O1T7AhxfAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846645; c=relaxed/simple;
	bh=qjPacZ6W48j/mjK8omT3VIEt5+vuJ4CpubaD6KHIGC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMXuc/LVhaflb62bUq7OGzj19mpWXB+cmxIm0cFg796hmuyUSUlX3f6UeH7KKsw2kzNH3Mlp0csjyAOYCWlkDhwcAjxNRjr4W0U5/q6gFSzDiC7LFvMA3E43bXF30AaV4tWXyzHKwZhtPLtkxGZSfmy3Pj0sb31kYD6buKtgZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBAjWJQC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753846643; x=1785382643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qjPacZ6W48j/mjK8omT3VIEt5+vuJ4CpubaD6KHIGC0=;
  b=kBAjWJQCLkfYtBuZg1loIw+Fkyw/V2dua/hZLNJbFlkS80YIus5XvXHy
   T9WKob+u4S2HKZqcgy+WPgZ/lI0NYp+MuJmNPTcoOasWS/GtioXrPY3qO
   3bK5l4ftzK5yh0RNb6XuCozOq2DoprhSWZBTd+cMWg10Hpw7HHUX69gGn
   +uzWi2U7ceVeoLlpFyi83Cezb9CYan+AD40uoJMIGgGEN/Rx5GH+BvwcJ
   ampZ/lNRigSqqSHBAgaUUBxZkxShwCGE5TIvw4xKxxsRh5nwKiQY4l9MT
   bKbhZfDfQ+TvggD7bttFAnZ62lVNeJDAXs0rm8vGuKSqe+/wAEVoh8Arg
   Q==;
X-CSE-ConnectionGUID: Ee0I5xZ9Q/6wb35GH7z8gw==
X-CSE-MsgGUID: r6VhQXHaRh2zh1D0GOjoxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="59962343"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="59962343"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 20:37:23 -0700
X-CSE-ConnectionGUID: q8tQ4ws2RTKYSGxWAVmjaQ==
X-CSE-MsgGUID: ce0zWUKwTgmAl/SlhJnqPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="167051794"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2025 20:37:22 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugxd1-0001xz-1d;
	Wed, 30 Jul 2025 03:37:19 +0000
Date: Wed, 30 Jul 2025 11:36:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jiawei Zhao <Phoenix500526@163.com>, ast@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: add SIB addressing mode support for x86-64 USDT
 arguments
Message-ID: <202507301122.2gtH7n4r-lkp@intel.com>
References: <20250729125244.28364-1-Phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729125244.28364-1-Phoenix500526@163.com>

Hi Jiawei,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master linus/master v6.16 next-20250729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiawei-Zhao/libbpf-add-SIB-addressing-mode-support-for-x86-64-USDT-arguments/20250729-205449
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250729125244.28364-1-Phoenix500526%40163.com
patch subject: [PATCH] libbpf: add SIB addressing mode support for x86-64 USDT arguments
config: arm-randconfig-001-20250730 (https://download.01.org/0day-ci/archive/20250730/202507301122.2gtH7n4r-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project bcd0d972247154336dd1321f1fded818e46671d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507301122.2gtH7n4r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507301122.2gtH7n4r-lkp@intel.com/

All errors (new ones prefixed by >>):

>> usdt.c:1301:7: error: mixing declarations and code is a C99 extension [-Werror,-Wdeclaration-after-statement]
    1301 |                 int idx_reg_off = calc_pt_regs_off(idx_reg_name);
         |                     ^
   1 error generated.
   make[6]: *** [tools/build/Makefile.build:85: tools/bpf/resolve_btfids/libbpf/staticobjs/usdt.o] Error 1 shuffle=2731265819
   make[6]: Target '__build' not remade because of errors.
   make[5]: *** [Makefile:152: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2 shuffle=2731265819
   make[5]: Target 'tools/bpf/resolve_btfids/libbpf/libbpf.a' not remade because of errors.
   make[4]: *** [Makefile:61: tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2 shuffle=2731265819
   make[4]: Target 'all' not remade because of errors.
   make[3]: *** [Makefile:76: bpf/resolve_btfids] Error 2 shuffle=2731265819
   make[2]: *** [Makefile:1443: tools/bpf/resolve_btfids] Error 2 shuffle=2731265819
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=2731265819
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=2731265819
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

