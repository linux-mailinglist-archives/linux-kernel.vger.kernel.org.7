Return-Path: <linux-kernel+bounces-776592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D00B2CF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2347D1C410B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF913054C5;
	Tue, 19 Aug 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dI2OgXtH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C82E2298
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642108; cv=none; b=SCCkfokMmGSIOfadkm0h62dPsBFGv82ZD3eDkBIotIbsm1R3HzSKK75ElewFYae8A+Mw8fkSaxVIaoT2uZoWF2wZe75gxt9FES1yNJg+JS6Cg2ZpJ8gy3jdfOEwlafMW4dCq2JRt99bmgdW2VLYtEfCBs+6up6tMv2ZhQ7BYrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642108; c=relaxed/simple;
	bh=uNt8YfZHMjlUNlGSxjAZTSl7ltsB0S7zjdtGLOF8xps=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JfD+BXl5XzucqPPWO7aU5P/UBfjwKSJIKRmFCrbBxiHKqb/xY5O3ednVzdrKGUmgxvmGwEFqGpU7Xa+qA6J3SgvUMOx+NxKW8MAN31aE2kEgg2xWgRqxF50+jaYm1lr4PGFp6MCMKqMRqaQaaWcVzWhdz59K4bm+sv4L94k8ci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dI2OgXtH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755642107; x=1787178107;
  h=date:from:to:cc:subject:message-id;
  bh=uNt8YfZHMjlUNlGSxjAZTSl7ltsB0S7zjdtGLOF8xps=;
  b=dI2OgXtHupbUvJTTRdRHqRkC/vKkQ1FA7f1OJjmmCE0xqjx4Avk33nNf
   j6DUepsti4KU3LfYXd5Fq4Bj4F7zTRw9tzGgL7NyelAvSffmLk2dNUiOL
   X2FglYCx6N5To9o0WTxK9VDiWXATaXMfY9OyAcShe0jPRWwqM0eflPLli
   4Ajnt8YGEt0fNbY9vXLrDAmGjC/Gv4zPyZhUDg2T5HbbRxrDknX6UQL9a
   WS42n7BHtG/1oE1Z9C5ZlSQWPytEH6rLIc9FORabVqhO6BI39JupN1zdr
   wDX7q3HgFZ1iJFQUEKoB/Tb9eAiWdz2SEsw/Yy27wDYcq+paM0elZr0lZ
   A==;
X-CSE-ConnectionGUID: 5Pvla51GTOCzrcF55wp3Dw==
X-CSE-MsgGUID: Eb8JUm7fRem8wimxiBVX3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61731942"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61731942"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 15:21:46 -0700
X-CSE-ConnectionGUID: zcA4D2lHQ4uZrr3EX2XzFg==
X-CSE-MsgGUID: UXnYgsSYRcmS9J1OfkKYrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167876168"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 Aug 2025 15:21:45 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoUi6-000Hdx-2d;
	Tue, 19 Aug 2025 22:21:42 +0000
Date: Wed, 20 Aug 2025 06:17:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d4932a1b148bb6121121e56bad312c4339042d70
Message-ID: <202508200601.AqDlpLOG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d4932a1b148bb6121121e56bad312c4339042d70  x86/bugs: Fix GDS mitigation selecting when mitigation is off

elapsed time: 762m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250819    gcc-12
i386    buildonly-randconfig-002-20250819    clang-20
i386    buildonly-randconfig-003-20250819    clang-20
i386    buildonly-randconfig-004-20250819    clang-20
i386    buildonly-randconfig-005-20250819    clang-20
i386    buildonly-randconfig-006-20250819    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250819    clang-20
x86_64  buildonly-randconfig-002-20250819    clang-20
x86_64  buildonly-randconfig-003-20250819    clang-20
x86_64  buildonly-randconfig-004-20250819    clang-20
x86_64  buildonly-randconfig-005-20250819    clang-20
x86_64  buildonly-randconfig-006-20250819    clang-20
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

