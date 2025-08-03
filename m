Return-Path: <linux-kernel+bounces-754255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76066B19168
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 03:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259BB3BB725
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E50F2C1A2;
	Sun,  3 Aug 2025 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KroBnbXg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BD14F70
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754183945; cv=none; b=mO+CT9+fX+gL5mOf0xQttNOEjamI3MXXIwDm0CVqmXIFanfL3ElG4BwA0B2wVPAsEb7GZuAnFkUR7rxO8MMPdFBFXlmxIX7hBQPDkpScmTu1o6n5soBqSuoiYjPq0lQW86tWb8QtroUbbSToRGIixEG+zagE3lwzIJc4nSPD0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754183945; c=relaxed/simple;
	bh=ZDSZLb+ocL+4CdzQaRwarIKc/HAbTK5y4q9XjhqAvcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W5cqhfMw30kHqMJG9bbD++SbmB+7WwPuap9sebPchZcQkOjo2qKT+bnGyE/jH0kc3/UIeDDFpKHEZ14CSLs49V/mPoeCbsz739CZjxByON5FMJhVL+BO1/lBVodRUeOg2ALS4kDOlPDziilhf/AMtk0gxGFNs/41PERCmqWFjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KroBnbXg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754183944; x=1785719944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZDSZLb+ocL+4CdzQaRwarIKc/HAbTK5y4q9XjhqAvcU=;
  b=KroBnbXgcoyhwh/8unhNbNIbaSieyM3uQ3Uu8LV4sw/8riHAGVyMPOrJ
   zSpMQX69Os1XhU/JwtyoNtuD+N+XAWI2voJDlx/RyITN1avpVDvWFDv9S
   /0nBpaO3bX2cEdZP0S1oUEqABpXsoXl8PJLIprtAHnUVqYepTGIKccOOn
   awvMCIImYwcRrkKiP38eEO2+ct2/7wDWtI7KmT5Y9Ts6df/wwCpKCaAjl
   eaC+mqqcZL6jqfwNTrU1vEe0NcbUO+ZZFu7ZK7RlHkNfLpjRoXkqM0cnL
   xc0tm+mf8la+qJfmorWRKTEt6AkC52MO0P86LAgXjIj3pB35F1/QiAb7l
   Q==;
X-CSE-ConnectionGUID: nL8gFBrvTn6jiEn6ven6Dw==
X-CSE-MsgGUID: zOrdEBHxQ9mA0l16wJOCnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="56188859"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56188859"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 18:19:04 -0700
X-CSE-ConnectionGUID: O+bIlj9OQxaOdc+BcdY2hg==
X-CSE-MsgGUID: KM2kh2MZT+q11CzLMfDLHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163549293"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 02 Aug 2025 18:19:02 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiNNM-0005hk-09;
	Sun, 03 Aug 2025 01:19:00 +0000
Date: Sun, 3 Aug 2025 09:18:00 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Terrell <terrelln@meta.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/s390/include/uapi/../../../../lib/zstd/decompress/zstd_decompress_block.c:1987
 ZSTD_decompressSequencesLong() warn: inconsistent indenting
Message-ID: <202508030928.NddvBAsZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   186f3edfdd41f2ae87fc40a9ccba52a3bf930994
commit: 65d1f5507ed2c78c64fce40e44e5574a9419eb09 zstd: Import upstream v1.5.7
date:   5 months ago
config: s390-randconfig-r071-20250803 (https://download.01.org/0day-ci/archive/20250803/202508030928.NddvBAsZ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508030928.NddvBAsZ-lkp@intel.com/

New smatch warnings:
arch/s390/include/uapi/../../../../lib/zstd/decompress/zstd_decompress_block.c:1987 ZSTD_decompressSequencesLong() warn: inconsistent indenting

Old smatch warnings:
arch/s390/include/uapi/../../../../lib/zstd/decompress/huf_decompress.c:650 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/s390/include/uapi/../../../../lib/zstd/decompress/huf_decompress.c:650 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/s390/include/uapi/../../../../lib/zstd/decompress/huf_decompress.c:1431 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
arch/s390/include/uapi/../../../../lib/zstd/decompress/huf_decompress.c:1431 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
arch/s390/include/uapi/../../../../lib/zstd/decompress/zstd_decompress_block.c:941 ZSTD_execSequenceEnd() warn: inconsistent indenting
arch/s390/include/uapi/../../../../lib/zstd/decompress/zstd_decompress_block.c:990 ZSTD_execSequenceEndSplitLitBuffer() warn: inconsistent indenting
arch/s390/include/uapi/../../../../lib/zstd/decompress/zstd_decompress_block.c:1063 ZSTD_execSequence() warn: inconsistent indenting

vim +1987 arch/s390/include/uapi/../../../../lib/zstd/decompress/zstd_decompress_block.c

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

