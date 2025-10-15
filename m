Return-Path: <linux-kernel+bounces-853890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B6BDCD33
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EAD3BA032
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A2E2FE577;
	Wed, 15 Oct 2025 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vsox0Qt3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938320B7EE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512147; cv=none; b=gWkY5a5dD6wgyklz2XS3JSYTuqGpRxNePelIJvDDOAYkoCJyyBnj0Ke5cOJkUl9rxn10FmCYB1IJCvUc4BvRsJCbqcqF0CW7RSeULXwXiAWB1XIYQV2fepEu53ZJw+8nxMXuFtSXrkVNpuNewzAD2yhCwJ+c1FtCQ9YjeJH+1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512147; c=relaxed/simple;
	bh=cbFWr/aeVAGwQ8W4iJ9elJFtP7YdZfaqIxqQ0SovTjY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WgV5JlsSEvX1F8FshzxBG+6WS+mJfn+0EuSA/eUDkTkZlPfxg3z+6DbiUHkf7Yj9KnBmy4MKZzQz+EZDcLC6cc5TUAsdFQh9t0kmoNgvS/ebTZx6SlkUH+Qx1luvHT5UabiIjGRx8Fm9Xvh6Y9mR8vewit3t70utqoSEHw1ssBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vsox0Qt3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760512145; x=1792048145;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cbFWr/aeVAGwQ8W4iJ9elJFtP7YdZfaqIxqQ0SovTjY=;
  b=Vsox0Qt3TMq6oeRVigRqTbqpWyoN8jVmmvmMbK70fkyp2vprC4z1Kttu
   MvQdsF5WTUInJwTmCvfk0Rk4ET6FHY3TqidpdTgfL9gFMxByBp//liAfH
   uQkZAUbyoNQsAKxOw5eecaFtDUl3pK28pTDrIE/Av16n3L0g0U9iSVbIz
   jKFBzYMTNjtEhAkNKmFSjPawVkzqi5IUG0/W3E84UPtnB5lZWepQ/I9vF
   zww5x9AjseaBWAa6G5cAQYh1g74NPGA5nXTiX/e854EklAJsXmRprgrfi
   H+6c4c7NezWLhuhvVv2UDAj6Lm9yItoo/Em96HCjdHCpPVyZbNjb8AfLe
   Q==;
X-CSE-ConnectionGUID: eojKYf2pTG2XmqBusI7Z1g==
X-CSE-MsgGUID: Js0PwM9oTcifJpsykK221g==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62830767"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62830767"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:09:04 -0700
X-CSE-ConnectionGUID: XqKoxdnFQoGmbpHy8/Ld3Q==
X-CSE-MsgGUID: 2+bJnW6hRr+eJkAGjwFlzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182871151"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 15 Oct 2025 00:09:03 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8vd7-0003Yr-0V;
	Wed, 15 Oct 2025 07:09:01 +0000
Date: Wed, 15 Oct 2025 15:08:57 +0800
From: kernel test robot <lkp@intel.com>
To: Feng Chen <feng.chen@amlogic.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: alpha-linux-ld: drivers/spi/spi-amlogic-spifc-a4.c:289:undefined
 reference to `__ffsdi2'
Message-ID: <202510151522.iQuRChZM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Feng,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b332cece987ee1790b2ed4c989e28162fa47860
commit: 4670db6f32e9379f5ab6c9bb2a6787cd9b9230a9 spi: amlogic: add driver for Amlogic SPI Flash Controller
date:   5 weeks ago
config: alpha-randconfig-r123-20251014 (https://download.01.org/0day-ci/archive/20251015/202510151522.iQuRChZM-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151522.iQuRChZM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151522.iQuRChZM-lkp@intel.com/

All errors (new ones prefixed by >>):

   `xe_configfs_exit' referenced in section `.data.rel.ro' of drivers/gpu/drm/xe/xe_module.o: defined in discarded section `.exit.text' of drivers/gpu/drm/xe/xe_configfs.o
   alpha-linux-ld: drivers/spi/spi-amlogic-spifc-a4.o: in function `aml_sfc_set_bus_width':
   drivers/spi/spi-amlogic-spifc-a4.c:289:(.text+0x5ec): undefined reference to `__ffsdi2'
>> alpha-linux-ld: drivers/spi/spi-amlogic-spifc-a4.c:289:(.text+0x5f0): undefined reference to `__ffsdi2'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

