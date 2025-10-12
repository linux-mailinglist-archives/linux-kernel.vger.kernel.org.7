Return-Path: <linux-kernel+bounces-849407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A34BD00C0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 11:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C53189422F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50725C80E;
	Sun, 12 Oct 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEEBDWky"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD6233721
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760261996; cv=none; b=utSvIWksZ/fnFYhi6qQc48fqlz/DfomK+C+SZc/c4r5IA2y/9P3gYFcNsPgKaT5YZ4ofV8POqdweLFVpPlOOfBMNJ2CzAgNs4Jao1dDqias5xbBlRHdnKcNQKyskObvCNp0mUomp71V2bCVo2qYN8G1lgtSLLfxMdlHjE/P34/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760261996; c=relaxed/simple;
	bh=i8aemhS/vZH8wM/8GZe+Q6SGLttvr8nwrhc3A80kDMY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qXPKbWC7S1Squklv66HM+9+kDcDjBFSbzAGQtDR0GruCfa9jg87mTysSzpC2zFw72sGYRxQX2au/dAzIXVxM/BdLsXtEe6JRzDec25ZQKoXW1oCX2l7PoMDA7WLQu1PED1+CGyFQkJt4kMjEHjpyU52LZUzMfNOLMG+NG9l5aJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEEBDWky; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760261994; x=1791797994;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i8aemhS/vZH8wM/8GZe+Q6SGLttvr8nwrhc3A80kDMY=;
  b=BEEBDWkyS2c2iBMtBuS+rBvK4t9FJ3xVtv5aKWrcf09lr+r4rpy2QAKB
   z/okcekATuVUOBE9rBM9f1LgCK8eVmKx51Tqh7FSnVCv7ImOnvmgUS7QO
   Nk417CiD71kX2F8fVgT+MuZl0bYUJ6CUH7uk9CtadMv5mDmsZ4vNOBZ6F
   lSRihNDD0CqGIpZuDLy9Np/RLJYUoI8y3xpyazGEsJK62J9gMh4xaEont
   2M4WQkguDIlTegT6NobFOuiWsezNZtWFarYLcYVaqdlh2/TR4bWudTA/k
   Cm75Ey3vAN+63sPN0exGok0+mqyLy7J3kOIajErdFERQl0mKg9De8X+TR
   g==;
X-CSE-ConnectionGUID: VJlRg+aNRIKSJj+NLB75bw==
X-CSE-MsgGUID: gMNHDFECRGCb0KowaAjr+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11579"; a="62454711"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; 
   d="scan'208";a="62454711"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2025 02:39:54 -0700
X-CSE-ConnectionGUID: W5Pv/dysS9WjMY5i9BOJog==
X-CSE-MsgGUID: 3AdvyM79RPKZ5cMvre6X1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; 
   d="scan'208";a="180594273"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Oct 2025 02:39:52 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7sYP-0004JB-0E;
	Sun, 12 Oct 2025 09:39:49 +0000
Date: Sun, 12 Oct 2025 17:39:00 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Davis <afd@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: include/linux/platform_device.h:91:23: sparse: sparse: incorrect
 type in return expression (different address spaces)
Message-ID: <202510121751.7zwNEW58-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   67029a49db6c1f21106a1b5fcdd0ea234a6e0711
commit: 61de83fd8256e185588670d3cf0bccc3e913819c mux: mmio: Do not use syscon helper to build regmap
date:   5 months ago
config: s390-randconfig-r123-20251012 (https://download.01.org/0day-ci/archive/20251012/202510121751.7zwNEW58-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251012/202510121751.7zwNEW58-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510121751.7zwNEW58-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mux/mmio.c: note: in included file:
>> include/linux/platform_device.h:91:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/platform_device.h:91:23: sparse:     expected void [noderef] __iomem *
   include/linux/platform_device.h:91:23: sparse:     got void *

vim +91 include/linux/platform_device.h

a0c74f6c9ea9ce Mark Brown 2023-07-18  85  
a0c74f6c9ea9ce Mark Brown 2023-07-18  86  
a0c74f6c9ea9ce Mark Brown 2023-07-18  87  static inline void __iomem *
a0c74f6c9ea9ce Mark Brown 2023-07-18  88  devm_platform_ioremap_resource(struct platform_device *pdev,
a0c74f6c9ea9ce Mark Brown 2023-07-18  89  			       unsigned int index)
a0c74f6c9ea9ce Mark Brown 2023-07-18  90  {
a0c74f6c9ea9ce Mark Brown 2023-07-18 @91  	return ERR_PTR(-EINVAL);
a0c74f6c9ea9ce Mark Brown 2023-07-18  92  }
a0c74f6c9ea9ce Mark Brown 2023-07-18  93  

:::::: The code at line 91 was first introduced by commit
:::::: a0c74f6c9ea9cebd7a8f38142bf87e7c12c2905d platform: Provide stubs for !HAS_IOMEM builds

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

