Return-Path: <linux-kernel+bounces-807039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F6DB49F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D045A7AA58E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E72472A2;
	Tue,  9 Sep 2025 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XP46+QMs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A9F23A9B0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384668; cv=none; b=mKCqI9Phr0zFjck5wjIh6E3ElGFPWCktKR2Bb/M3NP8Yw8fq3Nh39Xf4PaH6casTzN5fSa/FWS3IOH0JawDPnEfdu/8O2HOsJDWuUGMbsaUJ6p8DZ1IGKUR3tcKctVNBIX6LNfA5nyutBL2nXfYkc8d906/kfD6lu2F43c99haE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384668; c=relaxed/simple;
	bh=rXblcU4RJo1epq/Ugyh9sei8B9zyUqPVXquk+rYm3w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3/TPF2rMDDzsX4cXihE18/4tAvzjR0iCnwaEHM812hyrYN9gI1rFFHdRlw4lUkhmXgmpCsd2Q6ivFnnQKa4WkLuckV5u04HcoQQ3q2Sllso5COx6p5wG/fGCyJuV8xZQEnCdl/lGLFTmDyYtfqQkUpkGL7/qqoMG7lK91OKDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XP46+QMs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757384666; x=1788920666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rXblcU4RJo1epq/Ugyh9sei8B9zyUqPVXquk+rYm3w8=;
  b=XP46+QMs8c52gJdFaJT/zALpacsjH+zD5xZVTnuTtSsLUutZOe5q80RX
   KcVGFmnpSbvoDjmPMsdaDealUmjg4k677/nQQ4ZkenV+hpA1fgh0TVvrT
   1/AqJHdogyvJDTqH3H9htTJdANLbEjOGmcRLmCg4KPUd8mSYhOkk+QkJ1
   iqJGE0+wSwjAHy7OWJY3A9QK4QQnToWdAmC31thyCP0tR+7L7oQKJi3Di
   d8RrjQpdnjRi1+O9hVWdGxb9k2/LNttghayDndYJmKQQJ8QGkzxD49BQV
   4gxU/GhdN5qkFZTtvE1YhklsZk8qbljrnP8Im3ZsnvJh5VYnbuBQb8jfI
   g==;
X-CSE-ConnectionGUID: yz8WHhz0TRuJiEdB5obAiA==
X-CSE-MsgGUID: WCXiFN6UTbeDY9Vu6NMJmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77114454"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="77114454"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 19:24:25 -0700
X-CSE-ConnectionGUID: 2RIKdZ4lTKC0lKLdgcJ3sA==
X-CSE-MsgGUID: RQqgG6QqSDWXZELyXXpfVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="177302420"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Sep 2025 19:24:21 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvo1q-0004LD-3A;
	Tue, 09 Sep 2025 02:24:18 +0000
Date: Tue, 9 Sep 2025 10:23:32 +0800
From: kernel test robot <lkp@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
	nicolinc@nvidia.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, jsnitsel@redhat.com, vasant.hegde@amd.com,
	iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v4] iommu/amd: Add support for hw_info for iommu
 capability query
Message-ID: <202509090900.HNQfwn5v-lkp@intel.com>
References: <20250904193112.7418-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904193112.7418-1-suravee.suthikulpanit@amd.com>

Hi Suravee,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17-rc5 next-20250908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suravee-Suthikulpanit/iommu-amd-Add-support-for-hw_info-for-iommu-capability-query/20250905-033352
base:   linus/master
patch link:    https://lore.kernel.org/r/20250904193112.7418-1-suravee.suthikulpanit%40amd.com
patch subject: [PATCH v4] iommu/amd: Add support for hw_info for iommu capability query
config: x86_64-rhel-9.4-func (https://download.01.org/0day-ci/archive/20250909/202509090900.HNQfwn5v-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509090900.HNQfwn5v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509090900.HNQfwn5v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld: drivers/iommu/amd/iommu.o:(.rodata+0x25a8): undefined reference to `amd_iommufd_hw_info'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

