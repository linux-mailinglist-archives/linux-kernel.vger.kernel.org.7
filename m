Return-Path: <linux-kernel+bounces-891697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F55FC43458
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E109C4E151F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DCE27A462;
	Sat,  8 Nov 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrXKWo7y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964F25486D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631924; cv=none; b=FZPyuqLh+kLKtpzK0p7KJ5XPnsXRTtjFj38gODn1imI1gFqyaJhLWJsaFcEXemGHBhyA+lxeRahR9UDmKcdGBVfVnb9mvF1S/mJYATteWT9OQze7OdbUO6+a4rSJ2/fVwRNoJfNmeWE972Nm5hykfyKONHg3dO6WtpBh0ka8nSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631924; c=relaxed/simple;
	bh=plhVHEBXm7QJOKf+WRWk8aQuYSGYHx8t6uD1XGz/MU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rxsb7hMqdEtfn9/SPv8pY7tH5zUt85njm/Q684LhDK4yvTud7SzWh81K2/Ph3rjfyu0vNvtywuRjYnb//vLOMqn7Cla8CG0YyRvdvSa3hicc1LDOu+MEH9dSLSCEIOiPWkWtz5/t7dCLQ79yRWsXzb2BIRUfAuXLbKNgEd+bL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrXKWo7y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762631923; x=1794167923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=plhVHEBXm7QJOKf+WRWk8aQuYSGYHx8t6uD1XGz/MU4=;
  b=LrXKWo7yROvQqR5muWQCdqNcagSHOFqiMXPXwUYudrtwGPDMwI4k9fhT
   MY2L13SUz06wzDHi/Vdzo9h41isJ42ELj5bxKK2igwTIUmA+OhkiXIjBg
   ExhcQ4tZT97nscHnXxn6Dj9BwKa01nFlXyEoMeQK+O6BC2769d/tJNYVR
   T6aKWfIgrt4VvXV/NLmPala59duPGvFozBW1HgxNUTxrZLp25nlPGPHSG
   mLbOgUuFJedaobt2klcr8H+fKqeWuhVFHKIYqvLc4HxSY521rKIsHUr6x
   DJEsXz1ENUd4GzeLB2TTCJA/eIZlapfotKKvTHciWvc8JAIMIOY294Tas
   g==;
X-CSE-ConnectionGUID: X5EBKuLySZWfzcARTCYvTw==
X-CSE-MsgGUID: eUPFlKxsSfOwrZig9aETvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64836953"
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="64836953"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 11:58:41 -0800
X-CSE-ConnectionGUID: jS2iGeBtTd+y52CBSdpldg==
X-CSE-MsgGUID: Rx0/F1j6Tuumq1wHZHbvIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="188496410"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Nov 2025 11:58:40 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHp53-0001Oh-1h;
	Sat, 08 Nov 2025 19:58:37 +0000
Date: Sun, 9 Nov 2025 03:58:34 +0800
From: kernel test robot <lkp@intel.com>
To: Helge Deller <deller@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/parisc/kernel/perf_regs.c:30:2-3: Unneeded semicolon
Message-ID: <202511090323.OwYsZkev-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7bb4d6512545a792a6cd8d6c8be5718920b9b11a
commit: 610cb23bcc75bcd9fead3e41cbd867cccd0eb229 parisc: Add initial kernel-side perf_event support
date:   5 weeks ago
config: parisc-randconfig-r062-20251109 (https://download.01.org/0day-ci/archive/20251109/202511090323.OwYsZkev-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511090323.OwYsZkev-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> arch/parisc/kernel/perf_regs.c:30:2-3: Unneeded semicolon

vim +30 arch/parisc/kernel/perf_regs.c

     8	
     9	u64 perf_reg_value(struct pt_regs *regs, int idx)
    10	{
    11		switch (idx) {
    12		case PERF_REG_PARISC_R0 ... PERF_REG_PARISC_R31:
    13			return regs->gr[idx - PERF_REG_PARISC_R0];
    14		case PERF_REG_PARISC_SR0 ... PERF_REG_PARISC_SR7:
    15			return regs->sr[idx - PERF_REG_PARISC_SR0];
    16		case PERF_REG_PARISC_IASQ0 ... PERF_REG_PARISC_IASQ1:
    17			return regs->iasq[idx - PERF_REG_PARISC_IASQ0];
    18		case PERF_REG_PARISC_IAOQ0 ... PERF_REG_PARISC_IAOQ1:
    19			return regs->iasq[idx - PERF_REG_PARISC_IAOQ0];
    20		case PERF_REG_PARISC_SAR:	/* CR11 */
    21			return regs->sar;
    22		case PERF_REG_PARISC_IIR:	/* CR19 */
    23			return regs->iir;
    24		case PERF_REG_PARISC_ISR:	/* CR20 */
    25			return regs->isr;
    26		case PERF_REG_PARISC_IOR:	/* CR21 */
    27			return regs->ior;
    28		case PERF_REG_PARISC_IPSW:	/* CR22 */
    29			return regs->ipsw;
  > 30		};
    31		WARN_ON_ONCE((u32)idx >= PERF_REG_PARISC_MAX);
    32		return 0;
    33	}
    34	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

