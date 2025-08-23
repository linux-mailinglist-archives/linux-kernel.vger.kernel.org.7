Return-Path: <linux-kernel+bounces-783298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52580B32B71
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 20:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F976179E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E742248871;
	Sat, 23 Aug 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdunXPS8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407BF1F17E8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755972517; cv=none; b=fb+bidnC4vy1jWEO5ftrEvP1xpjN54Elbh0du2OtLRrrZQZvzc9PI4FyTv22bO/ft1r4m1qUMJ2kkbLm3CFdt4/3Zys7gM2KFval0VJVEjWNXYw1EiaWrQgGgvgrTxyy1rt5osV3LPlkVyklu+e9P89BK0Mk3TeNlnJpwn0ebdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755972517; c=relaxed/simple;
	bh=Jmih/DEUoV1ZAJgVCoGt5qeY4AN4djP44yu93t/dmBU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZjyBTg+uuPZGVqdhjEDcjWb4le2WtP6nAVsCZnqM6VdvMQ6EMtLbRrNQcQbV+VD5ONNS1LDn0UO0rh0MNRJbfKtqZNOciDVw5yFpNGQGKSvpl64dMxOJf5QlGo4dfFASeex7eZg4itTuJiqhqfJIdFXzP+rYfoY2LfehHavQsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdunXPS8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755972516; x=1787508516;
  h=date:from:to:cc:subject:message-id;
  bh=Jmih/DEUoV1ZAJgVCoGt5qeY4AN4djP44yu93t/dmBU=;
  b=hdunXPS8CDO5oop5l0CkW0ZPt16ZiHnqDcaKj0gDhJhFZDQp5vmkxp30
   zmRpzOqSOLtYhBnWsvREl4mKkVTFIiuB7Clc9yUlS8UJI3I54KP1Irlq0
   njBZI9FlFuDLd69nJLiFCd/ujOfqQTsz6iAGG6bM0AxoFRSEcYOYN8c+N
   CwZUK7sQnfkaFaeca9DdXyQNo9Hab1claiNfwijSwkFD2HGoLuyonFRkD
   8bFsx6K25BbEDMYu3P6Uci4LEcE2aduZ8ugsoeC6HxTRYkRsd6IH7Q0mn
   AS9qnz0O3Y1x9hDkcJzPUAop1KBXIxt4pcZpgw4zkDIlYIiICsfJOT9Bi
   w==;
X-CSE-ConnectionGUID: CpSw3PHmQDeceLy7Qn1Kag==
X-CSE-MsgGUID: EjhEO2keT3iGcr7gkuDKmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="57267840"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="57267840"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 11:08:35 -0700
X-CSE-ConnectionGUID: Npo1A/6GShqB+ZMsWeJfrQ==
X-CSE-MsgGUID: jP7cgUw2SmSP6rZMJi/mdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168545547"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 23 Aug 2025 11:08:35 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upsfI-000MUz-0x;
	Sat, 23 Aug 2025 18:08:32 +0000
Date: Sun, 24 Aug 2025 02:07:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 f3285344a5a370ee72ff6db2759b0f11d1495c70
Message-ID: <202508240247.MPvvlFfA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: f3285344a5a370ee72ff6db2759b0f11d1495c70  x86/cpu/cacheinfo: Simplify cacheinfo_amd_init_llc_id() using _cpuid4_info

elapsed time: 1595m

configs tested: 20
configs skipped: 150

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
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

