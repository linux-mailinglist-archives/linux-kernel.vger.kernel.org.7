Return-Path: <linux-kernel+bounces-896517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FCC508FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3927F3AB7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97429BD8C;
	Wed, 12 Nov 2025 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2lmwhfE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C876257835
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762923007; cv=none; b=LY1rG4jxexjz2KHggofGGxPPmr77RbIDsVeJDZvWXbZYAlWI/yjmxUcLh9glzWVLIpkZW5QKQGWsmVLWM7n+zi6exMOyRxY5WZiQ+Lc81fbEEYUjLevWITBxvShzGHVouI3x9+l6b1egIINkEDHVm00Zuh66csAFTxnnDe7qxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762923007; c=relaxed/simple;
	bh=iQzLTptlm+78QXRRW1umaVBM/mH1CXfb1UqJ4jsCy4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XWenjAb2TFWoX8dtUXR+h7+J7MD5vhAKkml4bEd1ed45nphpjN00VjUETbS9tlRu7onSxbw86uLXPkOyB6CnbRsZp5Tm9Q5UjAZicPPRdzszDPFzEl+vAnReXH8cvgk0W5ovEEVWpWSjgQj7jFvkR2mc8IAUsk+IciQfXc3qHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2lmwhfE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762923005; x=1794459005;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iQzLTptlm+78QXRRW1umaVBM/mH1CXfb1UqJ4jsCy4I=;
  b=h2lmwhfEjf6WXJpnNo0mXyk8pyJDIoUApvALkMxc8uAKkwSvU2NkR94i
   FdAoARXLxfhxpNFlj3JMPlIDCOwMj/p6QTM1siPOwisgaom4TVRFQ7lxR
   GHpFxXdDbESEfPS8whgpSXwuRe3lY1bI5vCXtqvf1Zo5Vh3K5EyQYfTTl
   YHVI/17efk3PIqQQgsROiJBaJ9tHsjZGPcocP208xUJsKV7Ua/VD7Xku8
   DEEWBN9EphmvYaisFv5UJig5/k6fzXeTTi+j8xxwRjX/Vp7ZFWGltiuR9
   WuHI/QT0ooMJf94NuIOoitCYHxXNSJ3Zg0nt+oQmzmlBPBzBCBwACfmXk
   g==;
X-CSE-ConnectionGUID: N+o4YTIERkqQUF/KTuP4MA==
X-CSE-MsgGUID: EouxkTl1ReCZnedibFOLlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64862683"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="64862683"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 20:50:05 -0800
X-CSE-ConnectionGUID: gyROaRCGRPmEh3Gv6zWzJg==
X-CSE-MsgGUID: GnVI9Jq5QEudGhbI2/I22A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="219847813"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Nov 2025 20:50:04 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJ2nx-0003qI-2I;
	Wed, 12 Nov 2025 04:50:01 +0000
Date: Wed, 12 Nov 2025 12:49:48 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Terrell <terrelln@meta.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/mips/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1987
 ZSTD_decompressSequencesLong() warn: inconsistent indenting
Message-ID: <202511121211.tqTlfLkK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   24172e0d79900908cf5ebf366600616d29c9b417
commit: 65d1f5507ed2c78c64fce40e44e5574a9419eb09 zstd: Import upstream v1.5.7
date:   8 months ago
config: mips-randconfig-r073-20251112 (https://download.01.org/0day-ci/archive/20251112/202511121211.tqTlfLkK-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 996639d6ebb86ff15a8c99b67f1c2e2117636ae7)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511121211.tqTlfLkK-lkp@intel.com/

New smatch warnings:
arch/mips/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1987 ZSTD_decompressSequencesLong() warn: inconsistent indenting

Old smatch warnings:
arch/mips/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:650 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/mips/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:650 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/mips/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:1431 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
arch/mips/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:1431 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
arch/mips/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:941 ZSTD_execSequenceEnd() warn: inconsistent indenting
arch/mips/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:990 ZSTD_execSequenceEndSplitLitBuffer() warn: inconsistent indenting
arch/mips/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1063 ZSTD_execSequence() warn: inconsistent indenting

vim +1987 arch/mips/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c

  1967	
  1968	
  1969	#ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
  1970	/* ZSTD_decompressSequencesLong() :
  1971	 * decompression function triggered when a minimum share of offsets is considered "long",
  1972	 * aka out of cache.
  1973	 * note : "long" definition seems overloaded here, sometimes meaning "wider than bitstream register", and sometimes meaning "farther than memory cache distance".
  1974	 * This function will try to mitigate main memory latency through the use of prefetching */
  1975	static size_t
  1976	ZSTD_decompressSequencesLong(ZSTD_DCtx* dctx,
  1977	                             void* dst, size_t maxDstSize,
  1978	                             const void* seqStart, size_t seqSize, int nbSeq,
  1979	                             const ZSTD_longOffset_e isLongOffset)
  1980	{
  1981	    DEBUGLOG(5, "ZSTD_decompressSequencesLong");
  1982	#if DYNAMIC_BMI2
  1983	    if (ZSTD_DCtx_get_bmi2(dctx)) {
  1984	        return ZSTD_decompressSequencesLong_bmi2(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset);
  1985	    }
  1986	#endif
> 1987	  return ZSTD_decompressSequencesLong_default(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset);
  1988	}
  1989	#endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT */
  1990	
  1991	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

