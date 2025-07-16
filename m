Return-Path: <linux-kernel+bounces-733505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73729B0758C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368565840CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8E2F508D;
	Wed, 16 Jul 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxXpo6No"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEFC2F50A9;
	Wed, 16 Jul 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668722; cv=none; b=KCaFD/NIGo4D+SBCBFrMPIBahHYmUo+dabyWmvz1pZ6hgDfjT1WfKCAKxkRYIhKvI106uA1umxlKi6awOG0RvDiI/G5JwoNwVHGmcFp0Aa0JLWGKqOZG9Xe4DBsEOyrVlTltuWru+qetkAiIeX8Fm1yHVrY7jdQDuri7O3OKYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668722; c=relaxed/simple;
	bh=BWrLRFAp92FC1Lne9D6uyC23s8dUsoFZLRBGb5z/924=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukqR9daZ8OKMTO1YhTdrUv4E9kI6ohZsJr+MawApSBKWHkbaknDv7wclM05Ga3fdvLA9UV1TjqDE/0JDRQN8Ae/bhmeFmvXUR9+RbEX0o9ua8Hf6MqFNsJbxzu/TfYx+st/SgVPhR05HAySuptBkNqZIxs1NFv2qIM/8fIFWYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxXpo6No; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752668720; x=1784204720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BWrLRFAp92FC1Lne9D6uyC23s8dUsoFZLRBGb5z/924=;
  b=nxXpo6NodfGQmyNg02hngwlgbGLYJgxMnVCLchN8ZFcF6P20B73zV5gl
   /fJn9/YLCsyPEEME4xIqLjJRIi0n98Tvh3tMX7ieNpDVMwAe28F5sb6Gn
   BR2fIyz+YDXuUAAugJ/NKeqekRhwXm7/5gpcY8osGLoWYeKJb51dxIroV
   5kZlv8XAvR9VogwkGq8m3lNx7QeT5IZkGhogePn+DxidwzxO3iisUwpes
   6KU3YCiRdwAWKLWrBSLjx6sZDSRzEtqVJbx7A/91JoqkHClXKgkrrHasN
   oJhIJG3cwnD9BUH51MF01+huxu3JrIMrTApjlGDT9DunK7yz4vas3CPUD
   g==;
X-CSE-ConnectionGUID: 0mW5e1Z2TxqxIAi+KDd/Tg==
X-CSE-MsgGUID: mnNjbIciTgmtbkAco3BO9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54020733"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54020733"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 05:25:19 -0700
X-CSE-ConnectionGUID: JHf6O6CWSnWFwjKCUsM/Pg==
X-CSE-MsgGUID: TbiiyrIeSrCVY4Ejj0xc+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="162043447"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Jul 2025 05:25:15 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc1CD-000CMB-0b;
	Wed, 16 Jul 2025 12:25:13 +0000
Date: Wed, 16 Jul 2025 20:24:38 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lee@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org
Subject: Re: [PATCH v5 4/8] regulator: Add support for MediaTek MT6363 SPMI
 PMIC Regulators
Message-ID: <202507162012.qDNKtUiI-lkp@intel.com>
References: <20250715140224.206329-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715140224.206329-5-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes lee-leds/for-leds-next linus/master v6.16-rc6 next-20250715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-regulator-Document-MediaTek-MT6316-PMIC-Regulators/20250715-222516
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20250715140224.206329-5-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v5 4/8] regulator: Add support for MediaTek MT6363 SPMI PMIC Regulators
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250716/202507162012.qDNKtUiI-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507162012.qDNKtUiI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507162012.qDNKtUiI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/regulator/mt6363-regulator.c:519:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     519 |                 sel = FIELD_PREP(MT6363_RG_VEMC_VOSEL_1_MASK, sel);
         |                       ^
>> drivers/regulator/mt6363-regulator.c:577:10: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     577 |                 vsel = FIELD_GET(MT6363_RG_VEMC_VOSEL_1_MASK, vosel);
         |                        ^
   2 errors generated.


