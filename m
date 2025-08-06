Return-Path: <linux-kernel+bounces-757847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A558B1C75F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EDF56293E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197528CF40;
	Wed,  6 Aug 2025 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F23ezB30"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D81C8633
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489335; cv=none; b=G27n8p70GCkZuqZAQ5r8mIYfaLsnYiPUcFzYyX0XSxg+qhfROKqhuLqFmWPMuPxGA12dTkzoJ+eIwECdHgM4aUMFKitlcpCiIsD4pz7JQ5n1mzv9pjFquqqiVKoAqo2pTA6TGZAI9n6YAGjEFx55A+Oufz7/t7uYLtAxBP6jvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489335; c=relaxed/simple;
	bh=1cMKK2wzDn7b1YoWly6nrrbQX+BYhS328kQ/8gB4DmU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZHCthqFPeyndF3p+enb3Z45+daCk1WJkRslBTuCjyUIh9extDZQzlt9Ou112bODgYJf1t2+tf1CCpWEnf20ursUJXyNZn8Xbs+kvtVs0jC2aL0mxTa88MwZMp3g0FGI3bHo7gQK6TKQM/ukhRwqqvioikdism7qCdonja5wIklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F23ezB30; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754489334; x=1786025334;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1cMKK2wzDn7b1YoWly6nrrbQX+BYhS328kQ/8gB4DmU=;
  b=F23ezB30UotpGMBJqxaLBSts/gHUadFtIghPA8bslPY+A9T7phms36Qm
   x4zJFoU4BWieZcXmkHw4kVvwQVNAEpKs64GNi/t8ZOqriW4Bo4nbZsOPp
   c7tlk1ubKIUF8NBmY3r8A9WkYCoIiGJT8BqvXBct7iFfrgCRXqGN167ax
   AXe6xmA2F3rWlPQT1aEZFWXYVfDJqCfoR7oaR+tpK97WUs2hjJv5uh3tM
   E8UxRN3hcJ0GTp2fouof3tHEjJVbVV3wfJ4KFWSFf9zQ8Bhn94y19T87M
   sebLEA6ok1V2I1QM2Yv6HjDzNiFgtpNBy5czObZUJs3isR8UDFnJIe+1O
   w==;
X-CSE-ConnectionGUID: YrBXNZGzRIao0jisPP5Sgg==
X-CSE-MsgGUID: cbAnFH0GSaOBooRf1Xx6iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56019952"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56019952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 07:08:54 -0700
X-CSE-ConnectionGUID: iJHZK1AgS1+zGBS+JasvnA==
X-CSE-MsgGUID: T+MCNb3pRuqplH3sDjcf/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="168957173"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2025 07:08:52 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujeob-0001kc-2w;
	Wed, 06 Aug 2025 14:08:48 +0000
Date: Wed, 6 Aug 2025 22:07:38 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Nachman <enachman@marvell.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:irq/urgent 3/7] drivers/irqchip/irq-mvebu-gicp.c:240:45-48:
 WARNING: Suspicious code. resource_size is maybe missing with gicp -> res
Message-ID: <202508062150.mtFQMTXc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
head:   3b6a18f0da8720d612d8a682ea5c55870da068e0
commit: 3c3d7dbab2c70a4bca47634d564bf659351c05ca [3/7] irqchip/mvebu-gicp: Clear pending interrupts on init
config: arm64-randconfig-r052-20250806 (https://download.01.org/0day-ci/archive/20250806/202508062150.mtFQMTXc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508062150.mtFQMTXc-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-mvebu-gicp.c:240:45-48: WARNING: Suspicious code. resource_size is maybe missing with gicp -> res

vim +240 drivers/irqchip/irq-mvebu-gicp.c

   170	
   171	static int mvebu_gicp_probe(struct platform_device *pdev)
   172	{
   173		struct device_node *node = pdev->dev.of_node;
   174		struct device_node *irq_parent_dn;
   175		struct irq_domain_info info = {
   176			.fwnode	= of_fwnode_handle(node),
   177			.ops	= &gicp_domain_ops,
   178		};
   179		struct mvebu_gicp *gicp;
   180		void __iomem *base;
   181		int ret, i;
   182	
   183		gicp = devm_kzalloc(&pdev->dev, sizeof(*gicp), GFP_KERNEL);
   184		if (!gicp)
   185			return -ENOMEM;
   186	
   187		gicp->dev = &pdev->dev;
   188		spin_lock_init(&gicp->spi_lock);
   189	
   190		gicp->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   191		if (!gicp->res)
   192			return -ENODEV;
   193	
   194		ret = of_property_count_u32_elems(node, "marvell,spi-ranges");
   195		if (ret < 0)
   196			return ret;
   197	
   198		gicp->spi_ranges_cnt = ret / 2;
   199	
   200		gicp->spi_ranges =
   201			devm_kcalloc(&pdev->dev,
   202				     gicp->spi_ranges_cnt,
   203				     sizeof(struct mvebu_gicp_spi_range),
   204				     GFP_KERNEL);
   205		if (!gicp->spi_ranges)
   206			return -ENOMEM;
   207	
   208		for (i = 0; i < gicp->spi_ranges_cnt; i++) {
   209			of_property_read_u32_index(node, "marvell,spi-ranges",
   210						   i * 2,
   211						   &gicp->spi_ranges[i].start);
   212	
   213			of_property_read_u32_index(node, "marvell,spi-ranges",
   214						   i * 2 + 1,
   215						   &gicp->spi_ranges[i].count);
   216	
   217			gicp->spi_cnt += gicp->spi_ranges[i].count;
   218		}
   219	
   220		gicp->spi_bitmap = devm_bitmap_zalloc(&pdev->dev, gicp->spi_cnt, GFP_KERNEL);
   221		if (!gicp->spi_bitmap)
   222			return -ENOMEM;
   223	
   224		info.size = gicp->spi_cnt;
   225		info.host_data = gicp;
   226	
   227		irq_parent_dn = of_irq_find_parent(node);
   228		if (!irq_parent_dn) {
   229			dev_err(&pdev->dev, "failed to find parent IRQ node\n");
   230			return -ENODEV;
   231		}
   232	
   233		info.parent = irq_find_host(irq_parent_dn);
   234		of_node_put(irq_parent_dn);
   235		if (!info.parent) {
   236			dev_err(&pdev->dev, "failed to find parent IRQ domain\n");
   237			return -ENODEV;
   238		}
   239	
 > 240		base = ioremap(gicp->res->start, gicp->res->end - gicp->res->start);
   241		if (IS_ERR(base)) {
   242			dev_err(&pdev->dev, "ioremap() failed. Unable to clear pending interrupts.\n");
   243		} else {
   244			for (i = 0; i < 64; i++)
   245				writel(i, base + GICP_CLRSPI_NSR_OFFSET);
   246			iounmap(base);
   247		}
   248	
   249		return msi_create_parent_irq_domain(&info, &gicp_msi_parent_ops) ? 0 : -ENOMEM;
   250	}
   251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

