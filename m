Return-Path: <linux-kernel+bounces-739120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE9B0C212
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C533178068
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E332900BA;
	Mon, 21 Jul 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCrPMvPo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD842900AF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095733; cv=none; b=VSJS/fDHJ+6EfElY2GAWMCKZgSnf4A4q4xYpijZ/CndJtIgivpx3gQ0WlYttljoHwd0sTtRQD2JjdyUBjwI68MU1UQiV4E5sT9tWaxXvNlDwEcakqjAdkklNKx29HAsynxqxjTGkfR3beLyS0u3E/dONKx0vy9WVek2S5F37aH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095733; c=relaxed/simple;
	bh=3uRhaUB5Mh2Cjxn2SQKTZqQm9gZ4wribpTNPQ9s23e0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BEeIPLqEcf6e6lwmSPjB+7c+Fpfp+hEzLoMGSCOe0EzLDtYboeawtLfCClmmokyP+8QAzZgRpNNwv3zaGtuTfjRVMBuA7+eQrAmLTL+uZmCPZop2TJ+NrSmglZJ5EabU0zoViK43pLlExEz4CbidatJ+T+5iyUBZ9IkSpux8ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCrPMvPo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753095732; x=1784631732;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3uRhaUB5Mh2Cjxn2SQKTZqQm9gZ4wribpTNPQ9s23e0=;
  b=DCrPMvPofkrCvxMtuSb1/7+v9cBCASRiHv9KwQnEFuRNLwByer9prEp9
   hPLDp3Q+Uj+zTkHAIFkyKc8M3v8zavxIwWZx7yYekQ+tLMGRwipInjqfl
   yAB7iINVxE9jK0ky+pvNgrRXWMyPk80u0fqoRZ11l0K6GuChyuvdnRGLd
   mQTXdJv9YQNrxiRFMpmtcfPyesDFbuddMJeJ8rReoLTFBrtqo/+N/nXpL
   CTHM7nEi/iI8MWta588zEJeF5mwIO+eA2DWDgxy9J7cAx+QKcoeo03IKk
   iFp9WNQO1tPBXTaFWw1Ut4MW7JGXEMyhKcQ1jGSMTckoItIIXRTdOnAqr
   w==;
X-CSE-ConnectionGUID: BwfT41fJSq2FxRrFZNBfqw==
X-CSE-MsgGUID: vMM9VayvQ1m0uV3wOUGyag==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55157057"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55157057"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:02:11 -0700
X-CSE-ConnectionGUID: DhbvSEKlQBO3Y5gWPAmmJQ==
X-CSE-MsgGUID: lHmLTVTZTMe/isSZQATfsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158130335"
Received: from igk-lkp-server01.igk.intel.com (HELO 8b57277650df) ([10.91.175.65])
  by orviesa006.jf.intel.com with ESMTP; 21 Jul 2025 04:02:09 -0700
Received: from kbuild by 8b57277650df with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udoHX-0001P7-0V;
	Mon, 21 Jul 2025 11:02:07 +0000
Date: Mon, 21 Jul 2025 13:01:18 +0200
From: kernel test robot <lkp@intel.com>
To: Likun Gao <Likun.Gao@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/imu_v12_0.c:333:30: warning: variable
 'data' is uninitialized when used here
Message-ID: <202507211301.7SjLWatr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89be9a83ccf1f88522317ce02f854f30d6115c41
commit: 56159fffaab5c42a8897eac0824c58af3b369914 drm/amdgpu: use new method to program rlc ram
date:   1 year, 3 months ago
config: powerpc64-randconfig-2006-20250721 (https://download.01.org/0day-ci/archive/20250721/202507211301.7SjLWatr-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 6193dd55535460c347f8c0b794df7d7d52fa78c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250721/202507211301.7SjLWatr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507211301.7SjLWatr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/imu_v12_0.c:25:
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:52:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/amd/amdgpu/imu_v12_0.c:333:30: warning: variable 'data' is uninitialized when used here [-Wuninitialized]
     333 |                         program_imu_rlc_ram(adev, data, (const u32)size);
         |                                                   ^~~~
   drivers/gpu/drm/amd/amdgpu/imu_v12_0.c:325:17: note: initialize the variable 'data' to silence this warning
     325 |         const u32 *data;
         |                        ^
         |                         = NULL
   2 warnings generated.


vim +/data +333 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c

   321	
   322	static void imu_v12_0_program_rlc_ram(struct amdgpu_device *adev)
   323	{
   324		u32 reg_data, size = 0;
   325		const u32 *data;
   326		int r = -EINVAL;
   327	
   328		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);
   329	
   330		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
   331		case IP_VERSION(12, 0, 1):
   332			if (!r)
 > 333				program_imu_rlc_ram(adev, data, (const u32)size);
   334			else
   335				program_imu_rlc_ram_old(adev, imu_rlc_ram_golden_12_0_1,
   336					(const u32)ARRAY_SIZE(imu_rlc_ram_golden_12_0_1));
   337			break;
   338		default:
   339			BUG();
   340			break;
   341		}
   342	
   343		//Indicate the latest entry
   344		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
   345		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, 0);
   346		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, 0);
   347	
   348		reg_data = RREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX);
   349		reg_data |= GFX_IMU_RLC_RAM_INDEX__RAM_VALID_MASK;
   350		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, reg_data);
   351	}
   352	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

