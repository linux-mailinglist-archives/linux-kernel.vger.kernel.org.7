Return-Path: <linux-kernel+bounces-779325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43EAB2F2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907C11672C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2EE2EACE2;
	Thu, 21 Aug 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqyJqDqX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAB2EA73B;
	Thu, 21 Aug 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765684; cv=none; b=hvhsKPLYFpxtp3Ps3D34/kWrUPHBtTIetlQzfaDa7LkGtHhMGeYAp4HK/rD+a7ofMjFhR42vdJvBOmyi90Swthdv4XeD7R7nza1G4/+UQVtU4Rf5+awa1b6H5cXmD7EXl4ZuntxkT3kKiW9VVo28TP8C7/Bn0/j0WZdA629tBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765684; c=relaxed/simple;
	bh=KtT8TscMuMza33UUIFFQPhrRCIrbqTRqWw56j6zQ3yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyhwAA60f8mw6jTBxKBQysv2Ba2gVDmx21YCe+hwa3igElkCFj02ToyXHpIt7s3H+U6cxNk76XMkKl6PDjFZHr5aEz47XFcZHqXjYzx+RJUzEDjxJJDfXIqZV0jI/qmnirad/RfgVN7/Dox0QKgbahRu91PaTXQFxj519HJVfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqyJqDqX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755765683; x=1787301683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtT8TscMuMza33UUIFFQPhrRCIrbqTRqWw56j6zQ3yc=;
  b=lqyJqDqXWyE2wI0K6oTAsPdsbSRqNiud2MXsSUSjekPy9St2BQcOo8Xi
   yIdE3NN50/MPA8mb8MNemRF71htZuZ7YHkASWZneqKFu18CLErfLtaJiv
   xZFIxVnR3I8hTEKiMuptC7ckh398VyeVkSP4I/1MM3OpQAwFrJ/jknck5
   b6+lFATXmID8P+N4KLIrCnl7AESZgypz9KJGt8vBUb5hlSzqPTR7Hcp+K
   Ioj/HG/hbDja7tAwyhDkZQBfRq8Fa6FfLuW4QrV767vk95iKKBk1/O7Kr
   lgKSbBx6x0qqh6U2xC9WHCKUrbUdYmo4exi1IYzA1BHD6o2MEQPu92yyT
   g==;
X-CSE-ConnectionGUID: EVqCl9XFRvaoLEhRwJyjow==
X-CSE-MsgGUID: ZWXM14OYQYaY6fzovaRBSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69488920"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69488920"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:41:22 -0700
X-CSE-ConnectionGUID: VcnuS50NTQCGJ5qwqqfKZA==
X-CSE-MsgGUID: s8qtbVRzSrOlunfa07343w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167583174"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 Aug 2025 01:41:20 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up0rF-000K6h-0m;
	Thu, 21 Aug 2025 08:41:17 +0000
Date: Thu, 21 Aug 2025 16:41:04 +0800
From: kernel test robot <lkp@intel.com>
To: Antheas Kapenekakis <lkml@antheas.dev>,
	platform-driver-x86@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: Re: [PATCH v1 4/5] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
Message-ID: <202508211626.9Cxkta6K-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Antheas-Kapenekakis/platform-x86-ayaneo-ec-Add-Ayaneo-Embedded-Controller-platform-driver/20250821-002525
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250820160628.99678-5-lkml%40antheas.dev
patch subject: [PATCH v1 4/5] platform/x86: ayaneo-ec: Add controller power and modules attributes
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250821/202508211626.9Cxkta6K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250821/202508211626.9Cxkta6K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508211626.9Cxkta6K-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/x86/ayaneo-ec.c: In function 'ayaneo_ec_probe':
>> drivers/platform/x86/ayaneo-ec.c:497:49: error: implicit declaration of function 'MKDEV' [-Werror=implicit-function-declaration]
     497 |                                                 MKDEV(0, 0), NULL, "%s",
         |                                                 ^~~~~
   cc1: some warnings being treated as errors


vim +/MKDEV +497 drivers/platform/x86/ayaneo-ec.c

   459	
   460	static int ayaneo_ec_probe(struct platform_device *pdev)
   461	{
   462		const struct dmi_system_id *dmi_entry;
   463		struct ayaneo_ec_platform_data *data;
   464		struct device *hwdev;
   465		int ret;
   466	
   467		dmi_entry = dmi_first_match(dmi_table);
   468		if (!dmi_entry)
   469			return -ENODEV;
   470	
   471		data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
   472		if (!data)
   473			return -ENOMEM;
   474	
   475		data->pdev = pdev;
   476		data->quirks = dmi_entry->driver_data;
   477		platform_set_drvdata(pdev, data);
   478	
   479		if (data->quirks->has_fan_control) {
   480			hwdev = devm_hwmon_device_register_with_info(
   481				&pdev->dev, "ayaneo_ec", NULL, &ayaneo_ec_chip_info, NULL);
   482			if (IS_ERR(hwdev))
   483				return PTR_ERR(hwdev);
   484		}
   485	
   486		if (data->quirks->has_charge_control) {
   487			data->battery_hook.add_battery = ayaneo_add_battery;
   488			data->battery_hook.remove_battery = ayaneo_remove_battery;
   489			data->battery_hook.name = "Ayaneo Battery";
   490			ret = devm_battery_hook_register(&pdev->dev, &data->battery_hook);
   491			if (ret)
   492				return ret;
   493		}
   494	
   495		if (data->quirks->has_magic_modules || data->quirks->has_controller_power) {
   496			data->fw_attrs_dev = device_create(&firmware_attributes_class, NULL,
 > 497							MKDEV(0, 0), NULL, "%s",
   498							DRIVER_NAME);
   499			if (IS_ERR(data->fw_attrs_dev))
   500				return PTR_ERR(data->fw_attrs_dev);
   501	
   502			ret = devm_add_action_or_reset(&data->pdev->dev,
   503						ayaneo_fw_attrs_dev_unregister,
   504						data->fw_attrs_dev);
   505			if (ret)
   506				return ret;
   507	
   508			data->fw_attrs_kset = kset_create_and_add("attributes", NULL,
   509								&data->fw_attrs_dev->kobj);
   510			if (!data->fw_attrs_kset)
   511				return -ENOMEM;
   512	
   513			ret = devm_add_action_or_reset(&data->pdev->dev, ayaneo_kset_unregister,
   514						data->fw_attrs_kset);
   515	
   516			if (data->quirks->has_magic_modules) {
   517				ret = ayaneo_fw_attr_init(
   518					data, AYANEO_ATTR_CONTROLLER_MODULES, true);
   519				if (ret)
   520					return ret;
   521			}
   522	
   523			if (data->quirks->has_controller_power) {
   524				ret = ayaneo_fw_attr_init(
   525					data, AYANEO_ATTR_CONTROLLER_POWER, false);
   526				if (ret)
   527					return ret;
   528			}
   529		}
   530	
   531		return 0;
   532	}
   533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

