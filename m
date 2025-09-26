Return-Path: <linux-kernel+bounces-834635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC5BA5256
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE5A1885044
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D8288C27;
	Fri, 26 Sep 2025 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOZv90L9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F6283FF8;
	Fri, 26 Sep 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920387; cv=none; b=QyAmk0ZfmeeJ9aoE/mcnvEGyVjvyJwnb3c1AWMUiy+AFsCNsMie+yxEnDp1AxuLBCJzCUPLlkRAXC7n3lDFBfwBKw//+/WIttrZdUsEyrp0CpJctS2zxPNOlVsICZ0Tyor6g05xdIs+h9ErE+ni9WaOCRFhfnALb8HWCDMMeDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920387; c=relaxed/simple;
	bh=5ShXEXdq0SADyJdekc7MQj0W+eQwAb2eRszFpmFWIvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6FgwNAXSUOWvMtELN4ETDfYPOLU34MhSYKnODnQxESGClggvX+llSYkWjO+KpB/qyHBA/Oa0Gt9umHvBxarfF0wFj4G8Xx0cZ0GMQKgaQqRf1XS68rzBTR4UehXVvT/CBBiBpO5E9OVlNhl0iZcvoE8tF6lqYwbtm42rAssROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOZv90L9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758920386; x=1790456386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ShXEXdq0SADyJdekc7MQj0W+eQwAb2eRszFpmFWIvc=;
  b=DOZv90L9rB3C0Rm3FbNIuXUKu+Ef/x2IZ8vhRRnVPqCQWCWdhsPBmqtO
   c8W44ePO22/D/b+5SbgCYO8SC877zKH9h1W4EHSPiRH2YTwRKkQbGX+5c
   xfrPMb6oI75DZqvO8dIuuES3EOTl8+iPCf38uoGPgESA9ZdwqAnqFcKjj
   AQD21bbXb03i+2dWcSQFUI1uFpKhkpPrUeNenOsqsXROYNXS7p1mYEDB5
   54dYqWGlHRaUbLOFhIz+l7Q2ZWEH3ejFfcBbecsDHBc5+cNFZcAlmt9y8
   PgnC8dsa1srOCdHnwFBKIRF6/oWBCy2QefVCpEipYJGgWCkfBdmBow7P6
   A==;
X-CSE-ConnectionGUID: DLMqIparRw+xqjWBYubX1w==
X-CSE-MsgGUID: LY18DzN6TvuL1JFGOQhdhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61213289"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61213289"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 13:59:45 -0700
X-CSE-ConnectionGUID: PTauouoETHSdKZXYanxbIA==
X-CSE-MsgGUID: TakWQswXSXaoS8dGzKTmXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="176983068"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 26 Sep 2025 13:59:42 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2FXY-0006b9-0M;
	Fri, 26 Sep 2025 20:59:40 +0000
Date: Sat, 27 Sep 2025 04:58:55 +0800
From: kernel test robot <lkp@intel.com>
To: Joan-Na-adi <joan.na.devcode@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH 2/3] regulator: max77675: Add MAX77675 regulator driver
Message-ID: <202509270412.dpXeCSVU-lkp@intel.com>
References: <20250926053757.480086-3-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926053757.480086-3-joan.na@analog.com>

Hi Joan-Na-adi,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on robh/for-next linus/master v6.17-rc7 next-20250926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joan-Na-adi/dt-bindings-regulator-Add-MAX77675-binding-header/20250926-134116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20250926053757.480086-3-joan.na%40analog.com
patch subject: [PATCH 2/3] regulator: max77675: Add MAX77675 regulator driver
config: alpha-randconfig-r072-20250927 (https://download.01.org/0day-ci/archive/20250927/202509270412.dpXeCSVU-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509270412.dpXeCSVU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509270412.dpXeCSVU-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/regulator/max77675-regulator.c: In function 'max77675_set_sbb_slew_rate':
   drivers/regulator/max77675-regulator.c:246:18: warning: variable 'value' set but not used [-Wunused-but-set-variable]
     246 |         u8 mask, value;
         |                  ^~~~~
   drivers/regulator/max77675-regulator.c: At top level:
   drivers/regulator/max77675-regulator.c:371:33: warning: initialized field overwritten [-Woverride-init]
     371 |         .list_voltage         = regulator_list_voltage_linear,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/max77675-regulator.c:371:33: note: (near initialization for 'max77675_regulator_ops.list_voltage')
>> drivers/regulator/max77675-regulator.c:783:35: error: 'max77675_of_match' undeclared here (not in a function); did you mean 'max77675_of_parse_cb'?
     783 |                 .of_match_table = max77675_of_match,
         |                                   ^~~~~~~~~~~~~~~~~
         |                                   max77675_of_parse_cb


vim +783 drivers/regulator/max77675-regulator.c

   779	
   780	static struct i2c_driver max77675_regulator_driver = {
   781		.driver = {
   782			.name = "max77675",
 > 783			.of_match_table = max77675_of_match,
   784		},
   785		.probe = max77675_regulator_probe,
   786		.remove = max77675_regulator_remove,
   787		.id_table = max77675_i2c_id,
   788	};
   789	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

