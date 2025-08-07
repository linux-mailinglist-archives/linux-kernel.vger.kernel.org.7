Return-Path: <linux-kernel+bounces-759251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193CB1DB00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540BB7B34EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF5262FE4;
	Thu,  7 Aug 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFIrEp9B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA11C5D72;
	Thu,  7 Aug 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581733; cv=none; b=opy0MyqifwWzuO2fy4Ep1Wrmniub1rvwdvcwCPaC2knefr/17etDmCeB8udBI7vpWoeIxNFxvkRwiTlb8yyxMHewcs92t3gA2pvKY0lMgQvfkA1RoM3j2+HImD8a0V7/9oqphLVMJDzY9fkGh+kEap/qXC9vm6XcNDCPYQsIqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581733; c=relaxed/simple;
	bh=t2isChxoZmZHcVZWs0H8jL1QOW+h0x2ii/7YPK7/tqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXtEWlZvmZXATSq0B/xf2m3IGxDcU4vkWxs6mJbAfms0x0wHSR4A+PAILei47v+FaNC9KaCWTilmPwQg3vKHZDpVnRM53asZyxCoQqIkYFJKyWwnFATsnkpHhtO32QPlHwolW4pQeLcKQc5WFKUv6VTOsPLHB5tJIbLDZf1MGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFIrEp9B; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754581730; x=1786117730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t2isChxoZmZHcVZWs0H8jL1QOW+h0x2ii/7YPK7/tqQ=;
  b=WFIrEp9Bwy9S/5y66vDklufZD8AXvVoO2UiHcFylh7ZU18y16JKsB5i0
   b+FRkxw5s67hYts9o6Pcxz2Dbbi4W+gCyk3XSwBrJnEbQcvogOSjVn0dP
   JuBqwzR+Po2GF+iQZGCUg7KJgP+dJ4dpDHW472d0aqLB7NV1yg1q0So1Q
   8G9Zpw5YIayAgdfY94hXXwmVahhKzxGe72EUyD0dowObsQ3KBufvuGTtX
   NEbfG69L0jzUEwv/Y0RkIAuSbH25/ezhUhVj3UFpUyw4VMWjApeceTf47
   +QyrGO+yNVo1DdXJV0HBTX+IFZJ2qv31A261CyXPx+dznr7WTOTVmoT/r
   Q==;
X-CSE-ConnectionGUID: KMCCa7RaR9+vtvFgaQ6heA==
X-CSE-MsgGUID: Ua2hOEIkQtWUzvZIet7DTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60767582"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="60767582"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 08:48:50 -0700
X-CSE-ConnectionGUID: BY5hG06OTfOL7QAQywpv+Q==
X-CSE-MsgGUID: +Sf8aCMDT/OsviQNwBC+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170353220"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 07 Aug 2025 08:48:48 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uk2rF-0002vu-1n;
	Thu, 07 Aug 2025 15:48:45 +0000
Date: Thu, 7 Aug 2025 23:48:44 +0800
From: kernel test robot <lkp@intel.com>
To: Denis Benato <benato.denis96@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com, "Luke D . Jones" <luke@ljones.dev>,
	Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH v10 2/8] platform/x86: asus-armoury: move existing
 tunings to asus-armoury module
Message-ID: <202508072334.8n7nwIG3-lkp@intel.com>
References: <20250806135319.1205762-3-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806135319.1205762-3-benato.denis96@gmail.com>

Hi Denis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16 next-20250807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Denis-Benato/platform-x86-asus-wmi-export-symbols-used-for-read-write-WMI/20250806-215748
base:   linus/master
patch link:    https://lore.kernel.org/r/20250806135319.1205762-3-benato.denis96%40gmail.com
patch subject: [PATCH v10 2/8] platform/x86: asus-armoury: move existing tunings to asus-armoury module
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250807/202508072334.8n7nwIG3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508072334.8n7nwIG3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508072334.8n7nwIG3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/platform/x86/asus-armoury.c:28:
>> include/linux/platform_data/x86/asus-wmi.h:199:35: warning: 'asus_use_hid_led_dmi_ids' defined but not used [-Wunused-const-variable=]
     199 | static const struct dmi_system_id asus_use_hid_led_dmi_ids[] = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/asus_use_hid_led_dmi_ids +199 include/linux/platform_data/x86/asus-wmi.h

