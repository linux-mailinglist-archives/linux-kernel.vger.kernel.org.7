Return-Path: <linux-kernel+bounces-737150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6C6B0A869
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B62D47B2FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493822E62AE;
	Fri, 18 Jul 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMZsfzoN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD52E54BC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856057; cv=none; b=q/jrc33iG99iGZQnKVuaMkx8SNS7qv0Vu1pWLTRmlxxjXMTrTx+E1mRWC9LYj0drJS7f4XbJpvXqxlAEM93Ym+7ijsDQeIoCPIS8gvWk2608TpQC1osePsLqZ0cLRoLRpMnSfRVYuZGC73dw1e8gWJG5HPmwO+LT+bUm9n95EB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856057; c=relaxed/simple;
	bh=sgPMbwJvnaL1alGhdQ3Wko/dR2pBLFkjVgHr0eRTfR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjlbZCqgIinSWyUlmwBQCW5cXnrq2X9LpA10tTekHb3/mi70u6VASpKX64JtvjhrdPjDXf2nzabSq78DZnBlxAKY1sZvn0B2TGdus7eMEsEGo35oUm3gPwsvZEFVZqcWzS097mhl3ETnG5cSBkD0ERCyOu7aLQQONZXTRr5dYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMZsfzoN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752856055; x=1784392055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sgPMbwJvnaL1alGhdQ3Wko/dR2pBLFkjVgHr0eRTfR8=;
  b=QMZsfzoNGAyAjm887AT7hf21lsa8FgjdmXFVb5KfM7KVJT+gRBOCXm7M
   hn6S8vzhK2Bhj5D7LlGmCR9vPU97CWbx90+CbDEVfGnLq4w9rwdR1ih0b
   d4IADZuuJCr5/JGvbVAtpuK3Jkb3LVTTztBkymMaiJb56DdqGzFxpQ8Qb
   pXCGbj2VtkCJjg/vAaTENsHb4NQKk3ArIUPAv2GhmsuxCKIBqeFeWj1Ad
   X7sf2j0ecYG2bOUbskIOPqEBEq0ero6gTU4qAIdayBkvv1OJVWuVHwDlI
   x0ThmB0ndkjjoTP6HaUJp9InuaiGTIrnXdakoOhOR/ph9gVZUm9BnIszx
   Q==;
X-CSE-ConnectionGUID: AAhP+J4kTPyHKdPpH6nLAw==
X-CSE-MsgGUID: zBVhytbbRLui8FHtuMKmWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55009647"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55009647"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 09:27:34 -0700
X-CSE-ConnectionGUID: 6So0Y9EzRUmt2UAE95XL+g==
X-CSE-MsgGUID: HlQsLTziQVqSbrkQhss03Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="195228715"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Jul 2025 09:27:32 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucnvl-000EqZ-0L;
	Fri, 18 Jul 2025 16:27:29 +0000
Date: Sat, 19 Jul 2025 00:26:55 +0800
From: kernel test robot <lkp@intel.com>
To: Ignacio Encinas <ignacio@iencinas.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ignacio Encinas <ignacio@iencinas.com>
Subject: Re: [PATCH v5] riscv: introduce asm/swab.h
Message-ID: <202507190051.ejnrjSs3-lkp@intel.com>
References: <20250717-riscv-swab-v5-1-1d5bb7c42f38@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-riscv-swab-v5-1-1d5bb7c42f38@iencinas.com>

Hi Ignacio,

kernel test robot noticed the following build errors:

[auto build test ERROR on 155a3c003e555a7300d156a5252c004c392ec6b0]

url:    https://github.com/intel-lab-lkp/linux/commits/Ignacio-Encinas/riscv-introduce-asm-swab-h/20250718-024715
base:   155a3c003e555a7300d156a5252c004c392ec6b0
patch link:    https://lore.kernel.org/r/20250717-riscv-swab-v5-1-1d5bb7c42f38%40iencinas.com
patch subject: [PATCH v5] riscv: introduce asm/swab.h
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20250719/202507190051.ejnrjSs3-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507190051.ejnrjSs3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507190051.ejnrjSs3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/decompress_unlzo.c:28:
   In file included from include/linux/decompress/mm.h:79:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:53:9: warning: unknown option, expected 'push', 'pop', 'rvc', 'norvc', 'relax' or 'norelax' [-Winline-asm]
           return ARCH_SWAB(16, value);
                  ^
   arch/riscv/include/asm/swab.h:40:11: note: expanded from macro 'ARCH_SWAB'
                                 ".option arch,+zbb\n"                     \
                                  ^
   <inline asm>:2:9: note: instantiated into assembly here
   .option arch,+zbb
           ^
   In file included from lib/decompress_unlzo.c:28:
   In file included from include/linux/decompress/mm.h:79:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
