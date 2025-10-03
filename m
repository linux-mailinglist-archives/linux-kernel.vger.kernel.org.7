Return-Path: <linux-kernel+bounces-841028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0446BB5FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D6884E3BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A521773F;
	Fri,  3 Oct 2025 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jur5vE1F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A702139CE;
	Fri,  3 Oct 2025 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473581; cv=none; b=KIjgBuSh6wNLWPuLr484jjNRZs6Fhq+FHKRTwvLKWgyvcTJw9OKdp+m3oJFYJ2OOdn4xiFZfcz0qCyH70jvShyg+pG0VnYbjSw9zlygM61WcVTynshQqCMJlv8dUi/rP4/OEs8PB4qe0DTrct/3qRmTA/1amzNrO11DDBhRX6YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473581; c=relaxed/simple;
	bh=1udu7BCVdf/1HJxKb7sLZXkalgIJcCkVINf8u8yM/dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYve4ZQ2ErPMQVATJqPOxJywOgrtrlhZom+cvWJZJRgXSSmMpU4oj6DnChb4mlFUqWCSzmi0nolIbNAdmM7y9X9ZbFM7r0yTmJ08SWnkbke8R5ZHzTOO7iJtuSdPfCsA2vOXonGTAkqAy/xB/Qh+EOcY5VwCQzd5e+EPO1+iWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jur5vE1F; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759473580; x=1791009580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1udu7BCVdf/1HJxKb7sLZXkalgIJcCkVINf8u8yM/dI=;
  b=Jur5vE1FggTkN6aJGJQNUR3Lcl4i4wx+CJ1luApLqFPZrZ7SG6oCtL7v
   Jd4rpgV1rzUaVJIuCgb7JkFZDCGjl1G2huNKk0la4aDLitCqJwXf4AV8b
   LsUcS0kLINi9A+Vt8sW8cmudxznSiWZW16SCgVr/Cb4nJ0EmBQL0PiVX4
   LBAlNpq38KSw0Z2Uj2+oq/ZKSyPpi3h/vWxUSNn07Y1xQYDMtQRbvNmEX
   yezVHke++xxhT0j//Vf8HLSIq3XiPv9+X05id/e+DPAUT7bLIfVoVyMFn
   kjlCwDN6AW9FfH2D9mlbDWPM08Gcz4RETRqkfBQnpmrKWG6WyZ6nQ4Z4U
   A==;
X-CSE-ConnectionGUID: KCCLFGMUSP+VgOG02C+CNA==
X-CSE-MsgGUID: o+zkqvasSuqYawhDjepDGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72860285"
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="72860285"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 23:39:39 -0700
X-CSE-ConnectionGUID: gZ4GhqDhS+aj3/CLaF9nhQ==
X-CSE-MsgGUID: FI2EvZm+S42jGXxwG/Rx9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="179167487"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2025 23:39:36 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4ZS1-0004NP-13;
	Fri, 03 Oct 2025 06:39:33 +0000
Date: Fri, 3 Oct 2025 14:38:48 +0800
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
Subject: Re: [PATCH v7 4/9] regulator: Add support for MediaTek MT6363 SPMI
 PMIC Regulators
Message-ID: <202510031435.HCIv3oqu-lkp@intel.com>
References: <20251002090028.1796462-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002090028.1796462-5-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on lee-mfd/for-mfd-next jic23-iio/togreg lee-leds/for-leds-next lee-mfd/for-mfd-fixes linus/master v6.17 next-20251002]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-regulator-Document-MediaTek-MT6316-PMIC-Regulators/20251002-170532
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20251002090028.1796462-5-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v7 4/9] regulator: Add support for MediaTek MT6363 SPMI PMIC Regulators
config: x86_64-randconfig-001-20251003 (https://download.01.org/0day-ci/archive/20251003/202510031435.HCIv3oqu-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251003/202510031435.HCIv3oqu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510031435.HCIv3oqu-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__devm_regmap_init_spmi_ext" [drivers/regulator/mt6363-regulator.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

