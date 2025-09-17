Return-Path: <linux-kernel+bounces-820233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22A2B7CA05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18027162384
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C839309DB1;
	Wed, 17 Sep 2025 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOHyVUij"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C73090EB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097695; cv=none; b=I4yp8kvDLI7072CB9XdGA90s+CUG9QxIqySr+B0t0p4AHHMf7DcBe46JR6DL6Gcb3zz8CdLAHOqEnFo03WUulrGHzrupywsgUEDn5HPMle+O3OMTGjLyvYAH4hTo7sgA3SBP72tBTmx+v3yC6+jmXCAA0fRDmx5rh+WE641tANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097695; c=relaxed/simple;
	bh=MGVrxB/ZF16ux1N/bdvGH9wocGEyHCPQesgRGMarVsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6Dc7HZKtTDkGhR6t8G3gS0NB+89irFp/gHtMyjneFCAznYKKAzDsAFjtIJzlU6PyESr6pJQLB+JHeQuCgSizuTDJQaLurt6n0repWZv6uXwuhbR3+5E5OEQAQn1bZFjgBwlOxTGUXbBYpnLBEXrY2XDZeFa1UVHaN3gFkW8qhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOHyVUij; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758097694; x=1789633694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGVrxB/ZF16ux1N/bdvGH9wocGEyHCPQesgRGMarVsE=;
  b=iOHyVUijTXnZn1yN7kP4xjl4JF6CauRgZqhnf/5g6GwYdi5LjSo+asyH
   yUXEVIClhU3U2sNxDK78YXeK/lSCPL4doPfk9t2tCjLR0FYGeCuoK/FAe
   fcOkvbvQzF4CfuLN4jdD/prHnOsmMdWgTyDmtHwWd/wgBc1QfYZ+XH5kc
   y+8XTHmo2upiNmURO8e0jmjCb4Y21a2eVIyQcpqHIUwpfnUT13kfWidg5
   7U3mkdDQrfyczBq7aA4m62qq2FyRH0et65HwW9cadaEa1QmUbPps4MZfN
   5hsLutLua7gaqX2S687qp/aOkjaGLOLqv+6gHRRkd7XEobJ6GIB9gnUtA
   A==;
X-CSE-ConnectionGUID: L1rXr0QgRQaTS8zPx8ADGg==
X-CSE-MsgGUID: o8Jy5W2wSUC/K5EoJNe43A==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="59440032"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="59440032"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:28:13 -0700
X-CSE-ConnectionGUID: CHw4gGA6QPKatRWEth28wg==
X-CSE-MsgGUID: ahFwTMAYQ5aJ04VbMOIVBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="175957976"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Sep 2025 01:28:09 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uynWJ-0001GF-1J;
	Wed, 17 Sep 2025 08:28:07 +0000
Date: Wed, 17 Sep 2025 16:27:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, oleg@redhat.com, tglx@linutronix.de,
	peterz@infradead.org, luto@kernel.org, kees@kernel.org,
	wad@chromium.org, charlie@rivosinc.com, macro@orcam.me.uk,
	deller@gmx.de, akpm@linux-foundation.org, ldv@strace.io,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ruanjinjie@huawei.com
Subject: Re: [PATCH -next v6 08/10] entry: Add
 arch_ptrace_report_syscall_entry/exit()
Message-ID: <202509171609.V2opqAfm-lkp@intel.com>
References: <20250916082611.2972008-9-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916082611.2972008-9-ruanjinjie@huawei.com>

Hi Jinjie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250915]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/arm64-ptrace-Split-report_syscall-into-report_syscall_enter-exit/20250916-163202
base:   next-20250915
patch link:    https://lore.kernel.org/r/20250916082611.2972008-9-ruanjinjie%40huawei.com
patch subject: [PATCH -next v6 08/10] entry: Add arch_ptrace_report_syscall_entry/exit()
config: i386-buildonly-randconfig-001-20250917 (https://download.01.org/0day-ci/archive/20250917/202509171609.V2opqAfm-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250917/202509171609.V2opqAfm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509171609.V2opqAfm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/entry/syscall-common.c:29 function parameter 'regs' not described in 'arch_ptrace_report_syscall_entry'
>> Warning: kernel/entry/syscall-common.c:115 function parameter 'regs' not described in 'arch_ptrace_report_syscall_exit'
>> Warning: kernel/entry/syscall-common.c:115 function parameter 'step' not described in 'arch_ptrace_report_syscall_exit'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

