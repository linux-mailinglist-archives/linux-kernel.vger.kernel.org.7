Return-Path: <linux-kernel+bounces-820403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E946BB7D5CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6674C4E1E65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA8343D92;
	Wed, 17 Sep 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aca8hscL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F392C08AF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103044; cv=none; b=Sbn3W3pOwSVJQZjy1BwpdVb7cq8h14ctviLoXJLCbrIf+NYDCzq6fktPeIw5XtIfU/fXNM0DhRRbEkmCj3pP3g+jdl4IRLhgk4lKv8gugpbKF14fLl15OkeXsyFTNhjnqtSYM+axNN3ExqHuwKrGyROXgVBX71nunoWrDmo6W34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103044; c=relaxed/simple;
	bh=HNjakmqlXKYXOLr5czwwLTZPKrAK2HAIv/5QcvKc2TI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FkfbS6TGKzfviqzs0SArxQ25bD5XE/MCcP9h/NkWV6YP5M8SupR4PbieqD3mw1xse44kVAvnWLYRmz8P5nchBfpz4bjrv+SgiGHV0HuKCSDCUcdzRfSULwnUNYQN1w1Dryf5292kPDNj/p+8eC9RfUTTs8Kh2iPfG6jzvoYyNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aca8hscL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758103043; x=1789639043;
  h=date:from:to:cc:subject:message-id;
  bh=HNjakmqlXKYXOLr5czwwLTZPKrAK2HAIv/5QcvKc2TI=;
  b=Aca8hscLwSQ1sYwD4NkQaD9VjUcj2LWIGlJjvs30MZc7dnpaCi19KUQh
   Ld6mgCRitAcLVLBo+22Mf06Rlbkh9ux2RXqhcuQKM/Rq8FtSYNhMl8aDs
   dtz62FvLQQM0S9U3L/pS73VeNdsq1L4q/KnrNSWRc7ggm5TmNL8gv4Oej
   Dw7aBt8gihPLIYvJxU2B6l5LlfgM6UlGJ4hME71nMtVmSOQSJ2ynYpEbr
   +sAlwnBwn/KuolPb6wQ4stH4LL0r5p0aZxyDpyJBZlC/kYxmt86m0tUmP
   yyIfkdK6F0vWtohM6ecGsRHpQ4/lqjVeGgRNHSY7u3jK/m/zMJfZkBjFW
   g==;
X-CSE-ConnectionGUID: rcozrte7Rv61wx+VKnwTVw==
X-CSE-MsgGUID: NF00FmP/Sm2SFH9HMBOVwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60272465"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60272465"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 02:57:22 -0700
X-CSE-ConnectionGUID: p3xNxAVeRq2+f8w8IIdd9g==
X-CSE-MsgGUID: dhKY9juCS7yTusakfLmeDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174308789"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Sep 2025 02:57:22 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyoud-0001Lk-2B;
	Wed, 17 Sep 2025 09:57:19 +0000
Date: Wed, 17 Sep 2025 17:56:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 5c6f123c419b6e20f84ac1683089a52f449273aa
Message-ID: <202509171751.NAvqx3dF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 5c6f123c419b6e20f84ac1683089a52f449273aa  x86/mce: Add a clear_bank() helper

elapsed time: 1458m

configs tested: 16
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
i386    buildonly-randconfig-001-20250916    gcc-14
i386    buildonly-randconfig-002-20250916    gcc-14
i386    buildonly-randconfig-003-20250916    clang-20
i386    buildonly-randconfig-004-20250916    gcc-14
i386    buildonly-randconfig-005-20250916    gcc-14
i386    buildonly-randconfig-006-20250916    clang-20
x86_64                        allnoconfig    clang-20
x86_64  buildonly-randconfig-001-20250916    gcc-14
x86_64  buildonly-randconfig-002-20250916    clang-20
x86_64  buildonly-randconfig-003-20250916    clang-20
x86_64  buildonly-randconfig-004-20250916    clang-20
x86_64  buildonly-randconfig-005-20250916    clang-20
x86_64  buildonly-randconfig-006-20250916    clang-20
x86_64                          defconfig    gcc-14
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

