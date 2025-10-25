Return-Path: <linux-kernel+bounces-870129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7569C0A002
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1603B50F9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0C35B124;
	Sat, 25 Oct 2025 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHm9pFBT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2072EED8
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426040; cv=none; b=ga3AOYgwVujZuR0ngKZs4iYRC/uXK8YeMT9xSNge9ZEsfM+cGff64aZYQXyN2YHtZq57KOJ/ErGIoltRBIFK79rl15C/8xnx21zskRF/GrMdhCRYhiir7rm9+EodovKI65I2u0X2ytBT2l4wTUBEeUXJTL4wew+CIH0ts3aoI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426040; c=relaxed/simple;
	bh=/7uw6/+uVAyvakbvVGn43byDqcefCUuZ/GdPEYMjtts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WUuOWnxXmGR3dsGqs+cTvDD48kvkp4d0HOo4+FiEjYkXaSlPIXHlyXk5QP4uIv9qou6YoNodM5pdGtqImyKuhqFADb5Mnh6Ca53X59ia9CJlzJFmOmIMBs698RcMyv2piA6RNdIZdylJe/Opr6rundz/RXO8oSesWs6LQsBOCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHm9pFBT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761426039; x=1792962039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/7uw6/+uVAyvakbvVGn43byDqcefCUuZ/GdPEYMjtts=;
  b=BHm9pFBTD3qRAa8P2ZCY2zVTNgPYFSSNjcOGo+MQXWtA9TDlkzRZkOBm
   raUDGUmWPRSLvNaBDHmRLlwqiD9A8gh5zubiu6N3E66u/aebPM7eDeQqt
   8Zq9dSb2eqVS/WkoAjdTrJ4z7HhsVHOZmGcw3lzLEXzTnF6wCYpWGr9WT
   Tt3vyusxp1QvBZ2GN88GZb5yq8lUygv2wjeMlkqyOPwFxFvSRtx54LlpP
   cCWcrJv/UFpVKniYgiKIXqAXYtk+xnnTHaJwTxKPQXx8wkFK7mlw6ZVLQ
   LU16H2AfHhe2Hl027280YdenmUzHduk754zKNyzjjIjN5gESLyACL3qN2
   Q==;
X-CSE-ConnectionGUID: pWSgsS2uQUWW0EsMpIVZgA==
X-CSE-MsgGUID: QL/2aWfuRTewKsjquTN/LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74682714"
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="74682714"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 14:00:38 -0700
X-CSE-ConnectionGUID: tdu7SxhoTWi+wvZ8cjEHkw==
X-CSE-MsgGUID: ++bFjUueTvmdHwKv9D/GJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="185463770"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 25 Oct 2025 14:00:37 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vClNH-000Fav-2z;
	Sat, 25 Oct 2025 21:00:32 +0000
Date: Sun, 26 Oct 2025 04:59:47 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: cfi_staa_erase_varsize+0x4e3:
 cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
