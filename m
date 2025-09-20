Return-Path: <linux-kernel+bounces-825909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C722B8D152
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531346249CD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358D2D6410;
	Sat, 20 Sep 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFYtm3Iy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5292D027F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758401493; cv=none; b=W5EIdnEMZas8FLN3zgEB3SndEwUQDHOmHeyyXFudzaYj701o5hVmxgaiYBHlddE4T4gT5REui50APl94h7+2sjBJFN4SpykAr6QjY0/0lGjB8Y1uza9QkyJkxfZ8NSsjiUwPFSabLpHI14KCw1pyOKgrOwGepPJ0oIWD5sZSEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758401493; c=relaxed/simple;
	bh=L4HjTuLGXNJZcEmT4wpsCf3Z9tu6ik2PhVhed0hONZs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BwlBQ50c5TDIP0wRUmWNd185ZMV7F6wbz21rG/gRgteryISNfIzD2dM6ak5Tj3SxthrvY9a0IWM1ZmEgnIsmz/E4KFEM3yHQ5cDdcl6Zk5dnrzCWFDbUFnBNYYPxSL4KYvEsyJnkIYk4a2/pONPV3Tk5RfLNWwT9euVQrOkzWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFYtm3Iy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758401492; x=1789937492;
  h=date:from:to:cc:subject:message-id;
  bh=L4HjTuLGXNJZcEmT4wpsCf3Z9tu6ik2PhVhed0hONZs=;
  b=LFYtm3IyrhliSWJeEWYR8ej/JQf2g2me264olPW3mOXSrnsToQw37XMh
   DN1GrYRjhMYGSb1ohALgJXece5Q+HQPu65KBuNNpeC1Z8civkYony2bZ4
   xZQDrE9qpmq+0jacWYO97sblK6R5wuB+BzwqSfOC82sw4Z0v/2eHmPYAG
   8r5GTmr4E/z2C2gyCa7P/mN/ZXN77qiL+7agSc5CcXcH+OWjq4Ux2JPKx
   DHvw9hydBj1OBRZFa3I4IFvi3Xt9Iy/j0STa8Du6X974/5LOmYm+gVpyp
   +sfYPX3OPyVKLvr/iaoYB6iGNnCtXwaXACn7LcyPx+aSkGVNnqfnj01pi
   g==;
X-CSE-ConnectionGUID: STsC8o4uSIKkCRRv5X7/Sg==
X-CSE-MsgGUID: i1osYF4YT6quuPpWAwf5Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="64535994"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="64535994"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 13:51:31 -0700
X-CSE-ConnectionGUID: hIyqSphzT+iaPCaPesGlBw==
X-CSE-MsgGUID: k9UUYWgTSYettKjb8VvJxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="207079649"
Received: from lkp-server01.sh.intel.com (HELO 7f63209e7e66) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Sep 2025 13:51:31 -0700
Received: from kbuild by 7f63209e7e66 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v04YK-000079-1K;
	Sat, 20 Sep 2025 20:51:28 +0000
Date: Sun, 21 Sep 2025 04:51:02 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 27b1fd62012dfe9d3eb8ecde344d7aa673695ecf
Message-ID: <202509210454.Lj7zrgUG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 27b1fd62012dfe9d3eb8ecde344d7aa673695ecf  x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT aliases)

elapsed time: 1448m

configs tested: 23
configs skipped: 118

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250920    clang-20
i386        buildonly-randconfig-002-20250920    clang-20
i386        buildonly-randconfig-003-20250920    clang-20
i386        buildonly-randconfig-004-20250920    gcc-13
i386        buildonly-randconfig-005-20250920    clang-20
i386        buildonly-randconfig-006-20250920    clang-20
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250920    clang-20
x86_64      buildonly-randconfig-002-20250920    clang-20
x86_64      buildonly-randconfig-003-20250920    clang-20
x86_64      buildonly-randconfig-004-20250920    clang-20
x86_64      buildonly-randconfig-005-20250920    gcc-14
x86_64      buildonly-randconfig-006-20250920    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

