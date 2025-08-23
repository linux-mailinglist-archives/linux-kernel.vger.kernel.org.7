Return-Path: <linux-kernel+bounces-783297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F200B32B70
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 20:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9EF1C20236
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1972E62D3;
	Sat, 23 Aug 2025 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGyhRfbU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2961F17E8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755972460; cv=none; b=gexn8HPYJnbBt4PUe4ZVY4Gf2DpMGnSW1QjwRRmzMs1rtVql1eXuiDEvjiDqpqxCLXJr/1L7f9lpUZ6ZnVM870xgVQrINb5bNMRFd7qz04GVwYWJK9j5AOvoAiWXekaSoCXfXkmgDcC90lDs540aoGp9espAYKA4X/l1lVJ75QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755972460; c=relaxed/simple;
	bh=+znGQoKW3HyW4RCdhxAjAm3NcMbtUK3w40IV5pyywrU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mRgjtwpEEiv/AN3Sel6TmIuoGNTPeykulOTTy4SWfs1hI9obdrvg+YOSDa9XP4SysZR2yohwf9RP0UEKkRSqhuSKNxRaJxGtqIK4GfiATitk4XA001ZVaLvkGrZOFfhUMF08WHWHlWJhGOMfpPQjo19KdEIYypXfIU/hGRBoU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGyhRfbU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755972459; x=1787508459;
  h=date:from:to:cc:subject:message-id;
  bh=+znGQoKW3HyW4RCdhxAjAm3NcMbtUK3w40IV5pyywrU=;
  b=RGyhRfbU9KgrRyWzq7Wt02rT6OpEx9UlOFciU1PfznFN3v6BPY1OdkPv
   c7XtjeEurIUf7duToPjic5+UJl7f7/WN4dX4oJ2XWD69mGV/HzASazeXg
   x6RTtuPNApyPvt16+oIeYVOExz5YFm20c7u9MittJIl655AiXb7zBr/UH
   2eZg05RpphBQVdhFQG3dNhsVG+KYRuWZfyuhp+LwUhcJB/EWS/delSKq6
   NzQuPn4pA6KeF8ilMfb6+rdAvt1PHGPuNEGvDhtwHdGcmgtvBTuar2Dm8
   ElrzH0BygouAkmaCVWwp5k916iWKJf6V5wr++geoXBPgfKzASkjgobdQ1
   A==;
X-CSE-ConnectionGUID: Z5JCymcnTreQnkk2mpplnQ==
X-CSE-MsgGUID: UCwMZyW4R6eomVohouiceQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62076258"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62076258"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 11:07:35 -0700
X-CSE-ConnectionGUID: lJyR5k8cSaK+FNPS5spA3w==
X-CSE-MsgGUID: Jzc7pC7qTsCW4Dk9cu8Myg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168156078"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 23 Aug 2025 11:07:34 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upseK-000MUr-0d;
	Sat, 23 Aug 2025 18:07:32 +0000
Date: Sun, 24 Aug 2025 02:07:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 045f6a6e4dbaa0ecdee43bc2362676ff62ba5456
Message-ID: <202508240215.DWvS33iT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 045f6a6e4dbaa0ecdee43bc2362676ff62ba5456  x86/mtrr: Remove license boilerplate text with bad FSF address

elapsed time: 1447m

configs tested: 19
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386    buildonly-randconfig-001-20250823    clang-20
i386    buildonly-randconfig-002-20250823    clang-20
i386    buildonly-randconfig-003-20250823    clang-20
i386    buildonly-randconfig-004-20250823    clang-20
i386    buildonly-randconfig-005-20250823    clang-20
i386    buildonly-randconfig-006-20250823    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250823    gcc-12
x86_64  buildonly-randconfig-002-20250823    gcc-12
x86_64  buildonly-randconfig-003-20250823    clang-20
x86_64  buildonly-randconfig-004-20250823    clang-20
x86_64  buildonly-randconfig-005-20250823    gcc-12
x86_64  buildonly-randconfig-006-20250823    gcc-12
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

