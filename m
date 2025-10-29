Return-Path: <linux-kernel+bounces-877247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F5C1D8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D894D4E3556
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A6313263;
	Wed, 29 Oct 2025 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VniMnl78"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903C2F5A32
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761775496; cv=none; b=mJAWDsGXb0Izh9XWcbp0lIwojDyune0GwzAN6YnjGdkv4KQKK9I1WqivR5jJ0Igmt08AXqa7q+I5fT7+/Ilfyf6t3wurHFkIw8k4Yjc08HJKBFls5TxgEO/uQPpI3XEMeYMZrpf3CE2goarWE8SccjBBMnz6xCrYaAMrje581nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761775496; c=relaxed/simple;
	bh=Xa2nCvLmmPqcmZLV3BGsxHcwIp2YYJNnacnCRoxYSnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EEQIJSvst29S46VSBjR0zbQZRIZx97HFcMJ2Jxk1Uo4w/e24XLdVtB50O7ohwF80kSFLo86koPEi2p3XuNndaFtwXfVWiURspk8Te/fMenL2nPab4yfyVgDJAZtsz5drCGCCfVX60gIbc8uOJfLmSylOhp7l3OVRDquWBJjWim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VniMnl78; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761775495; x=1793311495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xa2nCvLmmPqcmZLV3BGsxHcwIp2YYJNnacnCRoxYSnI=;
  b=VniMnl78qgO+rcYx87pheorhIZaUpqwjiFidFLfDPRaBaevz8d7dVqqt
   MdOar8vqDJ6GHPp5IhHQRfGDjUeXysSwBFq/jn+ptMrOR0g4ZPtKMw8HV
   WQvAHOf5Gk36Viqku+s7F4KWByrrFxQkP2KIEZk8tVPlBpNkw7iTMeag5
   30cm49pgAi1lfps1Lt4/NWRI6hcgASRq+fTM1xw6Rxvms10GK1aNiqL7P
   278iwu0IYGq3cDRLaA+/rl/6nLjwExWM9dQ+TSXiUzVrzhwhFMdCAXc48
   ZL5/AWwu/p5d055z2QXtMXA/GV43fOS5viVfimuh1anJlJSaypI6pEdob
   A==;
X-CSE-ConnectionGUID: XGCaxoqqRpygna36fzoXQA==
X-CSE-MsgGUID: EFvjIJ+IRxmPodvYNvLrIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63840576"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63840576"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:04:54 -0700
X-CSE-ConnectionGUID: M0wkzMSYTTqXyzbCKB344w==
X-CSE-MsgGUID: DFr0l+b7TH2rhJMhMGeg4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="186525001"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 29 Oct 2025 15:04:52 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEEHi-000LDe-0N;
	Wed, 29 Oct 2025 22:04:50 +0000
Date: Thu, 30 Oct 2025 06:04:25 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: drivers/gpu/drm/xe/xe_svm.h:217:44: error: too many arguments to
 function call, expected 10, have 11
Message-ID: <202510300519.RG1ckAUY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
commit: 10aa5c80603088d10c2cd5e7e27d561a8fb59c7e drm/gpusvm, drm/xe: Fix userptr to not allow device private pages
date:   4 weeks ago
config: x86_64-randconfig-076-20251030 (https://download.01.org/0day-ci/archive/20251030/202510300519.RG1ckAUY-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510300519.RG1ckAUY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510300519.RG1ckAUY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/xe/xe_gt_pagefault.c:22:
>> drivers/gpu/drm/xe/xe_svm.h:217:44: error: too many arguments to function call, expected 10, have 11
     216 |         return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)", &vm->xe->drm,
         |                ~~~~~~~~~~~~~~~
     217 |                                NULL, NULL, 0, 0, 0, NULL, NULL, 0);
         |                                                                 ^
   include/drm/drm_gpusvm.h:251:5: note: 'drm_gpusvm_init' declared here
     251 | int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
         |     ^               ~~~~~~~~~~~~~~~~~~~~~~~~~~
     252 |                     const char *name, struct drm_device *drm,
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     253 |                     struct mm_struct *mm,
         |                     ~~~~~~~~~~~~~~~~~~~~~
     254 |                     unsigned long mm_start, unsigned long mm_range,
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     255 |                     unsigned long notifier_size,
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     256 |                     const struct drm_gpusvm_ops *ops,
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     257 |                     const unsigned long *chunk_sizes, int num_chunks);
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +217 drivers/gpu/drm/xe/xe_svm.h

0c30c65473ff37 Matthew Brost 2025-03-05  211  
6fd979c2f33150 Matthew Brost 2025-03-05  212  static inline
6fd979c2f33150 Matthew Brost 2025-03-05  213  int xe_svm_init(struct xe_vm *vm)
6fd979c2f33150 Matthew Brost 2025-03-05  214  {
9e978741488261 Matthew Auld  2025-08-28  215  #if IS_ENABLED(CONFIG_DRM_GPUSVM)
9e978741488261 Matthew Auld  2025-08-28  216  	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)", &vm->xe->drm,
9e978741488261 Matthew Auld  2025-08-28 @217  			       NULL, NULL, 0, 0, 0, NULL, NULL, 0);
9e978741488261 Matthew Auld  2025-08-28  218  #else
6fd979c2f33150 Matthew Brost 2025-03-05  219  	return 0;
9e978741488261 Matthew Auld  2025-08-28  220  #endif
6fd979c2f33150 Matthew Brost 2025-03-05  221  }
6fd979c2f33150 Matthew Brost 2025-03-05  222  

:::::: The code at line 217 was first introduced by commit
:::::: 9e978741488261e117bb50e5dfcf8e4080990958 drm/xe/userptr: replace xe_hmm with gpusvm

:::::: TO: Matthew Auld <matthew.auld@intel.com>
:::::: CC: Matthew Auld <matthew.auld@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

