Return-Path: <linux-kernel+bounces-834071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8FFBA3C17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DB61B25485
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1C32F60DD;
	Fri, 26 Sep 2025 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSzzAutt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880842F5A06;
	Fri, 26 Sep 2025 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891951; cv=none; b=hHSxQNxC8xull0sxdIAmrjfKMn9nQilJ0F26rykkU/5EprkXhDtM38IFGe3AY4qEDNQJgtDyl6FRuwDh95gKykivP5U7Ik7lCmS4rcdmOXiwqXiYq5Qr2uL2L9QYtfKJZVnQG4v22zprT7Q3fe6doNgLel5BIeMc7T3TckNWAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891951; c=relaxed/simple;
	bh=qBh44PfZwBCTkqxDPQXFYPD+nTO4K+b11wgKqFkNmhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdYn4pUhRLCyFzRSMndLpmKHc/5E7fMsvj4vJWK1Wu9Wj3+uyj/dfIFEm5PeRt3my1F8CJka/+oVoEvvINyhnUhuAmhR3T9YTjX3uVlDGeC6tog7S5gQdbEvSUFKPaA41U8egig2U4sNSbMVCYeisrKndvuI2Ry+yu8eEscYGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSzzAutt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758891949; x=1790427949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qBh44PfZwBCTkqxDPQXFYPD+nTO4K+b11wgKqFkNmhs=;
  b=lSzzAuttcPbphWEGy51Tt1ePqeqVBTLkVYyIAj3MuFHAZ8zlqJUEQWZm
   UfJKp+yJUE3AXNYlGGOfRj5ZS4G23/enTs9AN/Gxy3J1F+VYJpH/crurq
   IUsGrYF3sfJPdIMdL9IJJ7XBik0SWbprkR1Vj21Bx5YpivFKaIzcH3qWg
   d2h0xHU4wEJq7rWUNxh+U0W9ZIp2vadk22POEXUUdtFovOB7kVEfI42jO
   pamkPfJWo0n1JgGqrbWnIzUPe5sZnbTRf9cRP+8G9K+jur7Zx87MXAV2e
   Tg/FgUg+iIxBZR6IlgkBkHKbrkXaxoHAI6+PGC9/B3kRHwQ8lGQByLkC5
   g==;
X-CSE-ConnectionGUID: uImF6ECZSs+gciKU9fulzA==
X-CSE-MsgGUID: t39WHydhRomDTzTrvyYJig==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65035944"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65035944"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 06:05:48 -0700
X-CSE-ConnectionGUID: L1dkTA1aShCPlLcmCW5QSQ==
X-CSE-MsgGUID: aU7FOwRZR4C47OfGWK0WIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177209208"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 26 Sep 2025 06:05:42 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v288q-0006F9-13;
	Fri, 26 Sep 2025 13:05:40 +0000
Date: Fri, 26 Sep 2025 21:05:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jeff Lin <jefflin994697@gmail.com>, jdelvare@suse.com,
	linux@roeck-us.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cedricjustine.encarnacion@analog.com, ninad@linux.ibm.com,
	andriy.shevchenko@linux.intel.com,
	johnerasmusmari.geronimo@analog.com, Mariel.Tinaco@analog.com,
	jbrunet@baylibre.com, kimseer.paller@analog.com,
	leo.yang.sy0@gmail.com, nuno.sa@analog.com,
	chiang.brian@inventec.com, gregkh@linuxfoundation.org,
	grantpeltier93@gmail.com, peterz@infradead.org,
	william@wkennington.com, krzysztof.kozlowski@linaro.org,
	tzungbi@kernel.org, thorsten.blum@linux.dev,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Lin <jefflin994697@gmail.com>
Subject: Re: [PATCH] drivers/hwmon/pmbus: Add support for raa229141 in
 isl68137
Message-ID: <202509262044.Scx8WTbC-lkp@intel.com>
References: <20250926014552.1625950-1-jefflin994697@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926014552.1625950-1-jefflin994697@gmail.com>

Hi Jeff,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.17-rc7]
[also build test ERROR on linus/master next-20250925]
[cannot apply to groeck-staging/hwmon-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Lin/drivers-hwmon-pmbus-Add-support-for-raa229141-in-isl68137/20250926-094703
base:   v6.17-rc7
patch link:    https://lore.kernel.org/r/20250926014552.1625950-1-jefflin994697%40gmail.com
patch subject: [PATCH] drivers/hwmon/pmbus: Add support for raa229141 in isl68137
config: i386-buildonly-randconfig-002-20250926 (https://download.01.org/0day-ci/archive/20250926/202509262044.Scx8WTbC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509262044.Scx8WTbC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509262044.Scx8WTbC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/pmbus/isl68137.c:66:1: error: expected identifier
      66 | +#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
         | ^
   drivers/hwmon/pmbus/isl68137.c:68:1: error: expected identifier
      68 | +#endif /* CONFIG_SENSORS_RAA229141 */
         | ^
   2 errors generated.


vim +66 drivers/hwmon/pmbus/isl68137.c

    25	
    26	enum chips {
    27		isl68137,
    28		isl68220,
    29		isl68221,
    30		isl68222,
    31		isl68223,
    32		isl68224,
    33		isl68225,
    34		isl68226,
    35		isl68227,
    36		isl68229,
    37		isl68233,
    38		isl68239,
    39		isl69222,
    40		isl69223,
    41		isl69224,
    42		isl69225,
    43		isl69227,
    44		isl69228,
    45		isl69234,
    46		isl69236,
    47		isl69239,
    48		isl69242,
    49		isl69243,
    50		isl69247,
    51		isl69248,
    52		isl69254,
    53		isl69255,
    54		isl69256,
    55		isl69259,
    56		isl69260,
    57		isl69268,
    58		isl69269,
    59		isl69298,
    60		raa228000,
    61		raa228004,
    62		raa228006,
    63		raa228228,
    64		raa229001,
    65		raa229004,
  > 66	+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
    67	+	raa229141,
    68	+#endif /* CONFIG_SENSORS_RAA229141 */
    69		raa229621,
    70	};
    71	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

