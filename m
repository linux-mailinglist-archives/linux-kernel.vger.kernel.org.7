Return-Path: <linux-kernel+bounces-737881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3DB0B17C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA626189CDED
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2570B21D3E1;
	Sat, 19 Jul 2025 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYf0SilD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91662557A
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752950813; cv=none; b=iU2nzSt9gg/QZxHLg4b+ga5bMoBfmDMbAJHWGYlj8g33QDedB46euF7BTinLClpFCykbPl6/5zWAkPbTHxsGJVowx99NERV4ZPAO7Sfnm6fNEdEuwwlXa2RA8/HUxBQEChMdbR7rAU7Yb87SCLHBF5LANnP7+SR6xurIUyNKBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752950813; c=relaxed/simple;
	bh=pbiY1fI0+GXcNCMxaeSTCJmmo0VQsgsF5nT9YCJ4SNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm3DZvN5rAdW5YOsBNxvsnLATeThHX0CRyS2Wyu//jq22H45HpFyq1o7NC28fyfT3aUVj+qdVNN7iYeo3f0tquik6HKUvLfFU26U3Con6ZfOh75SQtdSwxpaSmjxJz3x0QdQYNjPuPb2M44EGZwMuQtWJJotX+XTQCa09jhSYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYf0SilD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752950812; x=1784486812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pbiY1fI0+GXcNCMxaeSTCJmmo0VQsgsF5nT9YCJ4SNk=;
  b=jYf0SilDtOckvBop32awlcRR7Pp5WOu4t/UwOFfKnC4oXQWd0B005AKm
   pD9V9E8EBbnITb3hWacWWaRgJwWEr4lyFHmtjjKmYnDXI8/k3VGIkJ9iS
   tLJaG54lcJv3Mw1sdG8YNfrua0e8SN3tvi3YAU1Fp7jImay0+3ejCzbXg
   D//CnZ5mhnPY8Pd4hP+L64dcNDIITIY4AkJfYQARlY1LB86JjK9cSnGpS
   0MN+v5flIHxJ90bWc5W4lGJAUdMA4rMPAdTwA59VU3e1bN5hCmycmTHbD
   IyjRGIdkhl4A6xhaGoEnwSLJ4kO+EvphU31Gc6e0j2m/HFcc9twaakOV9
   A==;
X-CSE-ConnectionGUID: aXSrc7wFSDqoFlWIdmtxGQ==
X-CSE-MsgGUID: yZWTwqXQTfe5gmdjhnkLPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="72782699"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="72782699"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 11:46:51 -0700
X-CSE-ConnectionGUID: Rmoe0PGRS46RBB4Ti1+FJw==
X-CSE-MsgGUID: LhSVHur1QzSINH6rBpVgmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="163982878"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Jul 2025 11:46:50 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udCa7-000FiZ-2O;
	Sat, 19 Jul 2025 18:46:47 +0000
Date: Sun, 20 Jul 2025 02:46:03 +0800
From: kernel test robot <lkp@intel.com>
To: jeff_chang@richtek.com, lgirdwood@gmail.com, broonie@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, jeff_chang@richtek.com
Subject: Re: [PATCH v2] regulator: rt5133: Add RT5133 PMIC regulator Support
Message-ID: <202507200210.ywA4tFPm-lkp@intel.com>
References: <20250718081052.2685826-1-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718081052.2685826-1-jeff_chang@richtek.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-regulator/for-next]
[also build test WARNING on linus/master v6.16-rc6 next-20250718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jeff_chang-richtek-com/regulator-rt5133-Add-RT5133-PMIC-regulator-Support/20250718-161216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20250718081052.2685826-1-jeff_chang%40richtek.com
patch subject: [PATCH v2] regulator: rt5133: Add RT5133 PMIC regulator Support
config: alpha-kismet-CONFIG_GPIO_SYSCON-CONFIG_GPIO_SAMA5D2_PIOBU-0-0 (https://download.01.org/0day-ci/archive/20250720/202507200210.ywA4tFPm-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250720/202507200210.ywA4tFPm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507200210.ywA4tFPm-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GPIO_SYSCON when selected by GPIO_SAMA5D2_PIOBU
   WARNING: unmet direct dependencies detected for OF_GPIO
     Depends on [n]: GPIOLIB [=y] && OF [=n] && HAS_IOMEM [=y]
     Selected by [y]:
     - REGULATOR_RT5133 [=y] && REGULATOR [=y] && I2C [=y] && GPIOLIB [=y]
   
   WARNING: unmet direct dependencies detected for MFD_STMFX
     Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
     Selected by [y]:
     - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && OF_GPIO [=y]
   
   WARNING: unmet direct dependencies detected for GPIO_SYSCON
     Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF [=n]
     Selected by [y]:
     - GPIO_SAMA5D2_PIOBU [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && MFD_SYSCON [=y] && OF_GPIO [=y] && (ARCH_AT91 || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

