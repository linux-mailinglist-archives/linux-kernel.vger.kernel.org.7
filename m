Return-Path: <linux-kernel+bounces-848277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF55ABCD3EC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F14444FA107
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB6B2F25EC;
	Fri, 10 Oct 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvru5tPH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854E2882AC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102746; cv=none; b=Q3FfZT9MwwtmCz3Yvfh3opVikAlHJgr5vH2cEKvrAu6cGOcmVTz1DAI4c4F03SkBPnE08qV6UP52iEJ1ZZfgPFv313L5f2N7gMeF2IPrb98Fmub7zzxNkF3WnqkZgIK3pp9erd2Tdqzt3P5P8WyzcmMqIj8t7xdC0baHXjHX6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102746; c=relaxed/simple;
	bh=4F2SRBzxmu3JvDwmY3WVPqwLxAP2d+AYedOk6SXFiGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZyNTKTP4mPNUcvmFGabt4rk8OLOPXGmjiCF8EiXVi8Y50xDVkFyzt5MP6Tria5j0A+9/YAZm9SsbNTLp7jyygVPVw5oSTxDPucmRN27esNlCBmbdFhti3Vwq/QxDbVVLMgDz3A2aGJIT2daY4twHs5SqcrkVeG0AMsD37YsncvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvru5tPH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760102744; x=1791638744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4F2SRBzxmu3JvDwmY3WVPqwLxAP2d+AYedOk6SXFiGw=;
  b=cvru5tPHTH6+dZeDmmOYig1ktKMFr8DzmJPN6IC0hxkdSDYdiuuHDPxs
   bT4YFqSh/r1OfxRqLYQk62Qi3W0J2NYOf+mXWsCL2weMuPJEfps7YBv4i
   i/tMbeJsRP860YQyeir9yJw/eG1FlUOYtLYydcv8WO5YRRD4eqSqeC+jv
   0wcdF+pO3bHcxmdMIY5u/wWJTK8fXT5gSiEtMl/XGt8tETHKPGNqRkODx
   fuWjedzTrPTI0WJqQ6KmwvMpjtw3KGlTL6v+yHeHwu8o7J/4baiXpxQk3
   nTMe5SA+tPfQ3mDBkDQcDrcD1Kowxl1BKhnnLs+DHZCDpvWcd8fyMs4Vi
   Q==;
X-CSE-ConnectionGUID: Qjvmx26lSgG6GxTQ/ALwdQ==
X-CSE-MsgGUID: um1yzud2R3aYS+1E6z/JAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="79964623"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="79964623"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 06:25:43 -0700
X-CSE-ConnectionGUID: waBopMs+R0KuLOc+C4OYzw==
X-CSE-MsgGUID: HomKKlWjSqCSmfjhrbpjOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="181741347"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Oct 2025 06:25:42 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7D7s-0002mN-0B;
	Fri, 10 Oct 2025 13:25:40 +0000
Date: Fri, 10 Oct 2025 21:25:26 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:572:38: error: call to
 '__compiletime_assert_491' declared with attribute error: FIELD_PREP: value
 too large for the field
Message-ID: <202510102117.Jqxrw1vF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472d60c129f75282d94ae5ad072ee6dfb7c7246
commit: 32913fe7f71e72fb49033df35ec6388ff7b170ff mips: Add __attribute_const__ to ffs()-family implementations
date:   5 weeks ago
config: mips-randconfig-r133-20251010 (https://download.01.org/0day-ci/archive/20251010/202510102117.Jqxrw1vF-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510102117.Jqxrw1vF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510102117.Jqxrw1vF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/iio/adc/ti_am335x_adc.c: In function 'tiadc_step_config':
>> include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_491' declared with attribute error: FIELD_PREP: value too large for the field
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:553:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:572:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
      ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: in expansion of macro '__BF_FIELD_CHECK'
      __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
      ^~~~~~~~~~~~~~~~
   include/linux/mfd/ti_am335x_tscadc.h:58:29: note: in expansion of macro 'FIELD_PREP'
    #define STEPCONFIG_AVG(val) FIELD_PREP(GENMASK(4, 2), (val))
                                ^~~~~~~~~~
   drivers/iio/adc/ti_am335x_adc.c:127:17: note: in expansion of macro 'STEPCONFIG_AVG'
       stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
                    ^~~~~~~~~~~~~~


vim +/__compiletime_assert_491 +572 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  558  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  559  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  560  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  561  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  562  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  563   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  564   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  565   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  566   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  567   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  568   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  569   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  570   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  571  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @572  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  573  

:::::: The code at line 572 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

