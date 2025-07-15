Return-Path: <linux-kernel+bounces-731033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86F6B04DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272D64A5057
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102262C327F;
	Tue, 15 Jul 2025 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAGiYCwz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB819DF4F;
	Tue, 15 Jul 2025 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545818; cv=none; b=ObvcEBZ2rMBnFpV6XuCzBZac2+GCE8ymxAJuexZjb0fDNv3EhoL48Y/w4jpEVrW8UX7MOBv9chZts0oO/1A6xeGjnCQxna5y8BCDaVo8yq87J1QP/9LCBe6u1k6ul4+3hTScjKQ7wXpjr/y7eZP20mMJhKHnBAITYshly21u6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545818; c=relaxed/simple;
	bh=jmxCqU7vT9wDGVqn13z5bf8xdfrCR0BgKtLcYkpE5QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWwFsd7ZVGs9lDqSOghbCrqmRP8gA4IxkfTAsdvm/D0PNqGHBj0VW8dGr0AKl4c9ivC8w+GfsatspgO3iZlxXGMqv423/W5wxvMYiOFLeU1DLMXTpPCfaRtnIcD5PmISHKUDqoT1AZ/9IexYg7uHl4iTlatgAyFcwYw2BBGVQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAGiYCwz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752545816; x=1784081816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jmxCqU7vT9wDGVqn13z5bf8xdfrCR0BgKtLcYkpE5QY=;
  b=LAGiYCwzGEHHB2nZa1e5BHHfkfFy42PnnTh4xsk5tXvC3sl4LZPVZqSG
   gOwsfz3uJhwg1kDnJpujK5EMmok9QM0kZ0wO0SVn341o3JmFZmkdQu/D/
   MaS6ePgpkXdUIr8pmvLd2+mfFgXpED98yJ+POW/prYpeSd+5QwkoUiY4Y
   Q7tORsdwq/TYTK0FDnbmyTwwd6hUdNhyZFJlteYjD3Yv5N2t4Jxn7h3D5
   CpyGKL3qUUqf4W8gJTM86rxZ1c0seQQ9O7bQiJA7no2MwO+vAY3UIWcYR
   Pr9ohq0CErp0qporiKn/HLgflcBiWmBkjiTu2NWoyeOzqOLa0R3dUBa9K
   A==;
X-CSE-ConnectionGUID: 2b9DI9I9TZGmx9G3sLiU3Q==
X-CSE-MsgGUID: +ywdsgmQRrWUp5xsy3LQXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66202049"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="66202049"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 19:16:56 -0700
X-CSE-ConnectionGUID: YPJe4lDXQxS/h0wBLeMU/w==
X-CSE-MsgGUID: M9YyJfrZSWqedUuQIlDCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157813800"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Jul 2025 19:16:52 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubVDt-0009Y3-3C;
	Tue, 15 Jul 2025 02:16:49 +0000
Date: Tue, 15 Jul 2025 10:16:17 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH v2 4/8] regulator: Add support for MediaTek MT6363 SPMI
 PMIC Regulators
Message-ID: <202507150934.VLFQsCyK-lkp@intel.com>
References: <20250707134451.154346-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707134451.154346-5-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes lee-leds/for-leds-next linus/master v6.16-rc6 next-20250714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-regulator-Document-MediaTek-MT6316-PMIC-Regulators/20250707-214911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20250707134451.154346-5-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 4/8] regulator: Add support for MediaTek MT6363 SPMI PMIC Regulators
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20250715/202507150934.VLFQsCyK-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507150934.VLFQsCyK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507150934.VLFQsCyK-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/regulator/mt6363-regulator.c: In function 'mt6363_vemc_set_voltage_sel':
>> drivers/regulator/mt6363-regulator.c:457:23: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     457 |                 sel = FIELD_PREP(MT6363_RG_VEMC_VOSEL_1_MASK, sel);
         |                       ^~~~~~~~~~
   drivers/regulator/mt6363-regulator.c: In function 'mt6363_vemc_get_voltage_sel':
>> drivers/regulator/mt6363-regulator.c:489:23: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     489 |                 ret = FIELD_GET(MT6363_RG_VEMC_VOSEL_1_MASK, sel);
         |                       ^~~~~~~~~


vim +/FIELD_PREP +457 drivers/regulator/mt6363-regulator.c

   432	
   433	static int mt6363_vemc_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
   434	{
   435		const u16 tma_unlock_key = MT6363_TMA_UNLOCK_VALUE;
   436		struct regmap *regmap = rdev->regmap;
   437		unsigned int val;
   438		u16 mask;
   439		int ret;
   440	
   441		ret = regmap_read(rdev->regmap, MT6363_TOP_TRAP, &val);
   442		if (ret)
   443			return ret;
   444	
   445		if (val > 1)
   446			return -EINVAL;
   447	
   448		/* Unlock TMA for writing */
   449		ret = regmap_bulk_write(rdev->regmap, MT6363_TOP_TMA_KEY_L,
   450					&tma_unlock_key, sizeof(tma_unlock_key));
   451		if (ret)
   452			return ret;
   453	
   454		/* If HW trapping value is 1, use VEMC_VOSEL_1 instead of VEMC_VOSEL_0 */
   455		if (val == 1) {
   456			mask = MT6363_RG_VEMC_VOSEL_1_MASK;
 > 457			sel = FIELD_PREP(MT6363_RG_VEMC_VOSEL_1_MASK, sel);
   458		} else {
   459			mask = rdev->desc->vsel_mask;
   460		}
   461	
   462		/* Function must return the result of this write operation */
   463		ret = regmap_update_bits(regmap, rdev->desc->vsel_reg, mask, sel);
   464	
   465		/* Unconditionally re-lock TMA */
   466		val = 0;
   467		regmap_bulk_write(rdev->regmap, MT6363_TOP_TMA_KEY_L, &val, 2);
   468	
   469		return ret;
   470	}
   471	
   472	static int mt6363_vemc_get_voltage_sel(struct regulator_dev *rdev)
   473	{
   474		unsigned int sel, trap;
   475		int ret;
   476	
   477		ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &sel);
   478		if (ret)
   479			return ret;
   480	
   481		ret = regmap_read(rdev->regmap, MT6363_TOP_TRAP, &trap);
   482		if (ret)
   483			return ret;
   484	
   485		/* If HW trapping value is 1, use VEMC_VOSEL_1 instead of VEMC_VOSEL_0 */
   486		if (trap > 1)
   487			return -EINVAL;
   488		else if (trap == 1)
 > 489			ret = FIELD_GET(MT6363_RG_VEMC_VOSEL_1_MASK, sel);
   490		else
   491			ret = sel & rdev->desc->vsel_mask;
   492	
   493		return ret;
   494	}
   495	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

