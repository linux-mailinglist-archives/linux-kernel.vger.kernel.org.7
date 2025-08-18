Return-Path: <linux-kernel+bounces-772664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFCBB295C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D597AD4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 00:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC9146D6A;
	Mon, 18 Aug 2025 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7GAisVD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41701F5F6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755475350; cv=none; b=aY7h18W7ZlKphY3esX95/mNnt3tqqRYumNVWpHoLYz68TOat44OI/BT5xCS+DAs1iI5NmWjPwqhAiRw/0ixWLCBcj9m3hni6BenJGxP9Ucrt7I42zRQ7G9VggDL+RWHsZK381qdGj4GXukalm6Szq0gHWzD6CHEHQazqWyAkcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755475350; c=relaxed/simple;
	bh=9II7IW9PrETb2OGmq6IN1gC5JB4G6FHnozlS/CXyEys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ex23olnWgKPQhtEEG/lnv5aFQ2/WYQ1fQF4lab7Xet+Cp87Qa09Veh7HrEl3xD3xSpwIK8GwKXxH5M1N+zeh6jQoYva/55DOwbdun44f0WMGwUZ00nSEDbBNeH4N1SrT8LkOsrYE/IhuKDZyo1rUerqMQPYcZJ13aniOLvNfR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7GAisVD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755475349; x=1787011349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9II7IW9PrETb2OGmq6IN1gC5JB4G6FHnozlS/CXyEys=;
  b=f7GAisVDC8SCY1kuh/i3Tr8/By0+qW8/Uw47fRQgCR+R0l5FT5DPLe7T
   gruBxWZtArHOqxCmUrnTW0ltjuq0tVHTJiMZXmV64jtGe/49gGexSgaeZ
   vbkLnVxjsXZdpJhog6R1eEYa3vI9ha6jdT5LShKs8IDHcBedkLY317Nrc
   eAIiSKWqyTfa8HxQvSfgHiQGqnyr1TG/q/iaWaVJ7Hrhrg6CobZwL5YV8
   +SNJtLbUdmALMbyK2Z+UCQWRFiyroKEzjN77qh9VjNcbixIvzLGm/pMYh
   QJ89n5avl30j9kROFIyhfZcvwuY5nkIyYvTZ8YurOLE2DXIrr2uHJwnVm
   g==;
X-CSE-ConnectionGUID: GU+yh1/ERPCaPTEVFV54cA==
X-CSE-MsgGUID: yag77DqFTE6403sQr0jbCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="68298076"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68298076"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 17:02:28 -0700
X-CSE-ConnectionGUID: AcqKu4zWTuu/j4mrxnzl3A==
X-CSE-MsgGUID: qhYIpKksSbeUA2+kUez+Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167051874"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 17 Aug 2025 17:02:27 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unnKR-000Dmy-34;
	Mon, 18 Aug 2025 00:02:23 +0000
Date: Mon, 18 Aug 2025 08:02:14 +0800
From: kernel test robot <lkp@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [tip:timers/clocksource 18/24] decompress.c:undefined reference to
 `__decompress'
Message-ID: <202508180750.eB80Lf6D-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/clocksource
head:   7b098309ced7709c0a502b5eb9f54bd1f26fc6c6
commit: ed1d4c331f9f161788903885ce9ddfd665bdbe18 [18/24] clocksource/drivers/timer-tegra186: Avoid 64-bit divide operation
config: powerpc-randconfig-001-20250818 (https://download.01.org/0day-ci/archive/20250818/202508180750.eB80Lf6D-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250818/202508180750.eB80Lf6D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508180750.eB80Lf6D-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: arch/powerpc/boot/wrapper.a(decompress.o): in function `partial_decompress':
>> decompress.c:(.text+0x1ec): undefined reference to `__decompress'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

