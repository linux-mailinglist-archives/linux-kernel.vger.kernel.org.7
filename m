Return-Path: <linux-kernel+bounces-732760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FC1B06BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D433AC54F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE3274FD8;
	Wed, 16 Jul 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ew1UfAeT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449C2270EBD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752634631; cv=none; b=BAIgHu0tMt22mqHYH/oOExIWB0z718iiyi8F1I4ep8V42j+oQRw3uzChkzbIrX5Na0umbXJmxfEicQMaaiFw8B0mkSdJUg2Yhn2+G3GI+ovZSLfLHqbx6musfccwY39q4/uRDv26TODtK8/u8FdtAUdW1o/oD5x6Pj45+278BRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752634631; c=relaxed/simple;
	bh=Z83NVETW4YBqk9CNIwmG5ZeJMxr5MoWy8pGEcVFhEFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GnngP77rQ0dLWBU4Vx5wWdK3K1MnQWigQI+EMS9me0Z/2ZYh2blR+4vGhVxAQYF5z6kD9Hoq42Pf97tyFYWEKnTA95FvtpqPeLMVh/CmMO/vCH12eW1M4h1QdrIaZl9KABzBk5KDG99V7zf0jTp+tSCjmr9rg+GNk95RRyGFg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ew1UfAeT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752634630; x=1784170630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z83NVETW4YBqk9CNIwmG5ZeJMxr5MoWy8pGEcVFhEFQ=;
  b=ew1UfAeTcGhtEwYVvTj/lC1jZrT9C0SKnso6YGncm+vMfzu/gKGrttsy
   i1J2/sd3GW9q3vqjjrxxf0op9fC1nyFMWsVoK1QBLFN250zpqtz/gBp11
   0n5vRw684m/wNIVzDkb/Qkfpd8zw0OfqFPHgFFPBILjyUVBfC/GByKW37
   kKkqgG8EwvyrVnDAkWYZN7NBIKNAuTu0hrsWrTIZebDMr841liEV4NrXk
   y/zocizaC8WfuzgX8XXqp7C9EWhbB0Dt051AVCOwUkZO6FmcYFz9/ZBz5
   j/9f9gP6iCpnde59QYD+wIpW8WaL0xQqCBEaNRi6ho3RtLgoFssGFjRO4
   A==;
X-CSE-ConnectionGUID: oZbuwknqRRWqSLDR8os3FA==
X-CSE-MsgGUID: fgwu1/xARuGX4BzxYJBV1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55014042"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="55014042"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:57:10 -0700
X-CSE-ConnectionGUID: rG9VEo0cS/e5GvWRpABN0Q==
X-CSE-MsgGUID: lvqDJUIDRWi7VASR3UqW4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157475896"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jul 2025 19:57:08 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubsKQ-000BoH-15;
	Wed, 16 Jul 2025 02:57:06 +0000
Date: Wed, 16 Jul 2025 10:56:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>
Subject: ld.lld: error: undefined symbol: crypto_req_done
Message-ID: <202507161032.QholMPtn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   155a3c003e555a7300d156a5252c004c392ec6b0
commit: b4a29efc51461edf1a02e9da656d4480cabd24b0 erofs: support DEFLATE decompression by using Intel QAT
date:   7 weeks ago
config: mips-randconfig-r054-20250716 (https://download.01.org/0day-ci/archive/20250716/202507161032.QholMPtn-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507161032.QholMPtn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507161032.QholMPtn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: crypto_req_done
   >>> referenced by decompressor_crypto.c
   >>>               fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
   >>> referenced by decompressor_crypto.c
   >>>               fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: crypto_acomp_decompress
   >>> referenced by decompressor_crypto.c
   >>>               fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: crypto_alloc_acomp
   >>> referenced by decompressor_crypto.c
   >>>               fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

