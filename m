Return-Path: <linux-kernel+bounces-884606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82432C30932
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840B91895F2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C248634F;
	Tue,  4 Nov 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lefwm9rx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686923A9B3;
	Tue,  4 Nov 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253229; cv=none; b=SMQxF6emDaJaAfEx+zozdqooTCkrxEFVLRfFprfKrsw1w0FrvcVW3XCbwsAVKEDLKAwPtxUMA5I8zUGoW/6FkuiquwMiIFW9NijdDmpgWBzGTrusoUmMIN8khmG0aWjtD4usNO857zTR5p6gPnxX0cFbIUhdKhqzBMSmda8lr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253229; c=relaxed/simple;
	bh=Kharzk8Yq5v+lRMrbK1AuFwTe0p9vJlwG/MZ3zvjizc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qokcoINmIu8O5nQUqOVB9IowwmdUDmgNdwUW1ZbS4DFVzq0IWAdQOcLNTKOqC2a2dLISKPfs2Qb4vJdoOGa+rvH8jkHRWa2QPY6nVRz9LtB6s+m0CqIKG+XWwJEO0cnGeEl98Tfiow7M7W5tp+S2A6Q+3UeUs+943G+ID6SaUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lefwm9rx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762253228; x=1793789228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kharzk8Yq5v+lRMrbK1AuFwTe0p9vJlwG/MZ3zvjizc=;
  b=Lefwm9rxKi8T+Undo5C+Di6bVFEeFeBsboMRnk6W+qOpHQFaXAcfe+Cf
   dPAGZvogUvSO1LcmXZVb9SShLArgG7BSLAUBItvZfTuak1uCHGFs7lxgt
   I97mZCBvny5O+uALxEkc9VxL3Y0AF5UYIx2yDn/ftCY7FwUd8Ufs5FeOh
   xj0lnq9XZlgPSSX01CHvrvRcjT9/Jmw2pj+D2YPvRKXjtmBdUtU8PVpYO
   JF0IJ7Mn0i36bZ6KQuQ3IQmBNbWFNtGq5+3FOPWOoloKAoWuiGzlWrrAB
   3jEwGG13aba/nm4PLdPVdfor9OMP26Dg81jPcCk8HWmDfQpos/1FsjPVT
   Q==;
X-CSE-ConnectionGUID: B9QZdu93RlWVXmfW+uyJRg==
X-CSE-MsgGUID: D6qZlkRFSZKQio5Y6VNFyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75694739"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="75694739"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 02:47:07 -0800
X-CSE-ConnectionGUID: AjkO+0FaTHOXLZw+Eu21rw==
X-CSE-MsgGUID: ugC9TNPSSpe7wM/pKh3CmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="191434864"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 04 Nov 2025 02:47:02 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGEZ2-000RI8-1r;
	Tue, 04 Nov 2025 10:47:00 +0000
Date: Tue, 4 Nov 2025 18:46:03 +0800
From: kernel test robot <lkp@intel.com>
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, robh@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
	bjorn.andersson@oss.qualcomm.com, bod@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, saravanak@google.com,
	prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
Message-ID: <202511041853.IxYgvWlc-lkp@intel.com>
References: <74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla@oss.qualcomm.com>

Hi Charan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.18-rc4 next-20251103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charan-Teja-Kalla/of-create-a-wrapper-for-of_map_id/20251104-170223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla%40oss.qualcomm.com
patch subject: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20251104/202511041853.IxYgvWlc-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511041853.IxYgvWlc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511041853.IxYgvWlc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/base.c:2127:6: warning: variable 'legacy_iommu_cells' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    2127 |         if (map_len % 4 != 0)
         |             ^~~~~~~~~~~~~~~~
   drivers/of/base.c:2130:9: note: uninitialized use occurs here
    2130 |         return legacy_iommu_cells ? : of_iommu_map_id_actual_cell_count(map, map_len, cells);
         |                ^~~~~~~~~~~~~~~~~~
   drivers/of/base.c:2127:2: note: remove the 'if' if its condition is always true
    2127 |         if (map_len % 4 != 0)
         |         ^~~~~~~~~~~~~~~~~~~~~
    2128 |                 legacy_iommu_cells = of_iommu_map_id_legacy_cell_count(map, map_len);
   drivers/of/base.c:2125:24: note: initialize the variable 'legacy_iommu_cells' to silence this warning
    2125 |         u32 legacy_iommu_cells;
         |                               ^
         |                                = 0
   1 warning generated.


vim +2127 drivers/of/base.c

c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2110  
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2111  /**
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2112   * of_iommu_map_id_cell_count - Determine the cell count for iommu-map parsing.
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2113   *
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2114   * @map: pointer to the iommu-map property that needs to be translated.
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2115   * @map_len: length of @map in bytes.
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2116   *
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2117   * Use #iommu-cells property while parsing iommu-map. Detect and use legacy
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2118   * case where iommu-map is parsed as if cells = 1.
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2119   *
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2120   * Return: number of cells that the caller should be considered while parsing
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2121   * the @map. It is > 0 for success, 0 for failure.
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2122   */
5288ad2aeeeb41 Charan Teja Kalla 2025-11-04  2123  static int of_iommu_map_id_cell_count(const __be32 *map, int map_len, u32 cells)
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2124  {
5288ad2aeeeb41 Charan Teja Kalla 2025-11-04  2125  	u32 legacy_iommu_cells;
5288ad2aeeeb41 Charan Teja Kalla 2025-11-04  2126  
c74d6f4acf99ef Charan Teja Kalla 2025-11-04 @2127  	if (map_len % 4 != 0)
5288ad2aeeeb41 Charan Teja Kalla 2025-11-04  2128  		legacy_iommu_cells = of_iommu_map_id_legacy_cell_count(map, map_len);
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2129  
5288ad2aeeeb41 Charan Teja Kalla 2025-11-04  2130  	return legacy_iommu_cells ? : of_iommu_map_id_actual_cell_count(map, map_len, cells);
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2131  }
c74d6f4acf99ef Charan Teja Kalla 2025-11-04  2132  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

