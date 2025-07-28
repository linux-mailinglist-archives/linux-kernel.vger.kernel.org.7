Return-Path: <linux-kernel+bounces-748683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1037B144BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F061AA0370
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7D238174;
	Mon, 28 Jul 2025 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKdmePZb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C18225784;
	Mon, 28 Jul 2025 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753745878; cv=none; b=rWeC58dhlOhkbHltz16usQP0IlYLKuvWLR4+X+ydQ3LTdr+3mktnypx3rQQEQcAcR2spp9lQoydXSrY1nwlms3je/UrbErl3WAyHYcX3yeoJ2oTOtgxxISAsQItDOQrXq+2K4khwp/60ABCkqRGUIY9RT3tL1sEaoGtDZJHEppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753745878; c=relaxed/simple;
	bh=M9KO/2aYIoLlJKYj0B6g/Dtc60iGI3XL4WVkIVReWRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKZOqa47KoyYShK0FswXp02f+s6fF828V7P++WuLI5NaaCnW5m0ClQUKK03A/9DC8aLRbhGZSw22b1pohyizqajI3GWdRIYIgq2Z9UQgRuq694lwCIPBciF2t1VUAu+RSau5MBzvVU234y1/DE1zQ8Z1+AJFgZUhuPJMGn5oKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKdmePZb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753745876; x=1785281876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M9KO/2aYIoLlJKYj0B6g/Dtc60iGI3XL4WVkIVReWRc=;
  b=aKdmePZb0W5MwKHrylLZtxm/Q8mJ94vRDX33eOrDCUxemybeDM1h8UT4
   W/EG84AURDyelAASaygFBMnEGtwIsPEk/J3dVwdfMAJdlrKUrpHqAQ+wN
   KDNtIClKaqdB81l1ZsvaN14TLvFO1xD3a81gc91GSkBzLkkDuF3zKy2P0
   WUj43nN2kRcGeycLHUAKJPtPjTFgzvvPw638WGHS9d/xoiK9Qwlc0nDhA
   ZILfPBJgV8iO0CnIYgaH07ApZPlWv9t6FX1ctMs+snVzDtQwMoQp6XBZ2
   APLo5NpR//m7ZkOVHJgkjV34f3Y5SLVTIFq1yiQQYOqsaBWuG/62ZcS8x
   A==;
X-CSE-ConnectionGUID: 4M+yrrc2RFyunh6SmNEXJw==
X-CSE-MsgGUID: omhOuLmLSYq37lgeHMGOJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="78557780"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="78557780"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 16:37:56 -0700
X-CSE-ConnectionGUID: PC1Oj44zRXy0Y4pJHQBufw==
X-CSE-MsgGUID: +hKsHsYQR5qcGaeo+xhvlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="162113821"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Jul 2025 16:37:52 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugXPi-0000pJ-0o;
	Mon, 28 Jul 2025 23:37:50 +0000
Date: Tue, 29 Jul 2025 07:36:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	David Box <david.e.box@linux.intel.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/4] platform/x86: (ayn-ec) Add RGB Interface
Message-ID: <202507290730.7XZMyOM7-lkp@intel.com>
References: <20250726204041.516440-4-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726204041.516440-4-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.16 next-20250728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-ayn-ec-Add-PWM-Fan-HWMON-Interface/20250727-044332
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250726204041.516440-4-derekjohn.clark%40gmail.com
patch subject: [PATCH v3 3/4] platform/x86: (ayn-ec) Add RGB Interface
config: i386-randconfig-061-20250728 (https://download.01.org/0day-ci/archive/20250729/202507290730.7XZMyOM7-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290730.7XZMyOM7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507290730.7XZMyOM7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/platform/x86/ayn-ec.c:87:5: sparse: sparse: symbol 'ayn_pwm_curve_registers' was not declared. Should it be static?
>> drivers/platform/x86/ayn-ec.c:753:18: sparse: sparse: symbol 'ayn_led_mc_subled_info' was not declared. Should it be static?
>> drivers/platform/x86/ayn-ec.c:774:24: sparse: sparse: symbol 'ayn_led_mc' was not declared. Should it be static?

vim +/ayn_led_mc_subled_info +753 drivers/platform/x86/ayn-ec.c

   752	
 > 753	struct mc_subled ayn_led_mc_subled_info[] = {
   754		{
   755			.color_index = LED_COLOR_ID_RED,
   756			.brightness = 0,
   757			.intensity = 0,
   758			.channel = AYN_LED_MC_RED_REG,
   759		},
   760		{
   761			.color_index = LED_COLOR_ID_GREEN,
   762			.brightness = 0,
   763			.intensity = 0,
   764			.channel = AYN_LED_MC_GREEN_REG,
   765		},
   766		{
   767			.color_index = LED_COLOR_ID_BLUE,
   768			.brightness = 0,
   769			.intensity = 0,
   770			.channel = AYN_LED_MC_BLUE_REG,
   771		},
   772	};
   773	
 > 774	struct led_classdev_mc ayn_led_mc = {
   775		.led_cdev = {
   776			.name = "ayn:rgb:joystick_rings",
   777			.brightness = 0,
   778			.max_brightness = 255,
   779			.brightness_set = ayn_led_mc_brightness_set,
   780			.brightness_get = ayn_led_mc_brightness_get,
   781			.color = LED_COLOR_ID_RGB,
   782		},
   783		.num_colors = ARRAY_SIZE(ayn_led_mc_subled_info),
   784		.subled_info = ayn_led_mc_subled_info,
   785	};
   786	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

