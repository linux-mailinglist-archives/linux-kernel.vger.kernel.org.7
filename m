Return-Path: <linux-kernel+bounces-766139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2352B242C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7C17E21E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD16B2D73AC;
	Wed, 13 Aug 2025 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdtdKeuq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84162D46A9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070118; cv=none; b=ZHgDGY+8Uo5biGp71SEc6e9ju6Tqfzlh4+NcoYJOqLOL6YyVg/zU09uBxC1/iLja/ku/4lG2Y4/dggpgJhC2NrxWblI3EoKnRlc8EFqnDeU7rpez5cAD/caF/mSB0HjPZ5JAVLFTytV/2TIbj8b//UFqwbtAOjvnxSSR140B+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070118; c=relaxed/simple;
	bh=zlmPGoHmw/tgtRKRutWE9DSu5b5DAhTHzefm1AQUQlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RKGmrd9UI6tw2tiu70K2pqirzeiBwyn0fy9Xgzq9DaxzFJFipcmY2jNfgUCQgZtiKpTJuxhSTYSkh+2IdqOQrfGQHwYkDwuTaWMEg3V+FmIek4WSjSq6QdP9CLWH5XPfQxr3dCxJzpYSQsHCJAE6dXeMgO2E2DkapbNhRRkRy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdtdKeuq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755070117; x=1786606117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zlmPGoHmw/tgtRKRutWE9DSu5b5DAhTHzefm1AQUQlw=;
  b=LdtdKeuqGnJNd4RZaN2FPmeO3zNtKOViQxPjThC7H9iwoOOgxr6KYxqT
   eTQBUx9G/es88l5DoNiF0cv6L+tSnKdbdfQqAqQb/Gcy6KO+9uJHEilGi
   97csstLT8GTqHc7ylXLvuCWmWJj7V5T7PsmaSSL5zVvijVc/9l9FJd+Gc
   QDSzrHovfxuoV1klJ7as8Ah2HYhEX5x1IcMfxYqy5Tk8E9HauMCKAKpZs
   V8uCGt7MxeBy9R2k2fz5w8GK+e7GaTtAF4fIcr/YcEWT67zP+r/VCXwm0
   RMHjQpNwk62PEwUVJozpFEfTk8+xbBMnSeByyjZCiVbTyLoCMMN72fSxP
   Q==;
X-CSE-ConnectionGUID: JZP91pttSXSB30vo14DAOw==
X-CSE-MsgGUID: 9ZWoB8h9R46YNLZ9zSsxew==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57434864"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57434864"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:28:37 -0700
X-CSE-ConnectionGUID: TA2CZ4SfQbiA+DDUTvUZKA==
X-CSE-MsgGUID: yQZBlN7fRgOqkUppk0f6jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="171658530"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 13 Aug 2025 00:28:35 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1um5uS-0009eu-35;
	Wed, 13 Aug 2025 07:28:32 +0000
Date: Wed, 13 Aug 2025 15:27:46 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: ERROR: modpost: "devm_gpiochip_add_data_with_key"
 [drivers/iio/adc/rohm-bd79124.ko] undefined!
Message-ID: <202508131533.5sSkq80B-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matti,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8742b2d8935f476449ef37e263bc4da3295c7b58
commit: 3f57a3b9ab74e8b6e00198af86ba41dcffa5509b iio: adc: Support ROHM BD79124 ADC
date:   4 months ago
config: csky-randconfig-r123-20250813 (https://download.01.org/0day-ci/archive/20250813/202508131533.5sSkq80B-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250813/202508131533.5sSkq80B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508131533.5sSkq80B-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
>> ERROR: modpost: "devm_gpiochip_add_data_with_key" [drivers/iio/adc/rohm-bd79124.ko] undefined!
>> ERROR: modpost: "gpiochip_get_data" [drivers/iio/adc/rohm-bd79124.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
   Depends on [n]: GPIOLIB [=n] || NEW_LEDS [=y] && GPIOLIB [=n]
   Selected by [y]:
   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

