Return-Path: <linux-kernel+bounces-884779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DBC311BD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C6F421C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440572F3614;
	Tue,  4 Nov 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMUpvoPW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C82F0C6A;
	Tue,  4 Nov 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261568; cv=none; b=uHZyOzJDJxvcfVhm5HstRPnXpeN7WM0TjO8r+pRt2I5+QZ9SwHPOyn+23QPguceg2svoPgKYIUopuRLBM/ye5HBAyuuh14RmJSvZpGCpDWZOxww9mPKu2lZ2uKEtW4LDN/sBQusGPCN0lkcxtz5Krf05KM6iL3JJ6J10OtnSrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261568; c=relaxed/simple;
	bh=uM+xb4jok103os8tzQky4xYv8R0/kY5bXK9YP0mICyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FX2XevBHOYb8MoO8Vi8HHo4P8sV0ArLlLScfiv1zkGQZlH+SqCCMpBtHu+uko+JfT44JfAsOVuQ/bXUk/MbqhSg3lToMnvn4IW3qOWj1qgKlf7YpWIM3IPsdXJlDwq1uKcvyZcRmkv+VnW0eyOgLlCcULh5rqV45vaeSuNLB5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMUpvoPW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762261566; x=1793797566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uM+xb4jok103os8tzQky4xYv8R0/kY5bXK9YP0mICyE=;
  b=EMUpvoPWOhY08qr+rsHfWr1elapeyT0uJp4kgbWwvOu72MZQGpyn6bPP
   f0QOjnyKvNdZRWRok4FG6WtrS+q5cxOMxgpw/YtyQVAEesrC+nc6YSUi3
   uM1/w1Huju3s3a9TEnoOfJe2idCoHtNVzL+ZwINf1xs5tgruFIl1RiagQ
   ZGWf/JQImLtCTVxBBFoTL7OVFV0itQlzoLESdWhniRrY35LAO0lH3/EDp
   yiVB4HRHv8J8SlZ3RF7q1yOf4HowR5vo3dTlLFsnb18eqHkppj84TDhKO
   d7iRWT14C9fxA85y1hDGk3BqYaiH6J33g6gNwRPUkVGmHyQtjoBxy+xCk
   w==;
X-CSE-ConnectionGUID: AgDeJfMtSYqHDwWQla+4cA==
X-CSE-MsgGUID: 34l2lIMWTo62zKgBJPyY4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="51925341"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="51925341"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 05:06:04 -0800
X-CSE-ConnectionGUID: 33vOWdfsTgqD0OkKZjmu2A==
X-CSE-MsgGUID: 6P7NkPMcT9a9kTAyDW6AFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187104013"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2025 05:06:01 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGGij-000RPb-2E;
	Tue, 04 Nov 2025 13:05:22 +0000
Date: Tue, 4 Nov 2025 21:02:23 +0800
From: kernel test robot <lkp@intel.com>
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, robh@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
	bjorn.andersson@oss.qualcomm.com, bod@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, saravanak@google.com,
	prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
Message-ID: <202511042005.MXfsNx3W-lkp@intel.com>
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
[also build test WARNING on linus/master v6.18-rc4 next-20251104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charan-Teja-Kalla/of-create-a-wrapper-for-of_map_id/20251104-170223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla%40oss.qualcomm.com
patch subject: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20251104/202511042005.MXfsNx3W-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511042005.MXfsNx3W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511042005.MXfsNx3W-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/of/base.c:2123 function parameter 'cells' not described in 'of_iommu_map_id_cell_count'
>> Warning: drivers/of/base.c:2240 function parameter 'np' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'id' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'map_name' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'map_mask_name' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'target' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'id_out' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'arg' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'pargs' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'fn' not described in 'of_map_id_or_funcid'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

