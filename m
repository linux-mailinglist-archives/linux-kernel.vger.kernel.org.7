Return-Path: <linux-kernel+bounces-815532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5009B567C7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0464D189689A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CA8244667;
	Sun, 14 Sep 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcHt/0tQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313E23C4FF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757845699; cv=none; b=HuN4dvUG3PjP2wfVl0u198p53ppHzBr8Z9j3ySNLeVmr5cnSec8/02fJnvpUievIBSrz50bXjIIIS8auhU1l53O3G6WB+5UnB/MGpuVFGmyjZXY4oGUPQDUrAYTTD00IeqPy69h+OSRxpOaUSStKhdruFIktWU8AWYKqpLsrPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757845699; c=relaxed/simple;
	bh=mqMgnkt/y682uPPyraj/Cbvv35maq2jz4ywZFINXozw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pMYRrtAI0DJP0bEotM5fm/LgY6OaqHMAD1JfUfMFtssyFSF2Fy3sHPNK3dCI9k8Bw40dEV7khyMJvT069b3j1ucYSruTNhZaE5CMxcENjum60AQFDvqUpQYqYuevNspJkd03e8foKdxrUWzjU5LdX358cjxXmAIEW/EzjuGwEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcHt/0tQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757845698; x=1789381698;
  h=date:from:to:cc:subject:message-id;
  bh=mqMgnkt/y682uPPyraj/Cbvv35maq2jz4ywZFINXozw=;
  b=mcHt/0tQZXTAv+L6mWETPuKYxOyc9C6YXZVd5Jzel0X4IHZpCas4g1it
   SbN928cPOLyODEnI1REEpOJuULPSzWY2kek7BozibYIVXUTLxWs5p2pF4
   U4k8JGWctF0NRuu/0e3h8gU2340Vfp5N3Eb8RElgexfKPIAAhTSPBY5bD
   3hhR7J1Kwf9ef4PrpLIu/BLADnwcPcS1rYKJVb00l0nujnHH1ZsTGxzgW
   8SXOi4Xg1kPUWdnFDsDFSozN1Y80dLxuZmeeTHVlnIx4qV5ouNfkbKtz7
   HB/KwfSFpYgcjN6KvxXBYfWT1LeI8cXdos68Y4xkmbizFECFxnxU5/R6o
   g==;
X-CSE-ConnectionGUID: QuUeXbiQQTOIYO8ODdfqXw==
X-CSE-MsgGUID: zUhBO/VJROKCOmWpGBWhOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="77577535"
X-IronPort-AV: E=Sophos;i="6.18,263,1751266800"; 
   d="scan'208";a="77577535"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 03:28:17 -0700
X-CSE-ConnectionGUID: mfo1fR6RSSelYVHe9tRNig==
X-CSE-MsgGUID: lu5Fm2qPQGyxH4Kc3bxQgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,263,1751266800"; 
   d="scan'208";a="205163530"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Sep 2025 03:28:17 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxjxu-0002KA-0e;
	Sun, 14 Sep 2025 10:28:14 +0000
Date: Sun, 14 Sep 2025 18:27:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 28e82d6f03b0626f78e0a2719eca9fbf43f26855
Message-ID: <202509141833.SznLRpz4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 28e82d6f03b0626f78e0a2719eca9fbf43f26855  x86/mce: Save and use APEI corrected threshold limit

elapsed time: 872m

configs tested: 20
configs skipped: 118

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-14
i386                          allnoconfig    gcc-14
i386                         allyesconfig    gcc-14
i386    buildonly-randconfig-001-20250914    gcc-13
i386    buildonly-randconfig-002-20250914    gcc-14
i386    buildonly-randconfig-003-20250914    gcc-14
i386    buildonly-randconfig-004-20250914    gcc-14
i386    buildonly-randconfig-005-20250914    clang-20
i386    buildonly-randconfig-006-20250914    gcc-14
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250914    clang-20
x86_64  buildonly-randconfig-002-20250914    clang-20
x86_64  buildonly-randconfig-003-20250914    clang-20
x86_64  buildonly-randconfig-004-20250914    clang-20
x86_64  buildonly-randconfig-005-20250914    gcc-14
x86_64  buildonly-randconfig-006-20250914    clang-20
x86_64                          defconfig    gcc-14
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

