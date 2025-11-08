Return-Path: <linux-kernel+bounces-891591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD8C4302C
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99DC3AEE82
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76CF230D0F;
	Sat,  8 Nov 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDi8vUwa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88822A80D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762620866; cv=none; b=RYaIJ1vuzFYF1vRHZAr+HxwrCczBQ6VzI9jzNCckKhmqB2FAgLd3t4kXbu0pAgHETV+ruI71BKVbIQ/Vuw7SDmFPaT2zm/c5nElIOWckHY0VChJVkvafsQY1s3nQvKIGDoetvDiDnW917TnSa9ydWkITLq38ROhQIu3+4txtiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762620866; c=relaxed/simple;
	bh=ZCQYnX45uAZM7T/QqOIdl/VoB6Z2QSZWSVLYK3UzCao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=in7OWR3esswXNQFnwOp2ZO4Sn7TFU2eTlDTBviZqfOQjXlmsXkfqZYnbttawHJP1GxFS9gToAuvP332uYSXXCslxP0gsN9lCWqc9V3RlpPyp6rJUhjk67DYjj3U3ecc++cojJQyiskTMC3DVZvFvi4+DdwYoJwHia/Z5WtT6OuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDi8vUwa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762620863; x=1794156863;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZCQYnX45uAZM7T/QqOIdl/VoB6Z2QSZWSVLYK3UzCao=;
  b=ZDi8vUwabDz0/9AKjE+fMi3y9Wso9CIxSdFXEM2EPJ61Rad4f23ZnPDY
   mF8gsniUt2X4bBaIvYjQK9zNQUYxVSeVD5RHgEyVMRGAgdczcT6yXgPPd
   PHHSpQTrTClAwYMamBxUiyN8M5xwXbuZdJp9KBEWHXfjV0tzwYiItJxUs
   zVpM95JfyMz/EIyYZRHcSKZGWRqf5cPJiF5o/w8siFZ+r5eqro+HxcaQ5
   UGsX35jioZttzhsHUuE4AaCelwOjPV+kGhpEA32qwX0FGW6rNaBzIOCrV
   hG0U2t+coGd8xUbVS0v+4LwFjXw0+bZUHXG9llq1M8vROgcw0RKwS34/S
   A==;
X-CSE-ConnectionGUID: kZ3lUNrqQ7K/W0QXzCMhHA==
X-CSE-MsgGUID: W44rgz7ASmmmDNC6kwHG2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="75351787"
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="75351787"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 08:54:23 -0800
X-CSE-ConnectionGUID: P+6AXLhiScmRSQUzI8D2Rw==
X-CSE-MsgGUID: zG505yV1RuqIQ2z4hLOTmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="187607146"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Nov 2025 08:54:22 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHmCh-0001GN-14;
	Sat, 08 Nov 2025 16:54:19 +0000
Date: Sun, 9 Nov 2025 00:53:33 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: arch/xtensa/boot/boot-elf/bootstrap.S:58: Error: invalid register
 'atomctl' for 'wsr' instruction
Message-ID: <202511090027.GvyB7VDx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e811c33b1f137be26a20444b79db8cbc1fca1c89
commit: 8d46603eeeb4c6abff1d2e49f2a6ae289dac765e media: cxd2841er: fix 64-bit division on gcc-9
date:   11 months ago
config: xtensa-randconfig-r131-20251108 (https://download.01.org/0day-ci/archive/20251109/202511090027.GvyB7VDx-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511090027.GvyB7VDx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511090027.GvyB7VDx-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/xtensa/boot/boot-elf/bootstrap.S: Assembler messages:
>> arch/xtensa/boot/boot-elf/bootstrap.S:58: Error: invalid register 'atomctl' for 'wsr' instruction
   arch/xtensa/boot/boot-elf/bootstrap.S:68: Warning: value 0x1a0003000 truncated to 0xa0003000


vim +58 arch/xtensa/boot/boot-elf/bootstrap.S

e85e335f8ff615f Max Filippov 2012-12-03  42  
e85e335f8ff615f Max Filippov 2012-12-03  43  	.align  4
e85e335f8ff615f Max Filippov 2012-12-03  44  _SetupMMU:
09af39f649dac66 Max Filippov 2021-07-26  45  #if XCHAL_HAVE_WINDOWED
e85e335f8ff615f Max Filippov 2012-12-03  46  	movi	a0, 0
e85e335f8ff615f Max Filippov 2012-12-03  47  	wsr	a0, windowbase
e85e335f8ff615f Max Filippov 2012-12-03  48  	rsync
e85e335f8ff615f Max Filippov 2012-12-03  49  	movi	a0, 1
e85e335f8ff615f Max Filippov 2012-12-03  50  	wsr	a0, windowstart
e85e335f8ff615f Max Filippov 2012-12-03  51  	rsync
09af39f649dac66 Max Filippov 2021-07-26  52  #endif
e85e335f8ff615f Max Filippov 2012-12-03  53  	movi	a0, 0x1F
e85e335f8ff615f Max Filippov 2012-12-03  54  	wsr	a0, ps
e85e335f8ff615f Max Filippov 2012-12-03  55  	rsync
e85e335f8ff615f Max Filippov 2012-12-03  56  
e85e335f8ff615f Max Filippov 2012-12-03  57  #ifndef CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX
e85e335f8ff615f Max Filippov 2012-12-03 @58  	initialize_mmu

:::::: The code at line 58 was first introduced by commit
:::::: e85e335f8ff615f74e29e09cc2599f095600114b xtensa: add MMU v3 support

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Chris Zankel <chris@zankel.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

