Return-Path: <linux-kernel+bounces-846839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F0DBC9332
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B213A37B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66EE2E7BA2;
	Thu,  9 Oct 2025 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PD32FAiK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AE2E7178
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015255; cv=none; b=eq+dqYLFHIS8bN4fWI+9X3SSIlPL+13/GSPjD0uowb2mEnDCnOtqST+V/aUSHJxUteK7v0efh7+FT/wqbDVJwt3RF8l7qUn41YAidAyUEhYvizAgw+SrQNPN0EBEHIk9CSUXjsB4hJKjyEzUlCP/Jbvu14QU1qtfQkeS5ji5OuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015255; c=relaxed/simple;
	bh=uN7i5BVypHfafaJqhmateC8WeGZu9whxYQt3s1oOu9U=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aE2ODckPWkTX5WfoCo1GO/oi3ioAWxGeU+EO0z3lA5xIEi6pZSvJhxFc/Ti+LPvRYaWhOjIIaw7BHNeT3ewNkDvR5bA3Phdi7LrLU5MzdZhg795mu+3HrDWEHJPzCcnsO5KpYf/duwgiwmcyjOYfFIQ3YDyfaxw0ONTuGugPP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PD32FAiK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760015254; x=1791551254;
  h=date:from:cc:subject:message-id:mime-version;
  bh=uN7i5BVypHfafaJqhmateC8WeGZu9whxYQt3s1oOu9U=;
  b=PD32FAiKmRvJ+IYf03lDUQBTRgUw/CRpqPo5Ju0wSQoG4T7DClIQ9nlr
   mhMf6IvGbD3mcAyLH5E9Oq6YAdOynfe3ZRhZReHV6xlHgsG8SwylTAYPn
   mIpVT7yAZddASpbi5U9MSPvNE4j3SGn7gJQ3kHBx2hr4OAq3hBuHgJR1T
   Vxhmr0jUGnOsiibaufqRSTBxp3u0jbxKpH4LM4iUhCYf0tIRXHnlhnDxK
   tdU6nZoJ9tMNqyusv0DNgoZzj8OxU+MnCVLa3BMmHfBbumxcdP4CgKNvN
   tHWRnJTbbeYB7HcEmBldWKusFH8uNnUKjBfkBcXdCARhCpp9dyGvrVJxW
   g==;
X-CSE-ConnectionGUID: IS6h1ziSRjeo5zS/T4bT2A==
X-CSE-MsgGUID: GyNpAKc2SMmTPtDVAC1+2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62164540"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62164540"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 06:07:32 -0700
X-CSE-ConnectionGUID: Lsz+pi0ETbSf4EWHmKIMyQ==
X-CSE-MsgGUID: RdaudrzHT3S+a1FSP2YHKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="185837748"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Oct 2025 06:07:31 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6qMh-0000iu-2J;
	Thu, 09 Oct 2025 13:07:27 +0000
Date: Thu, 9 Oct 2025 21:07:02 +0800
From: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [tip:x86/core 1/1] vmlinux.o: warning: objtool:
 rcar_pcie_probe+0x13e: no-cfi indirect call!
Message-ID: <202510092124.O2IX0Jek-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
head:   6c6e6a5416471498d8aafc050110bec9467e4da7
commit: 6c6e6a5416471498d8aafc050110bec9467e4da7 [1/1] Merge branch 'linus' into x86/core, to resolve conflicts
config: x86_64-buildonly-randconfig-001-20251009 (https://download.01.org/0day-ci/archive/20251009/202510092124.O2IX0Jek-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251009/202510092124.O2IX0Jek-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: rcar_pcie_probe+0x13e: no-cfi indirect call!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

