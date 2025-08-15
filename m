Return-Path: <linux-kernel+bounces-771498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B71B287FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A31726015
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A529C1B87C0;
	Fri, 15 Aug 2025 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agBVXIn3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E7221FDC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294639; cv=none; b=W8Hz3ZoY9HP7XJDF/3vJCpYaQ8WMgMsEe/rGiG05MvQGwVZ2R/qM+GiyOKzNYy6/a9Id2aJyPnA4K3EDpaU6HVrXFv783iRLOm3FKLQp1e7vNeIW2RQKfA4p2iZJW2PyA1ORvJZf9Ct7izec4EDFgMD5pAnQhg4Yr/ymtVBVgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294639; c=relaxed/simple;
	bh=FX31Dr4raEflRkKyJdaMBZxQojI+0lLRSkT9HNPz+84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nLCx74Fd/nBiEaoyp6G9yql5KAwIuEOrcYfH3id6/itxObeAYKrViJdIxk+lMWFQdXZzNwSk2PJL9AmJ4UT7sb+WF7083Sy1TVsVGWDlHgCZWXTtSbT/jFIzm8QlZurVYlBj4JeX/jwbBFNczGZIOZ6SpYQjN+57Jiq5/ctiPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agBVXIn3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755294638; x=1786830638;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FX31Dr4raEflRkKyJdaMBZxQojI+0lLRSkT9HNPz+84=;
  b=agBVXIn3ibj+z/rWlke7EyRsKPh09eMVPxoQxJfB6Rb6AjP3YnlvzAyF
   eLRBEGtAxOS55QXSpJ5IqNcAKIvwxzO08VmaU/isN9cBiupV9Z/uF4R0R
   4QiyKmj03Ibpq3z4cyQ1j6sRL3+ZatbisR3noeZ6WJZZLK7IbUi8q3O+G
   lWFIUZBePf43x7UaRJTyC+/IUaXgFZUodLjKOXfTXzb6Ho4OEizy7d3KP
   JTxs3D22TxueVHJkMPTpzLch3JQ+FOuX+37F81I+LMKJR21mrQAfyaEXV
   Kb/NMuP8QCypiVIaEh8N71dG1tVkdhFj/ncECDATHi3045t8INTqmBoXz
   g==;
X-CSE-ConnectionGUID: vVnECe34RXu2GVPmcOKCAg==
X-CSE-MsgGUID: sFN0REDbSd+T5/hrH3pXMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68708488"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68708488"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:50:38 -0700
X-CSE-ConnectionGUID: kw0e7wfFQlOJjfunyDBo6w==
X-CSE-MsgGUID: ouj59SOhQemMmR6Nwkesbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167914046"
Received: from igk-lkp-server01.igk.intel.com (HELO ca260db0ef79) ([10.91.175.65])
  by fmviesa010.fm.intel.com with ESMTP; 15 Aug 2025 14:50:36 -0700
Received: from kbuild by ca260db0ef79 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un2Jl-0000aF-2b;
	Fri, 15 Aug 2025 21:50:33 +0000
Date: Fri, 15 Aug 2025 23:50:14 +0200
From: kernel test robot <lkp@intel.com>
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	Timothy Hayes <timothy.hayes@arm.com>
Subject: arch/arm64/kvm/vgic/vgic-mmio.c:1094:3: warning: variable 'len' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202508152354.FWDol8gs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d0efc9e4276cda07c2f76652d240b165c30b05b8
commit: c017e49ed1381001ba7a6521daae8f968b11cf09 KVM: arm64: gic-v5: Support GICv3 compat
date:   5 weeks ago
config: arm64-randconfig-2002-20250814 (https://download.01.org/0day-ci/archive/20250815/202508152354.FWDol8gs-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7d886fab74d4037d654d02bed24dd97c0ba863d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508152354.FWDol8gs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508152354.FWDol8gs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/vgic/vgic-mmio.c:1094:3: warning: variable 'len' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1094 |                 BUG_ON(1);
         |                 ^~~~~~~~~
   include/asm-generic/bug.h:71:36: note: expanded from macro 'BUG_ON'
      71 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                    ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:47:23: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/vgic/vgic-mmio.c:1102:12: note: uninitialized use occurs here
    1102 |                                        len, &io_device->dev);
         |                                        ^~~
   arch/arm64/kvm/vgic/vgic-mmio.c:1094:3: note: remove the 'if' if its condition is always true
    1094 |                 BUG_ON(1);
         |                 ^
   include/asm-generic/bug.h:71:32: note: expanded from macro 'BUG_ON'
      71 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                ^
   arch/arm64/kvm/vgic/vgic-mmio.c:1084:18: note: initialize the variable 'len' to silence this warning
    1084 |         unsigned int len;
         |                         ^
         |                          = 0
   1 warning generated.


vim +1094 arch/arm64/kvm/vgic/vgic-mmio.c

fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1079  
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1080  int vgic_register_dist_iodev(struct kvm *kvm, gpa_t dist_base_address,
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1081  			     enum vgic_type type)
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1082  {
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1083  	struct vgic_io_device *io_device = &kvm->arch.vgic.dist_iodev;
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1084  	unsigned int len;
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1085  
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1086  	switch (type) {
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1087  	case VGIC_V2:
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1088  		len = vgic_v2_init_dist_iodev(io_device);
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1089  		break;
ed9b8cefa91695 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2015-12-01  1090  	case VGIC_V3:
ed9b8cefa91695 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2015-12-01  1091  		len = vgic_v3_init_dist_iodev(io_device);
ed9b8cefa91695 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2015-12-01  1092  		break;
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26  1093  	default:
fb848db39661a1 virt/kvm/arm/vgic/vgic-mmio.c Andre Przywara 2016-04-26 @1094  		BUG_ON(1);

:::::: The code at line 1094 was first introduced by commit
:::::: fb848db39661a1243f6ae939ef7e9251a765b972 KVM: arm/arm64: vgic-new: Add GICv2 MMIO handling framework

:::::: TO: Andre Przywara <andre.przywara@arm.com>
:::::: CC: Christoffer Dall <christoffer.dall@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