Message-ID: <202510260435.79ThTwFt-lkp@intel.com>
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
commit: 29c578c848402a34e8c8e115bf66cb6008b77062 objtool, regulator: rk808: Remove potential undefined behavior in rk806_set_mode_dcdc()
date:   7 months ago
config: x86_64-randconfig-004-20251026 (https://download.01.org/0day-ci/archive/20251026/202510260435.79ThTwFt-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510260435.79ThTwFt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510260435.79ThTwFt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: cfi_probe_chip+0x7d: cfi_qry_mode_on() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_probe_chip+0x7f: unreachable instruction
   vmlinux.o: warning: objtool: cfi_probe_chip+0x81: skipping duplicate warning(s)
>> vmlinux.o: warning: objtool: cfi_staa_erase_varsize+0x4e3: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_staa_erase_varsize+0x4eb: unreachable instruction
   vmlinux.o: warning: objtool: cfi_staa_erase_varsize+0x4f5: skipping duplicate warning(s)
>> vmlinux.o: warning: objtool: cfi_staa_read+0x305: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_staa_read+0x30d: unreachable instruction
   vmlinux.o: warning: objtool: cfi_staa_read+0x312: skipping duplicate warning(s)
>> vmlinux.o: warning: objtool: cfi_staa_write_buffers+0x3b7: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_staa_write_buffers+0x3bf: unreachable instruction
   vmlinux.o: warning: objtool: cfi_staa_write_buffers+0x3c4: skipping duplicate warning(s)
>> vmlinux.o: warning: objtool: cfi_staa_lock+0x2b2: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_staa_lock+0x2b7: unreachable instruction
   vmlinux.o: warning: objtool: cfi_staa_lock+0x2bb: skipping duplicate warning(s)
>> vmlinux.o: warning: objtool: cfi_staa_unlock+0x1a4: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_staa_unlock+0x1a9: unreachable instruction
   vmlinux.o: warning: objtool: cfi_staa_unlock+0x1ae: skipping duplicate warning(s)
>> vmlinux.o: warning: objtool: cfi_staa_resume+0x12d: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_staa_resume+0x130: unreachable instruction
   vmlinux.o: warning: objtool: cfi_staa_resume+0x133: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: cfi_intelext_read+0x35e: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_intelext_read+0x361: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_read+0x364: skipping duplicate warning(s)
>> vmlinux.o: warning: objtool: cfi_intelext_write_words+0x296: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_intelext_write_words+0x299: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_write_words+0x29e: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: cfi_intelext_suspend+0x480: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_intelext_suspend+0x483: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_suspend+0x48d: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: cfi_intelext_resume+0x173: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_intelext_resume+0x176: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_resume+0x180: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: fixup_LH28F640BF+0x110: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: fixup_LH28F640BF+0x113: unreachable instruction
   vmlinux.o: warning: objtool: fixup_LH28F640BF+0x116: skipping duplicate warning(s)
>> vmlinux.o: warning: objtool: cfi_intelext_writev+0x4aa: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_intelext_writev+0x4ad: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_writev+0x4b2: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: inval_cache_and_wait_for_operation+0x6a: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: inval_cache_and_wait_for_operation+0x6f: unreachable instruction
   vmlinux.o: warning: objtool: inval_cache_and_wait_for_operation+0x73: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: put_chip+0x1d5: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: put_chip+0x1d8: unreachable instruction
   vmlinux.o: warning: objtool: put_chip+0x1dc: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: chip_ready+0x8d: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: chip_ready+0x92: unreachable instruction
   vmlinux.o: warning: objtool: chip_ready+0x97: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: fwh_xxlock_oneblock+0x168: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: fwh_xxlock_oneblock+0x16b: unreachable instruction
   vmlinux.o: warning: objtool: fwh_xxlock_oneblock+0x16e: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: cfi_intelext_point+0x538: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_intelext_point+0x53b: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_point+0x53e: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: cfi_intelext_reset+0x141: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: cfi_intelext_reset+0x144: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_reset+0x14e: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: do_erase_oneblock+0x1cd: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: do_erase_oneblock+0x1d0: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_oneblock+0x1d3: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: do_xxlock_oneblock+0x13d: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: do_xxlock_oneblock+0x140: unreachable instruction
   vmlinux.o: warning: objtool: do_xxlock_oneblock+0x143: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: do_getlockstatus_oneblock+0xd8: cfi_build_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: do_getlockstatus_oneblock+0xdd: unreachable instruction
   vmlinux.o: warning: objtool: do_getlockstatus_oneblock+0xdf: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: jedec_probe_chip+0x304: cfi_send_gen_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: jedec_probe_chip+0x308: unreachable instruction
   vmlinux.o: warning: objtool: jedec_probe_chip+0x310: skipping duplicate warning(s)
   vmlinux.o: warning: objtool: jedec_reset+0x88: cfi_send_gen_cmd() missing __noreturn in .c/.h or NORETURN() in noreturns.h
   vmlinux.o: warning: objtool: jedec_reset+0x8c: unreachable instruction
   vmlinux.o: warning: objtool: jedec_reset+0x90: skipping duplicate warning(s)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

