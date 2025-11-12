Return-Path: <linux-kernel+bounces-897857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2361C53D09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886683A89D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2A347FCA;
	Wed, 12 Nov 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OU0Od5ja"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA8346E66
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969827; cv=none; b=HtEI5v4TdwRGa5hm2qjmDmdGOwgMbxZXRjnTlb9P5H3tfQuXkCESbk+4A5dBUmUOPiJz6Ym4NZIOcUtCs+TbYNv1FLR059k6x0cOJZB/rDidY48Q49eq8HXIM8rykahSJ8U4e1IWP8PESRGOTAwv2SiE8zdoxSE7hBHcaq6wJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969827; c=relaxed/simple;
	bh=+cAG+ko5uM8TEZvbuwYzPAx3F/UlyZhqlO1nIWyAXms=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GVC/AjR7RAbvbz1sm5aFjOzIj6bvk1v8s0yQNwwupVWSdBbnqc/U6GT+OWgVDwkCF3WW6ffpMVEnGEnYINjaoj4iEWjP2IrhscW/zx9dK0u+gQC+9eoFiZLNzaPRqnAtfuUmgD1vGpklER/nwBDSvUyauQBdzyIhbbdUNMLmbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OU0Od5ja; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762969825; x=1794505825;
  h=date:from:to:cc:subject:message-id;
  bh=+cAG+ko5uM8TEZvbuwYzPAx3F/UlyZhqlO1nIWyAXms=;
  b=OU0Od5jaNDlqfSCAeEfcVVDlP6nrw3jCfaRkOHEPoiFKOF6gI7MFIL5u
   kgRH7UUWyfooSBbQ2DHJhYSwd1epoJJO/Ima1YnByMJFc6OSJbRAsS167
   PgBxNiyGKWmMigAEX19hU56T98OWRycbnjPekRSoytWV2nfakjBKuigBJ
   3pdKWwV/XSOaGGlA8LKB4loOpdScO+QJy4xBukNfvPrD0ey6gnOdlIRue
   mO1y0PxeH5zDGLLVfGReX8nNEX1zFnbMFtZwI51PdicU4W9jr5OXhoQHd
   FMR1WarA9t5kQux5gyJPoqEaAQzxKBAs7XPPhMtRtpKzglK5za4ncSHMG
   w==;
X-CSE-ConnectionGUID: btKxEa1yRnSlZ7EinmInKA==
X-CSE-MsgGUID: Pg4QgEwiRPaXAOTMAxTySw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64946929"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="64946929"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 09:50:24 -0800
X-CSE-ConnectionGUID: DoTIOdbwSx2CCkmAu9bfQw==
X-CSE-MsgGUID: xD0xGCeQTHaCXmjwc+GJ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="194472007"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Nov 2025 09:50:24 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJEz7-0004Uu-2k;
	Wed, 12 Nov 2025 17:50:21 +0000
Date: Thu, 13 Nov 2025 01:49:57 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 b2c1dd6c6f70a5a519532227358c82d4cfda5b36
Message-ID: <202511130152.hw4QVtXJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: b2c1dd6c6f70a5a519532227358c82d4cfda5b36  x86/coco/sev: Convert has_cpuflag() to use cpu_feature_enabled()

elapsed time: 1541m

configs tested: 35
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
i386    buildonly-randconfig-001-20251112    clang-20
i386    buildonly-randconfig-002-20251112    gcc-14
i386    buildonly-randconfig-003-20251112    clang-20
i386    buildonly-randconfig-004-20251112    clang-20
i386    buildonly-randconfig-005-20251112    gcc-13
i386    buildonly-randconfig-006-20251112    clang-20
i386              randconfig-001-20251112    gcc-14
i386              randconfig-002-20251112    gcc-14
i386              randconfig-003-20251112    gcc-14
i386              randconfig-004-20251112    clang-20
i386              randconfig-005-20251112    clang-20
i386              randconfig-006-20251112    clang-20
i386              randconfig-007-20251112    gcc-13
i386              randconfig-011-20251112    gcc-14
i386              randconfig-012-20251112    gcc-14
i386              randconfig-013-20251112    clang-20
i386              randconfig-014-20251112    clang-20
i386              randconfig-015-20251112    clang-20
i386              randconfig-016-20251112    gcc-14
i386              randconfig-017-20251112    clang-20
x86_64                        allnoconfig    clang-20
x86_64  buildonly-randconfig-001-20251112    clang-20
x86_64  buildonly-randconfig-002-20251112    clang-20
x86_64  buildonly-randconfig-003-20251112    clang-20
x86_64  buildonly-randconfig-004-20251112    clang-20
x86_64  buildonly-randconfig-005-20251112    gcc-14
x86_64  buildonly-randconfig-006-20251112    gcc-14
x86_64                          defconfig    gcc-14
x86_64            randconfig-011-20251112    clang-20
x86_64            randconfig-012-20251112    gcc-14
x86_64            randconfig-013-20251112    gcc-14
x86_64            randconfig-014-20251112    clang-20
x86_64            randconfig-015-20251112    clang-20
x86_64            randconfig-016-20251112    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

