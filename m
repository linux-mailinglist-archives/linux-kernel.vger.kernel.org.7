Return-Path: <linux-kernel+bounces-749045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF2AB14947
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3A316FCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6926529A;
	Tue, 29 Jul 2025 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HH45wtQm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A04264638
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774914; cv=none; b=KJ2l3TyMdhf8rVw0+FboR6UxNQaPj2WwvF6BQu8Ofc0gMrZ1IkpHlbnlgJMAP+D7crc6hKra+zbFAipoywzSblIB/umWaD+JKk7D+hX/FFzJkz1+5L5ped8LtUC5Oo5m8PpQy0w/JzKBL2fpsU0QZJSQ8ob4SazPMsrfuZqjJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774914; c=relaxed/simple;
	bh=3jWFEykPi3v2GxNSP51NIqa1ECI538IFlc/9BBcvZ28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OIP1j5S79QvVfZTiTOMYE26vUcgTGA1Dwvh+IUz3HBd1WUYVrGb0skKMxZJJAqggYFm76hAVAoDqhWNdNq0NKbqtQT0prLckz5rTRspOgrcCoch6P4RqUV/DR1ltirD5wBPQLoInuMwaNMjRB+B4kNmbmOotNSCcSB4AZcchvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HH45wtQm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753774913; x=1785310913;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3jWFEykPi3v2GxNSP51NIqa1ECI538IFlc/9BBcvZ28=;
  b=HH45wtQmVOLCbv9X3kncx/hwlDb5Z1/x60O8ZfOXyIyS67hx3tLF90Y5
   fm9muB76eJLtqfEtXI6NQs72HAVN9mr5b/22yT1bxVXWP7JA8nAbLSyU3
   lGiQhxJFrLPqbVLNNNEd4SU1BY02XcTKkQEZTGB+MVSNmy//zQHs48tn0
   iPo7G56kf15tBFS78kuV7hzUhxLXBLa/SMfpue8KyIU0yZ8joGj/tYoHT
   4GHSPIcTYb/83bw7v7vOBoLhr0nfCCvxdpV23747qWAuDree7Ca3I7rBW
   2Zep2fePLHGXiNuNvtbFiab0bojhUZk0rk7uWZcu+dOD8ZAFBGT1T+DLR
   Q==;
X-CSE-ConnectionGUID: UO/cm2O5QdmbnYGcrMiT3A==
X-CSE-MsgGUID: MZMhjmZdRHC3t3dfcwZQ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67472303"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="67472303"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 00:41:52 -0700
X-CSE-ConnectionGUID: ozPYgMW+SXuIRebLw73UKA==
X-CSE-MsgGUID: maAKCDCZQWuoxcuw8oS8HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="166807026"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2025 00:41:51 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugey4-000167-29;
	Tue, 29 Jul 2025 07:41:48 +0000
Date: Tue, 29 Jul 2025 15:41:00 +0800
From: kernel test robot <lkp@intel.com>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 SERIAL_OF_PLATFORM when selected by ECONET
Message-ID: <202507291515.5EiVPN6M-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   86aa721820952b793a12fc6e5a01734186c0c238
commit: 35fb26f94dfa1b291086b84b2421f957214824d1 mips: Add EcoNet MIPS platform support
date:   2 months ago
config: mips-kismet-CONFIG_SERIAL_OF_PLATFORM-CONFIG_ECONET-0-0 (https://download.01.org/0day-ci/archive/20250729/202507291515.5EiVPN6M-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250729/202507291515.5EiVPN6M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507291515.5EiVPN6M-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SERIAL_OF_PLATFORM when selected by ECONET
   WARNING: unmet direct dependencies detected for SERIAL_OF_PLATFORM
     Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && OF [=y]
     Selected by [y]:
     - ECONET [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

