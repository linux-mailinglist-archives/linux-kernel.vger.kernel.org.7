Return-Path: <linux-kernel+bounces-834636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9DABA5259
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EE3188C299
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FF28C874;
	Fri, 26 Sep 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fv28DfRR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E62857C1;
	Fri, 26 Sep 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920387; cv=none; b=KUtL6aYg8agx8VRqGyR/BxapuBEsD/qQlFOEa/4XoZ9J8mz40mrdAxf4TbMw3V6m475tDGowIPnpnhdZ4oNJWDK04AS4RUfVfz+wsTb35CR73mVsCyRZrjzTB1+NanDWx4V2abSuaNhjPbUelpMZJdT17xSGJ2JbkZ4XDo0X7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920387; c=relaxed/simple;
	bh=/ABoBzHr1IMmep+FFsYWf6JR/+RW1Jjm4TNmaUHg0xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPBsNj+87RaLZHCndDzIwFpfapTn5lJ7iYCyANea8k9CJSEriBFatTs/ZXs3DJOaV/K8ZIikmEdUHnG6TqoOT1ZHtYoT3LXLSwTXSKrYyZEXWuIdllornzZg85cyTJDTg9P2N/W670uQyeMDb2eCeHmxK3L92sj4sPBUVE2sj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fv28DfRR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758920386; x=1790456386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ABoBzHr1IMmep+FFsYWf6JR/+RW1Jjm4TNmaUHg0xM=;
  b=fv28DfRRripiB9ABO1nXPVHSZfwwBaYqObkdwpVbtn6o15x7QjfNJBpz
   vyN7fp3deF4SH8ef9LdXHLcI9v9dF3whAPOLazjQWbuHVhoXD1PWJEX6B
   GfxZDVkM7XfiyzNS6Y9d65R26naV13/alYZtCMeWL5+wAPtuxBeJHuL7E
   8D/5TcEzl+YuwOchNlcx6RRZPZgjZsMfGJJ6HeBgmCMPbfdaGIRnLFSbA
   iodRL5yA5mFwe40xPc4QdptSsWEJvKFO6MXbJL8BZmM2dtyKuGz3xHExA
   SSW91h41oChVamElo2U/lPwqOiglWzTTHmuEQUAXNQ8dKbdDOZ/+TdOCE
   A==;
X-CSE-ConnectionGUID: a8nS+kPoQravQEk7RSDN4w==
X-CSE-MsgGUID: zSJfPBXZTs+22QdWfZl4bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61172320"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61172320"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 13:59:45 -0700
X-CSE-ConnectionGUID: vHS8gCbfTiOz42W8xOdpNA==
X-CSE-MsgGUID: PlZhraMfQteXp9L6egnfmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="177641641"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 26 Sep 2025 13:59:42 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2FXY-0006bB-0R;
	Fri, 26 Sep 2025 20:59:40 +0000
Date: Sat, 27 Sep 2025 04:58:57 +0800
From: kernel test robot <lkp@intel.com>
To: Joan-Na-adi <joan.na.devcode@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH 2/3] regulator: max77675: Add MAX77675 regulator driver
Message-ID: <202509270448.fUvCkHOA-lkp@intel.com>
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
config: sparc-randconfig-r073-20250927 (https://download.01.org/0day-ci/archive/20250927/202509270448.fUvCkHOA-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509270448.fUvCkHOA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509270448.fUvCkHOA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/regulator/max77675-regulator.c: In function 'max77675_set_sbb_slew_rate':
>> drivers/regulator/max77675-regulator.c:246:18: warning: variable 'value' set but not used [-Wunused-but-set-variable]
     246 |         u8 mask, value;
         |                  ^~~~~
   drivers/regulator/max77675-regulator.c: At top level:
   drivers/regulator/max77675-regulator.c:371:33: warning: initialized field overwritten [-Woverride-init]
     371 |         .list_voltage         = regulator_list_voltage_linear,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/max77675-regulator.c:371:33: note: (near initialization for 'max77675_regulator_ops.list_voltage')


vim +/value +246 drivers/regulator/max77675-regulator.c

   231	
   232	/**
   233	 * max77675_set_sbb_slew_rate - Set the slew rate for a specific SBB regulator channel
   234	 *
   235	 * @maxreg: Pointer to the max77675 regulator structure
   236	 * @id: Regulator channel ID (ID_SBB0 ~ ID_SBB3)
   237	 * @val: Slew rate value (0 = 2mV/us, 1 = use DVS_SLEW)
   238	 *
   239	 * This function configures the slew rate control source for the specified SBB channel by
   240	 * updating the corresponding bits in the CNFG_SBB_TOP_B register.
   241	 *
   242	 * Return: 0 on success, negative error code on failure (e.g., invalid channel ID).
   243	 */
   244	static int max77675_set_sbb_slew_rate(struct max77675_regulator *maxreg, int id, u8 val)
   245	{
 > 246		u8 mask, value;
   247	
   248		switch (id) {
   249		case MAX77675_ID_SBB0:
   250			mask = MAX77675_SR_SBB0_BIT;
   251			value = FIELD_PREP(MAX77675_SR_SBB0_BIT, val);
   252			break;
   253	
   254		case MAX77675_ID_SBB1:
   255			mask = MAX77675_SR_SBB1_BIT;
   256			value = FIELD_PREP(MAX77675_SR_SBB1_BIT, val);
   257			break;
   258	
   259		case MAX77675_ID_SBB2:
   260			mask = MAX77675_SR_SBB2_BIT;
   261			value = FIELD_PREP(MAX77675_SR_SBB2_BIT, val);
   262			break;
   263	
   264		case MAX77675_ID_SBB3:
   265			mask = MAX77675_SR_SBB3_BIT;
   266			value = FIELD_PREP(MAX77675_SR_SBB3_BIT, val);
   267			break;
   268		default:
   269			return -EINVAL;
   270		}
   271	
   272		return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_SBB_TOP_B, mask, val);
   273	}
   274	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

