Return-Path: <linux-kernel+bounces-754197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C955B18F9F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 20:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C528DAA0F84
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A0244667;
	Sat,  2 Aug 2025 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+vv9EZU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31601607AB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754157761; cv=none; b=mK4jySXqBsEdIqDcG8nxjaj42KqW37x+NgCoZxioVxsqnAxOfVoJhhyqx6diRJRTCfOXhDARCL/ruXZDHkBK3e4DBR+x2qRh7lDJGF7289gcvCn2CeHUy779jt86do482QNTNJNVO5QZk0AQ5ZH0V11UR+f1M1nqnot159tg+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754157761; c=relaxed/simple;
	bh=e5OINYOU2hue+fHdAAD3u5bu9jVNqzXHkm+sPnH8IZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RFgN4o7WE3+iD4jMA8Svcw4DBZkoO0ix/BzDCMhtKG3QL1xUmOWapmkP+2Kl416vx3XymCsuOqLPcHSzxsehe8Nv+dIi0nl//lGgAqcYm5BFeB/JTRHtMbzbYmZmXqIbh0PFSmko4+h35vKX8S0yrnE3yw6eKHeybIsGAL3ZE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+vv9EZU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754157760; x=1785693760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e5OINYOU2hue+fHdAAD3u5bu9jVNqzXHkm+sPnH8IZ0=;
  b=J+vv9EZUCepSlMplyIGbBATYFx8kx9Wd2jwc+PaWCdGOG2M3sC586/QN
   u2Vv7SpP3ikgWImNAz5D4vrXg+g1h+igpyuakguYGEQSxykGijiJzsiAE
   UcaYCpuEcWWScUyrssl0BQVGTjjEZJk1eP6+y2EzqoTXoV7B3qPIYuJRp
   FwPdOIKljlE+/YIXtIzd42ojHfdPmN5+R7C+jLIoSGomYgKYPD4hNYFkS
   7nIYnodVOSf5xMmVyhp/+TJXVom29LeHXf+wLZnbas3ZfPxR5PBweeW+W
   KlOo5TQp8hHn2jwFq6Ir9uqeEfj03onc0xpwPrEQUzlW0+KPV4ZxOtFMN
   w==;
X-CSE-ConnectionGUID: d8geZzyPTCubXxCNJLksqA==
X-CSE-MsgGUID: HzKBnwP5RTGLeoMZH4sgtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="81924975"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="81924975"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 11:02:39 -0700
X-CSE-ConnectionGUID: i1lohifhQy2A9RwUykJQpQ==
X-CSE-MsgGUID: dmRnuN4UTg++uuB9YeG9Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168008342"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa003.fm.intel.com with ESMTP; 02 Aug 2025 11:02:38 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiGZ2-0001Sx-05;
	Sat, 02 Aug 2025 18:02:36 +0000
Date: Sat, 2 Aug 2025 20:02:33 +0200
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:x86/urgent 2/2] irq.c:undefined reference to `lock_vector_lock'
Message-ID: <202508022015.ZX6l8pZr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
head:   69adc077da4c247dd39a8a0e3a898a25924e98d0
commit: 69adc077da4c247dd39a8a0e3a898a25924e98d0 [2/2] x86/irq: Plug vector setup race
config: i386-buildonly-randconfig-2002-20250802 (https://download.01.org/0day-ci/archive/20250802/202508022015.ZX6l8pZr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250802/202508022015.ZX6l8pZr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508022015.ZX6l8pZr-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/irq.o: in function `__common_interrupt':
>> irq.c:(.text+0x4f): undefined reference to `lock_vector_lock'
>> ld: irq.c:(.text+0x73): undefined reference to `unlock_vector_lock'
   ld: irq.c:(.text+0xa8): undefined reference to `unlock_vector_lock'
   ld: irq.c:(.text+0xc5): undefined reference to `unlock_vector_lock'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

