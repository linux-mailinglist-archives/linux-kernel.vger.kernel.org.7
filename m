Return-Path: <linux-kernel+bounces-603660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA55A88A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E3B17CD18
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC89191F84;
	Mon, 14 Apr 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeLjm0Mg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA7288CB2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653702; cv=none; b=Eaujaie/OoE1DL7V5AnDpzrsZxu+nvsh3dX7n8YNyMebFbE7WBu++ChaYOJEQz5LZtfCcZhwKf6v+z8u1goI8/ejQVLOhR2QSBjMdscDboD5HsXDTPYnGhSiDVJH5Jg5XjL59PK6T/TjpXoQZLk+KvUjWZju3+s0rrvCE5lo4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653702; c=relaxed/simple;
	bh=G7PxkYqPYv3OuWhhgnZ02TsFSmlFOr6o2vQSKFes5m0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WV+igyFuvNY86gP1oGCoxlNwePAHIhAyf5xlRkgfSa9uzVVERIv1TItM9mHJph+6XcztLJI/iNjqnObn7eWhkbfdK8lcrKqrOD7WFDBngkjpQ8lskaTSCpMmNv+flGRGBfvfRVvV3K5HUYA8zqK9B2vQVtUGUUCMYVomh7zq9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeLjm0Mg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744653699; x=1776189699;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G7PxkYqPYv3OuWhhgnZ02TsFSmlFOr6o2vQSKFes5m0=;
  b=OeLjm0Mg9VvMaKL0O7GRvOyeJ47f+0f4xscd/Bys2a3qeAS2Z2nNlNSf
   vXPR+c3MLDdQk6EBskLGZZ59zSNiNHLDgUKj1BSSCSdqBW6nhlkkYk46g
   p9Y0S1d5SuTWsX7093vqbuN3A/tc0tCpGM0pFi4Pfa4zN/5odu45AWemN
   +U79GLC5uizUvCxoCn98KFQBUR/Vl/LjUyJlRt+77OqQ91qpgxMW6SARk
   dtX/XXY6hnre9Z9hX70glLjrgGYzxZTyxfXnu4Ia3S6zmDboCx4IHMthw
   S/QVJUWLgyru9HcIAvGEekPQ7/vIunKcgxPpBl1eE2VDw+LuVTwnck2/6
   A==;
X-CSE-ConnectionGUID: gcwySwEGQ66+S8Q2jh//+g==
X-CSE-MsgGUID: X2M79tlmS+u6lDEuHnd8EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="63680507"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="63680507"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 11:01:38 -0700
X-CSE-ConnectionGUID: h7BjMY/wQ2Oy1DbBMygCSA==
X-CSE-MsgGUID: Q4S2C2njQ4CuFzdtXNKz2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="129888200"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Apr 2025 11:01:37 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4O7j-000EXz-0U;
	Mon, 14 Apr 2025 18:01:35 +0000
Date: Tue, 15 Apr 2025 02:01:02 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Penkler <dpenkler@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/staging/gpib/eastwood/fluke_gpib.c:1013:19: warning:
 assignment makes pointer from integer without a cast