vim +/FIELD_PREP +519 drivers/regulator/mt6363-regulator.c

   481	
   482	static int mt6363_vemc_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
   483	{
   484		const u16 tma_unlock_key = MT6363_TMA_UNLOCK_VALUE;
   485		const struct regulator_desc *rdesc = rdev->desc;
   486		struct regmap *regmap = rdev->regmap;
   487		unsigned int range, val;
   488		int i, ret;
   489		u16 mask;
   490	
   491		for (i = 0; i < rdesc->n_linear_ranges; i++) {
   492			const struct linear_range *r = &rdesc->linear_ranges[i];
   493			unsigned int voltages_in_range = linear_range_values_in_range(r);
   494	
   495			if (sel < voltages_in_range)
   496				break;
   497			sel -= voltages_in_range;
   498		}
   499	
   500		if (i == rdesc->n_linear_ranges)
   501			return -EINVAL;
   502	
   503		ret = regmap_read(rdev->regmap, MT6363_TOP_TRAP, &val);
   504		if (ret)
   505			return ret;
   506	
   507		if (val > 1)
   508			return -EINVAL;
   509	
   510		/* Unlock TMA for writing */
   511		ret = regmap_bulk_write(rdev->regmap, MT6363_TOP_TMA_KEY_L,
   512					&tma_unlock_key, sizeof(tma_unlock_key));
   513		if (ret)
   514			return ret;
   515	
   516		/* If HW trapping value is 1, use VEMC_VOSEL_1 instead of VEMC_VOSEL_0 */
   517		if (val == 1) {
   518			mask = MT6363_RG_VEMC_VOSEL_1_MASK;
 > 519			sel = FIELD_PREP(MT6363_RG_VEMC_VOSEL_1_MASK, sel);
   520		} else {
   521			mask = rdesc->vsel_mask;
   522		}
   523	
   524		sel <<= ffs(rdesc->vsel_mask) - 1;
   525		sel += rdesc->linear_ranges[i].min_sel;
   526	
   527		range = rdesc->linear_range_selectors_bitfield[i];
   528		range <<= ffs(rdesc->vsel_range_mask) - 1;
   529	
   530		/* Write to the vreg calibration register for voltage finetuning */
   531		ret = regmap_update_bits(regmap, rdesc->vsel_range_reg,
   532					 rdesc->vsel_range_mask, range);
   533		if (ret)
   534			goto lock_tma;
   535	
   536		/* Function must return the result of this write operation */
   537		ret = regmap_update_bits(regmap, rdesc->vsel_reg, mask, sel);
   538	
   539	lock_tma:
   540		/* Unconditionally re-lock TMA */
   541		val = 0;
   542		regmap_bulk_write(rdev->regmap, MT6363_TOP_TMA_KEY_L, &val, 2);
   543	
   544		return ret;
   545	}
   546	
   547	static int mt6363_vemc_get_voltage_sel(struct regulator_dev *rdev)
   548	{
   549		const struct regulator_desc *rdesc = rdev->desc;
   550		unsigned int vosel, trap, calsel;
   551		int vcal, vsel, range, ret;
   552	
   553		ret = regmap_read(rdev->regmap, rdesc->vsel_reg, &vosel);
   554		if (ret)
   555			return ret;
   556	
   557		ret = regmap_read(rdev->regmap, rdesc->vsel_range_reg, &calsel);
   558		if (ret)
   559			return ret;
   560	
   561		calsel &= rdesc->vsel_range_mask;
   562		for (range = 0; range < rdesc->n_linear_ranges; range++)
   563			if (rdesc->linear_range_selectors_bitfield[range] != calsel)
   564				break;
   565	
   566		if (range == rdesc->n_linear_ranges)
   567			return -EINVAL;
   568	
   569		ret = regmap_read(rdev->regmap, MT6363_TOP_TRAP, &trap);
   570		if (ret)
   571			return ret;
   572	
   573		/* If HW trapping value is 1, use VEMC_VOSEL_1 instead of VEMC_VOSEL_0 */
   574		if (trap > 1)
   575			return -EINVAL;
   576		else if (trap == 1)
 > 577			vsel = FIELD_GET(MT6363_RG_VEMC_VOSEL_1_MASK, vosel);
   578		else
   579			vsel = vosel & rdesc->vsel_mask;
   580	
   581		vcal = linear_range_values_in_range_array(rdesc->linear_ranges, range);
   582	
   583		return vsel + vcal;
   584	}
   585	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

