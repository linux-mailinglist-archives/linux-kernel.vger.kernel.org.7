Return-Path: <linux-kernel+bounces-834813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50343BA594A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24AD84E06C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08EA22D792;
	Sat, 27 Sep 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzsNiXwI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18A200C2;
	Sat, 27 Sep 2025 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758951086; cv=none; b=pwjbLp0SN56HMXCvfJcHTUio9+8FtWRrLqEgVPeSsnpMjYtqGcCTEP2Tf9Zjg7PpmsQT2fky5A5ADpkpPCsATGFsNdZRQP6Br3NSVou8apaHUzlszMt1BBoJErEfAoK03EoS6Ln7afjTzJ5JfKKWxrD4SWrDeEx/ewvbjMAYTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758951086; c=relaxed/simple;
	bh=GRKRiu1cWCz0fIQK2Ybtl3m6ooYbp3n87BsDYuMG+5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP4qG9UJHJvTaoW5tkiMv49mTURN3U1lmvfMiImuzQ5Go7emVizZxKhmfyQKopjQlwFhhacC+BFrLctAk1Wx6xx+wGGZOv37HBAOo9KyGiOP5qBWF+fJVLy9P6v0zPgr66vfIoiis4toPM8QMYkq91A/FBkLM0OhKiC6qxPzNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzsNiXwI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758951084; x=1790487084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GRKRiu1cWCz0fIQK2Ybtl3m6ooYbp3n87BsDYuMG+5w=;
  b=gzsNiXwIX2BXjHTXhDhiSoTTO/kgxG2WvGNNyks7INFnkoo/16d1gUMO
   P1ATxiKRPI8GcoBIBSrrLsVzL1ZKMh7EoBkMWE/KCpRj+xn1gluxU5L0U
   KvsBacdAsHw3DrJtJRopJOssPp1ii6qYloE5cIIbaC2vUjP47rryRkBbI
   exPs3pxOfR8nETGx59uJIipFB82aFUO/DkXwcxW3XquzQqOZNnZJ9vRuv
   qDHxk4cTUyzjBk60PeBsuD4ylYnhqWScADL/WwXmmqGhHef+DDY5Oe0Tg
   wCYfCVnhwI8H9liWAEee48eWMx28PJmrSPHXOP8dEI35HC/bO67R25SMQ
   A==;
X-CSE-ConnectionGUID: pOLciX68QKiqPtY/2ESaBg==
X-CSE-MsgGUID: vMseKTGvTzC+qhQRw80D8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61197626"
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="61197626"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 22:31:24 -0700
X-CSE-ConnectionGUID: oWG9ymA7QVGnmWxxzROXUg==
X-CSE-MsgGUID: VQqpaBjfRdqq9alc/vwNAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="177711000"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 26 Sep 2025 22:31:21 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2NWh-0006oh-0d;
	Sat, 27 Sep 2025 05:31:19 +0000
Date: Sat, 27 Sep 2025 13:30:40 +0800
From: kernel test robot <lkp@intel.com>
To: Joan-Na-adi <joan.na.devcode@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH 2/3] regulator: max77675: Add MAX77675 regulator driver
Message-ID: <202509271318.cU4bEADk-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-regulator/for-next]
[also build test WARNING on robh/for-next linus/master v6.17-rc7 next-20250926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joan-Na-adi/dt-bindings-regulator-Add-MAX77675-binding-header/20250926-134116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20250926053757.480086-3-joan.na%40analog.com
patch subject: [PATCH 2/3] regulator: max77675: Add MAX77675 regulator driver
config: parisc-randconfig-r122-20250927 (https://download.01.org/0day-ci/archive/20250927/202509271318.cU4bEADk-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509271318.cU4bEADk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509271318.cU4bEADk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/regulator/max77675-regulator.c:367:10: sparse: sparse: Initializer entry defined twice
   drivers/regulator/max77675-regulator.c:371:10: sparse:   also defined here

vim +367 drivers/regulator/max77675-regulator.c

   365	
   366	static const struct regulator_ops max77675_regulator_ops = {
 > 367		.list_voltage         = regulator_list_voltage_linear,
   368		.enable               = regulator_enable_regmap,
   369		.disable              = regulator_disable_regmap,
   370		.is_enabled           = regulator_is_enabled_regmap,
   371		.list_voltage         = regulator_list_voltage_linear,
   372		.map_voltage          = regulator_map_voltage_linear,
   373		.set_voltage_sel      = regulator_set_voltage_sel_regmap,
   374		.get_voltage_sel      = regulator_get_voltage_sel_regmap,
   375		.set_active_discharge = regulator_set_active_discharge_regmap,
   376		.get_error_flags      = max77675_get_error_flags,
   377	};
   378	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

