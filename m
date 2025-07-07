Return-Path: <linux-kernel+bounces-720432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FEDAFBB98
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23977188FBB2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E8265CCB;
	Mon,  7 Jul 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xxp4S3Fg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9831265288
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915601; cv=none; b=AXcjujyvh0rvwnTXZFxH5FA5INfb7KZ318ciFG5FBjW7n24ykRDJ6zVmyz1Bo5rzCYzocGT4gO6i0v400kRZ7zcMqRNn0N016YcR6UdCY+lIwhYY1bBpZyh9z1+M4FpvACJ4x/AOl6RNiOQnpqfQ1ZLUaGk0t4/woJ73nWCr0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915601; c=relaxed/simple;
	bh=q075Lf2icGWDq5hYoOOTF4GRd9e4zdBmS++T0iJcauY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kfZpy1jEyO/x8LVqN2COeSDSv4FjC5dGcToMwkrgwV6HsbOeTjguWYKdn0Y0o07ESk/S7CTp0WCjE91TPwXNgG7v2LfS4X+BzjyQsSCJk9rIzAYQw0v0YwJRVOkcT7SCoeu7/OHFxvbQdWwMZ+CapvYyehi+zQKJHEEhwx/cZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xxp4S3Fg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751915600; x=1783451600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q075Lf2icGWDq5hYoOOTF4GRd9e4zdBmS++T0iJcauY=;
  b=Xxp4S3FgPCZm+uO/GWcBz/fSpYntnFjEvLxqFO91lx+x6Y0wy5PyQNLY
   RTI6QDU3u4QhnAqDp+E3Oip2allzinc/NBO6CBqmDq9n6rE846ThCL/Vx
   KQZJNoIyYetiApDqv/yLZjyM/8dyU0/iZI1jVBlvjYIZkoQblObWE/ndS
   PqWEKMRBx+BiISaH1KW9gPlpt490tAHr7Miw/2n1VUMgNtxCke1KWDshk
   c0G5mF5KJouGHqskJaXPWKWXKnx/LS+JlKnNOi6njsgB2U9U31TlzZcQH
   XbNrVeno/UAky2GBDSmkH3y7d1hUPaM20d5td8pxhAq+hShSUoCeiKu1b
   g==;
X-CSE-ConnectionGUID: 4HHHXxVSQdyzoE3uhzq8Vg==
X-CSE-MsgGUID: NV592kjDQR2wZrTqmiyd8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65206110"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="65206110"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:13:20 -0700
X-CSE-ConnectionGUID: DS73QkxCSmWNIEqxDiNpbQ==
X-CSE-MsgGUID: 0qHqrZVwRSS7e8TZ5J2olA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="155418156"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Jul 2025 12:13:18 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYrH9-0000fr-0w;
	Mon, 07 Jul 2025 19:13:15 +0000
Date: Tue, 8 Jul 2025 03:12:19 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:timers/ptp 39/39] lib/vdso/gettimeofday.c:335:17: warning:
 shift count >= width of type
Message-ID: <202507080348.hKtUspGk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/ptp
head:   7893ea1006fcbb876ddf53ad4ebba4a054add4b2
commit: 7893ea1006fcbb876ddf53ad4ebba4a054add4b2 [39/39] vdso/gettimeofday: Add support for auxiliary clocks
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20250708/202507080348.hKtUspGk-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250708/202507080348.hKtUspGk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507080348.hKtUspGk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:4:
>> lib/vdso/gettimeofday.c:335:17: warning: shift count >= width of type [-Wshift-count-overflow]
     335 |         else if (msk & VDSO_AUX)
         |                        ^~~~~~~~
   include/vdso/datapage.h:50:18: note: expanded from macro 'VDSO_AUX'
      50 | #define VDSO_AUX        __GENMASK(CLOCK_AUX_LAST, CLOCK_AUX)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:7:56: note: expanded from macro '__GENMASK'
       7 | #define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                                                        ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <built-in>:4:
   lib/vdso/gettimeofday.c:481:19: warning: shift count >= width of type [-Wshift-count-overflow]
     481 |         } else if (msk & VDSO_AUX) {
         |                          ^~~~~~~~
   include/vdso/datapage.h:50:18: note: expanded from macro 'VDSO_AUX'
      50 | #define VDSO_AUX        __GENMASK(CLOCK_AUX_LAST, CLOCK_AUX)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:7:56: note: expanded from macro '__GENMASK'
       7 | #define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                                                        ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.
--
   In file included from <built-in>:4:
>> lib/vdso/gettimeofday.c:335:17: warning: shift count >= width of type [-Wshift-count-overflow]
     335 |         else if (msk & VDSO_AUX)
         |                        ^~~~~~~~
   include/vdso/datapage.h:50:18: note: expanded from macro 'VDSO_AUX'
      50 | #define VDSO_AUX        __GENMASK(CLOCK_AUX_LAST, CLOCK_AUX)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:7:56: note: expanded from macro '__GENMASK'
       7 | #define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                                                        ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <built-in>:4:
   lib/vdso/gettimeofday.c:481:19: warning: shift count >= width of type [-Wshift-count-overflow]
     481 |         } else if (msk & VDSO_AUX) {
         |                          ^~~~~~~~
   include/vdso/datapage.h:50:18: note: expanded from macro 'VDSO_AUX'
      50 | #define VDSO_AUX        __GENMASK(CLOCK_AUX_LAST, CLOCK_AUX)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:7:56: note: expanded from macro '__GENMASK'
       7 | #define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                                                        ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +335 lib/vdso/gettimeofday.c

   313	
   314	static __always_inline bool
   315	__cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
   316				     struct __kernel_timespec *ts)
   317	{
   318		const struct vdso_clock *vc = vd->clock_data;
   319		u32 msk;
   320	
   321		if (!vdso_clockid_valid(clock))
   322			return false;
   323	
   324		/*
   325		 * Convert the clockid to a bitmask and use it to check which
   326		 * clocks are handled in the VDSO directly.
   327		 */
   328		msk = 1U << clock;
   329		if (likely(msk & VDSO_HRES))
   330			vc = &vc[CS_HRES_COARSE];
   331		else if (msk & VDSO_COARSE)
   332			return do_coarse(vd, &vc[CS_HRES_COARSE], clock, ts);
   333		else if (msk & VDSO_RAW)
   334			vc = &vc[CS_RAW];
 > 335		else if (msk & VDSO_AUX)
   336			return do_aux(vd, clock, ts);
   337		else
   338			return false;
   339	
   340		return do_hres(vd, vc, clock, ts);
   341	}
   342	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