>> arch/riscv/include/asm/swab.h:53:9: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
           return ARCH_SWAB(16, value);
                  ^
   arch/riscv/include/asm/swab.h:41:11: note: expanded from macro 'ARCH_SWAB'
                                 "rev8 %0, %1\n"                           \
                                  ^
   <inline asm>:3:1: note: instantiated into assembly here
   rev8 a0, s1
   ^
   In file included from lib/decompress_unlzo.c:28:
   In file included from include/linux/decompress/mm.h:79:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:58:9: warning: unknown option, expected 'push', 'pop', 'rvc', 'norvc', 'relax' or 'norelax' [-Winline-asm]
           return ARCH_SWAB(32, value);
                  ^
   arch/riscv/include/asm/swab.h:40:11: note: expanded from macro 'ARCH_SWAB'
                                 ".option arch,+zbb\n"                     \
                                  ^
   <inline asm>:2:9: note: instantiated into assembly here
   .option arch,+zbb
           ^
   In file included from lib/decompress_unlzo.c:28:
   In file included from include/linux/decompress/mm.h:79:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:58:9: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
           return ARCH_SWAB(32, value);
                  ^
   arch/riscv/include/asm/swab.h:41:11: note: expanded from macro 'ARCH_SWAB'
                                 "rev8 %0, %1\n"                           \
                                  ^
   <inline asm>:3:1: note: instantiated into assembly here
   rev8 a0, s1
   ^
   In file included from lib/decompress_unlzo.c:28:
   In file included from include/linux/decompress/mm.h:79:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:58:9: warning: unknown option, expected 'push', 'pop', 'rvc', 'norvc', 'relax' or 'norelax' [-Winline-asm]
           return ARCH_SWAB(32, value);
                  ^
   arch/riscv/include/asm/swab.h:40:11: note: expanded from macro 'ARCH_SWAB'
                                 ".option arch,+zbb\n"                     \
                                  ^
   <inline asm>:2:9: note: instantiated into assembly here
   .option arch,+zbb
           ^
   In file included from lib/decompress_unlzo.c:28:
   In file included from include/linux/decompress/mm.h:79:
