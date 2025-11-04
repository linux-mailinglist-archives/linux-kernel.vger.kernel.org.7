Return-Path: <linux-kernel+bounces-883866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D05C2E984
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA62189B9FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC581FE45D;
	Tue,  4 Nov 2025 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vssg/Yqm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2F1A5B9D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216000; cv=none; b=OARp66MtM31C4lHthypLtFIMFzak9rpJLgDa0ObC8ZLjJq99jJQoLFyXy34bOEQGbOpor/7s1e7fVk+p8X6+R4h5FxkXHLM9y4ZECA57QRRhZyENjDNcv22iTAYdnsujoc7IrSiXxE0I4xYi3MYAl7PHEaN/enuPSxJVlQFpiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216000; c=relaxed/simple;
	bh=7VtOk+l1KzIkcjDpEzysoP/mmq8ICfm3pYZZI/Z8TME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ezC5NH698y0WiXb72zrlHfqKwYzQLMURyeWidW7yG3JeWxdTxGp7sphgyhoKGZlazf4AwISwVCA2lVgxkirxKDAdDtWZxiAZ1qHIE8h1Orn4z0w2kCe4OMU31/lBjPntj96lPyUvO457GfJWDLawIlhcbmToYuhNEwBlDEKGNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vssg/Yqm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762216000; x=1793752000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7VtOk+l1KzIkcjDpEzysoP/mmq8ICfm3pYZZI/Z8TME=;
  b=Vssg/Yqm09Qm4u4htZd2D5irbwHPUfjvzkyiQfLE2dCpPaPGsayK2s+/
   0GpG52+zBKPqq842XVOKmjktrlYfmg60ximpoR5+bjTW8c9aEmJ7bY4Hj
   mqBMsiG7KT1KDLdTMN/jiThytPbma7cW44uDeai3pIFm/W0pr7HJLhACa
   p8JhF6la+7yahURzcH7B6NiR59vRgnuYrPwtLo4oW5gFi0XnmTE4vkPtY
   AK36rAcD+b77dXk8fzH+EGmj4+5F2b2ulhdtZWyZVB5gUDv/AZ3GDoSBI
   cCz43ufHlLeyEncpTf1n9mpPsBx06u/yqk8thZtGJkmkVjnVe5rEilaWO
   A==;
X-CSE-ConnectionGUID: 9mutXz4LT2Gz7KLbAkV4kQ==
X-CSE-MsgGUID: Nodfy+u7RgqwhWObtMlf7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64334988"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64334988"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 16:26:39 -0800
X-CSE-ConnectionGUID: HfaZHcmsSWSgRXBfmuDsvQ==
X-CSE-MsgGUID: mH87W9X/S12M7jS/NoNFQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="191323219"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2025 16:26:37 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vG4sX-000QfT-2f;
	Tue, 04 Nov 2025 00:26:31 +0000
Date: Tue, 4 Nov 2025 08:25:43 +0800
From: kernel test robot <lkp@intel.com>
To: Varad Gautam <varadgautam@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against
 symbol 'abatron_pteptrs'; recompile with -fPIC
Message-ID: <202511040818.lT806PAp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6146a0f1dfae5d37442a9ddcba012add260bceb0
commit: 8327bd4fcb6c1dab01ce5c6ff00b42496836dcd2 asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
date:   6 weeks ago
config: powerpc-randconfig-r123-20251103 (https://download.01.org/0day-ci/archive/20251104/202511040818.lT806PAp-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511040818.lT806PAp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511040818.lT806PAp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'abatron_pteptrs'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/mm/nohash/mmu_context.o)
   >>> referenced by head_44x.S:212 (arch/powerpc/kernel/head_44x.S:212)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0xbe) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'abatron_pteptrs'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/mm/nohash/mmu_context.o)
   >>> referenced by head_44x.S:213 (arch/powerpc/kernel/head_44x.S:213)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0xc2) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'start_kernel'; recompile with -fPIC
   >>> defined in vmlinux.a(init/main.o)
   >>> referenced by head_44x.S:224 (arch/powerpc/kernel/head_44x.S:224)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0xde) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'start_kernel'; recompile with -fPIC
   >>> defined in vmlinux.a(init/main.o)
   >>> referenced by head_44x.S:225 (arch/powerpc/kernel/head_44x.S:225)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0xe2) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_HA cannot be used against symbol 'critirq_ctx'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/kernel/irq.o)
   >>> referenced by head_44x.S:251 (arch/powerpc/kernel/head_44x.S:251)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x106) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'critirq_ctx'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/kernel/irq.o)
   >>> referenced by head_44x.S:251 (arch/powerpc/kernel/head_44x.S:251)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x10a) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_HA cannot be used against symbol 'critirq_ctx'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/kernel/irq.o)
   >>> referenced by head_44x.S:254 (arch/powerpc/kernel/head_44x.S:254)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x286) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'critirq_ctx'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/kernel/irq.o)
   >>> referenced by head_44x.S:254 (arch/powerpc/kernel/head_44x.S:254)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x28a) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_HA cannot be used against symbol 'mcheckirq_ctx'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/kernel/irq.o)
   >>> referenced by head_44x.S:256 (arch/powerpc/kernel/head_44x.S:256)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x406) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'mcheckirq_ctx'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/kernel/irq.o)
   >>> referenced by head_44x.S:256 (arch/powerpc/kernel/head_44x.S:256)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x40a) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'init_thread_union'; recompile with -fPIC
   >>> defined in ./arch/powerpc/kernel/vmlinux.lds:134
   >>> referenced by head_44x.S:109 (arch/powerpc/kernel/head_44x.S:109)
   >>>               arch/powerpc/kernel/head_44x.o:(.head.text+0x52) in archive vmlinux.a
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

