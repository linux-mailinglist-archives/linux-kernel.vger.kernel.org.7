Return-Path: <linux-kernel+bounces-752530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D9B176B4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E138817FA39
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08272451C3;
	Thu, 31 Jul 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp2SSyCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6F23ED63;
	Thu, 31 Jul 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990608; cv=none; b=p/7pETTcFuJe0znSy57XRJLwAUTdBaek9iRcauAgsLNZYAx2ktE7nXMwYzYx35uPu4wQEnZL+TZElkccXleIXP9ut+JkrqlQEYDBA8A6jYhpQl7EY2PZ/Nzf7taQKMpZK4A7bLCm5xzZEeEazTXjyu5PLGosF0ZU7Nq836nzMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990608; c=relaxed/simple;
	bh=Wh3NN3AHHeAFEglBM+R48Xyj+T/EYGY/Cd48O7il8fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfnWxS+cLTx/hURHNIbTyH98rDBzd+Kr6mrTcS7s8s2WaJA9ENmW7MQYl+PqgwCZAKkRJbzp0Q9iL4PzWBgkxHiQY45EGYHPkcg9BAtB4O0WlMh2JDv05sfSLvxzAME7ceXk+hwhZu+PhEq4lb6rbtCxUdZoWZptQqmAvDtdayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp2SSyCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A95FC4CEEF;
	Thu, 31 Jul 2025 19:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753990607;
	bh=Wh3NN3AHHeAFEglBM+R48Xyj+T/EYGY/Cd48O7il8fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wp2SSyCCpyaZkAiHzElHviS55+JLxueogBfIasz9sDHQ/+hb0Tu1N3oBOFbRFNBhO
	 ZEHSq+zGiVImQPC9tSW4n+zFW6FeRFG2uNHlDB6F/25dxljT8rUK7pNyipuovyIyo4
	 5OuZY/ayG00wT/VxCtXWMaJBIvlOtS3DJF12v63zGaV7qTfuhawDNGS6RD76pJo3FO
	 E/W+b19/8VbepkZZlQHELIM/flQnOKfHYoPYUrw/mZG66qcc+zG8WC7mOIk/suk4ch
	 5NnPNvZ1nwlHPRmHmt8NKuOEI7Tis/y/3yGX4W2yDJPafm2GPRY4xQhUjinv7OQ/oz
	 JyZa4QORvNiwQ==
Date: Thu, 31 Jul 2025 21:36:43 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Subject: Re: drivers/irqchip/irq-gic-v5-iwb.c:265:1-8: WARNING: invalid free
 of devm_ allocated data
Message-ID: <aIvFy3eGJ5RXj5T4@lpieralisi>
References: <202508010038.N3r4ZmII-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508010038.N3r4ZmII-lkp@intel.com>

On Fri, Aug 01, 2025 at 12:20:00AM +0800, kernel test robot wrote:
> Hi Lorenzo,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   260f6f4fda93c8485c8037865c941b42b9cba5d2
> commit: 53bb952a625fd3247647c7a28366ce990a579415 arm64: Kconfig: Enable GICv5
> date:   3 weeks ago
> config: arm64-randconfig-r052-20250731 (https://download.01.org/0day-ci/archive/20250801/202508010038.N3r4ZmII-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 8f09b03aebb71c154f3bbe725c29e3f47d37c26e)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508010038.N3r4ZmII-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> drivers/irqchip/irq-gic-v5-iwb.c:265:1-8: WARNING: invalid free of devm_ allocated data
> 
> vim +265 drivers/irqchip/irq-gic-v5-iwb.c

Weird this has not been caught before but it is a trivial
fix (a leftover from early patch versions where the IWB was
not probed as a device), will send it tomorrow.

Thanks,
Lorenzo

> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  238  
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  239  static int gicv5_iwb_device_probe(struct platform_device *pdev)
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  240  {
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  241  	struct gicv5_iwb_chip_data *iwb_node;
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  242  	void __iomem *iwb_base;
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  243  	struct resource *res;
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  244  	int ret;
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  245  
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  246  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  247  	if (!res)
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  248  		return -EINVAL;
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  249  
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  250  	iwb_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  251  	if (!iwb_base) {
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  252  		dev_err(&pdev->dev, "failed to ioremap %pR\n", res);
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  253  		return -ENOMEM;
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  254  	}
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  255  
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  256  	iwb_node = gicv5_iwb_init_bases(iwb_base, pdev);
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  257  	if (IS_ERR(iwb_node)) {
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  258  		ret = PTR_ERR(iwb_node);
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  259  		goto out_unmap;
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  260  	}
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  261  
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  262  	return 0;
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  263  
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  264  out_unmap:
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03 @265  	iounmap(iwb_base);
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  266  	return ret;
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  267  }
> 695949d8b16f11 Lorenzo Pieralisi 2025-07-03  268  
> 
> :::::: The code at line 265 was first introduced by commit
> :::::: 695949d8b16f11f2f172d8d0c7ccc1ae09ed6cb7 irqchip/gic-v5: Add GICv5 IWB support
> 
> :::::: TO: Lorenzo Pieralisi <lpieralisi@kernel.org>
> :::::: CC: Marc Zyngier <maz@kernel.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

