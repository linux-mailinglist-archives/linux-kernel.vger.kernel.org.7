Return-Path: <linux-kernel+bounces-746697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F0B12A26
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E517AC912
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA6241664;
	Sat, 26 Jul 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVGjUsX7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C81747F;
	Sat, 26 Jul 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753527514; cv=none; b=r3hrgQsaWI59tskIbicPoZWae0mO1K9lKnCBUCdPB8GB+gqGt44x/f3z1jQxpjQ28214Ywn5vGkqg2ZYadYhBKiUCymki3sUKOgRv2Asl5tCnvWNDFyhxbkLCHZY/QkIz9JYw8Duvq4zrJ9t9DpedgD/Dn1jCRn0TXvU6eW/6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753527514; c=relaxed/simple;
	bh=rnRDlgj8Q/JfjRIbBFhbWoFicS29hIqzTXFKkikkhhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9AeJsKgsG7GzQhzV/K6qLa0fYh6NpxBXtLLLC2WWBSJcPBvP5EpeSBkJRutIZKzaIwpwQbGrOh+XQ85MoAMUmOlY/CSk4hNLGa5EOdMytMAqNAi0xiey3FkWgTwBKaA93j/dNI0r2Zl9YtmawG++BXu/DfbpGYOURukP00dElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVGjUsX7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753527513; x=1785063513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rnRDlgj8Q/JfjRIbBFhbWoFicS29hIqzTXFKkikkhhU=;
  b=DVGjUsX7mZr59omUv1Jg5OjSAdgup+7VEhhYI094y3IKvdw9PaD8SdMo
   Qm7tIeG3golXMWrovnYPS9STc12NGPpLHjfue//IEDpdua4BU1dPqm5ji
   HR4jIqD/0QvPIBe/rHG3kHbbu4DJe/ML2ji8JNWE5tqKQ1RQPmJnzg0io
   dEB+bc4TBNGSxFlP2CkvDUN/cQ6GoMfdRjA1OgY/yMbZHahLvSaiNDHG2
   RuYX+hQMd/T+ppwr0BIbL5ooegR6UxCtp9a1P+ED0I5hrlmDOEwN6RWjH
   aWfjkxO6ikCbHIOdEzovqOY7ZkAzj9jaPnq5vVYx1KibahwVFxvQOR/7g
   g==;
X-CSE-ConnectionGUID: Basx9IldRr6rX8sRhgZ/3A==
X-CSE-MsgGUID: tCyRBeGcROGhiB6g9dhwRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="67198514"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67198514"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 03:58:32 -0700
X-CSE-ConnectionGUID: uzDiAv0KSySNEF+wjyJ94w==
X-CSE-MsgGUID: lRf6MdY8Sy66yOhG03aEFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="198646569"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Jul 2025 03:58:29 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufcbi-000Lu3-2d;
	Sat, 26 Jul 2025 10:58:26 +0000
Date: Sat, 26 Jul 2025 18:57:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
Message-ID: <202507261841.lk1Z3fqj-lkp@intel.com>
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725004533.63537-1-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.16-rc7 next-20250725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-ayn-ec-Add-Temperature-Sensors/20250725-084850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250725004533.63537-1-derekjohn.clark%40gmail.com
patch subject: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250726/202507261841.lk1Z3fqj-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261841.lk1Z3fqj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261841.lk1Z3fqj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/x86/ayn-ec.c:526:6: warning: unused variable 'ret' [-Wunused-variable]
     526 |         int ret;
         |             ^~~
>> drivers/platform/x86/ayn-ec.c:557:35: warning: unused variable 'ayn_dmi_table' [-Wunused-const-variable]
     557 | static const struct dmi_system_id ayn_dmi_table[] = {
         |                                   ^~~~~~~~~~~~~
   2 warnings generated.


vim +/ayn_dmi_table +557 drivers/platform/x86/ayn-ec.c

   521	
   522	static int ayn_ec_probe(struct platform_device *pdev)
   523	{
   524		struct device *dev = &pdev->dev;
   525		struct device *hwdev;
 > 526		int ret;
   527	
   528		hwdev = devm_hwmon_device_register_with_info(dev, "aynec", NULL,
   529							     &ayn_ec_chip_info,
   530							     ayn_sensors_groups);
   531		return PTR_ERR_OR_ZERO(hwdev);
   532	}
   533	
   534	static struct platform_driver ayn_ec_driver = {
   535		.driver = {
   536			.name = "ayn-ec",
   537		},
   538		.probe = ayn_ec_probe,
   539	};
   540	
   541	static struct platform_device *ayn_ec_device;
   542	
   543	static int __init ayn_ec_init(void)
   544	{
   545		ayn_ec_device = platform_create_bundle(&ayn_ec_driver, ayn_ec_probe,
   546						       NULL, 0, NULL, 0);
   547	
   548		return PTR_ERR_OR_ZERO(ayn_ec_device);
   549	}
   550	
   551	static void __exit ayn_ec_exit(void)
   552	{
   553		platform_device_unregister(ayn_ec_device);
   554		platform_driver_unregister(&ayn_ec_driver);
   555	}
   556	
 > 557	static const struct dmi_system_id ayn_dmi_table[] = {
   558		{
   559			.matches = {
   560				DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
   561				DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Max"),
   562			},
   563			.driver_data = (void *)ayn_loki_max,
   564		},
   565		{
   566			.matches = {
   567				DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
   568				DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki MiniPro"),
   569			},
   570			.driver_data = (void *)ayn_loki_minipro,
   571		},
   572		{
   573			.matches = {
   574				DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ayn"),
   575				DMI_EXACT_MATCH(DMI_BOARD_NAME, "Loki Zero"),
   576			},
   577			.driver_data = (void *)ayn_loki_zero,
   578		},
   579		{
   580			.matches = {
   581				DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Tectoy"),
   582				DMI_EXACT_MATCH(DMI_BOARD_NAME, "Zeenix Lite"),
   583			},
   584			.driver_data = (void *)tactoy_zeenix_lite,
   585		},
   586		{},
   587	};
   588	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

