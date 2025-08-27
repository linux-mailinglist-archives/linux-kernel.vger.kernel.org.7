Return-Path: <linux-kernel+bounces-787633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFF8B378EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CC51BA0919
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B332C8B;
	Wed, 27 Aug 2025 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPb0iRiI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C062AE97
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756267283; cv=none; b=kfCx0/DAnnU6obDcp9fnJkQoTjHA3co6xTpWHERAoLK9KMnCMrUH4TFvDdmW7Ja81zNba9+QoyUq+1qxh23TiQaPTTN7oVawzDpNqfhbnSomE4dJ9m59Bbe1hGQpNtFAcExzV8CNbRY7Yd+99lcGtGPVrZIt9jktl3SVjIsL0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756267283; c=relaxed/simple;
	bh=Qov0BvcI4DyP4npyqP1WqdUjfAFciHdLbtvRNP3Y/Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MWxCdHfMAVW9gtIvR/+GUbgOJeIDUfvGAKpqdMPeFTURsxnxxdMobgP2E+Sff4WGP4TQsjiCX6huISM9XO0KrpPePW+62aWmDw9YWYNMVqWkFz7Vl0m+uEZIDfyLSkV2SLZHj6Qc43nlcry0rYnNgvLyB9qejpdv6EA9/k0+eoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPb0iRiI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756267280; x=1787803280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qov0BvcI4DyP4npyqP1WqdUjfAFciHdLbtvRNP3Y/Vc=;
  b=lPb0iRiIQFFdJBD30c5HNDqejJjes/qp6gY9TahHSNX5jNlWJwTBVPbx
   wSgpXkNDkm4bRNEEV390vumbYIYNCnfjfjH6+YiWhkMykh9Ig0a24hxGa
   pbcPVmabF5QKZo4aEPxi9wQ/fAQMXXoE4OKeN49jGXzLBiHRpZrjkr++w
   KPtVWZznEUmptiRrPtPyZ826zqVPlKVFkutFltGcRQ2vGjnWEJ+3TBT6W
   XjyIDlbWR1Is0V4CtUS4NsistaXV8/LFSdApr4OBlXOYcUS2mS/dcQ0Qu
   N5Jt08/TNpPe4ors4ZcyvQhmZZT15sgC0k5aVEUkdCPTY2skcF97aq6CR
   A==;
X-CSE-ConnectionGUID: kT5RQIXlSPifzm5DIc4sBQ==
X-CSE-MsgGUID: +ljkx80fT+KdIOV0Sn2pjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58572824"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58572824"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 21:01:19 -0700
X-CSE-ConnectionGUID: YenJ5FQmQES9dk5GM/oMuQ==
X-CSE-MsgGUID: 6UMwAC/xQSym7nO+t5hRyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173908179"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 21:01:18 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ur7LL-000SeT-2I;
	Wed, 27 Aug 2025 04:01:16 +0000
Date: Wed, 27 Aug 2025 11:59:17 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: tc358746.c:(.text.tc358746_probe+0x396): undefined reference to
 `devm_clk_hw_register'
Message-ID: <202508271114.ir9GuNN0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fab1beda7597fac1cecc01707d55eadb6bbe773c
commit: 4fbdd56edf1f0b3e338c90a011bbae1a677ac884 m68k: Enable dead code elimination
date:   7 weeks ago
config: m68k-randconfig-r131-20250827 (https://download.01.org/0day-ci/archive/20250827/202508271114.ir9GuNN0-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250827/202508271114.ir9GuNN0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508271114.ir9GuNN0-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/media/i2c/tc358746.o: in function `tc358746_probe':
>> tc358746.c:(.text.tc358746_probe+0x396): undefined reference to `devm_clk_hw_register'
>> m68k-linux-ld: tc358746.c:(.text.tc358746_probe+0x3aa): undefined reference to `of_clk_hw_simple_get'
>> m68k-linux-ld: tc358746.c:(.text.tc358746_probe+0x3b2): undefined reference to `devm_of_clk_add_hw_provider'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

