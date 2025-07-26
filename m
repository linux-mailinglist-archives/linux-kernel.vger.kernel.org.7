Return-Path: <linux-kernel+bounces-746718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C6FB12A60
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B107AA404
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45978242D88;
	Sat, 26 Jul 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tm6R095j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F91F0E29
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753531597; cv=none; b=BbNHN/exEHuOe8dmY76swlv1lMUTqmmkSIkb9KWyFYLJaOcDPaRfMZvu6U3VgjmR2qqahTNQZXUcV41+zgGO6l/ubSZMCnbVXv7rdEpbwTfyJsvX9w+8pLsOFnYsRXb1MPQU6t+8zKGeqRTc+5bVk3yPoxjuDBe7bmLcjrEYGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753531597; c=relaxed/simple;
	bh=W5q1u1HDfNCHS2WidOgSfhA8cypzt5eu3TwLmf5gUAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qmp+CrVEyalPAkP5dLFcgpq9VResSF+aQL0hHejoBba94eIOEm3GWdtn636z0+wZG1yGQJc0BcGgUv2A9sUkW67GEnpqZqewBADUODK2oKPGim5yPu7IZXub2aL/lRxQWNagAV5hE2zcbXP7KIMrS5pE5Pd4bMNuH6iaiS95CVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tm6R095j; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753531596; x=1785067596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W5q1u1HDfNCHS2WidOgSfhA8cypzt5eu3TwLmf5gUAw=;
  b=Tm6R095jfYlds0m34bPnFzJkj97WFV0HPXAYKsda7iD88Oaap95uu0D7
   BA9VGeqoEUyZx/eHXR0ClU+wXjDg38mCLHSCZ6oT3jiQ1VrvAlKwhZ57c
   44quqKYWImSNmhjvogqrlb2dy0cBKS3xdhgoYKdN1Ft5ilf6fas5PGgXY
   eYYwKSkMzTTIEsPPCx+pN9+bkpdzNRLm1yvhWZg+9Zl95ZaK8MAkXknyr
   PNf5jfNVpj5b/+urhvbPkGB6dXVJNF4V7vBHUsAJdW9n8X95y1CI2PQ4B
   cWE0ZJCrrAfvFd1xOulB7Rh0pFbyjAhiS+ocpN8AuJPU+7isX2jOd+sd8
   g==;
X-CSE-ConnectionGUID: UEDn5v6MTlC0win+Sqk0Ug==
X-CSE-MsgGUID: QxQOTIpPTHGA3t9TInA/zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="58468911"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="58468911"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 05:06:36 -0700
X-CSE-ConnectionGUID: 4XZJprYoS9iBYBJ2Ui5iTg==
X-CSE-MsgGUID: 4dBd82afRqasrfPq1cmnnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161669110"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by orviesa007.jf.intel.com with ESMTP; 26 Jul 2025 05:06:34 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufdfb-0000Id-1t;
	Sat, 26 Jul 2025 12:06:31 +0000
Date: Sat, 26 Jul 2025 14:06:13 +0200
From: kernel test robot <lkp@intel.com>
To: Shijith Thotton <sthotton@marvell.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Vamsi Attunuru <vattunuru@marvell.com>
Subject: drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive
 output may be truncated writing between 1 and 10 bytes into a region of size
 7
Message-ID: <202507261457.SXXHOjUk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f33ebd2018ced2600b3fad2f8e2052498eb4072
commit: e434e54d3ffcd17eeadfcf3cf434bc1dff36daff PCI: hotplug: Add OCTEON PCI hotplug controller driver
date:   9 months ago
config: powerpc-randconfig-2005-20250726 (https://download.01.org/0day-ci/archive/20250726/202507261457.SXXHOjUk-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261457.SXXHOjUk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261457.SXXHOjUk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/hotplug/octep_hp.c: In function 'octep_hp_pci_probe':
>> drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 7 [-Wformat-truncation=]
     snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
                                                        ^~
   drivers/pci/hotplug/octep_hp.c:312:43: note: directive argument in the range [0, 2147483646]
     snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
                                              ^~~~~~~~~~~~~
   drivers/pci/hotplug/octep_hp.c:312:2: note: 'snprintf' output between 11 and 20 bytes into a destination of size 16
     snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +312 drivers/pci/hotplug/octep_hp.c

   297	
   298	static int octep_hp_request_irq(struct octep_hp_controller *hp_ctrl,
   299					enum octep_hp_intr_type type)
   300	{
   301		struct pci_dev *pdev = hp_ctrl->pdev;
   302		struct octep_hp_intr_info *intr;
   303		int irq;
   304	
   305		irq = pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(type));
   306		if (irq < 0)
   307			return irq;
   308	
   309		intr = &hp_ctrl->intr[type];
   310		intr->number = irq;
   311		intr->type = type;
 > 312		snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
   313	
   314		return devm_request_irq(&pdev->dev, irq, octep_hp_intr_handler,
   315					IRQF_SHARED, intr->name, hp_ctrl);
   316	}
   317	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

