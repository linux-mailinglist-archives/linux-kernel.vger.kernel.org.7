Return-Path: <linux-kernel+bounces-779327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F91B2F2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B060169648
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C848D2EB853;
	Thu, 21 Aug 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OR9sMzoa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA22EAB7C;
	Thu, 21 Aug 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765686; cv=none; b=DrxDVPw6y5KXj4quXFhvs0wSSZkcrELO7OZxOHg2IZQzniMcSoh75X5lc8o6XTHy6u9w9fORiErPFUztqUJtE3ijk7Ie8H15FzwuGEPK48C16J9ReomD5xUhCGqhDQ4XDojpIVwjoM37QFNkzUfk1UmUA41x7o3vUX/mF3TXuGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765686; c=relaxed/simple;
	bh=n1jvE7GQvNq+ke5s5OIhDsUmMtDBv0GtY6vWyj5QfNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJfzg2Icr8DXhvOaqIxqwJm1FZS6ltAF0InjvmkH4TuwWIfTOy8zMIM0dk4f9Q75/+W95oXvSmh+m4oKVQft0TetTvHpAKOt1lJfy+mBkG5vpOYXj1ensy2RyJECaxZAQlR+dMtyFC4ZwjD0t8BTTc/kB3mem9BOi9CFODzmoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OR9sMzoa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755765685; x=1787301685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n1jvE7GQvNq+ke5s5OIhDsUmMtDBv0GtY6vWyj5QfNo=;
  b=OR9sMzoa8QkoX9d94YD6nsUoI1vbUp3Yt+7Fw/dugh+FoqMNA31b+hWI
   8ky9V0ocKtz4lTZQAq2SK9CFLrmQVoRZS01qah+PInhMsx158frtrCT/I
   x/24cs7NVnTArAQ+7StQSifKR2TxMCKp8uKJ9ppASZ3gmuiYqCCAuLVe2
   yJ9mXFNNoY5sxWBNstEjHoW695+BWkO/JMhDXIffQMDG94eiHAN778iPO
   8ulBEaUcHEvkYW203RWgJC060GYBSLPTKnF/QHz8P0a9ukdgSDiXXloq7
   8Yp3IeO3ihnoGND/JxcNeGvC/Q7vTbe56PYLmNM5xTlU34wmxxvTBD3ge
   Q==;
X-CSE-ConnectionGUID: a2aQO2zoSJS1YhlHDDwLLQ==
X-CSE-MsgGUID: 6adtBzygSC6wUJrxRinRoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69488927"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69488927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:41:22 -0700
X-CSE-ConnectionGUID: 6fnUNu6/SsWDcIXzDofbaw==
X-CSE-MsgGUID: 7GhbDLjtT5ahcqKwb2KLOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167583175"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 Aug 2025 01:41:20 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up0rF-000K6j-0p;
	Thu, 21 Aug 2025 08:41:17 +0000
Date: Thu, 21 Aug 2025 16:41:06 +0800
From: kernel test robot <lkp@intel.com>
To: Antheas Kapenekakis <lkml@antheas.dev>,
	platform-driver-x86@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: Re: [PATCH v1 4/5] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
Message-ID: <202508211640.8MtPueLL-lkp@intel.com>
References: <20250820160628.99678-5-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820160628.99678-5-lkml@antheas.dev>

Hi Antheas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Antheas-Kapenekakis/platform-x86-ayaneo-ec-Add-Ayaneo-Embedded-Controller-platform-driver/20250821-002525
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250820160628.99678-5-lkml%40antheas.dev
patch subject: [PATCH v1 4/5] platform/x86: ayaneo-ec: Add controller power and modules attributes
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250821/202508211640.8MtPueLL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250821/202508211640.8MtPueLL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508211640.8MtPueLL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/ayaneo-ec.c:395:12: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     395 |                 else if (sysfs_streq(buf, "off"))
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/ayaneo-ec.c:397:7: note: uninitialized use occurs here
     397 |                 if (ret)
         |                     ^~~
   drivers/platform/x86/ayaneo-ec.c:395:8: note: remove the 'if' if its condition is always true
     395 |                 else if (sysfs_streq(buf, "off"))
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
     396 |                         ret = ec_write(AYANEO_POWER_REG, AYANEO_POWER_OFF);
   drivers/platform/x86/ayaneo-ec.c:389:9: note: initialize the variable 'ret' to silence this warning
     389 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +395 drivers/platform/x86/ayaneo-ec.c

   382	
   383	static ssize_t current_value_store(struct kobject *kobj,
   384					   struct kobj_attribute *attr, const char *buf,
   385					   size_t count)
   386	{
   387		struct ayaneo_fw_attr *fw_attr =
   388			container_of(attr, struct ayaneo_fw_attr, current_value);
   389		int ret;
   390	
   391		switch (fw_attr->fw_attr_id) {
   392		case AYANEO_ATTR_CONTROLLER_POWER:
   393			if (sysfs_streq(buf, "on"))
   394				ret = ec_write(AYANEO_POWER_REG, AYANEO_POWER_ON);
 > 395			else if (sysfs_streq(buf, "off"))
   396				ret = ec_write(AYANEO_POWER_REG, AYANEO_POWER_OFF);
   397			if (ret)
   398				return ret;
   399			return count;
   400		case AYANEO_ATTR_CONTROLLER_MODULES:
   401			return -EINVAL;
   402		}
   403		return -EINVAL;
   404	}
   405	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

