Return-Path: <linux-kernel+bounces-877854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95CAC1F332
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4E2189C936
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60AD41C69;
	Thu, 30 Oct 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGeVbPr4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F031A553
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815445; cv=none; b=cKXUUbqTJgJ9XCKwXUs5NaTwjTsxTE0V3ETBdEOmIdf+8o/KwhRmzAfdWVR6ixI3FfsRxIE/pYfr0aWXlKrC2b6PwdCAFyIQMwuLIoYvyQ312kIAs4t80o18t5LOZSs4wVuDy3xFUN83Dzk+aOEKkf8uUuct9DfVnoac98zi5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815445; c=relaxed/simple;
	bh=QD0dpr+/yhSUGlk8rxv1ly6ZLzzQLlWepkMeM5rcY2o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EAwg/8qAQZ+wJQX3ULlNlRRKrFRj89jec/j85kr8YJJliTEBSPLhEjT/i0GyWATOcGRM1lypKZz3Ng5extpadUFtBksSbQ0IupRgTqMoKBaM1YWt+G0mW18zOG3EKVfQI5KghNQMeRpBtquYUA13unm3vKypHDdhS4fb+LpXsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGeVbPr4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761815444; x=1793351444;
  h=date:from:to:cc:subject:message-id;
  bh=QD0dpr+/yhSUGlk8rxv1ly6ZLzzQLlWepkMeM5rcY2o=;
  b=DGeVbPr4hF3mNxaHlc78F0y5TyiImvVC4E1tI+69hgilx4sOzypvBDoC
   Jwl+GbkY/ewClh9AiJzXaWWwCRdBgmYn0lyl/thQvgOTpt+e0icT7JKA4
   /NZ5qm/7Ba2QBk4ALxVc8yQ/gYURXdH/fCagQMX7C2qlLorCiG3khDhUq
   B7M2+ulHVCPOsI4I7NxzJ7lI7wp0Rh8+1iDb81LHtRU1aNA/hrZwteDr2
   jIOH4imHQSvmrKzvrw5K+ar6MoT0Vs2HU0Qudg1lfFmEC4dPCDqm4nErc
   eOHheOkh8OhC+Q79AKesacrVV2hXBG3YG4wNNOuQa7nBii/JXwXt2lVKU
   w==;
X-CSE-ConnectionGUID: S1mb/nRqQm+jqLSGiSRTQQ==
X-CSE-MsgGUID: aoLyJWrvTFSP2vAcUpf22w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74550069"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="74550069"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:10:43 -0700
X-CSE-ConnectionGUID: 317vv5WiSEC0plhN5zHXbA==
X-CSE-MsgGUID: xF804KswTo6ewTqf4biPwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="216755859"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 30 Oct 2025 02:10:42 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEOg4-000LkW-0g;
	Thu, 30 Oct 2025 09:10:40 +0000
Date: Thu, 30 Oct 2025 17:09:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 f8bfb10238a88722739de0c5294e2111a2eae297
Message-ID: <202510301752.u8BcHqt3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: f8bfb10238a88722739de0c5294e2111a2eae297  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1452m

configs tested: 29
configs skipped: 124

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
i386    buildonly-randconfig-001-20251030    clang-20
i386    buildonly-randconfig-002-20251030    gcc-14
i386    buildonly-randconfig-003-20251030    clang-20
i386    buildonly-randconfig-004-20251030    clang-20
i386    buildonly-randconfig-005-20251030    gcc-14
i386    buildonly-randconfig-006-20251030    clang-20
i386              randconfig-001-20251030    gcc-14
i386              randconfig-002-20251030    gcc-14
x86_64                        allnoconfig    clang-20
x86_64  buildonly-randconfig-001-20251030    clang-20
x86_64  buildonly-randconfig-002-20251030    gcc-14
x86_64  buildonly-randconfig-003-20251030    gcc-13
x86_64  buildonly-randconfig-004-20251030    gcc-14
x86_64  buildonly-randconfig-005-20251030    clang-20
x86_64  buildonly-randconfig-006-20251030    gcc-14
x86_64                          defconfig    gcc-14
x86_64            randconfig-011-20251030    clang-20
x86_64            randconfig-012-20251030    clang-20
x86_64            randconfig-013-20251030    gcc-13
x86_64            randconfig-014-20251030    gcc-14
x86_64            randconfig-015-20251030    clang-20
x86_64            randconfig-016-20251030    clang-20
x86_64            randconfig-071-20251030    gcc-14
x86_64            randconfig-072-20251030    gcc-14
x86_64            randconfig-073-20251030    clang-20
x86_64            randconfig-074-20251030    clang-20
x86_64            randconfig-075-20251030    gcc-13
x86_64            randconfig-076-20251030    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

