Return-Path: <linux-kernel+bounces-746707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466D6B12A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8EF3BBF63
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA1223FC4C;
	Sat, 26 Jul 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ng6z2KdI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACD23D2A1
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753528236; cv=none; b=ZQpXoy54s07ewGDdXyQF8zgLVdeBQmRySuqOytvjK4s27G+j6sqvz1S3EdWz8uJB5PoJHCTCWSD0zxeM53lQZR/ZCaiYUENGuhmHGBxQsMGmV3nHJiN5a2467iYKieg6rDEkX3SrINs/fnEZ2LNsoqY2tQSU6iw01Ndi5DS5/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753528236; c=relaxed/simple;
	bh=UMCcVYsotsVlB3gqcvdhIUZ3BeNnGlt6WBjFL9Fw4Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR6n27MTXW8KIGQyJECUhSkd6JWB1q8FmJGEy6tIc0ZfRmNILB5NZgmAM2MnPAPXgBDIHtgDSWKYLEFmRyX4o3To65DtJhyW2Jp3WU9t0QRytoysXb1wuzOUzldRSsBLd7DXJw/2ylEPNZE1jOwPwhNU5Q6jn35b+s76EhDParI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ng6z2KdI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753528234; x=1785064234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UMCcVYsotsVlB3gqcvdhIUZ3BeNnGlt6WBjFL9Fw4Rk=;
  b=Ng6z2KdImGGd3VP0UzN3PSYCbMqQRZjtwSK4LJjAEp+hn0ohaiO0zduF
   bchDFXgt7el9vMbYV4cqOn1BiSHx/Mn5/57n4Z7obh1KO5CoLhyER+r7B
   vVBzn7uWtYZec1j6e37HBltYbQg0VK+rpikksoP95G9zEdMykPVJ+cPqb
   QRC6tHtX83jVf+cYujmyYj4ywWH4td13BaOaZAZ4o5c95eVRrKGYBTXQb
   oMYQmi4EGyr3v5QDr0kR1+dbRAPiciIoKt96+QMRnmGURkFw+XhM0uq1X
   4karJOCtRXc4nPDET6ATwNoFyyypOPpT0uamKrcSeLddKpZBikqwiqq/p
   A==;
X-CSE-ConnectionGUID: d5VNRZYQSr2WN5dFgiLzDg==
X-CSE-MsgGUID: vYCfn3fkRMecswjsMuesfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55057928"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55057928"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 04:10:32 -0700
X-CSE-ConnectionGUID: EJG24i+6RqSQiqQjoMiUgw==
X-CSE-MsgGUID: PBODKjChRlO5kTuwV5iXVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192442294"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Jul 2025 04:10:30 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufcnM-000Lut-0G;
	Sat, 26 Jul 2025 11:10:28 +0000
Date: Sat, 26 Jul 2025 19:10:11 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Shi <yang@os.amperecomputing.com>, ryan.roberts@arm.com,
	will@kernel.org, catalin.marinas@arm.com, akpm@linux-foundation.org,
	Miko.Lenczewski@arm.com, dev.jain@arm.com,
	scott@os.amperecomputing.com, cl@gentwo.org
Cc: oe-kbuild-all@lists.linux.dev, yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: mm: split linear mapping if BBML2 is not
 supported on secondary CPUs
Message-ID: <202507261822.ikaBRFsG-lkp@intel.com>
References: <20250724221216.1998696-5-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724221216.1998696-5-yang@os.amperecomputing.com>

Hi Yang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250724]
[cannot apply to arm64/for-next/core akpm-mm/mm-everything v6.16-rc7 v6.16-rc6 v6.16-rc5 linus/master v6.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/arm64-Enable-permission-change-on-arm64-kernel-block-mappings/20250725-061534
base:   next-20250724
patch link:    https://lore.kernel.org/r/20250724221216.1998696-5-yang%40os.amperecomputing.com
patch subject: [PATCH 4/4] arm64: mm: split linear mapping if BBML2 is not supported on secondary CPUs
config: arm64-randconfig-001-20250726 (https://download.01.org/0day-ci/archive/20250726/202507261822.ikaBRFsG-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261822.ikaBRFsG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261822.ikaBRFsG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm64/mm/mmu.o: in function `linear_map_split_to_ptes':
   mmu.c:(.init.text+0x23c): relocation truncated to fit: R_AARCH64_LDST32_ABS_LO12_NC against symbol `repaint_done' defined in .data section in arch/arm64/mm/proc.o
>> aarch64-linux-ld: mmu.c:(.init.text+0x23c): warning: one possible cause of this error is that the symbol is being referenced in the indicated code as if it had a larger alignment than was declared where it was defined

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