Message-ID: <202504150249.sGJCdyor-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ffd015db85fea3e15a77027fda6c02ced4d2444
commit: 165e8cc3cfec9ef51f3376b0d49b115294f34f3b staging: gpib: Add KBUILD files for GPIB drivers
date:   6 months ago
config: s390-randconfig-002-20250415 (https://download.01.org/0day-ci/archive/20250415/202504150249.sGJCdyor-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250415/202504150249.sGJCdyor-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504150249.sGJCdyor-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/staging/gpib/eastwood/fluke_gpib.c: In function 'fluke_line_status':
   drivers/staging/gpib/eastwood/fluke_gpib.c:196:23: warning: variable 'nec_priv' set but not used [-Wunused-but-set-variable]
     struct nec7210_priv *nec_priv;
                          ^~~~~~~~
   drivers/staging/gpib/eastwood/fluke_gpib.c: In function 'fluke_attach_impl':
   drivers/staging/gpib/eastwood/fluke_gpib.c:1013:21: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
     nec_priv->iobase = ioremap(e_priv->gpib_iomem_res->start,
                        ^~~~~~~
                        iounmap
>> drivers/staging/gpib/eastwood/fluke_gpib.c:1013:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     nec_priv->iobase = ioremap(e_priv->gpib_iomem_res->start,
                      ^
   drivers/staging/gpib/eastwood/fluke_gpib.c:1050:33: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     e_priv->write_transfer_counter = ioremap(e_priv->write_transfer_counter_res->start,
                                    ^
   In file included from drivers/staging/gpib/eastwood/fluke_gpib.c:10:0:
   At top level:
   drivers/staging/gpib/eastwood/fluke_gpib.h:140:18: warning: 'fluke_num_regs' defined but not used [-Wunused-const-variable=]
    static const int fluke_num_regs = 8;
                     ^~~~~~~~~~~~~~
   In file included from drivers/staging/gpib/include/nec7210.h:17:0,
                    from drivers/staging/gpib/eastwood/fluke_gpib.h:13,
                    from drivers/staging/gpib/eastwood/fluke_gpib.c:10:
   drivers/staging/gpib/include/nec7210_registers.h:21:18: warning: 'nec7210_num_registers' defined but not used [-Wunused-const-variable=]
    static const int nec7210_num_registers = 8;
                     ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/staging/gpib/include/gpib_types.h:16:0,
                    from drivers/staging/gpib/include/nec7210.h:16,
                    from drivers/staging/gpib/eastwood/fluke_gpib.h:13,
                    from drivers/staging/gpib/eastwood/fluke_gpib.c:10:
   drivers/staging/gpib/uapi/gpib_user.h:344:18: warning: 'request_service_bit' defined but not used [-Wunused-const-variable=]
    static const int request_service_bit = 0x40;
                     ^~~~~~~~~~~~~~~~~~~
   drivers/staging/gpib/uapi/gpib_user.h:264:18: warning: 'gpib_addr_max' defined but not used [-Wunused-const-variable=]
    static const int gpib_addr_max = 30; /* max address for primary/secondary gpib addresses */
                     ^~~~~~~~~~~~~
   drivers/staging/gpib/uapi/gpib_user.h:212:22: warning: 'gpib_command_mask' defined but not used [-Wunused-const-variable=]
    static const uint8_t gpib_command_mask = 0x7f;
                         ^~~~~~~~~~~~~~~~~
   drivers/staging/gpib/uapi/gpib_user.h:53:18: warning: 'board_status_mask' defined but not used [-Wunused-const-variable=]
    static const int board_status_mask = ERR | TIMO | END | CMPL | SPOLL |
                     ^~~~~~~~~~~~~~~~~
   drivers/staging/gpib/uapi/gpib_user.h:52:18: warning: 'device_status_mask' defined but not used [-Wunused-const-variable=]
    static const int device_status_mask = ERR | TIMO | END | CMPL | RQS;
                     ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1013 drivers/staging/gpib/eastwood/fluke_gpib.c

55936779f496129 Dave Penkler 2024-09-18   973  
55936779f496129 Dave Penkler 2024-09-18   974  static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *config,
55936779f496129 Dave Penkler 2024-09-18   975  			     unsigned int handshake_mode)
55936779f496129 Dave Penkler 2024-09-18   976  {
55936779f496129 Dave Penkler 2024-09-18   977  	struct fluke_priv *e_priv;
55936779f496129 Dave Penkler 2024-09-18   978  	struct nec7210_priv *nec_priv;
55936779f496129 Dave Penkler 2024-09-18   979  	int isr_flags = 0;
55936779f496129 Dave Penkler 2024-09-18   980  	int retval;
55936779f496129 Dave Penkler 2024-09-18   981  	int irq;
55936779f496129 Dave Penkler 2024-09-18   982  	struct resource *res;
55936779f496129 Dave Penkler 2024-09-18   983  	dma_cap_mask_t dma_cap;
55936779f496129 Dave Penkler 2024-09-18   984  
55936779f496129 Dave Penkler 2024-09-18   985  	if (!fluke_gpib_pdev) {
55936779f496129 Dave Penkler 2024-09-18   986  		pr_err("No gpib platform device was found, attach failed.\n");
55936779f496129 Dave Penkler 2024-09-18   987  		return -ENODEV;
55936779f496129 Dave Penkler 2024-09-18   988  	}
55936779f496129 Dave Penkler 2024-09-18   989  
55936779f496129 Dave Penkler 2024-09-18   990  	retval = fluke_generic_attach(board);
55936779f496129 Dave Penkler 2024-09-18   991  	if (retval)
55936779f496129 Dave Penkler 2024-09-18   992  		return retval;
55936779f496129 Dave Penkler 2024-09-18   993  
55936779f496129 Dave Penkler 2024-09-18   994  	e_priv = board->private_data;
55936779f496129 Dave Penkler 2024-09-18   995  	nec_priv = &e_priv->nec7210_priv;
55936779f496129 Dave Penkler 2024-09-18   996  	nec_priv->offset = fluke_reg_offset;
55936779f496129 Dave Penkler 2024-09-18   997  	board->dev = &fluke_gpib_pdev->dev;
55936779f496129 Dave Penkler 2024-09-18   998  
55936779f496129 Dave Penkler 2024-09-18   999  	res = platform_get_resource(fluke_gpib_pdev, IORESOURCE_MEM, 0);
55936779f496129 Dave Penkler 2024-09-18  1000  	if (!res) {
55936779f496129 Dave Penkler 2024-09-18  1001  		dev_err(&fluke_gpib_pdev->dev, "Unable to locate mmio resource for cb7210 gpib\n");
55936779f496129 Dave Penkler 2024-09-18  1002  		return -ENODEV;
55936779f496129 Dave Penkler 2024-09-18  1003  	}
55936779f496129 Dave Penkler 2024-09-18  1004  
55936779f496129 Dave Penkler 2024-09-18  1005  	if (request_mem_region(res->start,
55936779f496129 Dave Penkler 2024-09-18  1006  			       resource_size(res),
55936779f496129 Dave Penkler 2024-09-18  1007  			       fluke_gpib_pdev->name) == NULL) {
55936779f496129 Dave Penkler 2024-09-18  1008  		dev_err(&fluke_gpib_pdev->dev, "cannot claim registers\n");
55936779f496129 Dave Penkler 2024-09-18  1009  		return -ENXIO;
55936779f496129 Dave Penkler 2024-09-18  1010  	}
55936779f496129 Dave Penkler 2024-09-18  1011  	e_priv->gpib_iomem_res = res;
55936779f496129 Dave Penkler 2024-09-18  1012  
55936779f496129 Dave Penkler 2024-09-18 @1013  	nec_priv->iobase = ioremap(e_priv->gpib_iomem_res->start,
55936779f496129 Dave Penkler 2024-09-18  1014  				   resource_size(e_priv->gpib_iomem_res));
55936779f496129 Dave Penkler 2024-09-18  1015  	pr_info("gpib: iobase %lx remapped to %p, length=%d\n",
55936779f496129 Dave Penkler 2024-09-18  1016  		(unsigned long)e_priv->gpib_iomem_res->start,
55936779f496129 Dave Penkler 2024-09-18  1017  		nec_priv->iobase, (int)resource_size(e_priv->gpib_iomem_res));
55936779f496129 Dave Penkler 2024-09-18  1018  	if (!nec_priv->iobase) {
55936779f496129 Dave Penkler 2024-09-18  1019  		dev_err(&fluke_gpib_pdev->dev, "Could not map I/O memory\n");
55936779f496129 Dave Penkler 2024-09-18  1020  		return -ENOMEM;
55936779f496129 Dave Penkler 2024-09-18  1021  	}
55936779f496129 Dave Penkler 2024-09-18  1022  
55936779f496129 Dave Penkler 2024-09-18  1023  	res = platform_get_resource(fluke_gpib_pdev, IORESOURCE_MEM, 1);
55936779f496129 Dave Penkler 2024-09-18  1024  	if (!res) {
55936779f496129 Dave Penkler 2024-09-18  1025  		dev_err(&fluke_gpib_pdev->dev, "Unable to locate mmio resource for gpib dma port\n");
55936779f496129 Dave Penkler 2024-09-18  1026  		return -ENODEV;
55936779f496129 Dave Penkler 2024-09-18  1027  	}
55936779f496129 Dave Penkler 2024-09-18  1028  	if (request_mem_region(res->start,
55936779f496129 Dave Penkler 2024-09-18  1029  			       resource_size(res),
55936779f496129 Dave Penkler 2024-09-18  1030  			       fluke_gpib_pdev->name) == NULL) {
55936779f496129 Dave Penkler 2024-09-18  1031  		dev_err(&fluke_gpib_pdev->dev, "cannot claim registers\n");
55936779f496129 Dave Penkler 2024-09-18  1032  		return -ENXIO;
55936779f496129 Dave Penkler 2024-09-18  1033  	}
55936779f496129 Dave Penkler 2024-09-18  1034  	e_priv->dma_port_res = res;
55936779f496129 Dave Penkler 2024-09-18  1035  
55936779f496129 Dave Penkler 2024-09-18  1036  	res = platform_get_resource(fluke_gpib_pdev, IORESOURCE_MEM, 2);
55936779f496129 Dave Penkler 2024-09-18  1037  	if (!res) {
55936779f496129 Dave Penkler 2024-09-18  1038  		dev_err(&fluke_gpib_pdev->dev, "Unable to locate mmio resource for write transfer counter\n");
55936779f496129 Dave Penkler 2024-09-18  1039  		return -ENODEV;
55936779f496129 Dave Penkler 2024-09-18  1040  	}
55936779f496129 Dave Penkler 2024-09-18  1041  
55936779f496129 Dave Penkler 2024-09-18  1042  	if (request_mem_region(res->start,
55936779f496129 Dave Penkler 2024-09-18  1043  			       resource_size(res),
55936779f496129 Dave Penkler 2024-09-18  1044  			       fluke_gpib_pdev->name) == NULL) {
55936779f496129 Dave Penkler 2024-09-18  1045  		dev_err(&fluke_gpib_pdev->dev, "cannot claim registers\n");
55936779f496129 Dave Penkler 2024-09-18  1046  		return -ENXIO;
55936779f496129 Dave Penkler 2024-09-18  1047  	}
55936779f496129 Dave Penkler 2024-09-18  1048  	e_priv->write_transfer_counter_res = res;
55936779f496129 Dave Penkler 2024-09-18  1049  
55936779f496129 Dave Penkler 2024-09-18  1050  	e_priv->write_transfer_counter = ioremap(e_priv->write_transfer_counter_res->start,
55936779f496129 Dave Penkler 2024-09-18  1051  						 resource_size(e_priv->write_transfer_counter_res));
55936779f496129 Dave Penkler 2024-09-18  1052  	pr_info("gpib: write transfer counter %lx remapped to %p, length=%d\n",
55936779f496129 Dave Penkler 2024-09-18  1053  		(unsigned long)e_priv->write_transfer_counter_res->start,
55936779f496129 Dave Penkler 2024-09-18  1054  		e_priv->write_transfer_counter,
55936779f496129 Dave Penkler 2024-09-18  1055  		(int)resource_size(e_priv->write_transfer_counter_res));
55936779f496129 Dave Penkler 2024-09-18  1056  	if (!e_priv->write_transfer_counter) {
55936779f496129 Dave Penkler 2024-09-18  1057  		dev_err(&fluke_gpib_pdev->dev, "Could not map I/O memory\n");
55936779f496129 Dave Penkler 2024-09-18  1058  		return -ENOMEM;
55936779f496129 Dave Penkler 2024-09-18  1059  	}
55936779f496129 Dave Penkler 2024-09-18  1060  
55936779f496129 Dave Penkler 2024-09-18  1061  	irq = platform_get_irq(fluke_gpib_pdev, 0);
55936779f496129 Dave Penkler 2024-09-18  1062  	pr_info("gpib: irq %d\n", irq);
55936779f496129 Dave Penkler 2024-09-18  1063  	if (irq < 0) {
55936779f496129 Dave Penkler 2024-09-18  1064  		dev_err(&fluke_gpib_pdev->dev, "fluke_gpib: request for IRQ failed\n");
55936779f496129 Dave Penkler 2024-09-18  1065  		return -EBUSY;
55936779f496129 Dave Penkler 2024-09-18  1066  	}
55936779f496129 Dave Penkler 2024-09-18  1067  	retval = request_irq(irq, fluke_gpib_interrupt, isr_flags, fluke_gpib_pdev->name, board);
55936779f496129 Dave Penkler 2024-09-18  1068  	if (retval) {
55936779f496129 Dave Penkler 2024-09-18  1069  		dev_err(&fluke_gpib_pdev->dev,
55936779f496129 Dave Penkler 2024-09-18  1070  			"cannot register interrupt handler err=%d\n",
55936779f496129 Dave Penkler 2024-09-18  1071  			retval);
55936779f496129 Dave Penkler 2024-09-18  1072  		return retval;
55936779f496129 Dave Penkler 2024-09-18  1073  	}
55936779f496129 Dave Penkler 2024-09-18  1074  	e_priv->irq = irq;
55936779f496129 Dave Penkler 2024-09-18  1075  
55936779f496129 Dave Penkler 2024-09-18  1076  	dma_cap_zero(dma_cap);
55936779f496129 Dave Penkler 2024-09-18  1077  	dma_cap_set(DMA_SLAVE, dma_cap);
55936779f496129 Dave Penkler 2024-09-18  1078  	e_priv->dma_channel = dma_request_channel(dma_cap, gpib_dma_channel_filter, NULL);
55936779f496129 Dave Penkler 2024-09-18  1079  	if (!e_priv->dma_channel) {
55936779f496129 Dave Penkler 2024-09-18  1080  		pr_err("fluke_gpib: failed to allocate a dma channel.\n");
55936779f496129 Dave Penkler 2024-09-18  1081  		// we don't error out here because unaccel interface will still
55936779f496129 Dave Penkler 2024-09-18  1082  		// work without dma
55936779f496129 Dave Penkler 2024-09-18  1083  	}
55936779f496129 Dave Penkler 2024-09-18  1084  
55936779f496129 Dave Penkler 2024-09-18  1085  	return fluke_init(e_priv, board, handshake_mode);
55936779f496129 Dave Penkler 2024-09-18  1086  }
55936779f496129 Dave Penkler 2024-09-18  1087  

:::::: The code at line 1013 was first introduced by commit
:::::: 55936779f4961299efa99a6843c8ff3b019d3858 staging: gpib: Add Fluke cda based cards GPIB driver

:::::: TO: Dave Penkler <dpenkler@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

