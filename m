Return-Path: <linux-kernel+bounces-849059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C2BCF1B4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF23F19A0471
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2A2356D9;
	Sat, 11 Oct 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWb1ip0w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42929A2
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760169573; cv=none; b=NY6KLDooKgz8WD/OCNP2VWqFjOoTcHJvhb9/Coo112M9SBMy/aELlX1QdVzlVahdKZ/LYOmASRYQ8GQqI6M+HZTfRLquF7Hs6jRLN9BYevoUkuhxxHhiSHHd38mdZaO24DaWG/89PMiTiZ1lEBaOTTThueTEVcx01rc85SvaSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760169573; c=relaxed/simple;
	bh=8v1LnbbHFIfqA7vJouybB86oy19ps3TIzwxEhAJtQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rz2g3JTz/DD8RaSSDG97lvx85ICuXvaNk/SovUirxT/K590svfDsxpB5xM19i/+5Z+JvkGTsgzqiw8lLbV9N0ESYh5qDCxBag6oeOa099FPqRfxrDQuZeMnxs8KdMiWiQN5bmi91adDD3ax7FK0ThA92U9MDEHifQmGD0DFNyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWb1ip0w; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760169572; x=1791705572;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8v1LnbbHFIfqA7vJouybB86oy19ps3TIzwxEhAJtQTk=;
  b=XWb1ip0woz78a0bGDmpDB0MJc4tep717FhafTNq1eCaoAugUrrYvKUwU
   Fpz0nC+vQbVaRnUsi1f4TSokkKYvyQYLHhV3c2BepDDOVw524/FjxgE1H
   /VeS3j0JkgU7QNis3+WzAwAgFXVTGhCvshZSH4PXKPYV4jiW5ZosT3fhY
   VwDvIw8ezFIbhT5vZ8BlLFA5ZZjb4fJD8Dtum78EHLe3ZIKgxpI6yMuob
   RmRzaqFvU1HWYuRP0puiMf1QdEI2vL9pc6BSrV5qk4XqKZaZ7NjP7LEXu
   Ig42lUgKIhvA3gVNnCPpmcfblqFPYj9MoTDwdg2Pml5pT0VeKxvf8/59p
   w==;
X-CSE-ConnectionGUID: wIN/080HTfSzfSYsJWi6NA==
X-CSE-MsgGUID: pttbQWbvTrO47CSzRAn4YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="66234320"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="66234320"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 00:59:32 -0700
X-CSE-ConnectionGUID: NeCWoKbJSHav64IBGy1+OQ==
X-CSE-MsgGUID: 16ccj2lkTQWTxVQBuwpw9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="186270708"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Oct 2025 00:59:30 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7UVi-0003cx-2t;
	Sat, 11 Oct 2025 07:59:26 +0000
Date: Sat, 11 Oct 2025 15:58:32 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: include/linux/stddef.h:8:14: warning: passing argument 5 of
 'drm_gpusvm_init' makes integer from pointer without a cast
Message-ID: <202510111506.HRLvzZmk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0739473694c4878513031006829f1030ec850bc2
commit: 10aa5c80603088d10c2cd5e7e27d561a8fb59c7e drm/gpusvm, drm/xe: Fix userptr to not allow device private pages
date:   8 days ago
config: x86_64-randconfig-r123-20251011 (https://download.01.org/0day-ci/archive/20251011/202510111506.HRLvzZmk-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111506.HRLvzZmk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111506.HRLvzZmk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/objtool_types.h:7,
                    from include/linux/objtool.h:5,
                    from include/linux/instrumentation.h:7,
                    from arch/x86/include/asm/bug.h:6,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from include/linux/pagemap.h:8,
                    from include/drm/ttm/ttm_tt.h:30,
                    from drivers/gpu/drm/xe/xe_bo.h:9,
                    from drivers/gpu/drm/xe/xe_bo.c:6:
   drivers/gpu/drm/xe/xe_svm.h: In function 'xe_svm_init':
>> include/linux/stddef.h:8:14: warning: passing argument 5 of 'drm_gpusvm_init' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drivers/gpu/drm/xe/xe_svm.h:217:38: note: in expansion of macro 'NULL'
     217 |                                NULL, NULL, 0, 0, 0, NULL, NULL, 0);
         |                                      ^~~~
   In file included from drivers/gpu/drm/xe/xe_bo_types.h:11,
                    from drivers/gpu/drm/xe/xe_bo.h:11:
   include/drm/drm_gpusvm.h:254:35: note: expected 'long unsigned int' but argument is of type 'void *'
     254 |                     unsigned long mm_start, unsigned long mm_range,
         |                     ~~~~~~~~~~~~~~^~~~~~~~
   include/linux/stddef.h:8:14: warning: passing argument 10 of 'drm_gpusvm_init' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drivers/gpu/drm/xe/xe_svm.h:217:59: note: in expansion of macro 'NULL'
     217 |                                NULL, NULL, 0, 0, 0, NULL, NULL, 0);
         |                                                           ^~~~
   include/drm/drm_gpusvm.h:257:59: note: expected 'int' but argument is of type 'void *'
     257 |                     const unsigned long *chunk_sizes, int num_chunks);
         |                                                       ~~~~^~~~~~~~~~
   In file included from drivers/gpu/drm/xe/xe_res_cursor.h:38,
                    from drivers/gpu/drm/xe/xe_bo.c:34:
   drivers/gpu/drm/xe/xe_svm.h:216:16: error: too many arguments to function 'drm_gpusvm_init'
     216 |         return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)", &vm->xe->drm,
         |                ^~~~~~~~~~~~~~~
   include/drm/drm_gpusvm.h:251:5: note: declared here
     251 | int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
         |     ^~~~~~~~~~~~~~~


vim +/drm_gpusvm_init +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

:::::: The code at line 8 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

