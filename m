Return-Path: <linux-kernel+bounces-894997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 695D7C4CAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D264F56B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC788228CA9;
	Tue, 11 Nov 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9y3NNKq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4421E7C23
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853355; cv=none; b=jESLauKc8eX4lH7NwvugYMccarMDOZ2r0pDKZFQYh4Qp99OcpES0zWqjTE8gIvrpHUF2XSQqkUbQNRLSjO/EzHvGMFdmslv+762C7nqOmHOfq1/l6Nq+ng2s/w+fIPvFJRJGfR7QnnzJxQpQrTrukbtg8yODit1BBamOCUY0De8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853355; c=relaxed/simple;
	bh=X3Pfna6q1LslALfJlKLTcg9wvJZz1J+YXyBMsPuJOdY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i1CjiY/wEoTse9MBOj5MNCSQFLeSK5pOepH93kom3JMXOOVJBt8AaDrBA3H2go1LY9JISaokpeVE09mzIknFHLA6zPCs90Zsj/v2T8RMy00tWSCXkWBlPBZ7F3nH65e/o2DO/HRxF2+P/JxX6FVn4jil0VnbczNngvMHGgKq4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9y3NNKq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762853354; x=1794389354;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X3Pfna6q1LslALfJlKLTcg9wvJZz1J+YXyBMsPuJOdY=;
  b=S9y3NNKq0y3KNKJrUiV9IJjim/MOs05Cu27ZvkExyCZU01ccoP+81f7p
   n7Q0kDX/KbPx3Q3ROBTHMJ9l5/aKXpaXF6bmCMu/4DZFhVn3aSC4aW7WK
   jI6CjeXd0l+Uwsl9YOduGzcUb/efoTSjpyJsGlL+I1ftKsXvpZiQeytcq
   7Twfvk4we3s9pIwNxyiIHpgVSwysTDdakKFNZyW8Ci82JDjhvDovjSNX0
   /UVAEGv3SStMDbPLrpK5tvijIKci7mLtrTmMlpOybmvEDtN+ELk+Hxw99
   ybf9HMmfaxvaFShjykR5tG/wHQrtwvaLzw9k9XVd2P3RSGmNmnHoSMGw2
   A==;
X-CSE-ConnectionGUID: Rj6hKGpyRM+s2vTbckDVsg==
X-CSE-MsgGUID: zX2JfCR/QXybnpiBh8QUDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75528951"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="75528951"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 01:29:13 -0800
X-CSE-ConnectionGUID: K6A4IGZtSJy6pOPRpGCvpQ==
X-CSE-MsgGUID: w2XnrKhPSVSWNqwPHr3crQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="212309282"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2025 01:29:12 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIkgX-00030m-2U;
	Tue, 11 Nov 2025 09:29:09 +0000
Date: Tue, 11 Nov 2025 17:28:54 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: drivers/pci/controller/cadence/pci-j721e.c:648:undefined reference
 to `cdns_pcie_host_disable'
Message-ID: <202511111705.MZ7ls8Hm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
commit: 1c72774df028429836eec3394212f2921bb830fc PCI: sg2042: Add Sophgo SG2042 PCIe driver
date:   8 weeks ago
config: loongarch-randconfig-r113-20251110 (https://download.01.org/0day-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/pci/controller/cadence/pci-j721e.o: in function `j721e_pcie_remove':
>> drivers/pci/controller/cadence/pci-j721e.c:648:(.text+0x83c): undefined reference to `cdns_pcie_host_disable'


vim +648 drivers/pci/controller/cadence/pci-j721e.c

f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  637  
c86f4bd6008e7e Uwe Kleine-König       2023-03-21  638  static void j721e_pcie_remove(struct platform_device *pdev)
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  639  {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  640  	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  641  	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  642  	struct device *dev = &pdev->dev;
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  643  	struct cdns_pcie_ep *ep;
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  644  	struct cdns_pcie_rc *rc;
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  645  
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  646  	if (pcie->mode == PCI_MODE_RC) {
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  647  		rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17 @648  		cdns_pcie_host_disable(rc);
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  649  	} else {
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  650  		ep = container_of(cdns_pcie, struct cdns_pcie_ep, pcie);
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  651  		cdns_pcie_ep_disable(ep);
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  652  	}
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  653  
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  654  	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  655  
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  656  	clk_disable_unprepare(pcie->refclk);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  657  	cdns_pcie_disable_phy(cdns_pcie);
a2790bf81f0f7b Siddharth Vadapalli    2025-04-17  658  	j721e_pcie_disable_link_irq(pcie);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  659  	pm_runtime_put(dev);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  660  	pm_runtime_disable(dev);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  661  }
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  662  

:::::: The code at line 648 was first introduced by commit
:::::: a2790bf81f0f7b0fb683204cd3bef07feecb9958 PCI: j721e: Add support to build as a loadable module

:::::: TO: Siddharth Vadapalli <s-vadapalli@ti.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

