Return-Path: <linux-kernel+bounces-774897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1EB2B8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED501BA14EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE6223DC6;
	Tue, 19 Aug 2025 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENpjeqjJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806D21ADAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582525; cv=none; b=TsqawHmBQUd9kblBuTxMu2OzKo/8ZIsuAvm8G95JcZDU2mzSXv2feSzwGn0KdsrW4OT1cs/EnwpGB4eQqjXBf2nsEW7poxM47qm2YLt5Mpbf+/DYJoKacw6ahISPWLA5ZskXwQy8sSQ/72wQcsgE2/eJ3ea9dbe98AA4DMaxGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582525; c=relaxed/simple;
	bh=awBNQis2/Wp2vHf0nSTW4ilfCnxB3WgzqqA1wHWPNEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4negk4iD1MsmF19XYmdKpZYudyc8c2yTupsiFHemGeNL8vRDjNW/9/Se/1sUOsB1K88oEtI6q6caxPHcmZ8VzlpxAd9RIZJmJi66nOK7YDJwTIfNJLVnQzAqYenU5lQr7GwfXNPsXGuS43upjjmGY5irSpboCeahVYxiQMVazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENpjeqjJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755582524; x=1787118524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=awBNQis2/Wp2vHf0nSTW4ilfCnxB3WgzqqA1wHWPNEw=;
  b=ENpjeqjJaIdCNK8NE4tGlzPbphCUZHI2lkuGizEcblearHP+v5gFewD7
   T5+5PgT0HSo9s2RSU7RGect1Xhq6WDWFjg5ELWAwb+pMXx3y0C2sbLjaK
   AynYVZwi/yDO9EICnbcmtSFk6g0TO5VmdxmCC0wShkyxmwqeZlKRhtcYo
   S7dbm4fTpGo8ICXl4QO3YzTdvq34hVI6zmKmd/D2uFDYD9oBejiz88P1R
   zMNb00W4dfztryWukhMdYPisaw28JmwYDb0+0ll0+G19WqqGXHka4cogt
   +zzz5mnTtcNTA9izCE/yh7+VSki7majNjJ465vGqTB1mvWxg3CUiHnB0G
   Q==;
X-CSE-ConnectionGUID: 9KCwHNnPSUS3B21xyNBeNw==
X-CSE-MsgGUID: /WUTJ6WJSBmquUviBNiwXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57921216"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57921216"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 22:48:43 -0700
X-CSE-ConnectionGUID: W4Gr7TKHQFKWtBI3CtnaRg==
X-CSE-MsgGUID: DGONlHHLSx27vdC+evfYkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="204909581"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Aug 2025 22:48:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoFD2-000GXq-2I;
	Tue, 19 Aug 2025 05:48:36 +0000
Date: Tue, 19 Aug 2025 13:47:26 +0800
From: kernel test robot <lkp@intel.com>
To: Nipun Gupta <nipun.gupta@amd.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org, nikhil.agarwal@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, krzk@kernel.org,
	tglx@linutronix.de, maz@kernel.org, linux@weissschuh.net,
	chenqiuji666@gmail.com, peterz@infradead.org, robh@kernel.org,
	abhijit.gangurde@amd.com, nathan@kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] vfio/cdx: update driver to build without
 CONFIG_GENERIC_MSI_IRQ
Message-ID: <202508191254.kSWLsaT3-lkp@intel.com>
References: <20250818063244.1242634-2-nipun.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818063244.1242634-2-nipun.gupta@amd.com>

Hi Nipun,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17-rc2 next-20250818]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nipun-Gupta/vfio-cdx-update-driver-to-build-without-CONFIG_GENERIC_MSI_IRQ/20250818-143703
base:   linus/master
patch link:    https://lore.kernel.org/r/20250818063244.1242634-2-nipun.gupta%40amd.com
patch subject: [PATCH 2/2] vfio/cdx: update driver to build without CONFIG_GENERIC_MSI_IRQ
config: powerpc-randconfig-003-20250819 (https://download.01.org/0day-ci/archive/20250819/202508191254.kSWLsaT3-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250819/202508191254.kSWLsaT3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508191254.kSWLsaT3-lkp@intel.com/

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/vfio/cdx/intr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vfio/cdx/intr.o
>> ERROR: modpost: "vfio_cdx_irqs_cleanup" [drivers/vfio/cdx/vfio-cdx.ko] undefined!
>> ERROR: modpost: "vfio_cdx_set_irqs_ioctl" [drivers/vfio/cdx/vfio-cdx.ko] undefined!
>> WARNING: modpost: module intr uses symbol cdx_enable_msi from namespace CDX_BUS, but does not import it.
>> WARNING: modpost: module intr uses symbol cdx_disable_msi from namespace CDX_BUS, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

