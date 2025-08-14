Return-Path: <linux-kernel+bounces-768894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28383B26739
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3F7681525
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73403002A3;
	Thu, 14 Aug 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAXdwbqb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C6265284
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177909; cv=none; b=eNoMqVH6hlafzToZvZPOPfOvGzrod22Rt+rJvRx5gp4DEshH0t3cYsZ7mI2ejjWfA2ZTwWzL1UFCg5gLLR5891GyAFB3l+MtTxqhgw4mvPr50FGJFWU/RQypvejMLev3MvG8jIW2k7qzDG1/DaLhGjtTQ8AW5I6Znu/8v5RbEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177909; c=relaxed/simple;
	bh=GYeszblfLXC9AxCoOxVYlC5jMxyPUQ/zm1wXlnd8Ir4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cHpIjDiwJM3mFFsqsVT4U7VnX5s2QmYBk3P6Qkor21xYWQKwhNnlGf/XGrvydhRmhnVS8oSx59+59maEX9ueZrzj+W2t4+ZXB6p6PH1pwZb6+kfEtq8w2jMvksEKDhvcJznDmBoxhUIPx00fv5TcMA03NoxUVr/9jZk9cEhR7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAXdwbqb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755177908; x=1786713908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GYeszblfLXC9AxCoOxVYlC5jMxyPUQ/zm1wXlnd8Ir4=;
  b=MAXdwbqbc/nCkDnS6jUfsrAv78yc1KdcUdsoK1UzkwZhfJp+ZpaT8qvP
   /5ZMqoCgK+2qo5rD+TGUe9gvDIUbvTSN1vWqLuHixjbvSmcEL6ZPbF4ed
   SIkBBEzUKxBIgC5SAWHaa1bsREh6U3D0KGrmJ1RwaRemIU0obRbygZwHX
   yaHEb9/6JS/6nPj4/MpUDa3s/HUvaR/dRGMRe4x2kkhFRab+88sdTmHLM
   dMU4l13pTwM9z+/V3E0feYm3GwcTdlrzj3a2Imu61RfNmVXWjnLBay4dh
   AeGYDQZ2ZzonWVni2kaIEwlEx6rdTzGk7svNKmlphxqAbt1m4YPLHtfCp
   A==;
X-CSE-ConnectionGUID: Q58QdYIZRemBbNaeXeTHqQ==
X-CSE-MsgGUID: Q0Nhp6FMSQG5t3A0XKTfBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57414863"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57414863"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 06:25:07 -0700
X-CSE-ConnectionGUID: SSBRO4SjT3Wl32uwQZFDQw==
X-CSE-MsgGUID: uPd1JJq9Rh+Gj/3SOLHiwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167126683"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 14 Aug 2025 06:25:05 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umXx1-000Az8-1A;
	Thu, 14 Aug 2025 13:25:03 +0000
Date: Thu, 14 Aug 2025 21:21:50 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Pranjal Shrivastava <praan@google.com>
Subject: drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202508142105.Jb5Smjsg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
commit: 32b2d3a57e26804ca96d82a222667ac0fa226cb7 iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
date:   5 weeks ago
config: arm64-randconfig-r112-20250814 (https://download.01.org/0day-ci/archive/20250814/202508142105.Jb5Smjsg-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce: (https://download.01.org/0day-ci/archive/20250814/202508142105.Jb5Smjsg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508142105.Jb5Smjsg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 @@     got unsigned long long @@
   drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:     expected restricted __le64
   drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:     got unsigned long long

vim +305 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

   297	
   298	static void tegra241_vintf_user_handle_error(struct tegra241_vintf *vintf)
   299	{
   300		struct iommufd_viommu *viommu = &vintf->vsmmu.core;
   301		struct iommu_vevent_tegra241_cmdqv vevent_data;
   302		int i;
   303	
   304		for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
 > 305			vevent_data.lvcmdq_err_map[i] =
   306				readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
   307	
   308		iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
   309					    &vevent_data, sizeof(vevent_data));
   310	}
   311	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

