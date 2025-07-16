Return-Path: <linux-kernel+bounces-733149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281B3B070D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302253B5879
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AC72EF282;
	Wed, 16 Jul 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKbhq97R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565423FC42
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655554; cv=none; b=lSVo53WG4Zq0u+KhCNYhpirhMJDgW+7D/XbmQCwLZTQBMEhC9AIfT5zxUUEG/3A0ytbiszjm/sYCPiSVNcV2NuNeWw9K7A3aoMZJCF3STj3HTGlb6KE7lWdF3euVOenDiOmgSwTXr75rJ8jEVZ8h2herHYNQByWkzcsFHo7alnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655554; c=relaxed/simple;
	bh=OsergoVcgVPfjK+w3ZmNoDii+kpsp6XiHQ03wmjMffM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eRbtBZWS053yp30B2josSGFm0mtIzC6UPuGjLDnjUjLk3GEc5uR9+EkP9AYVdG502PxfJzKfDLfM/Pw5L+GfY6HclmNmE0kIxW48H6Qc7b2QNBAWfwbVgzq6s87RjyjmYL2JrmQUzkM/Guc1t7hlL3AH3JC747ivvNriXseihoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKbhq97R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752655552; x=1784191552;
  h=date:from:to:cc:subject:message-id;
  bh=OsergoVcgVPfjK+w3ZmNoDii+kpsp6XiHQ03wmjMffM=;
  b=IKbhq97RBp2d3Y5Bhjliy/BSAlXTY61hYG5FirJX7cxO7VnflwvendKh
   vwSkHKdqwpUadnmLHaL4IMwt63OzeusGaL9miK57TbKmw1f2OVZQqc+RU
   JPmkKtGbJHWFiAUSXLyItO94JdFFMqUG2ZtcS7frDaOGAZP/xh+sqBDDv
   WPtc2wl7Fne4VqypiMazX2pXZPCbU+hO2wUWUe7rJqsQn6QH9OboIQEPw
   WYJgFUTmtImAcTUDbZRTyPJS1NYVHq1MrvvpfsH3PS/yAostvt7EQnrnx
   h+aXpAXldAfMZzDXJFcW7AfxwGEQdgQ34qIIAMHqiCEz3Jn56Cb3IhN7C
   w==;
X-CSE-ConnectionGUID: jyJ3TsblRGSoAcNoggX/0w==
X-CSE-MsgGUID: X6/qTTbMQ0KmJfL3PAG9tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58548118"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58548118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 01:45:52 -0700
X-CSE-ConnectionGUID: 2J1F/LiDTSiVP2rY0bNQ3w==
X-CSE-MsgGUID: kRQ0SNFWRticU5OP7C+lhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157110811"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jul 2025 01:45:50 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubxls-000C7r-2i;
	Wed, 16 Jul 2025 08:45:48 +0000
Date: Wed, 16 Jul 2025 16:45:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 6b995d01683feae619aa3263d18a6aa19bface16
Message-ID: <202507161634.u1cfXOWS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 6b995d01683feae619aa3263d18a6aa19bface16  x86/sev: Work around broken noinstr on GCC

elapsed time: 1431m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250715    gcc-12
i386    buildonly-randconfig-002-20250715    gcc-12
i386    buildonly-randconfig-003-20250715    gcc-12
i386    buildonly-randconfig-004-20250715    clang-20
i386    buildonly-randconfig-005-20250715    clang-20
i386    buildonly-randconfig-006-20250715    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250715    clang-20
x86_64  buildonly-randconfig-002-20250715    gcc-12
x86_64  buildonly-randconfig-003-20250715    gcc-12
x86_64  buildonly-randconfig-004-20250715    gcc-11
x86_64  buildonly-randconfig-005-20250715    gcc-12
x86_64  buildonly-randconfig-006-20250715    gcc-12
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

