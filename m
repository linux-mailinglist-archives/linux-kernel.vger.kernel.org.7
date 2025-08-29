Return-Path: <linux-kernel+bounces-792569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19642B3C5B8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6DD1B289FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6DC273D92;
	Fri, 29 Aug 2025 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWluYBUQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF0230BF6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511395; cv=none; b=o5WJ5cKLd2XIr4cLdtlo0y95nYRudZHXWd7E84jbx39u5EWUeg1saKOkhCCIY4PEg5dJ8roy8AnKl4K1Bv920edgTY0lFBwiu10HhcU+miOGZGDVt4FI4JAoaiwioYYUyMxnZ2DtNlRmgcDyJ+gGeiZabUaf2NDbsJ/R0N7ZUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511395; c=relaxed/simple;
	bh=nedf2ddkjK2otTUQZHomYDwwQ5YgV1/hqcfA6Wa3eeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VWp0Xc1LZ4csL9oNp9phooX8VbIFK2Ia1lJAJy3XMDLLkx3yS/FHC2fhDA2HtMsKYAltiPE9GVtzhjyH+FXYc4CkNgDQIdVO8yBr+5G3AMNgluQ5fkcx90rwRAHmndmu+x7FW5YSPo0O/C1KU14IgatsTYxigSM0yCSfPgNlom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWluYBUQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756511393; x=1788047393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nedf2ddkjK2otTUQZHomYDwwQ5YgV1/hqcfA6Wa3eeQ=;
  b=mWluYBUQKzOVER67zmil/UD/fDWGih2AJA0AF6u1gM7aDkx5T1fsGRO2
   YwnpESr+8UmxT9mJCJJgbFHn7CVmftn+l5BdIOztaJn2jC1puCV3NWnvO
   XWGajBCSfFc2tgGEV52j9Mt5Y88FC0N3fKZKg5thsdxX899OkfSu5uL6V
   //VzCq5IWTd4vVhGEGn2RfXxZ/20AXLqQBJXzLd5+3WVAwJGVM4ACmLYs
   SnPqf9mRbSv4CyFTLkG3oPE1EakrjV34n6QA/lPTGJEL3p0ADwT1Tb4TQ
   fwzzERrn3B/D5nz8Tu+gOBpfFcFAMq3CSTCR6cGPHqgGcGjd5mO+16kXo
   g==;
X-CSE-ConnectionGUID: JnpgpsYEQH+NuIXkZytNUQ==
X-CSE-MsgGUID: UbO9wmuhSi2Dz18UKwLJdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58751028"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58751028"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 16:49:53 -0700
X-CSE-ConnectionGUID: TZ4G4hfRTHeLdncMGF8j6Q==
X-CSE-MsgGUID: qRpIOGEGTLqAIDT8Cojumw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174863049"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 29 Aug 2025 16:49:52 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us8qh-000V3f-0R;
	Fri, 29 Aug 2025 23:49:40 +0000
Date: Sat, 30 Aug 2025 07:48:31 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: ld.lld: error: undefined symbol: qcom_mdt_get_size
Message-ID: <202508300739.5uKUOJ9T-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb679c832b6497f19fffb8274c419783909c0912
commit: 2df158047d532d0e2a6b39953656c738872151a3 ipa: fix compile-testing with qcom-mdt=m
date:   4 weeks ago
config: powerpc64-randconfig-r123-20250829 (https://download.01.org/0day-ci/archive/20250830/202508300739.5uKUOJ9T-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce: (https://download.01.org/0day-ci/archive/20250830/202508300739.5uKUOJ9T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508300739.5uKUOJ9T-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: qcom_mdt_get_size
   >>> referenced by iris_firmware.c
   >>>               drivers/media/platform/qcom/iris/iris_firmware.o:(iris_fw_load) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: qcom_mdt_load
   >>> referenced by iris_firmware.c
   >>>               drivers/media/platform/qcom/iris/iris_firmware.o:(iris_fw_load) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

