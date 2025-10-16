Return-Path: <linux-kernel+bounces-855737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40429BE225F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 229024EBFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1330504C;
	Thu, 16 Oct 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnmQVCPg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C32FDC4E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603366; cv=none; b=o4eY+foie5BYH9WQJAJi9u+Fo9jwe1aqLbpxr9Vy1OwNBv5WwzuQdzp5XIT0RM5T12KJgFQjadp6YtPXueZ5UgqbtsqbgTuHmWAfiBx7MLoL6Bv0aUzfy7pQnBud9mlL7TUci1OK8cNY++QiEA/MYH3IFe7yBFkFQMlKj6SnFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603366; c=relaxed/simple;
	bh=NRqMCO2UD2ZElId4/sDDauUesnj09RgQKU3DA85pH7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXWT+QGeAcXQAhGeEWwEPi7pT/pbYr6U1HcjrmjgDpE/tTR6Jm0OoXgdZS+ubPS++yYP7X0Pg20xMFlhst4ECPh4sFd5mItbD1OtAfE09TwqQ5c+UwsCBMpNMcjhTgt1+8YIu3sreqS+wynXjNrluU7RH3LcUGFEGqL2Ad7R3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnmQVCPg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760603364; x=1792139364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NRqMCO2UD2ZElId4/sDDauUesnj09RgQKU3DA85pH7U=;
  b=YnmQVCPg0TZu5QsQzi0yA/QRzjYTBNgg95i+s6WORwOo76od/w0xeQhx
   tvi3xBa8LlcsICcwcj5w+yuj6JzfNv1CaGumaQRJNY+f7BT+YmQvahBJJ
   NHn5zljbPjkjXWEWLI6mOPXsYzosdH0UXbQYr7TYfDwaqjzMr7AhjFfaF
   slt4rLvg41rN0vMMoJisPtoB6jdMTdAzl6+CMHsnb4Y2ZNqvDARliOVYM
   aGuJTVjnvoYMHEj34Q2JtZdDg4C08f7rXWh1vzrWeDE1QtvwsWTj9sgG4
   XvyAMF3npbgalSZXQSJ4PAGCz5+cp3K9y5ubPw98BeFE8ilE4dYIwugbe
   g==;
X-CSE-ConnectionGUID: 9cB6qO53T1y1cAX+mS3pfA==
X-CSE-MsgGUID: KG/PyJ8ISHy6c/2vqIjqtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="66439708"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="66439708"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 01:29:23 -0700
X-CSE-ConnectionGUID: m0sBl1kLTqOn+kmk8/YFNg==
X-CSE-MsgGUID: hmBJhFAFSheM3NYWWDHmJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="182072902"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 16 Oct 2025 01:29:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9JML-0004bH-2v;
	Thu, 16 Oct 2025 08:29:17 +0000
Date: Thu, 16 Oct 2025 16:29:00 +0800
From: kernel test robot <lkp@intel.com>
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, nd@arm.com,
	Boris Brezillon <bbrezillon@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/10] drm/panthor: Implement L2 power on/off via
 PWR_CONTROL
Message-ID: <202510161626.f3OG4u62-lkp@intel.com>
References: <20251014094337.1009601-7-karunika.choo@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014094337.1009601-7-karunika.choo@arm.com>

Hi Karunika,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.18-rc1 next-20251015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Karunika-Choo/drm-panthor-Factor-out-GPU_ID-register-read-into-separate-function/20251014-174729
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20251014094337.1009601-7-karunika.choo%40arm.com
patch subject: [PATCH v1 06/10] drm/panthor: Implement L2 power on/off via PWR_CONTROL
config: arm-randconfig-r132-20251016 (https://download.01.org/0day-ci/archive/20251016/202510161626.f3OG4u62-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161626.f3OG4u62-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161626.f3OG4u62-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/panthor/panthor_pwr.c:153:13: warning: shift count >= width of type [-Wshift-count-overflow]
     152 |         ret = gpu_read64_poll_timeout(ptdev, pwrtrans_reg, val,
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     153 |                                       !(PWR_ALL_CORES_MASK & val), 100,
         |                                       ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     154 |                                       timeout_us);
         |                                       ~~~~~~~~~~~
   drivers/gpu/drm/panthor/panthor_pwr.c:26:29: note: expanded from macro 'PWR_ALL_CORES_MASK'
      26 | #define PWR_ALL_CORES_MASK              GENMASK(63, 0)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   drivers/gpu/drm/panthor/panthor_device.h:533:37: note: expanded from macro 'gpu_read64_poll_timeout'
     533 |         read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     534 |                           dev, reg)
         |                           ~~~~~~~~~
   include/linux/iopoll.h:145:36: note: expanded from macro 'read_poll_timeout'
     145 |         poll_timeout_us((val) = op(args), cond, sleep_us, timeout_us, sleep_before_read)
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/iopoll.h:49:7: note: expanded from macro 'poll_timeout_us'
      49 |                 if (cond) { \
         |                     ^~~~
   drivers/gpu/drm/panthor/panthor_pwr.c:260:13: warning: shift count >= width of type [-Wshift-count-overflow]
     259 |         ret = gpu_read64_poll_timeout(ptdev, PWR_STATUS, val,
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     260 |                                       !(PWR_STATUS_RETRACT_PENDING & val), 0,
         |                                       ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     261 |                                       PWR_RETRACT_TIMEOUT_US);
         |                                       ~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panthor/panthor_regs.h:249:40: note: expanded from macro 'PWR_STATUS_RETRACT_PENDING'
     249 | #define   PWR_STATUS_RETRACT_PENDING                    BIT(43)
         |                                                         ^
   include/vdso/bits.h:7:26: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^
   drivers/gpu/drm/panthor/panthor_device.h:533:37: note: expanded from macro 'gpu_read64_poll_timeout'
     533 |         read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     534 |                           dev, reg)
         |                           ~~~~~~~~~
   include/linux/iopoll.h:145:36: note: expanded from macro 'read_poll_timeout'
     145 |         poll_timeout_us((val) = op(args), cond, sleep_us, timeout_us, sleep_before_read)
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/iopoll.h:49:7: note: expanded from macro 'poll_timeout_us'
      49 |                 if (cond) { \
         |                     ^~~~
   2 warnings generated.


vim +153 drivers/gpu/drm/panthor/panthor_pwr.c

   144	
   145	static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32 domain,
   146						      u32 timeout_us)
   147	{
   148		u32 pwrtrans_reg = get_domain_pwrtrans_reg(domain);
   149		u64 val;
   150		int ret = 0;
   151	
   152		ret = gpu_read64_poll_timeout(ptdev, pwrtrans_reg, val,
 > 153					      !(PWR_ALL_CORES_MASK & val), 100,
   154					      timeout_us);
   155		if (ret) {
   156			drm_err(&ptdev->base, "%s domain power in transition, pwrtrans(0x%llx)",
   157				get_domain_name(domain), val);
   158			return ret;
   159		}
   160	
   161		return 0;
   162	}
   163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

