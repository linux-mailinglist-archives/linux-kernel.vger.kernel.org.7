Return-Path: <linux-kernel+bounces-883891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D8C2EAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0E0934C3DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99E1F5834;
	Tue,  4 Nov 2025 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jl/ymXFa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8B27456
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217976; cv=none; b=jrlbltKPdFkSLPA+eHk0j23Yc4mllDdG5yB9WavN9N3yozCjYmS/o456798BlRKUfs7odM+uMp++Yij2hlXvCzyg0yX1rXBYEJXsQMmR6lJbjYFASwzgytsfEqxYxkNtiszw35QO9ZZFtFIOTTfvmUHS+bLP5qwwJBRXnUIDpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217976; c=relaxed/simple;
	bh=4kBumpLPX76t+5M1bV9a46fiVCJFH23dZmzlUcwuvU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L8NwSnpHmRQSJJgB4oeofQDQ8fyfNwO8cV/9uaOhM1jQjyh/7gt2zcJ919crsh06KFF0CmRzmxXilXDp4pVa+PbF/TjB4whi+49zhAE5ls1v9ZA4UQpJ6GjHhOwFJeBv4kpQTIOhbLrmnVnAxECKCYNqQ80061D3jIdpfuN1SFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jl/ymXFa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762217975; x=1793753975;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4kBumpLPX76t+5M1bV9a46fiVCJFH23dZmzlUcwuvU4=;
  b=jl/ymXFaFPBjEPDVmp0RYOOMo2Gwz8LGlokG+OgXlWpbm9+hZI9wNLHE
   DIvI2cO3r/kYhe0gHcBU5JiHGj2Mtrv3xqm4gtYg+a7QcmUMxwCLB4WVh
   yLCD2F8QsfaO4BuZKxu6I3r5ki03P+xQT4V/1r0SsLcWi4f7YBEXZzSFZ
   ePjVunVDnmUU+llMBHZS4uZrZ7jjONMjIRtZ/HZnmN9aHBgKR7Yf1kz+Z
   FtSnzUmipNHpjMVVbefp/d/b7QICyLaCQs+ZlVi468Dl2H3d1hhPxgxvq
   21gN/LASfa0yedYYI5GIII7qpjCDr2y6mxbsMYPRwR+Mw36h3DmC056oB
   w==;
X-CSE-ConnectionGUID: bF4pw3imRjOHv3IJhNFmmQ==
X-CSE-MsgGUID: ISdnVrOLSHG5OEEYDQlaMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64189979"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64189979"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 16:59:34 -0800
X-CSE-ConnectionGUID: c37iCtTyTFut3d1ZTS0qEQ==
X-CSE-MsgGUID: VD6T7xAjSzSTESCwuqaV9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="224261563"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 03 Nov 2025 16:59:33 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vG5OU-000Qhf-2q;
	Tue, 04 Nov 2025 00:59:30 +0000
Date: Tue, 4 Nov 2025 08:58:20 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:objtool/core 1/1] arm-linux-gnueabi-ld: warning: orphan section
 `.text.start.constprop.0' from `drivers/usb/host/sl811-hcd.o' being placed
 in section `.text.start.constprop.0'
Message-ID: <202511040812.DFGedJiy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
head:   6568f14cb5ae68cd6c612604ca0c89301cf3a0d0
commit: 6568f14cb5ae68cd6c612604ca0c89301cf3a0d0 [1/1] vmlinux.lds: Exclude .text.startup and .text.exit from TEXT_MAIN
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20251104/202511040812.DFGedJiy-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511040812.DFGedJiy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511040812.DFGedJiy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/usb/host/sl811-hcd.o' being placed in section `.text.start.constprop.0'
>> arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/media/dvb-frontends/drxk_hard.o' being placed in section `.text.start.constprop.0'
>> arm-linux-gnueabi-ld: warning: orphan section `.text.start' from `drivers/media/dvb-frontends/stv0910.o' being placed in section `.text.start'
>> arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/media/pci/ddbridge/ddbridge-sx8.o' being placed in section `.text.start.constprop.0'
   arm-linux-gnueabi-ld: drivers/spi/spi-amlogic-spifc-a4.o: in function `aml_sfc_set_bus_width':
   spi-amlogic-spifc-a4.c:(.text.aml_sfc_set_bus_width+0x8c): undefined reference to `__ffsdi2'
   arm-linux-gnueabi-ld: spi-amlogic-spifc-a4.c:(.text.aml_sfc_set_bus_width+0xac): undefined reference to `__ffsdi2'
   arm-linux-gnueabi-ld: spi-amlogic-spifc-a4.c:(.text.aml_sfc_set_bus_width+0xcc): undefined reference to `__ffsdi2'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

