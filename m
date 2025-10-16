Return-Path: <linux-kernel+bounces-856401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B314BE40FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C95F3594FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D48345739;
	Thu, 16 Oct 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrT0bf9P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531113451DF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626767; cv=none; b=aYFx00vI5JlWYW3pwA8ndFCH/lsx6lcrq3W+yGQcvWjZcC1KlzM8w5kTkw4qeMT0cDktMFSHmrcQHtxlJ/55YMG8HnlVBVlrQOX+6qlfravmBoKX0QvvzYtNG3KCwZqKpEj1Q8a44/wqJjroPyVTMUxCjQWd6p5mdTiuh82l65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626767; c=relaxed/simple;
	bh=dz3MewSgWHCphMS4dpC0S69SCdi+UPMKOnXlykr7jUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s2e/YmU0KByr/5YlVnujvaKc+f5dYmcB0QadtwXu7I2AK3Ki6jDg2H3Rh5uDtKzETZaqkO/PHdxWpiLigp3gL9txZMVZHqvsY+pFFJf44VqTquZMfvANNffMUNtJu4LgB9KKTJxIAFNTb0XYupuy9r3jrR352tt2/IBzjLLh6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrT0bf9P; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760626765; x=1792162765;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dz3MewSgWHCphMS4dpC0S69SCdi+UPMKOnXlykr7jUo=;
  b=OrT0bf9PIBqUbtFXPUvfXhVCC+++h5oFQfu84+Ng0+W1/M8DIFOTYBEQ
   t6Cyw58QRwYwz/bjFWOyO5W6PQLhbbhIFGmyrDgWOf+7Oe6DyOSReJxx5
   DmEQsv+wU9T3HLqFQoSJDYZjNp0/yhPKNdOhuZwFfh+C/5bVLUOs6+txM
   rdwl0zfstnmwU0/+ovdWmVv9GRFFijcuuIEs7xvYIOkrgI7cvUPz+81wX
   QpkztDreKMo1fvNB1gc6WpwsjwlTDO7yeEwHwRJ4nnN5HviObxQRewUdn
   SYzRIzl/Z/RBvMcqU5qodxEAQ1PTrGTBHdShhwlDEVXw6NkT3BmiLe9H9
   w==;
X-CSE-ConnectionGUID: 6WyUMZixTGy9snHrtzjcZg==
X-CSE-MsgGUID: AsaT0YIITSGeyoplYIQ8yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62721878"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62721878"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 07:59:24 -0700
X-CSE-ConnectionGUID: N66yCT/tRLKuHBINi1WGOA==
X-CSE-MsgGUID: uVSe5penQB+x3PqQQ10YBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183275465"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 16 Oct 2025 07:59:22 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9PRn-0004wH-1R;
	Thu, 16 Oct 2025 14:59:19 +0000
Date: Thu, 16 Oct 2025 22:58:25 +0800
From: kernel test robot <lkp@intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [tip:irq/drivers 11/18] drivers/irqchip/irq-imx-mu-msi.c:419:9:
 error: call to undeclared function 'imx_mu_probe'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202510162256.hpgem8Ii-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
head:   45f8fdcfbf4e49075172cf1a3fd812b90160e903
commit: 4265aed28d7de2a643b8e441bc25344f421f2f78 [11/18] irqchip: Pass platform device to platform drivers
config: arm-randconfig-003-20251016 (https://download.01.org/0day-ci/archive/20251016/202510162256.hpgem8Ii-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510162256.hpgem8Ii-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510162256.hpgem8Ii-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-imx-mu-msi.c:419:9: error: call to undeclared function 'imx_mu_probe'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     419 |         return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx7ulp);
         |                ^
   drivers/irqchip/irq-imx-mu-msi.c:419:9: note: did you mean 'imx_mu_write'?
   drivers/irqchip/irq-imx-mu-msi.c:73:13: note: 'imx_mu_write' declared here
      73 | static void imx_mu_write(struct imx_mu_msi *msi_data, u32 val, u32 offs)
         |             ^
   drivers/irqchip/irq-imx-mu-msi.c:424:9: error: call to undeclared function 'imx_mu_probe'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     424 |         return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx6sx);
         |                ^
   drivers/irqchip/irq-imx-mu-msi.c:429:9: error: call to undeclared function 'imx_mu_probe'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     429 |         return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx8ulp);
         |                ^
   3 errors generated.


vim +/imx_mu_probe +419 drivers/irqchip/irq-imx-mu-msi.c

   416	
   417	static int imx_mu_imx7ulp_probe(struct platform_device *pdev, struct device_node *parent)
   418	{
 > 419		return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx7ulp);
   420	}
   421	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

