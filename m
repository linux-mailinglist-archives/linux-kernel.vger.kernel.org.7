Return-Path: <linux-kernel+bounces-895833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB4C4F0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA0334F403F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188A36CE16;
	Tue, 11 Nov 2025 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeAqx1xL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E3328276;
	Tue, 11 Nov 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878841; cv=none; b=DcCPbq4eQh5q5+A9teDS0Z5VbWJ9zpO4YaP/lc7x4n5t7mQax8Curc0nSdvWl1ri3o/B3ZrgzQp7yW5AF6wHNo+prWF3efcsKvsbxzyyX19OF8I9vE2UWjb5S0Lt7w77dNs+qzZ5sMXPv63yGkQAh+YjJNMB1oXhhhMSnT6BRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878841; c=relaxed/simple;
	bh=yJ2LzCsvw6ArGjiUAFXmFEj3idSKQ3/GF1+iB5RVUl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8zrI/0/XJw4Z17NaqR5Besa99R0zVPtczqywcDTGvsM2Kssym54JGMYUe8oJstcSDeYJPZedf0EvylvUU1iBQ2cdAZ6BRoMXr0XW9oEl1wL8MEwKmANSQzfM3IOCuYpza9j6cFFnXB5NsY8r6UcGt/sW2CmgZVIpD2PZdThqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeAqx1xL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762878839; x=1794414839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yJ2LzCsvw6ArGjiUAFXmFEj3idSKQ3/GF1+iB5RVUl4=;
  b=UeAqx1xL/llCNJ1fdJqJyQ5FMR09sTEijHoAcgzpBiLFncatKtVgZVwr
   9b5IfQInL0QUdAZOcVMPmS+onss09GkO6TQW+Itd1waq/zt7lsqU67A78
   kwQMus+ohE3As9wpJYviwjsFlBIZCIPRgdAZDKoVzqpTya1IuSI/Z9Q3q
   aVxFgsxGVPvMdS9EqAh8rys1jy02MSZdBj/fksjC24uXUUokxOLiAg/kk
   RPsAR4hrqj7d2gNFc/BXVCMs1pwyoCOhmG0wmuFvk/vjYRBQsGt2RLVpu
   hepTj7O/ptgrbpp9YU1K3AjueWoGEOb/hXF08FFqrMX4QmQRUW/cvsNBv
   A==;
X-CSE-ConnectionGUID: ALuEQhv2SD+jNl7j+x9O1g==
X-CSE-MsgGUID: eIJJYaNAQauDrPSiUJZuYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="82341339"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="82341339"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:33:58 -0800
X-CSE-ConnectionGUID: 42SDqvc9QrqRcuoY5NWowg==
X-CSE-MsgGUID: y4Yi1rdLQ4avEbGDEdJZeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193386798"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Nov 2025 08:33:56 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIrJZ-0003N3-17;
	Tue, 11 Nov 2025 16:33:53 +0000
Date: Wed, 12 Nov 2025 00:33:08 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v1 2/2] devres: Move devm_alloc_percpu() and related to
 devres.h
Message-ID: <202511120059.G3PR823H-lkp@intel.com>
References: <20251111144104.910241-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111144104.910241-3-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.18-rc5 next-20251111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/devres-Remove-unused-devm_free_percpu/20251111-230827
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20251111144104.910241-3-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 2/2] devres: Move devm_alloc_percpu() and related to devres.h
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20251112/202511120059.G3PR823H-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 996639d6ebb86ff15a8c99b67f1c2e2117636ae7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511120059.G3PR823H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511120059.G3PR823H-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpio/gpiolib-devres.c:9:
>> include/linux/device/devres.h:113:6: error: variable has incomplete type 'void'
     113 | void __percpu *__devm_alloc_percpu(struct device *dev, size_t size, size_t align);
         |      ^
   include/linux/compiler_types.h:60:19: note: expanded from macro '__percpu'
      60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
         |                         ^
   In file included from drivers/gpio/gpiolib-devres.c:9:
>> include/linux/device/devres.h:113:15: error: expected ';' after top level declarator
     113 | void __percpu *__devm_alloc_percpu(struct device *dev, size_t size, size_t align);
         |               ^
   In file included from drivers/gpio/gpiolib-devres.c:17:
   In file included from drivers/gpio/gpiolib.h:12:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/loongarch/include/asm/elf.h:9:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpio/gpiolib-devres.c:17:
   In file included from drivers/gpio/gpiolib.h:12:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/loongarch/include/asm/elf.h:9:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpio/gpiolib-devres.c:17:
   In file included from drivers/gpio/gpiolib.h:12:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/loongarch/include/asm/elf.h:9:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpio/gpiolib-devres.c:17:
   In file included from drivers/gpio/gpiolib.h:12:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/loongarch/include/asm/elf.h:9:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpio/gpiolib-devres.c:17:
   In file included from drivers/gpio/gpiolib.h:12:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/loongarch/include/asm/elf.h:9:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpio/gpiolib-devres.c:17:
   In file included from drivers/gpio/gpiolib.h:12:
   In file included from include/linux/cdev.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/loongarch/include/asm/elf.h:9:


vim +/void +113 include/linux/device/devres.h

    98	
    99	/**
   100	 * devm_alloc_percpu - Resource-managed alloc_percpu
   101	 * @dev: Device to allocate per-cpu memory for
   102	 * @type: Type to allocate per-cpu memory for
   103	 *
   104	 * Managed alloc_percpu. Per-cpu memory allocated with this function is
   105	 * automatically freed on driver detach.
   106	 *
   107	 * RETURNS:
   108	 * Pointer to allocated memory on success, NULL on failure.
   109	 */
   110	#define devm_alloc_percpu(dev, type)      \
   111		((typeof(type) __percpu *)__devm_alloc_percpu((dev), sizeof(type), __alignof__(type)))
   112	
 > 113	void __percpu *__devm_alloc_percpu(struct device *dev, size_t size, size_t align);
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