--
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:58:9: warning: unknown option, expected 'push', 'pop', 'rvc', 'norvc', 'relax' or 'norelax' [-Winline-asm]
           return ARCH_SWAB(32, value);
                  ^
   arch/riscv/include/asm/swab.h:40:11: note: expanded from macro 'ARCH_SWAB'
                                 ".option arch,+zbb\n"                     \
                                  ^
   <inline asm>:2:9: note: instantiated into assembly here
   .option arch,+zbb
           ^
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:13:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:58:9: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
           return ARCH_SWAB(32, value);
                  ^
   arch/riscv/include/asm/swab.h:41:11: note: expanded from macro 'ARCH_SWAB'
                                 "rev8 %0, %1\n"                           \
                                  ^
   <inline asm>:3:1: note: instantiated into assembly here
   rev8 a0, s7
   ^
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:13:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:53:9: warning: unknown option, expected 'push', 'pop', 'rvc', 'norvc', 'relax' or 'norelax' [-Winline-asm]
           return ARCH_SWAB(16, value);
                  ^
   arch/riscv/include/asm/swab.h:40:11: note: expanded from macro 'ARCH_SWAB'
                                 ".option arch,+zbb\n"                     \
                                  ^
   <inline asm>:2:9: note: instantiated into assembly here
   .option arch,+zbb
           ^
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:13:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
>> arch/riscv/include/asm/swab.h:53:9: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
           return ARCH_SWAB(16, value);
                  ^
   arch/riscv/include/asm/swab.h:41:11: note: expanded from macro 'ARCH_SWAB'
                                 "rev8 %0, %1\n"                           \
                                  ^
   <inline asm>:3:1: note: instantiated into assembly here
   rev8 a0, s2
   ^
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:13:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:53:9: warning: unknown option, expected 'push', 'pop', 'rvc', 'norvc', 'relax' or 'norelax' [-Winline-asm]
           return ARCH_SWAB(16, value);
                  ^
   arch/riscv/include/asm/swab.h:40:11: note: expanded from macro 'ARCH_SWAB'
                                 ".option arch,+zbb\n"                     \
                                  ^
   <inline asm>:2:9: note: instantiated into assembly here
   .option arch,+zbb
           ^
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:13:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
>> arch/riscv/include/asm/swab.h:53:9: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
           return ARCH_SWAB(16, value);
                  ^
   arch/riscv/include/asm/swab.h:41:11: note: expanded from macro 'ARCH_SWAB'
                                 "rev8 %0, %1\n"                           \
                                  ^
   <inline asm>:3:1: note: instantiated into assembly here
   rev8 a0, s2
   ^
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:13:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:58:9: warning: unknown option, expected 'push', 'pop', 'rvc', 'norvc', 'relax' or 'norelax' [-Winline-asm]
           return ARCH_SWAB(32, value);
                  ^
   arch/riscv/include/asm/swab.h:40:11: note: expanded from macro 'ARCH_SWAB'
                                 ".option arch,+zbb\n"                     \
                                  ^
   <inline asm>:2:9: note: instantiated into assembly here
   .option arch,+zbb
           ^
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:13:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:58:9: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
           return ARCH_SWAB(32, value);
                  ^
   arch/riscv/include/asm/swab.h:41:11: note: expanded from macro 'ARCH_SWAB'
                                 "rev8 %0, %1\n"                           \
                                  ^
   <inline asm>:3:1: note: instantiated into assembly here
   rev8 a0, s1
   ^
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:13:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
   arch/riscv/include/asm/swab.h:53:9: warning: unknown option, expected 'push', 'pop', 'rvc', 'norvc', 'relax' or 'norelax' [-Winline-asm]
           return ARCH_SWAB(16, value);
                  ^
   arch/riscv/include/asm/swab.h:40:11: note: expanded from macro 'ARCH_SWAB'
                                 ".option arch,+zbb\n"                     \
                                  ^
   <inline asm>:2:9: note: instantiated into assembly here
   .option arch,+zbb
           ^
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:13:
   In file included from include/linux/kernel.h:23:
   In file included from include/linux/bitops.h:28:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/riscv/include/asm/barrier.h:14:
   In file included from arch/riscv/include/asm/cmpxchg.h:9:
   In file included from include/linux/bug.h:5:
   In file included from arch/riscv/include/asm/bug.h:83:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/ratelimit_types.h:7:
   In file included from include/linux/spinlock_types_raw.h:7:
   In file included from ./arch/riscv/include/generated/asm/spinlock_types.h:1:
   In file included from include/asm-generic/spinlock_types.h:7:
   In file included from include/asm-generic/qrwlock_types.h:6:
   In file included from arch/riscv/include/uapi/asm/byteorder.h:10:
   In file included from include/linux/byteorder/little_endian.h:5:
   In file included from include/uapi/linux/byteorder/little_endian.h:14:
   In file included from include/linux/swab.h:5:
   In file included from include/uapi/linux/swab.h:8:
>> arch/riscv/include/asm/swab.h:53:9: error: instruction requires the following: 'Zbb' (Basic Bit-Manipulation) or 'Zbkb' (Bitmanip instructions for Cryptography)
           return ARCH_SWAB(16, value);
                  ^
   arch/riscv/include/asm/swab.h:41:11: note: expanded from macro 'ARCH_SWAB'
                                 "rev8 %0, %1\n"                           \
                                  ^
   <inline asm>:3:1: note: instantiated into assembly here
   rev8 s1, s1
   ^
   7 warnings and 7 errors generated.
..


vim +53 arch/riscv/include/asm/swab.h

    50	
    51	static __always_inline __u16 __arch_swab16(__u16 value)
    52	{
  > 53		return ARCH_SWAB(16, value);
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

