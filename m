Return-Path: <linux-kernel+bounces-884816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD71C3138F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B956188DD6D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208D2DF13E;
	Tue,  4 Nov 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma01gJio"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753F2FB99C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262816; cv=none; b=PiP/yBeo0WGozycd2iCzIe9EnmJpEtdeDQ9nQT+OXwrsxQezjyHwvWPCd2vjTqNGMuaooKYbBPfs2CwLZipRaASkidx/KTJVE6SaOPe3P5v3BtCPPrKZRla05CUOo3V3i7U8/DI4I3iSAcPm3oJTv+pWMUWPd/QEvFrGKDJobc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262816; c=relaxed/simple;
	bh=F74OLeSmrW0D6mi+O/1ODpediCxwIMxbpnxzFvQ2tj4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kMtmt7ocvU4VRUzCPxhszHQD2xI83GCCgV4SoUK/Pe7/rPlf0AM6iJpBnonpwcYsnwxCP7BhOwa5yr1EVHKozI2hBWuKr5LWKRPHjgwfr/oxuarbrwT31r0voJiIOEPw+9R2BwjpHHnA9lolKQgbr3CeIKXodO5t2Y40aV40ziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma01gJio; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762262814; x=1793798814;
  h=date:from:to:cc:subject:message-id;
  bh=F74OLeSmrW0D6mi+O/1ODpediCxwIMxbpnxzFvQ2tj4=;
  b=Ma01gJiopDJciG51tonurD+zQTvQNigu0KVCYDL6GMr2Hxae6ZmmABp1
   AmM5hPXX6oLwKzFvuD8fuPn9IF91HG80iMVPYIw/1BmdslrPePQ4T8H5f
   NBGZR6VXvz/bhriTLEMlrzzWfPZwu9g8WYlVMuTBQNeJOMwdpRu9tk66R
   nHhi2UMvZL+jHLeQhFOPYAqTlTSAVxQh/60Z1u5qASuxekWutT8jUgr+1
   qtNRfa0Q2oK3nKhDh94p4IUx+D3Mm/vXNPvuVFpj3e4HOMUZUEimSvuJw
   2H+JWIDZynKk5B2pNYf5bnmhHaEuN3EzWk1IIHRrMUw5ynWL1xTDTaZav
   w==;
X-CSE-ConnectionGUID: EXmKrJx2TRywCaX5zVgXQg==
X-CSE-MsgGUID: jidUxQJaTlGBkQUPZvuyYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75805411"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="75805411"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 05:26:54 -0800
X-CSE-ConnectionGUID: RmStsEU2TaKhS+zVlrX9xA==
X-CSE-MsgGUID: pGuP9qViTm6Z3dTi+taLyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191509480"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 04 Nov 2025 05:26:53 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGH2v-000RR0-1A;
	Tue, 04 Nov 2025 13:26:16 +0000
Date: Tue, 04 Nov 2025 21:24:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0a4b61d9c2e496b5f0a10e29e355a1465c8738bb
Message-ID: <202511042154.oh0N0iSH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 0a4b61d9c2e496b5f0a10e29e355a1465c8738bb  x86/amd_node: Fix AMD root device caching

elapsed time: 1464m

configs tested: 48
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
i386    buildonly-randconfig-001-20251104    gcc-14
i386    buildonly-randconfig-002-20251104    clang-20
i386    buildonly-randconfig-003-20251104    gcc-12
i386    buildonly-randconfig-004-20251104    gcc-14
i386    buildonly-randconfig-005-20251104    gcc-12
i386    buildonly-randconfig-006-20251104    gcc-14
i386                            defconfig    clang-20
i386              randconfig-001-20251104    gcc-12
i386              randconfig-002-20251104    gcc-14
i386              randconfig-003-20251104    clang-20
i386              randconfig-004-20251104    gcc-14
i386              randconfig-005-20251104    gcc-14
i386              randconfig-006-20251104    gcc-14
i386              randconfig-007-20251104    gcc-14
i386              randconfig-011-20251104    gcc-13
i386              randconfig-012-20251104    clang-20
i386              randconfig-013-20251104    gcc-14
i386              randconfig-014-20251104    clang-20
i386              randconfig-015-20251104    gcc-14
i386              randconfig-016-20251104    clang-20
i386              randconfig-017-20251104    clang-20
x86_64                        allnoconfig    clang-20
x86_64  buildonly-randconfig-001-20251104    clang-20
x86_64  buildonly-randconfig-002-20251104    gcc-12
x86_64  buildonly-randconfig-003-20251104    gcc-14
x86_64  buildonly-randconfig-004-20251104    gcc-14
x86_64  buildonly-randconfig-005-20251104    gcc-12
x86_64  buildonly-randconfig-006-20251104    clang-20
x86_64                          defconfig    gcc-14
x86_64            randconfig-001-20251104    gcc-14
x86_64            randconfig-002-20251104    clang-20
x86_64            randconfig-003-20251104    gcc-13
x86_64            randconfig-004-20251104    clang-20
x86_64            randconfig-005-20251104    clang-20
x86_64            randconfig-006-20251104    gcc-14
x86_64            randconfig-011-20251104    gcc-14
x86_64            randconfig-012-20251104    gcc-14
x86_64            randconfig-013-20251104    clang-20
x86_64            randconfig-014-20251104    clang-20
x86_64            randconfig-015-20251104    gcc-14
x86_64            randconfig-016-20251104    clang-20
x86_64            randconfig-071-20251104    clang-20
x86_64            randconfig-072-20251104    clang-20
x86_64            randconfig-073-20251104    clang-20
x86_64            randconfig-074-20251104    gcc-14
x86_64            randconfig-075-20251104    clang-20
x86_64            randconfig-076-20251104    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

