Return-Path: <linux-kernel+bounces-803663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B26FB4637A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6883A19FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0318221577;
	Fri,  5 Sep 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USO7Fry3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86191DE89A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099996; cv=none; b=MYwqrneiaGFZvvR6r07N1OVes7YuAJVj83k8KecDToqCTOBBL8/jjXEVVCFRF8buCk/NP8HJbFB+NYd5bRmWh3tXsjQvT9k7jqr961AMx2jtuIUMM1wHxhg6anybLiKiXmB2CA2kvlcNRq/xtnRuVMCWbmDWA5QzyQS8NKLQa1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099996; c=relaxed/simple;
	bh=WZ7KN6JxkM6YxgjCtFBV2bQ13884JgSCXhaiGZwhAuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dGC1+EqRNqNwVBraxLV4mleA+vP9fox2yH3W+xJNGuqp9PnTUgXO8cHa/tr/p8l3/bFrKYMSbqg3lcM6gSbzP5Wxjo2kc4jPoksDbnZjBo+rojvkr5iXCVl9N9fdjLHGKteB9c2/lGrC55SNnl9Bj5n4yy2hEr7ynauyIvSqXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USO7Fry3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757099995; x=1788635995;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WZ7KN6JxkM6YxgjCtFBV2bQ13884JgSCXhaiGZwhAuc=;
  b=USO7Fry3RRnoNfOdfa9iGPXG1vr0Yc5V8WG1Ggg7bVNntX5uZcu243Rw
   JGzZcxTjRKEMTJrD7T9Z/VQ42LY/jLfcq1PCXH8ulvLHplwOVt4cYi3Dm
   GbLxf+tmMFV0arwB4aMBa7tUW+3X4w6lmMS+rYNLa2ACofsbSgKrJ3J/7
   UKA+pt+tr+ENuoN+FhKsG228zGRH0DMWZUhvqWcgWRyRYWxYFnsxzLYaF
   vFfuPLvLLt2pqUq9OSkNvYl+GJYJGymVOGtxDk1TbrSN2o5BsHv5hdd8M
   ZYWOZZYp3usMFHWTAq3y1WQa5x9QD4tin5ouRT4Vb6xvtLW2sDinraVY9
   A==;
X-CSE-ConnectionGUID: 5ohhURbXRJyDork1ik6ovw==
X-CSE-MsgGUID: RA5OhtCDTMupJZkiI0K+9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="63097112"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="63097112"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 12:19:54 -0700
X-CSE-ConnectionGUID: JDHf6294RkWpYOVQn9lexQ==
X-CSE-MsgGUID: Io1SUpwnSoqX0nsQ2I9ejg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="176572956"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Sep 2025 12:19:53 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uubyP-0000kv-2p;
	Fri, 05 Sep 2025 19:19:49 +0000
Date: Sat, 6 Sep 2025 03:19:36 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/platform_device.h:91:23: sparse: sparse: incorrect
 type in return expression (different address spaces)
Message-ID: <202509060307.JubgnLhc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c8ed9b5c02a5ceb3d8244f3862a7e64cf0b5648e
commit: 9fe58ecd1ed8162a96447fe6fbcbfb2f74be0b54 mux: mmio: Fix missing CONFIG_REGMAP_MMIO
date:   9 weeks ago
config: um-randconfig-r132-20250905 (https://download.01.org/0day-ci/archive/20250906/202509060307.JubgnLhc-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509060307.JubgnLhc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509060307.JubgnLhc-lkp@intel.com/

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

