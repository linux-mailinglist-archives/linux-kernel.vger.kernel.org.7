Return-Path: <linux-kernel+bounces-813775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F142B54A88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80039A063CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4E2FF149;
	Fri, 12 Sep 2025 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/jS5HcH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB152FF140
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674858; cv=none; b=OXaUtX3mn0Igv6XtmD7s1/SbVl9EM/EgYfUytmvpfNT9puURa9FH7lFfpBLNYIiMB/WSnGuwFFUG75uW+AX9eQGiAk31WGNpARubXZHFIDgc6h950OUpC/PGv7EAolgCtE5SMpHzRr66887RgJLsHoLS6G5CMoU8DkAymOvwwBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674858; c=relaxed/simple;
	bh=LuUucZQGkwN0lgyulDYt1UyTany7wNQ+M2E/haQRDZU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HA8A+nFVUdtqi8vqU3QEKVkRMUSBlvYoVmekBIsCDQY/d4Xd6JXmAVip9/mFpODxIm7nJS0rRFsf4f2Aps2ehI4nu4/0a21dPr/dr3mGPRVn2gUIhfKCl9E25maTgyXLLuh6odfZydQv+M2ly7W5wpfiwkPfPpFQMoDyYmZpzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/jS5HcH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757674857; x=1789210857;
  h=date:from:to:cc:subject:message-id;
  bh=LuUucZQGkwN0lgyulDYt1UyTany7wNQ+M2E/haQRDZU=;
  b=W/jS5HcH2iPTNmwfJzz2q9IupqM14P9LNJkjGNoM9ZIt4/8exjmKgJcU
   8Bc6yu/sUjH/i9d3UHAEg/97NvqfU8l9nYCyQFVSNZhh+bBDFMkYYOTuK
   WgtBmVEG+autYRJ6aqyWaI4iwMr/5fpHV0f4PeCKtth7MqpGkDxRZUJDy
   tZnTogHRZxPNr4PVs7WZNYknVN8J118/QA7kMkwXoamRaEjqdyPCkAxGw
   0dZUvn5MORJo1hkbzrdkmOTeRh7qCF4QnZV0b6ls1509htq+BqXH/L5bo
   V3IoOmzLYG1/kGRHIUWytvlt5rCOPd2fL9z2qDYLkpTNeRNxGVmEqkr4q
   g==;
X-CSE-ConnectionGUID: NLJp5/tFQ3iZA8F5STfYpA==
X-CSE-MsgGUID: 4bgzCaBgSleAn77fyhbo9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60127751"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="60127751"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 04:00:57 -0700
X-CSE-ConnectionGUID: Ox+ZkVMrQ3S9+ijhqRS9YQ==
X-CSE-MsgGUID: TGk5YZ5/SaihXBFpTBNdeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173849437"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 12 Sep 2025 04:00:56 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ux1WP-0000yX-2m;
	Fri, 12 Sep 2025 11:00:53 +0000
Date: Fri, 12 Sep 2025 18:59:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 8541d643578f5fc7919e3982667c5dedab597bf5
Message-ID: <202509121844.nd3Agrk1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 8541d643578f5fc7919e3982667c5dedab597bf5  x86/mce: Save and use APEI corrected threshold limit

elapsed time: 1460m

configs tested: 19
configs skipped: 117

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
i386                         allyesconfig    gcc-14
i386    buildonly-randconfig-001-20250911    clang-20
i386    buildonly-randconfig-002-20250911    clang-20
i386    buildonly-randconfig-003-20250911    clang-20
i386    buildonly-randconfig-004-20250911    clang-20
i386    buildonly-randconfig-005-20250911    clang-20
i386    buildonly-randconfig-006-20250911    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250911    gcc-14
x86_64  buildonly-randconfig-002-20250911    gcc-14
x86_64  buildonly-randconfig-003-20250911    clang-20
x86_64  buildonly-randconfig-004-20250911    clang-20
x86_64  buildonly-randconfig-005-20250911    clang-20
x86_64  buildonly-randconfig-006-20250911    gcc-14
x86_64                          defconfig    gcc-14
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

