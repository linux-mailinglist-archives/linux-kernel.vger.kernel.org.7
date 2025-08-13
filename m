Return-Path: <linux-kernel+bounces-766504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E876B24760
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E9B686A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF722F49F8;
	Wed, 13 Aug 2025 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvvRyy+A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522F2F49FB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081208; cv=none; b=VShR+k7/0ByCcjkV6E4zT6/VCgCsetR05/BSGmGX/NcAPoNXFnTSzvSNqV8qSDXlTrgtVSBpdRYinSYsdEkIXa4WVUebeeABaPqigeUxt0lx8pGtypNwVdvQ0BOfzlAYqXNnn28Twwi6rtcUMlHJLb0zuoK/OH+IuWUrDLFHgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081208; c=relaxed/simple;
	bh=RjqGqoR60AVhiOZbluu61XTmsTW3YUE9+mSjI8rI94g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OyWEUvFgffXZO+t9MF3uMhpberwDMiDE1+Wr+6e6vyFellULTm8kAHzqkMt9i+ZBqzuccysG+VpENkuL7aKtdhTqgEijV0WIWtf7kKm7RyuKH7PLf8mZJAr7vUFp2K9ZryHBKBHpfZHpBN3cfDfY+flGhp0aHDYkqESOlgDB2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvvRyy+A; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755081207; x=1786617207;
  h=date:from:to:cc:subject:message-id;
  bh=RjqGqoR60AVhiOZbluu61XTmsTW3YUE9+mSjI8rI94g=;
  b=RvvRyy+AEBAY6xWli20LfwGiUCIsTulnogJOC5huGPdeCtt6fcBBX4A2
   eoJI1r/9qoNtU4Z6S8mKerM4V/fcsiTHoE0sMDdFN6R/q9DALBb76k1y3
   yFOWbZOPDg9JeDlTU+Y2XrZswbt9D7EmLV0qyT9TyKEFIvIWI4mAwHb5k
   KtD0yLJDWeiCXHCVlQEnIjf8sgtF10uhasHIUotEmx9Lgw4i9PVsK3ez6
   zi75pOdXNRMzClzI2N+q3XPbKa41Bkh9zhcbxDTrhqzJABiGpWt4vmY87
   u1AxMEsLgmiqmV1Es49NjbRmgWHF4oWw36L/hOV1uF0P4aWktHPMCBILm
   Q==;
X-CSE-ConnectionGUID: 217qJlPlS42CjnuoWuy56Q==
X-CSE-MsgGUID: bNDFtuhySgehLWzGIAuWEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74817090"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74817090"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:33:27 -0700
X-CSE-ConnectionGUID: AcVBBA2GQEuQlp3l8F1VQw==
X-CSE-MsgGUID: Mi2lhfquRJu3XENuQuKoow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="171763067"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 13 Aug 2025 03:33:26 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1um8nE-0009my-21;
	Wed, 13 Aug 2025 10:33:19 +0000
Date: Wed, 13 Aug 2025 18:33:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 5eb1bcdb6a8c088514019c3a9bda5d565beed1af
Message-ID: <202508131853.8g0SGAnq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 5eb1bcdb6a8c088514019c3a9bda5d565beed1af  x86/sev: Improve handling of writes to intercepted TSC MSRs

elapsed time: 1273m

configs tested: 20
configs skipped: 118

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250812    gcc-12
i386    buildonly-randconfig-002-20250812    gcc-12
i386    buildonly-randconfig-003-20250812    gcc-12
i386    buildonly-randconfig-004-20250812    clang-20
i386    buildonly-randconfig-005-20250812    clang-20
i386    buildonly-randconfig-006-20250812    gcc-12
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250812    clang-20
x86_64  buildonly-randconfig-002-20250812    gcc-12
x86_64  buildonly-randconfig-003-20250812    gcc-12
x86_64  buildonly-randconfig-004-20250812    gcc-12
x86_64  buildonly-randconfig-005-20250812    clang-20
x86_64  buildonly-randconfig-006-20250812    gcc-12
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

