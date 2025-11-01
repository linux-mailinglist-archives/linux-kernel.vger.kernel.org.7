Return-Path: <linux-kernel+bounces-881420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDF7C282A3
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD132404597
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD5246783;
	Sat,  1 Nov 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXNH+2c1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842562264CD
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014351; cv=none; b=hO4ArMteJCEv7h4xiM0lzr8vG15dB1H2o7qHdASTcKz0r4ax5VpEIQchi6CjI/ghRmQk4J1B5fiMP+KNLEe1pKPtuy8mF2Sbb+TJRquFxH60elqDdCXaUULIL5gs+pHhR092M2NTILYimhu8NRBDWYgzv/zqxpGH8h9sFLbcz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014351; c=relaxed/simple;
	bh=pPFMBUE3E/n+AfJdNxDIBYoEpsa4YYKIvKgatrJJXhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbzWefYQTwbG7Tzsn0dTX3nR/Huy9qNXeuJ+WLBqSlXvNTjfIqYS/SluAlh7z/tMMqCFqTSphRj4WaEloUgyZtpHDf0M8pJHph6Px6O9b3DdhrqM5x4WIsCf2v7bLc7JGwdUVLeZoi2R8x7rjDqB8EXweNaQLjA+Y1SG1Ev8WFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXNH+2c1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762014350; x=1793550350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pPFMBUE3E/n+AfJdNxDIBYoEpsa4YYKIvKgatrJJXhE=;
  b=VXNH+2c1J+P5CAPWd1eoIPmLZ4Hcjd96BxIm3g9Z2RnaD0q3AyXCRMFJ
   Mjc5kBD46paQbeRiyjSx75PfIAjGARamID3Pdlrjp0Oc1U6dMkj3UBCDd
   Y9uRWfXUKctU0qFFumxOmbRtNUcVyBCFQiTvJfWr3JAohB+ZEQFPLds7t
   0DnKqUTMxvKTPJ0/tI9kjvE/NVvhnu681MNHQ+UbwoYM88A3fL7DtociG
   pAutT9uLfA2fHrsrLasU7fspNyaIR6CaGly+oCKOVdxgU+59GTQ10+zco
   Hd1bQyA4j62W5qwSKwodKALiSBH3e1AdnWeBGKzHIop7r/zEr8LT6D+83
   w==;
X-CSE-ConnectionGUID: lbIRr8vqQHSESHAu4Dr+Mw==
X-CSE-MsgGUID: Vlsx2YTsQKmmoOo2h2c9EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="64193815"
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="64193815"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 09:25:48 -0700
X-CSE-ConnectionGUID: /34bxfPXTfi+RPw7sLLQwg==
X-CSE-MsgGUID: 66b9k+8qQo6oJv7sbFfA9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="186940434"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 01 Nov 2025 09:25:44 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFEQA-000OSu-1r;
	Sat, 01 Nov 2025 16:25:42 +0000
Date: Sun, 2 Nov 2025 00:25:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vishal Mahaveer <vishalm@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: Re: [PATCH v9 3/3] firmware: ti_sci: Partial-IO support
Message-ID: <202511020037.8sAseAYs-lkp@intel.com>
References: <20251030-topic-am62-partialio-v6-12-b4-v9-3-074f55d9c16b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-topic-am62-partialio-v6-12-b4-v9-3-074f55d9c16b@baylibre.com>

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c9a389ffad27e7847c69f4d2b67ba56b77190209]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann-TI-com/firmware-ti_sci-Remove-constant-0-function-arguments/20251030-173054
base:   c9a389ffad27e7847c69f4d2b67ba56b77190209
patch link:    https://lore.kernel.org/r/20251030-topic-am62-partialio-v6-12-b4-v9-3-074f55d9c16b%40baylibre.com
patch subject: [PATCH v9 3/3] firmware: ti_sci: Partial-IO support
config: arm-randconfig-002-20251101 (https://download.01.org/0day-ci/archive/20251102/202511020037.8sAseAYs-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251102/202511020037.8sAseAYs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511020037.8sAseAYs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/ti_sci.c:10:9: warning: 'pr_fmt' macro redefined [-Wmacro-redefined]
      10 | #define pr_fmt(fmt) "%s: " fmt, __func__
         |         ^
   include/linux/printk.h:402:9: note: previous definition is here
     402 | #define pr_fmt(fmt) fmt
         |         ^
   1 warning generated.


vim +/pr_fmt +10 drivers/firmware/ti_sci.c

aa276781a64a5f Nishanth Menon 2016-10-18 @10  #define pr_fmt(fmt) "%s: " fmt, __func__
aa276781a64a5f Nishanth Menon 2016-10-18  11  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

