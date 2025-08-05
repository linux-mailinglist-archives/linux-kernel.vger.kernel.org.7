Return-Path: <linux-kernel+bounces-756649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E416B1B735
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56ABB18A4A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE827A469;
	Tue,  5 Aug 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DV6vifOt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1227A44C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406732; cv=none; b=IBW1DW7CyFNW9SNbcUsOoZM9FFwIyDPYwi3JfvEi3BIYbEWXpvBIsezJ6XfW33d6oyvTYVyGj0reLV3x21IeRaVJtPTsxPQoD8MtBqI0Oa1dWIJiEGS5byltZ5ICF4UxA0S7H+VsMqi+9Z2MCRHGbE5FlBQ9xJMCgrniX0yeuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406732; c=relaxed/simple;
	bh=mdhnueASgKl0y+lHuxw3KdEgANEkTTFWl5SCJSHUY7I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GRvtuS39muUOtbTm5zGy85Hi0q1Di1OYPuTDTbJ/vNHBDKfD0DF6h2Rwo0oKIXTvEQ92R65i0XeOMbXqSZCBPeUvvtYcNuvQiqvhXDhJ9q3IvinPO/bNAMFMGW2jNeDHTuU8Fo2hGy5atxJh0B4t+lQPEQN4Jq1o2YHC8FpheTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DV6vifOt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754406731; x=1785942731;
  h=date:from:to:cc:subject:message-id;
  bh=mdhnueASgKl0y+lHuxw3KdEgANEkTTFWl5SCJSHUY7I=;
  b=DV6vifOtgu1Z18dqB4cSR0guA6ihHh+lLizJK5ypjTV3v6LjJ0Qj+B53
   IkK+VGEgrtBhDwzFoAUG1vkLoWjuCMup26sFJMTEiZzCvle5YDWLm9+oE
   eNEgYxz8hEVeABAB9vXAgYwbR1wMDyCV5eJ8tzAUH4IbVKU7EKq5H0oyM
   6DyIcRB7MQLp0CXlFL1LUoYUzdeCl5Bvq2HwIJ4cicWSXdca+HeE/vZJB
   IFgiyhUfCV9WoYladFsCUF6hx4hVkryWXNGs/gUEIEZs0G6qdIejbNocE
   BngjjHQzFrvUQzHgL1dYKja3O4o3lVyAf3HFSWeQGmIzWdH+pfJG/WlyF
   Q==;
X-CSE-ConnectionGUID: ErfUvtbDRH+dIQFmaa5bOA==
X-CSE-MsgGUID: ZMQgdgrOQoqxocPtQFTwcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56847348"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56847348"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 08:12:11 -0700
X-CSE-ConnectionGUID: GTzOQPkHSbeLroPWgZVZZA==
X-CSE-MsgGUID: cHOuULCNTyGbvPDwFMZPdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="163766741"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2025 08:12:09 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujJKc-0000dc-04;
	Tue, 05 Aug 2025 15:12:03 +0000
Date: Tue, 05 Aug 2025 23:11:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 ce0b5eedcb753697d43f61dd2e27d68eb5d3150f
Message-ID: <202508052319.R0Zr9oek-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: ce0b5eedcb753697d43f61dd2e27d68eb5d3150f  x86/irq: Plug vector setup race

elapsed time: 955m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250805    clang-20
i386    buildonly-randconfig-002-20250805    gcc-12
i386    buildonly-randconfig-003-20250805    gcc-12
i386    buildonly-randconfig-004-20250805    gcc-12
i386    buildonly-randconfig-005-20250805    gcc-12
i386    buildonly-randconfig-006-20250805    gcc-12
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250805    gcc-12
x86_64  buildonly-randconfig-002-20250805    gcc-12
x86_64  buildonly-randconfig-003-20250805    clang-20
x86_64  buildonly-randconfig-004-20250805    gcc-12
x86_64  buildonly-randconfig-005-20250805    clang-20
x86_64  buildonly-randconfig-006-20250805    gcc-12
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

