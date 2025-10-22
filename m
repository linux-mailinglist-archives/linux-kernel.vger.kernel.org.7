Return-Path: <linux-kernel+bounces-864315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B700BFA810
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93391892837
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4F82F5A1C;
	Wed, 22 Oct 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Int9qboz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9692F5319;
	Wed, 22 Oct 2025 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117565; cv=none; b=T2AJ507xY0g4d6Qah77M2vfvlyi5wdslZ4vJp4m9tc3Wype1Va1nIY+LtiTfosWWw+/3UkilBRvzuQhhTztxrSoi7aS2W26/kovIIkii407eIqaY69gY8iRv3NrUHStyNRUkzyCHzOdCRazCQigKJ86iL0mSBNJZEAKzpHQaZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117565; c=relaxed/simple;
	bh=UiGPap5OuCArfvp0Rq7pyLVsVmVZWUW9e6oIXM/7mSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6FBe6PhrkJTGVGHedeW6v5JEoHs2n0DOtKKKZGLaw0aX6Exlzbptr93GDNjsczZdhqpGqN8Z/jn2ZXzfaOP/IvnNDwUx3ttKecFq7f0JLtFIRnZDXYMAtipOjbnbVY+IBV5T2SGDFGkyJzHAq1VVaHczD5+e7wa15f0x4ggeYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Int9qboz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761117563; x=1792653563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UiGPap5OuCArfvp0Rq7pyLVsVmVZWUW9e6oIXM/7mSs=;
  b=Int9qboz1llnZRqMp/pV75Cg8P0cG1+DUNThJVxb1seHfRHFt1+2xbJg
   +W/l2IachMMcnG25KaKCAuWXc5gjwJ1eLVtirmNbmU4cp8NqkqFIQyTFX
   PobPv4miOJ1D53Ztkgnok++n2eG4jxTUI1+Khp+GHPohaM+19729fUW/Y
   iIXOLqFSysT/zqwxBpZaXd7wjDRg0mw/oOTwFxLi/m3ZNBrqkJYgYTaMh
   PnCnYDLgKBSIqKI5ojydENI2WAAa0n20m6w58J4xfS0SlVjJnKi7weXOW
   iKqAlAPJM17K6MYIWQxPMe8TrcQSAkCK9N23PM4T35qDEB07iDg7KFHWM
   g==;
X-CSE-ConnectionGUID: bnY7A5vWSZ64nikuQRJZrw==
X-CSE-MsgGUID: 1qiLYUYkTjG7yGW/g8LOjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62466003"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="62466003"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 00:19:22 -0700
X-CSE-ConnectionGUID: 7M7TzhqdR9KlUZ387HsP5Q==
X-CSE-MsgGUID: 1tHd2Us/SE61EU8ZcZSO7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="188074733"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 22 Oct 2025 00:19:18 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBT7s-000C5h-1T;
	Wed, 22 Oct 2025 07:19:16 +0000
Date: Wed, 22 Oct 2025 15:18:28 +0800
From: kernel test robot <lkp@intel.com>
To: muhammed.efecetin.67@gmail.com, linux-rockchip@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
	neil.armstrong@linaro.org, lee@kernel.org, rafael@kernel.org,
	efectn@protonmail.com, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 3/5] mfd: add Khadas Edge 2 registers to khadas-mcu.
Message-ID: <202510221512.9Ji8w2KZ-lkp@intel.com>
References: <adbd6dd5e9ed938bab7927597b7f21eca3274b78.1761059314.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adbd6dd5e9ed938bab7927597b7f21eca3274b78.1761059314.git.efectn@protonmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on lee-mfd/for-mfd-fixes rockchip/for-next rafael-pm/thermal linus/master v6.18-rc2 next-20251022]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/muhammed-efecetin-67-gmail-com/dt-bindings-mfd-khadas-mcu-add-new-compatible-for-Khadas-Edge-2/20251021-232554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/adbd6dd5e9ed938bab7927597b7f21eca3274b78.1761059314.git.efectn%40protonmail.com
patch subject: [PATCH v3 3/5] mfd: add Khadas Edge 2 registers to khadas-mcu.
config: i386-buildonly-randconfig-002-20251022 (https://download.01.org/0day-ci/archive/20251022/202510221512.9Ji8w2KZ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510221512.9Ji8w2KZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510221512.9Ji8w2KZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/khadas-mcu.c:93:35: warning: unused variable 'khadas_mcu_regmap_config' [-Wunused-const-variable]
      93 | static const struct regmap_config khadas_mcu_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mfd/khadas-mcu.c:103:35: warning: unused variable 'khadas_mcu_regmap_config_edge2' [-Wunused-const-variable]
     103 | static const struct regmap_config khadas_mcu_regmap_config_edge2 = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/khadas_mcu_regmap_config +93 drivers/mfd/khadas-mcu.c

54c97b83897fb1 Muhammed Efe Cetin 2025-10-21   92  
6c27219e349116 Neil Armstrong     2020-06-08  @93  static const struct regmap_config khadas_mcu_regmap_config = {
6c27219e349116 Neil Armstrong     2020-06-08   94  	.reg_bits	= 8,
6c27219e349116 Neil Armstrong     2020-06-08   95  	.reg_stride	= 1,
6c27219e349116 Neil Armstrong     2020-06-08   96  	.val_bits	= 8,
6c27219e349116 Neil Armstrong     2020-06-08   97  	.max_register	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
6c27219e349116 Neil Armstrong     2020-06-08   98  	.volatile_reg	= khadas_mcu_reg_volatile,
6c27219e349116 Neil Armstrong     2020-06-08   99  	.writeable_reg	= khadas_mcu_reg_writeable,
14100f8e58564d Bo Liu             2024-02-06  100  	.cache_type	= REGCACHE_MAPLE,
6c27219e349116 Neil Armstrong     2020-06-08  101  };
6c27219e349116 Neil Armstrong     2020-06-08  102  
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21 @103  static const struct regmap_config khadas_mcu_regmap_config_edge2 = {
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21  104  	.reg_bits	= 8,
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21  105  	.reg_stride	= 1,
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21  106  	.val_bits	= 8,
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21  107  	.max_register	= KHADAS_MCU_EDGE2_SYS_RST_REG,
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21  108  	.volatile_reg	= khadas_mcu_reg_volatile_edge2,
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21  109  	.writeable_reg	= khadas_mcu_reg_writeable_edge2,
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21  110  	.cache_type	= REGCACHE_MAPLE,
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21  111  };
54c97b83897fb1 Muhammed Efe Cetin 2025-10-21  112  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

