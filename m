Return-Path: <linux-kernel+bounces-881168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58366C279F2
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 09:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8072018974B8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6DF2BCF4A;
	Sat,  1 Nov 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYjCU7pG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFF29D270;
	Sat,  1 Nov 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761986999; cv=none; b=dgANwPBVCJln8pLNVE+SogfEitKEWdxClDn0L79mUyDL1Mm40DFTiFJOJrh1Qt4BiXtldJuTJn2np1E7YWntCSYwl70oJpqmgepx72qFZ5Au2KunTwU7EYhDKefFZauTyIdAdzgXeLJQNUYrFhB63O1aTCXdXPjj4plxmhIQRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761986999; c=relaxed/simple;
	bh=9s/STQTxcc3k88CIQt95xpXMPCs3JdFq9Lp93ypc8O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2xP0tToPf/F+D3vDQjNExKMXMjzC9eyh799BnFYce64rjqOvcNUw684iPgZkHXQMWkWtHqUXPcqI07a2pwThdpOtt6oxNXg69uFqDV2LyFh/MQKRZaMJTCffR39CK/Jr0TDThSIX6h1+s/ItmlGwAVBqR3pbrrH+JxRuy8aV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYjCU7pG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761986998; x=1793522998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9s/STQTxcc3k88CIQt95xpXMPCs3JdFq9Lp93ypc8O8=;
  b=UYjCU7pGpJP1l3jU4HLldrQnN84mI91fV0O0FwkYc81XsEI0lBvy2mNz
   D77lXisguHQjxGF0XPxCOJTDGy7Z5HD44AqgRUJPYdF+ta8RIlTFj/zbW
   GGYBqaygEpFMPDh+YH89iYUH1Ab9risdX9s17D2A1jZYS+MAHYU78ACDl
   DNBEYtRWH1Y4byquxXsq90R5q7IM/MfqQUD19i02FT7NryegAKfeO/gD2
   0kuuPqS74T1Kg/mI2OLenZQ9PZatdZIK2AQc9L0Vaz10CV8TVghqmgijd
   cciv+v0yeqf1hP/XIsMBjHKCwraMy+iCYxiGqzEgvowWp+oOy0th1Z1Sz
   w==;
X-CSE-ConnectionGUID: 4V9ithJURnm2z0g2fHNCPg==
X-CSE-MsgGUID: f5NHueueQLK9kgiehus+gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="51709718"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="51709718"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 01:49:57 -0700
X-CSE-ConnectionGUID: I0St/XsbSMKzNTm82JZ0YA==
X-CSE-MsgGUID: Z0R3c7DDRjq0Nctd+arFGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="190771097"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Nov 2025 01:49:55 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF7Im-000O3M-31;
	Sat, 01 Nov 2025 08:49:42 +0000
Date: Sat, 1 Nov 2025 16:49:04 +0800
From: kernel test robot <lkp@intel.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>,
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	Lee Jones <lee@kernel.org>, imx@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in NXP PF1550 PMIC MFD
 DRIVER
Message-ID: <202511011641.mVLMVN8V-lkp@intel.com>
References: <20251029104228.95498-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029104228.95498-1-lukas.bulwahn@redhat.com>

Hi Lukas,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251029]
[cannot apply to lee-leds/for-leds-next linus/master v6.18-rc3 v6.18-rc2 v6.18-rc1 v6.18-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukas-Bulwahn/MAINTAINERS-adjust-file-entry-in-NXP-PF1550-PMIC-MFD-DRIVER/20251029-184717
base:   next-20251029
patch link:    https://lore.kernel.org/r/20251029104228.95498-1-lukas.bulwahn%40redhat.com
patch subject: [PATCH] MAINTAINERS: adjust file entry in NXP PF1550 PMIC MFD DRIVER
config: powerpc-randconfig-002-20251101 (https://download.01.org/0day-ci/archive/20251101/202511011641.mVLMVN8V-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011641.mVLMVN8V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511011641.mVLMVN8V-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_task'; recompile with -fPIC
   >>> defined in vmlinux.a(init/init_task.o)
   >>> referenced by head_85xx.S:222 (arch/powerpc/kernel/head_85xx.S:222)
   >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x41a) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'init_task'; recompile with -fPIC
   >>> defined in vmlinux.a(init/init_task.o)
   >>> referenced by head_85xx.S:223 (arch/powerpc/kernel/head_85xx.S:223)
   >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x41e) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_thread_union'; recompile with -fPIC
   >>> defined in ./arch/powerpc/kernel/vmlinux.lds:146
   >>> referenced by head_85xx.S:230 (arch/powerpc/kernel/head_85xx.S:230)
   >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x42a) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

