Return-Path: <linux-kernel+bounces-863902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3912FBF975A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C221888643
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B381487E9;
	Wed, 22 Oct 2025 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEherjye"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2595733E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093079; cv=none; b=ExNvoy0M2fJylnHuE3hiqFyGQvtFsFjQrb2L/KfUoUbEO3MMZ7a1YtoDQ/s1yI39jrKxrI9y2Ya5/yLjuogzQcmxsdYEXJopJb50rU8/9qyJR+mkXQT79O+TpfoRNWxDWf7aaff3YiAjWlF8N26pF1cuy+8dYhddN/F0WQVy8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093079; c=relaxed/simple;
	bh=CQKqJtPBr/av3c5oJvuyyHOodvPUaYkBx7VP27CiwNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pTfD2/RHFoHOOI7dboeAgzcPyItPu3CbNfuq1bQbauY2smhQ3NzsrdOHdHEtPuOSKaduPEUTbohkN45YZdSUmRxlEpxh4y0fI9XaJlhFhiL5R/0b5bOpYzaAl88uw9zod4dq0iFcK04+4xEZoChj8nNvee3WBi675V2P6Yqjex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEherjye; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761093078; x=1792629078;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CQKqJtPBr/av3c5oJvuyyHOodvPUaYkBx7VP27CiwNA=;
  b=NEherjye+5kOwatCxNWGBbJF8b6En3UmgdaiAo8pv8Mm7vXmbaO1N+mz
   urpRCnVYUbbE9mDs6Oz0UBSOwZKIy+i8PB4aYXg3w3dnw9R/3vufSFd5N
   jVrqKmApvkCJlPxfdusbK+QtuTzexqPBso83fe/KywIRNuAAISji8rOTp
   IXMd3TCoS6KSf3gZsdpau5/+c/Gb1qfNH0dFDhc/GWpC7AwGZJl5C6oZ8
   pBeL83BKSCPuTqtGVNkEMonTJEaZ/Rnv+9wKe1SNd2Cl+7r+HfzxX4qE/
   aKOZKIex1LgaVyyfYJ4FzbPDzS2hhd6VG7KdY2SbkdZyEQO7wEyrhBUbD
   w==;
X-CSE-ConnectionGUID: 8z6W8iHbT6mYPoxR+H4kyg==
X-CSE-MsgGUID: Pz/j/ChZTEqySweoXdQ5jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73901210"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="73901210"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 17:31:17 -0700
X-CSE-ConnectionGUID: NAaOriFlQLuqHqpSRmf83A==
X-CSE-MsgGUID: FV6zE9vaSgmWBAmqUUXbTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="184209727"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 Oct 2025 17:31:16 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBMl0-000BrZ-19;
	Wed, 22 Oct 2025 00:31:14 +0000
Date: Wed, 22 Oct 2025 08:30:17 +0800
From: kernel test robot <lkp@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: xtensa-linux-ld: drivers/gpu/drm/xe/xe_module.o:undefined reference
 to `xe_configfs_init'
Message-ID: <202510220824.usapHutb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6548d364a3e850326831799d7e3ea2d7bb97ba08
commit: 16280ded45fba1216d1d4c6acfc20c2d5b45ef50 drm/xe: Add configfs to enable survivability mode
date:   7 months ago
config: xtensa-randconfig-002-20251021 (https://download.01.org/0day-ci/archive/20251022/202510220824.usapHutb-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510220824.usapHutb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510220824.usapHutb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: drivers/gpu/drm/xe/xe_module.o:(.rodata+0x30): undefined reference to `xe_configfs_init'
>> xtensa-linux-ld: drivers/gpu/drm/xe/xe_module.o:(.rodata+0x34): undefined reference to `xe_configfs_exit'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

