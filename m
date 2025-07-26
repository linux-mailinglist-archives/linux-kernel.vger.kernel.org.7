Return-Path: <linux-kernel+bounces-746719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BAFB12A61
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C135456AF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BAF2459FF;
	Sat, 26 Jul 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eR/jyxHP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6B245022;
	Sat, 26 Jul 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753531602; cv=none; b=aYVBIL4rMYE1bu8LPT2zz3M91//TT2fZjG5x2QbOYc1lkynTjqb8y9d+kuEznynxjYJ0b2+6kUXlhrKklcFNhWw/Qoxg98rzze1ENDfy5d74jlFhc1dCFHbM4DQolN+FaJKzcF+dCkAf1AcrP+WaklLFoxk1Edr76AEUMgWfDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753531602; c=relaxed/simple;
	bh=566pX6VH1r+Sd8KvPjLi/b2Yl5tbJepe2oJQbZ/onys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oueL+O2EWpFoC/l0cTOn9kOyHFFwrkqLO4LvDOXovIKQuk0Mft+3PKvEYNrSgSpy+H0wRvrXOBsLxMKDtivDpL7cD22ZAGMYnGIzMI8KYL0s4Haja3ox6bRmYZMV95ABcGuMalzPGvK+bMZlXlNd9bdjRQBHKBbi5jFqu6niZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eR/jyxHP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753531601; x=1785067601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=566pX6VH1r+Sd8KvPjLi/b2Yl5tbJepe2oJQbZ/onys=;
  b=eR/jyxHPPewnhitoBsB7Gp/nXZKUmBed74POuCsQFId0oooVKzkJvSqw
   2iAXyk0USwCgwrNsOZHJdn9oCR7QuAxBNPaXEx4C+vuMo02HhmSoVnBvG
   33Oxwe78/SMFyvnPKamqTr2CIHL59F+brhiYkuGfqSlCltwzlsqzPS+e1
   DNRsBZZwWGQFjFNZG3FQk5qkv+Qx7DC3+x9mrwDwTrUQoLQm0wLAc2llW
   CxOplJI0Gb1d43XZgBRS3AINFC953UncK6tUXnvqXe/XZzD4H5uDn3fhv
   2ZXAAMONIVk7J+QUrbc0WaLM5wSqQbhPo/MyI86c9v5Nxd3YTowK7o++T
   w==;
X-CSE-ConnectionGUID: cswCqypQQ+G3c8xZvDWr8g==
X-CSE-MsgGUID: v+8ipEBdRr60idO2AwsAgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66114153"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66114153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 05:06:41 -0700
X-CSE-ConnectionGUID: Lsn1vMt4Ro+eR9d28RzJ1Q==
X-CSE-MsgGUID: mZNLFnzKQvuq+5H+n0+gJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166962948"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Jul 2025 05:06:38 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufdfe-000Lxv-3B;
	Sat, 26 Jul 2025 12:06:34 +0000
Date: Sat, 26 Jul 2025 20:06:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
Message-ID: <202507261928.2I5G2r8J-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.16-rc7 next-20250725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-ayn-ec-Add-Temperature-Sensors/20250725-084850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250725004533.63537-1-derekjohn.clark%40gmail.com
patch subject: [PATCH 1/4] platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
config: i386-randconfig-007-20250726 (https://download.01.org/0day-ci/archive/20250726/202507261928.2I5G2r8J-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261928.2I5G2r8J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261928.2I5G2r8J-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/platform/x86/ayn-ec.o: in function `read_from_ec':
>> drivers/platform/x86/ayn-ec.c:99: undefined reference to `ec_read'
   ld: drivers/platform/x86/ayn-ec.o: in function `write_to_ec':
>> drivers/platform/x86/ayn-ec.c:128: undefined reference to `ec_write'


vim +99 drivers/platform/x86/ayn-ec.c

    79	
    80	/**
    81	 * read_from_ec() - Reads a value from the embedded controller.
    82	 *
    83	 * @reg: The register to start the read from.
    84	 * @size: The number of sequential registers the data is contained in.
    85	 * @val: Pointer to return the data with.
    86	 *
    87	 * Return: 0, or an error.
    88	 */
    89	static int read_from_ec(u8 reg, int size, long *val)
    90	{
    91		int ret, i;
    92		u8 buf;
    93	
    94		if (!lock_global_acpi_lock())
    95			return -EBUSY;
    96	
    97		*val = 0;
    98		for (i = 0; i < size; i++) {
  > 99			ret = ec_read(reg + i, &buf);
   100			if (ret)
   101				return ret;
   102			*val <<= i * 8;
   103			*val += buf;
   104		}
   105	
   106		if (!unlock_global_acpi_lock())
   107			return -EBUSY;
   108	
   109		return 0;
   110	}
   111	
   112	/**
   113	 * write_to_ec() - Writes a value to the embedded controller.
   114	 *
   115	 * @reg: The register to write to.
   116	 * @val: Value to write
   117	 *
   118	 * Return: 0, or an error.
   119	 */
   120	static int write_to_ec(u8 reg, u8 val)
   121	{
   122		int ret;
   123	
   124		if (!lock_global_acpi_lock())
   125			return -EBUSY;
   126	
   127		pr_info("Writing EC value %d to register %u\n", val, reg);
 > 128		ret = ec_write(reg, val);
   129	
   130		if (!unlock_global_acpi_lock())
   131			return -EBUSY;
   132	
   133		return ret;
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

