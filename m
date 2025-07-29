Return-Path: <linux-kernel+bounces-748954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D1DB14800
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F37F3A2882
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A70256C8D;
	Tue, 29 Jul 2025 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mb0FBu40"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3FA1A76BB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769206; cv=none; b=SSM6yfO/5hH8ACtIicQuYpQ3IYCLkr8XTaXBl6xnMCy2GeE0oubRYsmRo55Ez6Gdn8y3RLwgjVN4y2tQua5ZOWxt4Y57FkjD4oLG4Ilyt4SPcDcDn8vCUT72jWfGx0FYmmwQztAxRUn+nD7IdFAebA0B0dEOaBZHRZwM3POTjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769206; c=relaxed/simple;
	bh=Bl/fNTkig+CIWaWN8mZbPmPTpdVQHEHftYHWyS67TFw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eoiiTrq9q4eV7p0ZEjuzY3TEvju9l1zc30L9GUZgSCXHaEYtmy/osUrBH5n+LpUtR98ldR/ogfbHs1I3L7EES3ptj0zub4PUzVQfRXoypf71jlDvC81ro3aMUuRNnlCdPvO24YlafIxoQIGfS/q2vU0I2J2uZCh861s096ihIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mb0FBu40; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753769204; x=1785305204;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bl/fNTkig+CIWaWN8mZbPmPTpdVQHEHftYHWyS67TFw=;
  b=mb0FBu40jVU3EGolpEfaiQH3kJt//Iv52Vz+YgZ6280DnFYIsP1TizZL
   /DKYVBhJfgZf8WiASMcKnV0+0pslYPLlkZ4J3Z25zei0c7rFRV3+PHw+o
   b6jpaeXOopWqVRKJnwVw8k0fGyn5t3I5vregD9WLPMmu7yMCkNKq5r1bx
   ZtoNkNWsm76f2mJwyK+Sxsk2I2HhfQczndcnPfBo0Oetih6m+QrRNeLML
   rBAp4XZ6sMe0M2Tde27+3PNEnEebOmGkSwEusZjpKF+UiTHM21+la6VHW
   7Yhiv+O1M1QAY0M1ehU/AGrz7jcLaxAPg7sMX1rMCWJcrJbh+G021tJd8
   g==;
X-CSE-ConnectionGUID: 2EyTA7wcQKmpeJ5b6yABiA==
X-CSE-MsgGUID: soppFsHlQqysUs8rtUeURQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="56117595"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="56117595"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 23:06:44 -0700
X-CSE-ConnectionGUID: a3ugEmSJQMC/Xq/JHlE7FQ==
X-CSE-MsgGUID: TTMxe9XwRjaBDBKf5P1Afw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="162954614"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 28 Jul 2025 23:06:42 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugdU0-00012t-0M;
	Tue, 29 Jul 2025 06:06:40 +0000
Date: Tue, 29 Jul 2025 14:06:39 +0800
From: kernel test robot <lkp@intel.com>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 EARLY_PRINTK_8250 when selected by ECONET
Message-ID: <202507291418.bJ3Xc6L2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae388edd4a8f0226f3ef7b102c34f78220756c3d
commit: 35fb26f94dfa1b291086b84b2421f957214824d1 mips: Add EcoNet MIPS platform support
date:   2 months ago
config: mips-kismet-CONFIG_EARLY_PRINTK_8250-CONFIG_ECONET-0-0 (https://download.01.org/0day-ci/archive/20250729/202507291418.bJ3Xc6L2-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250729/202507291418.bJ3Xc6L2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507291418.bJ3Xc6L2-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for EARLY_PRINTK_8250 when selected by ECONET
   WARNING: unmet direct dependencies detected for EARLY_PRINTK_8250
     Depends on [n]: EARLY_PRINTK [=n] && USE_GENERIC_EARLY_PRINTK_8250 [=y]
     Selected by [y]:
     - ECONET [=y]
   
   WARNING: unmet direct dependencies detected for SERIAL_OF_PLATFORM
     Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && OF [=y]
     Selected by [y]:
     - ECONET [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

