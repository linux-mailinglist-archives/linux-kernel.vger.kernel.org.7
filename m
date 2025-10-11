Return-Path: <linux-kernel+bounces-849009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856CBCF024
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEC2424642
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7031C1B142D;
	Sat, 11 Oct 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBvRNDia"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3542A96;
	Sat, 11 Oct 2025 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160802; cv=none; b=RC3WJvuqyw/CapVR9FGpZ4Fi6/vB4v5T69EJBMjYbIfTGwitEO+Dv/Rz4sHSw2Ze590BIbm8zPMI67kdMBAzuF0LP15E1QdgxM1TJR5Pbsyl2nxv57swNK+/TIlJGFIOAOQ1c7KI8O2FFPOvmNSFTf4Ymwfd1mIL/YuKH/pBDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160802; c=relaxed/simple;
	bh=i9MQD2vi87alMgAlFMVJwNlAR7uWjr5N9wlOTw9xWUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev9DIYUTuQqehbiEsl2vTMx1vtCMJIwdao6ehVL7UhGf4s+9e7i6R5Cfmgb8bTDUJZkt55A5NcRfMCJOaq3Apr6R6IoykaizWpXcX9A4+DiZLmTp7T5m72td7cE1/KMOer3oOjkFKOYxbPuNCUqtn+98eiulthwanL6lg0VAXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBvRNDia; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760160801; x=1791696801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i9MQD2vi87alMgAlFMVJwNlAR7uWjr5N9wlOTw9xWUo=;
  b=NBvRNDia1GOlTEdnOYCKTU764RTf/bGkDyPQW14WYsTxwj0s/qXNFfkn
   Npx8ImCALwSOERMPOOiX0kg9tNr4Wm2bDspYPgno/FIlUrb/04t9ucHuz
   brDlrPju2xlxLUTIL8ZYK9faeAwphyNB1ZoZXgm96JrkUsb3+QgWqA8Wj
   GybfdnuZxIBwnrVGeeNEmRfIQXaBvQw00EtIiLOu949dyWyop9J66pelq
   Yq/BgkntOMkDuifvBLARCmWvcdoVLyJmagDukl3qSCzHH62RHQlZZvmHD
   M2rpurHOvrQ6hFgGasGILnl2Cb2DrnWRcgV0QbITG19ujOKEOeM0ZS9gJ
   Q==;
X-CSE-ConnectionGUID: kJyyUjA+QbGJk8ovYGoc/A==
X-CSE-MsgGUID: JMfdkV3jR5atvHhOzy/PBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="73060199"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="73060199"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 22:33:20 -0700
X-CSE-ConnectionGUID: hm20f+lUTteEogIs84GaQg==
X-CSE-MsgGUID: KQgz213TSu6dzQ/MgUIx8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180968712"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Oct 2025 22:33:16 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7SEE-0003Xl-08;
	Sat, 11 Oct 2025 05:33:14 +0000
Date: Sat, 11 Oct 2025 13:32:50 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v8 6/9] regulator: Add support for MediaTek MT6373 SPMI
 PMIC Regulators
Message-ID: <202510111324.JD1amFXO-lkp@intel.com>
References: <20251003091158.26748-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003091158.26748-7-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on lee-mfd/for-mfd-next jic23-iio/togreg lee-leds/for-leds-next lee-mfd/for-mfd-fixes linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-regulator-Document-MediaTek-MT6316-PMIC-Regulators/20251003-171606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20251003091158.26748-7-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v8 6/9] regulator: Add support for MediaTek MT6373 SPMI PMIC Regulators
config: alpha-randconfig-r073-20251009 (https://download.01.org/0day-ci/archive/20251011/202510111324.JD1amFXO-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111324.JD1amFXO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111324.JD1amFXO-lkp@intel.com/

All errors (new ones prefixed by >>):

   `xe_configfs_exit' referenced in section `.data.rel.ro' of drivers/gpu/drm/xe/xe_module.o: defined in discarded section `.exit.text' of drivers/gpu/drm/xe/xe_configfs.o
   alpha-linux-ld: drivers/regulator/mt6373-regulator.o: in function `mt6373_spmi_remove':
   drivers/regulator/mt6373-regulator.c:598:(.text+0x6b0): undefined reference to `spmi_device_remove'
>> alpha-linux-ld: drivers/regulator/mt6373-regulator.c:598:(.text+0x6b8): undefined reference to `spmi_device_remove'
   alpha-linux-ld: drivers/regulator/mt6373-regulator.o: in function `mt6373_spmi_register_regmap':
   drivers/regulator/mt6373-regulator.c:624:(.text+0x93c): undefined reference to `spmi_device_alloc'
>> alpha-linux-ld: drivers/regulator/mt6373-regulator.c:624:(.text+0x940): undefined reference to `spmi_device_alloc'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_base_read':
   drivers/base/regmap/regmap-spmi.c:26:(.text+0x11c): undefined reference to `spmi_register_read'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:26:(.text+0x124): undefined reference to `spmi_register_read'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_base_gather_write':
   drivers/base/regmap/regmap-spmi.c:46:(.text+0x1f0): undefined reference to `spmi_register_zero_write'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:46:(.text+0x1f4): undefined reference to `spmi_register_zero_write'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:56:(.text+0x220): undefined reference to `spmi_register_write'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:56:(.text+0x228): undefined reference to `spmi_register_write'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_ext_read':
   drivers/base/regmap/regmap-spmi.c:124:(.text+0x3f0): undefined reference to `spmi_ext_register_read'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:124:(.text+0x404): undefined reference to `spmi_ext_register_read'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:136:(.text+0x444): undefined reference to `spmi_ext_register_readl'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:136:(.text+0x458): undefined reference to `spmi_ext_register_readl'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_ext_gather_write':
   drivers/base/regmap/regmap-spmi.c:164:(.text+0x528): undefined reference to `spmi_ext_register_write'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:164:(.text+0x53c): undefined reference to `spmi_ext_register_write'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:176:(.text+0x57c): undefined reference to `spmi_ext_register_writel'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:176:(.text+0x590): undefined reference to `spmi_ext_register_writel'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPMI
   Depends on [n]: SPMI [=n]
   Selected by [y]:
   - REGULATOR_MT6316 [=y] && REGULATOR [=y] && (SPMI [=n] || COMPILE_TEST [=y])
   - REGULATOR_MT6373 [=y] && REGULATOR [=y] && (SPMI [=n] || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