ffb6ce7086ee2d Daniel Drake  2018-10-09  196  
a720dee5e03923 Luke D. Jones 2024-07-13  197  /* To be used by both hid-asus and asus-wmi to determine which controls kbd_brightness */
9d3b02ad9b1d1f Luke D. Jones 2025-08-06  198  #if IS_REACHABLE(CONFIG_ASUS_WMI) || IS_REACHABLE(CONFIG_HID_ASUS)
a720dee5e03923 Luke D. Jones 2024-07-13 @199  static const struct dmi_system_id asus_use_hid_led_dmi_ids[] = {
a720dee5e03923 Luke D. Jones 2024-07-13  200  	{
a720dee5e03923 Luke D. Jones 2024-07-13  201  		.matches = {
a720dee5e03923 Luke D. Jones 2024-07-13  202  			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Zephyrus"),
a720dee5e03923 Luke D. Jones 2024-07-13  203  		},
a720dee5e03923 Luke D. Jones 2024-07-13  204  	},
a720dee5e03923 Luke D. Jones 2024-07-13  205  	{
a720dee5e03923 Luke D. Jones 2024-07-13  206  		.matches = {
a720dee5e03923 Luke D. Jones 2024-07-13  207  			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Strix"),
a720dee5e03923 Luke D. Jones 2024-07-13  208  		},
a720dee5e03923 Luke D. Jones 2024-07-13  209  	},
a720dee5e03923 Luke D. Jones 2024-07-13  210  	{
a720dee5e03923 Luke D. Jones 2024-07-13  211  		.matches = {
a720dee5e03923 Luke D. Jones 2024-07-13  212  			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Flow"),
a720dee5e03923 Luke D. Jones 2024-07-13  213  		},
a720dee5e03923 Luke D. Jones 2024-07-13  214  	},
53078a736fbc60 Luke D. Jones 2025-01-11  215  	{
53078a736fbc60 Luke D. Jones 2025-01-11  216  		.matches = {
53078a736fbc60 Luke D. Jones 2025-01-11  217  			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt P16"),
53078a736fbc60 Luke D. Jones 2025-01-11  218  		},
53078a736fbc60 Luke D. Jones 2025-01-11  219  	},
a720dee5e03923 Luke D. Jones 2024-07-13  220  	{
a720dee5e03923 Luke D. Jones 2024-07-13  221  		.matches = {
a720dee5e03923 Luke D. Jones 2024-07-13  222  			DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
a720dee5e03923 Luke D. Jones 2024-07-13  223  		},
a720dee5e03923 Luke D. Jones 2024-07-13  224  	},
a720dee5e03923 Luke D. Jones 2024-07-13  225  	{
a720dee5e03923 Luke D. Jones 2024-07-13  226  		.matches = {
a720dee5e03923 Luke D. Jones 2024-07-13  227  			DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
a720dee5e03923 Luke D. Jones 2024-07-13  228  		},
a720dee5e03923 Luke D. Jones 2024-07-13  229  	},
a720dee5e03923 Luke D. Jones 2024-07-13  230  	{
a720dee5e03923 Luke D. Jones 2024-07-13  231  		.matches = {
a720dee5e03923 Luke D. Jones 2024-07-13  232  			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
a720dee5e03923 Luke D. Jones 2024-07-13  233  		},
a720dee5e03923 Luke D. Jones 2024-07-13  234  	},
a720dee5e03923 Luke D. Jones 2024-07-13  235  	{ },
a720dee5e03923 Luke D. Jones 2024-07-13  236  };
9d3b02ad9b1d1f Luke D. Jones 2025-08-06  237  #endif
a720dee5e03923 Luke D. Jones 2024-07-13  238  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

