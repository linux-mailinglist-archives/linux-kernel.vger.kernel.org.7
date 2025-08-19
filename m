Return-Path: <linux-kernel+bounces-774912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4BB2B91C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258231964D21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335F269CF0;
	Tue, 19 Aug 2025 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ay91WHAp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C9266B41
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583703; cv=none; b=V9GmEIfK0/+5zzYmMSg8paq1Ypex5XUTjtpOpflixrbCTHCol26zOLhpmMRbQQeKbKy5Cr/pXgeoL8E0xdUtLgwbRsGYxM/8f/lsUf7kbh+zC2TCvnRGPW51IlHwTaeWMipPpccZDg3ExqAdpiv0eSWg5sIm4aEV9QXpe2fmb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583703; c=relaxed/simple;
	bh=XChp3liQYL0Z3JG2IuJUG6yDs9kT5S2Sa2/Cnnjt764=;
	h=Date:From:To:Cc:Subject:Message-ID; b=L8iQ47kj/wqp+qbQV16qB6+rCc+IITncr4nI/WCby79XX6024x3issgnLWSPjlbgu8/R4Xtfzd6PL7aROQfC/l9tZQ8RUpQWAgZXMqnXR01jxiIQlPiSc2QbwW4p13X9HV9G4fO8lHZOXu+bKKLmfy+lfsYjfxurlz3O7R6W/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ay91WHAp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755583702; x=1787119702;
  h=date:from:to:cc:subject:message-id;
  bh=XChp3liQYL0Z3JG2IuJUG6yDs9kT5S2Sa2/Cnnjt764=;
  b=ay91WHApRHXUA6TZgPbi8E3e37b5x1/JqxbXWgOsoeF4YMWHmhmPFVwT
   V0PdiZ1cTaEeqwr2b7P9r5JCayrG1PlZ+guc8Jw2ZXFzIaXKwL9EryTqo
   JE276fDcN0Mpp5Xr7w22RTooZA58vJXOAUVFZhoqy3Y6WinDpiTvu3uaO
   kts4z0gFs4RdesMYIWZLW3GlVIujDjiB0329lD0YXbDodg9ZYx+nYRGYm
   b+7blPVjgqfhwVuTgpUz3s2XrD7HuAwD8eEzdMWXjwjMyEDBlsi096m6k
   LacJF0SPmywu7N9m2pR3PHzDhZ7CCFPLqR68Vmj+AyaPSBNvoYhRo30Ak
   w==;
X-CSE-ConnectionGUID: tLsvTHEuQnSXgGKlbXlfKA==
X-CSE-MsgGUID: fAaCLwVgQeWpG3fok4mDPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="68081706"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="68081706"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 23:08:22 -0700
X-CSE-ConnectionGUID: KLBdEWIES4yRNbI9U6oetA==
X-CSE-MsgGUID: 7kFqYQspScaF5ANqjpgmNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168163890"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 18 Aug 2025 23:08:21 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoFW6-000GZ1-1w;
	Tue, 19 Aug 2025 06:08:18 +0000
Date: Tue, 19 Aug 2025 14:07:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 215596ddc33f20945e8d1188a7e682831f0ef050
Message-ID: <202508191424.eMvTrYL6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 215596ddc33f20945e8d1188a7e682831f0ef050  x86/cpu: Detect FreeBSD Bhyve hypervisor

elapsed time: 920m

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

